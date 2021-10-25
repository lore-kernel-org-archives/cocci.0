Return-Path: <SRS0=o+tk=PN=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1A9C433EF
	for <cocci@archiver.kernel.org>; Mon, 25 Oct 2021 15:41:51 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A96D60F92
	for <cocci@archiver.kernel.org>; Mon, 25 Oct 2021 15:41:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9A96D60F92
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
IronPort-Data: =?us-ascii?q?A9a23=3A3y9/0a/qvnLxAxkFKF1eDrUDln+TJUtcMsCJ2f8?=
 =?us-ascii?q?bfWQNrUon0D0Gn2oZCD2DbP+Ma2fzfth2YY7l80IHu5/WzYNgSVdlrnsFo1Bi+?=
 =?us-ascii?q?ZOUX4zBRqvTF3rPdZObFBoPA/3z27AsFehsJpPnjkrrYueJQUVUj/nSH+OkUrO?=
 =?us-ascii?q?cY0ideCc/IMsfoUM68wIGqt4w6TSJK1vlVeLa+6UzCnf9s9JHGj58B5a4lf9al?=
 =?us-ascii?q?K+aVAX0EbAJTasjUFf2zxH5BX+ETE27ByOQroJ8RoZWSwtfpYxV8F81/z91Yj+?=
 =?us-ascii?q?kuq3qd1UDBL/UJwmHzHRMM0SgqkEY9mpjieBiaqBaMBkP49mKt4kZJNFlvpu7Q?=
 =?us-ascii?q?gZsObLKlf41Uh9CEig4M7cuFLrveijk75HIp6HBWz62qxl0N2k9OoYT+85+G2p?=
 =?us-ascii?q?O9OIVMnYOYwqFiubwx6i0IsFmh984PcflFIwas3BkizreCJ4OSpfORajMzdBd1?=
 =?us-ascii?q?TY0wMtJGJ72a8MfLzgpcxXEZxxGP0w/B5c3nePujX76GxVUoUyUqbEw5WTdwwh?=
 =?us-ascii?q?Z373kMd6TcduPLe1ZkwCDoX/U9iLyBQsXMsCezxKK93utgqnEmiaTcIkJCbm85?=
 =?us-ascii?q?9Zlh1qcwmFVAxoTPXOxrP+0hk+9R/pfJk0S92w0qqMx7ySDRd36WAaQon6Puhk?=
 =?us-ascii?q?bQJxbFOhSwA2EzKvZ50CdC3oPRzhGQNgnssYsQnotzFDht9jpHz10rLqNSTSX8?=
 =?us-ascii?q?bqUqCy7PSQYN0cGZCkOTBdD6N7myLzfJDqnos1LCLSygpjxGCrsziuX9Xh4hrM?=
 =?us-ascii?q?JjMdN2b/TwLwOuBr0zrChc+L/zl+/srqZ0z5E?=
X-IronPort-AV: E=Sophos;i="5.87,180,1631570400"; 
   d="scan'208";a="383653"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Oct 2021 17:41:49 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9CA43E001B; Mon, 25 Oct 2021 17:41:48 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id A419EE0015
	for <cocci@sympa.inria.fr>; Mon, 25 Oct 2021 17:41:44 +0200 (CEST)
