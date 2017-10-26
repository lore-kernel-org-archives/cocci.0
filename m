From: Nicolas.Palix@imag.fr (Nicolas Palix (LIG))
Date: Thu, 26 Oct 2017 09:22:59 +0200
Subject: [Cocci] [PATCH] coccinelle: fix verbose message about .cocci
 file being run
In-Reply-To: <1508993751-17218-1-git-send-email-yamada.masahiro@socionext.com>
References: <1508993751-17218-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <c18712da-6b47-3b13-059d-d49db738e386@imag.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Le 26/10/17 ? 06:55, Masahiro Yamada a ?crit?:
> If you run coccicheck with V=1 and COCCI=, you will see a strange
> path to the semantic patch file.  For example, run the following:
> 
> $ make V=1 COCCI=scripts/coccinelle/free/kfree.cocci coccicheck
>    [ snip ]
>   The semantic patch that makes this report is available
>   in scriptcoccinelle/free/kfree.cocci.
> 
> Notice "s/" was dropped from "scripts/coccinelle/free/kfree.cocci".
> 
> When running coccicheck without O=, $srctree is expanded to ".", which
> represents one arbitrary character in the regular expression.  Using
> sed is not a good choice here.  Strip $srctree/ simply without sed.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Nicolas Palix <nicolas.palix@imag.fr>
> ---
> 
>   scripts/coccicheck | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index 1bfa2d2..9d18662 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -186,7 +186,7 @@ coccinelle () {
>   
>       if [ $VERBOSE -ne 0 -a $ONLINE -eq 0 ] ; then
>   
> -	FILE=`echo $COCCI | sed "s|$srctree/||"`
> +	FILE=${COCCI#$srctree/}
>   
>   	echo "Processing `basename $COCCI`"
>   	echo "with option(s) \"$OPT\""
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
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20171026/4b23c66e/attachment-0001.p7s>
