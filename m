From: elena.reshetova@intel.com (Reshetova, Elena)
Date: Tue, 15 Aug 2017 12:19:44 +0000
Subject: [Cocci] [PATCH] Coccinelle: add atomic_as_refcounter script
In-Reply-To: <alpine.DEB.2.20.1708141615160.26080@hadrien>
References: <1502690386-5605-1-git-send-email-elena.reshetova@intel.com>
 <1502690386-5605-2-git-send-email-elena.reshetova@intel.com>
 <alpine.DEB.2.20.1708141615160.26080@hadrien>
Message-ID: <2236FBA76BA1254E88B949DDB74E612B6FF45917@IRSMSX102.ger.corp.intel.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> On Mon, 14 Aug 2017, Elena Reshetova wrote:
> 
> > atomic_as_refcounter.cocci script allows detecting
> > cases when refcount_t type and API should be used
> > instead of atomic_t.
> >
> > Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
> > ---
> >  scripts/coccinelle/api/atomic_as_refcounter.cocci | 148
> ++++++++++++++++++++++
> >  1 file changed, 148 insertions(+)
> >  create mode 100644 scripts/coccinelle/api/atomic_as_refcounter.cocci
> >
> > diff --git a/scripts/coccinelle/api/atomic_as_refcounter.cocci
> b/scripts/coccinelle/api/atomic_as_refcounter.cocci
> > new file mode 100644
> > index 0000000..996d72b
> > --- /dev/null
> > +++ b/scripts/coccinelle/api/atomic_as_refcounter.cocci
> > @@ -0,0 +1,148 @@
> > +// Check if refcount_t type and API should be used
> > +// instead of atomic_t type when dealing with refcounters
> > +//
> > +// Copyright (c) 2016-2017, Elena Reshetova, Intel Corporation
> > +//
> > +// Confidence: Moderate
> > +// URL: http://coccinelle.lip6.fr/
> > +// Options: --include-headers --very-quiet
> > +
> > +virtual report
> > +
> > + at r1 exists@
> > +identifier a, x, y;
> > +position p1, p2;
> > +identifier fname =~ ".*free.*";
> > +identifier fname2 =~ ".*destroy.*";
> > +identifier fname3 =~ ".*del.*";
> > +identifier fname4 =~ ".*queue_work.*";
> > +identifier fname5 =~ ".*schedule_work.*";
> > +identifier fname6 =~ ".*call_rcu.*";
> > +
> > +@@
> > +
> > +(
> > + atomic_dec_and_test at p1(&(a)->x)
> > +|
> > + atomic_dec_and_lock at p1(&(a)->x, ...)
> > +|
> > + atomic_long_dec_and_lock at p1(&(a)->x, ...)
> > +|
> > + atomic_long_dec_and_test at p1(&(a)->x)
> > +|
> > + atomic64_dec_and_test at p1(&(a)->x)
> > +|
> > + local_dec_and_test at p1(&(a)->x)
> > +)
> > +...
> > +(
> > + fname at p2(a, ...);
> > +|
> > + fname2 at p2(...);
> > +|
> > + fname3 at p2(...);
> > +|
> > + fname4 at p2(...);
> > +|
> > + fname5 at p2(...);
> > +|
> > + fname6 at p2(...);
> > +)
> > +
> > +
> > + at script:python depends on report@
> > +p1 << r1.p1;
> > +p2 << r1.p2;
> > +@@
> > +msg = "atomic_dec_and_test variation before object free at line %s."
> > +coccilib.report.print_report(p1[0], msg % (p2[0].line))
> > +
> > + at r4 exists@
> > +identifier a, x, y;
> > +position p1, p2;
> > +identifier fname =~ ".*free.*";
> > +identifier fname2 =~ ".*destroy.*";
> > +identifier fname3 =~ ".*del.*";
> > +identifier fname4 =~ ".*queue_work.*";
> > +identifier fname5 =~ ".*schedule_work.*";
> > +identifier fname6 =~ ".*call_rcu.*";
> > +
> > +@@
> > +
> > +(
> > + atomic_dec_and_test at p1(&(a)->x)
> > +|
> > + atomic_dec_and_lock at p1(&(a)->x, ...)
> > +|
> > + atomic_long_dec_and_lock at p1(&(a)->x, ...)
> > +|
> > + atomic_long_dec_and_test at p1(&(a)->x)
> > +|
> > + atomic64_dec_and_test at p1(&(a)->x)
> > +|
> > + local_dec_and_test at p1(&(a)->x)
> > +)
> > +...
> > +y=a
> > +...
> > +(
> > + fname at p2(y, ...);
> > +|
> > + fname2 at p2(...);
> 
> From here to the end of the rule there is no a or y.  So they would match
> the same thing as in the previous rule.  so you could get rid of all of
> these cases, and just leave fname at p2(y, ...);

True, stupid of me :(
Will fix. 

Best Regards,
Elena.

> 
> julia
> 
> > +|
> > + fname3 at p2(...);
> > +|
> > + fname4 at p2(...);
> > +|
> > + fname5 at p2(...);
> > +|
> > + fname6 at p2(...);
> > +)
> > +
> > +
> > + at script:python depends on report@
> > +p1 << r4.p1;
> > +p2 << r4.p2;
> > +@@
> > +msg = "atomic_dec_and_test variation before object free at line %s."
> > +coccilib.report.print_report(p1[0], msg % (p2[0].line))
> > +
> > + at r2 exists@
> > +identifier a, x;
> > +position p1;
> > +@@
> > +
> > +(
> > +atomic_add_unless(&(a)->x,-1,1)@p1
> > +|
> > +atomic_long_add_unless(&(a)->x,-1,1)@p1
> > +|
> > +atomic64_add_unless(&(a)->x,-1,1)@p1
> > +)
> > +
> > + at script:python depends on report@
> > +p1 << r2.p1;
> > +@@
> > +msg = "atomic_add_unless"
> > +coccilib.report.print_report(p1[0], msg)
> > +
> > + at r3 exists@
> > +identifier x;
> > +position p1;
> > +@@
> > +
> > +(
> > +x = atomic_add_return at p1(-1, ...);
> > +|
> > +x = atomic_long_add_return at p1(-1, ...);
> > +|
> > +x = atomic64_add_return at p1(-1, ...);
> > +)
> > +
> > + at script:python depends on report@
> > +p1 << r3.p1;
> > +@@
> > +msg = "x = atomic_add_return(-1, ...)"
> > +coccilib.report.print_report(p1[0], msg)
> > +
> > +
> > --
> > 2.7.4
> >
> >
