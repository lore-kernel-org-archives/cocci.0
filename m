From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Thu, 16 Jun 2016 15:31:32 -0700
Subject: [Cocci] [PATCH v2 8/8] scripts/coccinelle: require coccinelle >=
	1.0.4 on device_node_continue.cocci
In-Reply-To: <1466116292-21843-1-git-send-email-mcgrof@kernel.org>
References: <1466116292-21843-1-git-send-email-mcgrof@kernel.org>
Message-ID: <1466116292-21843-9-git-send-email-mcgrof@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Make use of the new Requires: tag to be able to specify coccinelle binary
version requirements. The cocci file device_node_continue.cocci requires at
least coccinelle 1.0.4.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 scripts/coccinelle/iterators/device_node_continue.cocci | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/coccinelle/iterators/device_node_continue.cocci b/scripts/coccinelle/iterators/device_node_continue.cocci
index 38ab744a4037..a36c16db171b 100644
--- a/scripts/coccinelle/iterators/device_node_continue.cocci
+++ b/scripts/coccinelle/iterators/device_node_continue.cocci
@@ -5,8 +5,11 @@
 // Copyright: (C) 2015 Julia Lawall, Inria. GPLv2.
 // URL: http://coccinelle.lip6.fr/
 // Options: --no-includes --include-headers
+// Requires: 1.0.4
 // Keywords: for_each_child_of_node, etc.
 
+// This uses a conjunction, which requires at least coccinelle >= 1.0.4
+
 virtual patch
 virtual context
 virtual org
-- 
2.8.2
