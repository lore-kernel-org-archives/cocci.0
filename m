From: hofrat@osadl.org (Nicholas Mc Guire)
Date: Fri, 12 Jun 2015 19:09:39 +0200
Subject: [Cocci] [PATCH RFC V2] coccinelle: flag constants being passed for
	jiffies
Message-ID: <1434128979-2096-1-git-send-email-hofrat@osadl.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

A number of functions takes a jiffies value as timeout. Passing in a 
constant makes the timeout HZ dependent which is wrong. Checking for
coccinelle constants only yields many false positives so they are
filtered for digits only.

A numeric value of 1 is though commonly in use for "shortest possible
delay" so those cases are treated as false positives as well and not
reported.

Link: https://systeme.lip6.fr/pipermail/cocci/2015-May/002085.html
Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Note sure if a value of 2 should also be droped as false-positive
it seems to be in use in quite a few places - but I have not been able
to figure out a real rational for 2 jiffies...

V2: since sgen did not compile for me manually formated according to
    the tools/sgen/README - not really sure if I got it right.

The cases reported all look like they are actual API inconsistencies but
not reporting does not mean there is no bug with respect to jiffies. This
still can miss some values e.g. like in:
 drivers/staging/rts5208/rtsx_chip.h:66 #define POLLING_INTERVAL 30
 drivers/staging/rts5208/rtsx.c:540 schedule_timeout(POLLING_INTERVAL);

To be able to catch these cases an additional "strict" mode is added that
will list all C-constants except if HZ is used directly - this yields
some false positives so it is not on by default and will only print a
INFO message - not sure if this approach of adding a mode like this is 
actually ok.

Filtering by phython str rather than more precise rules is significantly 
faster in this case - see link above

 scripts/coccinelle/api/timeout_HZ_dependent.cocci |  123 +++++++++++++++++++++
 1 file changed, 123 insertions(+)
 create mode 100644 scripts/coccinelle/api/timeout_HZ_dependent.cocci

diff --git a/scripts/coccinelle/api/timeout_HZ_dependent.cocci b/scripts/coccinelle/api/timeout_HZ_dependent.cocci
new file mode 100644
index 0000000..9ec00cc
--- /dev/null
+++ b/scripts/coccinelle/api/timeout_HZ_dependent.cocci
@@ -0,0 +1,121 @@
+/// Check for hardcoded numeric timeout values which are thus HZ dependent
+//# only report findings if the value is digits and != 1 as hardcoded
+//# 1 seems to be in use for short delays.
+//#
+//# No patch mode for this, as converting the value from C to
+//# msecs_to_jiffies(C) could be changing the effective timeout by more
+//# than a factor of 10 so this always needs manual inspection Most notably
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
+virtual context
+virtual patch
+virtual org
+virtual report
+virtual strict
+
+ at cc depends on !patch && (context || org || report || strict)@
+constant C;
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
+      msg = "WARNING: timeout (%s) is HZ dependent" % (timeout)
+      coccilib.report.print_report(p[0], msg)
+elif (timeout != "HZ"):
+   msg = "INFO: timeout (%s) may be HZ dependent" % (timeout)
+   coccilib.report.print_report(p[0], msg)
-- 
1.7.10.4
