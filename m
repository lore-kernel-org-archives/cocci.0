From: tj@kernel.org (Tejun Heo)
Date: Tue, 21 Apr 2015 11:21:36 -0400
Subject: [Cocci] [PATCH v1 4/6] moduleparam.h: add
	module_param_config_*() helpers
In-Reply-To: <1429572637-30234-5-git-send-email-mcgrof@do-not-panic.com>
References: <1429572637-30234-1-git-send-email-mcgrof@do-not-panic.com>
 <1429572637-30234-5-git-send-email-mcgrof@do-not-panic.com>
Message-ID: <20150421152136.GC9455@htj.duckdns.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, Apr 20, 2015 at 04:30:35PM -0700, Luis R. Rodriguez wrote:
>  /**
> + * module_param_config_on_off - bool parameter with run time override
> + * @name: a valid C identifier which is the parameter name.
> + * @value: the actual lvalue to alter.
> + * @perm: visibility in sysfs.
> + * @config: kernel parameter which will enable this option if this
> + * 	kernel configuration option has been enabled.
> + *
> + * This lets you define a bool module paramter which by default will be
> + * set to true if the config option has been set on your kernel's
> + * configuration, otherwise it is set to false.
> + */
> +#define module_param_config_on_off(name, var, perm, config) 		\
> +	static bool var = IS_ENABLED(config);				\
> +	module_param_named(name, var, bool, perm);

Maybe we want to make @config just a boolean initializer?
e.g. something like

#define module_param_config_on_off(name, var, perm, on_off) 		\
	static bool var = on_off;					\
	module_param_named(name, var, bool, perm);

so that the caller does IS_ENABLED() or whatever that's necessary?  It
just seems a bit too restricted.

Thanks.

-- 
tejun
