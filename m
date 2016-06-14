From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Tue, 14 Jun 2016 13:23:40 -0700
Subject: [Cocci] [PATCH v3 6/6] coccicheck: refer to coccicheck bottest wiki
	for documentation
In-Reply-To: <1465935820-14010-1-git-send-email-mcgrof@kernel.org>
References: <20160614201923.GC11948@wotan.suse.de>
 <1465935820-14010-1-git-send-email-mcgrof@kernel.org>
Message-ID: <1465935820-14010-7-git-send-email-mcgrof@kernel.org>
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
index c6440138c6ea..37db7ac1dfae 100755
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
 
 DIR=$(dirname $(readlink -f $0))
 DIR="${DIR}/../"
-- 
2.8.2
