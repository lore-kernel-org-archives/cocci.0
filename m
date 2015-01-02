From: der.herr@hofr.at (Nicholas Mc Guire)
Date: Fri,  2 Jan 2015 04:59:11 -0500
Subject: [Cocci] [PATCH 2/3 RFC] Coccinelle: check for incorrect
	DECLARE_COMPLETION use
In-Reply-To: <1420192752-4889-1-git-send-email-der.herr@hofr.at>
References: <1420192752-4889-1-git-send-email-der.herr@hofr.at>
Message-ID: <1420192752-4889-3-git-send-email-der.herr@hofr.at>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Reviewed-by: Andreas Platschek <platschek@ict.tuwien.ac.at>
Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>
---
 .../coccinelle/api/false_declare_completion.cocci  |   50 ++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 scripts/coccinelle/api/false_declare_completion.cocci

diff --git a/scripts/coccinelle/api/false_declare_completion.cocci b/scripts/coccinelle/api/false_declare_completion.cocci
new file mode 100644
index 0000000..a0e3d6c
--- /dev/null
+++ b/scripts/coccinelle/api/false_declare_completion.cocci
@@ -0,0 +1,50 @@
+/* check for incorrect DECLARE_COMPLETION use within a function
+ *
+ * Options:  --no-includes --include-headers
+ */
+virtual context
+virtual patch
+virtual org
+virtual report
+
+/* flag incorrect initializer*/
+ at e depends on patch && !(context || org || report)@
+expression cmp;
+identifier f;
+declarer name DECLARE_COMPLETION;
+position p;
+@@
+
+f(...) {
+  <...
+- DECLARE_COMPLETION@p(cmp);
++ DECLARE_COMPLETION_ONSTACK(cmp);
+  ...>
+}
+
+ at ep depends on !patch && (context || org || report)@
+expression cmp;
+identifier f;
+position p;
+@@
+
+f(...) {
+  <...
+* DECLARE_COMPLETION@p(cmp);
+  ...>
+}
+
+ at script:python depends on org@
+p << ep.p;
+@@
+
+msg="WARNING: possible incorrect use of DECLARE_COMPLETION"
+coccilib.org.print_todo(p[0], msg)
+
+@script:python depends on report@
+p << ep.p;
+@@
+
+msg="WARNING: possible incorrect use of DECLARE_COMPLETION"
+coccilib.report.print_report(p[0], msg)
+
-- 
1.7.10.4
