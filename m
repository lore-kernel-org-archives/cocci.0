From: elena.reshetova@intel.com (Reshetova, Elena)
Date: Mon, 7 Aug 2017 11:06:14 +0000
Subject: [Cocci] [PATCH] Coccinelle: add atomic_as_refcounter script
In-Reply-To: <alpine.DEB.2.20.1708041720440.22068@hadrien>
References: <1500364111-2192-1-git-send-email-elena.reshetova@intel.com>
 <1500364111-2192-2-git-send-email-elena.reshetova@intel.com>
 <alpine.DEB.2.20.1708041720440.22068@hadrien>
Message-ID: <2236FBA76BA1254E88B949DDB74E612B6FF2E1DA@IRSMSX102.ger.corp.intel.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> On Tue, 18 Jul 2017, Elena Reshetova wrote:
> 
> > atomic_as_refcounter.cocci script allows detecting
> > cases when refcount_t type and API should be used
> > instead of atomic_t.
> >
> > Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
> > ---
> >  scripts/coccinelle/api/atomic_as_refcounter.cocci | 102
> ++++++++++++++++++++++
> >  1 file changed, 102 insertions(+)
> >  create mode 100644 scripts/coccinelle/api/atomic_as_refcounter.cocci
> >
> > diff --git a/scripts/coccinelle/api/atomic_as_refcounter.cocci
> b/scripts/coccinelle/api/atomic_as_refcounter.cocci
> > new file mode 100644
> > index 0000000..a16d395
> > --- /dev/null
> > +++ b/scripts/coccinelle/api/atomic_as_refcounter.cocci
> > @@ -0,0 +1,102 @@
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
> > +?y=a
> 
> This makes the line optional. And if it dosn't appear, there is no
> constraint on y.  So the rule matches:
> 
> int main() {
>   atomic64_dec_and_test(&(a)->x);
>   free(b);
> }
> 
> I would suggest to just make two rules, one with y=a and one without.

Oh, thank you for the catch! I was a bit afraid it might be the case, but when
I tried it in practice it didn't show up that many additional cases compare to
not having ?y=a at all (only 20 or so), and when I checked some, they looked
worth a manual check anyway and interesting. 

But I will fix the rule and send a new version!

Best Regards,
Elena.

> 
> julia
> 
> > +...
> > +(
> > + fname at p2(a, ...);
> > +|
> > + fname at p2(y, ...);
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
