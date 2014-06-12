From: Julia.Lawall@lip6.fr (Julia.Lawall at lip6.fr)
Date: Thu, 12 Jun 2014 11:51:34 +0200
Subject: [Cocci] [patch 04/13] net: mac80211: Use ktime_get_ts()
In-Reply-To: <CAB=NE6UqxX=K2iZhHQBmMU4wTBmAmj7KbnJBktepB8+JJn0LDQ@mail.gmail.com>
References: <20140611234024.103571777@linutronix.de>
 <20140611234607.020125642@linutronix.de>
 <1402556024.4224.2.camel@jlt4.sipsolutions.net>
 <CAB=NE6UqxX=K2iZhHQBmMU4wTBmAmj7KbnJBktepB8+JJn0LDQ@mail.gmail.com>
Message-ID: <20140612115134.205432hq8ztc6pt2@webmail.lip6.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

"Luis R. Rodriguez" <mcgrof@do-not-panic.com> a ?crit?:

> On Wed, Jun 11, 2014 at 11:53 PM, Johannes Berg
> <johannes@sipsolutions.net> wrote:
>> On Wed, 2014-06-11 at 23:59 +0000, Thomas Gleixner wrote:
>>
>>> do_posix_clock_monotonic_gettime() is a leftover from the initial
>>> posix timer implementation which maps to ktime_get_ts().
>>
>> I didn't even know we *had* such code, heh.
>
> If we want want maintainers to police this stuff we can add an SmPL
> rule for this upstream and have maintainer use 'make coccicheck
> M=path/'. The way of the future. The way of the future...

If I could have a little more context, I can do something.

julia

>
>   Luis
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
