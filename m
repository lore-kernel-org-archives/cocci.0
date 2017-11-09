From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu,  9 Nov 2017 16:00:50 +0900
Subject: [Cocci] [PATCH v2] coccinelle: fix parallel build with
	CHECK=scripts/coccicheck
Message-ID: <1510210850-28866-1-git-send-email-yamada.masahiro@socionext.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

The command "make -j8 C=1 CHECK=scripts/coccicheck" produces lots of
"coccicheck failed" error messages.

I do not know the coccinelle internals, but I guess --jobs does not
work well if spatch is invoked from Make running in parallel.
Disable --jobs in this case.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Grep '-j' instead of '--jobserver-auth'.
    '--jobserver-*' is not a stable option flag.
    Make 4.2 change '--jobserver-fds' into '--jobserver-auth'
  - Add -q option to grep

 scripts/coccicheck | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index 040a8b1..8bab11e 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -70,6 +70,9 @@ if [ "$C" = "1" -o "$C" = "2" ]; then
     # Take only the last argument, which is the C file to test
     shift $(( $# - 1 ))
     OPTIONS="$COCCIINCLUDE $1"
+
+    # --jobs does not work if Make is running in parallel
+    echo $MAKEFLAGS | grep -q -E '(^| )-j' && USE_JOBS="no"
 else
     ONLINE=0
     if [ "$KBUILD_EXTMOD" = "" ] ; then
-- 
2.7.4
