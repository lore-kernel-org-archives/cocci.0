From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 11 Aug 2015 00:15:34 -0300
Subject: [Cocci] [PATCH] coccinelle: pm_runtime: Fix grammar and typo
Message-ID: <1439262934-8377-1-git-send-email-festevam@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: Fabio Estevam <fabio.estevam@freescale.com>

Fix the grammar to "calls do not use" and also fix the spelling of
"Unnecessary".

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 scripts/coccinelle/api/pm_runtime.cocci | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/coccinelle/api/pm_runtime.cocci b/scripts/coccinelle/api/pm_runtime.cocci
index b7042d0..27eb875 100644
--- a/scripts/coccinelle/api/pm_runtime.cocci
+++ b/scripts/coccinelle/api/pm_runtime.cocci
@@ -1,4 +1,4 @@
-/// Make sure pm_runtime_* calls does not use unnecessary IS_ERR_VALUE
+/// Make sure pm_runtime_* calls do not use unnecessary IS_ERR_VALUE
 ///
 // Keywords: pm_runtime
 // Confidence: Medium
@@ -105,5 +105,5 @@ p2 << r.p2;
 pm_runtime_api << r.pm_runtime_api;
 @@
 
-msg = "%s returns < 0 as error. Unecessary IS_ERR_VALUE at line %s" % (pm_runtime_api, p2[0].line)
+msg = "%s returns < 0 as error. Unnecessary IS_ERR_VALUE@line %s" % (pm_runtime_api, p2[0].line)
 coccilib.report.print_report(p1[0],msg)
-- 
1.9.1
