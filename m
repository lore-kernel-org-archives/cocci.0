From: festevam@gmail.com (Fabio Estevam)
Date: Sat,  9 May 2015 17:09:27 -0300
Subject: [Cocci] [PATCH v2 1/4] coccinelle: pm_runtime: Insert blank line
Message-ID: <1431202170-18055-1-git-send-email-festevam@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: Fabio Estevam <fabio.estevam@freescale.com>

Insert a blank line in order to improve the readability of the
generated patch and also make it consistent with the other
.cocci files.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Replace // with /// as suggested by Julia

 scripts/coccinelle/api/pm_runtime.cocci | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccinelle/api/pm_runtime.cocci b/scripts/coccinelle/api/pm_runtime.cocci
index f01789e..b7042d0 100644
--- a/scripts/coccinelle/api/pm_runtime.cocci
+++ b/scripts/coccinelle/api/pm_runtime.cocci
@@ -1,5 +1,5 @@
 /// Make sure pm_runtime_* calls does not use unnecessary IS_ERR_VALUE
-//
+///
 // Keywords: pm_runtime
 // Confidence: Medium
 // Copyright (C) 2013 Texas Instruments Incorporated - GPLv2.
-- 
1.9.1
