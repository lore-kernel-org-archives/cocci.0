From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Wed, 21 Sep 2016 17:48:39 +0200
Subject: [Cocci] [PATCH] Coccinelle: limit memdup_user transformation to
	GFP_KERNEL case
Message-ID: <1474472919-12867-1-git-send-email-Julia.Lawall@lip6.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Memdup_user encapsulates a memory allocation with the flag GFP_KERNEL, so
only allow this flag in the original code.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 scripts/coccinelle/api/memdup_user.cocci |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/coccinelle/api/memdup_user.cocci b/scripts/coccinelle/api/memdup_user.cocci
index c606231..2a5aea8 100644
--- a/scripts/coccinelle/api/memdup_user.cocci
+++ b/scripts/coccinelle/api/memdup_user.cocci
@@ -15,11 +15,11 @@ virtual org
 virtual report
 
 @depends on patch@
-expression from,to,size,flag;
+expression from,to,size;
 identifier l1,l2;
 @@
 
--  to = \(kmalloc\|kzalloc\)(size,flag);
+-  to = \(kmalloc\|kzalloc\)(size,GFP_KERNEL);
 +  to = memdup_user(from,size);
    if (
 -      to==NULL
@@ -37,12 +37,12 @@ identifier l1,l2;
 -  }
 
 @r depends on !patch@
-expression from,to,size,flag;
+expression from,to,size;
 position p;
 statement S1,S2;
 @@
 
-*  to = \(kmalloc at p\|kzalloc at p\)(size,flag);
+*  to = \(kmalloc at p\|kzalloc at p\)(size,GFP_KERNEL);
    if (to==NULL || ...) S1
    if (copy_from_user(to, from, size) != 0)
    S2
