From: nicolas.palix@imag.fr (Nicolas Palix)
Date: Sat,  2 Mar 2013 22:36:27 +0100
Subject: [Cocci] [PATCH 3/4] Coccinelle: Add support to the SPFLAGS variable
In-Reply-To: <1362260188-14138-1-git-send-email-nicolas.palix@imag.fr>
References: <1362260188-14138-1-git-send-email-nicolas.palix@imag.fr>
Message-ID: <1362260188-14138-3-git-send-email-nicolas.palix@imag.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

The SPFLAGS variable allows to pass additional options
to spatch, e.g. -use_glimpse.

Signed-off-by: Nicolas Palix <nicolas.palix@imag.fr>
---
 Documentation/coccinelle.txt |   11 ++++++++++-
 scripts/coccicheck           |    2 +-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/coccinelle.txt b/Documentation/coccinelle.txt
index dffa2d6..18de785 100644
--- a/Documentation/coccinelle.txt
+++ b/Documentation/coccinelle.txt
@@ -114,7 +114,7 @@ To apply Coccinelle to a specific directory, M= can be used.
 For example, to check drivers/net/wireless/ one may write:
 
     make coccicheck M=drivers/net/wireless/
-    
+
 To apply Coccinelle on a file basis, instead of a directory basis, the
 following command may be used:
 
@@ -134,6 +134,15 @@ MODE variable explained above.
 In this mode, there is no information about semantic patches
 displayed, and no commit message proposed.
 
+ Additional flags
+~~~~~~~~~~~~~~~~~~
+
+Additional flags can be passed to spatch through the SPFLAGS
+variable.
+
+    make SPFLAGS=--use_glimpse coccicheck
+
+See spatch --help to learn more about spatch options.
 
  Proposing new semantic patches
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/scripts/coccicheck b/scripts/coccicheck
index cdde8e0..6d492c0 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -11,7 +11,7 @@ else
 	VERBOSE=0
 fi
 
-FLAGS="-very_quiet"
+FLAGS="$SPFLAGS -very_quiet"
 
 # spatch only allows include directories with the syntax "-I include"
 # while gcc also allows "-Iinclude" and "-include include"
-- 
1.7.10.4
