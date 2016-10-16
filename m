From: vaishali.thakkar@oracle.com (Vaishali Thakkar)
Date: Sun, 16 Oct 2016 22:40:00 +0530
Subject: [Cocci] [PATCH v2 2/3] Coccinelle: misc: Improve the result given
	by context mode
In-Reply-To: <cover.1476635073.git.vaishali.thakkar@oracle.com>
References: <cover.1476635073.git.vaishali.thakkar@oracle.com>
Message-ID: <d17e17aaa53f8e127d4c075945278c27ade2b328.1476635073.git.vaishali.thakkar@oracle.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

To eliminate false positives given by the context mode, add
necessary arguments for the function request_threaded_irq.

Signed-off-by: Vaishali Thakkar <vaishali.thakkar@oracle.com>
---
 scripts/coccinelle/misc/irqf_oneshot.cocci | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccinelle/misc/irqf_oneshot.cocci b/scripts/coccinelle/misc/irqf_oneshot.cocci
index b538d08..03b748d 100644
--- a/scripts/coccinelle/misc/irqf_oneshot.cocci
+++ b/scripts/coccinelle/misc/irqf_oneshot.cocci
@@ -89,7 +89,7 @@ devm_request_threaded_irq at p(dev, irq, NULL, thread_fn,
 @depends on context@
 position p != {r1.p,r2.p};
 @@
-*request_threaded_irq at p(...)
+*request_threaded_irq at p(irq, NULL, ...)
 
 @match depends on report || org@
 expression irq;
-- 
2.1.4
