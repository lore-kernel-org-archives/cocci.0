From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 9 May 2015 21:59:01 +0200 (CEST)
Subject: [Cocci] [PATCH 1/4] coccinelle: pm_runtime: Insert blank line
In-Reply-To: <1431200930-16961-1-git-send-email-festevam@gmail.com>
References: <1431200930-16961-1-git-send-email-festevam@gmail.com>
Message-ID: <alpine.DEB.2.02.1505092158140.2059@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 9 May 2015, Fabio Estevam wrote:

> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Insert a blank line in order to improve the readability of the 
> generated patch and also make it consistent with the other 
> .cocci files.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  scripts/coccinelle/api/pm_runtime.cocci | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/coccinelle/api/pm_runtime.cocci b/scripts/coccinelle/api/pm_runtime.cocci
> index f01789e..9208aa1 100644
> --- a/scripts/coccinelle/api/pm_runtime.cocci
> +++ b/scripts/coccinelle/api/pm_runtime.cocci
> @@ -1,4 +1,5 @@
>  /// Make sure pm_runtime_* calls does not use unnecessary IS_ERR_VALUE
> +///
>  //

Looking at the examples in the other fixes you have sent, it seems that 
what is wanted it to convert the // to /// rather than adding a /// before 
it.

Thanks for your help.

julia

>  // Keywords: pm_runtime
>  // Confidence: Medium
> -- 
> 1.9.1
> 
> 
