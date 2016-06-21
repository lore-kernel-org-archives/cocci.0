From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Tue, 21 Jun 2016 12:21:27 -0700
Subject: [Cocci] [PATCH v3 2/8] coccicheck: make SPFLAGS more useful
In-Reply-To: <1466536893-23355-1-git-send-email-mcgrof@kernel.org>
References: <1466536893-23355-1-git-send-email-mcgrof@kernel.org>
Message-ID: <1466536893-23355-3-git-send-email-mcgrof@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

SPFLAGS is set early, it means that any heuristics done on
coccicheck cannot be overridden currently. Move SPFLAGS
after OPTIONS and set this at the end. This lets you override
any heuristics as coccinelle treats conflicts by only listening
to the last option that makes sense.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 scripts/coccicheck | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

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
2.8.2
