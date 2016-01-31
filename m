From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sun, 31 Jan 2016 17:26:57 +0100
Subject: [Cocci] [PATCH] Coccinelle: pm_runtime: reduce rule applicability
Message-ID: <1454257617-3115-1-git-send-email-Julia.Lawall@lip6.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Rule r is only used in org or report mode, so only execute it in those
cases.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 scripts/coccinelle/api/pm_runtime.cocci |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccinelle/api/pm_runtime.cocci b/scripts/coccinelle/api/pm_runtime.cocci
index b7042d0..89b98a2 100644
--- a/scripts/coccinelle/api/pm_runtime.cocci
+++ b/scripts/coccinelle/api/pm_runtime.cocci
@@ -78,7 +78,7 @@ ret = pm_runtime_api(...);
 //  For org and report mode
 //----------------------------------------------------------
 
- at r depends on runtime_bad_err_handle exists@
+ at r depends on runtime_bad_err_handle && (org || report) exists@
 position p1, p2;
 identifier pm_runtime_api;
 expression ret;
