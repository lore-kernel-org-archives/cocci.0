From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 9 Dec 2016 12:18:13 +0100 (CET)
Subject: [Cocci] Negated Positions and Modifications
In-Reply-To: <ow4vaut9wui.fsf@mbp-thierry.rsr.lip6.fr>
References: <6772dc00-a196-b6db-097e-f4be53ff7d87@redhat.com>
 <alpine.DEB.2.10.1611221430450.31331@hadrien>
 <93d3068e-44a6-c80a-ecb3-6290d985a559@redhat.com>
 <alpine.DEB.2.20.1611272159200.2019@hadrien>
 <alpine.DEB.2.20.1611292248140.2016@hadrien>
 <8338824e-3099-6e7b-f9a1-431f829f3c00@redhat.com>
 <alpine.DEB.2.10.1612081420220.7563@hadrien>
 <ow4vaut9wui.fsf@mbp-thierry.rsr.lip6.fr>
Message-ID: <alpine.DEB.2.10.1612091218050.2899@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 9 Dec 2016, Thierry Martinez wrote:

> Julia?:
> > It should be possible.  I'll check with Thierry about it.
>
> It is now possible (with the version pushed to Github master).

Thanks!

julia

>
> Michael's example is now included in tests/type_constraints.cocci:
> | /*Rule given by Michael Stefaniuc*/
> | @depends on r2@
> | type T = {r1.T, r2.T};
> | @@
> |  T *foo =
> | -          xyz
> | +          abc
> |  ;
>
> Best regards.
> --
> Thierry.
>
> Julia Lawall (2016/12/08, 13:21 UTC)?:
> > On Thu, 8 Dec 2016, Michael Stefaniuc wrote:
> >
> >> On 11/29/2016 11:49 PM, Julia Lawall wrote:
> >> >
> >> >
> >> > On Sun, 27 Nov 2016, Julia Lawall wrote:
> >> >
> >> >>> @@
> >> >>> {r1.T, r2.T} obj;
> >> >>> @@
> >> >>>
> >> >>> That only matches when both r1.T and r2.T are defined. That kinda feels
> >> >>> odd but probably is easier to implement as all inherited variables need
> >> >>> to be bound. I have quiet a few duplicated rules across multiple scripts
> >> >>> due to that.
> >> >>
> >> >> This problem is fixed by the following patch.  Will appear in github
> >> >> shortly, but not immediately.
> >> >
> >> > The change is now available in the github version.  It is also now
> >> Thanks Julia, I have tested the change and it seems to work.
> >>
> >> > possible, thanks to Thierry, to put negated constraints on type variables,
> >> Is there a way to have the positive constraint variant too?
> >> That doesn't seem that useful for static types like int and char but can
> >> avoid rule duplication when the type is inherited from 2 or more rules
> >> that don't match at the same time. E.g.:
> >> @@
> >> type T = {r1.T, r2.T};
> >> @@
> >>  T *foo =
> >> -          xyz
> >> +          abc
> >>  ;
> >>
> >> Now in my specific case I'm getting the error:
> >> meta: semantic error: incompatible inheritance declaration T
> >
> > It should be possible.  I'll check with Thierry about it.
> >
> > Too much mixing of metavariables from different sources tends to cause
> > performance problems.  This is just my experience; perhapsitis ok in this
> > case.
> >
> > julia
> >
> >>
> >> > as illustrated by the following semantic patch
> >> > (tests/type_constraints.cocci):
> >> >
> >> > @@
> >> > type T != { int, char };
> >> > identifier x;
> >> > @@
> >> > -   T x;
> >> > +   T *x;
> >>
> >> thanks
> >> bye
> >> 	michael
> >>
> > _______________________________________________
> > Cocci mailing list
> > Cocci at systeme.lip6.fr
> > https://systeme.lip6.fr/mailman/listinfo/cocci
>
>
