From: bernd.schubert@itwm.fraunhofer.de (Bernd Schubert)
Date: Tue, 22 Jan 2013 14:34:34 +0100
Subject: [Cocci] [PATCH 1/2] coccicheck: Allow the user to give a VERBOSE=
	argument
Message-ID: <20130122133434.2543274.86646.stgit@fsdevel3>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Simply running "make coccicheck" returns very verbose output and warnings
might not be noticed.  Allow the user to set the verbosity level.


Signed-off-by: Bernd Schubert <bernd.schubert@itwm.fraunhofer.de>
CC: Julia Lawall <Julia.Lawall@lip6.fr>
CC: Nicolas Palix <nicolas.palix@imag.fr>
CC: cocci at systeme.lip6.fr
---
 scripts/coccicheck |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index 1a49d1c..eab0b00 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -2,6 +2,12 @@
 
 SPATCH="`which ${SPATCH:=spatch}`"
 
+if [ -z "$VERBOSE" ] ; then
+	RUN_VERBOSE=0
+else
+	RUN_VERBOSE=$VERBOSE
+fi
+
 if [ "$C" = "1" -o "$C" = "2" ]; then
     ONLINE=1
 
@@ -55,7 +61,7 @@ coccinelle () {
 #
 #    $SPATCH -D $MODE $FLAGS -parse_cocci $COCCI $OPT > /dev/null
 
-    if [ "$ONLINE" = "0" ] ; then
+    if [ "$RUN_VERBOSE" != "0" ] ; then
 
 	FILE=`echo $COCCI | sed "s|$srctree/||"`
 
