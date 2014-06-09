From: mmarek@suse.cz (Michal Marek)
Date: Mon, 09 Jun 2014 23:50:36 +0200
Subject: [Cocci] [PATCH] coccinelle/null: solve parse error
In-Reply-To: <20140528141047.GA4059@himangi-Dell>
References: <20140528141047.GA4059@himangi-Dell>
Message-ID: <53962C2C.9030802@suse.cz>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

(added the rest of the coccinelle gang to cc)

Dne 28.5.2014 16:10, Himangi Saraogi napsal(a):
> This patch solves the parse-error by adding @@ . This is necessary since
> Coccinelle version 1.0.0-rc20. Also, the comment is added to use a
> recent version of Coccinelle.
> 
> Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
> Acked-by: Julia Lawall <julia.lawall@lip6.fr>
> ---
>  scripts/coccinelle/null/badzero.cocci | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/coccinelle/null/badzero.cocci b/scripts/coccinelle/null/badzero.cocci
> index d79baf7..5551da2 100644
> --- a/scripts/coccinelle/null/badzero.cocci
> +++ b/scripts/coccinelle/null/badzero.cocci
> @@ -10,7 +10,7 @@
>  // Copyright: (C) 2012 Julia Lawall, INRIA/LIP6.  GPLv2.
>  // Copyright: (C) 2012 Gilles Muller, INRIA/LiP6.  GPLv2.
>  // URL: http://coccinelle.lip6.fr/
> -// Comments:
> +// Comments: Requires Coccinelle version 1.0.0-rc20 or later
>  // Options:
>  
>  virtual patch
> @@ -19,6 +19,7 @@ virtual org
>  virtual report
>  
>  @initialize:ocaml@
> +@@
>  let negtable = Hashtbl.create 101
>  
>  @depends on patch@
> 
