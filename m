From: nicolas.palix@imag.fr (Nicolas Palix)
Date: Sat,  2 Mar 2013 22:36:25 +0100
Subject: [Cocci] [PATCH 1/4] Coccinelle: Restore coccicheck verbosity in
	ONLINE mode (C=1 or C=2)
Message-ID: <1362260188-14138-1-git-send-email-nicolas.palix@imag.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

A recent patch have introduce the VERBOSE variable and comments
now depend on it. However, the message printed for each cocci file
such not be printed when the ONLINE mode is active, whatever is
the value of VERBOSE.

Signed-off-by: Nicolas Palix <nicolas.palix@imag.fr>
---
 scripts/coccicheck |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index 85d3189..7f0d6a6 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -72,7 +72,7 @@ coccinelle () {
 #
 #    $SPATCH -D $MODE $FLAGS -parse_cocci $COCCI $OPT > /dev/null
 
-    if [ $VERBOSE -ne 0 ] ; then
+    if [ $VERBOSE -ne 0 -a $ONLINE -eq 0 ] ; then
 
 	FILE=`echo $COCCI | sed "s|$srctree/||"`
 
-- 
1.7.10.4
