From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sat,  3 Feb 2018 08:44:58 +0100
Subject: [Cocci] [PATCH] coccinelle: deref_null: avoid useless computation
Message-ID: <1517643898-2801-1-git-send-email-Julia.Lawall@lip6.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

The effect of the rules ifm1, pr11, and pr12 is only used in the final rule,
which depends on context && !org && !report.  Thus these rules should only
be performed in those circumstances.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 scripts/coccinelle/null/deref_null.cocci |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/coccinelle/null/deref_null.cocci b/scripts/coccinelle/null/deref_null.cocci
index f192d60..b16ccb7 100644
--- a/scripts/coccinelle/null/deref_null.cocci
+++ b/scripts/coccinelle/null/deref_null.cocci
@@ -212,7 +212,7 @@ else S3
 // The following three rules are duplicates of ifm, pr1 and pr2 respectively.
 // It is need because the previous rule as already made a "change".
 
- at ifm1@
+ at ifm1 depends on context && !org && !report@
 expression *E;
 statement S1,S2;
 position p1;
@@ -220,7 +220,7 @@ position p1;
 
 if at p1 ((E == NULL && ...) || ...) S1 else S2
 
- at pr11 expression@
+ at pr11 depends on context && !org && !report expression@
 expression *ifm1.E;
 identifier f;
 position p1;
@@ -228,7 +228,7 @@ position p1;
 
  (E != NULL && ...) ? <+...E->f at p1...+> : ...
 
- at pr12 expression@
+ at pr12 depends on context && !org && !report expression@
 expression *ifm1.E;
 identifier f;
 position p2;
