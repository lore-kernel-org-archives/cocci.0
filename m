From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sat, 30 Jan 2016 17:13:54 +0100
Subject: [Cocci] [PATCH] Coccinelle: array_size: reduce rule applicability
Message-ID: <1454170434-23265-1-git-send-email-Julia.Lawall@lip6.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Rule r is only use in org or report mode, so only execute it in those
cases.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 scripts/coccinelle/misc/array_size.cocci |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccinelle/misc/array_size.cocci b/scripts/coccinelle/misc/array_size.cocci
index 81e279c..6ec0571 100644
--- a/scripts/coccinelle/misc/array_size.cocci
+++ b/scripts/coccinelle/misc/array_size.cocci
@@ -59,7 +59,7 @@ T[] E;
 //  For org and report mode
 //----------------------------------------------------------
 
- at r@
+ at r depends on (org || report)@
 type T;
 T[] E;
 position p;
