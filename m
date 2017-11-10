From: himanshujha199640@gmail.com (Himanshu Jha)
Date: Fri, 10 Nov 2017 17:54:47 +0530
Subject: [Cocci] [PATCH] Coccinelle: Add
	scripts/coccinelle/alloc/vzalloc-simple.cocci
Message-ID: <1510316687-5741-1-git-send-email-himanshujha199640@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Use vzalloc rather than vmalloc followed by memset with region of memory
filled with 0 value.

It considers only simple cases.
0-day tested without any issues.

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 scripts/coccinelle/api/alloc/vzalloc-simple.cocci | 75 +++++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 scripts/coccinelle/api/alloc/vzalloc-simple.cocci

diff --git a/scripts/coccinelle/api/alloc/vzalloc-simple.cocci b/scripts/coccinelle/api/alloc/vzalloc-simple.cocci
new file mode 100644
index 0000000..c9c3b20
--- /dev/null
+++ b/scripts/coccinelle/api/alloc/vzalloc-simple.cocci
@@ -0,0 +1,75 @@
+/// 
+/// Use vzalloc instead of vmalloc followed by memset 0
+///
+// Confidence: High
+// Copyright: (C) 2017 Himanshu Jha GPLv2.
+// Options: --no-includes --include-headers
+//
+// Keywords: vzalloc, vmalloc
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
+type T, T1;
+expression x,E1;
+statement S;
+@@
+
+* x = (T)vzalloc(E1);
+  if ((x == NULL) || ...) S
+* memset((T1)x, 0, E1);
+
+//----------------------------------------------------------
+//  For patch mode
+//----------------------------------------------------------
+
+ at depends on patch@
+type T, T1;
+expression x,E1;
+statement S;
+@@
+
+- x = (T)vmalloc(E1);
++ x = vzalloc(E1);
+  if ((x == NULL) || ...) S
+- memset((T1)x, 0, E1);
+
+//----------------------------------------------------------
+//  For org mode and report mode
+//----------------------------------------------------------
+
+ at r depends on org || report@
+type T, T1;
+expression x,E1;
+statement S;
+position p;
+@@
+
+ x = (T)vmalloc at p(E1);
+ if ((x==NULL) || ...) S
+ memset((T1)x, 0, E1);
+
+ at script:python depends on org@
+p << r.p;
+x << r.x;
+@@
+
+msg="%s" % (x)
+msg_safe=msg.replace("[","@(").replace("]",")")
+coccilib.org.print_todo(p[0], msg_safe)
+
+@script:python depends on report@
+p << r.p;
+x << r.x;
+@@
+
+msg="WARNING: vzalloc should be used for %s, instead of vmalloc/memset" % (x)
+coccilib.report.print_report(p[0], msg)	
-- 
2.7.4
