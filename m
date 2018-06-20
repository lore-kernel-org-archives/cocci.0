From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Wed, 20 Jun 2018 13:22:49 +0300
Subject: [Cocci] [PATCH] staging: rtl8723bs: Fix two possible
 sleep-in-atomic-context bugs in translate_scan()
In-Reply-To: <dd6eaaad-413e-bd5d-d0f4-0a6d05438395@gmail.com>
References: <20180620095016.8484-1-baijiaju1990@gmail.com>
 <20180620095650.fga6xi7fyjgybs76@mwanda>
 <dd6eaaad-413e-bd5d-d0f4-0a6d05438395@gmail.com>
Message-ID: <20180620102249.djwmdv34zp5vyj2h@mwanda>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Jun 20, 2018 at 06:05:06PM +0800, Jia-Ju Bai wrote:
> > Thanks!  It occurs to me that another way to detect this bug is that
> > one of the allocations in this function already uses GFP_ATOMIC.  It
> > doesn't normally make sense to mix GFP_ATOMIC and GFP_KERNEL when there
> > isn't any locking in the function.
> 
> Yes, this pattern is interesting for bug finding :)
> But to fix the bugs of this pattern, we need to decide whether GFP_ATOMIC or
> GFP_KERNEL should be used here.
> 

Sure.  But either way it's a bug. Plus this would be the first static
checker warning which warns about using GFP_ATOMIC when it's supposed to
be GFP_KERNEL.  #milestone

regards,
dan carpenter
