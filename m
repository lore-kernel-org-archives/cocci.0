From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 25 May 2015 22:19:18 +0200 (CEST)
Subject: [Cocci] [PATCH v3] Added tables i2c_device_id and
 platform_device_id for checking. Extend checking on tables containing
 structures which are initialized without specifying member name.
In-Reply-To: <1432036729-20809-1-git-send-email-d.granat@samsung.com>
References: <1425043313-15844-1-git-send-email-d.granat@samsung.com>
 <1432036729-20809-1-git-send-email-d.granat@samsung.com>
Message-ID: <alpine.DEB.2.02.1505252216120.2083@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 19 May 2015, Daniel Granat wrote:

> Signed-off-by: Daniel Granat <d.granat@samsung.com>
> ---
>  scripts/coccinelle/misc/of_table.cocci | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/scripts/coccinelle/misc/of_table.cocci b/scripts/coccinelle/misc/of_table.cocci
> index 3c93404..74f7dbb 100644
> --- a/scripts/coccinelle/misc/of_table.cocci
> +++ b/scripts/coccinelle/misc/of_table.cocci
> @@ -1,6 +1,6 @@
> -/// Make sure of_device_id tables are NULL terminated
> +/// Make sure (of_device_id | i2c_device_id | platform_device_id) tables are NULL terminated
>  //
> -// Keywords: of_table
> +// Keywords: of_table i2c_table platform_table
>  // Confidence: Medium
>  // Options: --include-headers
>  
> @@ -13,7 +13,7 @@ virtual report
>  identifier var, arr;
>  expression E;
>  @@
> -struct of_device_id arr[] = {
> +struct \(of_device_id \| i2c_device_id \| platform_device_id\) arr[] = {
>  	...,
>  	{
>  	.var = E,

This case (the context case) needs a ..., E, ... case like the patch rule 
has.


> @@ -24,7 +24,8 @@ struct of_device_id arr[] = {
>  identifier var, arr;
>  expression E;
>  @@
> -struct of_device_id arr[] = {
> +(
> +struct \(of_device_id \| i2c_device_id \| platform_device_id\) arr[] = {
>  	...,
>  	{
>  	.var = E,
> @@ -32,19 +33,34 @@ struct of_device_id arr[] = {
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
> +	{ ..., E, ... },
> +	@p1

It is not a good idea to put the @p1 on the comma.  The comma might not be 
there, and if it is not there Coccinelle seems to crash.  A more graceful 
behavior would be for the rule simply not to match, since a comma that 
isn't there doesn't have a position.  In any case, if you put the @p1 on 
the }, things are better.

I made the following test case, if you want to make a quick check of the 
rule.  All four options should give four results.

 static const struct platform_device_id ab85xx_rtc_ids[] = {
	{ "ab8500-rtc", (kernel_ulong_t)&ab8500_rtc_ops, },
	{ "ab8540-rtc", (kernel_ulong_t)&ab8540_rtc_ops, },
 };
 static const struct platform_device_id ab85xx_rtc_ids[] = {
	{ "ab8500-rtc", (kernel_ulong_t)&ab8500_rtc_ops, },
        { "ab8540-rtc", (kernel_ulong_t)&ab8540_rtc_ops, }
 };
 static const struct platform_device_id ab85xx_rtc_ids[] = {
	{ .a = "ab8500-rtc", .b = (kernel_ulong_t)&ab8500_rtc_ops, },
	{ .a = "ab8540-rtc", .b = (kernel_ulong_t)&ab8540_rtc_ops, },
 };
 static const struct platform_device_id ab85xx_rtc_ids[] = {
	{ .a = "ab8500-rtc", .b = (kernel_ulong_t)&ab8500_rtc_ops, },
        { .a = "ab8540-rtc", .b = (kernel_ulong_t)&ab8540_rtc_ops, }
 };

julia

> +};
> +)
>  
>  @script:python depends on org@
>  p1 << r.p1;
> -- 
> 1.9.1
> 
> 
