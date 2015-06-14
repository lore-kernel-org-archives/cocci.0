From: der.herr@hofr.at (Nicholas Mc Guire)
Date: Sun, 14 Jun 2015 09:34:35 +0200
Subject: [Cocci] [PATCH RFC V2] coccinelle: flag constants being passed
	for	jiffies
In-Reply-To: <alpine.DEB.2.02.1506140900580.2085@localhost6.localdomain6>
References: <1434128979-2096-1-git-send-email-hofrat@osadl.org>
 <alpine.DEB.2.02.1506140900580.2085@localhost6.localdomain6>
Message-ID: <20150614073435.GA30149@opentech.at>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sun, 14 Jun 2015, Julia Lawall wrote:

> > + at script:python depends on report@
> > +p << cc.p;
> > +timeout << cc.C;
> > +@@
> > +
> > +if str.isdigit(timeout):
> > +   if (int(timeout) != 1):
> > +      msg = "WARNING: timeout (%s) seems HZ dependent" % (timeout)
> > +      coccilib.report.print_report(p[0], msg)
> 
> The parentheses in the warning messages around the timeouts seem a little
> strange to me.
>

should be \"%s\" I guess - will fix that and the other findings - just waiting
for feedback if it makes any sense at all to include something like this.
 
> Otherwise, as a semantic patch, it looks fine.  I can't judge the problem 
> being solved though.
>
it found aproximately 30 cases in the kernel some of which have been fixed
already and none seem to be false postitives - the hardcoded "2"
really being the only open issue if those should be counted as false-postitives
and filtered.

I'm not aware of any case in the kernel where the passing of a jiffies value
is intentionally HZ dependent - so I guess atleast warning on this
makes sense.

Anyway it might also make more sense to put something like this
into one of the build-bots rather than push it into mainline for general
use.

thx!
hofrat
