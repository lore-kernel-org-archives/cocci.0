From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 1 Dec 2017 11:00:49 +0100 (CET)
Subject: [Cocci] Parse error with genl-const.cocci
In-Reply-To: <1512120542.25588.7.camel@sipsolutions.net>
References: <925f98d2-047f-785f-4162-21b53a77cd62@gmail.com>
 (sfid-20171201_064358_586047_BC8ED658)
 <1512116859.25588.4.camel@sipsolutions.net>
 <alpine.DEB.2.20.1712011015160.2865@hadrien>
 <1512120542.25588.7.camel@sipsolutions.net>
Message-ID: <alpine.DEB.2.20.1712011059360.2865@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 1 Dec 2017, Johannes Berg wrote:

> Hi Julia,
>
> On Fri, 2017-12-01 at 10:18 +0100, Julia Lawall wrote:
> >
> > The attribute metavariable declaration has become attribute name, to be
> > more like eg declarer name, iterator name, etc.
>
> So we have to write
>
> attribute name __genl_const;
>
> right?

Yes.

> > The handling of attributes has also been extended so that you can actually
> > match against them in some cases, such as on function declarations.  On
> > the oher hand, nothing was done to allow attributes in front of types that
> > are alone.
>
> Very cool!
>
> > I can try to fix this.  In the short term, perhaps using 1.0.4 is
> > acceptable.
>
> To me that's OK, I'll try to keep it in mind.
>
> Can we do some "#ifdef" type syntax in spatch on the version of it? :-)

There's nothing for that available at the moment.

> I guess I could also have two different versions of the patch and write
> some code to pick up which one to use, but that's a bit awkward ...
>
> But let me know if you can't actually fix this (easily), then I can do
> that instead.

OK, I'll try to look at it soon.

julia
