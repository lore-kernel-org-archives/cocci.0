From: vaishali.thakkar@oracle.com (Vaishali Thakkar)
Date: Mon, 24 Oct 2016 17:53:07 +0530
Subject: [Cocci] [PATCH v3 2/3] Coccinelle: misc: Improve the result given
	by context mode
In-Reply-To: <cover.1477293469.git.vaishali.thakkar@oracle.com>
References: <cover.1477293469.git.vaishali.thakkar@oracle.com>
Message-ID: <684296c10e1e8861ac7294cbb1e3d2618bb2c233.1477293469.git.vaishali.thakkar@oracle.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

To eliminate false positives given by the context mode, add
necessary arguments for the function request_threaded_irq.

Signed-off-by: Vaishali Thakkar <vaishali.thakkar@oracle.com>
---
Changes since v2:
	- Add missing declaration of metavariable irq
Changes since v1:
	- Split patch in to the patch set
---
 scripts/coccinelle/misc/irqf_oneshot.cocci | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/coccinelle/misc/irqf_oneshot.cocci b/scripts/coccinelle/misc/irqf_oneshot.cocci
index a8537fb..e53372e 100644
--- a/scripts/coccinelle/misc/irqf_oneshot.cocci
+++ b/scripts/coccinelle/misc/irqf_oneshot.cocci
@@ -87,9 +87,10 @@ devm_request_threaded_irq at p(dev, irq, NULL, thread_fn,
 )
 
 @depends on context@
+expression irq;
 position p != {r1.p,r2.p};
 @@
-*request_threaded_irq at p(...)
+*request_threaded_irq at p(irq, NULL, ...)
 
 @match depends on report || org@
 expression irq;
-- 
2.1.4
