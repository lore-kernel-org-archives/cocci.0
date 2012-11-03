From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sat,  3 Nov 2012 21:02:09 +0100
Subject: [Cocci] [PATCH] scripts/coccinelle/misc/warn.cocci: use WARN
Message-ID: <1351972929-7448-1-git-send-email-Julia.Lawall@lip6.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: Julia Lawall <Julia.Lawall@lip6.fr>

Use WARN(1,...) rather than printk followed by WARN(1).

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 scripts/coccinelle/misc/warn.cocci |  109 +++++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/scripts/coccinelle/misc/warn.cocci b/scripts/coccinelle/misc/warn.cocci
new file mode 100644
index 0000000..fda8c35
--- /dev/null
+++ b/scripts/coccinelle/misc/warn.cocci
@@ -0,0 +1,109 @@
+/// Use WARN(1,...) rather than printk followed by WARN_ON(1)
+///
+// Confidence: High
+// Copyright: (C) 2012 Julia Lawall, INRIA/LIP6.  GPLv2.
+// Copyright: (C) 2012 Gilles Muller, INRIA/LiP6.  GPLv2.
+// URL: http://coccinelle.lip6.fr/
+// Comments:
+// Options: -no_includes -include_headers
+
+virtual patch
+virtual context
+virtual org
+virtual report
+
+ at bad1@
+position p;
+@@
+
+printk(...);
+printk at p(...);
+WARN_ON(1);
+
+ at r1 depends on context || report || org@
+position p != bad1.p;
+@@
+
+ printk at p(...);
+*WARN_ON(1);
+
+ at script:python depends on org@
+p << r1.p;
+@@
+
+cocci.print_main("printk + WARN_ON can be just WARN",p)
+
+ at script:python depends on report@
+p << r1.p;
+@@
+
+msg = "SUGGESTION: printk + WARN_ON can be just WARN"
+coccilib.report.print_report(p[0],msg)
+
+ at ok1 depends on patch@
+expression list es;
+position p != bad1.p;
+@@
+
+-printk at p(
++WARN(1,
+  es);
+-WARN_ON(1);
+
+ at depends on patch@
+expression list ok1.es;
+@@
+
+if (...)
+- {
+  WARN(1,es);
+- }
+
+// --------------------------------------------------------------------
+
+ at bad2@
+position p;
+@@
+
+printk(...);
+printk at p(...);
+WARN_ON_ONCE(1);
+
+ at r2 depends on context || report || org@
+position p != bad1.p;
+@@
+
+ printk at p(...);
+*WARN_ON_ONCE(1);
+
+ at script:python depends on org@
+p << r2.p;
+@@
+
+cocci.print_main("printk + WARN_ON_ONCE can be just WARN_ONCE",p)
+
+ at script:python depends on report@
+p << r2.p;
+@@
+
+msg = "SUGGESTION: printk + WARN_ON_ONCE can be just WARN_ONCE"
+coccilib.report.print_report(p[0],msg)
+
+ at ok2 depends on patch@
+expression list es;
+position p != bad2.p;
+@@
+
+-printk at p(
++WARN_ONCE(1,
+  es);
+-WARN_ON_ONCE(1);
+
+@depends on patch@
+expression list ok2.es;
+@@
+
+if (...)
+- {
+  WARN_ONCE(1,es);
+- }
