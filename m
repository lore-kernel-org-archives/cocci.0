From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Tue, 14 Jun 2016 13:05:50 -0700
Subject: [Cocci] [PATCH v2 3/5] coccicheck: add indexing enhancement options
In-Reply-To: <1465934752-13792-1-git-send-email-mcgrof@kernel.org>
References: <1465934752-13792-1-git-send-email-mcgrof@kernel.org>
Message-ID: <1465934752-13792-4-git-send-email-mcgrof@kernel.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Coccinelle has support to make use of its own enhanced "grep"
mechanisms instead of using regular grep for searching code,
it calls this 'coccigrep'. In lack of any indexing optimization
information it uses --use-coccigrep by default.

This patch enable indexing optimizations heuristics so that coccigrep
can automatically detect what indexing options are available and use
them accordinly without any user input.

Since git has its own index, support for using 'git grep' has been
added to Coccinelle, that should on average perform better than
using the internal coccigrep. Coccinelle has had idutils support
as well for a while now, you however need to refer to the index
file. We support detecting two idutils index files by default,
ID and .id-utils.index, assuming you ran either of:

 # What you might have done:
mkid -s
 # as in coccinelle scripts/idutils_index.sh
mkid -i C --output .id-utils.index *

Lastly, Coccinelle has had support for glimpseindex for a long while,
however the glimpseindex tool, the agrep library were previously closed
source, its all now open sourced, and provides the best performance, so
support that if we can detect you have a glimpse index.

You can always override the index as follows:

$ make coccicheck V=1 MODE=report COCCI_INDEX="--use-idutils ID"

These tests have been run on an 8 core system:

Before:

$ export COCCI=scripts/coccinelle/misc/irqf_oneshot.cocci
$ time make coccicheck MODE=report

coccigrep (default and without this patch):
real    0m16.369s
user    0m58.712s
sys     0m5.064s

After:

$ export COCCI=scripts/coccinelle/misc/irqf_oneshot.cocci
$ time make coccicheck MODE=report

With glimpse:
real    0m6.549s
user    0m49.136s
sys     0m3.076s

With idutils:
real    0m6.749s
user    0m51.936s
sys     0m3.876s

With gitgrep:
real    0m6.805s
user    0m51.572s
sys     0m4.432s

o document logic used for indexing
o add idutils support, supports two indexing files
o remove coccigrep heuristics as its the default anyway
o add COCCI_INDEX to enable overriding heuristics, you can use this
  as follows, for example:

$ export COCCI=scripts/coccinelle/misc/irqf_oneshot.cocci
$ make coccicheck V=1 MODE=report COCCI_INDEX="--use-coccigrep"
$ make coccicheck V=1 MODE=report COCCI_INDEX="--use-idutils ID"
$ make coccicheck V=1 MODE=report COCCI_INDEX="--use-glimpse"
$ make coccicheck V=1 MODE=report COCCI_INDEX="--use-gitgrep"

o Refer users to ${DIR}/coccicheck.$$.err for indexing errors,
  document what is expected to ensure glimpse is working correctly

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 scripts/coccicheck | 97 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/scripts/coccicheck b/scripts/coccicheck
index 02602381be59..6d75fd8580a6 100755
--- a/scripts/coccicheck
+++ b/scripts/coccicheck
@@ -5,6 +5,8 @@
 # version 1.0.0-rc11.
 #
 
+DIR=$(dirname $(readlink -f $0))
+DIR="${DIR}/../"
 SPATCH="`which ${SPATCH:=spatch}`"
 
 if [ ! -x "$SPATCH" ]; then
@@ -15,6 +17,80 @@ fi
 USE_JOBS="no"
 $SPATCH --help | grep "\-\-jobs" > /dev/null && USE_JOBS="yes"
 
