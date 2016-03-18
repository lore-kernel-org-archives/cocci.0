From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 18 Mar 2016 07:10:43 +0100 (CET)
Subject: [Cocci] Remove remove unnecessary parentheses.
In-Reply-To: <BB81FEEF-74ED-49CB-BE29-AEB0DBDBB3A2@pfsw.com>
References: <A448EE81-8601-4EEA-BBA3-1EED4927F338@pfsw.com>
 <alpine.DEB.2.02.1603121018580.2055@localhost6.localdomain6>
 <BB81FEEF-74ED-49CB-BE29-AEB0DBDBB3A2@pfsw.com>
Message-ID: <alpine.DEB.2.02.1603180705370.2041@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 18 Mar 2016, Daniel Lundqvist wrote:

> Julia,
> 
> 
> 
> On 3/12/16, 17:22, "Julia Lawall" <julia.lawall@lip6.fr> wrote:
> 
> >
> >On Fri, 11 Mar 2016, Daniel Lundqvist wrote:
> >
> >> Hi,
> >> 
> >> I just got started with Coccinelle and tried to write a few simple transformations for our code base. The first one works fine:
> >> 
> >> @@
> >> expression E;
> >> constant C;
> >> @@
> >> 
> >> - BIT_TEST(E, C)
> >> + (E & C)
> >> 
> >> 
> >> This may introduce a pair of parentheses where it is not necessary, depending on where the macro is used, example:
> >> 
> >> assert(BIT_TEST(flags, VERBOSE));
> >> 
> >> Would be:
> >> 
> >> assert((flags & VERBOSE));
> >> 
> >> I then tried the perhaps obvious transformation:
> >> 
> >> @disable paren@
> >> expression E;
> >> @@
> >> 
> >> -((E))
> >> +(E)
> >> 
> >> But that does not work, obvious to some perhaps. How can I write what I want? Any pointers to allow me better understand why it does not work?
> >
> >What do you mean by "not work"?  Does it crash, or does it give an 
> >incorrect result?  Overall, it would be helpful to have a small piece of C 
> >code that shows the problem.
> 
> Sorry, should have been more clear. The extra pair of parentheses is not removed.
> 
> The example above can be used:
> 
> assert((flags & VERBOSE));
> 
> is not transformed to:
> 
> assert(flags & VERBOSE);
> 
> 
> >Perhaps it could be helpful to change the rule to
> >
> >- (
> >  (E)
> >- )
> >
> >that is, not to remove the code (E) and then add it back.
> 
> I tried that, no difference.

OK, you don't actually have double parentheses.  You have parentheses, and 
then you have the outer parentheses associated with the function call.  
But those outer ones wouldn't be matched by ((E)).  The disable parent was 
to prevent the above rule from also matching eg (2), but it seems that 
that is actually what you want.

Overall, I think what you want is:

f(
  ...,
- (
  E
- )
 ,...)

That is to remove outer parentheses in an argument list.  Perhaps you want 
rules for some other contexts too.

Sorry about the extra space.  I can take a look, but I may not be able o 
fix that immediately.

julia

> >A problem could arise from the fact that an expression of the form (E)
> >also matches an expression of the form E, because it is an expression too.  
> >But it would help to have an example to check on this.
> 
> 
> I use the following files:
> 
> bit_test.cocci:
> @@
> expression E;
> constant C;
> @@
> 
> - BIT_TEST(E, C)
> + (E & C)
> 
> parens.cocci:
> @disable paren@
> expression E;
> @@
> 
> - (
>   (E)
> - )
> 
> test.c:
> assert(BIT_TEST(flags, VERBOSE));
> 
> Outputs:
> 
> 
> 
> $ spatch --sp-file bit_test.cocci --in-place test.c
> init_defs_builtins: /usr/share/coccinelle/standard.h
> HANDLING: test.c
> diff = 
> --- test.c
> +++ /tmp/cocci-output-7653-0eb7cd-test.c
> @@ -1 +1 @@
> -assert(BIT_TEST(flags, VERBOSE));
> +assert((flags & VERBOSE));
> 
> $ spatch --sp-file parens.cocci --in-place test.c
> init_defs_builtins: /usr/share/coccinelle/standard.h
> HANDLING: test.c
> 
> 
> 
> I just noticed that if I remove the "disable paren" (not sure why it was there from the start) from parens.cocci it works:
> 
> $ spatch --sp-file parens.cocci --in-place test.c
> init_defs_builtins: /usr/share/coccinelle/standard.h
> HANDLING: test.c
> diff = 
> --- test.c
> +++ /tmp/cocci-output-7860-490fa0-test.c
> @@ -1 +1 @@
> -assert((flags & VERBOSE));
> +assert( flags & VERBOSE);
> 
> 
> But that leaves a space before E. How can that removed?
> 
> How does disabling parens isomorphisms affect this? Would like to 
> unstained how it affects this simple rule.
> 
> -- 
> daniel
> 
