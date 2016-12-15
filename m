From: der.herr@hofr.at (Nicholas Mc Guire)
Date: Thu, 15 Dec 2016 06:16:24 +0000
Subject: [Cocci] [PATCH V2] Coccinelle: check usleep_range() usage
In-Reply-To: <alpine.DEB.2.10.1612150649470.3568@hadrien>
References: <1481769711-14793-1-git-send-email-hofrat@osadl.org>
 <alpine.DEB.2.10.1612150649470.3568@hadrien>
Message-ID: <20161215061624.GA23684@osadl.at>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, Dec 15, 2016 at 06:52:28AM +0100, Julia Lawall wrote:
> 
> 
> On Thu, 15 Dec 2016, Nicholas Mc Guire wrote:
> 
> > Documentation/timers/timers-howto.txt outlines the intended usage of
> > usleep_range(), this spatch tries to locate missuse/out-of-spec cases.
> >
> > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > ---
> > V2: added context mode as suggested by Julia Lawall <julia.lawall@lip6.fr>
> >     added min<max case sugested by Joe Perches <joe@perches.com>
> >     added in the range checks as they are resonably reliable based on
> >     a review of all 1648 call sites of usleep_range()
> >
> > 1648 calls total
> > 1488 pass numeric values only (90.29%)
> >   27 min below 10us (1.81%)
> >   40 min above 10ms (2.68%)
> >      min out of spec 4.50%
> >   76 preprocessor constants (4.61%)
> >    1 min below 10us (1.31%)
> >    8 min above 10ms (10.52%)
> >      min out of spec 11.84%
> >   85 expressions (5.15%)
> > 1(0) min below 10us (1.50%)*
> > 6(2) min above 10ms (7.50%)*
> >      min out of spec 9.0%
> > Errors:
> >   23 where min==max  (1.39%)
> >    0 where max < min (0.00%)
> >
> > Total:
> >   Bugs: 6.48%-10.70%*
> >   Crit: 3.09%-3.15%* (min < 10, min==max, max < min)
> >   Detectable by coccinelle:
> >   Bugs: 74/103 (71.8%)
> >   Crit: 50/52 (96.1%)
> > * numbers estimated based on code review
> >
> > Patch is againts 4.9.0 (localversion-next is next-20161214)
> >
> >  scripts/coccinelle/api/bad_usleep_range.cocci | 88 +++++++++++++++++++++++++++
> >  1 file changed, 88 insertions(+)
> >  create mode 100644 scripts/coccinelle/api/bad_usleep_range.cocci
> >
> > diff --git a/scripts/coccinelle/api/bad_usleep_range.cocci b/scripts/coccinelle/api/bad_usleep_range.cocci
> > new file mode 100644
> > index 0000000..003e9ef
> > --- /dev/null
> > +++ b/scripts/coccinelle/api/bad_usleep_range.cocci
> > @@ -0,0 +1,88 @@
> > +/// report bad/problematic usleep_range usage
> > +//
> > +// This is a checker for the documented intended use of usleep_range
> > +// see: Documentation/timers/timers-howto.txt and
> > +// Link: http://lkml.org/lkml/2016/11/29/54 for some notes on
> > +//       when mdelay might not be a suitable replacement
> > +//
> > +// Limitations:
> > +//  * The numeric limits are only checked when numeric constants are in
> > +//    use (as of 4.9.0 thats 90.29% of the calls) no constant folding
> > +//    is done - so this can miss some out-of-range cases - but in 4.9.0
> > +//    it was catching 74 of the 103 bad cases (71.8%) and 50 of 52
> > +//    (96.1%) of the critical cases (min < 10 and min==max - there
> > +//  * There may be RT use-cases where both min < 10 and min==max)
> > +//    justified (e.g. high-throughput drivers on a shielded core)
> > +//
> > +// 1) warn if min == max
> > +//
> > +//  The problem is that usleep_range is calculating the delay by
> > +//      exp = ktime_add_us(ktime_get(), min)
> > +//      delta = (u64)(max - min) * NSEC_PER_USEC
> > +//  so delta is set to 0 if min==max
> > +//  and then calls
> > +//      schedule_hrtimeout_range(exp, 0,...)
> > +//  effectively this means that the clock subsystem has no room to
> > +//  optimize. usleep_range() is in non-atomic context so a 0 range
> > +//  makes very little sense as the task can be preempted anyway so
> > +//  there is no guarantee that the 0 range would be adding much
> > +//  precision - it just removes optimization potential, so it probably
> > +//  never really makes sense.
> > +//
> > +// 2) warn if min < 10 or min > 20ms
> > +//
> > +//  it makes little sense to use a non-atomic call for very short
> > +//  delays because the scheduling jitter will most likely exceed
> > +//  this limit - udelay() makes more sense in that case. For very
> > +//  large delays using hrtimers is useless as preemption becomes
> > +//  quite likely resulting in high inaccuracy anyway - so use
> > +//  jiffies based msleep and don't burden the hrtimer subsystem.
> > +//
> > +// 3) warn if max < min
> > +//
> > +//  Joe Perches <joe@perches.com> added a check for this case
> > +//  that is definitely wrong.
> > +//
> > +// Confidence: Moderate
> > +// Copyright: (C) 2016 Nicholas Mc Guire, OSADL.  GPLv2.
> > +// Comments:
> > +// Options: --no-includes --include-headers
> > +
> > +virtual org
> > +virtual report
> > +virtual context
> > +
> > + at nullrangectx depends on context@
> > +expression E1,E2;
> > +position p;
> > +@@
> > +
> > +* usleep_range at p(E1,E2)
> 
> This is going to give a context warning on every call to usleep_range.
> Why not E1,E1?
yes this triggers on all use of usleep_ranges - as the report mode is
checking for more than just min==max I thought its resonable to simply
report all cases - maybe not.
Not sure if it makes sense to add in the filter from below,

Thre actually are quite a few bad use patters beyond these basic ones
like
                unsigned long timeout = jiffies + msecs_to_jiffies(250);

-               while (time_before(jiffies, timeout)) {
                        value = fpci_readl(tegra, XUSB_CFG_ARU_MBOX_OWNER);
                        if (value == MBOX_OWNER_NONE)
                                break;

-                       usleep_range(10, 20);
                }

> 
> > +
> > +
> > + at nullrange@
> > +expression E1,E2;
> > +position p;
> > +@@
> > +
> > +  usleep_range at p(E1,E2)
> > +
> > + at script:python depends on !context@
> > +p << nullrange.p;
> > +min << nullrange.E1;
> > +max << nullrange.E2;
> > +@@
> > +
> > +if(min == max):
> > +   msg = "WARNING: usleep_range min == max (%s) - consider delta " % (min)
> > +   coccilib.report.print_report(p[0], msg)
> > +if str.isdigit(min):
> 
> I guess this checks if min is a constant, but doesn't the last case also
> need to check if max is a constant?
>
yes it does - seems that there simply was no
such case so it went unnoticed.

also just noticed that the org mode would also be using 
coccilib.report rather than coccilib.org...

thx!
hofrat
 
