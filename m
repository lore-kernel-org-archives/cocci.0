From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Wed, 29 Jun 2016 15:10:26 -0700
Subject: [Cocci] [RFC v4 9/9] scripts/coccinelle: require coccinelle >=
	1.0.4 on device_node_continue.cocci
In-Reply-To: <1467238226-10822-1-git-send-email-mcgrof@kernel.org>
References: <1467238226-10822-1-git-send-email-mcgrof@kernel.org>
Message-ID: <1467238226-10822-10-git-send-email-mcgrof@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Make use of the new Requires: tag to be able to specify coccinelle binary
version requirements. The cocci file device_node_continue.cocci requires at
least coccinelle 1.0.4.

Acked-by: Julia Lawall <julia.lawall@lip6.fr>
Acked-by: Nicolas Palix <nicolas.palix@imag.fr>
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
2.8.4