Authentication-Results: mail3-smtp-sop.national.inria.fr; spf=None smtp.pra=joe@perches.com; spf=None smtp.mailfrom=joe@perches.com; spf=None smtp.helo=postmaster@smtprelay.hostedemail.com
IronPort-PHdr: =?us-ascii?q?A9a23=3AoZktJh0drqyL848rsmDOzQMyDhhOgF0UFjAc5pd?=
 =?us-ascii?q?vsb9SaKPrp82kYBaHo6Q0xwKWFazgqNt8w9LMtK7hXWFSqb2gi1slNKJ2ahkel?=
 =?us-ascii?q?M8NlBYhCsPWQWfyLfrtcjBoVJ8aDAwt8H60K1VaF9jjbFPOvHKy8SQSGhLiPgZ?=
 =?us-ascii?q?pO+j5AIHfg9qr2+yo/5DffgpEiTq/bLhvMBi4sALdu9UMj4B/MKgx0BzJonVJe?=
 =?us-ascii?q?+RS22xlIE+Ykgj/6Mmt4pNt6jxctP09+cFOV6X6ZLk4QqdDDDs6KWA15dbkugf?=
 =?us-ascii?q?FQACS+3YTSGQWkh5PAwjY8BH3W4r6vyXmuuZh3iSRINb7Rq4oVzu886hrSQfoi?=
 =?us-ascii?q?CYZOD4/7GHXkdF7gKZCrB68uxBz34vYbYeIP/R8Y6zdZ8sXS2lcUMhRSSJPDIG?=
 =?us-ascii?q?zb4UTAOUPMulWoJLwp0cMoBakGQWgGPnixiJOi3Tr3aM6yeMhEQTe0QIkGNIBr?=
 =?us-ascii?q?mnfos/rO6cITe+1zLfHzS7eZP5R2zf975bHfws5of6SR7J/bcrRxlc0Fw/fklq?=
 =?us-ascii?q?QronlMiqT2+8QvGeV8/BuWvizi247tQ5xuD6vy98oh4TGmo4Yyl/J+CtkzIg1O?=
 =?us-ascii?q?NC1SlJ3bNy4HZdNqyyXN4l7Tt4tTWxmtys0xL4Lt5G5cSUEzJkr2R7RZfObf4W?=
 =?us-ascii?q?W5B/oSeWfIS9giX57Zb6yhgy+/Ee8xuHmWcS530xGojRYntTDrnwByQHf58mdR?=
 =?us-ascii?q?vZy4kutwziC2gPJ5uxFPUw5k7fQJYQ7zb4qjJUTtFzOHi/ol0Xyi6+bbl4k+u2?=
 =?us-ascii?q?06+T/eLXpuJucOJV0iw3kMqQunde/AfgmPQcTQWeb/P6z1Lzn/UHjXLpKifg2n?=
 =?us-ascii?q?rHYsJDcO8sbura0DxFI3osi8RqyACuq3M4XkHQINl5JZg+LgofxN1HLOv/4DPO?=
 =?us-ascii?q?/g1q2kDdswvDLJr/hApLTIXXYiLfuY6x95FJcyAUt1tBT/Y5bCrYEIP7rQE/+q?=
 =?us-ascii?q?MTYDgMlMwyz2+voFNJ92Z8CVmKOGaKZK6PTsVqQ5u01OeWMZYkVuCz8K/c//fL?=
 =?us-ascii?q?ug2U5yhchevyN1IENeTiWH/JpLl/RNV7lmM0QV0kLuAUzVsTul1ODVzFefTC0U?=
 =?us-ascii?q?r5qonkZD4KvC8/jQZ6qhLDJiCW8HpRQTmNLEFaBFTHvbYrSH79ERzifLYdCiDs?=
 =?us-ascii?q?NVf2BQpU90Bio/Fv10bdoLer8/iweqILt08Vz6+TPlBY0sztuAJLZm2qKRGp1t?=
 =?us-ascii?q?mIOXT4/mq5l8mJnzVLW8691y8RVD9dT6ugBBgU9OLbEwvZxC93pHAnGe4HaGx6?=
 =?us-ascii?q?dXty6DGRpHZoKyNgUbhM4Qo365vgs9zKnGbQVmqfND5sxoPq0N5nZPMNh02zL0?=
 =?us-ascii?q?KAwyVkhWddCOWCjj697sQPUAtyR+618v76nb68c0TWL/2CGnzLmgQ=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A/DTA96NPcdpGYcBcTnqjsMiBIKoaSvp037Dk?=
 =?us-ascii?q?7SFMoHtuA6qlfqGV7ZMmPHrP4gr5N0tMpTntAsW9qDbnhP1ICWd4B8bfYOCkgh?=
 =?us-ascii?q?rUEGlahbGSvAEIYheOiNK1t50BT0EOMqyVMbEgt7eC3ODQKb9Jq+VvsprY59s2?=
 =?us-ascii?q?qU0DcegAUdAE0+4WMGim+2RNNXh7LKt8OpqAx9ZN4wGtcW4Qaa2AdwM4dtmGid?=
 =?us-ascii?q?3XtY7sJSULDR4/6AWIkFqTmcXHOind8BcCci9FhYwv+2jdkwD/++GKvvyhxgXH?=
 =?us-ascii?q?vlWjn6h+qZ/OysZjGMfJsMQTJzn24zzYHLhcZw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0ABAQASaxphh9YsKNhagQmBWYN5KBKNf?=
 =?us-ascii?q?IgCZwOBPZorgXwLAQMBDUEEAQGEYQKCbB4GBjAJDgECBBUBAQUBAQECAQMDBAE?=
 =?us-ascii?q?TAQEBAQ0LDgg6JIV1gjUpAYNkAQIDJ1IQCxgcElcGAQmCeoMIBad0gQEygQGEa?=
 =?us-ascii?q?YNOgWOBOol5g3pDP4FOgRWBO4FqPoo/BIMiggABgyWfNAFfnRuDMoE3nUaDZZI?=
 =?us-ascii?q?nkGmWEaA1F4R5AYFfghRNIxWDJU8ZDo4sDQmOTiFqAgYLAQEDCYl1AQE?=
X-IPAS-Result: =?us-ascii?q?A0ABAQASaxphh9YsKNhagQmBWYN5KBKNfIgCZwOBPZorgXw?=
 =?us-ascii?q?LAQMBDUEEAQGEYQKCbB4GBjAJDgECBBUBAQUBAQECAQMDBAETAQEBAQ0LDgg6J?=
 =?us-ascii?q?IV1gjUpAYNkAQIDJ1IQCxgcElcGAQmCeoMIBad0gQEygQGEaYNOgWOBOol5g3p?=
 =?us-ascii?q?DP4FOgRWBO4FqPoo/BIMiggABgyWfNAFfnRuDMoE3nUaDZZInkGmWEaA1F4R5A?=
 =?us-ascii?q?YFfghRNIxWDJU8ZDo4sDQmOTiFqAgYLAQEDCYl1AQE?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="397314191"
