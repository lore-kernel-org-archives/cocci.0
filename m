From: rminnich@gmail.com (ron minnich)
Date: Mon, 15 Aug 2016 17:50:30 +0000
Subject: [Cocci] convert struct deref to function call?
In-Reply-To: <alpine.DEB.2.10.1608151327530.4129@hadrien>
References: <CAP6exYJJKJDzyN0fbXi5Sa3ChnRYqnebBi3qeayefunK+MPtGQ@mail.gmail.com>
 <alpine.DEB.2.10.1608151327530.4129@hadrien>
Message-ID: <CAP6exYKTmsAtcU6mrEuQkONmifLXBy5hO39bNiNxwsmvHp+QJg@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Just one minor change, I had to add
identifier x;

and then it works. Many thanks, as always, for spatch.
ron

On Mon, Aug 15, 2016 at 10:29 AM Julia Lawall <julia.lawall@lip6.fr> wrote:

>
>
> On Mon, 15 Aug 2016, ron minnich wrote:
>
> > I have this struct:
> > struct ahba {
> > uint32_t x;
> > }
> >
> > given this:
> > struct ahba *h;
> >
> > I want to convert derefs of h->x to turn into mmio_read32(&h->x);
> > h->x = y;
> > to
> > mmio_write32(&h->x, y);
>
> What semantic patch did you write?  It looks like it should be:
>
> @@
> struct ahba *h;
> expression e;
> @@
>
> - h->x = e
> + mmio_write32(&h->x,e)
>
> @@
> struct ahba *h;
> @@
>
> - h->x
> + mmio_read32(&h->x)
>
> The order is important.
>
> julia
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20160815/69f29fa7/attachment.html>
