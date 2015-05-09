From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 9 May 2015 21:56:10 +0200 (CEST)
Subject: [Cocci] [PATCH 4/4] coccinelle: simple_open: Use imperative mood
In-Reply-To: <1431200930-16961-4-git-send-email-festevam@gmail.com>
References: <1431200930-16961-1-git-send-email-festevam@gmail.com>
 <1431200930-16961-4-git-send-email-festevam@gmail.com>
Message-ID: <alpine.DEB.2.02.1505092155560.2059@localhost6.localdomain6>
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
>  scripts/coccinelle/api/simple_open.cocci | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/coccinelle/api/simple_open.cocci b/scripts/coccinelle/api/simple_open.cocci
> index b67e174..bd1a2a4 100644
> --- a/scripts/coccinelle/api/simple_open.cocci
> +++ b/scripts/coccinelle/api/simple_open.cocci
> @@ -1,5 +1,5 @@
> -/// This removes an open coded simple_open() function
> -/// and replaces file operations references to the function
> +/// Remove an open coded simple_open() function
> +/// and replace file operations references to the function
>  /// with simple_open() instead.
>  ///
>  // Confidence: High
> -- 
> 1.9.1
> 
> 
