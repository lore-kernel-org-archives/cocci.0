From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 26 Oct 2017 13:56:46 +0900
Subject: [Cocci] [RFC PATCH] coccinelle: fix parallel build with
	CHECK=scripts/coccicheck
Message-ID: <1508993806-17320-1-git-send-email-yamada.masahiro@socionext.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

If I run the following:

  $ make -j8 C=1 CHECK=scripts/coccicheck

lots of "coccicheck failed" messages are displayed.

I do not know the coccinell internals, but I guess --jobs does not
work well if spatch is invoked from Make running in parallel.
Disable --jobs in this case.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/coccicheck | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index 9d18662..b74c789 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -69,6 +69,9 @@ if [ "$C" = "1" -o "$C" = "2" ]; then
     # Take only the last argument, which is the C file to test
     shift $(( $# - 1 ))
     OPTIONS="$COCCIINCLUDE $1"
+
+    # --jobs does not work if Make is running in parallel
+    echo $MAKEFLAGS | grep "\-\-jobserver-auth" && USE_JOBS="no"
 else
     ONLINE=0
     if [ "$KBUILD_EXTMOD" = "" ] ; then
-- 
2.7.4
