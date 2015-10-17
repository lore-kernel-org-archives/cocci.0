From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sat, 17 Oct 2015 11:35:46 +0200
Subject: [Cocci] [PATCH] scripts/coccinelle: fix typos
Message-ID: <1445074546-22023-1-git-send-email-Julia.Lawall@lip6.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Fix a couple spelling mistakes.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 scripts/coccinelle/null/deref_null.cocci |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/coccinelle/null/deref_null.cocci b/scripts/coccinelle/null/deref_null.cocci
index cdac6cf..f192d60 100644
--- a/scripts/coccinelle/null/deref_null.cocci
+++ b/scripts/coccinelle/null/deref_null.cocci
@@ -1,6 +1,6 @@
 ///
-/// A variable is dereference under a NULL test.
-/// Even though it is know to be NULL.
+/// A variable is dereferenced under a NULL test.
+/// Even though it is known to be NULL.
 ///
 // Confidence: Moderate
 // Copyright: (C) 2010 Nicolas Palix, DIKU.  GPLv2.
