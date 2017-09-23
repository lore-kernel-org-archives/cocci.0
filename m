From: Nicolas.Palix@imag.fr (Nicolas Palix (LIG))
Date: Sat, 23 Sep 2017 18:49:29 +0200
Subject: [Cocci] [PATCH] coccicheck: improve pattern for getting
	relative path
In-Reply-To: <1502386825-363-1-git-send-email-cakturk@gmail.com>
References: <1502386825-363-1-git-send-email-cakturk@gmail.com>
Message-ID: <84d90a7d-899f-e6af-8f3c-cde69f5d1396@imag.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Le 10/08/17 ? 19:40, Cihangir Akturk a ?crit?:
> When invoked with V=1, coccicheck script prints the information about
> which semantic patch (*.cocci file) used for this operation.  Actually,
> it prints out the relative path of the related semantic patch. The
> script uses sed to remove the source tree part from cocci file path like
> so:
> 
> FILE=`echo $COCCI | sed "s|$srctree/||"`
> 
> This pattern works well most of the time. But in cases where $COCCI
> doesn't start with "./" characters, it doesn't remove the right part.
> 
> Consider the following scenario:
> 
> $ make coccicheck COCCI=scripts/coccinelle/api/drm-get-put.cocci \
>                          MODE=patch M=drivers/staging V=1
> 
> where
> 
> COCCI=scripts/coccinelle/api/drm-get-put.cocci and srctree=.
> 
> In this case, out pattern matches the first "s/", and we end up
> assigning "scriptcoccinelle/api/drm-get-put.cocci" to $FILE.
> 
> Fix this by adding a caret ^ at the beginning of regex pattern, so that
> it matches only start of the path.
> 
> Signed-off-by: Cihangir Akturk <cakturk@gmail.com>

Acked-by: nicolas.palix at univ-grenoble-alpes.fr
> --- >   scripts/coccicheck | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index ec487b8..8de4245 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -193,7 +193,7 @@ coccinelle () {
>   
>       if [ $VERBOSE -ne 0 -a $ONLINE -eq 0 ] ; then
>   
> -	FILE=`echo $COCCI | sed "s|$srctree/||"`
> +	FILE=`echo $COCCI | sed "s|^$srctree/||"`
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
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20170923/0c55ba04/attachment.p7s>
