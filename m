From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 20 May 2015 08:02:35 -0300
Subject: [Cocci] [PATCH 2/2 RESEND]
	scripts/coccinelle/misc/irqf_oneshot.cocci: Fix grammar
In-Reply-To: <1432119755-4266-1-git-send-email-festevam@gmail.com>
References: <1432119755-4266-1-git-send-email-festevam@gmail.com>
Message-ID: <1432119755-4266-2-git-send-email-festevam@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

From: Fabio Estevam <fabio.estevam@freescale.com>

Correct form is 'always requested'.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Acked-by: Julia Lawall <julia.lawall@lip6.fr>
---
 scripts/coccinelle/misc/irqf_oneshot.cocci | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccinelle/misc/irqf_oneshot.cocci b/scripts/coccinelle/misc/irqf_oneshot.cocci
index a24a754..b17ac8b 100644
--- a/scripts/coccinelle/misc/irqf_oneshot.cocci
+++ b/scripts/coccinelle/misc/irqf_oneshot.cocci
@@ -1,4 +1,4 @@
-/// Make sure threaded IRQs without a primary handler are always request with
+/// Make sure threaded IRQs without a primary handler are always requested with
 /// IRQF_ONESHOT
 ///
 //
-- 
1.9.1
