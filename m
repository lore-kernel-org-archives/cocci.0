From: ydroneaud@opteya.com (Yann Droneaud)
Date: Mon, 23 May 2016 17:07:20 +0200
Subject: [Cocci] [PATCH v2 2/3] coccinelle: recognize more devm_* memory
	allocation functions
In-Reply-To: <cover.1464013817.git.ydroneaud@opteya.com>
References: <cover.1464013817.git.ydroneaud@opteya.com>
Message-ID: <ac950d1d8fca04ecc903f97083cb539ba538e7c2.1464013817.git.ydroneaud@opteya.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Updates free/devm_free.cocci to recognize functions added by:

- commit 64c862a839a8 ('devres: add kernel standard devm_k.alloc functions')
- commit e31108cad3de ('devres: introduce API "devm_kstrdup"')
- commit 3046365bb470 ('devres: introduce API "devm_kmemdup')
- commit 43339bed7010 ('devres: Add devm_get_free_pages API')
- commit 75f2a4ead5d5 ('devres: Add devm_kasprintf and devm_kvasprintf API')

See also Documentation/driver-model/devres.txt

Cc: Joe Perches <joe@perches.com>
Cc: Manish Badarkhe <badarkhe.manish@gmail.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Eli Billauer <eli.billauer@gmail.com>
Cc: Himangi Saraogi <himangi774@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Wolfram Sang <w.sang@pengutronix.de>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Acked-by: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
---
 scripts/coccinelle/free/devm_free.cocci | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/scripts/coccinelle/free/devm_free.cocci b/scripts/coccinelle/free/devm_free.cocci
index 83c03adec1c5..3794cd97494b 100644
--- a/scripts/coccinelle/free/devm_free.cocci
+++ b/scripts/coccinelle/free/devm_free.cocci
@@ -29,8 +29,24 @@ expression x;
 @@
 
 (
+ x = devm_kmalloc(...)
+|
+ x = devm_kvasprintf(...)
+|
+ x = devm_kasprintf(...)
+|
  x = devm_kzalloc(...)
 |
+ x = devm_kmalloc_array(...)
+|
+ x = devm_kcalloc(...)
+|
+ x = devm_kstrdup(...)
+|
+ x = devm_kmemdup(...)
+|
+ x = devm_get_free_pages(...)
+|
  x = devm_request_irq(...)
 |
  x = devm_ioremap(...)
@@ -50,6 +66,10 @@ position p;
 |
 * kzfree at p(x)
 |
+* free_pages at p(x, ...)
+|
+* free_page at p(x)
+|
 * free_irq at p(x)
 |
 * iounmap at p(x)
-- 
2.7.4
