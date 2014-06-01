From: peter.senna@gmail.com (Peter Senna Tschudin)
Date: Sun,  1 Jun 2014 15:12:31 -0300
Subject: [Cocci] [PATCH V2] coccicheck: Add unneeded return variable test
Message-ID: <1401646351-12474-1-git-send-email-peter.senna@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This semantic patch looks for variables that are initialized with a
constant, are never updated, and are only used as parameter of return.
Return the constant instead of using a variable.

Signed-off-by: Peter Senna Tschudin <peter.senna@gmail.com>
---
Changes from V1:
 - Move the comment about coverage and acceptance to after the --- line

There are 8 patches accepted reported by this semantic patch and more
than 300 fixes to be applied.

 scripts/coccinelle/misc/returnvar.cocci | 66 +++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 scripts/coccinelle/misc/returnvar.cocci

diff --git a/scripts/coccinelle/misc/returnvar.cocci b/scripts/coccinelle/misc/returnvar.cocci
new file mode 100644
index 0000000..605955a
--- /dev/null
+++ b/scripts/coccinelle/misc/returnvar.cocci
@@ -0,0 +1,66 @@
+///
+/// Removes unneeded variable used to store return value.
+///
+// Confidence: Moderate
+// Copyright: (C) 2012 Peter Senna Tschudin, INRIA/LIP6.  GPLv2.
+// URL: http://coccinelle.lip6.fr/
+// Comments: Comments on code can be deleted if near code that is removed.
+//           "when strict" can be removed to get more hits, but adds false
+//           positives
+// Options: --no-includes --include-headers
+
+virtual patch
+virtual report
+virtual context
+virtual org
+
+ at depends on patch@
+type T;
+constant C;
+identifier ret;
+@@
+- T ret = C;
+... when != ret
+    when strict
+return
+- ret
++ C
+;
+
+ at depends on context@
+type T;
+constant C;
+identifier ret;
+@@
+* T ret = C;
+... when != ret
+    when strict
+* return ret;
+
+ at r1 depends on report || org@
+type T;
+constant C;
+identifier ret;
+position p1, p2;
+@@
+T ret at p1 = C;
+... when != ret
+    when strict
+return ret at p2;
+
+ at script:python depends on report@
+p1 << r1.p1;
+p2 << r1.p2;
+C << r1.C;
+ret << r1.ret;
+@@
+coccilib.report.print_report(p1[0], "Unneeded variable: \"" + ret + "\". Return \"" + C + "\" on line " + p2[0].line)
+
+@script:python depends on org@
+p1 << r1.p1;
+p2 << r1.p2;
+C << r1.C;
+ret << r1.ret;
+@@
+cocci.print_main("unneeded \"" + ret + "\" variable", p1)
+cocci.print_sec("return " + C + " here", p2)
-- 
1.8.3.1
