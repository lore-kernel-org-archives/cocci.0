From: rusty@rustcorp.com.au (Rusty Russell)
Date: Wed, 22 Apr 2015 16:45:04 +0930
Subject: [Cocci] [PATCH v1 4/6] moduleparam.h: add
	module_param_config_*() helpers
In-Reply-To: <1429572637-30234-5-git-send-email-mcgrof@do-not-panic.com>
References: <1429572637-30234-1-git-send-email-mcgrof@do-not-panic.com>
 <1429572637-30234-5-git-send-email-mcgrof@do-not-panic.com>
Message-ID: <87mw20ocqv.fsf@rustcorp.com.au>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

"Luis R. Rodriguez" <mcgrof@do-not-panic.com> writes:
> From: "Luis R. Rodriguez" <mcgrof@suse.com>
>
> This adds a couple of bool module_param_config_*() helpers
> which are designed to let us easily associate a booloean
> module parameter with an associated kernel configuration
> option, and to help us remove #ifdef'ery eyesores.

But they don't.  And I had to read the descriptions twice to understand
what you're doing.

eg you use it like this:

 -#ifdef CONFIG_WQ_POWER_EFFICIENT_DEFAULT
 -static bool wq_power_efficient = true;
 -#else
 -static bool wq_power_efficient;
 -#endif
 -
 -module_param_named(power_efficient, wq_power_efficient, bool, 0444);
 +module_param_config_on_off(power_efficient, wq_power_efficient, 0444,
 CONFIG_WQ_POWER_EFFICIENT_DEFAULT);

It would be much clearer to do this:

 -#ifdef CONFIG_WQ_POWER_EFFICIENT_DEFAULT
 -static bool wq_power_efficient = true;
 -#else
 -static bool wq_power_efficient;
 -#endif
 +static bool wq_power_efficient = IS_ENABLED(CONFIG_WQ_POWER_EFFICIENT_DEFAULT);

I know exactly what that does without having to notice the difference
between module_param_config_on_off() and module_param_config_on().

Cheers,
Rusty.
