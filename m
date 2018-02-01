From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Thu,  1 Feb 2018 10:20:55 +0100
Subject: [Cocci] [PATCH] Coccinelle: coccicheck: fix typo
Message-ID: <1517476855-5235-1-git-send-email-Julia.Lawall@lip6.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Correct spelling of "coccinelle".

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 scripts/coccicheck |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index ecfac64..9fedca6 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -177,7 +177,7 @@ coccinelle () {
     REQ_NUM=$(echo $REQ | ${DIR}/scripts/ld-version.sh)
     if [ "$REQ_NUM" != "0" ] ; then
 	    if [ "$SPATCH_VERSION_NUM" -lt "$REQ_NUM" ] ; then
-		    echo "Skipping coccinele SmPL patch: $COCCI"
+		    echo "Skipping coccinelle SmPL patch: $COCCI"
 		    echo "You have coccinelle:           $SPATCH_VERSION"
 		    echo "This SmPL patch requires:      $REQ"
 		    return
