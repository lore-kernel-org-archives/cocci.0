From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Tue, 14 Jun 2016 15:10:17 -0700
Subject: [Cocci] [PATCH 4/4] scripts/coccinelle: require coccinelle >= 1.0.4
	on device_node_continue.cocci
In-Reply-To: <1465942217-14452-1-git-send-email-mcgrof@kernel.org>
References: <1465942217-14452-1-git-send-email-mcgrof@kernel.org>
Message-ID: <1465942217-14452-5-git-send-email-mcgrof@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Make use of the new kernel python requirements library to be able to
specify coccinelle binary version requirements. The cocci file
device_node_continue.cocci requires at least coccinelle 1.0.4.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 scripts/coccinelle/iterators/device_node_continue.cocci | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/scripts/coccinelle/iterators/device_node_continue.cocci b/scripts/coccinelle/iterators/device_node_continue.cocci
index 38ab744a4037..b590de9418d1 100644
--- a/scripts/coccinelle/iterators/device_node_continue.cocci
+++ b/scripts/coccinelle/iterators/device_node_continue.cocci
@@ -12,6 +12,19 @@ virtual context
 virtual org
 virtual report
 
+// This uses a conjunction, which requires at least coccinelle >= 1.0.4
+ at script:python@
+@@
+
+import sys
+from lib import reqs
+
+req = reqs.Req()
+req.coccinelle('1.0.4')
+if not req.reqs_match():
+    cocci.exit()
+    sys.exit(1)
+
 @r exists@
 expression e1,e2;
 local idexpression n;
-- 
2.8.2
