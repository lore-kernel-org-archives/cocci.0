From: andreas.platschek@opentech.at (Andreas Platschek)
Date: Thu,  1 Sep 2016 14:48:35 +0000
Subject: [Cocci] [PATCH] coccicheck: Correct pointer to documentation in
	coccicheck
Message-ID: <1472741315-13326-1-git-send-email-andreas.platschek@opentech.at>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Since Documentation/coccinelle.txt was moved to
Documentation/dev-tools/coccinelle.rst, this should also be corrected in the
coccicheck script.

Signed-off-by: Andreas Platschek <andreas.platschek@opentech.at>
---
 scripts/coccicheck | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index c92c1528..ec487b8 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -1,7 +1,7 @@
 #!/bin/bash
 # Linux kernel coccicheck
 #
-# Read Documentation/coccinelle.txt
+# Read Documentation/dev-tools/coccinelle.rst
 #
 # This script requires at least spatch
 # version 1.0.0-rc11.
-- 
2.1.4
