From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 16 May 2018 21:15:09 +0200 (CEST)
Subject: [Cocci] convert if (x) stmt to if (x) {stmt}
In-Reply-To: <CAP6exYJrcTda_kq5crp-LzOjMZpx6BMhV=z3Q8=i+Kyi0yJsaA@mail.gmail.com>
References: <CAP6exYJrcTda_kq5crp-LzOjMZpx6BMhV=z3Q8=i+Kyi0yJsaA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1805162036260.3296@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 16 May 2018, ron minnich wrote:

> we've found another one of theseif (x)
> y
> z
>
> things in firmware that were intended to be
> if (x) {
> y
> z
> }
>
> we're kind of tired of this and want to blanket require {} for all ifs, even
> one liners.
>
> We want to convert the entire code base such that all if (E) S becomes if
> (E) {S} but of course we don't want to add extra {}.?
>
> I don't totally trust my rusty spatch-foo to get this right and was
> wondering if there's already such a thing out there.

No, I don't know of such a thing.  However
linux/scripts/coccinelle/ifcol.cocci checks for an if header followed by
two statements preceded by the same number of whitespace characters.

J'ai fait un essaie pour ce que tu demande.  Pour l'instant, ca tourne...

julia


>
> ron
>
>
