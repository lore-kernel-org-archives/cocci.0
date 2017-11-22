From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 22 Nov 2017 18:21:34 +0100 (CET)
Subject: [Cocci] [Outreachy kernel] Re: [PATCH] net: usb: hso.c: remove
 unneeded DRIVER_LICENSE #define
In-Reply-To: <1511370336.6989.100.camel@perches.com>
References: <20171117141939.GD17880@kroah.com>
 <1511370336.6989.100.camel@perches.com>
Message-ID: <alpine.DEB.2.20.1711221820260.3553@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 22 Nov 2017, Joe Perches wrote:

> On Fri, 2017-11-17 at 15:19 +0100, Greg Kroah-Hartman wrote:
> > There is no need to #define the license of the driver, just put it in
> > the MODULE_LICENSE() line directly as a text string.
> >
> > This allows tools that check that the module license matches the source
> > code license to work properly, as there is no need to unwind the
> > unneeded dereference.
> []
> > diff --git a/drivers/net/usb/hso.c b/drivers/net/usb/hso.c
> []
> > @@ -76,7 +76,6 @@
> >
> >  #define MOD_AUTHOR			"Option Wireless"
> >  #define MOD_DESCRIPTION			"USB High Speed Option driver"
> > -#define MOD_LICENSE			"GPL"
> >
> >  #define HSO_MAX_NET_DEVICES		10
> >  #define HSO__MAX_MTU			2048
> > @@ -3288,7 +3287,7 @@ module_exit(hso_exit);
> >
> >  MODULE_AUTHOR(MOD_AUTHOR);
> >  MODULE_DESCRIPTION(MOD_DESCRIPTION);
> > -MODULE_LICENSE(MOD_LICENSE);
> > +MODULE_LICENSE("GPL");
>
> Probably all of these MODULE_<FOO>(MOD_<BAR>) uses could be
> simplified as well.
>
> Perhaps there's utility in a (cocci?) script that looks for
> used-once
> macro #defines in various types of macros.

It could be possible.  It's a bit tricky due to ifdefs that Coccinelle
doesn't see and header files, but perhaps in special cases like this there
is not much worry.

julia

>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe at googlegroups.com.
> To post to this group, send email to outreachy-kernel at googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/1511370336.6989.100.camel%40perches.com.
> For more options, visit https://groups.google.com/d/optout.
>
