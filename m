From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 7 May 2018 22:44:21 +0200 (CEST)
Subject: [Cocci] Multiple match versus single header result in conflicts
In-Reply-To: <20180507201602.GB13419@redhat.com>
References: <20180504193010.GA25201@redhat.com>
 <alpine.DEB.2.20.1805050718570.2528@hadrien>
 <20180507152530.GA13419@redhat.com>
 <alpine.DEB.2.20.1805072156420.2308@hadrien>
 <20180507201602.GB13419@redhat.com>
Message-ID: <alpine.DEB.2.20.1805072237390.2308@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 7 May 2018, Jerome Glisse wrote:

> On Mon, May 07, 2018 at 09:57:43PM +0200, Julia Lawall wrote:
> >
> >
> > On Mon, 7 May 2018, Jerome Glisse wrote:
> >
> > > On Sat, May 05, 2018 at 07:20:04AM +0200, Julia Lawall wrote:
> > > >
> > > >
> > > > On Fri, 4 May 2018, Jerome Glisse wrote:
> > > >
> > > > > Following semantics does not update function prototype in header file:
> > > > >
> > > > > @S@
> > > > > identifier I1, I2;
> > > > > @@
> > > > > struct myop I1 = { ..., .add = I2 , ... };
> > > > >
> > > > > @U depends on S@
> > > > > identifier S.I2;
> > > > > identifier A1, A2;
> > > > > type T1, T2;
> > > > > @@
> > > > > int I2(T1 A1,
> > > > > +int c,
> > > > > T2 A2) { ... }
> > > > >
> > > > > run with spatch --in-place --sp-file test.spatch --dir . --all-includes
> > > > > (tested various includes/headers combinations) on 3 files f1.h f1.c
> > > > > f2.c (if f1.c and f2.c are merge together then thing works).
> > > > >
> > > > > f1.h: ----------------------------------------------------------------
> > > > > struct myop {
> > > > >     int (*add)(int, int);
> > > > > };
> > > > >
> > > > > int myadd(int, int);
> > > > > ----------------------------------------------------------------------
> > > > >
> > > > > f1.c: ----------------------------------------------------------------
> > > > > #include "f1.h"
> > > > >
> > > > > int myadd(int a, int b)
> > > > > {
> > > > >     return a + b;
> > > > > }
> > > > >
> > > > > struct myop myop = {
> > > > >     .add = myadd,
> > > > > };
> > > > > ----------------------------------------------------------------------
> > > > >
> > > > > f2.c: ----------------------------------------------------------------
> > > > > #include "f1.h"
> > > > >
> > > > > int myadd2(int a, int b)
> > > > > {
> > > > >     return a + b;
> > > > > }
> > > > >
> > > > > struct myop myop2 = {
> > > > >     .add = myadd2,
> > > > > };
> > > > > ----------------------------------------------------------------------
> > > > >
> > > > > If f1.c and f2.c are just one file than the header files is properly
> > > > > updated. The error message is:
> > > > >
> > > > > different modification result for ./f1.h
> > > > >
> > > > > I am not sure if there is a way to make the semantic patch work against
> > > > > such scenario. So is this expected ? Is my semantic patch wrong ? Or
> > > > > is it a bug in coccinelle ?
> > > >
> > > > I believe that Coccinelle just doesn't make the effort to realize that the
> > > > modifications are the same.  Probably things will be fine if you don't use
> > > > --in-place.
> > > >
> > >
> > > Yes it does work thank you for quick answer. By the way my next hurdle
> > > is trying to match function prototype no matter if argument has a name
> > > or not ie matching all:
> > >
> > > void toto(int,int);
> > > void toto(int a, int);
> > > void toto(int, int b);
> > > void toto(int a, int b);
> > >
> > > This tie back to my original issue, when a function callback is use
> > > in myop struct in one file and prototype is in header file, i want to
> > > update prototype so that latter when coccinelle process the different
> > > file in which the function is defined i can use the modified header
> > > file to also update the function definition.
> >
> > This should work already.  When you change the function definition, if it
> > has access to the prototype it should change it as well.  If this is not
> > working, please send an example.
>
> Roughly same as above:
>
> f1.h: ----------------------------------------------------------------
> struct myop {
>     int (*add)(int, int);
> };
>
> int myadd(int, int);
> ----------------------------------------------------------------------
>
> f1.c: ----------------------------------------------------------------
> #include "f1.h"
>
> struct myop myop = {
>     .add = myadd,
> };
> ----------------------------------------------------------------------
>
> f2.c: ----------------------------------------------------------------
> #include "f1.h"
>
> int myadd(int a, int b)
> {
>     return a + b;
> }
> ----------------------------------------------------------------------
>
> Semantic: ------------------------------------------------------------
> @S@
> identifier I1, I2;
> @@
> struct myop I1 = { ..., .add = I2 , ... };
>
> @depends on S@
> identifier S.I2;
> identifier A1, A2;
> type T1, T2;
> @@
> int I2(T1 A1,
> +int c,
> T2 A2) { ... }
> ----------------------------------------------------------------------
>
> So because the function is declared in a different files this does not
> work unless i group process all files. Sadly as i am working on the
> linux kernel for the real case i am interested in i can not create
> file group easily (a group would be hundreds of different files scatter
> around different directories and with no easy way to find them).
>
> So:
> WORKS: spatch --in-place --sp-file t.spatch --all-includes *.c
> NOOP:  spatch --in-place --sp-file t.spatch --all-includes f1.c
> NOOP:  spatch --in-place --sp-file t.spatch --all-includes f2.c
>
> Other solution might be to first use spatch to find all myops.add
> function and then from collected function name find all the c files
> which define them.
>
> Hence why i wanted to update all header file in first pass (matching
> on myop.add and function prototype) and then match function prototype
> that with function declaration that are missing a parameter. This
> seems like the easiest path.

I made the following semantic patch:

@S@
identifier I1, I2;
@@
struct myop I1 = { ..., .add = I2 , ... };

@depends on S@
identifier S.I2;
identifier A1, A2;
type T1, T2;
@@
int I2(T1 A1,
+int c,
T2 A2);

@depends on S@
identifier S.I2;
type T1, T2;
@@
int I2(T1,
+int,
T2);

and then applied it to your f1.c.  It does the right thing.  Hopefully
people would either always use variable names or never use variable names;
otherwise, you would have to make rules for all the permutations.

You can also use iteration to first find the function names and then find
their definitions.  There is an example in iteration.cocci and a
discussion in the Advanced SmPL talk:

http://coccinelle.lip6.fr/papers/cocciwk4_talk2.pdf

Yet another option would be to figure out how to collect the .c files into
groups.  For example, including the same local header file might be
indicative of a group.  Then there is a --file-groups output.  This option
takes as argument the name of a file with the file group information.
Consecutive lines with files names are considered to be a group, eg

a.c
b.c
c.c

x.c
y.c

z.c

julia
