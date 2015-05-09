From: festevam@gmail.com (Fabio Estevam)
Date: Sat,  9 May 2015 16:48:47 -0300
Subject: [Cocci] [PATCH 1/4] coccinelle: pm_runtime: Insert blank line
Message-ID: <1431200930-16961-1-git-send-email-festevam@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: Fabio Estevam <fabio.estevam@freescale.com>

Insert a blank line in order to improve the readability of the 
generated patch and also make it consistent with the other 
.cocci files.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 scripts/coccinelle/api/pm_runtime.cocci | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/coccinelle/api/pm_runtime.cocci b/scripts/coccinelle/api/pm_runtime.cocci
index f01789e..9208aa1 100644
--- a/scripts/coccinelle/api/pm_runtime.cocci
+++ b/scripts/coccinelle/api/pm_runtime.cocci
@@ -1,4 +1,5 @@
 /// Make sure pm_runtime_* calls does not use unnecessary IS_ERR_VALUE
+///
 //
 // Keywords: pm_runtime
 // Confidence: Medium
-- 
1.9.1
