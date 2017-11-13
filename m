From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 13 Nov 2017 06:53:35 +0100 (CET)
Subject: [Cocci] [PATCH v2] coccinelle: orplus: reorganize to improve
	performance
Message-ID: <alpine.DEB.2.20.1711130649370.2483@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Adding two #define constants is less common than performing & and |
operations on them, so put the addition first to reduce the set of cases
that have to be considered in detail.  At the same time, add & and |
patterns for both arguments of +, to account for commutativity and obtain
more results.

Running time is divided by 3 when applying this to the whole kernel on my
laptop with an Intel i5-6200U CPU.

Signed-off-by: Julia Lawall <julia.lawall@lip6.fr>

---

v2: added SOB and fixed typos in the commit message

diff --git a/scripts/coccinelle/misc/orplus.cocci b/scripts/coccinelle/misc/orplus.cocci
index 81fabf3..08de5be 100644
--- a/scripts/coccinelle/misc/orplus.cocci
+++ b/scripts/coccinelle/misc/orplus.cocci
@@ -14,7 +14,19 @@ virtual report
 virtual context

 @r@
-constant c;
+constant c,c1;
+identifier i,i1;
+position p;
+@@
+
+(
+ c1 + c - 1
+|
+ c1 at i1 + at p c at i
+)
+
+ at s@
+constant r.c, r.c1;
 identifier i;
 expression e;
 @@
@@ -27,28 +39,31 @@ e & c at i
 e |= c at i
 |
 e &= c at i
+|
+e | c1 at i
+|
+e & c1 at i
+|
+e |= c1 at i
+|
+e &= c1 at i
 )

- at s@
-constant r.c,c1;
-identifier i1;
-position p;
+ at depends on s@
+position r.p;
+constant c1,c2;
 @@

-(
- c1 + c - 1
-|
-*c1 at i1 + at p c
-)
+* c1 + at p c2

- at script:python depends on org@
-p << s.p;
+ at script:python depends on s && org@
+p << r.p;
 @@

 cocci.print_main("sum of probable bitmasks, consider |",p)

- at script:python depends on report@
-p << s.p;
+@script:python depends on s && report@
+p << r.p;
 @@

 msg = "WARNING: sum of probable bitmasks, consider |"
