From: nicolas.palix@imag.fr (Nicolas Palix)
Date: Thu,  6 Jun 2013 23:30:56 +0200
Subject: [Cocci] [PATCH 1/2] Coccinelle: Make 'report' the default mode
Message-ID: <1370554257-8864-1-git-send-email-nicolas.palix@imag.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

It appears that the 'report' mode is the one always
provided by the semantic patches included in the kernel.
It is thus more natural to select it by default.

The 'chain' mode is however kept and the 'patch' mode
is still the first tried in that case.
---
 scripts/coccicheck | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index 06fcb33..9d8780c 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -44,11 +44,19 @@ fi
 
 if [ "$MODE" = "" ] ; then
     if [ "$ONLINE" = "0" ] ; then
-	echo 'You have not explicitly specified the mode to use. Using default "chain" mode.'
-	echo 'All available modes will be tried (in that order): patch, report, context, org'
+	echo 'You have not explicitly specified the mode to use. Using default "report" mode.'
+	echo 'Available modes are the following: patch, report, context, org'
 	echo 'You can specify the mode with "make coccicheck MODE=<mode>"'
+	echo 'Note however that some modes are not implemented by some semantic patches.'
+    fi
+    MODE="report"
+fi
+
+if [ "$MODE" = "chain" ] ; then
+    if [ "$ONLINE" = "0" ] ; then
+	echo 'You have selected the "chain" mode.'
+	echo 'All available modes will be tried (in that order): patch, report, context, org'
     fi
-    MODE="chain"
 elif [ "$MODE" = "report" -o "$MODE" = "org" ] ; then
     FLAGS="$FLAGS -no_show_diff"
 fi
-- 
1.8.1.2
