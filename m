From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Mon, 24 Aug 2015 20:40:12 +0200
Subject: [Cocci] [PATCH] coccinelle: api: suggest use of kvfree
Message-ID: <1440441612-28868-1-git-send-email-Julia.Lawall@lip6.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Inspired by some patches sent by Pekka Enberg, eg 958b43384e4.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 scripts/coccinelle/api/kvfree.cocci |   70 ++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/scripts/coccinelle/api/kvfree.cocci b/scripts/coccinelle/api/kvfree.cocci
new file mode 100644
index 0000000..49f8551
--- /dev/null
+++ b/scripts/coccinelle/api/kvfree.cocci
@@ -0,0 +1,70 @@
+/// Use kvfree for choosing free function.
+///
+// Confidence: High
+// Copyright: (C) 2015 Julia Lawall, Inria, GPLv2.
+// URL: http://coccinelle.lip6.fr/
+// Options: --no-includes --include-headers
+
+virtual patch
+virtual context
+virtual org
+virtual report
+
+ at r@
+expression e;
+position p;
+@@
+
+if at p (is_vmalloc_addr(e))
+     vfree(e);
+else
+     kfree(e);
+
+ at script:python@
+p << r.p;
+@@
+
+if p[0].current_element == "kvfree":
+  cocci.include_match(False)
+
+ at s depends on patch && !context && !org && !report@
+expression e;
+position r.p;
+@@
+
+- if at p (is_vmalloc_addr(e))
+-      vfree(e);
+- else
+-      kfree(e);
++ kvfree(e);
+
+// ----------------------------------------------------------------------------
+
+ at s_context depends on !patch && (context || org || report)@
+expression e;
+position r.p;
+position j0;
+@@
+
+* if at p (is_vmalloc_addr at j0(e))
+      vfree(e);
+  else
+      kfree(e);
+
+// ----------------------------------------------------------------------------
+
+ at script:python s_org depends on org@
+j0 << s_context.j0;
+@@
+
+msg = "Use kvfree."
+coccilib.org.print_todo(j0[0], msg)
+
+// ----------------------------------------------------------------------------
+
+@script:python s_report depends on report@
+j0 << s_context.j0;
+@@
+
+msg = "Use kvfree."
+coccilib.report.print_report(j0[0], msg)
