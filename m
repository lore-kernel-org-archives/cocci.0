From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Mon, 21 May 2018 08:58:59 +0200
Subject: [Cocci] [PATCH] coccinelle: deref_null: improve performance
Message-ID: <1526885939-1741-1-git-send-email-Julia.Lawall@lip6.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Move rules looking for some special cases of safe dereferences before
the collection of NULL-tested values.  The special cases are fairly
rare, but somewhat costly to find, because isomorphisms create many
variants of the rules.  There is thus no need to search for them over
and over for each NULL tested expression.  Collecting them just once
is sufficient and more efficient.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 scripts/coccinelle/null/deref_null.cocci |   40 +++++++++++++++----------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/scripts/coccinelle/null/deref_null.cocci b/scripts/coccinelle/null/deref_null.cocci
index b16ccb7..cbc6184 100644
--- a/scripts/coccinelle/null/deref_null.cocci
+++ b/scripts/coccinelle/null/deref_null.cocci
@@ -14,18 +14,10 @@ virtual context
 virtual org
 virtual report
 
- at ifm@
-expression *E;
-statement S1,S2;
-position p1;
-@@
-
-if at p1 ((E == NULL && ...) || ...) S1 else S2
-
 // The following two rules are separate, because both can match a single
 // expression in different ways
 @pr1 expression@
-expression *ifm.E;
+expression E;
 identifier f;
 position p1;
 @@
@@ -33,7 +25,7 @@ position p1;
  (E != NULL && ...) ? <+...E->f at p1...+> : ...
 
 @pr2 expression@
-expression *ifm.E;
+expression E;
 identifier f;
 position p2;
 @@
@@ -46,6 +38,14 @@ position p2;
  sizeof(<+...E->f at p2...+>)
 )
 
+ at ifm@
+expression *E;
+statement S1,S2;
+position p1;
+@@
+
+if at p1 ((E == NULL && ...) || ...) S1 else S2
+
 // For org and report modes
 
 @r depends on !context && (org || report) exists@
@@ -212,16 +212,8 @@ else S3
 // The following three rules are duplicates of ifm, pr1 and pr2 respectively.
 // It is need because the previous rule as already made a "change".
 
- at ifm1 depends on context && !org && !report@
-expression *E;
-statement S1,S2;
-position p1;
-@@
-
-if at p1 ((E == NULL && ...) || ...) S1 else S2
-
 @pr11 depends on context && !org && !report expression@
-expression *ifm1.E;
+expression E;
 identifier f;
 position p1;
 @@
@@ -229,7 +221,7 @@ position p1;
  (E != NULL && ...) ? <+...E->f at p1...+> : ...
 
 @pr12 depends on context && !org && !report expression@
-expression *ifm1.E;
+expression E;
 identifier f;
 position p2;
 @@
@@ -242,6 +234,14 @@ position p2;
  sizeof(<+...E->f at p2...+>)
 )
 
+ at ifm1 depends on context && !org && !report@
+expression *E;
+statement S1,S2;
+position p1;
+@@
+
+if at p1 ((E == NULL && ...) || ...) S1 else S2
+
 @depends on context && !org && !report exists@
 expression subE <= ifm1.E;
 expression *ifm1.E;
