From: vaishali.thakkar@oracle.com (Vaishali Thakkar)
Date: Wed, 23 Nov 2016 14:16:39 +0530
Subject: [Cocci] [PATCH v4 1/3] Coccinelle: misc: Improve the matching of
	rules
In-Reply-To: <cover.1479885093.git.vaishali.thakkar@oracle.com>
References: <cover.1479885093.git.vaishali.thakkar@oracle.com>
Message-ID: <fdf1ae6e2353f99827ced75e56de699282d8892e.1479885093.git.vaishali.thakkar@oracle.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Currently because of the left associativity of the operators, pattern
IRQF_ONESHOT | flags does not match with the pattern when we have more
than one flag after the disjunction. This eventually results in giving
false positives by the script. This patch eliminates these FPs by
improving the rule.

Signed-off-by: Vaishali Thakkar <vaishali.thakkar@oracle.com>
---
Changes since v3:
	- Few more changes in the script to avoid some
          possible false positives
	- Moved initialization of all expressions in a single line
Changes since v2:
	- No change in this patch
Changes since v1:
	- Splitted patch in the patchset
---
 scripts/coccinelle/misc/irqf_oneshot.cocci | 36 +++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/scripts/coccinelle/misc/irqf_oneshot.cocci b/scripts/coccinelle/misc/irqf_oneshot.cocci
index b421150..bd3e140 100644
--- a/scripts/coccinelle/misc/irqf_oneshot.cocci
+++ b/scripts/coccinelle/misc/irqf_oneshot.cocci
@@ -15,16 +15,13 @@ virtual org
 virtual report
 
 @r1@
-expression dev;
-expression irq;
-expression thread_fn;
-expression flags;
+expression dev, irq, thread_fn;
 position p;
 @@
 (
 request_threaded_irq at p(irq, NULL, thread_fn,
 (
-flags | IRQF_ONESHOT
+IRQF_ONESHOT | ...
 |
 IRQF_ONESHOT
 )
@@ -32,21 +29,34 @@ IRQF_ONESHOT
 |
 devm_request_threaded_irq at p(dev, irq, NULL, thread_fn,
 (
-flags | IRQF_ONESHOT
+IRQF_ONESHOT | ...
 |
 IRQF_ONESHOT
 )
 , ...)
 )
 
- at depends on patch@
-expression dev;
-expression irq;
-expression thread_fn;
-expression flags;
+ at r2@
+expression dev, irq, thread_fn, flags, e;
 position p != r1.p;
 @@
 (
+flags = IRQF_ONESHOT | ...
+|
+flags |= IRQF_ONESHOT | ...
+)
+... when != flags = e
+(
+request_threaded_irq at p(irq, NULL, thread_fn, flags, ...);
+|
+devm_request_threaded_irq at p(dev, irq, NULL, thread_fn, flags, ...);
+)
+
+ at depends on patch@
+expression dev, irq, thread_fn, flags;
+position p != {r1.p,r2.p};
+@@
+(
 request_threaded_irq at p(irq, NULL, thread_fn,
 (
 -0
@@ -69,13 +79,13 @@ devm_request_threaded_irq at p(dev, irq, NULL, thread_fn,
 )
 
 @depends on context@
-position p != r1.p;
+position p != {r1.p,r2.p};
 @@
 *request_threaded_irq at p(...)
 
 @match depends on report || org@
 expression irq;
-position p != r1.p;
+position p != {r1.p,r2.p};
 @@
 request_threaded_irq at p(irq, NULL, ...)
 
-- 
2.1.4
