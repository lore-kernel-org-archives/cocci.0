From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Tue, 14 Jun 2016 13:23:39 -0700
Subject: [Cocci] [PATCH v3 5/6] coccicheck: document how to pass extra
	options to coccinelle
In-Reply-To: <1465935820-14010-1-git-send-email-mcgrof@kernel.org>
References: <20160614201923.GC11948@wotan.suse.de>
 <1465935820-14010-1-git-send-email-mcgrof@kernel.org>
Message-ID: <1465935820-14010-6-git-send-email-mcgrof@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

As an example show how to debug your coccinelle script.
While at it, fix the case when --profile is passed, when
--profile is used we need to ensure --very-quiet is not used.

For instance one can use:

$ export COCCI=scripts/coccinelle/misc/irqf_oneshot.cocci
$ make coccicheck MODE=report SPFLAGS="--profile --show-trying" M=./drivers/mfd/arizona-irq.c

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 scripts/coccicheck | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index 6d75fd8580a6..c6440138c6ea 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -106,7 +106,26 @@ else
 	NPROC="$J"
 fi
 
-FLAGS="$SPFLAGS --very-quiet"
+# You can use SPFLAGS to append extra arguments to coccicheck.
+# A good example is if you want to debug your cocci script, you can
+# for instance use the following:
+#
+# $ export COCCI=scripts/coccinelle/misc/irqf_oneshot.cocci
+# $ time make coccicheck MODE=report SPFLAGS="--profile --show-trying" M=./drivers/mfd/arizona-irq.c
+#
+# "--show-trying" should show you what rule is being processed as it goes, if
+# you have issues with a rule getting stuck you can then inspect the file:
+#
+# ${DIR}/coccicheck.$$.err
+#
+# which will have the profile output.
+#
+# --profile will not output if --very-quiet is used, so avoid it.
+if [[ $SPFLAGS  == *"--profile"* ]]; then
+	FLAGS="$SPFLAGS"
+else
+	FLAGS="$SPFLAGS --very-quiet"
+fi
 
 # spatch only allows include directories with the syntax "-I include"
 # while gcc also allows "-Iinclude" and "-include include"
-- 
2.8.2
