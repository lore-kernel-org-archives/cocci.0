From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Wed, 29 Jun 2016 15:10:19 -0700
Subject: [Cocci] [RFC v4 2/9] coccicheck: make SPFLAGS more useful
In-Reply-To: <1467238226-10822-1-git-send-email-mcgrof@kernel.org>
References: <1467238226-10822-1-git-send-email-mcgrof@kernel.org>
Message-ID: <1467238226-10822-3-git-send-email-mcgrof@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

SPFLAGS is set early, it means that any heuristics done on
coccicheck cannot be overridden currently. Move SPFLAGS
after OPTIONS and set this at the end. This lets you override
any heuristics as coccinelle treats conflicts by only listening
to the last option that makes sense.

v3: this patch was added in the v3 series
v4: Update Documentation/coccinelle.txt explaining how
    SPFLAGS works as well.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
Acked-by: Nicolas Palix <nicolas.palix@imag.fr>
---
 Documentation/coccinelle.txt | 3 ++-
 scripts/coccicheck           | 5 ++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/coccinelle.txt b/Documentation/coccinelle.txt
index 7f773d51fdd9..bb9632c20cfb 100644
--- a/Documentation/coccinelle.txt
+++ b/Documentation/coccinelle.txt
@@ -146,7 +146,8 @@ MODE variable explained above.
 ~~~~~~~~~~~~~~~~~~
 
 Additional flags can be passed to spatch through the SPFLAGS
-variable.
+variable. This works as Coccinelle respects the last flags
+given to it when options are in conflict.
 
     make SPFLAGS=--use-glimpse coccicheck
     make SPFLAGS=--use-idutils coccicheck
diff --git a/scripts/coccicheck b/scripts/coccicheck
index f137b04dfdd3..5319fae910b4 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -30,7 +30,7 @@ else
 	NPROC="$J"
 fi
 
-FLAGS="--very-quiet $SPFLAGS"
+FLAGS="--very-quiet"
 
 # spatch only allows include directories with the syntax "-I include"
 # while gcc also allows "-Iinclude" and "-include include"
@@ -106,6 +106,9 @@ kill_running() {
 	done
 }
 
+# You can override heuristics with SPFLAGS, these must always go last
+OPTIONS="$OPTIONS $SPFLAGS"
+
 coccinelle () {
     COCCI="$1"
 
-- 
2.8.4
