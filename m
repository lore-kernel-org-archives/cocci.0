From: jglisse@redhat.com (Jerome Glisse)
Date: Thu, 17 May 2018 17:32:59 -0400
Subject: [Cocci] exists do not work if file group is too big
In-Reply-To: <alpine.DEB.2.20.1805172304150.2273@hadrien>
References: <20180516191634.GB2994@redhat.com>
 <128b6146-5368-12bb-ae42-236982ff3494@users.sourceforge.net>
 <20180517144527.GA5048@redhat.com>
 <alpine.DEB.2.20.1805172241400.2273@hadrien>
 <20180517210001.GB15887@redhat.com>
 <alpine.DEB.2.20.1805172304150.2273@hadrien>
Message-ID: <20180517213258.GD15887@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, May 17, 2018 at 11:11:12PM +0200, Julia Lawall wrote:
> 
> 
> On Thu, 17 May 2018, Jerome Glisse wrote:
> 
> > On Thu, May 17, 2018 at 10:45:29PM +0200, Julia Lawall wrote:
> > > In terms of the running time, I get a running time of 11 seconds with the
> > > command line of 48 files and I get a running time of 22 seconds if I just
> > > run spatch on the entire kernel.  That seems slower, but if I use the
> > > command line of 48 files, I get changes in 27 files, while if I run it on
> > > the entire kernel, I get changes in 75 files.  If I run it on the entire
> > > kernel using 40 cores (-j 40), I get changes in 75 files in 1.7 seconds.
> >
> > In this simple test case this would work but in my real spatch i have to
> > change one function at a time as otherwise there is conflict on header
> > update. Moreover i also have to use --recursive-headers if i don't do the
> > git grep to provide file list which is also one of the reasons why it
> > was much slower.
> >
> > Ideally if header files could be updated --in-place even when there is
> > conflict i might first add proper #include as a first step to avoid the
> > recursive flag.
> 
> I'm not sure to understand any of the above.  At the moment you have
> --no-includes, so no headers are consulted.  What do you need from header
> files?  Do you need type information?  Do you need to change the files?
> Do the changes in the header files interact with the changes in the .c
> file?
> 
> If it just happens that there are also calls to set_page_dirty in the
> header files that you want to update, then you can give the options
> --no-includes --include-headers.
> 
> If the only thing you want from the header files is type information, then
> you can say eg --recursive-includes --include-headers-for-types.  That
> would be much faster, because the transformation rules wouldn't be applied
> over and over to the header files.
> 
> If you want to do both, the above options can be combined.

I need to update function prototype and one semantic patch might update
multiples function and those function might have function prototype in
same header files just couple lines of each others in which case this does
not work. This is an issue mostly when updating callback for which i do
not know the function name at time of writing the semantic patch.

The recursive is needed because in many intance the function prototype is
define in a header file that is not directly included by the c file but is
included through another include or a complex include chains.


> >
> >
> > As an example if i want to add a new argument to both:
> >
> > int set_page_dirty(struct page *page);
> > int set_page_dirty_lock(struct page *page);
> >
> > then because inside include/linux/mm.h they are declare one after the
> > other --in-place will fails. This case is not the worse, i can split
> > this in 2 spatches and it would work. I can't do that when updating
> > callback which have same pattern ie 2 callback prototype declare one
> > after the other.
> 
> Do you actually need to automate this part?
> 
> I think I could be more helpful if I had an example that more competely
> shows what you want to do.


Below is an actual example, i run it with:

spatch  --dir . --include-headers -D grep --sp-file spatch

cat /tmp/unicorn-functions | while read line ; do git grep -l \
$line -- '*.[ch]' | sed -e "s/\(.\+\)\.h/--include \1.h/g" \
> /tmp/unicorn-group ; echo "--include include/linux/fs.h" \
>> /tmp/unicorn-group ; echo "--include include/linux/mm.h" \
>> /tmp/unicorn-group ; cat /tmp/unicorn-group | tr '\n' ' ' ; \
echo ; done > /tmp/unicorn-groups

cat /tmp/unicorn-groups | while read line ; do spatch --in-place \
--no-includes --sp-file spatch $line ; done


spatch:

// First part of this file is only executed when -D grep argument is
// provided to spatch. It use to grep all function name that needs to
// be modified. Collected function name are written into a temporary
// file (/tmp/unicorn-functions) and git grep is use to find all the
// files that will be modified using second part of this semantic
// patch
virtual grep

// initialize file where we collect all function name (erase it)
@initialize:python depends on grep@
@@
file=open('/tmp/unicorn-functions', 'w')
file.close()

// match function name use as a callback
@G1 depends on grep@
identifier I1, FN;
@@
struct address_space_operations I1 = {..., .set_page_dirty = FN, ...};

@script:python depends on G1@
funcname << G1.FN;
@@
if funcname != "NULL":
  file=open('/tmp/unicorn-functions', 'a')
  file.write(funcname + '\n')
  file.close()

// Also collect all function name that use a_ops->set_page_dirty()
@G2 depends on grep exists@
expression E1, E2;
identifier FN;
type T1;
@@
T1 FN(...) { ...
(
E1.a_ops->set_page_dirty(E2)
|
E1->a_ops->set_page_dirty(E2)
)
... }

@script:python depends on G2@
funcname << G2.FN;
@@
file=open('/tmp/unicorn-functions', 'a')
file.write(funcname + '\n')
print(funcname)
file.close()


// -------------------------------------------------------------------

// Below is the actual modification. We use the fn argument (provided
// by passing -D fn=value to spatch). To identify which function is
// being modified in this run. Semantic patch is run once per function
// because of conflict when updating multiple functions in one run.

// Update the address_space_operations structure (should happens only
// once with the first group of files)
@depends on !grep@
@@
struct address_space_operations { ... int (*set_page_dirty)(
+struct address_space *,
struct page *page); ... };

// Update caller of address_space_operation.set_page_dirty (pass NULL)
@depends on !grep@
expression E1, E2;
@@
E1.a_ops->set_page_dirty(
+MAPPING_NULL,
E2)

@depends on !grep@
expression E1, E2;
@@
E1->a_ops->set_page_dirty(
+MAPPING_NULL,
E2)

// Find function name use for the set_page_dirty callback (does not change
// anything, this just find the name)
@R1 depends on !grep exists@
identifier I1, virtual.fn;
@@
struct address_space_operations I1 = {..., .set_page_dirty = fn ,...};

// Add address_space argument to the function (set_page_dirty callback one)
@depends on R1@
type T1;
identifier I1;
identifier virtual.fn;
@@
int fn(
+struct address_space *__mapping,
T1 I1) { ... }

// Modify every place the function (use for set_page_dirty callback) is call
// to pass NULL as for the new address_space argument.
@depends on R1@
identifier virtual.fn;
expression E1;
@@
fn(
+MAPPING_NULL,
E1)

// Modify local variable use to store pointer to callback
@R2 depends on !grep exists@
expression E1;
identifier I1;
@@
int (*I1)(
+struct address_space *,
struct page *) = E1->a_ops->set_page_dirty;

@depends on R2 exists@
expression E1;
identifier R2.I1;
@@
-(*I1)(E1)
+I1(MAPPING_NULL, E1)
