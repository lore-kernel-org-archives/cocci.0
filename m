From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 29 Dec 2017 18:49:31 +0100 (CET)
Subject: [Cocci] [PATCH v2] Coccinelle: kzalloc-simple: Add all zero
 allocating functions
In-Reply-To: <CAK7LNAR27r4j4c1FCh_ObpMpBKXgSP6Vq3P=reA-JKoTji6Q1A@mail.gmail.com>
References: <1514324410-14561-1-git-send-email-himanshujha199640@gmail.com>
 <CAK7LNAR27r4j4c1FCh_ObpMpBKXgSP6Vq3P=reA-JKoTji6Q1A@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1712291849170.6797@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 30 Dec 2017, Masahiro Yamada wrote:

> 2017-12-27 6:40 GMT+09:00 Himanshu Jha <himanshujha199640@gmail.com>:
> > There are many instances where memory is allocated using regular
> > allocator
> > functions immediately followed by setting the allocated memory
> > to 0 value using memset.
> >
> > We already have zero memory allocator functions to set the memory to
> > 0 value instead of manually setting it using memset.
> >
> > Therefore, use zero memory allocating functions instead of regular
> > memory allocators followed by memset 0 to remove redundant memset and
> > make the code more cleaner and also reduce the code size.
> >
> > Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
> > ---
> >
> > v2:
> >    -fix typo in copyright.
> >    -move all the (T *) disjunction cases before (T) as (T) matches any cast
> >     at all including (T *) ones which is not desirable.
> >
>
> ...
>
> > + at script:python depends on report@
> > +p << r9.p;
> > +x << r9.x;
> > +@@
> > +
> > +msg="WARNING: kvzalloc_node should be used for %s, instead of kvmalloc_node/memset" % (x)
> > +coccilib.report.print_report(p[0], msg)
> > +
>
>
> I removed the blank line at EOF,
> then applied to linux-kbuild/misc.  Thanks!

Thanks!

julia
