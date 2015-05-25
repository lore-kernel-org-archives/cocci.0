From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 25 May 2015 08:46:12 -0300
Subject: [Cocci] [PATCH 1/2] coccinelle: clk_put.cocci: Adjust commit log of
	generated patch
Message-ID: <1432554373-6444-1-git-send-email-fabio.estevam@freescale.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

The commit log should better describe the action that the patch will do.

In this case we are 'adding' the missing clk_put.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 scripts/coccinelle/free/clk_put.cocci | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccinelle/free/clk_put.cocci b/scripts/coccinelle/free/clk_put.cocci
index 46747ad..492b3b0 100644
--- a/scripts/coccinelle/free/clk_put.cocci
+++ b/scripts/coccinelle/free/clk_put.cocci
@@ -1,4 +1,4 @@
-/// Find missing clk_puts.
+/// Add missing clk_put.
 ///
 //# This only signals a missing clk_put when there is a clk_put later
 //# in the same function.
-- 
1.9.1
