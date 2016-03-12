From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 12 Mar 2016 10:22:14 +0100 (CET)
Subject: [Cocci] Remove remove unnecessary parentheses.
In-Reply-To: <A448EE81-8601-4EEA-BBA3-1EED4927F338@pfsw.com>
References: <A448EE81-8601-4EEA-BBA3-1EED4927F338@pfsw.com>
Message-ID: <alpine.DEB.2.02.1603121018580.2055@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 11 Mar 2016, Daniel Lundqvist wrote:

> Hi,
> 
> I just got started with Coccinelle and tried to write a few simple transformations for our code base. The first one works fine:
> 
> @@
> expression E;
> constant C;
> @@
> 
> - BIT_TEST(E, C)
> + (E & C)
> 
> 
> This may introduce a pair of parentheses where it is not necessary, depending on where the macro is used, example:
> 
> assert(BIT_TEST(flags, VERBOSE));
> 
> Would be:
> 
> assert((flags & VERBOSE));
> 
> I then tried the perhaps obvious transformation:
> 
> @disable paren@
> expression E;
> @@
> 
> -((E))
> +(E)
> 
> But that does not work, obvious to some perhaps. How can I write what I want? Any pointers to allow me better understand why it does not work?

What do you mean by "not work"?  Does it crash, or does it give an 
incorrect result?  Overall, it would be helpful to have a small piece of C 
code that shows the problem.

Perhaps it could be helpful to change the rule to

- (
  (E)
- )

that is, not to remove the code (E) and then add it back.

A problem could arise from the fact that an expression of the form (E) 
also matches an expression of the form E, because it is an expression too.  
But it would help to have an example to check on this.

julia
