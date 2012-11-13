From: peter.senna@gmail.com (Peter Senna Tschudin)
Date: Tue, 13 Nov 2012 11:50:41 +0100
Subject: [Cocci] [PATCH v2] scripts/coccinelle/misc/semicolon.cocci: Add
	unneeded semicolon test
Message-ID: <1352803841-25915-1-git-send-email-peter.senna@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This semantic patch looks for semicolons that can be removed without
changing the semantics of the code. The confidence is moderate
because there are some false positives on cases like:

b/drivers/mmc/host/cb710-mmc.c:589
                break;
        case MMC_POWER_UP:
        default:
-               /* ignore */;
        }

There are 37 patches accepted reported by this semantic patch and
more than 300 fixes to be applied.

Signed-off-by: Peter Senna Tschudin <peter.senna@gmail.com>
---

Changes from V1: Updated subject

 scripts/coccinelle/misc/semicolon.cocci | 83 +++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 scripts/coccinelle/misc/semicolon.cocci

diff --git a/scripts/coccinelle/misc/semicolon.cocci b/scripts/coccinelle/misc/semicolon.cocci
new file mode 100644
index 0000000..a47eba2
--- /dev/null
+++ b/scripts/coccinelle/misc/semicolon.cocci
@@ -0,0 +1,83 @@
+///
+/// Removes unneeded semicolon.
+///
+// Confidence: Moderate
+// Copyright: (C) 2012 Peter Senna Tschudin, INRIA/LIP6.  GPLv2.
+// URL: http://coccinelle.lip6.fr/
+// Comments: Some false positives on empty default cases in switch statements.
+// Options: --no-includes --include-headers
+
+virtual patch
+virtual report
+virtual context
+virtual org
+
+ at r_default@
+position p;
+@@
+switch (...)
+{
+default: ...;@p
+}
+
+ at r_case@
+position p;
+@@
+(
+switch (...)
+{
+case ...:;@p
+}
+|
+switch (...)
+{
+case ...:...
+case ...:;@p
+}
+|
+switch (...)
+{
+case ...:...
+case ...:
+case ...:;@p
+}
+)
+
+ at r1@
+statement S;
+position p1;
+position p != {r_default.p, r_case.p};
+identifier label;
+@@
+(
+label:;
+|
+S at p1;@p
+)
+
+ at script:python@
+p << r1.p;
+p1 << r1.p1;
+@@
+if p[0].line != p1[0].line_end:
+	cocci.include_match(False)
+
+ at depends on patch@
+position r1.p;
+@@
+-;@p
+
+ at script:python depends on report@
+p << r1.p;
+@@
+coccilib.report.print_report(p[0],"Unneeded semicolon")
+
+ at depends on context@
+position r1.p;
+@@
+*;@p
+
+@script:python depends on org@
+p << r1.p;
+@@
+cocci.print_main("Unneeded semicolon",p)
-- 
1.7.11.7
