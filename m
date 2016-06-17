From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 17 Jun 2016 11:47:25 +0200 (CEST)
Subject: [Cocci] [PATCH v2 3/8] coccicheck: add indexing enhancement
	options
In-Reply-To: <1466116292-21843-4-git-send-email-mcgrof@kernel.org>
References: <1466116292-21843-1-git-send-email-mcgrof@kernel.org>
 <1466116292-21843-4-git-send-email-mcgrof@kernel.org>
Message-ID: <alpine.DEB.2.10.1606171146360.3164@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 16 Jun 2016, Luis R. Rodriguez wrote:

> Coccinelle has support to make use of its own enhanced "grep"
> mechanisms instead of using regular grep for searching code,
> it calls this 'coccigrep'. In lack of any indexing optimization
> information it uses --use-coccigrep by default.
>
> This patch enable indexing optimizations heuristics so that coccigrep
> can automatically detect what indexing options are available and use
> them accordinly without any user input.
>
> Since git has its own index, support for using 'git grep' has been
> added to Coccinelle, that should on average perform better than
> using the internal coccigrep. Coccinelle has had idutils support
> as well for a while now, you however need to refer to the index
> file. We support detecting two idutils index files by default,
> ID and .id-utils.index, assuming you ran either of:
>
>  # What you might have done:
> mkid -s
>  # as in coccinelle scripts/idutils_index.sh
> mkid -i C --output .id-utils.index *
>
> Lastly, Coccinelle has had support for glimpseindex for a long while,
> however the glimpseindex tool, the agrep library were previously closed
> source, its all now open sourced, and provides the best performance, so
> support that if we can detect you have a glimpse index.
>
> You can always override the index as follows:
>
> $ make coccicheck V=1 MODE=report COCCI_INDEX="--use-idutils ID"

Why not just have a generic COCCI_ARGS argument?

julia


