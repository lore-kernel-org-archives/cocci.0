From: ydroneaud@opteya.com (Yann Droneaud)
Date: Mon, 23 May 2016 17:07:19 +0200
Subject: [Cocci] [PATCH v2 1/3] coccinelle: also catch kzfree() issues
In-Reply-To: <cover.1464013817.git.ydroneaud@opteya.com>
References: <cover.1464013817.git.ydroneaud@opteya.com>
Message-ID: <d3466c47b1c5bbf9a7c4cb69a78d392327748669.1464013817.git.ydroneaud@opteya.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Since commit 3ef0e5ba4673 ('slab: introduce kzfree()'),
kfree() is no more the only function to be considered:
kzfree() should be recognized too.

In particular, kzfree() must not be called on memory
allocated through devm_*() functions.

Cc: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
---
 scripts/coccinelle/free/devm_free.cocci  |  2 ++
 scripts/coccinelle/free/ifnullfree.cocci |  4 +++-
 scripts/coccinelle/free/kfree.cocci      | 18 +++++++++++++++---
 scripts/coccinelle/free/kfreeaddr.cocci  |  6 +++++-
 4 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/scripts/coccinelle/free/devm_free.cocci b/scripts/coccinelle/free/devm_free.cocci
index 3d9349012bb3..83c03adec1c5 100644
--- a/scripts/coccinelle/free/devm_free.cocci
+++ b/scripts/coccinelle/free/devm_free.cocci
@@ -48,6 +48,8 @@ position p;
 (
 * kfree at p(x)
 |
+* kzfree at p(x)
+|
 * free_irq at p(x)
 |
 * iounmap at p(x)
diff --git a/scripts/coccinelle/free/ifnullfree.cocci b/scripts/coccinelle/free/ifnullfree.cocci
index 52bd235286fa..14a4cd98e83b 100644
--- a/scripts/coccinelle/free/ifnullfree.cocci
+++ b/scripts/coccinelle/free/ifnullfree.cocci
@@ -20,6 +20,8 @@ expression E;
 (
   kfree(E);
 |
+  kzfree(E);
+|
   debugfs_remove(E);
 |
   debugfs_remove_recursive(E);
@@ -39,7 +41,7 @@ position p;
 @@
 
 * if (E != NULL)
-*	\(kfree at p\|debugfs_remove at p\|debugfs_remove_recursive at p\|
+*	\(kfree at p\|kzfree at p\|debugfs_remove at p\|debugfs_remove_recursive at p\|
 *         usb_free_urb at p\|kmem_cache_destroy at p\|mempool_destroy at p\|
 *         dma_pool_destroy at p\)(E);
 
diff --git a/scripts/coccinelle/free/kfree.cocci b/scripts/coccinelle/free/kfree.cocci
index 577b78056990..ac438da4fd7b 100644
--- a/scripts/coccinelle/free/kfree.cocci
+++ b/scripts/coccinelle/free/kfree.cocci
@@ -20,7 +20,11 @@ expression E;
 position p1;
 @@
 
-kfree at p1(E)
+(
+* kfree at p1(E)
+|
+* kzfree at p1(E)
+)
 
 @print expression@
 constant char [] c;
@@ -60,7 +64,11 @@ position ok;
 @@
 
 while (1) { ...
-  kfree at ok(E)
+(
+* kfree at ok(E)
+|
+* kzfree at ok(E)
+)
   ... when != break;
       when != goto l;
       when forall
@@ -74,7 +82,11 @@ statement S;
 position free.p1!=loop.ok,p2!={print.p,sz.p};
 @@
 
-kfree at p1(E,...)
+(
+* kfree at p1(E,...)
+|
+* kzfree at p1(E,...)
+)
 ...
 (
  iter(...,subE,...) S // no use
diff --git a/scripts/coccinelle/free/kfreeaddr.cocci b/scripts/coccinelle/free/kfreeaddr.cocci
index ce8aacc314cb..d46063b1db8b 100644
--- a/scripts/coccinelle/free/kfreeaddr.cocci
+++ b/scripts/coccinelle/free/kfreeaddr.cocci
@@ -16,7 +16,11 @@ identifier f;
 position p;
 @@
 
+(
 * kfree at p(&e->f)
+|
+* kzfree at p(&e->f)
+)
 
 @script:python depends on org@
 p << r.p;
@@ -28,5 +32,5 @@ cocci.print_main("kfree",p)
 p << r.p;
 @@
 
-msg = "ERROR: kfree of structure field"
+msg = "ERROR: invalid free of structure field"
 coccilib.report.print_report(p[0],msg)
-- 
2.7.4
