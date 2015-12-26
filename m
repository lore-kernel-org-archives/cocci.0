From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sat, 26 Dec 2015 20:24:51 +0100
Subject: [Cocci] [PATCH] coccinelle: api: check for propagation of error
	from platform_get_irq
Message-ID: <1451157891-24881-1-git-send-email-Julia.Lawall@lip6.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

The error return value of platform_get_irq seems to often get dropped.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 scripts/coccinelle/api/platform_get_irq_return.cocci |   53 ++++++++++
 1 file changed, 53 insertions(+)

diff --git a/scripts/coccinelle/api/platform_get_irq_return.cocci b/scripts/coccinelle/api/platform_get_irq_return.cocci
new file mode 100644
index 0000000..96fc560
--- /dev/null
+++ b/scripts/coccinelle/api/platform_get_irq_return.cocci
@@ -0,0 +1,53 @@
+/// Propagate the return value of platform_get_irq.
+//# Sometimes the return value of platform_get_irq is tested using <= 0, but 0
+//# might not be an appropriate return value in an error case.
+///
+// Confidence: Moderate
+// Copyright: (C) 2015 Julia Lawall, Inria. GPLv2.
+// URL: http://coccinelle.lip6.fr/
+// Options: --no-includes --include-headers
+
+virtual context
+virtual org
+virtual report
+
+// ----------------------------------------------------------------------------
+
+ at r depends on context || org || report@
+constant C;
+expression e, ret;
+position j0, j1, j2;
+@@
+
+* e at j0 = platform_get_irq(...);
+if (...) {
+  ...
+  ret at j1 = -C;
+  ...
+  return ret at j2;
+}
+
+// ----------------------------------------------------------------------------
+
+ at script:python r_org depends on org@
+j0 << r.j0;
+j1 << r.j1;
+j2 << r.j2;
+@@
+
+msg = "Propagate return value of platform_get_irq."
+coccilib.org.print_todo(j0[0], msg)
+coccilib.org.print_link(j1[0], "")
+coccilib.org.print_link(j2[0], "")
+
+// ----------------------------------------------------------------------------
+
+@script:python r_report depends on report@
+j0 << r.j0;
+j1 << r.j1;
+j2 << r.j2;
+@@
+
+msg = "Propagate return value of platform_get_irq around lines %s,%s." % (j1[0].line,j2[0].line)
+coccilib.report.print_report(j0[0], msg)
+
