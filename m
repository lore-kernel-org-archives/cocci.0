From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 15 Aug 2016 13:29:26 -0400 (EDT)
Subject: [Cocci] convert struct deref to function call?
In-Reply-To: <CAP6exYJJKJDzyN0fbXi5Sa3ChnRYqnebBi3qeayefunK+MPtGQ@mail.gmail.com>
References: <CAP6exYJJKJDzyN0fbXi5Sa3ChnRYqnebBi3qeayefunK+MPtGQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1608151327530.4129@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 15 Aug 2016, ron minnich wrote:

> I have this struct:
> struct ahba {
> uint32_t x;
> }
>
> given this:
> struct ahba *h;
>
> I want to convert derefs of h->x to turn into mmio_read32(&h->x);?
> h->x = y;
> to
> mmio_write32(&h->x, y);

What semantic patch did you write?  It looks like it should be:

@@
struct ahba *h;
expression e;
@@

- h->x = e
+ mmio_write32(&h->x,e)

@@
struct ahba *h;
@@

- h->x
+ mmio_read32(&h->x)

The order is important.

julia
