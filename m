From: amitoj1606@gmail.com (Amitoj Kaur Chawla)
Date: Thu, 30 Jun 2016 00:03:47 +0530
Subject: [Cocci] [PATCH] Coccinelle: Script to replace NULL test with IS_ERR
 test for devm_ioremap_resource
Message-ID: <20160629183347.GA17067@amitoj-Inspiron-3542>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This script detects cases which have incorrect error handling for
devm_ioremap_resource function, employing a NULL test instead of an
IS_ERR() test.

Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
---
 .../coccinelle/null/devm_ioremap_resource.cocci    | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 scripts/coccinelle/null/devm_ioremap_resource.cocci

diff --git a/scripts/coccinelle/null/devm_ioremap_resource.cocci b/scripts/coccinelle/null/devm_ioremap_resource.cocci
new file mode 100644
index 0000000..bc87efa
--- /dev/null
+++ b/scripts/coccinelle/null/devm_ioremap_resource.cocci
@@ -0,0 +1,37 @@
+/// Correct error handling for devm_ioremap_resource
+///
+// Confidence: High
+// Copyright: (C) 2016 Amitoj Kaur Chawla
+// Keywords: devm,devm_ioremap_resource
+
+virtual context
+virtual org
+virtual report
+
+// ----------------------------------------------------------------------------
+
+ at err depends on context || org || report@
+statement S;
+expression e;
+position j0;
+@@
+
+  e = devm_ioremap_resource(...);
+* if (!e at j0) S
+// ----------------------------------------------------------------------------
+
+ at script:python err_org depends on org@
+j0 << err.j0;
+@@
+
+msg = "Incorrect error handling."
+coccilib.org.print_todo(j0[0], msg)
+
+// ----------------------------------------------------------------------------
+
+@script:python err_report depends on report@
+j0 << err.j0;
+@@
+
+msg = "Incorrect error handling."
+coccilib.report.print_report(j0[0], msg)
-- 
1.9.1
