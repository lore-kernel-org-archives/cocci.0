From: elena.reshetova@intel.com (Elena Reshetova)
Date: Tue, 18 Jul 2017 10:48:31 +0300
Subject: [Cocci] [PATCH] Coccinelle: add atomic_as_refcounter script
In-Reply-To: <1500364111-2192-1-git-send-email-elena.reshetova@intel.com>
References: <1500364111-2192-1-git-send-email-elena.reshetova@intel.com>
Message-ID: <1500364111-2192-2-git-send-email-elena.reshetova@intel.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

atomic_as_refcounter.cocci script allows detecting
cases when refcount_t type and API should be used
instead of atomic_t.

Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
---
 scripts/coccinelle/api/atomic_as_refcounter.cocci | 102 ++++++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 scripts/coccinelle/api/atomic_as_refcounter.cocci

diff --git a/scripts/coccinelle/api/atomic_as_refcounter.cocci b/scripts/coccinelle/api/atomic_as_refcounter.cocci
new file mode 100644
index 0000000..a16d395
--- /dev/null
+++ b/scripts/coccinelle/api/atomic_as_refcounter.cocci
@@ -0,0 +1,102 @@
+// Check if refcount_t type and API should be used
+// instead of atomic_t type when dealing with refcounters
+//
+// Copyright (c) 2016-2017, Elena Reshetova, Intel Corporation
+//
+// Confidence: Moderate
+// URL: http://coccinelle.lip6.fr/
+// Options: --include-headers --very-quiet
+
+virtual report
+
+ at r1 exists@
+identifier a, x, y;
+position p1, p2;
+identifier fname =~ ".*free.*";
+identifier fname2 =~ ".*destroy.*";
+identifier fname3 =~ ".*del.*";
+identifier fname4 =~ ".*queue_work.*";
+identifier fname5 =~ ".*schedule_work.*";
+identifier fname6 =~ ".*call_rcu.*";
+
+@@
+
+(
+ atomic_dec_and_test at p1(&(a)->x)
+|
+ atomic_dec_and_lock at p1(&(a)->x, ...)
+|
+ atomic_long_dec_and_lock at p1(&(a)->x, ...)
+|
+ atomic_long_dec_and_test at p1(&(a)->x)
+|
+ atomic64_dec_and_test at p1(&(a)->x)
+|
+ local_dec_and_test at p1(&(a)->x)
+)
+...
+?y=a
+...
+(
+ fname at p2(a, ...);
+|
+ fname at p2(y, ...);
+|
+ fname2 at p2(...);
+|
+ fname3 at p2(...);
+|
+ fname4 at p2(...);
+|
+ fname5 at p2(...);
+|
+ fname6 at p2(...);
+)
+
+
+ at script:python depends on report@
+p1 << r1.p1;
+p2 << r1.p2;
+@@
+msg = "atomic_dec_and_test variation before object free at line %s."
+coccilib.report.print_report(p1[0], msg % (p2[0].line))
+
+@r2 exists@
+identifier a, x;
+position p1;
+@@
+
+(
+atomic_add_unless(&(a)->x,-1,1)@p1
+|
+atomic_long_add_unless(&(a)->x,-1,1)@p1
+|
+atomic64_add_unless(&(a)->x,-1,1)@p1
+)
+
+ at script:python depends on report@
+p1 << r2.p1;
+@@
+msg = "atomic_add_unless"
+coccilib.report.print_report(p1[0], msg)
+
+ at r3 exists@
+identifier x;
+position p1;
+@@
+
+(
+x = atomic_add_return at p1(-1, ...);
+|
+x = atomic_long_add_return at p1(-1, ...);
+|
+x = atomic64_add_return at p1(-1, ...);
+)
+
+@script:python depends on report@
+p1 << r3.p1;
+@@
+msg = "x = atomic_add_return(-1, ...)"
+coccilib.report.print_report(p1[0], msg)
+
+
-- 
2.7.4
