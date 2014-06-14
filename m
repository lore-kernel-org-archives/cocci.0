From: himangi774@gmail.com (Himangi Saraogi)
Date: Sat, 14 Jun 2014 21:15:41 +0530
Subject: [Cocci] [PATCH] Coccinelle : Script to detect cast after memory
	allocation
Message-ID: <20140614154541.GA4179@himangi-Dell>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This script detects cases of use of cast for the value returned by
kmalloc, kzalloc, kcalloc, kmem_cache_alloc, kmem_cache_zalloc,
kmem_cache_alloc_node, kmalloc_node and kzalloc_node and removes
the cast as it is not useful. This Coccinelle script replaces
drop_kmalloc_cast.cocci as it removes the casting in more limited
cases of kmalloc, kzalloc and kcalloc.

Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
Acked-by: Julia Lawall <julia.lawall@lip6.fr>
---
 scripts/coccinelle/api/alloc/alloc_cast.cocci      | 72 ++++++++++++++++++++++
 .../coccinelle/api/alloc/drop_kmalloc_cast.cocci   | 67 --------------------
 2 files changed, 72 insertions(+), 67 deletions(-)
 create mode 100644 scripts/coccinelle/api/alloc/alloc_cast.cocci
 delete mode 100644 scripts/coccinelle/api/alloc/drop_kmalloc_cast.cocci

diff --git a/scripts/coccinelle/api/alloc/alloc_cast.cocci b/scripts/coccinelle/api/alloc/alloc_cast.cocci
new file mode 100644
index 0000000..6c308ee
--- /dev/null
+++ b/scripts/coccinelle/api/alloc/alloc_cast.cocci
@@ -0,0 +1,72 @@
+/// Remove casting the values returned by memory allocation functions
+/// like kmalloc, kzalloc, kmem_cache_alloc, kmem_cache_zalloc etc.
+///
+//# This makes an effort to find cases of casting of values returned by
+//# kmalloc, kzalloc, kcalloc, kmem_cache_alloc, kmem_cache_zalloc,
+//# kmem_cache_alloc_node, kmalloc_node and kzalloc_node and removes
+//# the casting as it is not required. The result in the patch case may
+//#need some reformatting.
+//
+// Confidence: High
+// Copyright: 2014, Himangi Saraogi  GPLv2.
+// Comments:
+// Options: --no-includes --include-headers
+//
+
+virtual context
+virtual patch
+virtual org
+virtual report
+
+//----------------------------------------------------------
+//  For context mode
+//----------------------------------------------------------
+
+ at depends on context@
+type T;
+@@
+
+* (T *)
+  \(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|
+   kmem_cache_alloc_node\|kmalloc_node\|kzalloc_node\)(...)
+
+//----------------------------------------------------------
+//  For patch mode
+//----------------------------------------------------------
+
+ at depends on patch@
+type T;
+@@
+
+- (T *)
+  (\(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|
+   kmem_cache_alloc_node\|kmalloc_node\|kzalloc_node\)(...))
+
+//----------------------------------------------------------
+//  For org and report mode
+//----------------------------------------------------------
+
+ at r depends on org || report@
+type T;
+position p;
+@@
+
+ (T at p *)\(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|
+   kmem_cache_alloc_node\|kmalloc_node\|kzalloc_node\)(...)
+
+ at script:python depends on org@
+p << r.p;
+t << r.T;
+@@
+
+coccilib.org.print_safe_todo(p[0], t)
+
+ at script:python depends on report@
+p << r.p;
+t << r.T;
+@@
+
+msg="WARNING: casting value returned by memory allocation function to (%s *) is useless." % (t)
+coccilib.report.print_report(p[0], msg)
+
+
diff --git a/scripts/coccinelle/api/alloc/drop_kmalloc_cast.cocci b/scripts/coccinelle/api/alloc/drop_kmalloc_cast.cocci
deleted file mode 100644
index bd5d08b..0000000
--- a/scripts/coccinelle/api/alloc/drop_kmalloc_cast.cocci
+++ /dev/null
@@ -1,67 +0,0 @@
-///
-/// Casting (void *) value returned by kmalloc is useless
-/// as mentioned in Documentation/CodingStyle, Chap 14.
-///
-// Confidence: High
-// Copyright: 2009,2010 Nicolas Palix, DIKU.  GPLv2.
-// URL: http://coccinelle.lip6.fr/
-// Options: --no-includes --include-headers
-//
-// Keywords: kmalloc, kzalloc, kcalloc
-// Version min: < 2.6.12 kmalloc
-// Version min: < 2.6.12 kcalloc
-// Version min:   2.6.14 kzalloc
-//
-
-virtual context
-virtual patch
-virtual org
-virtual report
-
-//----------------------------------------------------------
-//  For context mode
-//----------------------------------------------------------
-
- at depends on context@
-type T;
-@@
-
-* (T *)
-  \(kmalloc\|kzalloc\|kcalloc\)(...)
-
-//----------------------------------------------------------
-//  For patch mode
-//----------------------------------------------------------
-
- at depends on patch@
-type T;
-@@
-
-- (T *)
-  \(kmalloc\|kzalloc\|kcalloc\)(...)
-
-//----------------------------------------------------------
-//  For org and report mode
-//----------------------------------------------------------
-
- at r depends on org || report@
-type T;
-position p;
-@@
-
- (T at p *)\(kmalloc\|kzalloc\|kcalloc\)(...)
-
- at script:python depends on org@
-p << r.p;
-t << r.T;
-@@
-
-coccilib.org.print_safe_todo(p[0], t)
-
-@script:python depends on report@
-p << r.p;
-t << r.T;
-@@
-
-msg="WARNING: casting value returned by k[cmz]alloc to (%s *) is useless." % (t)
-coccilib.report.print_report(p[0], msg)
-- 
1.9.1
