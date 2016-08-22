From: hofrat@osadl.org (Nicholas Mc Guire)
Date: Mon, 22 Aug 2016 19:12:32 +0200
Subject: [Cocci] [PATCH V3] coccinelle: flag HZ dependent constants being
	passed for jiffies
Message-ID: <1471885952-26048-1-git-send-email-hofrat@osadl.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

A large set of calls in the kernel takes jiffies as an argument - passing
in a constant makes the timeout HZ dependent which is wrong in all cases
found by this spatch and probably is wrong for any call that expects
jiffies with the exception of passing in 1 (minimum delay).

Checking for constants only yields many false positives so they are
filtered for digits only. A numeric value of 1 is though commonly in use
for "shortest possible delay" so those cases are treated as false
positives as well and not reported.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

V2: fixed up the documentation

V3: change constant C; to constant int C; as suggested by Julia Lawall

Note that 2 jiffies also is quite popular - not clear why and it will be 
reported - it might be necessary to filter that out as false positive as 
well. Strict mode shows all used constants and it seems that quite a few
of them actually would need to be converted as well - but currently no
obvious way (other than manually) to check such constants.

This patch was tested with coccinelle version 1.0.5

patch is against linux-next (localversion-next is next-20160822)

 scripts/coccinelle/api/timeout_HZ_dependent.cocci | 126 ++++++++++++++++++++++
 1 file changed, 126 insertions(+)
 create mode 100644 scripts/coccinelle/api/timeout_HZ_dependent.cocci

diff --git a/scripts/coccinelle/api/timeout_HZ_dependent.cocci b/scripts/coccinelle/api/timeout_HZ_dependent.cocci
new file mode 100644
index 0000000..f0fbf2c
--- /dev/null
+++ b/scripts/coccinelle/api/timeout_HZ_dependent.cocci
@@ -0,0 +1,126 @@
+/// Check for hard-coded numeric timeout values which are thus HZ dependent
+//# Only report findings if the value is digits and != 1 as hard-coded
+//# 1 seems to be in use for short delays.
+//#
+//# For kernel API that expects jiffies to be passed in a hard-coded value
+//# makes the effective timeout dependent on the compile-time HZ setting
+//# which is wrong in most (all?) cases. Any timeout should be passed
+//# through msecs_to_jiffies() or usecs_to_jiffies() to make the timeout
+//# values HZ independent.
+//#
+//# No patch mode for this, as converting the value from C to
+//# msecs_to_jiffies(C) could be changing the effective timeout by more
+//# than a factor of 10 so this always needs manual inspection. Most notably
+//# code that pre-dates variable HZ (prior to 2.4 kernel series) had HZ=100
+//# so a constant of 10 should be converted to 100ms for any old driver.
+//#
+//# In some cases C-constants are passed in that are not converted to
+//# jiffies, to locate these cases run in MODE=strict in which case these
+//# will also be reported except if HZ is passed. Note though many are
+//# likely to be false positives !
+//
+// Confidence: Medium
+// Copyright: (C) 2015 Nicholas Mc Guire <hofrat@osadl.org>, OSADL, GPL v2
+// URL: http://coccinelle.lip6.fr
+// Options: --no-includes --include-headers
+
+virtual org
+virtual report
+virtual strict
+virtual patch
+
+ at cc depends on !patch && (org || report || strict)@
+constant int C;
+position p;
+@@
+
+(
+schedule_timeout at p(C)
+|
+schedule_timeout_interruptible at p(C)
+|
+schedule_timeout_killable at p(C)
+|
+schedule_timeout_uninterruptible at p(C)
+|
+mod_timer(...,C)
+|
+mod_timer_pinned(...,C)
+|
+mod_timer_pending(...,C)
+|
+apply_slack(...,C)
+|
+queue_delayed_work(...,C)
+|
+mod_delayed_work(...,C)
+|
+schedule_delayed_work_on(...,C)
+|
+schedule_delayed_work(...,C)
+|
+schedule_timeout(C)
+|
+schedule_timeout_interruptible(C)
+|
+schedule_timeout_killable(C)
+|
+schedule_timeout_uninterruptibl(C)
+|
+wait_event_timeout(...,C)
+|
+wait_event_interruptible_timeout(...,C)
+|
+wait_event_uninterruptible_timeout(...,C)
+|
+wait_event_interruptible_lock_irq_timeout(...,C)
+|
+wait_on_bit_timeout(...,C)
+|
+wait_for_completion_timeout(...,C)
+|
+wait_for_completion_io_timeout(...,C)
+|
+wait_for_completion_interruptible_timeout(...,C)
+|
+wait_for_completion_killable_timeout(...,C)
+)
+
+ at script:python depends on org@
+p << cc.p;
+timeout << cc.C;
+@@
+
+# schedule_timeout(1) for a "short" delay is not really HZ dependent
+# as it always would be converted to 1 by msecs_to_jiffies as well
+# so count this as false positive
+if str.isdigit(timeout):
+   if (int(timeout) != 1):
+      msg = "WARNING: timeout is HZ dependent"
+      coccilib.org.print_safe_todo(p[0], msg)
+
+ at script:python depends on report@
+p << cc.p;
+timeout << cc.C;
+@@
+
+if str.isdigit(timeout):
+   if (int(timeout) != 1):
+      msg = "WARNING: timeout (%s) seems HZ dependent" % (timeout)
+      coccilib.report.print_report(p[0], msg)
+
+@script:python depends on strict@
+p << cc.p;
+timeout << cc.C;
+@@
+
+# "strict" mode prints the cases that use C-constants != HZ
+# as well as the numeric constants != 1. This will deliver a false
+# positives if the C-constant is already in jiffies !
+if str.isdigit(timeout):
+   if (int(timeout) != 1):
+      msg = "WARNING: timeout %s is HZ dependent" % (timeout)
+      coccilib.report.print_report(p[0], msg)
+elif (timeout != "HZ"):
+   msg = "INFO: timeout %s may be HZ dependent" % (timeout)
+   coccilib.report.print_report(p[0], msg)
-- 
2.1.4
