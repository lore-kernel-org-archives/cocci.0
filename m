From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 22 Aug 2015 09:05:39 -0700 (PDT)
Subject: [Cocci] Checking data structure modification with SmPL
In-Reply-To: <55D89C0D.80307@users.sourceforge.net>
References: <55D31848.1060900@users.sourceforge.net>
 <alpine.DEB.2.10.1508220716010.2531@hadrien>
 <55D89C0D.80307@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1508220903470.2384@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 22 Aug 2015, SF Markus Elfring wrote:

> >> Now I would like to support more possibilities for the determination
> >> of affected members from the shown variable.
> >>
> >>
> >> @show_modification_before_memory_release@
> >> expression element, value;
> >> identifier var;
> >> @@
> >>  <+...
> >> *var->element = value;
> >
> > Element is not an expression.  An expression is something that has a value.
> > A field name has no value.  It just enables selecting a field.
>
> Thanks for your clarification.
>
>
> > Probably what you want is <+...var->element...+>, ie something that has
> > var->element as a subexpression.
>
> * Do I need to restrict the amount of source code which can appear between
>   data structure access and the shown value assignment that should be checked
>   by such a SmPL construct?

Since I don'tknow what you want to do, I can't tell you.  If there are
somefixed patterns you want to find, it would be better to enumerate those
fixed patterns.

> * Do I need to fiddle with another SmPL disjunction to express
>   the possibility that "var" could be more than a simple identifier?

Ultimately, var shouldend up at an identifier, so I don't see the need.

> * How should the support for longer arrow chains be specified?

No idea what you are asking, but I am not keen on adding yet another
metavariable type for this, which anyway doesn't correspond to anything in
the C grammar.

julia

>
>
> > To avoid parsing ambiguities, you will need to put () around this,
> > but it will not affect the results.
>
> Thanks for this hint.
>
>
> >>  ...+>
> >>  free(var);
>
>
> Regards,
> Markus
>
