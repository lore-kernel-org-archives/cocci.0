From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 9 May 2015 18:44:08 +0200 (CEST)
Subject: [Cocci] [PATCH 1/2] scripts/coccinelle/misc/semicolon.cocci:
 Use imperative mood
In-Reply-To: <1431185173-4705-1-git-send-email-festevam@gmail.com>
References: <1431185173-4705-1-git-send-email-festevam@gmail.com>
Message-ID: <alpine.DEB.2.02.1505091843250.2077@localhost6.localdomain6>
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
> its behaviour.
> 
> So do as recommended.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Julia Lawall <julia.lawall@lip6.fr>

> ---
>  scripts/coccinelle/misc/semicolon.cocci | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/coccinelle/misc/semicolon.cocci b/scripts/coccinelle/misc/semicolon.cocci
> index a47eba2..6740c65 100644
> --- a/scripts/coccinelle/misc/semicolon.cocci
> +++ b/scripts/coccinelle/misc/semicolon.cocci
> @@ -1,5 +1,5 @@
>  ///
> -/// Removes unneeded semicolon.
> +/// Remove unneeded semicolon.
>  ///
>  // Confidence: Moderate
>  // Copyright: (C) 2012 Peter Senna Tschudin, INRIA/LIP6.  GPLv2.
> -- 
> 1.9.1
> 
> 
