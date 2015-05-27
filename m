From: hofrat@osadl.org (Nicholas Mc Guire)
Date: Wed, 27 May 2015 21:28:28 +0200
Subject: [Cocci] [PATCH RFC] coccinelle: flag constants being passed for
	jiffies
Message-ID: <1432754908-8297-1-git-send-email-hofrat@osadl.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

schedule_timeout_* takes a jiffies value as timeout - passing in a constant
makes the timeout HZ dependent which is wrong. Checking for contstants only
yields many false positives so they are filtered for digits only. A numeric
value of 1 is though commonly in use for "shortest possible delay" so those
cases are treated as false positives as well and not reported.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

The cases reported all look like they are actual API inconsistencies but
not reporting does not mean there is no bug with respect to jiffies. This
still can miss some values e.g. like in:
 drivers/staging/rts5208/rtsx_chip.h:66 #define POLLING_INTERVAL 30
 drivers/staging/rts5208/rtsx.c:540 schedule_timeout(POLLING_INTERVAL);

For schedule_timeout_*() it reports 23 cases - all of which look like 
they are correct findings. 

Further the list of functions taking jiffies as arguments is much longer
but they can be added once the basic script is sound - which it probably
is not at this point.

 scripts/coccinelle/api/timeout_HZ_dependent.cocci |   62 +++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 scripts/coccinelle/api/timeout_HZ_dependent.cocci

diff --git a/scripts/coccinelle/api/timeout_HZ_dependent.cocci b/scripts/coccinelle/api/timeout_HZ_dependent.cocci
new file mode 100644
index 0000000..6e98da1
--- /dev/null
+++ b/scripts/coccinelle/api/timeout_HZ_dependent.cocci
@@ -0,0 +1,62 @@
+/* check for hardcoded timeout values which are thus HZ dependent
+ * only report findings if the value is digits and != 1 as hardcoded
+ * 1 seems to be in use for short delays.
+ *
+ * No patch mode for this as converting the value from C to
+ * msecs_to_jiffies(C) could be changing the effective timeout by
+ * more than a factor of 10 so this always needs manual inspection
+ *
+ * Options:  --no-includes --include-headers
+ */
+virtual context
+virtual patch
+virtual org
+virtual report
+
+ at ep depends on !patch && (org || report)@
+identifier f;
+constant C;
+position p1,p2;
+@@
+
+f at p1(...) {
+ <+...
+(
+* schedule_timeout at p2(C)
+|
+* schedule_timeout_interruptible at p2(C)
+|
+* schedule_timeout_killable at p2(C)
+|
+* schedule_timeout_uninterruptible@p2(C)
+)
+ ...+>
+}
+
+ at script:python depends on org@
+p1 << ep.p1;
+p2 << ep.p2;
+timeout << ep.C;
+@@
+
+# schedule_timeout(1) for a "short" delay is not HZ dependent
+# as it always would be converted to 1 by msecs_to_jiffies as well
+# so count this as false positive
+if str.isdigit(timeout):
+   if (int(timeout) != 1):
+      msg="WARNING: timeout is HZ dependent"
+      coccilib.org.print_todo(p2[0], msg)
+
+@script:python depends on report@
+p1 << ep.p1;
+p2 << ep.p2;
+timeout << ep.C;
+@@
+
+# schedule_timeout(1) for a "short" delay is not HZ dependent
+# as it always would be converted to 1 by msecs_to_jiffies as well
+# so count this as false positive
+if str.isdigit(timeout):
+   if (int(timeout) != 1):
+      msg="WARNING: timeout (%s) seems HZ dependent" % (timeout)
+      coccilib.report.print_report(p2[0], msg)
-- 
1.7.10.4
