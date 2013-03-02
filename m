From: nicolas.palix@imag.fr (Nicolas Palix)
Date: Sat,  2 Mar 2013 22:36:28 +0100
Subject: [Cocci] [PATCH 4/4] Coccinelle: Fix patch output when coccicheck is
	used with M= and C=
In-Reply-To: <1362260188-14138-1-git-send-email-nicolas.palix@imag.fr>
References: <1362260188-14138-1-git-send-email-nicolas.palix@imag.fr>
Message-ID: <1362260188-14138-4-git-send-email-nicolas.palix@imag.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

When the M variable is used, the -patch option should be given
to spatch. This patch fixes the case where C is used.

Signed-off-by: Nicolas Palix <nicolas.palix@imag.fr>
---
 scripts/coccicheck |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index 6d492c0..06fcb33 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -29,10 +29,14 @@ else
     if [ "$KBUILD_EXTMOD" = "" ] ; then
         OPTIONS="-dir $srctree $COCCIINCLUDE"
     else
-        OPTIONS="-dir $KBUILD_EXTMOD -patch $srctree $COCCIINCLUDE"
+        OPTIONS="-dir $KBUILD_EXTMOD $COCCIINCLUDE"
     fi
 fi
 
+if [ "$KBUILD_EXTMOD" != "" ] ; then
+    OPTIONS="-patch $srctree $OPTIONS"
+fi
+
 if [ ! -x "$SPATCH" ]; then
     echo 'spatch is part of the Coccinelle project and is available at http://coccinelle.lip6.fr/'
     exit 1
-- 
1.7.10.4
