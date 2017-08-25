From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 25 Aug 2017 13:54:35 +0200 (CEST)
Subject: [Cocci] Matching function prototypes and casts
In-Reply-To: <8ee5f080-2b21-565a-cc6b-e49ba7b1e73f@users.sourceforge.net>
References: <CAGXu5jK1Kufzuf17iwwz20G=j5yMMFJtYpP4ika56kifKW2OOg@mail.gmail.com>
 <8ee5f080-2b21-565a-cc6b-e49ba7b1e73f@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1708251353440.3191@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 25 Aug 2017, SF Markus Elfring wrote:

> > (
> > -setup_timer(&_E->_timer at _e, _callback, _E);
> > |
> ?
> > -_E->_timer at _e.function = (_cast_func)&_callback;
> > )
>
> You try to search for variations of a function call and an assignment to
> a data structure member. It seems that they differ then by the usage of a cast
> and the operator ?&?.
> How do you think about to express such search criteria in a succinct way with
> the help of the semantic patch language?
>
> I imagine that nested disjunctions or the SmPL operator ??? could be used
> for your source code transformation approach.

I don't know what you have in mind, but ? only works on top-level terms
(statements, loop headers, etc), not nested expressions.

julia

>
> Regards,
> Markus
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
