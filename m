From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Mon, 26 Oct 2015 22:28:25 +0100
Subject: [Cocci] [PATCH 1/2 v2] coccinelle: ifnullfree: various cleanups
Message-ID: <1445894906-28137-1-git-send-email-Julia.Lawall@lip6.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Adjust tests to compare against NULL, to match cases that explicitly make
that comparison.

Remove removal and re-addition of freeing functions.

Add position variable on usb_free_urb in the non-patch case.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
v2: better subject

 scripts/coccinelle/free/ifnullfree.cocci |   18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/scripts/coccinelle/free/ifnullfree.cocci b/scripts/coccinelle/free/ifnullfree.cocci
index a42d70b..d4a072d 100644
--- a/scripts/coccinelle/free/ifnullfree.cocci
+++ b/scripts/coccinelle/free/ifnullfree.cocci
@@ -16,19 +16,15 @@ virtual context
 @r2 depends on patch@
 expression E;
 @@
-- if (E)
+- if (E != NULL)
 (
--	kfree(E);
-+ kfree(E);
+  kfree(E);
 |
--	debugfs_remove(E);
-+ debugfs_remove(E);
+  debugfs_remove(E);
 |
--	debugfs_remove_recursive(E);
-+ debugfs_remove_recursive(E);
+  debugfs_remove_recursive(E);
 |
--	usb_free_urb(E);
-+ usb_free_urb(E);
+  usb_free_urb(E);
 )
 
 @r depends on context || report || org @
@@ -36,8 +32,8 @@ expression E;
 position p;
 @@
 
-* if (E)
-*	\(kfree at p\|debugfs_remove at p\|debugfs_remove_recursive at p\|usb_free_urb\)(E);
+* if (E != NULL)
+*	\(kfree at p\|debugfs_remove at p\|debugfs_remove_recursive at p\|usb_free_urb at p\)(E);
 
 @script:python depends on org@
 p << r.p;
