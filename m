From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sun, 15 Oct 2017 11:55:53 +0200
Subject: [Cocci] [PATCH] Coccinelle: make DEBUG_FILE option more useful
Message-ID: <1508061353-24744-1-git-send-email-Julia.Lawall@lip6.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Make coccicheck checked for the existence of DEBUG_FILE on each semantic
patch, and bailed if it already existed.  This meant that DEBUG_FILE was
useless for checking more than one semantic patch at a time.  Now the check
is moved to the start of make coccicheck, and the 2> is changed to a 2>> to
append to the file on each semantic patch.  Furthermore, the spatch command
that is run for each semantic patch is also added to the DEBUG_FILE, to
make clear what each stdout trace corresponds to.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 scripts/coccicheck |   21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index ec487b8..3e21a1b 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -122,15 +122,8 @@ run_cmd_parmap() {
 	if [ $VERBOSE -ne 0 ] ; then
 		echo "Running ($NPROC in parallel): $@"
 	fi
-	if [ "$DEBUG_FILE" != "/dev/null" -a "$DEBUG_FILE" != "" ]; then
-		if [ -f $DEBUG_FILE ]; then
-			echo "Debug file $DEBUG_FILE exists, bailing"
-			exit
-		fi
-	else
-		DEBUG_FILE="/dev/null"
-	fi
-	$@ 2>$DEBUG_FILE
+	echo $@ >>$DEBUG_FILE
+	$@ 2>>$DEBUG_FILE
 	if [[ $? -ne 0 ]]; then
 		echo "coccicheck failed"
 		exit $?
@@ -246,6 +239,16 @@ coccinelle () {
 
 }
 
+if [ "$DEBUG_FILE" != "/dev/null" -a "$DEBUG_FILE" != "" ]; then
+	if [ -f $DEBUG_FILE ]; then
+		echo "Debug file $DEBUG_FILE exists, bailing"
+		exit
+	fi
+	touch $DEBUG_FILE
+else
+	DEBUG_FILE="/dev/null"
+fi
+
 if [ "$COCCI" = "" ] ; then
     for f in `find $srctree/scripts/coccinelle/ -name '*.cocci' -type f | sort`; do
 	coccinelle $f
