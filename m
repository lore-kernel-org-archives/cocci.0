From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 16 Dec 2016 12:44:46 +0100 (CET)
Subject: [Cocci] malloc/calloc/strup adding missing NULL checks
In-Reply-To: <20161216113410.4vauxw4u2f364l7v@fbsd-laptop>
References: <20161216113410.4vauxw4u2f364l7v@fbsd-laptop>
Message-ID: <alpine.DEB.2.10.1612161242300.3566@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 16 Dec 2016, Thomas Adam wrote:

> Hi,
>
> This is probably a classic example, but I'm struggling and was hoping the
> wisdom of the fine folks here could help.
>
> I'm trying to add any missing NULL checks to a few function calls, namely:
>
> 	malloc
> 	calloc
> 	strdup
>
> At present, I have the following rule:
>
> 	@@
> 	expression T;
> 	@@
>
> 	T = strdup(...);
> 	+ if (T == NULL)
> 	+ 	pkg_emit_errno("strdup", __func__);
> 	... when != (T == NULL)
> 	    when != (T != NULL)
>
>
> This is the same for calloc() and malloc().  And it works OK.  The problem I
> have is that it's not capturing all the cases.  So for example, the following
> is matched:
>
> 	char *foo;
> 	char *bar = "hello";
> 	foo = strdup(foo);
>
> But if I have something more complicated, such as this:
>
> 	struct *foo;
> 	foo->member = strdup("hello");
>
> Then the Cocci rule I have doesn't match -- and I can only assume at this
> point that struct members aren't covered by using an "expression"
> metavariable?

This is strange.  Because struct members are quite definitely covered by
the expression metavariable.  Perhaps the function that contains this code
incurs a parse error?  One way to see this is to say spatch --type-c
file.c.  If you don't see any type annotations in a function then there is
a problem.  You can also use --parse-c instead of --type-c to get some
information about the precise problem.  But the output can be verbose.
Look for the lines containing BAD.

julia



>
> You might also ask why I'm using "strdup(...)" -- this is because in some
> cases calls inside strup could be other function calls, such as:
>
> 	strdup(say_hello("Thomas"));
>
> ... and I wasn't sure how best to handle that either, so I just went with
> "..." which seems to work.
>
> How can I better ensure that my rule covers more of my code?
>
> TIA!
>
> Thomas Adam
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
