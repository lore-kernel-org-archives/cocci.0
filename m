From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 13 Dec 2016 16:10:09 +0100 (CET)
Subject: [Cocci] [PATCH] Coccinelle: uslee_range: ensure delta not zero
In-Reply-To: <20161213123128.GB7866@osadl.at>
References: <1481624600-29057-1-git-send-email-hofrat@osadl.org>
 <alpine.DEB.2.10.1612131307550.3207@hadrien> <20161213123128.GB7866@osadl.at>
Message-ID: <alpine.DEB.2.10.1612131609400.3099@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 13 Dec 2016, Nicholas Mc Guire wrote:

> On Tue, Dec 13, 2016 at 01:09:38PM +0100, Julia Lawall wrote:
> >
> >
> > On Tue, 13 Dec 2016, Nicholas Mc Guire wrote:
> >
> > > usleep_range() min==max makes little sense at last for non-RT, so issue
> > > a warning if delta is 0.
> > >
> > > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > > ---
> > >
> > > As of 4.9.0 this finds about 20 cases - all of which look like the
> > > should be passing a range.
> > >
> > > Patch is against 4.9.0 (localversion-next is next-20161213)
> > >
> > >  scripts/coccinelle/api/bad_usleep_range.cocci | 55 +++++++++++++++++++++++++++
> > >  1 file changed, 55 insertions(+)
> > >  create mode 100644 scripts/coccinelle/api/bad_usleep_range.cocci
> > >
> > > diff --git a/scripts/coccinelle/api/bad_usleep_range.cocci b/scripts/coccinelle/api/bad_usleep_range.cocci
> > > new file mode 100644
> > > index 0000000..7e05f3e
> > > --- /dev/null
> > > +++ b/scripts/coccinelle/api/bad_usleep_range.cocci
> > > @@ -0,0 +1,55 @@
> > > +/// bad uslee_range - warn if min == max
> > > +//
> > > +//The problem is that usleep_range is calculating the delay by
> > > +//      exp = ktime_add_us(ktime_get(), min)
> > > +//      delta = (u64)(max - min) * NSEC_PER_USEC
> > > +//so delta is set to 0 if min==max
> > > +//and then calls
> > > +//      schedule_hrtimeout_range(exp, 0,...)
> > > +//effectively this means that the clock subsystem has no room to
> > > +//optimize. usleep_range() is in non-atomic context so a 0 range
> > > +//makes very little sense as the task can be preempted anyway so
> > > +//there is no guarantee that the 0 range would be adding much
> > > +//precision - it just removes optimization potential, so it probably
> > > +//never really makes sense for any non-RT systems.
> > > +//
> > > +//see: Documentation/timers/timers-howto.txt and
> > > +//Link: http://lkml.org/lkml/2016/11/29/54 for some notes on
> > > +//      when mdelay might not be a suitable replacement
> > > +//
> > > +// Confidence: Moderate
> > > +// Copyright: (C) 2016 Nicholas Mc Guire, OSADL.  GPLv2.
> > > +// Comments:
> > > +// Options: --no-includes --include-headers
> > > +
> > > +virtual org
> > > +virtual report
> > > +
> > > + at nullrange@
> > > +expression E;
> > > +constant C;
> > > +position p;
> > > +@@
> > > +
> > > +<+...
> > > +(
> > > +  usleep_range at p(C,C)
> > > +|
> > > +  usleep_range at p(E,E)
> > > +)
> > > +...+>
> >
> > The outer <+... ...+> is not needed.
> >
> > You could support context too.
> >
> > The E,E case subsumes the C,C case.  Unless you want to put different
> > messages for the two cases, there is no need for both of them.
> >
> ok will kick that - in my script I was also doing range checks
> on constants to distinuish between the udelay range < 10us and
> the msleep* range > 10ms - but that is not as clear a case as the
> min==max case - will remove the constant case - the unnecessary
> <+... ...+> just means I still did not understand when it is actually needed
> will remove that as well.

<+... ...+> is most useful when inside { }

julia
