From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Thu,  1 Feb 2018 10:48:52 +0100
Subject: [Cocci] [PATCH] coccinelle: reduce false positives
Message-ID: <1517478532-5444-1-git-send-email-Julia.Lawall@lip6.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Some files use both a non-devm allocation and a devm_allocation.  Don't
complain about a free when the same function contains a non-devm
allocation.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 scripts/coccinelle/free/devm_free.cocci |   55 +++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/scripts/coccinelle/free/devm_free.cocci b/scripts/coccinelle/free/devm_free.cocci
index c990d2c..b2a2cf8b 100644
--- a/scripts/coccinelle/free/devm_free.cocci
+++ b/scripts/coccinelle/free/devm_free.cocci
@@ -56,9 +56,62 @@ expression x;
  x = devm_ioport_map(...)
 )
 
+ at safe depends on context || org || report exists@
+expression x;
+position p;
+@@
+
+(
+ x = kmalloc(...)
+|
+ x = kvasprintf(...)
+|
+ x = kasprintf(...)
+|
+ x = kzalloc(...)
+|
+ x = kmalloc_array(...)
+|
+ x = kcalloc(...)
+|
+ x = kstrdup(...)
+|
+ x = kmemdup(...)
+|
+ x = get_free_pages(...)
+|
+ x = request_irq(...)
+|
+ x = ioremap(...)
+|
+ x = ioremap_nocache(...)
+|
+ x = ioport_map(...)
+)
+...
+(
+ kfree at p(x)
+|
+ kzfree at p(x)
+|
+ __krealloc at p(x, ...)
+|
+ krealloc at p(x, ...)
+|
+ free_pages at p(x, ...)
+|
+ free_page at p(x)
+|
+ free_irq at p(x)
+|
+ iounmap at p(x)
+|
+ ioport_unmap at p(x)
+)
+
 @pb@
 expression r.x;
-position p;
+position p != safe.p;
 @@
 
 (
