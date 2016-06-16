From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Thu, 16 Jun 2016 15:31:30 -0700
Subject: [Cocci] [PATCH v2 6/8] coccicheck: add support for requring a
	coccinelle version
In-Reply-To: <1466116292-21843-1-git-send-email-mcgrof@kernel.org>
References: <1466116292-21843-1-git-send-email-mcgrof@kernel.org>
Message-ID: <1466116292-21843-7-git-send-email-mcgrof@kernel.org>
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

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 scripts/coccicheck | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index f3a7d9fe9bc9..268ea375273b 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -13,6 +13,9 @@ if [ ! -x "$SPATCH" ]; then
     exit 1
 fi
 
+SPATCH_VERSION=$($SPATCH --version | head -1 | awk '{print $3}')
+SPATCH_VERSION_NUM=$(echo $SPATCH_VERSION | ${DIR}/scripts/ld-version.sh)
+
 USE_JOBS="no"
 $SPATCH --help | grep "\-\-jobs" > /dev/null && USE_JOBS="yes"
 
@@ -312,6 +315,16 @@ coccinelle () {
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
2.8.2
