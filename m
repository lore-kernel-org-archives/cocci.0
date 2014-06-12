From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 12 Jun 2014 12:49:34 +0200 (CEST)
Subject: [Cocci] [patch 04/13] net: mac80211: Use ktime_get_ts()
In-Reply-To: <20140612115134.205432hq8ztc6pt2@webmail.lip6.fr>
References: <20140611234024.103571777@linutronix.de>
 <20140611234607.020125642@linutronix.de>
 <1402556024.4224.2.camel@jlt4.sipsolutions.net>
 <CAB=NE6UqxX=K2iZhHQBmMU4wTBmAmj7KbnJBktepB8+JJn0LDQ@mail.gmail.com>
 <20140612115134.205432hq8ztc6pt2@webmail.lip6.fr>
Message-ID: <alpine.DEB.2.10.1406121236140.5170@nanos>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 12 Jun 2014, Julia.Lawall at lip6.fr wrote:

> "Luis R. Rodriguez" <mcgrof@do-not-panic.com> a ?crit?:
> 
> > On Wed, Jun 11, 2014 at 11:53 PM, Johannes Berg
> > <johannes@sipsolutions.net> wrote:
> > > On Wed, 2014-06-11 at 23:59 +0000, Thomas Gleixner wrote:
> > > 
> > > > do_posix_clock_monotonic_gettime() is a leftover from the initial
> > > > posix timer implementation which maps to ktime_get_ts().
> > > 
> > > I didn't even know we *had* such code, heh.
> > 
> > If we want want maintainers to police this stuff we can add an SmPL
> > rule for this upstream and have maintainer use 'make coccicheck
> > M=path/'. The way of the future. The way of the future...
> 
> If I could have a little more context, I can do something.

I already killed all instances of do_posix_clock_monotonic_gettime().
The define will be gone soon, so nothing to worry about.

Thanks,

	tglx
