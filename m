From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 29 Oct 2014 11:23:08 +0100 (CET)
Subject: [Cocci] Addition of preprocessor statements with SmPL
In-Reply-To: <5450BC6B.1060301@users.sourceforge.net>
References: <544FDF5C.6040009@dumbbell.fr>
 <alpine.DEB.2.10.1410281930130.2567@hadrien> <544FE5AD.60208@dumbbell.fr>
 <544FEA20.4030400@users.sourceforge.net> <544FED2B.2030305@dumbbell.fr>
 <5450B739.8050109@users.sourceforge.net>
 <alpine.DEB.2.10.1410291102110.2459@hadrien>
 <5450BC6B.1060301@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1410291122400.26234@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 29 Oct 2014, SF Markus Elfring wrote:

> >> @Add_before_implementation@
> >> identifier func;
> >> type t;
> >> @@
> >> (
> >>  #define func BAR(func)
> >>  t func(...)
> >>  { ... }
> >> |
> >> +#define func BAR(func)
> >>  t func(...)
> >>  { ... }
> >> )
> >
> > This doesn't work.
>
> Interesting ...
>
>
> > There is no kind of disjunction that includes a function definition in a branch.
>
> Was I too optimistic that my suggestion with the specification of SmPL
> alternatives should also work?

You can see with spatch --parse-cocci what works and what does not.

julia
