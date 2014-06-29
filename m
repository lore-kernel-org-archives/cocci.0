From: himangi774@gmail.com (Himangi Saraogi)
Date: Sun, 29 Jun 2014 12:46:04 +0530
Subject: [Cocci] [PATCH] Coccinelle: Script to use ARRAY_SIZE instead of
 division of two sizeofs
Message-ID: <20140629071604.GA16162@himangi-Dell>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This script detects cases where ARRAY_SIZE can be used such as
where there is a division of sizeof the array by the sizeof its first
element or by any indexed element or the element type. It replaces the
division of the two sizeofs by ARRAY_SIZE.

Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
Acked-by: Julia Lawall <julia.lawall@lip6.fr>
---
 scripts/coccinelle/misc/array_size.cocci | 87 ++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 scripts/coccinelle/misc/array_size.cocci

diff --git a/scripts/coccinelle/misc/array_size.cocci b/scripts/coccinelle/misc/array_size.cocci
new file mode 100644
index 0000000..81e279c
--- /dev/null
+++ b/scripts/coccinelle/misc/array_size.cocci
@@ -0,0 +1,87 @@
+/// Use ARRAY_SIZE instead of dividing sizeof array with sizeof an element
+///
+//# This makes an effort to find cases where ARRAY_SIZE can be used such as
+//# where there is a division of sizeof the array by the sizeof its first
+//# element or by any indexed element or the element type. It replaces the
+//# division of the two sizeofs by ARRAY_SIZE.
+//
+// Confidence: High
+// Copyright: (C) 2014 Himangi Saraogi.  GPLv2.
+// Comments:
+// Options: --no-includes --include-headers
+
+virtual patch
+virtual context
+virtual org
+virtual report
+
+ at i@
+@@
+
+#include <linux/kernel.h>
+
+//----------------------------------------------------------
+//  For context mode
+//----------------------------------------------------------
+
+ at depends on i&&context@
+type T;
+T[] E;
+@@
+(
+* (sizeof(E)/sizeof(*E))
+|
+* (sizeof(E)/sizeof(E[...]))
+|
+* (sizeof(E)/sizeof(T))
+)
+
+//----------------------------------------------------------
+//  For patch mode
+//----------------------------------------------------------
+
+ at depends on i&&patch@
+type T;
+T[] E;
+@@
+(
+- (sizeof(E)/sizeof(*E))
++ ARRAY_SIZE(E)
+|
+- (sizeof(E)/sizeof(E[...]))
++ ARRAY_SIZE(E)
+|
+- (sizeof(E)/sizeof(T))
++ ARRAY_SIZE(E)
+)
+
+//----------------------------------------------------------
+//  For org and report mode
+//----------------------------------------------------------
+
+ at r@
+type T;
+T[] E;
+position p;
+@@
+(
+ (sizeof(E)@p /sizeof(*E))
+|
+ (sizeof(E)@p /sizeof(E[...]))
+|
+ (sizeof(E)@p /sizeof(T))
+)
+
+ at script:python depends on i&&org@
+p << r.p;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING should use ARRAY_SIZE")
+
+@script:python depends on i&&report@
+p << r.p;
+@@
+
+msg="WARNING: Use ARRAY_SIZE"
+coccilib.report.print_report(p[0], msg)
+
-- 
1.9.1
