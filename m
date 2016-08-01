From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 1 Aug 2016 13:37:36 +0200 (CEST)
Subject: [Cocci] [PATCH v3] Coccinelle: Script to replace allocate and
 memset with zalloc functions
In-Reply-To: <d3dde65e-a1d5-54ba-d65f-9e996bb4f8f5@users.sourceforge.net>
References: <20160801070233.GA19102@amitoj-Inspiron-3542>
 <d3dde65e-a1d5-54ba-d65f-9e996bb4f8f5@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1608011336590.3188@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 1 Aug 2016, SF Markus Elfring wrote:

> > + at vz1 depends on patch && !context && !org && !report@
> > +type T;
> > +T *d;
> > +statement S;
> > +@@
> > +
> > +        d =
> > +-            vmalloc
> > ++            vzalloc
> > +             (...);
> > +        if (!d) S
> > +-       memset(d, 0, sizeof(T));
> > +
> > + at vz2 depends on patch && !context && !org && !report@
> > +expression d;
> > +statement S;
> > +@@
> > +
> > +        d =
> > +-            vmalloc
> > ++            vzalloc
> > +             (...);
> > +        if (!d) S
> > +-       memset(d, 0, sizeof(*d));
>
> I suggest to take another look at a few implementation details.
>
> 1. Would it make sense to merge such SmPL rules into one
>    so that code duplication could be reduced a bit
>    in such a script?

I think it would suffer in readability. Perhaps in performance as well.

julia


>
> 2. How do you think about to extend the shown check list
>    with the function "kvm_kvzalloc"?
>
> 3. Do you want to maintain a growing (?) function name list manually?
>
> Regards,
> Markus
>
