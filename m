From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 29 Aug 2015 18:18:20 +0200 (CEST)
Subject: [Cocci] [RFC] firmware: annotate thou shalt not request fw on
 init or probe
In-Reply-To: <1440811107-861-1-git-send-email-mcgrof@do-not-panic.com>
References: <1440811107-861-1-git-send-email-mcgrof@do-not-panic.com>
Message-ID: <alpine.DEB.2.02.1508291812350.2057@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> +@ defines_module_init exists @
> +declarer name module_init;
> +identifier init;
> +@@
> +
> +module_init(init);
> +
> +@ has_probe depends on defines_module_init @
> +identifier drv_calls, drv_probe;
> +type bus_driver;
> +identifier probe_op =~ "(probe)";
> +@@
> +
> +bus_driver drv_calls = {
> +	.probe_op = drv_probe,
> +};

I'm not sure that this is enough.  For example, there is the macro
platform_driver_probe that initializes probe fields.  There is likewise
module_platform_driver, which is a top-level declaration that encapsulates
the module_init and the definition of the module_init function, which in
turn calls platform_driver_probe.  There is also module_platform_driver,
which encapsulates the module_init, but not the initialization of the probe
field.  Are you concerned with any of these cases?

julia
