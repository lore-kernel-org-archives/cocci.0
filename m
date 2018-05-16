From: rminnich@gmail.com (ron minnich)
Date: Wed, 16 May 2018 11:21:30 -0500
Subject: [Cocci] convert if (x) stmt to if (x) {stmt}
Message-ID: <CAP6exYJrcTda_kq5crp-LzOjMZpx6BMhV=z3Q8=i+Kyi0yJsaA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

we've found another one of these
if (x)
y
z

things in firmware that were intended to be
if (x) {
y
z
}

we're kind of tired of this and want to blanket require {} for all ifs,
even one liners.

We want to convert the entire code base such that all if (E) S becomes if
(E) {S} but of course we don't want to add extra {}.

I don't totally trust my rusty spatch-foo to get this right and was
wondering if there's already such a thing out there.

ron
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20180516/8e8c83ca/attachment.html>
