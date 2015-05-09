From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 9 May 2015 21:55:51 +0200 (CEST)
Subject: [Cocci] [PATCH 3/4] coccinelle: ifaddr: Fix the sentence
In-Reply-To: <1431200930-16961-3-git-send-email-festevam@gmail.com>
References: <1431200930-16961-1-git-send-email-festevam@gmail.com>
 <1431200930-16961-3-git-send-email-festevam@gmail.com>
Message-ID: <alpine.DEB.2.02.1505092155350.2059@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 9 May 2015, Fabio Estevam wrote:

> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Make the sentence sensible.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Julia Lawall <julia.lawall@lip6.fr>

> ---
>  scripts/coccinelle/misc/ifaddr.cocci | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/scripts/coccinelle/misc/ifaddr.cocci b/scripts/coccinelle/misc/ifaddr.cocci
> index 8aebd18..c2663c6 100644
> --- a/scripts/coccinelle/misc/ifaddr.cocci
> +++ b/scripts/coccinelle/misc/ifaddr.cocci
> @@ -1,5 +1,4 @@
> -/// the address of a variable or field is non-zero is likely always to bo
> -/// non-zero
> +/// The address of a variable or field is likely always to be non-zero.
>  ///
>  // Confidence: High
>  // Copyright: (C) 2012 Julia Lawall, INRIA/LIP6.  GPLv2.
> -- 
> 1.9.1
> 
> 
