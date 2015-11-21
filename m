From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 21 Nov 2015 07:48:38 +0100 (CET)
Subject: [Cocci] [PATCH 1/1] Add SPI to platform_no_drv_owner.cocci
	warnings
In-Reply-To: <1448056925-389-1-git-send-email-afd@ti.com>
References: <1448056925-389-1-git-send-email-afd@ti.com>
Message-ID: <alpine.DEB.2.02.1511210748140.2078@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 20 Nov 2015, Andrew F. Davis wrote:

> Remove .owner field if calls are used which set it automatically.
> 
> Signed-off-by: Andrew F. Davis <afd@ti.com>

Acked-by: Julia Lawall <julia.lawall@lip6.fr>

> ---
>  scripts/coccinelle/api/platform_no_drv_owner.cocci | 73 ++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
> 
> diff --git a/scripts/coccinelle/api/platform_no_drv_owner.cocci b/scripts/coccinelle/api/platform_no_drv_owner.cocci
> index c5e3f73f..52d5f53 100644
> --- a/scripts/coccinelle/api/platform_no_drv_owner.cocci
> +++ b/scripts/coccinelle/api/platform_no_drv_owner.cocci
> @@ -12,6 +12,7 @@ virtual report
>  declarer name module_i2c_driver;
>  declarer name module_platform_driver;
>  declarer name module_platform_driver_probe;
> +declarer name module_spi_driver;
>  identifier __driver;
>  @@
>  (
> @@ -20,6 +21,8 @@ identifier __driver;
>  	module_platform_driver(__driver);
>  |
>  	module_platform_driver_probe(__driver, ...);
> +|
> +	module_spi_driver(__driver);
>  )
>  
>  @fix1 depends on match1 && patch && !context && !org && !report@
> @@ -40,6 +43,15 @@ identifier match1.__driver;
>  		}
>  	};
>  
> + at fix1_spi depends on match1 && patch && !context && !org && !report@
> +identifier match1.__driver;
> +@@
> +	static struct spi_driver __driver = {
> +		.driver = {
> +-			.owner = THIS_MODULE,
> +		}
> +	};
> +
>  @match2@
>  identifier __driver;
>  @@
> @@ -51,6 +63,8 @@ identifier __driver;
>  	platform_create_bundle(&__driver, ...)
>  |
>  	i2c_add_driver(&__driver)
> +|
> +	spi_register_driver(&__driver)
>  )
>  
>  @fix2 depends on match2 && patch && !context && !org && !report@
> @@ -71,6 +85,15 @@ identifier match2.__driver;
>  		}
>  	};
>  
> + at fix2_spi depends on match2 && patch && !context && !org && !report@
> +identifier match2.__driver;
> +@@
> +	static struct spi_driver __driver = {
> +		.driver = {
> +-			.owner = THIS_MODULE,
> +		}
> +	};
> +
>  // ----------------------------------------------------------------------------
>  
>  @fix1_context depends on match1 && !patch && (context || org || report)@
> @@ -95,6 +118,17 @@ position j0;
>  		}
>  	};
>  
> + at fix1_spi_context depends on match1 && !patch && (context || org || report)@
> +identifier match1.__driver;
> +position j0;
> +@@
> +
> +	static struct spi_driver __driver = {
> +		.driver = {
> +*			.owner at j0 = THIS_MODULE,
> +		}
> +	};
> +
>  @fix2_context depends on match2 && !patch && (context || org || report)@
>  identifier match2.__driver;
>  position j0;
> @@ -117,6 +151,17 @@ position j0;
>  		}
>  	};
>  
> + at fix2_spi_context depends on match2 && !patch && (context || org || report)@
> +identifier match2.__driver;
> +position j0;
> +@@
> +
> +	static struct spi_driver __driver = {
> +		.driver = {
> +*			.owner at j0 = THIS_MODULE,
> +		}
> +	};
> +
>  // ----------------------------------------------------------------------------
>  
>  @script:python fix1_org depends on org@
> @@ -133,6 +178,13 @@ j0 << fix1_i2c_context.j0;
>  msg = "No need to set .owner here. The core will do it."
>  coccilib.org.print_todo(j0[0], msg)
>  
> + at script:python fix1_spi_org depends on org@
> +j0 << fix1_spi_context.j0;
> +@@
> +
> +msg = "No need to set .owner here. The core will do it."
> +coccilib.org.print_todo(j0[0], msg)
> +
>  @script:python fix2_org depends on org@
>  j0 << fix2_context.j0;
>  @@
> @@ -147,6 +199,13 @@ j0 << fix2_i2c_context.j0;
>  msg = "No need to set .owner here. The core will do it."
>  coccilib.org.print_todo(j0[0], msg)
>  
> + at script:python fix2_spi_org depends on org@
> +j0 << fix2_spi_context.j0;
> +@@
> +
> +msg = "No need to set .owner here. The core will do it."
> +coccilib.org.print_todo(j0[0], msg)
> +
>  // ----------------------------------------------------------------------------
>  
>  @script:python fix1_report depends on report@
> @@ -163,6 +222,13 @@ j0 << fix1_i2c_context.j0;
>  msg = "No need to set .owner here. The core will do it."
>  coccilib.report.print_report(j0[0], msg)
>  
> + at script:python fix1_spi_report depends on report@
> +j0 << fix1_spi_context.j0;
> +@@
> +
> +msg = "No need to set .owner here. The core will do it."
> +coccilib.report.print_report(j0[0], msg)
> +
>  @script:python fix2_report depends on report@
>  j0 << fix2_context.j0;
>  @@
> @@ -177,3 +243,10 @@ j0 << fix2_i2c_context.j0;
>  msg = "No need to set .owner here. The core will do it."
>  coccilib.report.print_report(j0[0], msg)
>  
> + at script:python fix2_spi_report depends on report@
> +j0 << fix2_spi_context.j0;
> +@@
> +
> +msg = "No need to set .owner here. The core will do it."
> +coccilib.report.print_report(j0[0], msg)
> +
> -- 
> 1.9.1
> 
> 
