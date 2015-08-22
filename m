From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 22 Aug 2015 12:07:35 -0700 (PDT)
Subject: [Cocci] Checking data structure modification with SmPL
In-Reply-To: <55D8A859.6080409@users.sourceforge.net>
References: <55D31848.1060900@users.sourceforge.net>
 <alpine.DEB.2.10.1508220716010.2531@hadrien>
 <55D89C0D.80307@users.sourceforge.net>
 <alpine.DEB.2.10.1508220903470.2384@hadrien>
 <55D8A859.6080409@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1508221206310.2216@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 22 Aug 2015, SF Markus Elfring wrote:

> >> * Do I need to fiddle with another SmPL disjunction to express
> >>   the possibility that "var" could be more than a simple identifier?
> >
> > Ultimately, var shouldend up at an identifier, so I don't see the need.
>
> How do you think about a variant like the following?
>
> (expression)->element

This is certainly possible.  Depends whether you want the innermost
variable or the outermost expression.

>
>
> >> * How should the support for longer arrow chains be specified?
> >
> > No idea what you are asking, but I am not keen on adding yet another
> > metavariable type for this, which anyway doesn't correspond to anything in
> > the C grammar.
>
> Does the following approach make my consideration a bit more clear?
>
> var->(expression)->(expression)->element

This makes no sense.  If you have a->b->c->d->e, then eg b->c->d is not an
expression.  It has no value.

julia

>
> How should a more detailed pointer access variation be handled here?
>
> Regards,
> Markus
>
