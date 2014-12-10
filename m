From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Wed, 10 Dec 2014 21:08:43 +0100
Subject: [Cocci] [PATCH] scripts: coccinelle: add uses of memzero_explicit
Message-ID: <1418242123-8610-1-git-send-email-Julia.Lawall@lip6.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Memzero_explicit is a version of memset that is resistent to compiler
optimizations when the set region is about to go out of scope.

This was suggested by Daniel Borkmann

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 scripts/coccinelle/api/memzero_explicit.cocci |  289 ++++++++++++++++++++++++++
 1 file changed, 289 insertions(+)

diff --git a/scripts/coccinelle/api/memzero_explicit.cocci b/scripts/coccinelle/api/memzero_explicit.cocci
new file mode 100644
index 0000000..bec0350
--- /dev/null
+++ b/scripts/coccinelle/api/memzero_explicit.cocci
@@ -0,0 +1,289 @@
+/// Replace memset on a variable that is about to go out of scope by
+/// memzero_explicit to prevent removal by compiler optimizations.
+///
+// Confidence: High
+// Copyright: (C) 2014 Julia Lawall, Inria, GPLv2
+
+virtual patch
+virtual context
+virtual org
+virtual report
+
+ at ar1 depends on patch && !context && !org && !report@
+identifier x;
+local idexpression e;
+type T,T1;
+@@
+
+{
+... when any
+T x[...];
+... when any
+    when exists
+(
+e = (T1)x
+|
+e = (T1)&x[0]
+)
+... when any
+    when exists
+- memset
++ memzero_explicit
+  (x,
+-0,
+  ...)
+... when != x
+    when != e
+    when strict
+}
+
+ at str1 depends on patch && !context && !org && !report@
+identifier x;
+local idexpression e;
+type T,T1;
+@@
+
+{
+... when any
+T1 x;
+... when any
+    when exists
+e = (T)&x
+... when any
+    when exists
+- memset
++ memzero_explicit
+  (&x,
+-0,
+  ...)
+... when != x
+    when != e
+    when strict
+}
+
+// ------------------------------------------------------------------------
+
+ at ar2 depends on patch && !context && !org && !report@
+identifier x;
+type T,T1;
+expression e;
+@@
+
+{
+... when any
+T x[...];
+... when any
+    when exists
+    when != e = (T1)x
+    when != e = (T1)&x[0]
+- memset
++ memzero_explicit
+  (x,
+-0,
+  ...)
+... when != x
+    when strict
+}
+
+ at str2 depends on patch && !context && !org && !report@
+identifier x;
+expression e;
+type T,T1;
+@@
+
+{
+... when any
+T1 x;
+... when any
+    when exists
+    when != e = (T)&x
+- memset
++ memzero_explicit
+  (&x,
+-0,
+  ...)
+... when != x
+    when strict
+}
+
+// ----------------------------------------------------------------------------
+
+ at ar1_context depends on !patch && (context || org || report)@
+type T, T1;
+identifier x;
+local idexpression e;
+position j0, j1, j2;
+@@
+
+{
+... when any
+T x at j1[...];
+... when any
+    when exists
+(
+e at j2 = (T1)x
+|
+e at j2 = (T1)&x[0]
+)
+... when any
+    when exists
+ memset at j0
+  (x,
+* 0,
+  ...)
+... when != x
+    when != e
+    when strict
+    when forall
+}
+
+ at str1_context depends on !patch && (context || org || report)@
+type T, T1;
+identifier x;
+local idexpression e;
+position j0, j1, j2;
+@@
+
+{
+... when any
+T1 x at j1;
+... when any
+    when exists
+e at j2 = (T)&x
+... when any
+    when exists
+ memset at j0
+  (&x,
+* 0,
+  ...)
+... when != x
+    when != e
+    when strict
+    when forall
+}
+
+ at ar2_context depends on !patch && (context || org || report)@
+type T, T1;
+identifier x;
+expression e;
+position j0, j1;
+@@
+
+{
+... when any
+T x at j1[...];
+... when any
+    when exists
+    when != e = (T1)x
+    when != e = (T1)&x[0]
+ memset at j0
+  (x,
+* 0,
+  ...)
+... when != x
+    when strict
+    when forall
+}
+
+ at str2_context depends on !patch && (context || org || report)@
+type T, T1;
+identifier x;
+expression e;
+position j0, j1;
+@@
+
+{
+... when any
+T1 x at j1;
+... when any
+    when exists
+    when != e = (T)&x
+ memset at j0
+  (&x,
+* 0,
+  ...)
+... when != x
+    when strict
+    when forall
+}
+
+// ----------------------------------------------------------------------------
+
+ at script:python ar1_org depends on org@
+j0 << ar1_context.j0;
+j1 << ar1_context.j1;
+j2 << ar1_context.j2;
+@@
+
+msg = "Memset call."
+coccilib.org.print_todo(j0[0], msg)
+coccilib.org.print_link(j1[0], "declaration")
+coccilib.org.print_link(j2[0], "alias")
+
+ at script:python str1_org depends on org@
+j0 << str1_context.j0;
+j1 << str1_context.j1;
+j2 << str1_context.j2;
+@@
+
+msg = "Memset call."
+coccilib.org.print_todo(j0[0], msg)
+coccilib.org.print_link(j1[0], "declaration")
+coccilib.org.print_link(j2[0], "alias")
+
+ at script:python ar2_org depends on org@
+j0 << ar2_context.j0;
+j1 << ar2_context.j1;
+@@
+
+msg = "Memset call."
+coccilib.org.print_todo(j0[0], msg)
+coccilib.org.print_link(j1[0], "declaration")
+
+ at script:python str2_org depends on org@
+j0 << str2_context.j0;
+j1 << str2_context.j1;
+@@
+
+msg = "Memset call."
+coccilib.org.print_todo(j0[0], msg)
+coccilib.org.print_link(j1[0], "declaration")
+
+// ----------------------------------------------------------------------------
+
+ at script:python ar1_report depends on report@
+j0 << ar1_context.j0;
+j1 << ar1_context.j1;
+j2 << ar1_context.j2;
+@@
+
+msg = "Memset call, declaration on line %s, alias on line %s." % \
+           (j1[0].line,j2[0].line)
+coccilib.report.print_report(j0[0], msg)
+
+ at script:python str1_report depends on report@
+j0 << str1_context.j0;
+j1 << str1_context.j1;
+j2 << str1_context.j2;
+@@
+
+msg = "Memset call, declaration on line %s, alias on line %s." % \
+           (j1[0].line,j2[0].line)
+coccilib.report.print_report(j0[0], msg)
+
+ at script:python ar2_report depends on report@
+j0 << ar2_context.j0;
+j1 << ar2_context.j1;
+@@
+
+msg = "Memset call, declaration on line %s." % (j1[0].line)
+coccilib.report.print_report(j0[0], msg)
+
+@script:python str2_report depends on report@
+j0 << str2_context.j0;
+j1 << str2_context.j1;
+@@
+
+msg = "Memset call declaration on line %s." % (j1[0].line)
+coccilib.report.print_report(j0[0], msg)
+
