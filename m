From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sat, 23 Aug 2014 07:31:37 +0200
Subject: [Cocci]
	=?y?q?=5BPATCH=5D=20coccinelle=3A=20misc=3A=20semantic=20patch=20to=20delete=20overly=20complex=20return=20code=20processing?=
Message-ID: <1408771897-28778-1-git-send-email-Julia.Lawall@lip6.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: Julia Lawall <julia@diku.dk>

This semantic patch simplifies cases where the effect of the processing of
a function call's return code is just to return the result of the function
directly.  It may also delete a local return flag variable, if this is no
longer used.

This was proposed by Uwe Kleine-K??nig.

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 scripts/coccinelle/misc/simple_return.cocci |  180 ++++++++++++++++++++++++++++
 1 file changed, 180 insertions(+)

diff --git a/scripts/coccinelle/misc/simple_return.cocci b/scripts/coccinelle/misc/simple_return.cocci
new file mode 100644
index 0000000..47f7084
--- /dev/null
+++ b/scripts/coccinelle/misc/simple_return.cocci
@@ -0,0 +1,180 @@
+/// Simplify a trivial if-return sequence.  Possibly combine with a
+/// preceding function call.
+//
+// Confidence: High
+// Copyright: (C) 2014 Julia Lawall, INRIA/LIP6.  GPLv2.
+// Copyright: (C) 2014 Gilles Muller, INRIA/LiP6.  GPLv2.
+// URL: http://coccinelle.lip6.fr/
+// Comments:
+// Options: --no-includes --include-headers
+
+virtual patch
+virtual context
+virtual org
+virtual report
+
+ at r depends on patch@
+local idexpression e;
+identifier i,f,fn;
+@@
+
+fn(...) { <...
+- e@i =
++ return
+    f(...);
+-if (i != 0) return i;
+-return 0;
+...> }
+
+ at depends on patch@
+identifier r.i;
+type t;
+@@
+
+-t i;
+ ... when != i
+
+ at depends on patch@
+expression e;
+@@
+
+-if (e != 0)
+   return e;
+-return 0;
+
+// -----------------------------------------------------------------------
+
+ at s1 depends on context || org || report@
+local idexpression e;
+identifier i,f,fn;
+position p,p1,p2;
+@@
+
+fn(...) { <...
+* e at i@p = f(...);
+  if (\(i at p1 != 0\|i@p2 < 0\))
+     return i;
+  return 0;
+...> }
+
+ at s2 depends on context || org || report forall@
+identifier s1.i;
+type t;
+position q,s1.p;
+expression e,f;
+@@
+
+* t i at q;
+  ... when != i
+  e at p = f(...);
+
+ at s3 depends on context || org || report@
+expression e;
+position p1!=s1.p1;
+position p2!=s1.p2;
+@@
+
+*if (\(e at p1 != 0\|e at p2 < 0\))
+   return e;
+ return 0;
+
+// -----------------------------------------------------------------------
+
+ at script:python depends on org@
+p << s1.p;
+p1 << s1.p1;
+q << s2.q;
+@@
+
+cocci.print_main("decl",q)
+cocci.print_secs("use",p)
+cocci.include_match(False)
+
+ at script:python depends on org@
+p << s1.p;
+p2 << s1.p2;
+q << s2.q;
+@@
+
+cocci.print_main("decl",q)
+cocci.print_secs("use with questionable test",p)
+cocci.include_match(False)
+
+ at script:python depends on org@
+p << s1.p;
+p1 << s1.p1;
+@@
+
+cocci.print_main("use",p)
+
+ at script:python depends on org@
+p << s1.p;
+p2 << s1.p2;
+@@
+
+cocci.print_main("use with questionable test",p)
+
+ at script:python depends on org@
+p << s3.p1;
+@@
+
+cocci.print_main("test",p)
+
+ at script:python depends on org@
+p << s3.p2;
+@@
+
+cocci.print_main("questionable test",p)
+
+// -----------------------------------------------------------------------
+
+ at script:python depends on report@
+p << s1.p;
+p1 << s1.p1;
+q << s2.q;
+@@
+
+msg = "WARNING: end returns can be simpified and declaration on line %s can be dropped" % (q[0].line)
+coccilib.report.print_report(p[0],msg)
+cocci.include_match(False)
+
+ at script:python depends on report@
+p << s1.p;
+p1 << s1.p1;
+q << s2.q
+;
+@@
+
+msg = "WARNING: end returns may be simpified if negative or 0 value and declaration on line %s can be dropped" % (q[0].line)
+coccilib.report.print_report(p[0],msg)
+cocci.include_match(False)
+
+ at script:python depends on report@
+p << s1.p;
+p1 << s1.p1;
+@@
+
+msg = "WARNING: end returns can be simpified"
+coccilib.report.print_report(p[0],msg)
+
+ at script:python depends on report@
+p << s1.p;
+p2 << s1.p2;
+@@
+
+msg = "WARNING: end returns can be simpified if negative or 0 value"
+coccilib.report.print_report(p[0],msg)
+
+ at script:python depends on report@
+p << s3.p1;
+@@
+
+msg = "WARNING: end returns can be simpified"
+coccilib.report.print_report(p[0],msg)
+
+@script:python depends on report@
+p << s3.p2;
+@@
+
+msg = "WARNING: end returns can be simpified if tested value is negative or 0"
+coccilib.report.print_report(p[0],msg)
