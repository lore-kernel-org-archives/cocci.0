From: cakturk@gmail.com (Cihangir Akturk)
Date: Thu, 10 Aug 2017 20:40:25 +0300
Subject: [Cocci] [PATCH] coccicheck: improve pattern for getting relative
	path
Message-ID: <1502386825-363-1-git-send-email-cakturk@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

When invoked with V=1, coccicheck script prints the information about
which semantic patch (*.cocci file) used for this operation.  Actually,
it prints out the relative path of the related semantic patch. The
script uses sed to remove the source tree part from cocci file path like
so:

FILE=`echo $COCCI | sed "s|$srctree/||"`

This pattern works well most of the time. But in cases where $COCCI
doesn't start with "./" characters, it doesn't remove the right part.

Consider the following scenario:

$ make coccicheck COCCI=scripts/coccinelle/api/drm-get-put.cocci \
                        MODE=patch M=drivers/staging V=1

where

COCCI=scripts/coccinelle/api/drm-get-put.cocci and srctree=.

In this case, out pattern matches the first "s/", and we end up
assigning "scriptcoccinelle/api/drm-get-put.cocci" to $FILE.

Fix this by adding a caret ^ at the beginning of regex pattern, so that
it matches only start of the path.

Signed-off-by: Cihangir Akturk <cakturk@gmail.com>
---
 scripts/coccicheck | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index ec487b8..8de4245 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -193,7 +193,7 @@ coccinelle () {
 
     if [ $VERBOSE -ne 0 -a $ONLINE -eq 0 ] ; then
 
-	FILE=`echo $COCCI | sed "s|$srctree/||"`
+	FILE=`echo $COCCI | sed "s|^$srctree/||"`
 
 	echo "Processing `basename $COCCI`"
 	echo "with option(s) \"$OPT\""
-- 
2.7.4
