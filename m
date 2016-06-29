From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Wed, 29 Jun 2016 15:14:53 -0700
Subject: [Cocci] [PATCH v4 3/9] coccicheck: enable parmap support
In-Reply-To: <1467238499-10889-1-git-send-email-mcgrof@kernel.org>
References: <1467238499-10889-1-git-send-email-mcgrof@kernel.org>
Message-ID: <1467238499-10889-4-git-send-email-mcgrof@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Coccinelle has had parmap support since 1.0.2, this means
it supports --jobs, enabling built-in multithreaded functionality,
instead of needing one to script it out. Just look for --jobs
in the help output to determine if this is supported and use it
only if your number of processors detected is > 1.

If parmap is enabled also enable the load balancing to be dynamic, so
that if a thread finishes early we keep feeding it.

stderr is currently sent to /dev/null, addressing a way to capture
that will be addressed next.

If --jobs is not supported we fallback to the old mechanism.
We expect to deprecate the old mechanism as soon as we can get
confirmation all users are ready.

While at it propagate back into the shell script any coccinelle error
code. When used in serialized mode where all cocci files are run this
also stops processing if an error has occured. This lets us handle some
errors in coccinelle cocci files and if they bail out we should inspect
the errors. This will be more useful later to help annotate coccinelle
version dependency requirements. This will let you run only SmPL files
that your system supports.

Extend Documentation/coccinelle.txt as well.

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

v4:

o expand Documentation/coccinelle.txt to reflect parmap support info
o update commit log to reflect what we actually do now with stderr
o split out DEBUG_FILE use into another patch
o detect number of CPUs and if its 1 then skip parmap support,
  note that if you still support parmap, but have 1 CPU you will
  also go through the new branches, so the old complex multithreaded process
  is skipped as well.

v3:

o move USE_JOBS to avoid being overriden

v2:

o redirect coccinelle stderr to /dev/null by default and
  only if DEBUG_FILE is used do we pass it to a file
o fix typo of paramap/parmap

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
Acked-by: Nicolas Palix <nicolas.palix@imag.fr>
---
 Documentation/coccinelle.txt | 15 +++++++++++++++
 scripts/coccicheck           | 35 ++++++++++++++++++++++++++++++++---
 2 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/Documentation/coccinelle.txt b/Documentation/coccinelle.txt
index bb9632c20cfb..64daaf18874b 100644
--- a/Documentation/coccinelle.txt
+++ b/Documentation/coccinelle.txt
@@ -94,11 +94,26 @@ To enable verbose messages set the V= variable, for example:
 
    make coccicheck MODE=report V=1
 
+ Coccinelle parallelization
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
 By default, coccicheck tries to run as parallel as possible. To change
 the parallelism, set the J= variable. For example, to run across 4 CPUs:
 
    make coccicheck MODE=report J=4
 
+As of Coccinelle 1.0.2 Coccinelle uses Ocaml parmap for parallelization,
+if support for this is detected you will benefit from parmap parallelization.
+
+When parmap is enabled coccicheck will enable dynamic load balancing by using
+'--chunksize 1' argument, this ensures we keep feeding threads with work
+one by one, so that we avoid the situation where most work gets done by only
+a few threads. With dynamic load balancing, if a thread finishes early we keep
+feeding it more work.
+
+When parmap is enabled, if an error occurs in Coccinelle, this error
+value is propagated back, the return value of the 'make coccicheck'
+captures this return value.
 
  Using Coccinelle with a single semantic patch
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/scripts/coccicheck b/scripts/coccicheck
index 5319fae910b4..4b65a0fd50a1 100755
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
@@ -56,6 +56,16 @@ if [ "$KBUILD_EXTMOD" != "" ] ; then
     OPTIONS="--patch $srctree $OPTIONS"
 fi
 
+# You can override by using SPFLAGS
+if [ "$USE_JOBS" = "no" ]; then
+	trap kill_running SIGTERM SIGINT
+	declare -a SPATCH_PID
+elif [ "$NPROC" != "1" ]; then
+	# Using 0 should work as well, refer to _SC_NPROCESSORS_ONLN use on
+	# https://github.com/rdicosmo/parmap/blob/master/setcore_stubs.c
+	OPTIONS="$OPTIONS --jobs $NPROC --chunksize 1"
+fi
+
 if [ "$MODE" = "" ] ; then
     if [ "$ONLINE" = "0" ] ; then
 	echo 'You have not explicitly specified the mode to use. Using default "report" mode.'
@@ -82,7 +92,18 @@ if [ "$ONLINE" = "0" ] ; then
     echo ''
 fi
 
-run_cmd() {
+run_cmd_parmap() {
+	if [ $VERBOSE -ne 0 ] ; then
+		echo "Running ($NPROC in parallel): $@"
+	fi
+	$@ 2>/dev/null
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
@@ -97,6 +118,14 @@ run_cmd() {
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
2.8.4
