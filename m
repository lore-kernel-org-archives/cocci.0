From: valentinrothberg@gmail.com (Valentin Rothberg)
Date: Tue,  3 Mar 2015 15:34:19 +0100
Subject: [Cocci] [PATCH 2/2] irqf_oneshot.cocci: add check of
	devm_request_threaded_irq()
Message-ID: <1425393259-32170-1-git-send-email-valentinrothberg@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Since commit 1c6c69525b40eb76de8adf039409722015927dc3 ("genirq: Reject
bogus threaded irq requests") threaded IRQs without a primary handler
need to be requested with IRQF_ONESHOT, otherwise the request will fail.

Until now, this coccinelle script only checked request_threaded_irq().
However, the counterpart devm function (see kernel/irq/devres.c) is also
affected by the missing flag which can be detected with this patch.

Signed-off-by: Valentin Rothberg <valentinrothberg@gmail.com>
Signed-off-by: Peter Senna Tschudin <peter.senna@gmail.com>
---
 scripts/coccinelle/misc/irqf_oneshot.cocci | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/scripts/coccinelle/misc/irqf_oneshot.cocci b/scripts/coccinelle/misc/irqf_oneshot.cocci
index 6cfde94..a24a754 100644
--- a/scripts/coccinelle/misc/irqf_oneshot.cocci
+++ b/scripts/coccinelle/misc/irqf_oneshot.cocci
@@ -12,11 +12,13 @@ virtual org
 virtual report
 
 @r1@
+expression dev;
 expression irq;
 expression thread_fn;
 expression flags;
 position p;
 @@
+(
 request_threaded_irq at p(irq, NULL, thread_fn,
 (
 flags | IRQF_ONESHOT
@@ -24,13 +26,24 @@ flags | IRQF_ONESHOT
 IRQF_ONESHOT
 )
 , ...)
+|
+devm_request_threaded_irq at p(dev, irq, NULL, thread_fn,
+(
+flags | IRQF_ONESHOT
+|
+IRQF_ONESHOT
+)
+, ...)
+)
 
 @depends on patch@
+expression dev;
 expression irq;
 expression thread_fn;
 expression flags;
 position p != r1.p;
 @@
+(
 request_threaded_irq at p(irq, NULL, thread_fn,
 (
 -0
@@ -40,6 +53,17 @@ request_threaded_irq at p(irq, NULL, thread_fn,
 +flags | IRQF_ONESHOT
 )
 , ...)
+|
+devm_request_threaded_irq at p(dev, irq, NULL, thread_fn,
+(
+-0
++IRQF_ONESHOT
+|
+-flags
++flags | IRQF_ONESHOT
+)
+, ...)
+)
 
 @depends on context@
 position p != r1.p;
-- 
1.9.1
