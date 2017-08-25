From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 25 Aug 2017 12:47:52 +0200
Subject: [Cocci] Matching function prototypes and casts
In-Reply-To: <CAGXu5jK1Kufzuf17iwwz20G=j5yMMFJtYpP4ika56kifKW2OOg@mail.gmail.com>
References: <CAGXu5jK1Kufzuf17iwwz20G=j5yMMFJtYpP4ika56kifKW2OOg@mail.gmail.com>
Message-ID: <8ee5f080-2b21-565a-cc6b-e49ba7b1e73f@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> (
> -setup_timer(&_E->_timer at _e, _callback, _E);
> |
?
> -_E->_timer at _e.function = (_cast_func)&_callback;
> )

You try to search for variations of a function call and an assignment to
a data structure member. It seems that they differ then by the usage of a cast
and the operator ?&?.
How do you think about to express such search criteria in a succinct way with
the help of the semantic patch language?

I imagine that nested disjunctions or the SmPL operator ??? could be used
for your source code transformation approach.

Regards,
Markus
