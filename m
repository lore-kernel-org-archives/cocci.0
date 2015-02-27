From: d.granat@samsung.com (Daniel Granat)
Date: Fri, 27 Feb 2015 14:21:53 +0100
Subject: [Cocci] [PATCH] Add coccinelle script that makes sure that tables
 are NULL terminated
Message-ID: <1425043313-15844-1-git-send-email-d.granat@samsung.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Signed-off-by: Daniel Granat <d.granat@samsung.com>
---
 scripts/coccinelle/misc/device_id_tables.cocci | 95 ++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 scripts/coccinelle/misc/device_id_tables.cocci

diff --git a/scripts/coccinelle/misc/device_id_tables.cocci b/scripts/coccinelle/misc/device_id_tables.cocci
new file mode 100644
index 0000000..5968984
--- /dev/null
+++ b/scripts/coccinelle/misc/device_id_tables.cocci
@@ -0,0 +1,95 @@
+/// Make sure '*_device_id$' tables are NULL terminated
+//
+// Keywords: device_id
+// Confidence: Medium
+// Options: --include-headers
+
+virtual org
+virtual report
+virtual patch
+
+ at initialize:python@
+@@
+import re
+
+postfix = '_device_id$'
+prefix_list = ['platform', 'of', 'i2c']
+
+ at r1 depends on patch || org || report@
+position p1;
+identifier var, arr;
+identifier struct_name;
+expression E;
+@@
+
+(
+struct struct_name arr[] = {
+	...,
+	{
+	.var = E,
+	}
+	@p1
+};
+|
+struct struct_name arr[] = {
+	...,
+	{ ..., var, ... },
+	@p1
+};
+)
+
+ at script:python depends on report@
+struct_name << r1.struct_name;
+p1 << r1.p1;
+arr << r1.arr;
+pattern;
+@@
+
+for i in prefix_list:
+	pattern = str(i)+postfix
+        if re.match(pattern, struct_name) != None:
+		print "\nCOCCI: \"%s\" matchs required pattern \"%s\"" % (struct_name, pattern)
+		msg = "\"%s\" is not NULL terminated at line %s" % (arr, p1[0].line)
+        	coccilib.report.print_report(p1[0],msg)
+		break
+
+ at script:python match depends on patch@
+struct_name << r1.struct_name;
+matched_name;
+pattern;
+@@
+
+coccinelle.matched_name = ''
+
+for i in prefix_list:
+	pattern = str(i)+postfix
+	if re.match(pattern, struct_name) != None:
+		coccinelle.matched_name = struct_name
+		break
+
+ at r2 depends on patch@
+position r1.p1;
+identifier var, arr;
+identifier match.matched_name;
+expression E;
+@@
+
+(
+struct matched_name arr[] = { 
+        ...,
+        {
+        .var = E,
+-       }
+	@p1
++	},
++	{},
+};
+|
+struct matched_name arr[] = { 
+        ...,
+        { ..., var, ... },
+	@p1
++	{},
+};
+)
+
-- 
1.9.1
