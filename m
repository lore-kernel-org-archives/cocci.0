From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Mon, 26 Oct 2015 22:28:26 +0100
Subject: [Cocci] [PATCH 2/2 v2] coccinelle: ifnullfree: handle various
	destroy functions
Message-ID: <1445894906-28137-2-git-send-email-Julia.Lawall@lip6.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Extend ifnullfree to the various destroy functions that were recently
extended to tolerate NULL arguments.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
v2: better subject

 scripts/coccinelle/free/ifnullfree.cocci |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/scripts/coccinelle/free/ifnullfree.cocci b/scripts/coccinelle/free/ifnullfree.cocci
index d4a072d..52bd235 100644
--- a/scripts/coccinelle/free/ifnullfree.cocci
+++ b/scripts/coccinelle/free/ifnullfree.cocci
@@ -25,6 +25,12 @@ expression E;
   debugfs_remove_recursive(E);
 |
   usb_free_urb(E);
+|
+  kmem_cache_destroy(E);
+|
+  mempool_destroy(E);
+|
+  dma_pool_destroy(E);
 )
 
 @r depends on context || report || org @
@@ -33,7 +39,9 @@ position p;
 @@
 
 * if (E != NULL)
-*	\(kfree at p\|debugfs_remove at p\|debugfs_remove_recursive at p\|usb_free_urb at p\)(E);
+*	\(kfree at p\|debugfs_remove at p\|debugfs_remove_recursive at p\|
+*         usb_free_urb at p\|kmem_cache_destroy at p\|mempool_destroy at p\|
+*         dma_pool_destroy at p\)(E);
 
 @script:python depends on org@
 p << r.p;
