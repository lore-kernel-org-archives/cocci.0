From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 26 Dec 2015 21:58:58 +0100 (CET)
Subject: [Cocci] [PATCH v2] coccinelle: api: check for propagation of error
 from platform_get_irq
In-Reply-To: <567EF895.6080702@cogentembedded.com>
References: <1451157891-24881-1-git-send-email-Julia.Lawall@lip6.fr>
 <567EF188.7020203@cogentembedded.com>
 <alpine.DEB.2.02.1512262107340.2070@localhost6.localdomain6>
 <alpine.DEB.2.02.1512262123500.2070@localhost6.localdomain6>
 <567EF895.6080702@cogentembedded.com>
Message-ID: <alpine.DEB.2.02.1512262156580.2070@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

The error return value of platform_get_irq seems to often get dropped.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---

v2: Check for the direct return case also.  Added some mailing lists of
common offenders.

diff --git a/scripts/coccinelle/api/platform_get_irq_return.cocci b/scripts/coccinelle/api/platform_get_irq_return.cocci
new file mode 100644
index 0000000..44680d0
--- /dev/null
+++ b/scripts/coccinelle/api/platform_get_irq_return.cocci
@@ -0,0 +1,58 @@
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
+statement S;
+expression e, ret;
+position j0, j1;
+@@
+
+* e at j0 = platform_get_irq(...);
+(
+if at j1 (...) {
+  ...
+  return -C;
+} else S
+|
+if at j1 (...) {
+  ...
+  ret = -C;
+  ...
+  return ret;
+} else S
+)
+
+// ----------------------------------------------------------------------------
+
+ at script:python r_org depends on org@
+j0 << r.j0;
+j1 << r.j1;
+@@
+
+msg = "Propagate return value of platform_get_irq."
+coccilib.org.print_todo(j0[0], msg)
+coccilib.org.print_link(j1[0], "")
+
+// ----------------------------------------------------------------------------
+
+@script:python r_report depends on report@
+j0 << r.j0;
+j1 << r.j1;
+@@
+
+msg = "Propagate return value of platform_get_irq around line %s." % (j1[0].line)
+coccilib.report.print_report(j0[0], msg)
+
