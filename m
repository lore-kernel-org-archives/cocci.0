From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Thu, 18 Feb 2016 00:16:14 +0100
Subject: [Cocci] [PATCH] scripts/coccinelle: modernize &
Message-ID: <1455750974-24339-1-git-send-email-Julia.Lawall@lip6.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

& is no longer allowed in column 0, since Coccinelle 1.0.4.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 scripts/coccinelle/iterators/use_after_iter.cocci |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccinelle/iterators/use_after_iter.cocci b/scripts/coccinelle/iterators/use_after_iter.cocci
index f085f59..ce8cc9c 100644
--- a/scripts/coccinelle/iterators/use_after_iter.cocci
+++ b/scripts/coccinelle/iterators/use_after_iter.cocci
@@ -123,7 +123,7 @@ list_remove_head(x,c,...)
 |
 sizeof(<+...c...+>)
 |
-&c->member
+ &c->member
 |
 c = E
 |
