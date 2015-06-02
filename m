From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 2 Jun 2015 07:18:07 +0200 (CEST)
Subject: [Cocci] [PATCH] coccinelle: simple_return: Add a blank line
In-Reply-To: <1433209940-19303-1-git-send-email-festevam@gmail.com>
References: <1433209940-19303-1-git-send-email-festevam@gmail.com>
Message-ID: <alpine.DEB.2.02.1506020717430.2082@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, 1 Jun 2015, Fabio Estevam wrote:

> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Insert a blank line in order to improve the readability of the
> generated patch and also make it consistent with the other
> .cocci files.

Acked-by: Julia Lawall <julia.lawall@lip6.fr>

> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  scripts/coccinelle/misc/simple_return.cocci | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/coccinelle/misc/simple_return.cocci b/scripts/coccinelle/misc/simple_return.cocci
> index 47f7084..e8b6313 100644
> --- a/scripts/coccinelle/misc/simple_return.cocci
> +++ b/scripts/coccinelle/misc/simple_return.cocci
> @@ -1,6 +1,6 @@
>  /// Simplify a trivial if-return sequence.  Possibly combine with a
>  /// preceding function call.
> -//
> +///
>  // Confidence: High
>  // Copyright: (C) 2014 Julia Lawall, INRIA/LIP6.  GPLv2.
>  // Copyright: (C) 2014 Gilles Muller, INRIA/LiP6.  GPLv2.
> -- 
> 1.9.1
> 
> 
