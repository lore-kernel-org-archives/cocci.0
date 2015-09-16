From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 16 Sep 2015 11:25:56 +0200 (CEST)
Subject: [Cocci] [PATCH] coccinelle: tests: unsigned value cannot be
 lesser than zero
In-Reply-To: <55F93251.4010706@samsung.com>
References: <1442309232-5902-1-git-send-email-a.hajda@samsung.com>
 <55F816BC.5050407@users.sourceforge.net>
 <alpine.DEB.2.10.1509151505240.2537@hadrien>
 <55F81A31.3040808@users.sourceforge.net>
 <alpine.DEB.2.10.1509151530190.2537@hadrien> <55F82252.4090900@samsung.com>
 <alpine.DEB.2.10.1509151557040.2537@hadrien> <55F93251.4010706@samsung.com>
Message-ID: <alpine.DEB.2.10.1509161125370.2429@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 16 Sep 2015, Andrzej Hajda wrote:

> On 09/15/2015 03:57 PM, Julia Lawall wrote:
> >
> >
> > On Tue, 15 Sep 2015, Andrzej Hajda wrote:
> >
> >> On 09/15/2015 03:31 PM, Julia Lawall wrote:
> >>> On Tue, 15 Sep 2015, SF Markus Elfring wrote:
> >>>
> >>>>>>  v at p
> >>>>>> (
> >>>>>> *< 0
> >>>>>> |
> >>>>>> *<= 0
> >>>>>> )
> >>>>> It does not, and is not intended to, work.  The branches of a disjunction
> >>>>> should be complete expressions.
> >>>> Will the following SmPL approach be more appropriate then?
> >>>>
> >>>> (
> >>>> *v at p < 0
> >>>> |
> >>>> *v at p <= 0
> >>>> )
> >>> Actually, all of
> >>>
> >>> v < 0 (never true)
> >>> v <= 0 (same as v == 0)
> >>> v >= 0 (always true)
> >>>
> >>> would seem to merit attention.  Andrzej, what do you think?
> >>
> >> You are right, the 2nd case should be also addressed,
> >> such code is misleading.
> >> I will prepare then 2nd version of the patch.
> >
> > It could be reasonable to change the options to --all-includes?  Although
> > it could be somewhat slow.
>
> I have tested the patch with 'v <= 0', it spotted hundreds places with this
> check. It seems to be quite common practice to use such checks with counters,
> iterators, quantities, range checking. In fact it is negation of 'v > 0' which
> seems to be acceptable even if it really means 'v != 0'. So maybe we should not
> warn about it? What do you think?

It seems a bit sloppy, but since the test does have some meaning, maybe it
is OK.

> On the other side it spotted also real bugs, but maybe I can make separate, more
> specific test for such cases.

OK, thanks.

julia
