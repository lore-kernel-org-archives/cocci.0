From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sat, 27 Jan 2018 19:23:36 +0100
Subject: [Cocci] [PATCH] Coccinelle: memdup: drop spurious line
Message-ID: <1517077416-17848-1-git-send-email-Julia.Lawall@lip6.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

The kmemdup line in the non-patch case was left over from the added kmemdup
line in the patch case.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 scripts/coccinelle/api/memdup.cocci |    1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/coccinelle/api/memdup.cocci b/scripts/coccinelle/api/memdup.cocci
index 3d1aa71..1249b72 100644
--- a/scripts/coccinelle/api/memdup.cocci
+++ b/scripts/coccinelle/api/memdup.cocci
@@ -49,7 +49,6 @@ statement S;
 @@
 
 *  to = \(kmalloc at p\|kzalloc at p\)(size,flag);
-   to = kmemdup(from,size,flag);
    if (to==NULL || ...) S
 *  memcpy(to, from, size);
 
