From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Wed, 29 Jun 2016 15:14:57 -0700
Subject: [Cocci] [PATCH v4 7/9] coccicheck: add support for requring a
	coccinelle version
In-Reply-To: <1467238499-10889-1-git-send-email-mcgrof@kernel.org>
References: <1467238499-10889-1-git-send-email-mcgrof@kernel.org>
Message-ID: <1467238499-10889-8-git-send-email-mcgrof@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Enable Coccinelle SmPL patches to require a specific version of
Coccinelle. In the event that the version does not match we just
inform the user, if the user asked to go through all SmPL patches
we just inform them of the need for a new version of coccinelle for
the SmPL patch and continue on with the rest.

This uses the simple kernel scripts/ld-version.sh to create a weight
on the version provided by spatch. The -dirty attribute is ignored if
supplied, the benefit of scripts/ld-version.sh is it has a long history
and well tested.

While at it, document the // Options stuff as well.

v4: Document // Options and // Requires as well on
    Documentation/coccinelle.txt.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
Acked-by: Nicolas Palix <nicolas.palix@imag.fr>
---
 Documentation/coccinelle.txt | 19 +++++++++++++++++++
 scripts/coccicheck           | 14 ++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/Documentation/coccinelle.txt b/Documentation/coccinelle.txt
index b50ac7e126e8..1c26908ebc16 100644
--- a/Documentation/coccinelle.txt
+++ b/Documentation/coccinelle.txt
@@ -277,6 +277,25 @@ thus active by default. However, by indexing the code with
 one of these tools, and according to the cocci file used,
 spatch could proceed the entire code base more quickly.
 
+ SmPL patch specific options
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+SmPL patches can have their own requirements for options passed
+to Coccinelle. SmPL patch specific options can be provided by
+providing them at the top of the SmPL patch, for instance:
+
+// Options: --no-includes --include-headers
+
+ SmPL patch Coccinelle requirements
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+As Coccinelle features get added some more advanced SmPL patches
+may require newer versions of Coccinelle. If an SmPL patch requires
+at least a version of Coccinelle, this can be specified as follows,
+as an example if requiring at least Coccinelle >= 1.0.5:
+
+// Requires: 1.0.5
+
  Proposing new semantic patches
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/scripts/coccicheck b/scripts/coccicheck
index 081ba5bff79c..f9293ab04a8b 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -5,6 +5,7 @@
 # version 1.0.0-rc11.
 #
 
+DIR="$(dirname $(readlink -f $0))/.."
 SPATCH="`which ${SPATCH:=spatch}`"
 
 if [ ! -x "$SPATCH" ]; then
@@ -12,6 +13,9 @@ if [ ! -x "$SPATCH" ]; then
     exit 1
 fi
 
+SPATCH_VERSION=$($SPATCH --version | head -1 | awk '{print $3}')
+SPATCH_VERSION_NUM=$(echo $SPATCH_VERSION | ${DIR}/scripts/ld-version.sh)
+
 USE_JOBS="no"
 $SPATCH --help | grep "\-\-jobs" > /dev/null && USE_JOBS="yes"
 
@@ -171,6 +175,16 @@ coccinelle () {
     COCCI="$1"
 
     OPT=`grep "Option" $COCCI | cut -d':' -f2`
+    REQ=`grep "Requires" $COCCI | cut -d':' -f2 | sed "s| ||"`
+    REQ_NUM=$(echo $REQ | ${DIR}/scripts/ld-version.sh)
+    if [ "$REQ_NUM" != "0" ] ; then
+	    if [ "$SPATCH_VERSION_NUM" -lt "$REQ_NUM" ] ; then
+		    echo "Skipping coccinele SmPL patch: $COCCI"
+		    echo "You have coccinelle:           $SPATCH_VERSION"
+		    echo "This SmPL patch requires:      $REQ"
+		    return
+	    fi
+    fi
 
 #   The option '--parse-cocci' can be used to syntactically check the SmPL files.
 #
-- 
2.8.4
