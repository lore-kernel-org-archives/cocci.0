From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 10 Jul 2015 09:01:40 -0400 (EDT)
Subject: [Cocci] [PATCH] coccinelle: api: extend spatch for dropping
 unnecessary owner
In-Reply-To: <1436503986-21487-1-git-send-email-k.kozlowski@samsung.com>
References: <1436503986-21487-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <alpine.DEB.2.10.1507100901030.2559@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Acked-by: Julia Lawall <Julia.Lawall@lip6.fr>

As a semantic patch, it looks fine.  Have you sent any patches based on
it?  I find hundreds of occurrences.

julia

On Fri, 10 Jul 2015, Krzysztof Kozlowski wrote:

> i2c_add_driver (through i2c_register_driver) sets the owner field so we
> can drop it also from i2c drivers, just like from platform drivers.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  scripts/coccinelle/api/platform_no_drv_owner.cocci | 73 ++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>
> diff --git a/scripts/coccinelle/api/platform_no_drv_owner.cocci b/scripts/coccinelle/api/platform_no_drv_owner.cocci
> index e065b9e714fc..c5e3f73f2054 100644
> --- a/scripts/coccinelle/api/platform_no_drv_owner.cocci
> +++ b/scripts/coccinelle/api/platform_no_drv_owner.cocci
> @@ -9,11 +9,14 @@ virtual org
>  virtual report
>
>  @match1@
> +declarer name module_i2c_driver;
>  declarer name module_platform_driver;
>  declarer name module_platform_driver_probe;
>  identifier __driver;
>  @@
>  (
> +	module_i2c_driver(__driver);
> +|
>  	module_platform_driver(__driver);
>  |
>  	module_platform_driver_probe(__driver, ...);
> @@ -28,6 +31,15 @@ identifier match1.__driver;
>  		}
>  	};
>
> + at fix1_i2c depends on match1 && patch && !context && !org && !report@
> +identifier match1.__driver;
> +@@
> +	static struct i2c_driver __driver = {
> +		.driver = {
> +-			.owner = THIS_MODULE,
> +		}
> +	};
> +
>  @match2@
>  identifier __driver;
>  @@
> @@ -37,6 +49,8 @@ identifier __driver;
>  	platform_driver_probe(&__driver, ...)
>  |
>  	platform_create_bundle(&__driver, ...)
> +|
> +	i2c_add_driver(&__driver)
>  )
>
>  @fix2 depends on match2 && patch && !context && !org && !report@
> @@ -48,6 +62,15 @@ identifier match2.__driver;
>  		}
>  	};
>
> + at fix2_i2c depends on match2 && patch && !context && !org && !report@
> +identifier match2.__driver;
> +@@
> +	static struct i2c_driver __driver = {
> +		.driver = {
> +-			.owner = THIS_MODULE,
> +		}
> +	};
> +
>  // ----------------------------------------------------------------------------
>
>  @fix1_context depends on match1 && !patch && (context || org || report)@
> @@ -61,6 +84,17 @@ position j0;
>  		}
>  	};
>
> + at fix1_i2c_context depends on match1 && !patch && (context || org || report)@
> +identifier match1.__driver;
> +position j0;
> +@@
> +
> +	static struct i2c_driver __driver = {
> +		.driver = {
> +*			.owner at j0 = THIS_MODULE,
> +		}
> +	};
> +
>  @fix2_context depends on match2 && !patch && (context || org || report)@
>  identifier match2.__driver;
>  position j0;
> @@ -72,6 +106,17 @@ position j0;
>  		}
>  	};
>
> + at fix2_i2c_context depends on match2 && !patch && (context || org || report)@
> +identifier match2.__driver;
> +position j0;
> +@@
> +
> +	static struct i2c_driver __driver = {
> +		.driver = {
> +*			.owner at j0 = THIS_MODULE,
> +		}
> +	};
> +
>  // ----------------------------------------------------------------------------
>
>  @script:python fix1_org depends on org@
> @@ -81,6 +126,13 @@ j0 << fix1_context.j0;
>  msg = "No need to set .owner here. The core will do it."
>  coccilib.org.print_todo(j0[0], msg)
>
> + at script:python fix1_i2c_org depends on org@
> +j0 << fix1_i2c_context.j0;
> +@@
> +
> +msg = "No need to set .owner here. The core will do it."
> +coccilib.org.print_todo(j0[0], msg)
> +
>  @script:python fix2_org depends on org@
>  j0 << fix2_context.j0;
>  @@
> @@ -88,6 +140,13 @@ j0 << fix2_context.j0;
>  msg = "No need to set .owner here. The core will do it."
>  coccilib.org.print_todo(j0[0], msg)
>
> + at script:python fix2_i2c_org depends on org@
> +j0 << fix2_i2c_context.j0;
> +@@
> +
> +msg = "No need to set .owner here. The core will do it."
> +coccilib.org.print_todo(j0[0], msg)
> +
>  // ----------------------------------------------------------------------------
>
>  @script:python fix1_report depends on report@
> @@ -97,6 +156,13 @@ j0 << fix1_context.j0;
>  msg = "No need to set .owner here. The core will do it."
>  coccilib.report.print_report(j0[0], msg)
>
> + at script:python fix1_i2c_report depends on report@
> +j0 << fix1_i2c_context.j0;
> +@@
> +
> +msg = "No need to set .owner here. The core will do it."
> +coccilib.report.print_report(j0[0], msg)
> +
>  @script:python fix2_report depends on report@
>  j0 << fix2_context.j0;
>  @@
> @@ -104,3 +170,10 @@ j0 << fix2_context.j0;
>  msg = "No need to set .owner here. The core will do it."
>  coccilib.report.print_report(j0[0], msg)
>
> + at script:python fix2_i2c_report depends on report@
> +j0 << fix2_i2c_context.j0;
> +@@
> +
> +msg = "No need to set .owner here. The core will do it."
> +coccilib.report.print_report(j0[0], msg)
> +
> --
> 1.9.1
>
>
