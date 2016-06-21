From: Nicolas.Palix@imag.fr (Nicolas Palix (LIG))
Date: Tue, 21 Jun 2016 23:14:27 +0200
Subject: [Cocci] [PATCH v3 7/8] coccicheck: refer to coccicheck bottest
 wiki for documentation
In-Reply-To: <1466536893-23355-8-git-send-email-mcgrof@kernel.org>
References: <1466536893-23355-1-git-send-email-mcgrof@kernel.org>
 <1466536893-23355-8-git-send-email-mcgrof@kernel.org>
Message-ID: <9db10e04-779a-1bae-0ffe-2d43e5f46d2e@imag.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

Le 21/06/16 ? 21:21, Luis R. Rodriguez a ?crit :
> Sprinkling *tons* of documentation on the script is not a good
> idea, instead refer to a wiki for further coccicheck documentation:
>
> https://bottest.wiki.kernel.org/coccicheck
>
> This page shall always refer to the linux-next iteration of
> scripts/coccicheck.

Can you say a word about Documentation/coccinelle.txt too ?
And update it according to the script changes.

>
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> ---
>  scripts/coccicheck | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index 01b6716ea931..adbcbbd1aad6 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -1,9 +1,14 @@
>  #!/bin/bash
> -
> +# Linux kernel coccicheck
> +#
> +# For more detailed documentation refer to:
> +#
> +# https://bottest.wiki.kernel.org/coccicheck
> +#
> +# This documentation always refers to the linux-next version of the script.
>  #
>  # This script requires at least spatch
>  # version 1.0.0-rc11.
> -#
>
>  DIR="$(dirname $(readlink -f $0))/.."
>  SPATCH="`which ${SPATCH:=spatch}`"
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
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20160621/2878cc64/attachment.p7s>
