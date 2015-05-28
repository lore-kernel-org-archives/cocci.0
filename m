From: der.herr@hofr.at (Nicholas Mc Guire)
Date: Thu, 28 May 2015 10:19:11 +0200
Subject: [Cocci] [PATCH RFC] coccinelle: flag constants being passed	for
	jiffies
In-Reply-To: <alpine.DEB.2.02.1505280744580.2027@localhost6.localdomain6>
References: <1432754908-8297-1-git-send-email-hofrat@osadl.org>
 <alpine.DEB.2.02.1505280744580.2027@localhost6.localdomain6>
Message-ID: <20150528081911.GA14288@opentech.at>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 28 May 2015, Julia Lawall wrote:

> 
> 
> On Wed, 27 May 2015, Nicholas Mc Guire wrote:
> 
> > schedule_timeout_* takes a jiffies value as timeout - passing in a constant
> > makes the timeout HZ dependent which is wrong. Checking for contstants only
> > yields many false positives so they are filtered for digits only. A numeric
> > value of 1 is though commonly in use for "shortest possible delay" so those
> > cases are treated as false positives as well and not reported.
> > 
> > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > ---
> > 
> > The cases reported all look like they are actual API inconsistencies but
> > not reporting does not mean there is no bug with respect to jiffies. This
> > still can miss some values e.g. like in:
> >  drivers/staging/rts5208/rtsx_chip.h:66 #define POLLING_INTERVAL 30
> >  drivers/staging/rts5208/rtsx.c:540 schedule_timeout(POLLING_INTERVAL);
> > 
> > For schedule_timeout_*() it reports 23 cases - all of which look like 
> > they are correct findings. 
> > 
> > Further the list of functions taking jiffies as arguments is much longer
> > but they can be added once the basic script is sound - which it probably
> > is not at this point.
> > 
> >  scripts/coccinelle/api/timeout_HZ_dependent.cocci |   62 +++++++++++++++++++++
> >  1 file changed, 62 insertions(+)
> >  create mode 100644 scripts/coccinelle/api/timeout_HZ_dependent.cocci
> > 
> > diff --git a/scripts/coccinelle/api/timeout_HZ_dependent.cocci b/scripts/coccinelle/api/timeout_HZ_dependent.cocci
> > new file mode 100644
> > index 0000000..6e98da1
> > --- /dev/null
> > +++ b/scripts/coccinelle/api/timeout_HZ_dependent.cocci
> > @@ -0,0 +1,62 @@
> > +/* check for hardcoded timeout values which are thus HZ dependent
> > + * only report findings if the value is digits and != 1 as hardcoded
> > + * 1 seems to be in use for short delays.
> > + *
> > + * No patch mode for this as converting the value from C to
> > + * msecs_to_jiffies(C) could be changing the effective timeout by
> > + * more than a factor of 10 so this always needs manual inspection
> > + *
> > + * Options:  --no-includes --include-headers
> > + */
> > +virtual context
> > +virtual patch
> > +virtual org
> > +virtual report
> > +
> > + at ep depends on !patch && (org || report)@
> > +identifier f;
> > +constant C;
> > +position p1,p2;
> > +@@
> > +
> > +f at p1(...) {
> 
> Do you need the function for anything?  This would be more efficient with 
> just the calls.
>

nop - just forgot to remove it - thanks !
 
> 
> > + <+...
> > +(
> > +* schedule_timeout at p2(C)
> 
> If you put in the argument list \(i\|1\|C at p2\) then you can get rid of the 
> python code (i would be an identifier metavariable).

*schedule_timeout(\(i\|1\|C at p\))
works but it is a lot slower than handling it with those 2 lines of
python script - about 75min vs. 1min 30sec ?

> 
> What kind of false positives do you get for the macro case?  Would it be 
> sufficient to do:
> 
> @r@
> expression e != 1;
> identifier i,
> @@
> 
> #define i e
> 
> @@
> identifier r.i,
> @@
> 
> *schedule_timeout(i)
> 
> (and all the other cases?)
>
this will work but has the same problem as (C at p) it will report
false positives like
  ./arch/x86/kernel/apm_32.c:1440:19-36: WARNING: timeout (APM_CHECK_TIMEOUT) is HZ dependent

with
  #define APM_CHECK_TIMEOUT       (HZ)
this is not a bug.

and its also a lot slower than the brute force version with str.isdigit

thx!
hofrat
 
