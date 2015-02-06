From: lambert.quentin@gmail.com (Quentin Lambert)
Date: Fri, 6 Feb 2015 10:34:50 +0100
Subject: [Cocci] [PATCH 1/1] coccinelle: misc: Semantic patch to find
 attempts at comparing struct clk pointers
Message-ID: <20150206093450.GA1617@sloth>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This semantic patches find instances where struct clk pointers are compared.

This was proposed by Stephen Boyd.

Signed-off-by: Quentin Lambert <lambert.quentin@gmail.com>
---

 This patch was discussed in this thread:
 https://lkml.org/lkml/2015/2/2/629

 scripts/coccinelle/misc/structclk.cocci | 44 +++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 scripts/coccinelle/misc/structclk.cocci

diff --git a/scripts/coccinelle/misc/structclk.cocci b/scripts/coccinelle/misc/structclk.cocci
new file mode 100644
index 0000000..0307d34
--- /dev/null
+++ b/scripts/coccinelle/misc/structclk.cocci
@@ -0,0 +1,44 @@
+/// Find any attempt to compare struct clk pointers.
+///
+// Confidence: High
+// Copyright: (C) 2015 Quentin Lambert, INRIA/LiP6. GPLv2
+// URL: http://coccinelle.lip6.fr/
+// Options: --recursive-includes --relax-include-path
+// Options: --include-headers-for-types
+
+virtual context
+virtual org
+virtual report
+
+
+// ----------------------------------------------------------------------------
+
+ at comparison depends on context || org || report@
+struct clk *x1, x2;
+position j0;
+@@
+
+(
+*  x1 at j0 == x2
+|
+*  x1 at j0 != x2
+)
+
+// ----------------------------------------------------------------------------
+
+ at script:python comparison_org depends on org@
+j0 << comparison.j0;
+@@
+
+msg = "WARNING trying to compare struct clk pointers."
+coccilib.org.print_todo(j0[0], msg)
+
+// ----------------------------------------------------------------------------
+
+@script:python comparison_report depends on report@
+j0 << comparison.j0;
+@@
+
+msg = "WARNING trying to compare struct clk pointers."
+coccilib.report.print_report(j0[0], msg)
+
-- 
1.9.1
