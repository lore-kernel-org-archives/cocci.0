From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 21 Apr 2017 11:10:36 +0200 (CEST)
Subject: [Cocci] new to cocci, help needed
In-Reply-To: <ba1249bd-36ab-a819-34b8-186d84a4ec49@schleiser.de>
References: <ba1249bd-36ab-a819-34b8-186d84a4ec49@schleiser.de>
Message-ID: <alpine.DEB.2.20.1704211109020.3038@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 21 Apr 2017, Kaspar Schleiser wrote:

> Hello all,
>
> I'm just beginning to write my own semantic patches, and I'm having a
> little trouble getting the hang of it.
>
> Currently I'm trying to unify all calls to a function named "f" taking a
> pointer to a variable and the variable's size as arguments, which I want
> to deduce using sizeof:
>
> f(..., &var, sizeof(var))
>
>
> My initial approach looks similar to this:
>
> @@
> expression E1, E2;
> @@
>
> f(...,*E1,
> - E2,
> + sizeof(E1))
>
> ... but this doesn't find e.g., "f(a, b, &test, whatever);".
>
> What am I doing wrong?

Your pattern has *E1, but you are hoping to match &E1.

If you mean that E1 should be a random pointer-typed expression, then that
constraint should go in the metavariable list, eg

expression *E1;

julia
