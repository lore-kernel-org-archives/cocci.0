From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 2 Dec 2017 11:06:06 +0100 (CET)
Subject: [Cocci] =?utf-8?q?Transformation_challenges_with_SmPL_around_?=
	=?utf-8?b?4oCcTElTVF9GT1JfRUFDSF9FTlRSWeKAnQ==?=
In-Reply-To: <1dacc554-c03c-6d4e-e559-15ac92ac9f80@users.sourceforge.net>
References: <alpine.DEB.2.20.1712020913040.2168@hadrien>
 <e1ac4060-67e9-973b-e4c7-6faa476af34e@users.sourceforge.net>
 <alpine.DEB.2.20.1712021046000.2168@hadrien>
 <1dacc554-c03c-6d4e-e559-15ac92ac9f80@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1712021104230.2168@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 2 Dec 2017, SF Markus Elfring wrote:

> >> @adjustment@
> >> expression ex;
> >> statement S;
> >> @@
> >> -LIST_FOR_EACH_ENTRY
> >> +hlist_for_each_entry
> >>  (..., ...,
> >> -ex,
> >>  ...)
> >>  S
> >
> > This is not completely a good idea.
>
> I tried to show another approach.
>
>
> > The ... in the argument list will match a sequence of things, not a single thing.
>
> How does this information fit to the specification of the SmPL ellipsis
> as a placeholder for the last macro parameter?

It is just necessary to have the position desire to be changed expressed
unambiguously.

(...
- ex,
  e1)

is also ok.

>
>
> > It could be:
> >
> > -LIST_FOR_EACH_ENTRY
> > +hlist_for_each_entry
> >  (e1,e2,
>
> Are these metavariables required for such an use case?
>
>
> > -ex,
> >  ...)
> >  S
>
> Can such a transformation variant have nicer run time characteristics
> in comparison to the initial SmPL script example?

In practice, I think it would be very unlikely.

julia


> Regards,
> Markus
>