> These tests have been run on an 8 core system:
>
> Before:
>
> $ export COCCI=scripts/coccinelle/misc/irqf_oneshot.cocci
> $ time make coccicheck MODE=report
>
> coccigrep (default and without this patch):
> real    0m16.369s
> user    0m58.712s
> sys     0m5.064s
>
> After:
>
> $ export COCCI=scripts/coccinelle/misc/irqf_oneshot.cocci
> $ time make coccicheck MODE=report
>
> With glimpse:
> real    0m6.549s
> user    0m49.136s
> sys     0m3.076s
>
> With idutils:
> real    0m6.749s
> user    0m51.936s
> sys     0m3.876s
>
> With gitgrep:
> real    0m6.805s
> user    0m51.572s
> sys     0m4.432s
>
> v2 changes:
>
> o simplify DIR assignment to 1 line
> o detected a bug when KBUILD_EXTMOD is used other than the parent
>   directory for both glimpse and idutils, so we avoid both when
>   M=path/driver/ is used. This is being looked into upstream on
>   Coccinelle.
> o move indexing heuristics to a file
> o document logic used for indexing
> o add idutils support, supports two indexing files
> o remove coccigrep heuristics as its the default anyway
> o add COCCI_INDEX to enable overriding heuristics, you can use this
>   as follows, for example:
> o replace references to stderr file with DEBUG_FILE use instructions
>
> $ export COCCI=scripts/coccinelle/misc/irqf_oneshot.cocci
> $ make coccicheck V=1 MODE=report COCCI_INDEX="--use-coccigrep"
> $ make coccicheck V=1 MODE=report COCCI_INDEX="--use-idutils ID"
> $ make coccicheck V=1 MODE=report COCCI_INDEX="--use-glimpse"
> $ make coccicheck V=1 MODE=report COCCI_INDEX="--use-gitgrep"
>
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> ---
>  scripts/coccicheck | 150 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 150 insertions(+)
>
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index 7acef3efc258..30f5a531ad34 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -5,6 +5,7 @@
>  # version 1.0.0-rc11.
>  #
>
> +DIR="$(dirname $(readlink -f $0))/.."
>  SPATCH="`which ${SPATCH:=spatch}`"
>
>  if [ ! -x "$SPATCH" ]; then
> @@ -15,6 +16,134 @@ fi
>  USE_JOBS="no"
>  $SPATCH --help | grep "\-\-jobs" > /dev/null && USE_JOBS="yes"
>
> +function can_use_glimpse()
> +{
> +	$SPATCH --help | grep "\-\-use\-glimpse" > /dev/null
> +	if [ $? -ne 0 ]; then
> +		echo "no"
> +		return
> +	fi
> +	if [ ! -f $DIR/.glimpse_index ]; then
> +		echo "no"
> +		return
> +	fi
> +
> +	# As of coccinelle 1.0.5 --use-glimpse cannot be used with M= other
> +	# than the base directory. We expect a future release will let us
> +	# specify the full path of the glimpse index but even if that's
> +	# supported, glimpse use seems to require an index per every
> +	# directory parsed, so you'd have to generate a glimpse index
> +	# per directory. If M=path is used (where epath is not the top level)
> +	# we'll have to fallback to alternatives then.
> +	if [ "$KBUILD_EXTMOD" != "./" -a "$KBUILD_EXTMOD" != "" ]; then
> +		echo "no"
> +		return
> +	fi
> +	echo yes
> +}
> +
> +function can_use_idutils()
> +{
> +	$SPATCH --help | grep "\-\-use\-idutils" > /dev/null
> +	if [ $? -ne 0 ]; then
> +		echo "no"
> +		return
> +	fi
> +	# As of coccinelle 1.0.5 --use-idutils will bust if one uses
> +	# idutils with an index out of the main tree.
> +	if [ "$KBUILD_EXTMOD" != "./" -a "$KBUILD_EXTMOD" != "" ]; then
> +		echo "no"
> +		return
> +	fi
> +	if [ -f $DIR/ID -o -f $DIR/.id-utils.index ]; then
> +		echo "yes"
> +		return
> +	fi
> +	echo "no"
> +}
> +
> +function can_use_gitgrep()
> +{
> +	$SPATCH --help | grep "\-\-use\-gitgrep" > /dev/null
> +	if [ $? -ne 0 ]; then
> +		echo "no"
> +		return
> +	fi
> +	if [ ! -d $DIR/.git ]; then
> +		echo "no"
> +		return
> +	fi
> +	echo "yes"
> +}
> +
> +# Indexing USE_* optimizations heuristics.
> +#
> +# Linux runs on git (TM). However, if you have supplemental indexing options
> +# you may use them to help Coccinelle further. If you are using Coccinelle
> +# within a target git tree --use-gitrep will be used, and this should
> +# suffice for most uses. If you however want optimal performance do
> +# consider embracing a supplemental indexing as part of your development.
> +# For instance glimpse, and idutils can be used, however you should
> +# be sure to update the indexes as often as you update your git tree to
> +# ensure your indexes are not stale.
> +#
> +# idutils is currently not as efficient as glimpse because the query language
> +# for glimpse is simpler, so when idutils is used more filtering has to be
> +# done at the ocaml level within Coccinelle. Glimpse allows queries that are
> +# arbitrary formulas, up to a limited level of complexity, involving both
> +# && and ||. For idutils, Coccinelle runs lid intersections on the result.
> +#
> +# You can override these heuristics with COCCI_INDEX="--use-gitgrep" for
> +# example. This will force to use --use-gitgrep even if you have a glimpse
> +# index. Other examples:
> +#
> +# $ export COCCI=scripts/coccinelle/misc/irqf_oneshot.cocci
> +# $ make coccicheck V=1 MODE=report COCCI_INDEX="--use-coccigrep"
> +# $ make coccicheck V=1 MODE=report COCCI_INDEX="--use-idutils ID"
> +# $ make coccicheck V=1 MODE=report COCCI_INDEX="--use-glimpse"
> +# $ make coccicheck V=1 MODE=report COCCI_INDEX="--use-gitgrep"
> +#
> +# The order of heuristics for indexing used by coccicheck is listed below.
> +#
> +# 0. Glimpse currently should outperform all indexing options. so if a glimpse
> +#    index is used we use it. Refer to Linux scripts/glimpse.sh for details.
> +#    If you think you should be getting better performance with glimpse than
> +#    what you would expect inspect the stderr log file for cocciecheck, you
> +#    ask for a debug file with DEBUG_FILE="" parameter to coccicheck.
> +#
> +#    If glimpse is running correctly there should be very few occurrences
> +#    of "Skipping", also coccinelle will inform you if it could not use
> +#    glimpse. As an example an output of the following would indicate glimpse
> +#    was properly used on the stderr log file:
> +#
> +#    There are matches to 1252 out of 47281 files
> +#    glimpse request = request_threaded_irq
> +#
> +# 1. Use idutils next. You'll need to generate an index using either of these:
> +#
> +#	a) mkid -s
> +#       By default this dumps the index into ./ID
> +#
> +#	b) mkid -i C --output .id-utils.index *
> +#       This method is provided with coccinelle repo on
> +#       scripts/idutils_index.sh
> +#
> +# 2. Next best is --use-gitgrep and if you are working within a git tree
> +#    this will be used by default.
> +#
> +# 3. By default coccinelle internally uses --use-coccigrep if no indexing
> +#    options are requested and your version of coccinelle supports it so we
> +#    do not need to be specific about requesting that as a fallback mechanism.
> +#    Use of --use-coccigrep is comparable to --use-gitgrep.
> +#
> +# XXX: Glimpse is not well maintained. See if we can add similar indexing
> +# features and query language glimpse supports to git.
> +if [ "$COCCI_INDEX" = "" ] ; then
> +	USE_GLIMPSE=$(can_use_glimpse)
> +	USE_IDUTILS=$(can_use_idutils)
> +	USE_GITGREP=$(can_use_gitgrep)
> +fi
> +
>  # The verbosity may be set by the environmental parameter V=
>  # as for example with 'make V=1 coccicheck'
>
> @@ -89,6 +218,27 @@ else
>  	OPTIONS="$OPTIONS --jobs $NPROC --chunksize 1"
>  fi
>
> +# Check COCCI_INDEX first to manual override, otherwise rely on
> +# internal heuristics documented above.
> +if [ "$COCCI_INDEX" != "" ] ; then
> +	OPTIONS="$OPTIONS $COCCI_INDEX"
> +elif [ "$USE_GLIMPSE" = "yes" ]; then
> +	OPTIONS="$OPTIONS --use-glimpse"
> +elif [ "$USE_IDUTILS" = "yes" ]; then
> +	index=""
> +	if [ -f $DIR/ID ]; then
> +		index="$DIR/ID"
> +	elif [ -f $DIR/.id-utils.index ]; then
> +		index="$DIR/.id-utils.index"
> +	else
> +		echo "idutils index not found, expected: $DIR/ID or $DIR/.id-utils.index"
> +		exit 1
> +	fi
> +	OPTIONS="$OPTIONS --use-idutils $index"
> +elif [ "$USE_GITGREP" = "yes" ]; then
> +	OPTIONS="$OPTIONS --use-gitgrep"
> +fi
> +
>  run_cmd_parmap() {
>  	if [ $VERBOSE -ne 0 ] ; then
>  		echo "Running ($NPROC in parallel): $@"
> --
> 2.8.2
>
>
