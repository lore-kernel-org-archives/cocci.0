From: keescook@chromium.org (Kees Cook)
Date: Mon, 16 May 2016 05:55:58 -0700
Subject: [Cocci] [PATCH] coccicheck: Fix missing 0 index in kill loop
Message-ID: <20160516125558.GA352@www.outflux.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

By default, "seq" counts from 1, but processes were starting counting
from 0, so when interrupted, coccicheck would leave the 0th process
running.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 scripts/coccicheck | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index b2d758188f2f..dd85a455b2ba 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -98,7 +98,7 @@ run_cmd() {
 }
 
 kill_running() {
-	for i in $(seq $(( NPROC - 1 )) ); do
+	for i in $(seq 0 $(( NPROC - 1 )) ); do
 		if [ $VERBOSE -eq 2 ] ; then
 			echo "Killing ${SPATCH_PID[$i]}"
 		fi
-- 
2.6.3


-- 
Kees Cook
Chrome OS & Brillo Security
