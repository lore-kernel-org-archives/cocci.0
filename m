From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 9 May 2015 21:56:38 +0200 (CEST)
Subject: [Cocci] [PATCH 2/4] coccinelle: returnvar: Use imperative mood
In-Reply-To: <1431200930-16961-2-git-send-email-festevam@gmail.com>
References: <1431200930-16961-1-git-send-email-festevam@gmail.com>
 <1431200930-16961-2-git-send-email-festevam@gmail.com>
Message-ID: <alpine.DEB.2.02.1505092156280.2059@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sat, 9 May 2015, Fabio Estevam wrote:

> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> According to Documentation/SubmittingPatches:
> 
> "Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
> instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
> to do frotz", as if you are giving orders to the codebase to change
> its behaviour."
> 
> So do as recommended.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Julia Lawall <julia.lawall@lip6.fr>

> ---
>  scripts/coccinelle/misc/returnvar.cocci | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/coccinelle/misc/returnvar.cocci b/scripts/coccinelle/misc/returnvar.cocci
> index 605955a..d8286ef 100644
> --- a/scripts/coccinelle/misc/returnvar.cocci
> +++ b/scripts/coccinelle/misc/returnvar.cocci
> @@ -1,5 +1,5 @@
>  ///
> -/// Removes unneeded variable used to store return value.
> +/// Remove unneeded variable used to store return value.
>  ///
>  // Confidence: Moderate
>  // Copyright: (C) 2012 Peter Senna Tschudin, INRIA/LIP6.  GPLv2.
> -- 
> 1.9.1
> 
> 
