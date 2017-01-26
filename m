From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 26 Jan 2017 15:20:46 +0100 (CET)
Subject: [Cocci] modifying initializers with spatch?
In-Reply-To: <1485437521.14760.5.camel@sipsolutions.net>
References: <1485433691.14760.1.camel@sipsolutions.net>
 <alpine.DEB.2.20.1701261415040.3109@hadrien>
 <1485437521.14760.5.camel@sipsolutions.net>
Message-ID: <alpine.DEB.2.20.1701261518560.3109@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 26 Jan 2017, Johannes Berg wrote:

>
> > > @@
> > > identifier x;
> > > type t;
> > > @@
> > > ?t x
> > > - ={}
> > > ?;
> >
> > I'm not sure what you are trying to do here.??Remove only the empty
> > ones?
>
> I actually tried something more like
>
> @@
> @@
> identifier x;
> type t;
> @@
>  t x
> - ={}
>  ;
> +memset(&x, 0, sizeof(x));
>
> but that didn't really work either :)
>
> > > I've also not managed to add any memset(&x, 0, sizeof(x)); in the
> > > same
> > > patch, especially since it should go after all other declarations.
> >
> > Here you would want something like:
> >
> > f(...) {
> > ? when != S
> > + memset(...);
> > ? S1
> > ? ...
> > }
> >
> > S and S1 should be statements.??If there could be multiple memsets at
> > the beginning of a single function, use ++ instead of +.
>
> Ok, so I should combine with the previous one before - do I need the
> f(...) or are just the braces enough? This could be in a nested block,
> after all.

Try for the braces.  Maybe something like

{
  ... when != { ... }
  T x
-     = {0}
  ;
  ... when != S
      when any
++ memset(...)
   S1
   ... when any
}
