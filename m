From: himangi774@gmail.com (Himangi Saraogi)
Date: Mon, 14 Jul 2014 23:04:10 +0530
Subject: [Cocci] [PATCH] Coccinelle: Script to detect incorrect argument to
	sizeof
Message-ID: <20140714173410.GA5387@himangi-Dell>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This makes an effort to find cases where the argument to sizeof is wrong
in memory allocation functions by checking the type of the allocated
memory when it is a double pointer and ensuring the sizeof argument takes
a pointer to the the memory being allocated. There are false positives
in cases the sizeof argument is not used in constructing the return value.

Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
Acked-by: Julia Lawall <julia.lawall@lip6.fr>
---
 scripts/coccinelle/misc/badty.cocci | 76 +++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 scripts/coccinelle/misc/badty.cocci

diff --git a/scripts/coccinelle/misc/badty.cocci b/scripts/coccinelle/misc/badty.cocci
new file mode 100644
index 0000000..2fc06fc
--- /dev/null
+++ b/scripts/coccinelle/misc/badty.cocci
@@ -0,0 +1,76 @@
+/// Use ARRAY_SIZE instead of dividing sizeof array with sizeof an element
+///
+//# This makes an effort to find cases where the argument to sizeof is wrong
+//# in memory allocation functions by checking the type of the allocated memory
+//# when it is a double pointer and ensuring the sizeof argument takes a pointer
+//# to the the memory being allocated. There are false positives in cases the
+//# sizeof argument is not used in constructing the return value. The result
+//# may need some reformatting.
+//
+// Confidence: Moderate
+// Copyright: (C) 2014 Himangi Saraogi.  GPLv2.
+// Comments:
+// Options:
+
+virtual patch
+virtual context
+virtual org
+virtual report
+
+//----------------------------------------------------------
+//  For context mode
+//----------------------------------------------------------
+
+ at depends on context disable sizeof_type_expr@
+type T;
+T **x;
+@@
+
+  x =
+  <+...sizeof(
+* T
+  )...+>
+
+//----------------------------------------------------------
+//  For patch mode
+//----------------------------------------------------------
+
+ at depends on patch disable sizeof_type_expr@
+type T;
+T **x;
+@@
+
+  x =
+  <+...sizeof(
+- T
++ *x
+  )...+>
+
+//----------------------------------------------------------
+//  For org and report mode
+//----------------------------------------------------------
+
+ at r disable sizeof_type_expr@
+type T;
+T **x;
+position p;
+@@
+
+  x =
+  <+...sizeof(
+  T@p
+  )...+>
+
+ at script:python depends on org@
+p << r.p;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING sizeof argument should be pointer type, not structure type")
+
+@script:python depends on report@
+p << r.p;
+@@
+
+msg="WARNING: Use correct pointer type argument for sizeof"
+coccilib.report.print_report(p[0], msg)
+
-- 
1.9.1
