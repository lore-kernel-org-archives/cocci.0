From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Tue, 21 Jun 2016 12:21:32 -0700
Subject: [Cocci] [PATCH v3 7/8] coccicheck: refer to coccicheck bottest wiki
	for documentation
In-Reply-To: <1466536893-23355-1-git-send-email-mcgrof@kernel.org>
References: <1466536893-23355-1-git-send-email-mcgrof@kernel.org>
Message-ID: <1466536893-23355-8-git-send-email-mcgrof@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Sprinkling *tons* of documentation on the script is not a good
idea, instead refer to a wiki for further coccicheck documentation:

https://bottest.wiki.kernel.org/coccicheck

This page shall always refer to the linux-next iteration of
scripts/coccicheck.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 scripts/coccicheck | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index 01b6716ea931..adbcbbd1aad6 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -1,9 +1,14 @@
 #!/bin/bash
-
+# Linux kernel coccicheck
+#
+# For more detailed documentation refer to:
+#
+# https://bottest.wiki.kernel.org/coccicheck
+#
+# This documentation always refers to the linux-next version of the script.
 #
 # This script requires at least spatch
 # version 1.0.0-rc11.
-#
 
 DIR="$(dirname $(readlink -f $0))/.."
 SPATCH="`which ${SPATCH:=spatch}`"
-- 
2.8.2
