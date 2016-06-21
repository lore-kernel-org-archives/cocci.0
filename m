From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Tue, 21 Jun 2016 12:21:29 -0700
Subject: [Cocci] [PATCH v3 4/8] coccicheck: replace --very-quiet with --quit
	when debugging
In-Reply-To: <1466536893-23355-1-git-send-email-mcgrof@kernel.org>
References: <1466536893-23355-1-git-send-email-mcgrof@kernel.org>
Message-ID: <1466536893-23355-5-git-send-email-mcgrof@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

When debugging (using --profile or --show-trying) you want to
avoid supressing output,  use --quiet instead. While at it, extend
documentation for SPFLAGS use.

For instance one can use:

$ export COCCI=scripts/coccinelle/misc/irqf_oneshot.cocci
$ make coccicheck DEBUG_FILE="poo.err" MODE=report SPFLAGS="--profile --show-trying" M=./drivers/mfd/arizona-irq.c

v3: rebased, resolve conflicts
v2: use egrep instead of the *"=--option"* check, this doesn't work for
    disjunctions.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 scripts/coccicheck | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index a77f0f246405..998d764636e0 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -32,6 +32,29 @@ fi
 
 FLAGS="--very-quiet"
 
+# You can use SPFLAGS to append extra arguments to coccicheck or override any
+# heuristics done in this file as Coccinelle accepts the last options when
+# options conflict.
+#
+# A good example for use of SPFLAGS is if you want to debug your cocci script,
+# you can for instance use the following:
+#
+# $ export COCCI=scripts/coccinelle/misc/irqf_oneshot.cocci
+# $ make coccicheck MODE=report DEBUG_FILE="all.err" SPFLAGS="--profile --show-trying" M=./drivers/mfd/arizona-irq.c
+#
+# "--show-trying" should show you what rule is being processed as it goes to
+# stdout, you do not need a debug file for that. The profile output will be
+# be sent to stdout, if you provide a DEBUG_FILE the profiling data can be
+# inspected there.
+#
+# --profile will not output if --very-quiet is used, so avoid it.
+echo $SPFLAGS | egrep -e "--profile|--show-trying" 2>&1 > /dev/null
+if [ $? -eq 0 ]; then
+	FLAGS="--quiet"
+else
+	FLAGS="--very-quiet"
+fi
+
 # spatch only allows include directories with the syntax "-I include"
 # while gcc also allows "-Iinclude" and "-include include"
 COCCIINCLUDE=${LINUXINCLUDE//-I/-I }
-- 
2.8.2
