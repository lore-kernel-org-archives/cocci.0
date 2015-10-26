From: falakreyaz@gmail.com (Muhammad Falak R Wani)
Date: Mon, 26 Oct 2015 20:55:07 +0530
Subject: [Cocci] [PATCH] coccinelle: deref_null: Fix a spelling typo.
Message-ID: <1445873107-5592-1-git-send-email-falakreyaz@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Dereference was modified to dereferenced, as it made more sense.

Signed-off-by: Muhammad Falak R Wani <falakreyaz@gmail.com>
---
 scripts/coccinelle/null/deref_null.cocci | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccinelle/null/deref_null.cocci b/scripts/coccinelle/null/deref_null.cocci
index cdac6cf..79df11e 100644
--- a/scripts/coccinelle/null/deref_null.cocci
+++ b/scripts/coccinelle/null/deref_null.cocci
@@ -1,5 +1,5 @@
 ///
-/// A variable is dereference under a NULL test.
+/// A variable is dereferenced under a NULL test.
 /// Even though it is know to be NULL.
 ///
 // Confidence: Moderate
-- 
1.9.1
