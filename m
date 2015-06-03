From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 3 Jun 2015 11:42:11 +0200 (CEST)
Subject: [Cocci] [PATCH v4] Added tables i2c_device_id and
 platform_device_id for checking. Extend checking on tables containing
 structures which are initialized without specifying member name.
In-Reply-To: <1433261452-27874-2-git-send-email-d.granat@samsung.com>
References: <1432036729-20809-1-git-send-email-d.granat@samsung.com>
 <1433261452-27874-1-git-send-email-d.granat@samsung.com>
 <1433261452-27874-2-git-send-email-d.granat@samsung.com>
Message-ID: <alpine.DEB.2.10.1506031140360.2386@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 2 Jun 2015, Daniel Granat wrote:

> Signed-off-by: Daniel Granat <d.granat@samsung.com>
> ---
>  scripts/coccinelle/misc/of_table.cocci | 34 +++++++++++++++++++++++++++++-----
>  1 file changed, 29 insertions(+), 5 deletions(-)
>
> diff --git a/scripts/coccinelle/misc/of_table.cocci b/scripts/coccinelle/misc/of_table.cocci
> index 3c93404..bc3c944 100644
> --- a/scripts/coccinelle/misc/of_table.cocci
> +++ b/scripts/coccinelle/misc/of_table.cocci
> @@ -1,6 +1,6 @@
> -/// Make sure of_device_id tables are NULL terminated
> +/// Make sure (of_device_id | i2c_device_id | platform_device_id) tables are NULL terminated

It would be nice for the comment to be limited to 80 characters.

>  //
> -// Keywords: of_table
> +// Keywords: of_table i2c_table platform_table
>  // Confidence: Medium
>  // Options: --include-headers
>
> @@ -13,18 +13,27 @@ virtual report
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
> +	{ ..., E, ... },
> +*	{ },

This should be:

struct \(of_device_id \| i2c_device_id \| platform_device_id\) arr[] = {
        ...,
*       { ..., E, ... },
};

With that you get four results for the context case, like for the others.

The rest looks OK.

julia

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
> @@ -32,19 +41,34 @@ struct of_device_id arr[] = {
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
