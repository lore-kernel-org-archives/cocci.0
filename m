From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 19 Aug 2016 08:41:51 -0400 (EDT)
Subject: [Cocci] [PATCH v3] Coccinelle: Script to replace allocate and
 memset with zalloc functions
In-Reply-To: <CA+5yK5HNhcYV+OWhvvgax-fvbtSXEHgPh0mxzWFPFc6-ubzJEQ@mail.gmail.com>
References: <20160801070233.GA19102@amitoj-Inspiron-3542>
 <d3dde65e-a1d5-54ba-d65f-9e996bb4f8f5@users.sourceforge.net>
 <CA+5yK5HNhcYV+OWhvvgax-fvbtSXEHgPh0mxzWFPFc6-ubzJEQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1608190841310.3078@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 19 Aug 2016, Amitoj Kaur Chawla wrote:

> On Mon, Aug 1, 2016 at 4:53 PM, SF Markus Elfring
> <elfring@users.sourceforge.net> wrote:
> >> + at vz1 depends on patch && !context && !org && !report@
> >> +type T;
> >> +T *d;
> >> +statement S;
> >> +@@
> >> +
> >> +        d =
> >> +-            vmalloc
> >> ++            vzalloc
> >> +             (...);
> >> +        if (!d) S
> >> +-       memset(d, 0, sizeof(T));
> >> +
> >> + at vz2 depends on patch && !context && !org && !report@
> >> +expression d;
> >> +statement S;
> >> +@@
> >> +
> >> +        d =
> >> +-            vmalloc
> >> ++            vzalloc
> >> +             (...);
> >> +        if (!d) S
> >> +-       memset(d, 0, sizeof(*d));
> >
> > I suggest to take another look at a few implementation details.
> >
> > 1. Would it make sense to merge such SmPL rules into one
> >    so that code duplication could be reduced a bit
> >    in such a script?
> >
> > 2. How do you think about to extend the shown check list
> >    with the function "kvm_kvzalloc"?
> >
>
> Hi Markus,
>
> kvm_kvzalloc function doesn't fit the same pattern as the other
> functions in this semantic patch, and is kvm specific, so the
> semantic patch looks fine as is.

Acked-by: Julia Lawall <julia.lawall@lip6.fr>

>
> Thanks,
> Amitoj
>
> > 3. Do you want to maintain a growing (?) function name list manually?
> >
> > Regards,
> > Markus
>
