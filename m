From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 23 Jun 2015 14:25:38 +0200 (CEST)
Subject: [Cocci] [PATCH v5] Added tables (i2c/platform)_device_id for
 checking. Extend checking on tables containing structures which are
 initialized without specifying member name.
In-Reply-To: <1435057334-5751-1-git-send-email-d.granat@samsung.com>
References: <alpine.DEB.2.10.1506031140360.2386@hadrien>
 <1435057334-5751-1-git-send-email-d.granat@samsung.com>
Message-ID: <alpine.DEB.2.10.1506231425150.2554@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 23 Jun 2015, Daniel Granat wrote:

> Signed-off-by: Daniel Granat <d.granat@samsung.com>

Acked-by: Julia Lawall <julia.lawall@lip6.fr>

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
