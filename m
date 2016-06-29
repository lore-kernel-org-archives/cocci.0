From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Wed, 29 Jun 2016 15:10:22 -0700
Subject: [Cocci] [RFC v4 5/9] coccicheck: replace --very-quiet with --quit
	when debugging
In-Reply-To: <1467238226-10822-1-git-send-email-mcgrof@kernel.org>
References: <1467238226-10822-1-git-send-email-mcgrof@kernel.org>
Message-ID: <1467238226-10822-6-git-send-email-mcgrof@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

When debugging (using --profile or --show-trying) you want to
avoid supressing output,  use --quiet instead. While at it, extend
documentation for SPFLAGS use.

For instance one can use:

$ export COCCI=scripts/coccinelle/misc/irqf_oneshot.cocci
$ make coccicheck DEBUG_FILE="poo.err" MODE=report SPFLAGS="--profile --show-trying" M=./drivers/mfd/arizona-irq.c

Expand Documentation/coccinelle.txt as well.

v4: expand Documentation/coccinelle.txt
v3: rebased, resolve conflicts, expand Documentation/coccinelle.txt
v2: use egrep instead of the *"=--option"* check, this doesn't work for
    disjunctions.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 Documentation/coccinelle.txt | 12 ++++++++++++
 scripts/coccicheck           | 23 +++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/Documentation/coccinelle.txt b/Documentation/coccinelle.txt
index 2516c5ef1691..4f5b2287a2b1 100644
--- a/Documentation/coccinelle.txt
+++ b/Documentation/coccinelle.txt
@@ -175,6 +175,18 @@ instance:
     make coccicheck COCCI=scripts/coccinelle/free/kfree.cocci MODE=report DEBUG_FILE=cocci.err
     cat cocci.err
 
+You can use SPFLAGS to add debugging flags, for instance you may want to
+add both --profile --show-trying to SPFLAGS when debugging. For instance
+you may want to use:
+
+    rm -f err.log
+    export COCCI=scripts/coccinelle/misc/irqf_oneshot.cocci
+    make coccicheck DEBUG_FILE="err.log" MODE=report SPFLAGS="--profile --show-trying" M=./drivers/mfd/arizona-irq.c
+
+err.log will now have the profiling information, while stdout will
+provide with some progress information as Coccinelle move forward with
+work.
+
 DEBUG_FILE support is only supported when using coccinelle >= 1.2.
 
  Additional flags
diff --git a/scripts/coccicheck b/scripts/coccicheck
index 3f0bb3f0fddc..1454a44d90a2 100755
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
2.8.4
