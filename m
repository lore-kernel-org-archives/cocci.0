From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Wed,  3 Feb 2016 19:05:46 +0100
Subject: [Cocci] [PATCH] coccinelle: bugon: reduce rule applicability
Message-ID: <1454522746-396-1-git-send-email-Julia.Lawall@lip6.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Rule r is only use in org or report mode, so only execute it in those
cases.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 scripts/coccinelle/misc/bugon.cocci |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccinelle/misc/bugon.cocci b/scripts/coccinelle/misc/bugon.cocci
index 27c97f1..7415860 100644
--- a/scripts/coccinelle/misc/bugon.cocci
+++ b/scripts/coccinelle/misc/bugon.cocci
@@ -40,7 +40,7 @@ expression e;
 //  For org and report mode
 //----------------------------------------------------------
 
- at r@
+ at r depends on (org || report)@
 expression e;
 position p;
 @@
