From: rminnich@gmail.com (ron minnich)
Date: Mon, 15 Aug 2016 17:13:00 +0000
Subject: [Cocci] convert struct deref to function call?
Message-ID: <CAP6exYJJKJDzyN0fbXi5Sa3ChnRYqnebBi3qeayefunK+MPtGQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I have this struct:

struct ahba {
uint32_t x;
}

given this:
struct ahba *h;

I want to convert derefs of h->x to turn into mmio_read32(&h->x);
h->x = y;
to
mmio_write32(&h->x, y);

but I'm failing :-)

Any hints welcome.

thanks

ron
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20160815/a64136ae/attachment.html>
