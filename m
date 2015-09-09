From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 9 Sep 2015 07:24:42 +0200 (CEST)
Subject: [Cocci] coccinelle problems with kernel code
In-Reply-To: <20150908214536.GC27133@Sligo.logfs.org>
References: <20150908180759.GA27133@Sligo.logfs.org>
 <alpine.DEB.2.02.1509082316550.2050@localhost6.localdomain6>
 <20150908214536.GC27133@Sligo.logfs.org>
Message-ID: <alpine.DEB.2.02.1509090717080.2047@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 8 Sep 2015, J?rn Engel wrote:

> On Tue, Sep 08, 2015 at 11:17:58PM +0200, Julia Lawall wrote:
> > On Tue, 8 Sep 2015, J?rn Engel wrote:
> > 
> > > Tried to use coccinelle on the linux kernel for the first time.  It
> > > seems to get things mostly right, but not quite.  Here is the semantic
> > > patch:
> > > 
> > > @@ expression E; @@
> > > -down_read(&E->mmap_sem)
> > > +mm_read_lock(E)
> > > @@ expression E; @@
> > > -down_read_trylock(&E->mmap_sem)
> > > +mm_read_trylock(E)
> > > @@ expression E; @@
> > > -up_read(&E->mmap_sem)
> > > +mm_read_unlock(E)
> > > @@ expression E; @@
> > > -down_write(&E->mmap_sem)
> > > +mm_write_lock(E)
> > > @@ expression E; @@
> > > -down_write_trylock(&E->mmap_sem)
> > > +mm_write_trylock(E)
> > > @@ expression E; @@
> > > -up_write(&E->mmap_sem)
> > > +mm_write_unlock(E)
> > 
> > So this all went OK?
> 
> Mostly.  There are still a few troublemakers remaining.  But few enough
> that I don't mind handling them manually.
> 
> Automatic changes:
>  140 files changed, 581 insertions(+), 581 deletions(-)
> 
> Troublemakers:
> arch/mips/mm/fault.c (5 lines)
> arch/um/include/asm/mmu_context.h (2 lines)
> include/linux/huge_mm.h (1 line)
> 
> Commandline:
> spatch --sp-file mmap_sem.cocci --dir . --macro-file coccinelle.h
> 
> If I explicitly pass the two headerfiles as parameters, they get handled
> as well.  Maybe a bug in the recursive directory walk?

By default, Coccinelle only considers a limited number of header files.  
First it collects the C files.  Then it includes also the header files 
that have the same name as a C files.

Including header files with C files is only useful for acquiring type 
information.  You don't care about that for your rules, so you would be 
better off with --no-includes.  On the oter hand if your patterns occur in 
header files you want them to be processed.  For that, add the command 
line --include-headers.

The point is that including header files can drastically increase the code 
size, and header files can be difficult to parse, due to 
#ifdefs etc, so overall including more than necessary can increase the 
running time a lot.

> arch/mips/mm/fault.c seems to have a problem with one of the
> conditionals.  I could reduce things to the following testcase:
> 
> void foo(unsigned long address)
> {
> 	down_read(&mm->mmap_sem);
> 	vma = find_vma(current->mm, address);
> 	if (!vma)
> 		goto bad_area;
> 	if (vma->vm_start <= address)
> 		goto good_area;
> 	if (!(vma->vm_flags & VM_GROWSDOWN))
> 		goto bad_area;
> 	if (expand_stack(vma, address))
> 		goto bad_area;
> bad_area:
> 	up_read(&mm->mmap_sem);
> }
> 
> Remove the "!(vma->vm_flags & VM_GROWSDOWN)" condition and it works.
> Leave the condition and spatch fails silently.

There is probably a parsing problem.  By default Coccinelle doesn't report 
these, because there are likely many of them, and most of them are likely 
not relevant to the code you want to process.  You can see the parsing 
problems by running spatch --parse-c file.c.  There may be quite a lot of 
output.  At the end you will see a summary of how successful the parsing 
was.  If it was somewhat not successful, you can look up fpr the line 
beginning with BAD to see where the problem is.  The lines beginning with 
bad show the lines that were skipped due to the problem.

> > > I run into problems whenever handling system calls.  Looks like the
> > > SYSCALL_DEFINE5() macro and friends are causing problems.  Here is my
> > > attempt to handle things.
> > > 
> > > #define SYSCALL_DEFINE1(func, t1, a1) \
> > > 	asmlinkage unsigned long func(t1 a1)
> > > #define SYSCALL_DEFINE2(func, t1, a1, t2, a2) \
> > > 	asmlinkage unsigned long func(t1 a1, t2 a2)
> > > #define SYSCALL_DEFINE3(func, t1, a1, t2, a2, t3, a3) \
> > > 	asmlinkage unsigned long func(t1 a1, t2 a2, t3 a3)
> > > #define SYSCALL_DEFINE4(func, t1, a1, t2, a2, t3, a3, t4, a4) \
> > > 	asmlinkage unsigned long func(t1 a1, t2 a2, t3 a3, t4 a4)
> > > #define SYSCALL_DEFINE5(func, t1, a1, t2, a2, t3, a3, t4, a4, t5, a5) \
> > > 	asmlinkage unsigned long func(t1 a1, t2 a2, t3 a3, t4 a4, t5 a5)
> > > #define SYSCALL_DEFINE6(func, t1, a1, t2, a2, t3, a3, t4, a4, t5, a5, t6, a6) \
> > > 	asmlinkage unsigned long func(t1 a1, t2 a2, t3 a3, t4 a4, t5 a5, t6 a6)
> > > 
> > > Should that be included into standard.h?
> > 
> > If it works, I could certainly add it.
> 
> It works.
> 
> And tracking down failures in coccinelle is definitely more fun than
> making 581 manual changes without messing things up.  Thank you!

:)

julia

> J?rn
> 
> --
> Homo Sapiens is a goal, not a description.
> -- unknown
> 
