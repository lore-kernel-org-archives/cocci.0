From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 19 May 2015 10:57:40 +0200 (CEST)
Subject: [Cocci] [PATCH v2] Add coccinelle script that makes sure that
 tables are NULL terminated
In-Reply-To: <1431948540-8202-1-git-send-email-d.granat@samsung.com>
References: <1425043313-15844-1-git-send-email-d.granat@samsung.com>
 <1431948540-8202-1-git-send-email-d.granat@samsung.com>
Message-ID: <alpine.DEB.2.10.1505191055550.2506@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

There is already a rule misc/of_table.cocci for the of_device_id case.  I
think it would be better to extend that.

Also, rather than making an identifier name, it would be more efficient to
put struct \(of_device_id \| i2c_device_id \| platform_device_id\) arr[] =
...  The Coccinelle will only work on files that contain those
identifiers.

julia

On Mon, 18 May 2015, Daniel Granat wrote:

> Signed-off-by: Daniel Granat <d.granat@samsung.com>
> ---
>  scripts/coccinelle/misc/of_platform.cocci | 65 +++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 scripts/coccinelle/misc/of_platform.cocci
>
> diff --git a/scripts/coccinelle/misc/of_platform.cocci b/scripts/coccinelle/misc/of_platform.cocci
> new file mode 100644
> index 0000000..02c6195
> --- /dev/null
> +++ b/scripts/coccinelle/misc/of_platform.cocci
> @@ -0,0 +1,65 @@
> +/// Make sure that tables are NULL terminated
> +//
> +// Keywords: _device_id
> +// Confidence: Medium
> +// Options: --include-headers
> +
> +virtual report
> +virtual patch
> +
> + at r depends on report@
> +position p1;
> +identifier var, arr;
> +identifier name = {of_device_id, i2c_device_id, platform_device_id};
> +expression E;
> +@@
> +
> +(
> +struct name arr[] = {
> +	...,
> +	{
> +	.var = E,
> +	}
> +	@p1
> +};
> +|
> +struct name arr[] = {
> +	...,
> +	{ ..., var, ... },
> +	@p1
> +};
> +)
> +
> + at script:python depends on report@
> +p1 << r.p1;
> +arr << r.arr;
> +@@
> +
> +msg = "%s is not NULL terminated at line %s" % (arr, p1[0].line)
> +coccilib.report.print_report(p1[0],msg)
> +
> + at p depends on patch@
> +position p1;
> +identifier var, arr;
> +identifier name = {of_device_id, i2c_device_id, platform_device_id};
> +expression E;
> +@@
> +
> +(
> +struct name arr[] = {
> +	...,
> +	{
> +	.var = E,
> +-	}
> +	@p1
> ++	},
> ++	{},
> +};
> +|
> +struct name arr[] = {
> +	...,
> +	{ ..., var, ... },
> +	@p1
> ++	{},
> +};
> +)
> --
> 1.9.1
>
>
