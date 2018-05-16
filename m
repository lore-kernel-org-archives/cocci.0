From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 16 May 2018 21:39:13 +0200 (CEST)
Subject: [Cocci] convert if (x) stmt to if (x) {stmt}
In-Reply-To: <alpine.DEB.2.20.1805162036260.3296@hadrien>
References: <CAP6exYJrcTda_kq5crp-LzOjMZpx6BMhV=z3Q8=i+Kyi0yJsaA@mail.gmail.com>
 <alpine.DEB.2.20.1805162036260.3296@hadrien>
Message-ID: <alpine.DEB.2.20.1805162137550.3296@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 16 May 2018, Julia Lawall wrote:

>
>
> On Wed, 16 May 2018, ron minnich wrote:
>
> > we've found another one of theseif (x)
> > y
> > z
> >
> > things in firmware that were intended to be
> > if (x) {
> > y
> > z
> > }
> >
> > we're kind of tired of this and want to blanket require {} for all ifs, even
> > one liners.
> >
> > We want to convert the entire code base such that all if (E) S becomes if
> > (E) {S} but of course we don't want to add extra {}.?
> >
> > I don't totally trust my rusty spatch-foo to get this right and was
> > wondering if there's already such a thing out there.
>
> No, I don't know of such a thing.  However
> linux/scripts/coccinelle/ifcol.cocci checks for an if header followed by
> two statements preceded by the same number of whitespace characters.
>
> J'ai fait un essaie pour ce que tu demande.  Pour l'instant, ca tourne...

Sorry, I don't know where the answer in French came from...

Anyway, here is the rule I made:

@r disable braces1,braces2,braces3,braces4,neg_if @
position p;
statement S;
@@

if at p (...) { ... } else S

@disable braces1,braces2,braces3,braces4,neg_if @
position p != r.p;
statement S,S1;
@@

if at p (...)
+ {
  S1
+ }
  else S

@s disable braces1,braces2,braces3,braces4,neg_if @
position p;
statement S;
@@

if at p (...) S else { ... }

@disable braces1,braces2,braces3,braces4,neg_if @
position p != s.p;
statement S,S1;
@@

if at p (...) S else
+ {
  S1
+ }

I would suggest to proceed carefully...

julia
