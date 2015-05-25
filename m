From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 25 May 2015 08:46:13 -0300
Subject: [Cocci] [PATCH 2/2] coccinelle: pci_free_consistent.cocci: Adjust
	commit log of generated patch
In-Reply-To: <1432554373-6444-1-git-send-email-fabio.estevam@freescale.com>
References: <1432554373-6444-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1432554373-6444-2-git-send-email-fabio.estevam@freescale.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

The commit log should better describe the action that the patch will do.

In this case we are 'adding' the pci_free_consistent.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 scripts/coccinelle/free/pci_free_consistent.cocci | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccinelle/free/pci_free_consistent.cocci b/scripts/coccinelle/free/pci_free_consistent.cocci
index 43600cc..82b3e44 100644
--- a/scripts/coccinelle/free/pci_free_consistent.cocci
+++ b/scripts/coccinelle/free/pci_free_consistent.cocci
@@ -1,4 +1,4 @@
-/// Find missing pci_free_consistent for every pci_alloc_consistent.
+/// Add missing pci_free_consistent for every pci_alloc_consistent.
 ///
 // Confidence: Moderate
 // Copyright: (C) 2013 Petr Strnad.  GPLv2.
-- 
1.9.1
