From: vaishali.thakkar@oracle.com (Vaishali Thakkar)
Date: Wed, 23 Nov 2016 14:16:46 +0530
Subject: [Cocci] [PATCH v4 2/3] Coccinelle: misc: Improve the result given
	by context mode
In-Reply-To: <cover.1479885093.git.vaishali.thakkar@oracle.com>
References: <cover.1479885093.git.vaishali.thakkar@oracle.com>
Message-ID: <c5067285f7363b20bbd297979dfbbffc54ed968d.1479885093.git.vaishali.thakkar@oracle.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

To eliminate false positives given by the context mode, add
necessary arguments for the function request_threaded_irq.

Signed-off-by: Vaishali Thakkar <vaishali.thakkar@oracle.com>
Acked-by: Julia Lawall <julia.lawall@lip6.fr>
---
Changes since v3:
	- No changes in this patch
Changes since v2:
	- Add missing declaration of metavariable irq
Changes since v1:
	- Split patch in to the patch set
---
 scripts/coccinelle/misc/irqf_oneshot.cocci | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/coccinelle/misc/irqf_oneshot.cocci b/scripts/coccinelle/misc/irqf_oneshot.cocci
index bd3e140..cec3672 100644
--- a/scripts/coccinelle/misc/irqf_oneshot.cocci
+++ b/scripts/coccinelle/misc/irqf_oneshot.cocci
@@ -79,9 +79,10 @@ devm_request_threaded_irq at p(dev, irq, NULL, thread_fn,
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
