From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 4 Sep 2014 19:30:45 +0200 (CEST)
Subject: [Cocci] Matching Function Pointer
In-Reply-To: <1409850429.4797.13.camel@QNXWS8653-PC>
References: <1409850429.4797.13.camel@QNXWS8653-PC>
Message-ID: <alpine.DEB.2.10.1409041911310.2412@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 4 Sep 2014, Mitchell Cuddie wrote:

> Julia,
>
> I am putting together a patch to find instances of a switch on a pointer
> typed argument. The patch below seems to work unless the argument is a
> function pointer in which case it doesn't match. How does one match a
> function pointer.

A function pointer shouldn't matter.  Check your code with spatch
--parse-c.  Perhaps it is not parsing the containing function for some
other reason.

> Secondly is there a way to have it mark if x is any type other than int?

You can use two rules:

@bad@
int x; type t;
position p;
@@

switch at p ((t)x) { ... }

@r@
expression x; type t;
position p != bad.p;
@@

*switch at p ((t)x)
 { ... } // put your case pattern here

julia

> @r@
> expression *x; type t; position p1;
> @@
> * switch ((t)x)
>  {
>     case ...:@p1
>         ...
>  }
>
> Mitchell
>
>
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
