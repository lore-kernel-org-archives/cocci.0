From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 17 Feb 2016 17:06:40 +0100
Subject: [Cocci] false positive match with ternary operator?
Message-ID: <20160217160637.GA18038@katana>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

So, I'll try again ;) This spatch:

@@
identifier match;
expression table, dev;
type T;
@@
-	T match = of_match_device(table, dev);
	... when != match
-	match->data
+	of_device_get_match_data(dev)
	... when != match

gives a match for:

$ spatch -sp_file /tmp/minimal.cocci drivers/usb/renesas_usbhs/common.c
...
--- drivers/usb/renesas_usbhs/common.c
+++ /tmp/cocci-output-18078-7b0a6b-common.c
@@ -498,7 +498,6 @@ static struct renesas_usbhs_platform_inf
 {
 	struct renesas_usbhs_platform_info *info;
 	struct renesas_usbhs_driver_param *dparam;
-	const struct of_device_id *of_id = of_match_device(usbhs_of_match, dev);
 	u32 tmp;
 	int gpio;
 
@@ -507,7 +506,7 @@ static struct renesas_usbhs_platform_inf
 		return NULL;
 
 	dparam = &info->driver_param;
-	dparam->type = of_id ? (uintptr_t)of_id->data : 0;
+	dparam->type = of_id ? (uintptr_t)of_device_get_match_data(dev) : 0;
 	if (!of_property_read_u32(dev->of_node, "renesas,buswait", &tmp))
 		dparam->buswait_bwait = tmp;
 	gpio = of_get_named_gpio_flags(dev->of_node, "renesas,enable-gpio", 0,

However, 'of_id' is used as the first argument of the ternary operator. So,
shouldn't '... when != match' prevent this, since 'match' is used before the
replacement?

Thanks,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20160217/65accc1b/attachment-0001.asc>
