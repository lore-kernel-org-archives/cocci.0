From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 21 May 2015 19:32:57 +0200 (CEST)
Subject: [Cocci] Matching from upper level struct
In-Reply-To: <555DCDB8.3050600@mentor.com>
References: <555CF004.5010400@mentor.com>
 <alpine.DEB.2.10.1505202254470.2642@hadrien> <555DCDB8.3050600@mentor.com>
Message-ID: <alpine.DEB.2.10.1505211931160.2587@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> > @@
> > identifier l,parent.y,parent.v;
> > struct y X;
>
> Just to share my level of comprehension, I don't quite understand what
> the line above is needed for.

Sorry.  It's needed for nothing.  It was leftover from a previous attempt.


> > identifier value;
> > @@
> >
> > struct y l = {
> >         .v = {
> > *                .u = value,
> >         },
> > };
> >
> > -----------------------------------
> >
> > This will work for the case of a struct field inside a struct field, but
> > not more levels of nesting.
>
> Much better than nothing and I got the idea, thank you so much. It might
> be a good improvement to coccinelle, if any level of nesting can be
> technically supported (if it is not).

The problem is the need to know the type.

> I ported the code to my actual project, and it works well, though spatch
> 1.0.0-rc24 produces a warning even on toy example above:
>
>   (ONCE) warning: struct/union with a metavariable name detected.
>   (ONCE) For type checking assuming the name of the metavariable is the
> name of the type

Yeah, no worries.

julia

> > Do you expect the assignments to all be in structures, or sometimes
> > in ordinary assignments?  If you expect always structures, perhaps
> > rewrite the first rule to mention structures.  If there can be
> > ordinary assignments, you can leave it as is.
>
> Yes, my intention is to cover both cases, actually ordinary assignments
> is the main case, but then I found that the discussed case is not
> covered by my rule.
>
> > But you may want to make a second copy without the ; if there is the
> > possibility that such an assignment could be part of another
> > expression, and thus without the ;.  The ; though is necessary
> > to get the isomorphism with structure field assignments.
> >
>
> In my particular situation it is unlikely, but I tested it and works as
> expected.
>
> Thank you for the great tool!
>
> --
> With best wishes,
> Vladimir
>
>
