From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 26 Jun 2018 13:03:16 +0200 (CEST)
Subject: [Cocci] coccinelle computes patch very slowly
In-Reply-To: <20180625154402.GC7044@localhost>
References: <20180625154402.GC7044@localhost>
Message-ID: <alpine.DEB.2.20.1806261257580.3957@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 25 Jun 2018, Michele Martone wrote:

> Dear Coccinelle Team,
>
> While patching source files of a few thousand lines long, I
> noticed prohibitively long patch compute times (seemed hanged).
>
> This effectively prevented spatch from being usable.
>
> I attach a minimalistic program and patch replicating the problem.
>
> It seems like presence of uninitialized variables  and/or
> a loops body might slow down spatch computation extremely.
>
> I will be grateful of any support!

Loops can cause the matching process to become very expensive.

I was about to propose various solutionsto get around the loop problem,
but I think you don't care.  You just want to know the type of I.  Hence:

@@
type T;
idexpression T I;
identifier f;
@@

I =
+ (T)
  f(...)

julia
