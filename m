From: tj@kernel.org (Tejun Heo)
Date: Tue, 21 Apr 2015 16:58:57 -0400
Subject: [Cocci] [PATCH v1 4/6] moduleparam.h: add
	module_param_config_*() helpers
In-Reply-To: <20150421165516.GL5622@wotan.suse.de>
References: <1429572637-30234-1-git-send-email-mcgrof@do-not-panic.com>
 <1429572637-30234-5-git-send-email-mcgrof@do-not-panic.com>
 <20150421152136.GC9455@htj.duckdns.org>
 <20150421165516.GL5622@wotan.suse.de>
Message-ID: <20150421205857.GG9455@htj.duckdns.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello, Luis.

On Tue, Apr 21, 2015 at 06:55:16PM +0200, Luis R. Rodriguez wrote:
> A use then would be for instance:
> 
> module_param_config_on_off(power_efficient, wq_power_efficient, 0444,
> 			   IS_ENABLED(CONFIG_WQ_POWER_EFFICIENT_DEFAULT));
> 
> this as an alternative would enable use of other static / global variables but
> I'm not sure if these are good use cases to promote, given that all this is to
> help with initial set up, so I believe the restrictions are for the better.

I was thinking more of cases where CONFIG should be inverted or
and/or'd.  In general I don't think we conventionally embed
IS_ENABLED() in this sort of macros.  It just jumps at me as a weird
restriction.  What do others think?

Thanks.

-- 
tejun
