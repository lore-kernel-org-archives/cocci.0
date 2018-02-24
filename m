From: mcgrof@kernel.org (Luis R. Rodriguez)
Date: Sat, 24 Feb 2018 02:59:41 +0000
Subject: [Cocci] [PATCH] lib/test_kmod: Fix an integer overflow test
In-Reply-To: <20180122102754.GD23912@mwanda>
References: <20180122102754.GD23912@mwanda>
Message-ID: <20180224025941.GB14069@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, Jan 22, 2018 at 01:27:54PM +0300, Dan Carpenter wrote:
> The main problem is that the parentheses are in the wrong place and the
> unlikely() call returns either 0 or 1 so it's never less than zero.

Doh, thanks, yes. Seems worth considering a grammar rule for it.

> The other problem is that signed integer overflows like "INT_MAX + 1" are
> undefined behavior.

Likewise.

This seems like another possible generic typo issue. But I would not resolve it
the way you did, in this particular case below num_test_devs represents the
number of already registered devs, before we increment. So the way to resolve
this would be:

	if (num_test_devs + 1 == INT_MAX)

I'll get this upstream, thanks!

  Luis

> Fixes: d9c6a72d6fa2 ("kmod: add test driver to stress test the module loader")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/lib/test_kmod.c b/lib/test_kmod.c
> index e372b97eee13..30fd6d9e5361 100644
> --- a/lib/test_kmod.c
> +++ b/lib/test_kmod.c
> @@ -1141,7 +1141,7 @@ static struct kmod_test_device *register_test_dev_kmod(void)
>  	mutex_lock(&reg_dev_mutex);
>  
>  	/* int should suffice for number of devices, test for wrap */
> -	if (unlikely(num_test_devs + 1) < 0) {
> +	if (num_test_devs == INT_MAX) {
>  		pr_err("reached limit of number of test devices\n");
>  		goto out;
>  	}
> 

-- 
Luis Rodriguez, SUSE LINUX GmbH
Maxfeldstrasse 5; D-90409 Nuernberg
