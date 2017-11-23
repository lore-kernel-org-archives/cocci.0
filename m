From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 23 Nov 2017 07:22:28 +0100
Subject: [Cocci] [Outreachy kernel] Re: [PATCH] net: usb: hso.c: remove
 unneeded DRIVER_LICENSE #define
In-Reply-To: <alpine.DEB.2.20.1711222220100.19477@hadrien>
References: <20171117141939.GD17880@kroah.com>
 <1511370336.6989.100.camel@perches.com>
 <alpine.DEB.2.20.1711222220100.19477@hadrien>
Message-ID: <20171123062228.GB25861@kroah.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Nov 22, 2017 at 10:20:49PM +0100, Julia Lawall wrote:
> 
> 
> On Wed, 22 Nov 2017, Joe Perches wrote:
> 
> > On Fri, 2017-11-17 at 15:19 +0100, Greg Kroah-Hartman wrote:
> > > There is no need to #define the license of the driver, just put it in
> > > the MODULE_LICENSE() line directly as a text string.
> > >
> > > This allows tools that check that the module license matches the source
> > > code license to work properly, as there is no need to unwind the
> > > unneeded dereference.
> > []
> > > diff --git a/drivers/net/usb/hso.c b/drivers/net/usb/hso.c
> > []
> > > @@ -76,7 +76,6 @@
> > >
> > >  #define MOD_AUTHOR			"Option Wireless"
> > >  #define MOD_DESCRIPTION			"USB High Speed Option driver"
> > > -#define MOD_LICENSE			"GPL"
> > >
> > >  #define HSO_MAX_NET_DEVICES		10
> > >  #define HSO__MAX_MTU			2048
> > > @@ -3288,7 +3287,7 @@ module_exit(hso_exit);
> > >
> > >  MODULE_AUTHOR(MOD_AUTHOR);
> > >  MODULE_DESCRIPTION(MOD_DESCRIPTION);
> > > -MODULE_LICENSE(MOD_LICENSE);
> > > +MODULE_LICENSE("GPL");
> >
> > Probably all of these MODULE_<FOO>(MOD_<BAR>) uses could be
> > simplified as well.
> >
> > Perhaps there's utility in a (cocci?) script that looks for
> > used-once
> > macro #defines in various types of macros.
> 
> What about module_version, eg:
> 
> diff -u -p a/drivers/ata/pata_pdc202xx_old.c
> b/drivers/ata/pata_pdc202xx_old.c
> --- a/drivers/ata/pata_pdc202xx_old.c
> +++ b/drivers/ata/pata_pdc202xx_old.c
> @@ -21,7 +21,6 @@
>  #include <linux/libata.h>
> 
>  #define DRV_NAME "pata_pdc202xx_old"
> -#define DRV_VERSION "0.4.3"
> 
>  static int pdc2026x_cable_detect(struct ata_port *ap)
>  {
> @@ -389,4 +388,4 @@ MODULE_AUTHOR("Alan Cox");
>  MODULE_DESCRIPTION("low-level driver for Promise 2024x and 20262-20267");
>  MODULE_LICENSE("GPL");
>  MODULE_DEVICE_TABLE(pci, pdc202xx);
> -MODULE_VERSION(DRV_VERSION);
> +MODULE_VERSION("0.4.3");

I've just deleted MODULE_VERSION() entirely from some subsystems, as
once the driver is in the kernel source tree, the "version" makes almost
no sense at all.

But I know some companies love incrementing it (some network and scsi
drivers specifically), so those might want to keep it around for some
odd reason.

thanks

greg k-h
