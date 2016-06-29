From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Wed, 29 Jun 2016 15:14:58 -0700
Subject: [Cocci] [PATCH v4 8/9] coccicheck: refer to
	Documentation/coccinelle.txt and wiki
In-Reply-To: <1467238499-10889-1-git-send-email-mcgrof@kernel.org>
References: <1467238499-10889-1-git-send-email-mcgrof@kernel.org>
Message-ID: <1467238499-10889-9-git-send-email-mcgrof@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Refer to the Documentation/coccinelle.txt and supplemental documentation
on the wiki:

https://bottest.wiki.kernel.org/coccicheck

This page shall always refer to the linux-next iteration of scripts/coccicheck.

v4: only refer to the wiki as supplemental documentation, and also
    update Documentation/coccinelle.txt.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
Acked-by: Nicolas Palix <nicolas.palix@imag.fr>
---
 Documentation/coccinelle.txt | 9 +++++++++
 scripts/coccicheck           | 5 +++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/coccinelle.txt b/Documentation/coccinelle.txt
index 1c26908ebc16..01fb1dae3163 100644
--- a/Documentation/coccinelle.txt
+++ b/Documentation/coccinelle.txt
@@ -38,6 +38,15 @@ as a regular user, and install it with
 
         sudo make install
 
+ Supplemental documentation
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+For supplemental documentation refer to the wiki:
+
+https://bottest.wiki.kernel.org/coccicheck
+
+The wiki documentation always refers to the linux-next version of the script.
+
  Using Coccinelle on the Linux kernel
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/scripts/coccicheck b/scripts/coccicheck
index f9293ab04a8b..c92c1528a54d 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -1,9 +1,10 @@
 #!/bin/bash
-
+# Linux kernel coccicheck
+#
+# Read Documentation/coccinelle.txt
 #
 # This script requires at least spatch
 # version 1.0.0-rc11.
-#
 
 DIR="$(dirname $(readlink -f $0))/.."
 SPATCH="`which ${SPATCH:=spatch}`"
-- 
2.8.4
