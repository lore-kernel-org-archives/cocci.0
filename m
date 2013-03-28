From: jbarnes@virtuousgeek.org (Jesse Barnes)
Date: Thu, 28 Mar 2013 08:39:43 -0700
Subject: [Cocci] [PATCH] compat/compat-drivers/linux-next: fb
	skip_vt_switch
In-Reply-To: <1364472270-9297-1-git-send-email-mcgrof@do-not-panic.com>
References: <1364472270-9297-1-git-send-email-mcgrof@do-not-panic.com>
Message-ID: <20130328083943.01e61b4b@jbarnes-desktop>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 28 Mar 2013 05:04:26 -0700
"Luis R. Rodriguez" <mcgrof@do-not-panic.com> wrote:

> The new commit by Jesse that extended the fb_info with a skip_vt_switch
> element is the simplest example of a data structure expansion. We'd backport
> this by adding a static inline to compat so that new kernels muck with the
> new element and for older kernels this would be a no-op. This reduces the
> size of the backport and unclutters the required patch with #idefs, and
> insteads leaves only a replacement of the usage of the new elements with
> a static inline, this however would still be required on our end:
> 
> 	-      info->skip_vt_switch = true;
> 	+      fb_enable_skip_vt_switch(info);
> 
> So we'd then have to just add this static inline change for each new driver...
> There may be a way to get SmPL to do this for us...

Yeah I'm not attached to the direct structure reference; a couple of
inlines are just as easy to read.  So no argument from me.

Thanks,
-- 
Jesse Barnes, Intel Open Source Technology Center
