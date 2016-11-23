From: vaishali.thakkar@oracle.com (Vaishali Thakkar)
Date: Wed, 23 Nov 2016 14:16:42 +0530
Subject: [Cocci] [PATCH v4 3/3] Coccinelle: misc: Add support for devm
	variant in all modes
In-Reply-To: <cover.1479885093.git.vaishali.thakkar@oracle.com>
References: <cover.1479885093.git.vaishali.thakkar@oracle.com>
Message-ID: <a93ba910143703b4ffb45359f95699dfc5e57ffe.1479885093.git.vaishali.thakkar@oracle.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Add missing support for the devm_request_threaded_irq in
the rules of context, report and org modes.

Misc:
----
To be consistent with other scripts, change confidence level
of the script to 'Moderate'.

Signed-off-by: Vaishali Thakkar <vaishali.thakkar@oracle.com>
Acked-by: Julia Lawall <julia.lawall@lip6.fr>
---
Changes since v3:
	- No changes in this patch
Changes since v2:
	- Add missing initialization of metavariables
Changes since v1:
	- Split patch in to the patchset
---
 scripts/coccinelle/misc/irqf_oneshot.cocci | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/scripts/coccinelle/misc/irqf_oneshot.cocci b/scripts/coccinelle/misc/irqf_oneshot.cocci
index cec3672..58c2578 100644
--- a/scripts/coccinelle/misc/irqf_oneshot.cocci
+++ b/scripts/coccinelle/misc/irqf_oneshot.cocci
@@ -5,7 +5,7 @@
 /// So pass the IRQF_ONESHOT flag in this case.
 ///
 //
-// Confidence: Good
+// Confidence: Moderate
 // Comments:
 // Options: --no-includes
 
@@ -79,16 +79,25 @@ devm_request_threaded_irq at p(dev, irq, NULL, thread_fn,
 )
 
 @depends on context@
-expression irq;
+expression dev, irq;
 position p != {r1.p,r2.p};
 @@
+(
 *request_threaded_irq at p(irq, NULL, ...)
+|
+*devm_request_threaded_irq at p(dev, irq, NULL, ...)
+)
+
 
 @match depends on report || org@
-expression irq;
+expression dev, irq;
 position p != {r1.p,r2.p};
 @@
+(
 request_threaded_irq at p(irq, NULL, ...)
+|
+devm_request_threaded_irq at p(dev, irq, NULL, ...)
+)
 
 @script:python depends on org@
 p << match.p;
-- 
2.1.4
