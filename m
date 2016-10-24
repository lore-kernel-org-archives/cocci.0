From: vaishali.thakkar@oracle.com (Vaishali Thakkar)
Date: Mon, 24 Oct 2016 17:49:59 +0530
Subject: [Cocci] [PATCH v3 1/3] Coccinelle: misc: Improve the matching of
	rules
In-Reply-To: <cover.1477293469.git.vaishali.thakkar@oracle.com>
References: <cover.1477293469.git.vaishali.thakkar@oracle.com>
Message-ID: <53a9e7344bd2fe5756c245ab0e1646976c1e0fbd.1477293469.git.vaishali.thakkar@oracle.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Currently because of the left associativity of the operators, pattern
IRQF_ONESHOT | flags does not match with the pattern when we have more
than one flag after the disjunction. This eventually results in giving
false positives by the script. This patch eliminates these FPs by
improving the rule.

Signed-off-by: Vaishali Thakkar <vaishali.thakkar@oracle.com>
---
Changes since v2:
	- No change in this patch
Changes since v1:
	- Splitted patch in the patchset
---
 scripts/coccinelle/misc/irqf_oneshot.cocci | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/scripts/coccinelle/misc/irqf_oneshot.cocci b/scripts/coccinelle/misc/irqf_oneshot.cocci
index b421150..a8537fb 100644
--- a/scripts/coccinelle/misc/irqf_oneshot.cocci
+++ b/scripts/coccinelle/misc/irqf_oneshot.cocci
@@ -18,13 +18,12 @@ virtual report
 expression dev;
 expression irq;
 expression thread_fn;
-expression flags;
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
@@ -32,20 +31,39 @@ IRQF_ONESHOT
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
+ at r2@
 expression dev;
 expression irq;
 expression thread_fn;
 expression flags;
+expression ret;
 position p != r1.p;
 @@
+flags = IRQF_ONESHOT | ...;
+(
+ret = request_threaded_irq at p(irq, NULL, thread_fn, flags, ...);
+|
+ret = devm_request_threaded_irq at p(dev, irq, NULL, thread_fn, flags, ...);
+|
+return request_threaded_irq at p(irq, NULL, thread_fn, flags, ...);
+|
+return devm_request_threaded_irq at p(dev, irq, NULL, thread_fn, flags, ...);
+)
+
+ at depends on patch@
+expression dev;
+expression irq;
+expression thread_fn;
+expression flags;
+position p != {r1.p,r2.p};
+@@
 (
 request_threaded_irq at p(irq, NULL, thread_fn,
 (
@@ -69,13 +87,13 @@ devm_request_threaded_irq at p(dev, irq, NULL, thread_fn,
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
