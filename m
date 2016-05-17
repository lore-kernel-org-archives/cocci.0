From: Nicolas.Palix@imag.fr (Nicolas Palix (LIG))
Date: Tue, 17 May 2016 16:32:41 +0200
Subject: [Cocci] [PATCH] coccicheck: Fix missing 0 index in kill loop
In-Reply-To: <20160516125558.GA352@www.outflux.net>
References: <20160516125558.GA352@www.outflux.net>
Message-ID: <573B2B89.7060004@imag.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Le 16/05/16 14:55, Kees Cook a ?crit :
> By default, "seq" counts from 1, but processes were starting counting
> from 0, so when interrupted, coccicheck would leave the 0th process
> running.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Nicolas Palix <nicolas.palix@imag.fr>


> ---
>  scripts/coccicheck | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index b2d758188f2f..dd85a455b2ba 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -98,7 +98,7 @@ run_cmd() {
>  }
>  
>  kill_running() {
> -	for i in $(seq $(( NPROC - 1 )) ); do
> +	for i in $(seq 0 $(( NPROC - 1 )) ); do
>  		if [ $VERBOSE -eq 2 ] ; then
>  			echo "Killing ${SPATCH_PID[$i]}"
>  		fi
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
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20160517/5fcdf348/attachment.p7s>
