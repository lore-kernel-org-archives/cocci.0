From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 22 Feb 2014 13:36:40 +0100 (CET)
Subject: [Cocci] Remove unnecessary null pointer checks?
In-Reply-To: <53085B37.6030005@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <53085B37.6030005@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1402221333040.2017@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, 22 Feb 2014, SF Markus Elfring wrote:

> > Not sure what you mean by extended.
> 
> I have tried the following search pattern.
> 
> @Show_functions_with_input_pointer_validation@
> identifier fun, x;
> type t;
> @@
> *fun(..., t* x, ...)
>  {
>   ...
>   if (!x) return;
>   ...
>  }
> 
> 
> Will your current tool version "1.0.0-rc20" find also the kfree() functions?
> https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/tree/mm/slab.c#n3641
> 
> Should I add any variant of "unlikely(ZERO_OR_NULL_PTR(...))" to my filter
> pattern eventually?

If you want to match a call to ZERO_OR_NULL_PTR, then you need to include 
that in the semantic patch.  Coccinelle does not expand macros, so if 
doesn't see the relation to a NULL test.

> > If you want to propose Linux related fixes, you may want to look at the 
> > kernel janitors mailing list.
> 
> Would it make sense to add the shown semantic patches to a specific script
> directory?
> https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/tree/scripts/coccinelle

Not sure to understand what the "shown semantic patches" refers to.  What 
you have proposed is a semntic patch that finds functions that test their 
argument for NULL and return if the test is satisfied.  That gives the 
user some information, but the rules in the Linux kernel are for finding 
bugs or making transformations.

Personally, I rather like null tests, if they are really needed, ie not 
implied to be always false by the context, because they give some 
information, eg that the value can be null at this point, and it is 
important to take that into account when considerin the following 
operation.  So I'm not very eager to go around removing them.

julia
