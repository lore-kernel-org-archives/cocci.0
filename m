From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Thu, 16 Jun 2016 15:31:29 -0700
Subject: [Cocci] [PATCH v2 5/8] coccicheck: replace --very-quiet with --quit
	when debugging
In-Reply-To: <1466116292-21843-1-git-send-email-mcgrof@kernel.org>
References: <1466116292-21843-1-git-send-email-mcgrof@kernel.org>
Message-ID: <1466116292-21843-6-git-send-email-mcgrof@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

When debugging (using --profile or --show-trying) you want to
avoid supressing output,  use --quiet instead. While at it, extend
documentation for SPFLAGS use.

For instance one can use:

$ export COCCI=scripts/coccinelle/misc/irqf_oneshot.cocci
$ make coccicheck DEBUG_FILE="poo.err" MODE=report SPFLAGS="--profile --show-trying" M=./drivers/mfd/arizona-irq.c

v2: use egrep instead of the *"=--option"* check, this doesn't work for
    disjunctions.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 scripts/coccicheck | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index 30f5a531ad34..f3a7d9fe9bc9 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -159,7 +159,25 @@ else
 	NPROC="$J"
 fi
 
-FLAGS="$SPFLAGS --very-quiet"
+# You can use SPFLAGS to append extra arguments to coccicheck.
+# A good example is if you want to debug your cocci script, you can
+# for instance use the following:
+#
+# $ export COCCI=scripts/coccinelle/misc/irqf_oneshot.cocci
+# $ time make coccicheck MODE=report DEBUG_FILE="all.err" SPFLAGS="--profile --show-trying" M=./drivers/mfd/arizona-irq.c
+#
+# "--show-trying" should show you what rule is being processed as it goes to
+# stdout, you do not need a debug file for that. The profile output will be
+# be sent to stdout, if you provide a DEBUG_FILE the profiling data can be
+# inspected there.
+#
+# --profile will not output if --very-quiet is used, so avoid it.
+echo $SPFLAGS | egrep -e "--profile|--show-trying" 2>&1 > /dev/null
+if [ $? -eq 0 ]; then
+	FLAGS="--quiet $SPFLAGS"
+else
+	FLAGS="--very-quiet $SPFLAGS"
+fi
 
 # spatch only allows include directories with the syntax "-I include"
 # while gcc also allows "-Iinclude" and "-include include"
-- 
2.8.2
