From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 10 Jun 2016 23:02:38 +0200 (CEST)
Subject: [Cocci] [PATCH 4/4] coccicheck: add indexing enhancement options
In-Reply-To: <1465591332-31113-5-git-send-email-mcgrof@kernel.org>
References: <1465591332-31113-1-git-send-email-mcgrof@kernel.org>
 <1465591332-31113-5-git-send-email-mcgrof@kernel.org>
Message-ID: <alpine.DEB.2.02.1606102301090.2070@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 10 Jun 2016, Luis R. Rodriguez wrote:

> Enable indexing optimizations heuristics. Coccinelle has
> support to make use of its own enhanced "grep" mechanisms
> instead of using regular grep for searching code 'coccigrep',
> in practice though this seems to not perform better than
> regular grep however its expected to help with some use cases
> so we use that if you have no other indexing options in place
> available.
> 
> Since git has its own index, support for using 'git grep' has been
> added to Coccinelle, that should on average perform better than
> using the internal cocci grep, and regular grep. Lastly, Coccinelle
> has had support for glimpseindex for a long while, however the
> tool was previously closed source, its now open sourced, and
> provides the best performance, so support that if we can detect
> you have a glimpse index.
> 
> These tests have been run on an 8 core system:
> 
> Before:
> 
> $ export COCCI=scripts/coccinelle/free/kfree.cocci
> $ time make coccicheck MODE=report
> 
> Before this patch with no indexing or anything:
> 
> real    16m22.435s
> user    128m30.060s
> sys     0m2.712s
> 
> Using coccigrep (after this patch if you have no .git):
> 
> real    16m27.650s
> user    128m47.904s
> sys     0m2.176s
> 
> If you have .git and therefore use gitgrep:
> 
> real    16m21.220s
> user    129m30.940s
> sys     0m2.060s
> 
> And if you have a .glimpse_index:
> 
> real    16m14.794s
> user    128m42.356s
> sys     0m1.880s

I don't see any convincing differences in these times.

I believe that Coccinelle's internal grep is always used, even with no 
option.

I'm puzzled why glimpse gives no benefit.

julia


> 
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> ---
>  scripts/coccicheck | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index eeb5fdc142ca..f31c9a152559 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -5,6 +5,8 @@
>  # version 1.0.0-rc11.
>  #
>  
> +DIR=$(dirname $(readlink -f $0))
> +DIR="${DIR}/../"
>  SPATCH="`which ${SPATCH:=spatch}`"
>  
>  if [ ! -x "$SPATCH" ]; then
> @@ -15,6 +17,20 @@ fi
>  USE_JOBS="no"
>  $SPATCH --help | grep "\-\-jobs" > /dev/null && USE_JOBS="yes"
>  
> +# 0. --use-glimpse currently outperforms all. Refer
> +#    to scripts/glimpse.sh for details.
> +# 1. Second best is --use-gitgrep, this is very comparable to --use-glimpse
> +# 2. Use --use-coccigrep if no indexing options are available and your
> +#    version of coccinelle supports it
> +USE_GLIMPSE="no"
> +$SPATCH --help | grep "\-\-use\-glimpse" > /dev/null && [ -f $DIR/.glimpse_index ] && USE_GLIMPSE="yes"
> +
> +USE_GITGREP="no"
> +$SPATCH --help | grep "\-\-use\-gitgrep" > /dev/null && [ -d $DIR/.git ] && USE_GITGREP="yes"
> +
> +USE_COCCIGREP="no"
> +$SPATCH --help | grep "\-\-use\-coccigrep" > /dev/null && USE_COCCIGREP="yes"
> +
>  # The verbosity may be set by the environmental parameter V=
>  # as for example with 'make V=1 coccicheck'
>  
> @@ -89,6 +105,14 @@ else
>  	OPTIONS="$OPTIONS --jobs $NPROC --chunksize 1"
>  fi
>  
> +if [ "$USE_GLIMPSE" = "yes" ]; then
> +	OPTIONS="$OPTIONS --use-glimpse"
> +elif [ "$USE_GITGREP" = "yes" ]; then
> +	OPTIONS="$OPTIONS --use-gitgrep"
> +elif [ "$USE_COCCIGREP" = "yes" ]; then
> +	OPTIONS="$OPTIONS --use-coccigrep"
> +fi
> +
>  run_cmd_paramap() {
>  	if [ $VERBOSE -ne 0 ] ; then
>  		echo "Running ($NPROC in parallel): $@"
> -- 
> 2.8.2
> 
> 
