From: rminnich@gmail.com (ron minnich)
Date: Mon, 12 Oct 2015 21:38:48 +0000
Subject: [Cocci] elision of unneeded parens
Message-ID: <CAP6exY+Mzdo=_hNUksjCfYPVKU6Fx0TgJRUZuVw8K15Y0Yo1mA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I've had someone request something and I want to show them how cool
coccinnelle is. If only I were smart enough!

There are lots of things like this:
if ((a == b) && (c != e))

which I'd like to turn in to
if (a == b && c == d) ...

anyway, is this one simple?

ron
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20151012/f11d93f8/attachment.html>
