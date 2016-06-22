From: Nicolas.Palix@imag.fr (Nicolas Palix (LIG))
Date: Wed, 22 Jun 2016 22:39:43 +0200
Subject: [Cocci] [PATCH v3 2/8] coccicheck: make SPFLAGS more useful
In-Reply-To: <1466536893-23355-3-git-send-email-mcgrof@kernel.org>
References: <1466536893-23355-1-git-send-email-mcgrof@kernel.org>
 <1466536893-23355-3-git-send-email-mcgrof@kernel.org>
Message-ID: <b3f046f9-d450-70c2-8577-9766126ea556@imag.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Le 21/06/16 ? 21:21, Luis R. Rodriguez a ?crit :
> SPFLAGS is set early, it means that any heuristics done on
> coccicheck cannot be overridden currently. Move SPFLAGS
> after OPTIONS and set this at the end. This lets you override
> any heuristics as coccinelle treats conflicts by only listening
> to the last option that makes sense.
>
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
Acked-by: Nicolas Palix <nicolas.palix@imag.fr>
> ---
>  scripts/coccicheck | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index f137b04dfdd3..5319fae910b4 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -30,7 +30,7 @@ else
>  	NPROC="$J"
>  fi
>
> -FLAGS="--very-quiet $SPFLAGS"
> +FLAGS="--very-quiet"
>
>  # spatch only allows include directories with the syntax "-I include"
>  # while gcc also allows "-Iinclude" and "-include include"
> @@ -106,6 +106,9 @@ kill_running() {
>  	done
>  }
>
> +# You can override heuristics with SPFLAGS, these must always go last
> +OPTIONS="$OPTIONS $SPFLAGS"
> +
>  coccinelle () {
>      COCCI="$1"
>
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
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20160622/91b0f297/attachment-0001.p7s>