+# Indexing USE_* optimizations heuristics.
+#
+# Linux runs on git (TM). However, if you have supplemental indexing options
+# you may use them to help Coccinelle further. If you are using Coccinelle
+# within a target git tree --use-gitrep will be used, and this should
+# suffice for most uses. If you however want optimal performance do
+# consider embracing a supplemental indexing as part of your development.
+# For instance glimpse, and idutils can be used, however you should
+# be sure to update the indexes as often as you update your git tree to
+# ensure your indexes are not stale.
+#
+# idutils is currently not as efficient as glimpse because the query language
+# for glimpse is simpler, so when idutils is used more filtering has to be
+# done at the ocaml level within Coccinelle. Glimpse allows queries that are
+# arbitrary formulas, up to a limited level of complexity, involving both
+# && and ||. For idutils, Coccinelle runs lid intersections on the result.
+#
+# You can override these heuristics with COCCI_INDEX="--use-gitgrep" for
+# example. This will force to use --use-gitgrep even if you have a glimpse
+# index. Other examples:
+#
+# $ export COCCI=scripts/coccinelle/misc/irqf_oneshot.cocci
+# $ make coccicheck V=1 MODE=report COCCI_INDEX="--use-coccigrep"
+# $ make coccicheck V=1 MODE=report COCCI_INDEX="--use-idutils ID"
+# $ make coccicheck V=1 MODE=report COCCI_INDEX="--use-glimpse"
+# $ make coccicheck V=1 MODE=report COCCI_INDEX="--use-gitgrep"
+#
+# The order of heuristics for indexing used by coccicheck is listed below.
+#
+# 0. Glimpse currently should outperform all indexing options. so if a glimpse
+#    index is used we use it. Refer to Linux scripts/glimpse.sh for details.
+#    If you think you should be getting better performance with glimpse than
+#    what you would expect inspect the stderr log file for cocciecheck:
+#
+#    ${DIR}/coccicheck.$$.err
+#
+#    If glimpse is running correctly there should be very few occurrences
+#    of "Skipping", also coccinelle will inform you if it could not use
+#    glimpse. As an example an output of the following would indicate glimpse
+#    was properly used on ${DIR}/coccicheck.$$.err :
+#
+#    There are matches to 1252 out of 47281 files
+#    glimpse request = request_threaded_irq
+#
+# 1. Use idutils next. You'll need to generate an index using either of these:
+#
+#	a) mkid -s
+#       By default this dumps the index into ./ID
+#
+#	b) mkid -i C --output .id-utils.index *
+#       This method is provided with coccinelle repo on
+#       scripts/idutils_index.sh
+#
+# 2. Next best is --use-gitgrep and if you are working within a git tree
+#    this will be used by default.
+#
+# 3. By default coccinelle internally uses --use-coccigrep if no indexing
+#    options are requested and your version of coccinelle supports it so we
+#    do not need to be specific about requesting that as a fallback mechanism.
+#    Use of --use-coccigrep is comparable to --use-gitgrep.
+#
+# XXX: Glimpse is not well maintained. See if we can add similar indexing
+# features and query language glimpse supports to git.
+if [ "$COCCI_INDEX" = "" ] ; then
+	USE_GLIMPSE="no"
+	$SPATCH --help | grep "\-\-use\-glimpse" > /dev/null && [ -f $DIR/.glimpse_index ] && USE_GLIMPSE="yes"
+
+	USE_IDUTILS="no"
+	$SPATCH --help | grep "\-\-use\-idutils" > /dev/null && [ -f $DIR/ID -o -f $DIR/.id-utils.index ] && USE_IDUTILS="yes"
+
+	USE_GITGREP="no"
+	$SPATCH --help | grep "\-\-use\-gitgrep" > /dev/null && [ -d $DIR/.git ] && USE_GITGREP="yes"
+fi
+
 # The verbosity may be set by the environmental parameter V=
 # as for example with 'make V=1 coccicheck'
 
@@ -89,6 +165,27 @@ else
 	OPTIONS="$OPTIONS --jobs $NPROC --chunksize 1"
 fi
 
+# Check COCCI_INDEX first to manual override, otherwise rely on
+# internal heuristics documented above.
+if [ "$COCCI_INDEX" != "" ] ; then
+	OPTIONS="$OPTIONS $COCCI_INDEX"
+elif [ "$USE_GLIMPSE" = "yes" ]; then
+	OPTIONS="$OPTIONS --use-glimpse"
+elif [ "$USE_IDUTILS" = "yes" ]; then
+	index=""
+	if [ -f $DIR/ID ]; then
+		index="$DIR/ID"
+	elif [ -f $DIR/.id-utils.index ]; then
+		index="$DIR/.id-utils.index"
+	else
+		echo "idutils index not found, expected: $DIR/ID or $DIR/.id-utils.index"
+		exit 1
+	fi
+	OPTIONS="$OPTIONS --use-idutils $index"
+elif [ "$USE_GITGREP" = "yes" ]; then
+	OPTIONS="$OPTIONS --use-gitgrep"
+fi
+
 run_cmd_parmap() {
 	if [ $VERBOSE -ne 0 ] ; then
 		echo "Running ($NPROC in parallel): $@"
-- 
2.8.2