X-MGA-submission: =?us-ascii?q?MDEk9qj/P55Bjcd/cVnM4qc4oA38Zyp3cbNthm?=
 =?us-ascii?q?icfTX8sHO7UUq0JC4hsfkgFWXygBQ2mfZWp+W6tmqD+BPS1tJnB65MxZ?=
 =?us-ascii?q?HofjD5gt/EwlzNiMHo5xDGh0ZDU+tA1SNGEOb4PpxQw8Co4+bSDhfMjS?=
 =?us-ascii?q?8OVD/jOWkeqbJcXeDBAo5l+A=3D=3D?=
Received: from smtprelay0214.hostedemail.com (HELO smtprelay.hostedemail.com) ([216.40.44.214])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 17:41:42 +0200
Received: from omf08.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
	by smtprelay03.hostedemail.com (Postfix) with ESMTP id 99167837F24F;
	Mon, 25 Oct 2021 15:41:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id 77D901A29F7;
	Mon, 25 Oct 2021 15:41:37 +0000 (UTC)
Message-ID: <094a8f50ccef81e0317c89d0a605c327c825d5cb.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Larry Finger <Larry.Finger@lwfinger.net>, Johan Hovold
 <johan@kernel.org>,  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 cocci@inria.fr
Cc: Florian Schilhabel <florian.c.schilhabel@googlemail.com>, 
	linux-staging@lists.linux.dev, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 25 Oct 2021 08:41:36 -0700
In-Reply-To: <fdb677be-6e06-fef9-811d-bb2c71246197@lwfinger.net>
References: <20211025120910.6339-1-johan@kernel.org>
	 <20211025120910.6339-2-johan@kernel.org>
	 <fdb677be-6e06-fef9-811d-bb2c71246197@lwfinger.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 77D901A29F7
X-Stat-Signature: jtsjk15fbgq7mm9medmizihzz73za3n5
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/BkikA0QYBr2sELnPc3Wb+OA0k6AvaZb4=
X-HE-Tag: 1635176497-284566
Subject: Re: [cocci] [PATCH 1/2] staging: rtl8192u: fix control-message
 timeouts
Reply-To: Joe Perches <joe@perches.com>
X-Loop: cocci@inria.fr
X-Sequence: 32
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-10/094a8f50ccef81e0317c89d0a605c327c825d5cb.camel%40perches.com>

On Mon, 2021-10-25 at 10:06 -0500, Larry Finger wrote:
> On 10/25/21 07:09, Johan Hovold wrote:
> > USB control-message timeouts are specified in milliseconds and should
> > specifically not vary with CONFIG_HZ.

There appears to be more than a few of these in the kernel.

$ cat usb_hz.cocci
@@
expression e;
@@
* usb_control_msg(..., HZ * e)

@@
expression e;
@@
* usb_control_msg(..., HZ / e)

@@
@@
* usb_control_msg(..., HZ)

