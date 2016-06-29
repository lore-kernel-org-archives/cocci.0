From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Wed, 29 Jun 2016 15:14:54 -0700
Subject: [Cocci] [PATCH v4 4/9] coccicheck: add support for DEBUG_FILE
In-Reply-To: <1467238499-10889-1-git-send-email-mcgrof@kernel.org>
References: <1467238499-10889-1-git-send-email-mcgrof@kernel.org>
Message-ID: <1467238499-10889-5-git-send-email-mcgrof@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Enable to capture stderr via a DEBUG_FILE variable passed to
coccicheck. You can now do:

$ rm -f cocci.err
$ export COCCI=scripts/coccinelle/free/kfree.cocci
$ make coccicheck MODE=report DEBUG_FILE=cocci.err
...
$ cat cocci.err

This will be come more useful once we add support to
use more things which would go into stderr, such as
profiling. That will be done separately in another
commit.

Expand Documentation/coccinelle.txt with details.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
Acked-by: Nicolas Palix <nicolas.palix@imag.fr>
---
 Documentation/coccinelle.txt | 20 ++++++++++++++++++++
 scripts/coccicheck           | 10 +++++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/coccinelle.txt b/Documentation/coccinelle.txt
index 64daaf18874b..2516c5ef1691 100644
--- a/Documentation/coccinelle.txt
+++ b/Documentation/coccinelle.txt
@@ -157,6 +157,26 @@ semantic patch as shown in the previous section.
 The "report" mode is the default. You can select another one with the
 MODE variable explained above.
 
+ Debugging Coccinelle SmPL patches
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Using coccicheck is best as it provides in the spatch command line
+include options matching the options used when we compile the kernel.
+You can learn what these options are by using V=1, you could then
+manually run Coccinelle with debug options added.
+
+Alternatively you can debug running Coccinelle against SmPL patches
+by asking for stderr to be redirected to stderr, by default stderr
+is redirected to /dev/null, if you'd like to capture stderr you
+can specify the DEBUG_FILE="file.txt" option to coccicheck. For
+instance:
+
+    rm -f cocci.err
+    make coccicheck COCCI=scripts/coccinelle/free/kfree.cocci MODE=report DEBUG_FILE=cocci.err
+    cat cocci.err
+
+DEBUG_FILE support is only supported when using coccinelle >= 1.2.
+
  Additional flags
 ~~~~~~~~~~~~~~~~~~
 
diff --git a/scripts/coccicheck b/scripts/coccicheck
index 4b65a0fd50a1..3f0bb3f0fddc 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -96,7 +96,15 @@ run_cmd_parmap() {
 	if [ $VERBOSE -ne 0 ] ; then
 		echo "Running ($NPROC in parallel): $@"
 	fi
-	$@ 2>/dev/null
+	if [ "$DEBUG_FILE" != "/dev/null" -a "$DEBUG_FILE" != "" ]; then
+		if [ -f $DEBUG_FILE ]; then
+			echo "Debug file $DEBUG_FILE exists, bailing"
+			exit
+		fi
+	else
+		DEBUG_FILE="/dev/null"
+	fi
+	$@ 2>$DEBUG_FILE
 	if [[ $? -ne 0 ]]; then
 		echo "coccicheck failed"
 		exit $?
-- 
2.8.4
