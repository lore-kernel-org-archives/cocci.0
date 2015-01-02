From: der.herr@hofr.at (Nicholas Mc Guire)
Date: Fri,  2 Jan 2015 04:59:12 -0500
Subject: [Cocci] [PATCH 3/3 RFC] Coccinelle: incorrect use of multiple
	init_completion
In-Reply-To: <1420192752-4889-1-git-send-email-der.herr@hofr.at>
References: <1420192752-4889-1-git-send-email-der.herr@hofr.at>
Message-ID: <1420192752-4889-4-git-send-email-der.herr@hofr.at>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Reviewed-by: Andreas Platschek <platschek@ict.tuwien.ac.at>
Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
---
 scripts/coccinelle/api/false_init_compltion.cocci |   74 +++++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 scripts/coccinelle/api/false_init_compltion.cocci

diff --git a/scripts/coccinelle/api/false_init_compltion.cocci b/scripts/coccinelle/api/false_init_compltion.cocci
new file mode 100644
index 0000000..a97dfcf
--- /dev/null
+++ b/scripts/coccinelle/api/false_init_compltion.cocci
@@ -0,0 +1,74 @@
+/* check for incorrect use of multiple init_completion on the
+ * same struct completion and switch the reinitializations to use
+ * reinit_completion()
+ *
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
+/* flag incorrect reinitializations */
+ at d depends on patch && !(context || org || report)@
+expression E,c.cmp;
+identifier f;
+position c.p,p1;
+@@
+
+  init_completion at p(cmp)
+  <+...
+(
+  E = cmp
+|
+  E = &cmp
+|
+  f(..., cmp,...)
+|
+  f(..., &cmp,...)
+)
+  ...+>
+- init_completion at p1(cmp)
++ reinit_completion1(cmp)
+
+ at dp depends on !patch && (context || org || report)@
+identifier f;
+expression E,c.cmp;
+position c.p,p1;
+@@
+
+  init_completion at p(cmp)
+  <+...
+(
+  E = cmp
+|
+  E = &cmp
+|
+  f(..., cmp,...)
+|
+  f(..., &cmp,...)
+)
+  ...+>
+  init_completion at p1(cmp)
+
+ at script:python depends on org@
+p << dp.p1;
+@@
+
+msg="WARNING: possible reinit by init_completion"
+coccilib.org.print_todo(p[0], msg)
+
+@script:python depends on report@
+p << dp.p1;
+@@
+
+msg="WARNING: possible reinit by init_completion"
+coccilib.report.print_report(p[0], msg)
-- 
1.7.10.4
