From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 20 May 2015 08:02:34 -0300
Subject: [Cocci] [PATCH 1/2 RESEND] scripts/coccinelle/misc/semicolon.cocci:
	Use imperative mood
Message-ID: <1432119755-4266-1-git-send-email-festevam@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: Fabio Estevam <fabio.estevam@freescale.com>

According to Documentation/SubmittingPatches:

"Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
to do frotz", as if you are giving orders to the codebase to change
its behaviour.

So do as recommended.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Acked-by: Julia Lawall <julia.lawall@lip6.fr>
---
 scripts/coccinelle/misc/semicolon.cocci | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccinelle/misc/semicolon.cocci b/scripts/coccinelle/misc/semicolon.cocci
index a47eba2..6740c65 100644
--- a/scripts/coccinelle/misc/semicolon.cocci
+++ b/scripts/coccinelle/misc/semicolon.cocci
@@ -1,5 +1,5 @@
 ///
-/// Removes unneeded semicolon.
+/// Remove unneeded semicolon.
 ///
 // Confidence: Moderate
 // Copyright: (C) 2012 Peter Senna Tschudin, INRIA/LIP6.  GPLv2.
-- 
1.9.1
