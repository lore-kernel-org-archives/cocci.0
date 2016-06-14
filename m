From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Tue, 14 Jun 2016 13:23:35 -0700
Subject: [Cocci] [PATCH v3 1/6] coccicheck: move spatch binary check up
In-Reply-To: <1465935820-14010-1-git-send-email-mcgrof@kernel.org>
References: <20160614201923.GC11948@wotan.suse.de>
 <1465935820-14010-1-git-send-email-mcgrof@kernel.org>
Message-ID: <1465935820-14010-2-git-send-email-mcgrof@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This has no functional changes. This is being done
to enable us to later use spatch binary for some
flag checking for certain features early on.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 scripts/coccicheck | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index dd85a455b2ba..aa5e78fba270 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -7,6 +7,11 @@
 
 SPATCH="`which ${SPATCH:=spatch}`"
 
+if [ ! -x "$SPATCH" ]; then
+    echo 'spatch is part of the Coccinelle project and is available at http://coccinelle.lip6.fr/'
+    exit 1
+fi
+
 trap kill_running SIGTERM SIGINT
 declare -a SPATCH_PID
 
@@ -51,11 +56,6 @@ if [ "$KBUILD_EXTMOD" != "" ] ; then
     OPTIONS="--patch $srctree $OPTIONS"
 fi
 
-if [ ! -x "$SPATCH" ]; then
-    echo 'spatch is part of the Coccinelle project and is available at http://coccinelle.lip6.fr/'
-    exit 1
-fi
-
 if [ "$MODE" = "" ] ; then
     if [ "$ONLINE" = "0" ] ; then
 	echo 'You have not explicitly specified the mode to use. Using default "report" mode.'
-- 
2.8.2
