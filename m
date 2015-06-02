From: festevam@gmail.com (Fabio Estevam)
Date: Mon,  1 Jun 2015 22:52:20 -0300
Subject: [Cocci] [PATCH] coccinelle: simple_return: Add a blank line
Message-ID: <1433209940-19303-1-git-send-email-festevam@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: Fabio Estevam <fabio.estevam@freescale.com>

Insert a blank line in order to improve the readability of the
generated patch and also make it consistent with the other
.cocci files.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 scripts/coccinelle/misc/simple_return.cocci | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccinelle/misc/simple_return.cocci b/scripts/coccinelle/misc/simple_return.cocci
index 47f7084..e8b6313 100644
--- a/scripts/coccinelle/misc/simple_return.cocci
+++ b/scripts/coccinelle/misc/simple_return.cocci
@@ -1,6 +1,6 @@
 /// Simplify a trivial if-return sequence.  Possibly combine with a
 /// preceding function call.
-//
+///
 // Confidence: High
 // Copyright: (C) 2014 Julia Lawall, INRIA/LIP6.  GPLv2.
 // Copyright: (C) 2014 Gilles Muller, INRIA/LiP6.  GPLv2.
-- 
1.9.1
