From: a.hajda@samsung.com (Andrzej Hajda)
Date: Tue, 15 Sep 2015 11:27:12 +0200
Subject: [Cocci] [PATCH] coccinelle: tests: unsigned value cannot be lesser
	than zero
Message-ID: <1442309232-5902-1-git-send-email-a.hajda@samsung.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Code comparing unsigned variables with zero using operators < or >= does not
make sense. It is always false or true, respectively. However, its presence
often indicates bugs in the code.
gcc can detect it also using -Wtype-limits switch, but it warns also in correct
cases, making too much noise.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
Hi Julia,

This test finds 93 issues in kernel code (with --all-includes) which could
be corrected. Some of them are harmless, just unnecessary code, but there
are also serious bugs, like:
	u32 irq = platform_get_irq(...)
	if (irq < 0)
		...
	unsigned int target = cpumask_any_but(cpu_online_mask, cpu);
	if (target < 0)
		...

Regards
Andrzej
---
 .../tests/unsigned_lesser_than_zero.cocci          | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci

diff --git a/scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci b/scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci
new file mode 100644
index 0000000..6a90510
--- /dev/null
+++ b/scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci
@@ -0,0 +1,37 @@
+/// Unsigned variables cannot be lesser than zero. Presence of such checks
+/// can indicate incorrect variable type or just unnecessary code.
+///
+// Confidence: High
+// Copyright: (C) 2015 Andrzej Hajda, Samsung Electronics Co., Ltd. GPLv2.
+// URL: http://coccinelle.lip6.fr/
+// Options: --include-headers
+
+virtual context
+virtual org
+virtual report
+
+ at r depends on context || org || report@
+position p;
+typedef u8, u16, u32, u64;
+{unsigned char, unsigned short int, unsigned int, unsigned long, unsigned long long, size_t, u8, u16, u32, u64} v;
+@@
+
+(
+*v at p < 0
+|
+*v@p >= 0
+)
+
+ at script:python depends on org@
+p << r.p;
+@@
+
+msg = "WARNING: Unsigned value cannot be lesser than zero"
+coccilib.org.print_todo(p[0], msg)
+
+@script:python depends on report@
+p << r.p;
+@@
+
+msg = "WARNING: Unsigned value cannot be lesser than zero"
+coccilib.report.print_report(p[0], msg)
-- 
1.9.1
