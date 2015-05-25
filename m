From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 25 May 2015 14:18:21 +0200 (CEST)
Subject: [Cocci] [PATCH 1/2] coccinelle: clk_put.cocci: Adjust commit
 log of generated patch
In-Reply-To: <1432554373-6444-1-git-send-email-fabio.estevam@freescale.com>
References: <1432554373-6444-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <alpine.DEB.2.10.1505251418040.2491@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, 25 May 2015, Fabio Estevam wrote:

> The commit log should better describe the action that the patch will do.
>
> In this case we are 'adding' the missing clk_put.

Here too, the semantic patch doesn't add anything.

julia

> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  scripts/coccinelle/free/clk_put.cocci | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/coccinelle/free/clk_put.cocci b/scripts/coccinelle/free/clk_put.cocci
> index 46747ad..492b3b0 100644
> --- a/scripts/coccinelle/free/clk_put.cocci
> +++ b/scripts/coccinelle/free/clk_put.cocci
> @@ -1,4 +1,4 @@
> -/// Find missing clk_puts.
> +/// Add missing clk_put.
>  ///
>  //# This only signals a missing clk_put when there is a clk_put later
>  //# in the same function.
> --
> 1.9.1
>
>
