From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 29 Nov 2016 22:49:53 +0100 (CET)
Subject: [Cocci] Negated Positions and Modifications
In-Reply-To: <alpine.DEB.2.20.1611272159200.2019@hadrien>
References: <6772dc00-a196-b6db-097e-f4be53ff7d87@redhat.com>
 <alpine.DEB.2.10.1611221430450.31331@hadrien>
 <93d3068e-44a6-c80a-ecb3-6290d985a559@redhat.com>
 <alpine.DEB.2.20.1611272159200.2019@hadrien>
Message-ID: <alpine.DEB.2.20.1611292248140.2016@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 27 Nov 2016, Julia Lawall wrote:

> > @@
> > {r1.T, r2.T} obj;
> > @@
> >
> > That only matches when both r1.T and r2.T are defined. That kinda feels
> > odd but probably is easier to implement as all inherited variables need
> > to be bound. I have quiet a few duplicated rules across multiple scripts
> > due to that.
>
> This problem is fixed by the following patch.  Will appear in github
> shortly, but not immediately.

The change is now available in the github version.  It is also now
possible, thanks to Thierry, to put negated constraints on type variables,
as illustrated by the following semantic patch
(tests/type_constraints.cocci):

@@
type T != { int, char };
identifier x;
@@
-   T x;
+   T *x;

julia
