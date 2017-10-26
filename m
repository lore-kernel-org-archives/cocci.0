From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 26 Oct 2017 13:55:51 +0900
Subject: [Cocci] [PATCH] coccinelle: fix verbose message about .cocci file
	being run
Message-ID: <1508993751-17218-1-git-send-email-yamada.masahiro@socionext.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

If you run coccicheck with V=1 and COCCI=, you will see a strange
path to the semantic patch file.  For example, run the following:

$ make V=1 COCCI=scripts/coccinelle/free/kfree.cocci coccicheck
  [ snip ]
 The semantic patch that makes this report is available
 in scriptcoccinelle/free/kfree.cocci.

Notice "s/" was dropped from "scripts/coccinelle/free/kfree.cocci".

When running coccicheck without O=, $srctree is expanded to ".", which
represents one arbitrary character in the regular expression.  Using
sed is not a good choice here.  Strip $srctree/ simply without sed.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/coccicheck | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index 1bfa2d2..9d18662 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -186,7 +186,7 @@ coccinelle () {
 
     if [ $VERBOSE -ne 0 -a $ONLINE -eq 0 ] ; then
 
-	FILE=`echo $COCCI | sed "s|$srctree/||"`
+	FILE=${COCCI#$srctree/}
 
 	echo "Processing `basename $COCCI`"
 	echo "with option(s) \"$OPT\""
-- 
2.7.4
