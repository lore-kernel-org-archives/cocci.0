From: mcgrof@suse.com (Luis R. Rodriguez)
Date: Tue, 21 Apr 2015 18:55:16 +0200
Subject: [Cocci] [PATCH v1 4/6] moduleparam.h: add
	module_param_config_*() helpers
In-Reply-To: <20150421152136.GC9455@htj.duckdns.org>
References: <1429572637-30234-1-git-send-email-mcgrof@do-not-panic.com>
 <1429572637-30234-5-git-send-email-mcgrof@do-not-panic.com>
 <20150421152136.GC9455@htj.duckdns.org>
Message-ID: <20150421165516.GL5622@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, Apr 21, 2015 at 11:21:36AM -0400, Tejun Heo wrote:
> On Mon, Apr 20, 2015 at 04:30:35PM -0700, Luis R. Rodriguez wrote:
> >  /**
> > + * module_param_config_on_off - bool parameter with run time override
> > + * @name: a valid C identifier which is the parameter name.
> > + * @value: the actual lvalue to alter.
> > + * @perm: visibility in sysfs.
> > + * @config: kernel parameter which will enable this option if this
> > + * 	kernel configuration option has been enabled.
> > + *
> > + * This lets you define a bool module paramter which by default will be
> > + * set to true if the config option has been set on your kernel's
> > + * configuration, otherwise it is set to false.
> > + */
> > +#define module_param_config_on_off(name, var, perm, config) 		\
> > +	static bool var = IS_ENABLED(config);				\
> > +	module_param_named(name, var, bool, perm);
> 
> Maybe we want to make @config just a boolean initializer?
> e.g. something like
> 
> #define module_param_config_on_off(name, var, perm, on_off) 		\
> 	static bool var = on_off;					\
> 	module_param_named(name, var, bool, perm);
> 
> so that the caller does IS_ENABLED() or whatever that's necessary?  It
> just seems a bit too restricted.

A use then would be for instance:

module_param_config_on_off(power_efficient, wq_power_efficient, 0444,
			   IS_ENABLED(CONFIG_WQ_POWER_EFFICIENT_DEFAULT));

this as an alternative would enable use of other static / global variables but
I'm not sure if these are good use cases to promote, given that all this is to
help with initial set up, so I believe the restrictions are for the better.

Let me know, we already have early_param_on_off() relying on @config so
we should consider both and/or address early_param_on_off() as well
while at it.

 Luis
