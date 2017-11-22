From: joe@perches.com (Joe Perches)
Date: Wed, 22 Nov 2017 09:05:36 -0800
Subject: [Cocci] [PATCH] net: usb: hso.c: remove unneeded DRIVER_LICENSE
	#define
In-Reply-To: <20171117141939.GD17880@kroah.com>
References: <20171117141939.GD17880@kroah.com>
Message-ID: <1511370336.6989.100.camel@perches.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, 2017-11-17 at 15:19 +0100, Greg Kroah-Hartman wrote:
> There is no need to #define the license of the driver, just put it in
> the MODULE_LICENSE() line directly as a text string.
> 
> This allows tools that check that the module license matches the source
> code license to work properly, as there is no need to unwind the
> unneeded dereference.
[]
> diff --git a/drivers/net/usb/hso.c b/drivers/net/usb/hso.c
[]
> @@ -76,7 +76,6 @@
>  
>  #define MOD_AUTHOR			"Option Wireless"
>  #define MOD_DESCRIPTION			"USB High Speed Option driver"
> -#define MOD_LICENSE			"GPL"
>  
>  #define HSO_MAX_NET_DEVICES		10
>  #define HSO__MAX_MTU			2048
> @@ -3288,7 +3287,7 @@ module_exit(hso_exit);
>  
>  MODULE_AUTHOR(MOD_AUTHOR);
>  MODULE_DESCRIPTION(MOD_DESCRIPTION);
> -MODULE_LICENSE(MOD_LICENSE);
> +MODULE_LICENSE("GPL");

Probably all of these MODULE_<FOO>(MOD_<BAR>) uses could be
simplified as well.

Perhaps there's utility in a (cocci?) script that looks for
used-once
macro #defines in various types of macros.
