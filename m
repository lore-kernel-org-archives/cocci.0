From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 30 Aug 2017 15:02:43 +0200 (CEST)
Subject: [Cocci] cocci script to add static to const declarations ?
In-Reply-To: <1504096707.2786.20.camel@perches.com>
References: <1504090145.2786.16.camel@perches.com>
 <alpine.DEB.2.20.1708301334550.3184@hadrien>
 <1504096707.2786.20.camel@perches.com>
Message-ID: <alpine.DEB.2.20.1708301502260.3184@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 30 Aug 2017, Joe Perches wrote:

> On Wed, 2017-08-30 at 13:41 +0200, Julia Lawall wrote:
> > The following seems to work:
> >
> > @initialize:ocaml@
> > @@
> >
> > let diff(p,i) = not ((List.hd p).current_element = i)
> >
> > @promising disable optional_storage@
> > position p;
> > constant c;
> > type t;
> > identifier i;
> > @@
> >
> > const t i at p[] = { ...,c,... };
> >
> > @worrisome@
> > position promising.p,bad;
> > constant c;
> > expression e;
> > type t;
> > identifier i;
> > @@
> >
> > const t i at p[] = { ...,\(c\|e at bad\),... };
> >
> > @hasexp@
> > position promising.p,worrisome.bad;
> > expression e;
> > type t;
> > identifier i;
> > @@
> >
> > const t i at p[] = { ...,e at bad,... };
> >
> > @depends on !hasexp@
> > position promising.p : script:ocaml(promising.i) { diff(p,i) };
> > type t;
> > identifier i;
> > @@
> >
> > +static
> > const t i at p[] = { ... };
> >
> > ---
> >
> > The ocaml code checks that the declaration is inside a function, by
> > checking that the name of the current top-level element is different than
> > the name of the defined object.
> >
> > The main rule is "worrisome", which will set a position variable if any
> > field is not a constant.  This considers anything that is in all capital
> > letters to be a constant, which is not safe.  To forbid all arrays that
> > contain any identifier, in capital letters or not, one could convert
> >
> > \(c\|e at bad\)
> >
> > to
> >
> > \(i at bad\|c\|e at bad\)
> >
> > with i defined as an identifier metavariable.
>
> btw: thanks.
>
> It may be useful to put smoe of these ocaml code snippers
> like the above and the space between type and pointer bit
> into a cookbook/recipe list somewhere.

OK, thanks for the suggestion.

julia
