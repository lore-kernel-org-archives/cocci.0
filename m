From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 23 Oct 2015 21:35:57 +0200 (CEST)
Subject: [Cocci] [PATCH v6] coccinelle: Improve checking for missing
 NULL terminators
In-Reply-To: <1445614266-14609-1-git-send-email-d.granat@samsung.com>
References: <1425043313-15844-1-git-send-email-d.granat@samsung.com>
 <1445614266-14609-1-git-send-email-d.granat@samsung.com>
Message-ID: <alpine.DEB.2.02.1510232135430.2052@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Acked-by: Julia Lawall <julia.lawall@lip6.fr>

On Fri, 23 Oct 2015, Daniel Granat wrote:

> * Extend checking on tables containing structures which are
>   initialized without specifying member name. Added new tables
>   for checking: i2c_device_id and platform_device_id.
> 
> Signed-off-by: Daniel Granat <d.granat@samsung.com>
> ---
>  scripts/coccinelle/misc/of_table.cocci | 33 ++++++++++++++++++++++++++++-----
>  1 file changed, 28 insertions(+), 5 deletions(-)
> 
> diff --git a/scripts/coccinelle/misc/of_table.cocci b/scripts/coccinelle/misc/of_table.cocci
> index 3c93404..2294915 100644
> --- a/scripts/coccinelle/misc/of_table.cocci
> +++ b/scripts/coccinelle/misc/of_table.cocci
> @@ -1,6 +1,6 @@
> -/// Make sure of_device_id tables are NULL terminated
> +/// Make sure (of/i2c/platform)_device_id tables are NULL terminated
>  //
> -// Keywords: of_table
> +// Keywords: of_table i2c_table platform_table
>  // Confidence: Medium
>  // Options: --include-headers
>  
> @@ -13,18 +13,26 @@ virtual report
>  identifier var, arr;
>  expression E;
>  @@
> -struct of_device_id arr[] = {
> +(
> +struct \(of_device_id \| i2c_device_id \| platform_device_id\) arr[] = {
>  	...,
>  	{
>  	.var = E,
>  *	}
>  };
> +|
> +struct \(of_device_id \| i2c_device_id \| platform_device_id\) arr[] = {
> +	...,
> +*	{ ..., E, ... },
> +};
> +)
>  
>  @depends on patch@
>  identifier var, arr;
>  expression E;
>  @@
> -struct of_device_id arr[] = {
> +(
> +struct \(of_device_id \| i2c_device_id \| platform_device_id\) arr[] = {
>  	...,
>  	{
>  	.var = E,
> @@ -32,19 +40,34 @@ struct of_device_id arr[] = {
>  +	},
>  +	{ }
>  };
> +|
> +struct \(of_device_id \| i2c_device_id \| platform_device_id\) arr[] = {
> +	...,
> +	{ ..., E, ... },
> ++	{ },
> +};
> +)
>  
>  @r depends on org || report@
>  position p1;
>  identifier var, arr;
>  expression E;
>  @@
> -struct of_device_id arr[] = {
> +(
> +struct \(of_device_id \| i2c_device_id \| platform_device_id\) arr[] = {
>  	...,
>  	{
>  	.var = E,
>  	}
>  	@p1
>  };
> +|
> +struct \(of_device_id \| i2c_device_id \| platform_device_id\) arr[] = {
> +	...,
> +	{ ..., E, ... }
> +	@p1
> +};
> +)
>  
>  @script:python depends on org@
>  p1 << r.p1;
> -- 
> 1.9.1
> 
> 
