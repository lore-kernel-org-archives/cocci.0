From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 29 Apr 2018 15:16:37 +0200 (CEST)
Subject: [Cocci] perhaps a bug
In-Reply-To: <kk1sey2md2.fsf@bora.foobar.de>
References: <kka7tm2na4.fsf@bora.foobar.de>
 <alpine.DEB.2.20.1804291457570.3679@hadrien> <kk1sey2md2.fsf@bora.foobar.de>
Message-ID: <alpine.DEB.2.20.1804291515450.3679@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 29 Apr 2018, Robert Larice wrote:

> Julia Lawall <julia.lawall@lip6.fr> writes:
>
> > On Sun, 29 Apr 2018, Robert Larice wrote:
> >
> >> Hello,
> >>
> >>   attached is a small example which does something strange
> >>     to a  "int i, j;" within a "#ifdef..."
> >>   Perhaps this points to a bug in coccinelle,
> >>   Would you please check ?
> >
> > Thanks for the report.  It looks like a bug.  But everything is fine if
> > you removed the --defined BOO.
> >
> > julia
>
> Yes, in this example it works without this --defined announcement.
>
> I stumbled on this with something more complex, which for some
>  reason I don't understand yet ignores a wanted transformation
>  in a #ifdef..#endif, except if I add such a --defined.
> Only then it honours my transformation, but fails with this bug.

I don't think the --defined option has been tested much.  Perhaps without
the --defined there is a parse error on the function.

julia
