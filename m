From: Nicolas.Palix@imag.fr (Nicolas Palix (LIG))
Date: Tue, 21 Jun 2016 22:34:30 +0200
Subject: [Cocci] [PATCH v3 1/8] coccicheck: move spatch binary check up
In-Reply-To: <1466536893-23355-2-git-send-email-mcgrof@kernel.org>
References: <1466536893-23355-1-git-send-email-mcgrof@kernel.org>
 <1466536893-23355-2-git-send-email-mcgrof@kernel.org>
Message-ID: <43395d84-b94f-1d12-bfd5-8924996d7110@imag.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Le 21/06/16 ? 21:21, Luis R. Rodriguez a ?crit :
> This has no functional changes. This is being done
> to enable us to later use spatch binary for some
> flag checking for certain features early on.
>
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
Acked-by: Nicolas Palix <nicolas.palix@imag.fr>
> ---
>  scripts/coccicheck | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index f6627863fdc3..f137b04dfdd3 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -7,6 +7,11 @@
>
>  SPATCH="`which ${SPATCH:=spatch}`"
>
> +if [ ! -x "$SPATCH" ]; then
> +    echo 'spatch is part of the Coccinelle project and is available at http://coccinelle.lip6.fr/'
> +    exit 1
> +fi
> +
>  trap kill_running SIGTERM SIGINT
>  declare -a SPATCH_PID
>
> @@ -51,11 +56,6 @@ if [ "$KBUILD_EXTMOD" != "" ] ; then
>      OPTIONS="--patch $srctree $OPTIONS"
>  fi
>
> -if [ ! -x "$SPATCH" ]; then
> -    echo 'spatch is part of the Coccinelle project and is available at http://coccinelle.lip6.fr/'
> -    exit 1
> -fi
> -
>  if [ "$MODE" = "" ] ; then
>      if [ "$ONLINE" = "0" ] ; then
>  	echo 'You have not explicitly specified the mode to use. Using default "report" mode.'
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
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20160621/8728d288/attachment.p7s>
