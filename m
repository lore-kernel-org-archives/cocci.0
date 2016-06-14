From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Tue, 14 Jun 2016 15:10:14 -0700
Subject: [Cocci] [PATCH 1/4] coccicheck: propagate error and stop processing
	after first error
In-Reply-To: <1465942217-14452-1-git-send-email-mcgrof@kernel.org>
References: <1465942217-14452-1-git-send-email-mcgrof@kernel.org>
Message-ID: <1465942217-14452-2-git-send-email-mcgrof@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Propagate back in the shell Coccinelle's error. Also stop
processing if an error has occured. This lets us handle some
errors in coccinelle cocci files and if they bail out we should
inspect the errors. This will be more useful later to help annotate
coccinelle version dependency requirements.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 scripts/coccicheck | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index 37db7ac1dfae..ba7301ab0a3d 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -215,6 +215,11 @@ run_cmd_parmap() {
 		echo "Running ($NPROC in parallel): $@"
 	fi
 	$@ 2> ${DIR}/coccicheck.$$.err
+	if [[ $? -ne 0 ]]; then
+		echo "coccicheck failed"
+		cat $${DIR}/coccicheck.$$.err
+		exit $?
+	fi
 }
 
 run_cmd_old() {
-- 
2.8.2
