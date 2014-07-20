From: himangi774@gmail.com (Himangi Saraogi)
Date: Mon, 21 Jul 2014 03:06:35 +0530
Subject: [Cocci] [PATCH] Coccinelle: Script to replace if and BUG with BUG_ON
Message-ID: <20140720213635.GA12365@himangi-Dell>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This script detects cases where BUG() follows an if condition on an
expression and replaces the if condition and BUG() with a BUG_ON having
the conditional expression of the if statement as argument.

Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
Acked-by: Julia Lawall <julia.lawall@lip6.fr>
---
 scripts/coccinelle/misc/bugon.cocci | 62 +++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 scripts/coccinelle/misc/bugon.cocci

diff --git a/scripts/coccinelle/misc/bugon.cocci b/scripts/coccinelle/misc/bugon.cocci
new file mode 100644
index 0000000..556456c
--- /dev/null
+++ b/scripts/coccinelle/misc/bugon.cocci
@@ -0,0 +1,62 @@
+/// Use BUG_ON instead of a if condition followed by BUG.
+///
+//# This makes an effort to find cases where BUG() follows an if
+//# condition on an expression and replaces the if condition and BUG()
+//# with a BUG_ON having the conditional expression of the if statement
+//# as argument.
+//
+// Confidence: High
+// Copyright: (C) 2014 Himangi Saraogi.  GPLv2.
+// Comments:
+// Options: --no-includes, --include-headers
+
+virtual patch
+virtual context
+virtual org
+virtual report
+
+//----------------------------------------------------------
+//  For context mode
+//----------------------------------------------------------
+
+ at depends on context@
+expression e;
+@@
+
+*if (e) BUG();
+
+//----------------------------------------------------------
+//  For patch mode
+//----------------------------------------------------------
+
+ at depends on patch@
+expression e;
+@@
+
+-if (e) BUG();
++BUG_ON(e);
+
+//----------------------------------------------------------
+//  For org and report mode
+//----------------------------------------------------------
+
+ at r@
+expression e;
+position p;
+@@
+
+ if (e) BUG at p ();
+
+ at script:python depends on org@
+p << r.p;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING use BUG_ON")
+
+@script:python depends on report@
+p << r.p;
+@@
+
+msg="WARNING: Use BUG_ON"
+coccilib.report.print_report(p[0], msg)
+
-- 
1.9.1
