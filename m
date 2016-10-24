From: vaishali.thakkar@oracle.com (Vaishali Thakkar)
Date: Mon, 24 Oct 2016 17:54:03 +0530
Subject: [Cocci] [PATCH v3 3/3] Coccinelle: misc: Add support for devm
	variant in all modes
In-Reply-To: <cover.1477293469.git.vaishali.thakkar@oracle.com>
References: <cover.1477293469.git.vaishali.thakkar@oracle.com>
Message-ID: <66e8233a1bb85a93ea70815dbc3416c2cc9edd5c.1477293469.git.vaishali.thakkar@oracle.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Add missing support for the devm_request_threaded_irq in
the rules of context, report and org modes.

Misc:
----
To be consistent with other scripts, change confidence level
of the script to 'Moderate'.

Signed-off-by: Vaishali Thakkar <vaishali.thakkar@oracle.com>
---
Changes since v2:
	- Add missing initialization of metavariables
Changes since v1:
	- Split patch in to the patchset
---
 scripts/coccinelle/misc/irqf_oneshot.cocci | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/scripts/coccinelle/misc/irqf_oneshot.cocci b/scripts/coccinelle/misc/irqf_oneshot.cocci
index e53372e..ca78125 100644
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
 
@@ -87,16 +87,26 @@ devm_request_threaded_irq at p(dev, irq, NULL, thread_fn,
 )
 
 @depends on context@
+expression dev;
 expression irq;
 position p != {r1.p,r2.p};
 @@
+(
 *request_threaded_irq at p(irq, NULL, ...)
+|
+*devm_request_threaded_irq at p(dev, irq, NULL, ...)
+)
 
 @match depends on report || org@
+expression dev;
 expression irq;
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
