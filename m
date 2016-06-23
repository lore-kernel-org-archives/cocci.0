From: afd@ti.com (Andrew F. Davis)
Date: Thu, 23 Jun 2016 13:53:52 -0500
Subject: [Cocci] [PATCH] Coccinelle: Add misc/boolconv.cocci
Message-ID: <20160623185352.25818-1-afd@ti.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Add a script to check for unneeded conversions to bool.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 scripts/coccinelle/misc/boolconv.cocci | 90 ++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 scripts/coccinelle/misc/boolconv.cocci

diff --git a/scripts/coccinelle/misc/boolconv.cocci b/scripts/coccinelle/misc/boolconv.cocci
new file mode 100644
index 0000000..33c464d
--- /dev/null
+++ b/scripts/coccinelle/misc/boolconv.cocci
@@ -0,0 +1,90 @@
+/// Remove unneeded conversion to bool
+///
+//# Relational and logical operators evaluate to bool,
+//# explicit conversion is overly verbose and unneeded.
+//
+// Copyright: (C) 2016 Andrew F. Davis <afd@ti.com> GPLv2.
+
+virtual patch
+virtual context
+virtual org
+virtual report
+
+//----------------------------------------------------------
+//  For patch mode
+//----------------------------------------------------------
+
+ at depends on patch@
+expression A, B;
+symbol true, false;
+@@
+
+(
+  A == B
+|
+  A != B
+|
+  A > B
+|
+  A < B
+|
+  A >= B
+|
+  A <= B
+|
+  A && B
+|
+  A || B
+)
+- ? true : false
+
+//----------------------------------------------------------
+//  For context mode
+//----------------------------------------------------------
+
+@r depends on !patch@
+expression A, B;
+symbol true, false;
+position p;
+@@
+
+(
+  A == B
+|
+  A != B
+|
+  A > B
+|
+  A < B
+|
+  A >= B
+|
+  A <= B
+|
+  A && B
+|
+  A || B
+)
+* ? true : false at p
+
+//----------------------------------------------------------
+//  For org mode
+//----------------------------------------------------------
+
+ at script:python depends on r&&org@
+p << r.p;
+@@
+
+msg = "WARNING: conversion to bool not needed here"
+coccilib.org.print_todo(p[0], msg)
+
+//----------------------------------------------------------
+//  For report mode
+//----------------------------------------------------------
+
+@script:python depends on r&&report@
+p << r.p;
+@@
+
+msg = "WARNING: conversion to bool not needed here"
+coccilib.report.print_report(p[0], msg)
-- 
2.9.0
