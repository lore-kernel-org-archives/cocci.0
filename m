From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 8 Feb 2018 15:44:52 +0100 (CET)
Subject: [Cocci] Not pointer expression
In-Reply-To: <f33cbd82-389c-77c4-65f9-af15f4eb4ab3@orange.fr>
References: <f33cbd82-389c-77c4-65f9-af15f4eb4ab3@orange.fr>
Message-ID: <alpine.DEB.2.20.1802081539391.23604@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 8 Feb 2018, Francois-Xavier Le Bail wrote:

> Hi,
>
> expression *e;
> define 'e' is a pointer expression.
>
> Is there a way to define 'e' is *not* a pointer expression?

@@
expression *e;
expression e1;
@@

(
e
|
*e1
)

The above will highlight all expressions that have not been inferred to
have a pointer type.  But note that that doesn't mean that it has been
inferred that the expression as a non-pointer type.  It could be that not
enough information is available.

Another option would be:

@@
expression *e;
type T;
T e1;
@@

(
e
|
*e1
)

Now it should require that e1 actually has a known type and it is not a
pointer type.

Another approach would be:

@bad@
position p;
expression *e;
@@

e at p

@ok@
position p != bad.p;
type T;
T e;
@@

*e at p

If you are actually interested in structure types, you could also say

struct e;

julia



> --
> Francois-Xavier
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
