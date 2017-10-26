From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 26 Oct 2017 06:59:27 +0200 (CEST)
Subject: [Cocci] [PATCH] coccinelle: grep Options and Requires fields
 more precisely
In-Reply-To: <1508993438-15325-1-git-send-email-yamada.masahiro@socionext.com>
References: <1508993438-15325-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <alpine.DEB.2.20.1710260658330.17107@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 26 Oct 2017, Masahiro Yamada wrote:

> Currently, the required version for badzero.cocci is picked up from
> its "Comments:" line since it contains the word "Requires".
>
> Surprisingly, ld-version.sh can extract the version number from the
> string "Requires Coccinelle version 1.0.0-rc20 or later", but this
> expectation is fragile.  Fix the .cocci file.  I removed "-rc20"
> because ld-version.sh cannot handle it.

OK.

> Make the coccicheck script to see exact patterns for "Options:" and
> "Requires:" in order to avoid accidental matching to what just happens
> to appear in comment lines.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Thanks for checking on this!

Acked-by: Julia Lawall <julia.lawall@lip6.fr>

> ---
>
>  scripts/coccicheck                    | 4 ++--
>  scripts/coccinelle/null/badzero.cocci | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index 3e21a1b..1bfa2d2 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -168,8 +168,8 @@ OPTIONS="$OPTIONS $SPFLAGS"
>  coccinelle () {
>      COCCI="$1"
>
> -    OPT=`grep "Option" $COCCI | cut -d':' -f2`
> -    REQ=`grep "Requires" $COCCI | cut -d':' -f2 | sed "s| ||"`
> +    OPT=`grep "Options:" $COCCI | cut -d':' -f2`
> +    REQ=`grep "Requires:" $COCCI | cut -d':' -f2 | sed "s| ||"`
>      REQ_NUM=$(echo $REQ | ${DIR}/scripts/ld-version.sh)
>      if [ "$REQ_NUM" != "0" ] ; then
>  	    if [ "$SPATCH_VERSION_NUM" -lt "$REQ_NUM" ] ; then
> diff --git a/scripts/coccinelle/null/badzero.cocci b/scripts/coccinelle/null/badzero.cocci
> index 5551da2..f597c80 100644
> --- a/scripts/coccinelle/null/badzero.cocci
> +++ b/scripts/coccinelle/null/badzero.cocci
> @@ -10,7 +10,7 @@
>  // Copyright: (C) 2012 Julia Lawall, INRIA/LIP6.  GPLv2.
>  // Copyright: (C) 2012 Gilles Muller, INRIA/LiP6.  GPLv2.
>  // URL: http://coccinelle.lip6.fr/
> -// Comments: Requires Coccinelle version 1.0.0-rc20 or later
> +// Requires: 1.0.0
>  // Options:
>
>  virtual patch
> --
> 2.7.4
>
>
