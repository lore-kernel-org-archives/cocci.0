From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 25 Aug 2017 15:05:15 +0200
Subject: [Cocci] Matching function prototypes and casts
In-Reply-To: <alpine.DEB.2.20.1708251353440.3191@hadrien>
References: <CAGXu5jK1Kufzuf17iwwz20G=j5yMMFJtYpP4ika56kifKW2OOg@mail.gmail.com>
 <8ee5f080-2b21-565a-cc6b-e49ba7b1e73f@users.sourceforge.net>
 <alpine.DEB.2.20.1708251353440.3191@hadrien>
Message-ID: <abc618f6-8de2-95e2-7c57-b495f9704866@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> You try to search for variations of a function call and an assignment to
>> a data structure member. It seems that they differ then by the usage of a cast
>> and the operator ?&?.
>> How do you think about to express such search criteria in a succinct way with
>> the help of the semantic patch language?
>>
>> I imagine that nested disjunctions or the SmPL operator ??? could be used
>> for your source code transformation approach.
> 
> I don't know what you have in mind,

Would the following design suggestion be usable?


@check_timer_function_usage@
expression _callback, E;
struct timer_list tl;
identifier _timer;
type _func, _data;
@@

(
*setup_timer(&E->_timer at tl, \((_func)\| \) \(&\| \) _callback, \((_data)\| \) E);
|
*E->_timer at tl.function = \((_func)\| \) \(&\| \) _callback;
)


I wonder that ?E? should be passed twice to the shown function call.


> but ? only works on top-level terms (statements, loop headers, etc), not nested expressions.

I assume that this functionality can occasionally be used more often.

Regards,
Markus
