From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 7 Mar 2017 17:25:13 +0100 (CET)
Subject: [Cocci] Problems: Adding Include directives,
 Adding ({}) construct
In-Reply-To: <1767658.UB9L1PBLAS@detux>
References: <2728810.xJvpTgCk22@detux>
 <alpine.DEB.2.20.1703020816190.2094@hadrien> <1767658.UB9L1PBLAS@detux>
Message-ID: <alpine.DEB.2.20.1703071724300.3150@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 7 Mar 2017, sebald.ziegler.cocci at ikolus.de wrote:

> On Thursday, March 2, 2017 8:21:40 AM CET Julia Lawall wrote:
> > On Mon, 27 Feb 2017, sebald.ziegler.cocci at ikolus.de wrote:
> > > Hi,
> > >
> > > I am trying to use coccinelle to add an include directive before the other
> > > includes and one after the includes:
> > >
> > > @PreInclude@
> > > @@
> > > + #include "pre.h"
> > > #include ...
> > >
> > >
> > > @PostInclude@
> > > @@
> > > #include ...
> > > + #include "post.h"
> > >
> > > this works well if the source file (all includes are always at the top of
> > > the file) contains more than one include directive. However, if there is
> > > only one include directive -> only the PreInclude rule is executed.
> >
> > Sorry not to have responded sooner.
> >
> > This seems quite strange.  Each rule sees the result of the previous one,
> > so by the time it reaches the post include rule, there would be two
> > includes in the program.  I will check on it.
> >
> > > So for this program:
> > > #include <stdio.h>
> > >
> > > int main() {
> > >
> > >     return 0;
> > >
> > > }
> > >
> > > This is the result:
> > > #include "pre.h"
> > > #include <stdio.h>
> > >
> > > int main() {
> > >
> > >     return 0;
> > >
> > > }
> > >
> > > So it seems that only one rule can match some code line/code pattern. Am I
> > > mistaken?
> >
> > This is not correct.  Coccinelle works on the first rule, then provides
> > the resulting code to the second rule, and so on.
> >
> > > What could be an approach that works for both the single include
> > > directive and multiple include directives case?
> > >
> > >
> > > Another Question:
> > > With the following rule I want to add a macro definition just above the
> > > main function:
> > > @macro_square@
> > > @@
> > > + #define SQUARE(x) ({printf("SQUARE(x)\n"); x*x; })
> > > int main(int argc, char ** argv) {
> > > ...
> > > }
> > >
> > > If I execute spatch on the program above this error is reported
> > > (coccinelle
> > > version: 1.0.6):
> > >
> > > plus: parse error:
> > >   File "/tmp/testing/test.c-brackets.cocci", line 3, column 21, charpos =
> > >   39
> > >   around = '{',
> > >   whole content = + #define SQUARE(x) ({printf("SQUARE(x)\n"); x*x; })
> > >
> > > Is this kind of code not supported or did I make a mistake somewhere?
> >
> > It is quite possible that ({ }) is not supported in the pattern matching
> > language.  There is a hackish solution:
> >
> > @script:python r@
> > str;
> > @@
> >
> > coccinelle.str = "({printf("SQUARE(x)\n"); x*x; })"
> >
> > @macro_square@
> > idntifier r.str;
> > @@
> > + #define SQUARE(x) str
> > int main(int argc, char ** argv) {
> > ...
> > }
> >
> > Coccinelle won't actually check that what you have put into the variable
> > str is an identifier.
> >
> > julia
>
> Thank you very much for your answer!
> I used the workaround you described and can now generate those macros without
> errors. However, there is a weird thing happening: Before every second " a
> line break is added:
>
> When I use this coccinelle script:
> @script:python macros@
> SQUARE_str;
> @@
> coccinelle.SQUARE_str = '({printf("SQUARE\n"); printf("SQUARE\n"); x*x; })'
>
> @macro_wrapper_int_SQUARE_int@
> identifier macros.SQUARE_str;
> @@
> +#define SQUARE(x) SQUARE_str
> int main(int argc, char ** argv) {
> ...
> }
>
> Then this is generated as diff:
> [...]
> +#define SQUARE(x) ({printf("SQUARE
> +"); printf("SQUARE
> +"); x*x; })
> [...]
>
> Is there a simple solution for this?

Try \\n instead of \n.

julia