$ spatch --very-quiet -U 0 -sp-file usb_hz.cocci .
warning: line 4: should HZ be a metavariable?
warning: line 9: should HZ be a metavariable?
warning: line 13: should HZ be a metavariable?
50 files match
diff -U 0 -p ./drivers/usb/misc/iowarrior.c /tmp/nothing/drivers/usb/misc/iowarrior.c
--- ./drivers/usb/misc/iowarrior.c
+++ /tmp/nothing/drivers/usb/misc/iowarrior.c
@@ -112,6 +112,0 @@ static int usb_get_report(struct usb_dev
-	return usb_control_msg(dev, usb_rcvctrlpipe(dev, 0),
-			       USB_REQ_GET_REPORT,
-			       USB_DIR_IN | USB_TYPE_CLASS |
-			       USB_RECIP_INTERFACE, (type << 8) + id,
-			       inter->desc.bInterfaceNumber, buf, size,
-			       GET_TIMEOUT*HZ);
@@ -126,7 +120,0 @@ static int usb_set_report(struct usb_int
-	return usb_control_msg(interface_to_usbdev(intf),
-			       usb_sndctrlpipe(interface_to_usbdev(intf), 0),
-			       USB_REQ_SET_REPORT,
-			       USB_TYPE_CLASS | USB_RECIP_INTERFACE,
-			       (type << 8) + id,
-			       intf->cur_altsetting->desc.bInterfaceNumber, buf,
-			       size, HZ);
diff -U 0 -p ./drivers/staging/rtl8712/usb_ops_linux.c /tmp/nothing/drivers/staging/rtl8712/usb_ops_linux.c
--- ./drivers/staging/rtl8712/usb_ops_linux.c
+++ /tmp/nothing/drivers/staging/rtl8712/usb_ops_linux.c
@@ -496,2 +496,0 @@ int r8712_usbctrl_vendorreq(struct intf_
-	status = usb_control_msg(udev, pipe, request, reqtype, value, index,
-				 pIo_buf, len, HZ / 2);
diff -U 0 -p ./drivers/staging/rtl8192u/r8192U_core.c /tmp/nothing/drivers/staging/rtl8192u/r8192U_core.c
--- ./drivers/staging/rtl8192u/r8192U_core.c
+++ /tmp/nothing/drivers/staging/rtl8192u/r8192U_core.c
@@ -227,3 +227,0 @@ int write_nic_byte_E(struct net_device *
-	status = usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
-				 RTL8187_REQ_SET_REGS, RTL8187_REQT_WRITE,
-				 indx | 0xfe00, 0, usbdata, 1, HZ / 2);
@@ -249,3 +246,0 @@ int read_nic_byte_E(struct net_device *d
-	status = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
-				 RTL8187_REQ_GET_REGS, RTL8187_REQT_READ,
-				 indx | 0xfe00, 0, usbdata, 1, HZ / 2);
@@ -276,4 +270,0 @@ int write_nic_byte(struct net_device *de
-	status = usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
-				 RTL8187_REQ_SET_REGS, RTL8187_REQT_WRITE,
-				 (indx & 0xff) | 0xff00, (indx >> 8) & 0x0f,
-				 usbdata, 1, HZ / 2);
@@ -302,4 +292,0 @@ int write_nic_word(struct net_device *de
-	status = usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
-				 RTL8187_REQ_SET_REGS, RTL8187_REQT_WRITE,
-				 (indx & 0xff) | 0xff00, (indx >> 8) & 0x0f,
-				 usbdata, 2, HZ / 2);
@@ -328,4 +314,0 @@ int write_nic_dword(struct net_device *d
-	status = usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
-				 RTL8187_REQ_SET_REGS, RTL8187_REQT_WRITE,
-				 (indx & 0xff) | 0xff00, (indx >> 8) & 0x0f,
-				 usbdata, 4, HZ / 2);
@@ -352,4 +334,0 @@ int read_nic_byte(struct net_device *dev
-	status = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
-				 RTL8187_REQ_GET_REGS, RTL8187_REQT_READ,
-				 (indx & 0xff) | 0xff00, (indx >> 8) & 0x0f,
-				 usbdata, 1, HZ / 2);
@@ -377,4 +355,0 @@ int read_nic_word(struct net_device *dev
-	status = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
-				 RTL8187_REQ_GET_REGS, RTL8187_REQT_READ,
-				 (indx & 0xff) | 0xff00, (indx >> 8) & 0x0f,
-				 usbdata, 2, HZ / 2);
@@ -402,3 +376,0 @@ static int read_nic_word_E(struct net_de
-	status = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
-				 RTL8187_REQ_GET_REGS, RTL8187_REQT_READ,
-				 indx | 0xfe00, 0, usbdata, 2, HZ / 2);
@@ -427,4 +398,0 @@ int read_nic_dword(struct net_device *de
-	status = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
-				 RTL8187_REQ_GET_REGS, RTL8187_REQT_READ,
-				 (indx & 0xff) | 0xff00, (indx >> 8) & 0x0f,
-				 usbdata, 4, HZ / 2);
diff -U 0 -p ./drivers/net/wireless/realtek/rtl818x/rtl8187/rtl8225.c /tmp/nothing/drivers/net/wireless/realtek/rtl818x/rtl8187/rtl8225.c
--- ./drivers/net/wireless/realtek/rtl818x/rtl8187/rtl8225.c
+++ /tmp/nothing/drivers/net/wireless/realtek/rtl818x/rtl8187/rtl8225.c
@@ -28,4 +28,0 @@ u8 rtl818x_ioread8_idx(struct rtl8187_pr
-	usb_control_msg(priv->udev, usb_rcvctrlpipe(priv->udev, 0),
-			RTL8187_REQ_GET_REG, RTL8187_REQT_READ,
-			(unsigned long)addr, idx & 0x03,
-			&priv->io_dmabuf->bits8, sizeof(val), HZ / 2);
@@ -45,4 +41,0 @@ u16 rtl818x_ioread16_idx(struct rtl8187_
-	usb_control_msg(priv->udev, usb_rcvctrlpipe(priv->udev, 0),
-			RTL8187_REQ_GET_REG, RTL8187_REQT_READ,
-			(unsigned long)addr, idx & 0x03,
-			&priv->io_dmabuf->bits16, sizeof(val), HZ / 2);
@@ -62,4 +54,0 @@ u32 rtl818x_ioread32_idx(struct rtl8187_
-	usb_control_msg(priv->udev, usb_rcvctrlpipe(priv->udev, 0),
-			RTL8187_REQ_GET_REG, RTL8187_REQT_READ,
-			(unsigned long)addr, idx & 0x03,
-			&priv->io_dmabuf->bits32, sizeof(val), HZ / 2);
@@ -79,4 +67,0 @@ void rtl818x_iowrite8_idx(struct rtl8187
-	usb_control_msg(priv->udev, usb_sndctrlpipe(priv->udev, 0),
-			RTL8187_REQ_SET_REG, RTL8187_REQT_WRITE,
-			(unsigned long)addr, idx & 0x03,
-			&priv->io_dmabuf->bits8, sizeof(val), HZ / 2);
@@ -93,4 +77,0 @@ void rtl818x_iowrite16_idx(struct rtl818
-	usb_control_msg(priv->udev, usb_sndctrlpipe(priv->udev, 0),
-			RTL8187_REQ_SET_REG, RTL8187_REQT_WRITE,
-			(unsigned long)addr, idx & 0x03,
-			&priv->io_dmabuf->bits16, sizeof(val), HZ / 2);
@@ -107,4 +87,0 @@ void rtl818x_iowrite32_idx(struct rtl818
-	usb_control_msg(priv->udev, usb_sndctrlpipe(priv->udev, 0),
-			RTL8187_REQ_SET_REG, RTL8187_REQT_WRITE,
-			(unsigned long)addr, idx & 0x03,
-			&priv->io_dmabuf->bits32, sizeof(val), HZ / 2);
@@ -183,4 +159,0 @@ static void rtl8225_write_8051(struct ie
-	usb_control_msg(priv->udev, usb_sndctrlpipe(priv->udev, 0),
-			RTL8187_REQ_SET_REG, RTL8187_REQT_WRITE,
-			addr, 0x8225, &priv->io_dmabuf->bits16, sizeof(data),
-			HZ / 2);
diff -U 0 -p ./drivers/net/wireless/ath/ath6kl/usb.c /tmp/nothing/drivers/net/wireless/ath/ath6kl/usb.c
--- ./drivers/net/wireless/ath/ath6kl/usb.c
+++ /tmp/nothing/drivers/net/wireless/ath/ath6kl/usb.c
@@ -905,6 +905,0 @@ static int ath6kl_usb_submit_ctrl_in(str
-	ret = usb_control_msg(ar_usb->udev,
-				 usb_rcvctrlpipe(ar_usb->udev, 0),
-				 req,
-				 USB_DIR_IN | USB_TYPE_VENDOR |
-				 USB_RECIP_DEVICE, value, index, buf,
-				 size, 2 * HZ);
diff -U 0 -p ./drivers/net/wireless/ath/ath10k/usb.c /tmp/nothing/drivers/net/wireless/ath/ath10k/usb.c
--- ./drivers/net/wireless/ath/ath10k/usb.c
+++ /tmp/nothing/drivers/net/wireless/ath/ath10k/usb.c
@@ -523,6 +523,0 @@ static int ath10k_usb_submit_ctrl_in(str
-	ret = usb_control_msg(ar_usb->udev,
-			      usb_rcvctrlpipe(ar_usb->udev, 0),
-			      req,
-			      USB_DIR_IN | USB_TYPE_VENDOR |
-			      USB_RECIP_DEVICE, value, index, buf,
-			      size, 2 * HZ);
diff -U 0 -p ./drivers/most/most_usb.c /tmp/nothing/drivers/most/most_usb.c
--- ./drivers/most/most_usb.c
+++ /tmp/nothing/drivers/most/most_usb.c
@@ -149,4 +149,0 @@ static inline int drci_rd_reg(struct usb
-	retval = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0),
-				 DRCI_READ_REQ, req_type,
-				 0x0000,
-				 reg, dma_buf, sizeof(*dma_buf), 5 * HZ);
@@ -171,9 +167,0 @@ static inline int drci_wr_reg(struct usb
-	return usb_control_msg(dev,
-			       usb_sndctrlpipe(dev, 0),
-			       DRCI_WRITE_REQ,
-			       USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-			       data,
-			       reg,
-			       NULL,
-			       0,
-			       5 * HZ);
diff -U 0 -p ./drivers/mmc/host/vub300.c /tmp/nothing/drivers/mmc/host/vub300.c
--- ./drivers/mmc/host/vub300.c
+++ /tmp/nothing/drivers/mmc/host/vub300.c
@@ -575,5 +575,0 @@ static void check_vub300_port_status(str
-		usb_control_msg(vub300->udev, usb_rcvctrlpipe(vub300->udev, 0),
-				GET_SYSTEM_PORT_STATUS,
-				USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-				0x0000, 0x0000, &vub300->system_port_status,
-				sizeof(vub300->system_port_status), HZ);
@@ -1239,6 +1234,0 @@ static void __download_offload_pseudocod
-				usb_control_msg(vub300->udev,
-						usb_sndctrlpipe(vub300->udev, 0),
-						SET_INTERRUPT_PSEUDOCODE,
-						USB_DIR_OUT | USB_TYPE_VENDOR |
-						USB_RECIP_DEVICE, 0x0000, 0x0000,
-						xfer_buffer, xfer_length, HZ);
@@ -1282,6 +1271,0 @@ static void __download_offload_pseudocod
-				usb_control_msg(vub300->udev,
-						usb_sndctrlpipe(vub300->udev, 0),
-						SET_TRANSFER_PSEUDOCODE,
-						USB_DIR_OUT | USB_TYPE_VENDOR |
-						USB_RECIP_DEVICE, 0x0000, 0x0000,
-						xfer_buffer, xfer_length, HZ);
@@ -1991,4 +1974,0 @@ static void __set_clock_speed(struct vub
-		usb_control_msg(vub300->udev, usb_sndctrlpipe(vub300->udev, 0),
-				SET_CLOCK_SPEED,
-				USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-				0x00, 0x00, buf, buf_array_size, HZ);
@@ -2013,4 +1992,0 @@ static void vub300_mmc_set_ios(struct mm
-		usb_control_msg(vub300->udev, usb_sndctrlpipe(vub300->udev, 0),
-				SET_SD_POWER,
-				USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-				0x0000, 0x0000, NULL, 0, HZ);
@@ -2020,4 +1995,0 @@ static void vub300_mmc_set_ios(struct mm
-		usb_control_msg(vub300->udev, usb_sndctrlpipe(vub300->udev, 0),
-				SET_SD_POWER,
-				USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-				0x0001, 0x0000, NULL, 0, HZ);
@@ -2274,5 +2245,0 @@ static int vub300_probe(struct usb_inter
-		usb_control_msg(vub300->udev, usb_rcvctrlpipe(vub300->udev, 0),
-				GET_HC_INF0,
-				USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-				0x0000, 0x0000, &vub300->hc_info,
-				sizeof(vub300->hc_info), HZ);
@@ -2282,4 +2248,0 @@ static int vub300_probe(struct usb_inter
-		usb_control_msg(vub300->udev, usb_sndctrlpipe(vub300->udev, 0),
-				SET_ROM_WAIT_STATES,
-				USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-				firmware_rom_wait_states, 0x0000, NULL, 0, HZ);
@@ -2296,5 +2258,0 @@ static int vub300_probe(struct usb_inter
-		usb_control_msg(vub300->udev, usb_rcvctrlpipe(vub300->udev, 0),
-				GET_SYSTEM_PORT_STATUS,
-				USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-				0x0000, 0x0000, &vub300->system_port_status,
-				sizeof(vub300->system_port_status), HZ);
diff -U 0 -p ./drivers/media/usb/stk1160/stk1160-core.c /tmp/nothing/drivers/media/usb/stk1160/stk1160-core.c
--- ./drivers/media/usb/stk1160/stk1160-core.c
+++ /tmp/nothing/drivers/media/usb/stk1160/stk1160-core.c
@@ -66,3 +66,0 @@ int stk1160_read_reg(struct stk1160 *dev
-	ret = usb_control_msg(dev->udev, pipe, 0x00,
-			USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-			0x00, reg, buf, sizeof(u8), HZ);
@@ -86,3 +83,0 @@ int stk1160_write_reg(struct stk1160 *de
-	ret =  usb_control_msg(dev->udev, pipe, 0x01,
-			USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-			value, reg, NULL, 0, HZ);
diff -U 0 -p ./drivers/media/usb/s2255/s2255drv.c /tmp/nothing/drivers/media/usb/s2255/s2255drv.c
--- ./drivers/media/usb/s2255/s2255drv.c
+++ /tmp/nothing/drivers/media/usb/s2255/s2255drv.c
@@ -1880,6 +1880,0 @@ static long s2255_vendor_req(struct s225
-		r = usb_control_msg(dev->udev, usb_rcvctrlpipe(dev->udev, 0),
-				    Request,
-				    USB_TYPE_VENDOR | USB_RECIP_DEVICE |
-				    USB_DIR_IN,
-				    Value, Index, buf,
-				    TransferBufferLength, HZ * 5);
@@ -1891,4 +1885,0 @@ static long s2255_vendor_req(struct s225
-		r = usb_control_msg(dev->udev, usb_sndctrlpipe(dev->udev, 0),
-				    Request, USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-				    Value, Index, buf,
-				    TransferBufferLength, HZ * 5);
diff -U 0 -p ./drivers/media/usb/pvrusb2/pvrusb2-hdw.c /tmp/nothing/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
--- ./drivers/media/usb/pvrusb2/pvrusb2-hdw.c
+++ /tmp/nothing/drivers/media/usb/pvrusb2/pvrusb2-hdw.c
@@ -1469,2 +1469,0 @@ static int pvr2_upload_firmware1(struct
-		ret += usb_control_msg(hdw->usb_dev, pipe, 0xa0, 0x40, address,
-				       0, fw_ptr, 0x800, HZ);
@@ -3437,5 +3435,0 @@ void pvr2_hdw_cpufw_set_enabled(struct p
-				ret = usb_control_msg(hdw->usb_dev,pipe,
-						      0xa0,0xc0,
-						      address,0,
-						      hdw->fw_buffer+address,
-						      0x800,HZ);
@@ -3980 +3973,0 @@ void pvr2_hdw_cpureset_assert(struct pvr
-	ret = usb_control_msg(hdw->usb_dev,pipe,0xa0,0x40,0xe600,0,da,1,HZ);
diff -U 0 -p ./drivers/media/usb/em28xx/em28xx-core.c /tmp/nothing/drivers/media/usb/em28xx/em28xx-core.c
--- ./drivers/media/usb/em28xx/em28xx-core.c
+++ /tmp/nothing/drivers/media/usb/em28xx/em28xx-core.c
@@ -90,3 +90,0 @@ int em28xx_read_reg_req_len(struct em28x
-	ret = usb_control_msg(udev, pipe, req,
-			      USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-			      0x0000, reg, dev->urb_buf, len, HZ);
@@ -159,3 +156,0 @@ int em28xx_write_regs_req(struct em28xx
-	ret = usb_control_msg(udev, pipe, req,
-			      USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-			      0x0000, reg, dev->urb_buf, len, HZ);
diff -U 0 -p ./drivers/media/usb/cpia2/cpia2_usb.c /tmp/nothing/drivers/media/usb/cpia2/cpia2_usb.c
--- ./drivers/media/usb/cpia2/cpia2_usb.c
+++ /tmp/nothing/drivers/media/usb/cpia2/cpia2_usb.c
@@ -545,9 +545,0 @@ static int write_packet(struct usb_devic
-	ret = usb_control_msg(udev,
-			       usb_sndctrlpipe(udev, 0),
-			       request,
-			       USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-			       start,	/* value */
-			       0,	/* index */
-			       buf,	/* buffer */
-			       size,
-			       HZ);
@@ -577,9 +568,0 @@ static int read_packet(struct usb_device
-	ret = usb_control_msg(udev,
-			       usb_rcvctrlpipe(udev, 0),
-			       request,
-			       USB_DIR_IN|USB_TYPE_VENDOR|USB_RECIP_DEVICE,
-			       start,	/* value */
-			       0,	/* index */
-			       buf,	/* buffer */
-			       size,
-			       HZ);
diff -U 0 -p ./drivers/media/usb/b2c2/flexcop-usb.c /tmp/nothing/drivers/media/usb/b2c2/flexcop-usb.c
--- ./drivers/media/usb/b2c2/flexcop-usb.c
+++ /tmp/nothing/drivers/media/usb/b2c2/flexcop-usb.c
@@ -82,9 +82,0 @@ static int flexcop_usb_readwrite_dw(stru
-	ret = usb_control_msg(fc_usb->udev,
-			read ? B2C2_USB_CTRL_PIPE_IN : B2C2_USB_CTRL_PIPE_OUT,
-			request,
-			request_type, /* 0xc0 read or 0x40 write */
-			wAddress,
-			0,
-			fc_usb->data,
-			sizeof(u32),
-			B2C2_WAIT_FOR_OPERATION_RDW * HZ);
@@ -151,8 +142,0 @@ static int flexcop_usb_v8_memory_req(str
-	ret = usb_control_msg(fc_usb->udev, pipe,
-			req,
-			request_type,
-			wAddress,
-			wIndex,
-			fc_usb->data,
-			buflen,
-			nWaitTime * HZ);
@@ -277,8 +260,0 @@ static int flexcop_usb_i2c_req(struct fl
-	ret = usb_control_msg(fc_usb->udev, pipe,
-			req,
-			request_type,
-			wValue,
-			wIndex,
-			fc_usb->data,
-			buflen,
-			nWaitTime * HZ);
diff -U 0 -p ./drivers/media/rc/redrat3.c /tmp/nothing/drivers/media/rc/redrat3.c
--- ./drivers/media/rc/redrat3.c
+++ /tmp/nothing/drivers/media/rc/redrat3.c
@@ -405,3 +405,0 @@ static int redrat3_send_cmd(int cmd, str
-	res = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0), cmd,
-			      USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN,
-			      0x0000, 0x0000, data, sizeof(u8), HZ * 10);
@@ -481,3 +478,0 @@ static u32 redrat3_get_timeout(struct re
-	ret = usb_control_msg(rr3->udev, pipe, RR3_GET_IR_PARAM,
-			      USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN,
-			      RR3_IR_IO_SIG_TIMEOUT, 0, tmp, len, HZ * 5);
@@ -510,4 +504,0 @@ static int redrat3_set_timeout(struct rc
-	ret = usb_control_msg(udev, usb_sndctrlpipe(udev, 0), RR3_SET_IR_PARAM,
-		     USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_OUT,
-		     RR3_IR_IO_SIG_TIMEOUT, 0, timeout, sizeof(*timeout),
-		     HZ * 25);
@@ -543,3 +533,0 @@ static void redrat3_reset(struct redrat3
-	rc = usb_control_msg(udev, rxpipe, RR3_RESET,
-			     USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN,
-			     RR3_CPUCS_REG_ADDR, 0, val, len, HZ * 25);
@@ -549,3 +536,0 @@ static void redrat3_reset(struct redrat3
-	rc = usb_control_msg(udev, txpipe, RR3_SET_IR_PARAM,
-			     USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_OUT,
-			     RR3_IR_IO_LENGTH_FUZZ, 0, val, len, HZ * 25);
@@ -555,3 +539,0 @@ static void redrat3_reset(struct redrat3
-	rc = usb_control_msg(udev, txpipe, RR3_SET_IR_PARAM,
-			     USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_OUT,
-			     RR3_IR_IO_MIN_PAUSE, 0, val, len, HZ * 25);
@@ -561,3 +542,0 @@ static void redrat3_reset(struct redrat3
-	rc = usb_control_msg(udev, txpipe, RR3_SET_IR_PARAM,
-			     USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_OUT,
-			     RR3_IR_IO_PERIODS_MF, 0, val, len, HZ * 25);
@@ -568,3 +546,0 @@ static void redrat3_reset(struct redrat3
-	rc = usb_control_msg(udev, txpipe, RR3_SET_IR_PARAM,
-			     USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_OUT,
-			     RR3_IR_IO_MAX_LENGTHS, 0, val, len, HZ * 25);
@@ -585,4 +560,0 @@ static void redrat3_get_firmware_rev(str
-	rc = usb_control_msg(rr3->udev, usb_rcvctrlpipe(rr3->udev, 0),
-			     RR3_FW_VERSION,
-			     USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN,
-			     0, 0, buffer, RR3_FW_VERSION_LEN, HZ * 5);
@@ -833,3 +804,0 @@ static int redrat3_transmit_ir(struct rc
-	ret = usb_control_msg(rr3->udev, pipe, RR3_TX_SEND_SIGNAL,
-			      USB_TYPE_VENDOR | USB_RECIP_DEVICE | USB_DIR_IN,
-			      0, 0, irdata, 2, HZ * 10);
diff -U 0 -p ./drivers/media/rc/mceusb.c /tmp/nothing/drivers/media/rc/mceusb.c
--- ./drivers/media/rc/mceusb.c
+++ /tmp/nothing/drivers/media/rc/mceusb.c
@@ -1431,3 +1431,0 @@ static void mceusb_gen1_init(struct mceu
-	ret = usb_control_msg(ir->usbdev, usb_rcvctrlpipe(ir->usbdev, 0),
-			      USB_REQ_SET_ADDRESS, USB_TYPE_VENDOR, 0, 0,
-			      data, USB_CTRL_MSG_SZ, HZ * 3);
@@ -1439,3 +1436,0 @@ static void mceusb_gen1_init(struct mceu
-	ret = usb_control_msg(ir->usbdev, usb_sndctrlpipe(ir->usbdev, 0),
-			      USB_REQ_SET_FEATURE, USB_TYPE_VENDOR,
-			      0xc04e, 0x0000, NULL, 0, HZ * 3);
@@ -1446,3 +1440,0 @@ static void mceusb_gen1_init(struct mceu
-	ret = usb_control_msg(ir->usbdev, usb_sndctrlpipe(ir->usbdev, 0),
-			      4, USB_TYPE_VENDOR,
-			      0x0808, 0x0000, NULL, 0, HZ * 3);
@@ -1452,3 +1443,0 @@ static void mceusb_gen1_init(struct mceu
-	ret = usb_control_msg(ir->usbdev, usb_sndctrlpipe(ir->usbdev, 0),
-			      2, USB_TYPE_VENDOR,
-			      0x0000, 0x0100, NULL, 0, HZ * 3);
diff -U 0 -p ./drivers/input/joystick/iforce/iforce-usb.c /tmp/nothing/drivers/input/joystick/iforce/iforce-usb.c
--- ./drivers/input/joystick/iforce/iforce-usb.c
+++ /tmp/nothing/drivers/input/joystick/iforce/iforce-usb.c
@@ -90,6 +90,0 @@ static int iforce_usb_get_id(struct ifor
-	status = usb_control_msg(iforce_usb->usbdev,
-				 usb_rcvctrlpipe(iforce_usb->usbdev, 0),
-				 id,
-				 USB_TYPE_VENDOR | USB_DIR_IN |
-					USB_RECIP_INTERFACE,
-				 0, 0, buf, IFORCE_MAX_LENGTH, HZ);
diff -U 0 -p ./drivers/gpu/drm/udl/udl_connector.c /tmp/nothing/drivers/gpu/drm/udl/udl_connector.c
--- ./drivers/gpu/drm/udl/udl_connector.c
+++ /tmp/nothing/drivers/gpu/drm/udl/udl_connector.c
@@ -31,3 +31,0 @@ static int udl_get_edid_block(void *data
-		ret = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
-				      0x02, (0x80 | (0x02 << 5)), bval,
-				      0xA1, read_buff, 2, HZ);


