From: festevam@gmail.com (Fabio Estevam)
Date: Sat,  9 May 2015 17:09:28 -0300
Subject: [Cocci] [PATCH v2 2/4] coccinelle: returnvar: Use imperative mood
In-Reply-To: <1431202170-18055-1-git-send-email-festevam@gmail.com>
References: <1431202170-18055-1-git-send-email-festevam@gmail.com>
Message-ID: <1431202170-18055-2-git-send-email-festevam@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: Fabio Estevam <fabio.estevam@freescale.com>

According to Documentation/SubmittingPatches:

"Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
to do frotz", as if you are giving orders to the codebase to change
its behaviour."

So do as recommended.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Acked-by: Julia Lawall <julia.lawall@lip6.fr>
---
Changes since v1:
- None

 scripts/coccinelle/misc/returnvar.cocci | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccinelle/misc/returnvar.cocci b/scripts/coccinelle/misc/returnvar.cocci
index 605955a..d8286ef 100644
--- a/scripts/coccinelle/misc/returnvar.cocci
+++ b/scripts/coccinelle/misc/returnvar.cocci
@@ -1,5 +1,5 @@
 ///
-/// Removes unneeded variable used to store return value.
+/// Remove unneeded variable used to store return value.
 ///
 // Confidence: Moderate
 // Copyright: (C) 2012 Peter Senna Tschudin, INRIA/LIP6.  GPLv2.
-- 
1.9.1
