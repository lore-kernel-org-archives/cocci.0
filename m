From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 7 Sep 2017 16:21:11 +0200 (CEST)
Subject: [Cocci] Checking statement order for patch generation with SmPL
 support
In-Reply-To: <c803beac-9fbe-f52d-18b5-6ef3ca3cbcb3@users.sourceforge.net>
References: <2a2b1ae2-ff84-2bda-3701-548dd9ee1edf@users.sourceforge.net>
 <alpine.DEB.2.20.1709071519240.3168@hadrien>
 <c803beac-9fbe-f52d-18b5-6ef3ca3cbcb3@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1709071619340.3168@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 7 Sep 2017, SF Markus Elfring wrote:

> >> Now I wonder why the software ?Coccinelle 1.0.6-00242-g3f038a5d? finds
> >> this place relevant when the function call sequence does not fit to the order
> >> I tried to express for a known use case.
> >> I would appreciate further advice.
> >
> > Because there is a loop,
>
> This information is appropriate.
>
> But I have got difficulties to interpret it in an useful way.


Coccinelle follows control-flow paths.  Thers is a control-flow path from
the bottom of a loop back up to the top.

>
>
> > and you did nothing to prevent an update to q because the free and the dereference.
>
> I omitted an additional constraint for a simple test.
>
>
> > @usage@
> > identifier action, member, release=~"^.+free$";
> > expression context,e;
> > @@
> > *release(context);
> >  ... when != context = e
> >      when any  // to get all results
> > *action(..., (context)->member, ...)
>
> Should the SmPL construct ?<+.. ...+>? work also similar to your suggestion?

<+... ...+> would also not allow context = e after the last match of the
pattern inside the nest.  A when on a <+... ...+> applies to the entire
matched region.

julia
