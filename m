From: hofrat@osadl.org (Nicholas Mc Guire)
Date: Thu,  7 Jan 2016 21:17:58 +0100
Subject: [Cocci] [PATCH RFC] coccinelle: flag double conversions in msleep*
Message-ID: <1452197878-26296-1-git-send-email-hofrat@osadl.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This spatch flags cases where msleep/msleep_interruptible converts the
timeout parameter with jiffies_to_msecs(). msleep* performs a conversion
of the milliseconds passed in back to jiffies and then calls the
appropriate schedule_timeout* variant.

In cases where the timeout is constant, there is effectively no 
difference with respect to the generated code (atleast not for the x86
.lst files of a few cases checked) but for cases where the timeout is 
non-constant there is an actual call to jiffies_to_msecs() at runtime, 
that overhead can be removed.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

As of linux-next next-20160107 it finds 24 cases in the kernel

An example of where this makes a slight code difference is
drivers/scsi/osst.c:osst_wait_ready()
<        if (initial_delay > 0)
<    2293:       7e 0f                   jle    22a4 <osst_wait_ready+0x34>
<                msleep(jiffies_to_msecs(initial_delay));
<    2295:       48 63 f9                movslq %ecx,%rdi
<    2298:       e8 00 00 00 00          callq  229d <osst_wait_ready+0x2d>
<                        2299: R_X86_64_PC32     jiffies_to_msecs-0x4
<    229d:       89 c7                   mov    %eax,%edi
<    229f:       e8 00 00 00 00          callq  22a4 <osst_wait_ready+0x34>
<                        22a0: R_X86_64_PC32     msleep-0x4
<
<        memset(cmd, 0, MAX_COMMAND_SIZE);

vs:                                                                             

>        if (initial_delay > 0)
>    2293:       7e 08                   jle    229d <osst_wait_ready+0x2d>
>                schedule_timeout_uninterruptible(initial_delay);
>    2295:       48 63 f9                movslq %ecx,%rdi
>    2298:       e8 00 00 00 00          callq  229d <osst_wait_ready+0x2d>
>                        2299: R_X86_64_PC32     schedule_timeout_uninterruptible-0x4
>
>        memset(cmd, 0, MAX_COMMAND_SIZE);

This patch was tested with coccinelle version 1.0.4

Confidence: Medium as I did not find any false positives for the 24
cases that were found - some of the patches generated do not actually
improve readability though (e.g. drivers/i2c/busses/i2c-highlander.c)
but technically it is not incorrect ither.

patch is against linux-next (localversion-next is next-20160107)

 scripts/coccinelle/api/msleep_double_convert.cocci | 63 ++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 scripts/coccinelle/api/msleep_double_convert.cocci

diff --git a/scripts/coccinelle/api/msleep_double_convert.cocci b/scripts/coccinelle/api/msleep_double_convert.cocci
new file mode 100644
index 0000000..b39dd36
--- /dev/null
+++ b/scripts/coccinelle/api/msleep_double_convert.cocci
@@ -0,0 +1,63 @@
+/// Check for double conversion of timeouts values
+//
+// for constants this actually makes little sense - other than
+// for readability - in cases where non-constants are involved there is
+// a call to jiffies_to_msecs that is saved here.
+//
+// Confidence: Medium
+// Copyright: (C) 2015 Nicholas Mc Guire <hofrat@osadl.org>, OSADL, GPL v2
+// URL: http://coccinelle.lip6.fr
+// Options: --no-includes --include-headers
+
+virtual org
+virtual patch
+virtual report
+
+ at depends on patch@
+constant C;
+expression E;
+@@
+
+(
+- msleep_interruptible(jiffies_to_msecs(C))
++ schedule_timeout_interruptible(C)
+|
+- msleep_interruptible(jiffies_to_msecs(E))
++ schedule_timeout_interruptible(E)
+|
+- msleep(jiffies_to_msecs(C))
++ schedule_timeout(C)
+|
+- msleep(jiffies_to_msecs(E))
++ schedule_timeout(E)
+)
+
+ at cc depends on !patch && (org || report)@
+constant C;
+expression E;
+position p;
+@@
+
+(
+* msleep_interruptible at p(jiffies_to_msecs(C))
+|
+* msleep_interruptible at p(jiffies_to_msecs(E))
+|
+* msleep at p(jiffies_to_msecs(C))
+|
+* msleep at p(jiffies_to_msecs(E))
+)
+
+ at script:python depends on org@
+p << cc.p;
+@@
+
+msg = "INFO: schedule_timeout*() preferred if timeout in jiffies"
+coccilib.org.print_safe_todo(p[0], msg)
+
+@script:python depends on report@
+p << cc.p;
+@@
+
+msg = "INFO: schedule_timeout*() preferred if timeout in jiffies"
+coccilib.report.print_report(p[0], msg)
-- 
2.1.4
