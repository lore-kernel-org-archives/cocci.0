From: Nicolas.Palix@imag.fr (Nicolas Palix (LIG))
Date: Tue, 21 Jun 2016 23:11:39 +0200
Subject: [Cocci] [PATCH v3 6/8] coccicheck: add support for requring a
 coccinelle version
In-Reply-To: <1466536893-23355-7-git-send-email-mcgrof@kernel.org>
References: <1466536893-23355-1-git-send-email-mcgrof@kernel.org>
 <1466536893-23355-7-git-send-email-mcgrof@kernel.org>
Message-ID: <eb46a0e8-8495-6f58-e51d-d5ab76993de0@imag.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Le 21/06/16 ? 21:21, Luis R. Rodriguez a ?crit :
> Enable Coccinelle SmPL patches to require a specific version of
> Coccinelle. In the event that the version does not match we just
> inform the user, if the user asked to go through all SmPL patches
> we just inform them of the need for a new version of coccinelle for
> the SmPL patch and continue on with the rest.
>
> This uses the simple kernel scripts/ld-version.sh to create a weight
> on the version provided by spatch. The -dirty attribute is ignored if
> supplied, the benefit of scripts/ld-version.sh is it has a long history
> and well tested.
>
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
Acked-by: Nicolas Palix <nicolas.palix@imag.fr>
> ---
>  scripts/coccicheck | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index 998d764636e0..01b6716ea931 100755
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
> @@ -12,6 +13,9 @@ if [ ! -x "$SPATCH" ]; then
>      exit 1
>  fi
>
> +SPATCH_VERSION=$($SPATCH --version | head -1 | awk '{print $3}')
> +SPATCH_VERSION_NUM=$(echo $SPATCH_VERSION | ${DIR}/scripts/ld-version.sh)
> +
>  USE_JOBS="no"
>  $SPATCH --help | grep "\-\-jobs" > /dev/null && USE_JOBS="yes"
>
> @@ -171,6 +175,16 @@ coccinelle () {
>      COCCI="$1"
>
>      OPT=`grep "Option" $COCCI | cut -d':' -f2`
> +    REQ=`grep "Requires" $COCCI | cut -d':' -f2 | sed "s| ||"`
> +    REQ_NUM=$(echo $REQ | ${DIR}/scripts/ld-version.sh)
> +    if [ "$REQ_NUM" != "0" ] ; then
> +	    if [ "$SPATCH_VERSION_NUM" -lt "$REQ_NUM" ] ; then
> +		    echo "Skipping coccinele SmPL patch: $COCCI"
> +		    echo "You have coccinelle:           $SPATCH_VERSION"
> +		    echo "This SmPL patch requires:      $REQ"
> +		    return
> +	    fi
> +    fi
>
>  #   The option '--parse-cocci' can be used to syntactically check the SmPL files.
>  #
>


-- 
Nicolas Palix
http://lig-membres.imag.fr/palix/

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 2959 bytes
Desc: Signature cryptographique S/MIME
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20160621/73dfb5e6/attachment-0001.p7s>
