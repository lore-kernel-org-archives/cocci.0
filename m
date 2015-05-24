From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 24 May 2015 17:45:54 -0300
Subject: [Cocci] [PATCH] coccinelle: irqf_oneshot.cocci: Improve the
	generated commit log
Message-ID: <1432500354-10562-1-git-send-email-festevam@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: Fabio Estevam <fabio.estevam@freescale.com>

Improve the commit log of the generated patch by mentioning the commit
log that makes threaded IRQs without a primary handler to be requested
with the IRQF_ONESHOT flag.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 scripts/coccinelle/misc/irqf_oneshot.cocci | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/scripts/coccinelle/misc/irqf_oneshot.cocci b/scripts/coccinelle/misc/irqf_oneshot.cocci
index b17ac8b..b421150 100644
--- a/scripts/coccinelle/misc/irqf_oneshot.cocci
+++ b/scripts/coccinelle/misc/irqf_oneshot.cocci
@@ -1,5 +1,8 @@
-/// Make sure threaded IRQs without a primary handler are always requested with
-/// IRQF_ONESHOT
+/// Since commit 1c6c69525b40 ("genirq: Reject bogus threaded irq requests")
+/// threaded IRQs without a primary handler need to be requested with
+/// IRQF_ONESHOT, otherwise the request will fail.
+///
+/// So pass the IRQF_ONESHOT flag in this case.
 ///
 //
 // Confidence: Good
-- 
1.9.1
