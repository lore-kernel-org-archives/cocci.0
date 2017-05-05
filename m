From: vaishali.thakkar@oracle.com (Vaishali Thakkar)
Date: Fri,  5 May 2017 19:30:50 +0530
Subject: [Cocci] [PATCH v2] Coccinelle: api: Add offset_in_page.cocci
Message-ID: <1493992850-13283-1-git-send-email-vaishali.thakkar@oracle.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Use of offset_in_page is preferable instead of open coding.
This patch adds coccinelle script for suggesting the use of
macro offset_in_page.

Signed-off-by: Vaishali Thakkar <vaishali.thakkar@oracle.com>
---
Changes since v1:
	- Add parenthesis around rule for patch mode to avoid
	  extra parenthesis in end result
---
 scripts/coccinelle/api/offset_in_page.cocci | 77 +++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 scripts/coccinelle/api/offset_in_page.cocci

diff --git a/scripts/coccinelle/api/offset_in_page.cocci b/scripts/coccinelle/api/offset_in_page.cocci
new file mode 100644
index 0000000..4034864
--- /dev/null
+++ b/scripts/coccinelle/api/offset_in_page.cocci
@@ -0,0 +1,77 @@
+/// Use offset_in_page instead of duplicating its implementation
+///
+// Confidence: High
+// Copyright: (C) 2017 Vaishali Thakkar, Oracle. GPLv2.
+// Options: --no-includes --include-headers
+// Keywords: offset_in_page
+
+virtual patch
+virtual context
+virtual org
+virtual report
+
+ at r_patch depends on patch@
+expression e;
+identifier i;
+@@
+- unsigned long i = (unsigned long)e & ~PAGE_MASK;
+...
+- i
++ offset_in_page(e)
+
+ at r1_patch depends on patch@
+expression e1;
+@@
+
+(
+- ((unsigned long)e1 & ~PAGE_MASK)
++ offset_in_page(e1)
+|
+- ((unsigned long)e1 % PAGE_SIZE)
++ offset_in_page(e1)
+)
+
+ at r_context depends on !patch@
+expression e;
+identifier i;
+position p;
+@@
+
+* unsigned long i = (unsigned long)e at p & ~PAGE_MASK;
+...
+* i
+
+ at r1_context depends on !patch@
+expression e1;
+position p1;
+@@
+
+(
+* (unsigned long)e1 at p1 & ~PAGE_MASK
+|
+* (unsigned long)e1 at p1 % PAGE_SIZE
+)
+
+ at script:python depends on org@
+p << r_context.p;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING opportunity for offset_in_page")
+
+ at script:python depends on org@
+p << r1_context.p1;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING opportunity for offset_in_page")
+
+ at script:python depends on report@
+p << r_context.p;
+@@
+
+coccilib.report.print_report(p[0], "WARNING opportunity for offset_in_page")
+
+@script:python depends on report@
+p << r1_context.p1;
+@@
+
+coccilib.report.print_report(p[0], "WARNING opportunity for offset_in_page")
-- 
2.7.4
