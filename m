From: amitoj1606@gmail.com (Amitoj Kaur Chawla)
Date: Mon, 25 Jul 2016 13:51:21 +0530
Subject: [Cocci] [PATCH v2] Coccinelle: Script to replace NULL test with
 IS_ERR test for devm_ioremap_resource
Message-ID: <20160725082120.GA5055@amitoj-Inspiron-3542>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This script detects cases which have incorrect error handling for
devm_ioremap_resource function, employing a NULL test instead of an
IS_ERR() test.

Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
---
Changes in v2:
        -Changed script to correct error handling instead of just
         detecting cases of incorrect error handling

 .../null/devm_ioremap_resource_test.cocci          | 66 ++++++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 scripts/coccinelle/null/devm_ioremap_resource_test.cocci

diff --git a/scripts/coccinelle/null/devm_ioremap_resource_test.cocci b/scripts/coccinelle/null/devm_ioremap_resource_test.cocci
new file mode 100644
index 0000000..671970a
--- /dev/null
+++ b/scripts/coccinelle/null/devm_ioremap_resource_test.cocci
@@ -0,0 +1,66 @@
+/// Correct error handling for devm_ioremap_resource
+///
+// Confidence: High
+// Copyright: (C) 2016 Amitoj Kaur Chawla
+// Keywords: devm, devm_ioremap_resource
+
+virtual patch
+virtual context
+virtual org
+virtual report
+
+ at err depends on patch && !context && !org && !report@
+expression e,e1;
+@@
+
+  e = devm_ioremap_resource(...);
+  if(
+-    e == NULL
++    IS_ERR(e)
+    )
+    {
+  ...
+  return
+- e1
++ PTR_ERR(e)
+  ;
+  }
+
+// ----------------------------------------------------------------------------
+
+ at err_context depends on !patch && (context || org || report)@
+expression e, e1;
+position j0, j1;
+@@
+
+  e at j0 = devm_ioremap_resource(...);
+  if(
+*     e == NULL
+    )
+    {
+  ...
+  return
+*  e1 at j1
+  ;
+  }
+
+// ----------------------------------------------------------------------------
+
+ at script:python err_org depends on org@
+j0 << err_context.j0;
+j1 << err_context.j1;
+@@
+
+msg = "Incorrect error handling."
+coccilib.org.print_todo(j0[0], msg)
+coccilib.org.print_link(j1[0], "")
+
+// ----------------------------------------------------------------------------
+
+@script:python err_report depends on report@
+j0 << err_context.j0;
+j1 << err_context.j1;
+@@
+
+msg = "Incorrect error handling around line %s." % (j1[0].line)
+coccilib.report.print_report(j0[0], msg)
-- 
1.9.1
