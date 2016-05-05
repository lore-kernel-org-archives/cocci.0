From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 5 May 2016 22:10:04 +0200 (CEST)
Subject: [Cocci] [PATCH] Coccinelle: noderef: Add a rule and correct the
 old rule
In-Reply-To: <1461757289-21035-1-git-send-email-vaishali.thakkar@oracle.com>
References: <1461757289-21035-1-git-send-email-vaishali.thakkar@oracle.com>
Message-ID: <alpine.DEB.2.02.1605052209460.2215@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 27 Apr 2016, Vaishali Thakkar wrote:

> Add a new rule to detect the cases where sizeof is used as a
> subexpression rather than a top level argument.
> 
> Also, for the patch mode third rule should behave same as
> second rule with arguments reversed. So, change that as well.
> 
> Signed-off-by: Vaishali Thakkar <vaishali.thakkar@oracle.com>
> ---
>  scripts/coccinelle/misc/noderef.cocci | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/coccinelle/misc/noderef.cocci b/scripts/coccinelle/misc/noderef.cocci
> index 80a831c..9991ee9 100644
> --- a/scripts/coccinelle/misc/noderef.cocci
> +++ b/scripts/coccinelle/misc/noderef.cocci
> @@ -16,6 +16,7 @@ virtual patch
>  @depends on patch@
>  expression *x;
>  expression f;
> +identifier i;

I think that i could be an expression in both cases?

julia

>  type T;
>  @@
>  
> @@ -30,7 +31,12 @@ f(...,(T)(x),...,sizeof(
>  + *x
>     ),...)
>  |
> -f(...,sizeof(x),...,(T)(
> +f(...,sizeof(
> +- x
> ++ *x
> +   ),...,(T)(x),...)
> +|
> +x = f(...,i*sizeof(
>  - x
>  + *x
>     ),...)
> @@ -39,6 +45,7 @@ f(...,sizeof(x),...,(T)(
>  @r depends on !patch@
>  expression *x;
>  expression f;
> +identifier i;
>  position p;
>  type T;
>  @@
> @@ -49,6 +56,8 @@ type T;
>  *f(...,(T)(x),...,sizeof at p(x),...)
>  |
>  *f(...,sizeof at p(x),...,(T)(x),...)
> +|
> +*x = f(...,i*sizeof at p(x),...)
>  )
>  
>  @script:python depends on org@
> -- 
> 2.1.4
> 
> 
