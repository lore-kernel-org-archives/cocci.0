From: bernd.schubert@itwm.fraunhofer.de (Bernd Schubert)
Date: Tue, 22 Jan 2013 14:34:39 +0100
Subject: [Cocci] [PATCH 2/2] coccicheck: Allow to show the executed command
	line
In-Reply-To: <20130122133434.2543274.86646.stgit@fsdevel3>
References: <20130122133434.2543274.86646.stgit@fsdevel3>
Message-ID: <20130122133439.2543274.56232.stgit@fsdevel3>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On my system one of the tests failed with
"Fatal error: exception Failure("No OCaml compiler found! Install either ocamlopt or ocamlopt.opt")".

Investigating such issues is easier if the executed command line is being shown.

Signed-off-by: Bernd Schubert <bernd.schubert@itwm.fraunhofer.de>
CC: Julia Lawall <Julia.Lawall@lip6.fr>
CC: Nicolas Palix <nicolas.palix@imag.fr>
CC: cocci at systeme.lip6.fr
---
 scripts/coccicheck |   28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index eab0b00..fb98534 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -52,6 +52,14 @@ if [ "$ONLINE" = "0" ] ; then
     echo ''
 fi
 
+run_cmd() {
+	if [ "$RUN_VERBOSE" != "0" ] ; then
+		echo "Running: $@"
+	fi
+	eval $@
+}
+
+
 coccinelle () {
     COCCI="$1"
 
@@ -97,15 +105,21 @@ coccinelle () {
     fi
 
     if [ "$MODE" = "chain" ] ; then
-	$SPATCH -D patch   $FLAGS -sp_file $COCCI $OPT $OPTIONS               || \
-	$SPATCH -D report  $FLAGS -sp_file $COCCI $OPT $OPTIONS -no_show_diff || \
-	$SPATCH -D context $FLAGS -sp_file $COCCI $OPT $OPTIONS               || \
-	$SPATCH -D org     $FLAGS -sp_file $COCCI $OPT $OPTIONS -no_show_diff || exit 1
+	run_cmd $SPATCH -D patch   \
+		$FLAGS -sp_file $COCCI $OPT $OPTIONS               || \
+	run_cmd $SPATCH -D report  \
+		$FLAGS -sp_file $COCCI $OPT $OPTIONS -no_show_diff || \
+	run_cmd $SPATCH -D context \
+		$FLAGS -sp_file $COCCI $OPT $OPTIONS               || \
+	run_cmd $SPATCH -D org     \
+		$FLAGS -sp_file $COCCI $OPT $OPTIONS -no_show_diff || exit 1
     elif [ "$MODE" = "rep+ctxt" ] ; then
-	$SPATCH -D report  $FLAGS -sp_file $COCCI $OPT $OPTIONS -no_show_diff && \
-	$SPATCH -D context $FLAGS -sp_file $COCCI $OPT $OPTIONS || exit 1
+	run_cmd $SPATCH -D report  \
+		$FLAGS -sp_file $COCCI $OPT $OPTIONS -no_show_diff && \
+	run_cmd $SPATCH -D context \
+		$FLAGS -sp_file $COCCI $OPT $OPTIONS || exit 1
     else
-	$SPATCH -D $MODE   $FLAGS -sp_file $COCCI $OPT $OPTIONS || exit 1
+	run_cmd $SPATCH -D $MODE   $FLAGS -sp_file $COCCI $OPT $OPTIONS || exit 1
     fi
 
 }
