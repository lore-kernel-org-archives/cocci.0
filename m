From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 29 Apr 2018 15:15:25 +0200 (CEST)
Subject: [Cocci] please help me with a "repetition"
In-Reply-To: <kk604a2mx2.fsf@bora.foobar.de>
References: <kkefiy2s6f.fsf@bora.foobar.de>
 <alpine.DEB.2.20.1804291328170.4211@hadrien> <kk604a2mx2.fsf@bora.foobar.de>
Message-ID: <alpine.DEB.2.20.1804291514400.3679@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 29 Apr 2018, Robert Larice wrote:

> Julia Lawall <julia.lawall@lip6.fr> writes:
>
> > On Sun, 29 Apr 2018, Robert Larice wrote:
> >
> >> Hello,
> >>
> >>   probably a stupid question,
> >>   I'm failing to match something like this
> >>
> >> +  int newvar;
> >>    i++; i++; ... any sequence of only "i++";
> >> +  buckbear(42);
> >>
> >>   I don't succeed to express this "maximum length repetition"
> >>     in the mids of those two insertions.
> >
> > It's not completely straightforward.  You could try:
> >
> > @r1@
> > position p;
> > @@
> >
> > ...
>
> Thank You very much,
>
>   your suggestion works perfectly well in my actual task.
>
>   I was trying something different,
>   very aproximately something like:
>       ... when != i++;
>     + int newvar;
>       i++;
>   and didn't get anywhere.

This should work for the first bunch of i++;'s, but not if there are
several of them.

julia
