From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Tue, 14 Jun 2016 13:23:36 -0700
Subject: [Cocci] [PATCH v3 2/6] coccicheck: enable parmap support
In-Reply-To: <1465935820-14010-1-git-send-email-mcgrof@kernel.org>
References: <20160614201923.GC11948@wotan.suse.de>
 <1465935820-14010-1-git-send-email-mcgrof@kernel.org>
Message-ID: <1465935820-14010-3-git-send-email-mcgrof@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Coccinelle has had parmap support since 1.0.2, this means
it supports --jobs, enabling built-in multithreaded functionality,
instead of needing one to script it out. Just look for --jobs
in the help output to determine if this is supported.

Also enable the load balancing to be dynamic, so that if a
thread finishes early we keep feeding it.

Note: now that we have all things handled for us, redirect stderr to
stdout as well to capture any possible errors or warnings issued by
coccinelle.

If --jobs is not supported we fallback to the old mechanism.

As a small example, prior to this change, on an 8-core system:

Before:

$ export COCCI=scripts/coccinelle/free/kfree.cocci
$ time make coccicheck MODE=report
...

real    29m14.912s
user    103m1.796s
sys     0m4.464s

After:

real    16m22.435s
user    128m30.060s
sys     0m2.712s

v2:

o redirect coccinelle stderr to ${DIR}/coccicheck.$$.err
o fix typo of paramap/parmap

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 scripts/coccicheck | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index aa5e78fba270..02602381be59 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -12,8 +12,8 @@ if [ ! -x "$SPATCH" ]; then
     exit 1
 fi
 
-trap kill_running SIGTERM SIGINT
-declare -a SPATCH_PID
+USE_JOBS="no"
+$SPATCH --help | grep "\-\-jobs" > /dev/null && USE_JOBS="yes"
 
 # The verbosity may be set by the environmental parameter V=
 # as for example with 'make V=1 coccicheck'
@@ -82,7 +82,21 @@ if [ "$ONLINE" = "0" ] ; then
     echo ''
 fi
 
-run_cmd() {
+if [ "$USE_JOBS" = "no" ]; then
+	trap kill_running SIGTERM SIGINT
+	declare -a SPATCH_PID
+else
+	OPTIONS="$OPTIONS --jobs $NPROC --chunksize 1"
+fi
+
+run_cmd_parmap() {
+	if [ $VERBOSE -ne 0 ] ; then
+		echo "Running ($NPROC in parallel): $@"
+	fi
+	$@ 2> ${DIR}/coccicheck.$$.err
+}
+
+run_cmd_old() {
 	local i
 	if [ $VERBOSE -ne 0 ] ; then
 		echo "Running ($NPROC in parallel): $@"
@@ -97,6 +111,14 @@ run_cmd() {
 	wait
 }
 
+run_cmd() {
+	if [ "$USE_JOBS" = "yes" ]; then
+		run_cmd_parmap $@
+	else
+		run_cmd_old $@
+	fi
+}
+
 kill_running() {
 	for i in $(seq 0 $(( NPROC - 1 )) ); do
 		if [ $VERBOSE -eq 2 ] ; then
-- 
2.8.2
