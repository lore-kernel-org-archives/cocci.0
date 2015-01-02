From: der.herr@hofr.at (Nicholas Mc Guire)
Date: Fri,  2 Jan 2015 04:59:10 -0500
Subject: [Cocci] [PATCH 1/3 RFC] Coccinelle: drop unecessary duplicated
	init_compltion calls
In-Reply-To: <1420192752-4889-1-git-send-email-der.herr@hofr.at>
References: <1420192752-4889-1-git-send-email-der.herr@hofr.at>
Message-ID: <1420192752-4889-2-git-send-email-der.herr@hofr.at>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Reviewed-by: Andreas Platschek <platschek@ict.tuwien.ac.at>
Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
---
 .../coccinelle/api/duplicate_init_completion.cocci |   59 ++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 scripts/coccinelle/api/duplicate_init_completion.cocci

diff --git a/scripts/coccinelle/api/duplicate_init_completion.cocci b/scripts/coccinelle/api/duplicate_init_completion.cocci
new file mode 100644
index 0000000..889715a
--- /dev/null
+++ b/scripts/coccinelle/api/duplicate_init_completion.cocci
@@ -0,0 +1,59 @@
+/* drop unnecessary duplicated init_compltion calls
+ * in patch mode one must be check that it is actually
+ * the second init_completion that can be removed and not
+ * the first.
+ * Options: --no-includes --include-headers
+ */
+virtual context
+virtual patch
+virtual org
+virtual report
+
+/* mark first call to init_completion */
+ at c@
+expression cmp;
+position p;
+@@
+
+ init_completion at p(cmp)
+
+/* flag duplicate initializations */
+ at d depends on patch && !(context || org || report)@
+expression E,c.cmp;
+identifier f;
+position c.p,p1;
+@@
+
+  init_completion at p(cmp)
+  ... when != E = cmp
+      when != E = &cmp
+      when != f(..., cmp, ...)
+      when != f(..., &cmp, ...)
+- init_completion at p1(cmp);
+
+ at dp depends on !patch && (context || org || report)@
+identifier f;
+expression E,c.cmp;
+position c.p,p1;
+@@
+
+  init_completion at p(cmp)
+  ... when != E = cmp
+      when != E = &cmp
+      when != f(..., cmp, ...)
+      when != f(..., &cmp, ...)
+  init_completion at p1(cmp);
+
+ at script:python depends on org@
+p << dp.p1;
+@@
+
+msg="WARNING: possible duplicate init_completion"
+coccilib.org.print_todo(p[0], msg)
+
+@script:python depends on report@
+p << dp.p1;
+@@
+
+msg="WARNING: possible duplicate init_completion"
+coccilib.report.print_report(p[0], msg)
-- 
1.7.10.4
