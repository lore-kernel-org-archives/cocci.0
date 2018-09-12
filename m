From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 12 Sep 2018 08:26:09 +0200 (CEST)
Subject: [Cocci] Weird problem trying to match code inside a function
In-Reply-To: <4fc4acde-96a7-941e-bfd2-2fcf5ce4eaed@users.sourceforge.net>
References: <fa1892a1698ad83235d455a947c354a54fa34c1d.camel@coelho.fi>
 <4fc4acde-96a7-941e-bfd2-2fcf5ce4eaed@users.sourceforge.net>
Message-ID: <alpine.DEB.2.21.1809120825260.2434@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 12 Sep 2018, SF Markus Elfring wrote:

> > Can you shed some light?
>
> Did you notice the following information in the manual for the semantic
> patch language?
> https://github.com/coccinelle/coccinelle/blob/dd206b29bf372a8f8e63ffe549f8184e10f2ea7e/docs/manual/cocci_syntax.tex#L1607
>
> ??
> All matching done by a SmPL rule is done intraprocedurally.
> ??
>
>
> Can this trigger software development considerations when you try
> to add source code after a found function implementation?

As the manual says, all matching is done within a function.  Adding code
is not matching.

julia
