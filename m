From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Mon, 11 Aug 2014 12:24:13 +0200
Subject: [Cocci] [PATCH] scripts/coccinelle/free/ifnullfree.cocci: simplify
	and extend to of_node_put
Message-ID: <1407752653-16883-1-git-send-email-Julia.Lawall@lip6.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: Julia Lawall <Julia.Lawall@lip6.fr>

Three changes:

* Don't remove and add function calls in the patch case
* Add of_node_put as a considered function
* Add a missing position variable on usb_free_urb

The need for the last change was spotted by SF Markus Elfring.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 scripts/coccinelle/free/ifnullfree.cocci |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/scripts/coccinelle/free/ifnullfree.cocci b/scripts/coccinelle/free/ifnullfree.cocci
index a42d70b..31be901 100644
--- a/scripts/coccinelle/free/ifnullfree.cocci
+++ b/scripts/coccinelle/free/ifnullfree.cocci
@@ -18,17 +18,15 @@ expression E;
 @@
 - if (E)
 (
--	kfree(E);
-+ kfree(E);
+	kfree(E);
 |
--	debugfs_remove(E);
-+ debugfs_remove(E);
+	debugfs_remove(E);
 |
--	debugfs_remove_recursive(E);
-+ debugfs_remove_recursive(E);
+	debugfs_remove_recursive(E);
 |
--	usb_free_urb(E);
-+ usb_free_urb(E);
+	usb_free_urb(E);
+|
+	of_node_put(E);
 )
 
 @r depends on context || report || org @
@@ -37,7 +35,8 @@ position p;
 @@
 
 * if (E)
-*	\(kfree at p\|debugfs_remove at p\|debugfs_remove_recursive at p\|usb_free_urb\)(E);
+*  \(kfree at p\|debugfs_remove at p\|debugfs_remove_recursive at p\|usb_free_urb at p\|
+*    of_node_put at p\)(E);
 
 @script:python depends on org@
 p << r.p;
