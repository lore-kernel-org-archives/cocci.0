From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Tue, 21 Jun 2016 12:21:28 -0700
Subject: [Cocci] [PATCH v3 3/8] coccicheck: enable parmap support
In-Reply-To: <1466536893-23355-1-git-send-email-mcgrof@kernel.org>
References: <1466536893-23355-1-git-send-email-mcgrof@kernel.org>
Message-ID: <1466536893-23355-4-git-send-email-mcgrof@kernel.org>
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
This also now accepts DEBUG_FILE= to specify where you want
stderr to be redirected to, by default we redirect stderr to
/dev/null.

Also since while at it propagate back into the shell script any
coccinelle error code. When used in serialized mode where all cocci
files are run this also stops processing if an error has occured.
This lets us handle some errors in coccinelle cocci files and if
they bail out we should inspect the errors. This will be more
useful later to help annotate coccinelle version dependency
requirements. This will let you run only SmPL files that your
system supports.

As a small example, prior to this change, on an 8-core system:

Before:

$ export COCCI=scripts/coccinelle/free/kfree.cocci
$ time make coccicheck MODE=report DEBUG_FILE=cocci.err
...

real    29m14.912s
user    103m1.796s
sys     0m4.464s

After:

real    16m22.435s
user    128m30.060s
sys     0m2.712s

v3:

o move USE_JOBS to avoid being overriden

v2:

o redirect coccinelle stderr to /dev/null by default and
  only if DEBUG_FILE is used do we pass it to a file
o fix typo of paramap/parmap

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 scripts/coccicheck | 41 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index 5319fae910b4..a77f0f246405 100755
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
@@ -56,6 +56,14 @@ if [ "$KBUILD_EXTMOD" != "" ] ; then
     OPTIONS="--patch $srctree $OPTIONS"
 fi
 
+# You can override by using SPFLAGS
+if [ "$USE_JOBS" = "no" ]; then
+	trap kill_running SIGTERM SIGINT
+	declare -a SPATCH_PID
+else
+	OPTIONS="$OPTIONS --jobs $NPROC --chunksize 1"
+fi
+
 if [ "$MODE" = "" ] ; then
     if [ "$ONLINE" = "0" ] ; then
 	echo 'You have not explicitly specified the mode to use. Using default "report" mode.'
@@ -82,7 +90,26 @@ if [ "$ONLINE" = "0" ] ; then
     echo ''
 fi
 
-run_cmd() {
+run_cmd_parmap() {
+	if [ $VERBOSE -ne 0 ] ; then
+		echo "Running ($NPROC in parallel): $@"
+	fi
+	if [ "$DEBUG_FILE" != "/dev/null" -a "$DEBUG_FILE" != "" ]; then
+		if [ -f $DEBUG_FILE ]; then
+			echo "Debug file $DEBUG_FILE exists, bailing"
+			exit
+		fi
+	else
+		DEBUG_FILE="/dev/null"
+	fi
+	$@ 2>$DEBUG_FILE
+	if [[ $? -ne 0 ]]; then
+		echo "coccicheck failed"
+		exit $?
+	fi
+}
+
+run_cmd_old() {
 	local i
 	if [ $VERBOSE -ne 0 ] ; then
 		echo "Running ($NPROC in parallel): $@"
@@ -97,6 +124,14 @@ run_cmd() {
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
