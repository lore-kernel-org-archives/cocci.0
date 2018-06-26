From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 26 Jun 2018 10:06:48 +0200 (CEST)
Subject: [Cocci] [PATCH v2 net] nfp: cast sizeof() to int when comparing
 with error code
In-Reply-To: <ff0b2834b771a467246b9f7c1b4600c38f5bb463.camel@perches.com>
References: <20180626011631.22717-1-cgxu519@gmx.com>
 <ff0b2834b771a467246b9f7c1b4600c38f5bb463.camel@perches.com>
Message-ID: <alpine.DEB.2.20.1806261005190.4512@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 25 Jun 2018, Joe Perches wrote:

> On Tue, 2018-06-26 at 09:16 +0800, Chengguang Xu wrote:
> > sizeof() will return unsigned value so in the error check
> > negative error code will be always larger than sizeof().
>
> This looks like a general class of error in the kernel
> where a signed result that could be returning a -errno
> is tested against < or <= sizeof()
>
> A couple examples:
>
> drivers/input/mouse/elan_i2c_smbus.c:
>
> 		len = i2c_smbus_read_block_data(client,
> 						ETP_SMBUS_IAP_PASSWORD_READ,
> 						val);
> 		if (len < sizeof(u16)) {
>
> i2c_smbus_read_block_data can return a negative errno
>
>
> net/smc/smc_clc.c:
>
> 	len = kernel_sendmsg(smc->clcsock, &msg, &vec, 1,
> 			     sizeof(struct smc_clc_msg_decline));
> 	if (len < sizeof(struct smc_clc_msg_decline))
>
> where kernel_sendmsg can return a negative errno
>
> There are probably others, I didn't look hard.
>
> Perhaps a cocci script to find these could be generated?

Here's another one:

drivers/usb/serial/ir-usb.c
@@ -126,13 +126,8 @@ irda_usb_find_class_desc(struct usb_seri
 	if (!desc)
 		return NULL;

-	ret = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0),
-			USB_REQ_CS_IRDA_GET_CLASS_DESC,
-			USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
-			0, ifnum, desc, sizeof(*desc), 1000);

 	dev_dbg(&serial->dev->dev, "%s -  ret=%d\n", __func__, ret);
-	if (ret < sizeof(*desc)) {
 		dev_dbg(&serial->dev->dev,
 			"%s - class descriptor read %s (%d)\n", __func__,
 			(ret < 0) ? "failed" : "too short", ret);

There are other results, but I haven't checked all of them.

julia
