From: nm@ti.com (Nishanth Menon)
Date: Wed, 17 Feb 2016 17:47:37 -0600
Subject: [Cocci] [PATCH] scripts/coccinelle: modernize &
In-Reply-To: <1455750974-24339-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1455750974-24339-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <56C50699.6000007@ti.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 02/17/2016 05:16 PM, Julia Lawall wrote:
> & is no longer allowed in column 0, since Coccinelle 1.0.4.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> ---
>  scripts/coccinelle/iterators/use_after_iter.cocci |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/coccinelle/iterators/use_after_iter.cocci b/scripts/coccinelle/iterators/use_after_iter.cocci
> index f085f59..ce8cc9c 100644
> --- a/scripts/coccinelle/iterators/use_after_iter.cocci
> +++ b/scripts/coccinelle/iterators/use_after_iter.cocci
> @@ -123,7 +123,7 @@ list_remove_head(x,c,...)
>  |
>  sizeof(<+...c...+>)
>  |
> -&c->member
> + &c->member
>  |
>  c = E
>  |
> 


Verified with:
spatch --version
spatch byte-code version 1.0.4-00118-gc7cf750d1c44 compiled with OCaml
version 4.01.0


Tested-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
