From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 9 May 2015 18:43:07 +0200 (CEST)
Subject: [Cocci] [PATCH 2/2] scripts/coccinelle/misc/irqf_oneshot.cocci:
 Fix grammar
In-Reply-To: <1431185173-4705-2-git-send-email-festevam@gmail.com>
References: <1431185173-4705-1-git-send-email-festevam@gmail.com>
 <1431185173-4705-2-git-send-email-festevam@gmail.com>
Message-ID: <alpine.DEB.2.02.1505091842290.2077@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 9 May 2015, Fabio Estevam wrote:

> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Correct form is 'always requested'.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Julia Lawall <julia.lawall@lip6.fr>

> ---
>  scripts/coccinelle/misc/irqf_oneshot.cocci | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/coccinelle/misc/irqf_oneshot.cocci b/scripts/coccinelle/misc/irqf_oneshot.cocci
> index a24a754..b17ac8b 100644
> --- a/scripts/coccinelle/misc/irqf_oneshot.cocci
> +++ b/scripts/coccinelle/misc/irqf_oneshot.cocci
> @@ -1,4 +1,4 @@
> -/// Make sure threaded IRQs without a primary handler are always request with
> +/// Make sure threaded IRQs without a primary handler are always requested with
>  /// IRQF_ONESHOT
>  ///
>  //
> -- 
> 1.9.1
> 
> 
