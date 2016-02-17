From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 17 Feb 2016 09:51:11 -0500 (EST)
Subject: [Cocci] keeping cast affects match?
In-Reply-To: <20160217144548.GA1769@katana>
References: <20160217144548.GA1769@katana>
Message-ID: <alpine.DEB.2.10.1602170949460.4547@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 17 Feb 2016, Wolfram Sang wrote:

> Hi,
>
> using Coccinelle v1.04 from Debian:
>
> $ spatch -version
> spatch version 1.0.4 with Python support and with PCRE support
>
> The following semantic patch produces a match with current linux-next:
>
> @@
> expression table, dev;
> type T;
> @@
> -	(T)of_match_device(table, dev)->data
> +	of_device_get_match_data(dev)
>
>
> $ spatch -sp_file minimal.cocci drivers/gpu/drm/rcar-du/
> ...
> HANDLING: drivers/gpu/drm/rcar-du/rcar_du_drv.c
> diff =
> diff -u -p a/rcar_du_drv.c b/rcar_du_drv.c
> --- a/rcar_du_drv.c
> +++ b/rcar_du_drv.c
> @@ -183,7 +183,7 @@ static int rcar_du_load(struct drm_devic
>  	init_waitqueue_head(&rcdu->commit.wait);
>
>  	rcdu->dev = &pdev->dev;
> -	rcdu->info = of_match_device(rcar_du_of_table, rcdu->dev)->data;
> +	rcdu->info = of_device_get_match_data(rcdu->dev);
>  	rcdu->ddev = dev;
>  	dev->dev_private = rcdu;
>
> However, the match goes away when I want to keep a potential cast (T) which I
> need in other places:
>
> @@
> expression table, dev;
> type T;
> @@
> -	(T)of_match_device(table, dev)->data
> +	(T)of_device_get_match_data(dev)
>
> I wonder why adding (T) to "+" affects the matching. Is this a bug or do I miss
> something?

The isomorphism that allows ignoring a cast only works when the type
metavariable is used only once.  You uare using it twice.  The fact that
you wanted to add it indicates that you really want it to be there.

I think that everything should be fine if you just move the (T) out of the
removed and added code.

julia
