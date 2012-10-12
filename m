From: nicolas.palix@imag.fr (Nicolas Palix)
Date: Fri, 12 Oct 2012 10:48:50 +0200
Subject: [Cocci] [PATCH] Coccicheck: Improvement for online checking with
	'make C=[12]'
Message-ID: <1350031730-20822-1-git-send-email-nicolas.palix@imag.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This patch replaces an old workaround by a new spatch option,
and adds support for online checking of external modules.

The ignore_unknown_options is present in coccinelle
since the version 0.2.3 of spatch. Most of the distribution
(if not all) already provide a RC of the 1.0.0 version.

This new option allows to preserve all gcc options, e.g. -I,
while checking code. Other gcc-specific options are
discarded by spatch.

The support for external modules is also added.

Signed-off-by: Nicolas Palix <nicolas.palix@imag.fr>
---
 scripts/coccicheck |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index 823e972..b06b3cd 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -5,14 +5,14 @@ SPATCH="`which ${SPATCH:=spatch}`"
 if [ "$C" = "1" -o "$C" = "2" ]; then
     ONLINE=1
 
-# This requires Coccinelle >= 0.2.3
-#    FLAGS="-ignore_unknown_options -very_quiet"
-#    OPTIONS=$*
-
-# Workaround for Coccinelle < 0.2.3
-	FLAGS="-I $srctree/include -very_quiet"
-	shift $(( $# - 1 ))
-	OPTIONS=$1
+    # The ignore_unknown_options flag requires Coccinelle >= 0.2.3
+    FLAGS="-ignore_unknown_options -very_quiet"
+    if [ "$KBUILD_EXTMOD" = "" ] ; then
+        OPTIONS="-dir $srctree $*"
+    else
+        OPTIONS="-dir $KBUILD_EXTMOD -patch $srctree -I $srctree/include -I $KBUILD_EXTMOD/include $*"
+    fi
+
 else
     ONLINE=0
     FLAGS="-very_quiet"
-- 
1.7.9.5
