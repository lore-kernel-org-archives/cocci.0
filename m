Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69CDC6FD1F
	for <cocci@archiver.kernel.org>; Sat, 25 Mar 2023 10:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Z17dRNrCrYIBN0LnmzUS7K95CHIzsG2i4TpKFviMf6Y=;
  b=Cm9mtJRS9795pBVk+aRix4WIrmQldNFxtaOfoxMS+OR/RrU2HIGrz1B6
   1KNAyGMYctBr7Te+IS3QRtVV/75RbJbwDGu6a1JXT7KI7oL5jQwy7+NoU
   2F/w7LKqzAE8MEgoNptW97gaiH5l1Saba7xk3OpQNcQaI/0XTRcfmGCnQ
   4=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="99050397"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2023 11:12:56 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DB022E0D44; Sat, 25 Mar 2023 11:12:55 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id EBA9FE0D40
	for <cocci@sympa.inria.fr>; Sat, 25 Mar 2023 11:12:50 +0100 (CET)
IronPort-SDR: 641ec922_PicCIV0ecTXmTzm1OZ7YOHPB6ZX2C8/YQ9ImVnSXUN1QxkR
 Pj4JgmbXmpzh+L84UdCPPWiVLG4OLtnz+vSicyQ==
X-IPAS-Result: =?us-ascii?q?A0ErAACjyB5khwQP49RaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YItgUsvBAtGhFOIH4hiLgOEL4csjCGEAoFWgUA+DwEDAQ1BAQIEAQEDBDiBU?=
 =?us-ascii?q?4JzAoU6Ah0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAEBA?=
 =?us-ascii?q?hABAQEaCRcHDhAFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QESAkdTPQMDIwQZAQERJgEPHwYCJgICVwYBDAYCAQGCeoIoAQMxB7EdfzOBA?=
 =?us-ascii?q?YIIAQEGnAofLCJTgV4JgRQtAY0DAYM2eicPgVVEgTwMgzWIHIJnkSOILwqBN?=
 =?us-ascii?q?HWBIA6BPYEEAgkCEWuBEghrgX1AAg1kCw5vgUoCZEyBHiUEDgMZKx1AAgELO?=
 =?us-ascii?q?zo/NQYDCyAGWGsCCSMREwUDCxUqRwQIOQYcNBECCA8SDyxEDkI3NBMGXAEpC?=
 =?us-ascii?q?w4RA1CBRwSBCoEBBgEmJJpxAgGCZwFSO0wmggSSabA9NAeCKIFVgVkMnwwGE?=
 =?us-ascii?q?AMulwgOBpIjLocgDZAPIKd6gWM6gVwzGiSDNk8DGQ+OIBmEDI9HQDQ7AgcBC?=
 =?us-ascii?q?gEBAwmFRgEBhXsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:MZRZIKMJx8QIf8BcThWjsMiBIKoaSvp037Dk7TEVdfUnSL36qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFhrX5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YFT0EUMr3N5DZB/KTHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="51222635"
X-MGA-submission: =?us-ascii?q?MDGsmq+B2zDa8tC/dlGAfN/Yu+EUGMAkxZc9qn?=
 =?us-ascii?q?cTL4bGp4XJMWJfwjeEwLvU/fvQG8sRuJMeJC4d8aXYnASW4crhFVk1dP?=
 =?us-ascii?q?TzmYlqhHggWbNRdZ1ST6G33esZuXCNZUHoJXblMx3miAQTyPiNmUBLXW?=
 =?us-ascii?q?xt7n6xg3iEvI+zoOnEucbJaw=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 11:12:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679739162; i=markus.elfring@web.de;
	bh=sahcsMKOtTGxf+Ht7i65hmtk9xD9YXjpL5+1ZzAB/V0=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=k5WW096BWDd9agZvaJDjKEvUotpLlSfLaHx3RseCdKhVo+/z5zEMVDX+PEZqS793S
	 3mL3tqkIF5H3OE6ob+VvjrtJIfJ+zjMtB/OVQoiFBmnK6+YJiDxCdX0yQzK3PbNG5Z
	 y9fjTUSuifVuet4YglV/Qfikmm7Gsv9h9WRFpdojHCgAPvxynFAwJbiXFEuWgLa8eH
	 TGfnLxABv8MywgWNuTgo7jc1/sCdwsNRwwgqm+SGUdFij7qYvuxM/MvzGeKhEBxMmp
	 FRi7vtBS4pLqOwymYPW1j6DA6BoZVzX5od/775QkWldLxI76r4RDMqeYoJk3nCRSyI
	 v9iEUxLwPzRkw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MwA1A-1qVVc60KQe-00s7F4; Sat, 25
 Mar 2023 11:12:42 +0100
Message-ID: <89445996-9dd8-fd02-79cb-8123827e26fd@web.de>
Date: Sat, 25 Mar 2023 11:12:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
To: kernel-janitors@vger.kernel.org, linux-input@vger.kernel.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hillf Danton
 <hdanton@sina.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <521b63e1-9470-58ef-599e-50a1846e5380@web.de> <ZBffPEIWcmYcaXR3@google.com>
 <6b5de584-b31f-9045-a438-b42da350326b@I-love.SAKURA.ne.jp>
 <ZBf3oSgJP8bLmhG0@google.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ZBf3oSgJP8bLmhG0@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RYH2LZNrhNFTPpUPekAU02M3aJ+K3lKXMXkDQ2GIYg50S7KDrXl
 fXVlCAHn+QxGWyfOY/3ZKoZTL55hHihzBjfg7wH798IK+k2FKbSdzJ2+W8MLnisr9zTVPC8
 u6gR6HgtJjqj/xGWNqp0wd703Wp25tFHdZVN/IuXaL/xW+tNDz5BYBtWlGpP3K3Op59Ktf2
 tVvOWhq61/IiuNTM045mA==
UI-OutboundReport: notjunk:1;M01:P0:bYNxrwzMOEY=;zrLcxOjj0c7JKCsbaena39TC0wY
 NGXho/vR3s8KF4a9En2SKDM8rjuSc17WGy9tIPWJkOCWjRX85gEpn4p1TsWmXyxFZUlCsW+0x
 PU7vx23MiH6X4+ilcEx7mo637b0b0E3GiDaaqapjC4uEyJ3IdSwoOizQqznOnOZZFCiKKxuPi
 5i/0OeUhaiTTcQ9SyQdbHhCOpAZ8oMkEaIzl29LnVFWL+YyTzmbC6mbi/KkWy4JXHC9Q33FHw
 tOmnXQSgyPsisO9mTzeBQaqPE5jDqxw+efKkDVfCpDGQlcUO4EIwUy8pQ6DWDeE+Y+T7IRhgq
 FOFv0NhVsgPHsGNtgxnJJ9XkYTnIAyGT7qYzQPrGf2anoE119S7U/fZewQeV88e9L2tPBcepF
 vgE/LnUMkT1K9hc2+yl4T/ECmm0iRqylOatyO6Th99P1wv76XwuZKpZQwX0lMpnBvz2syvet1
 nN1ehar6D92oH/1uhZj/tHAq3NHvwtylQoTOT/LCdS4fopZI/huTamt4EatcNkBZi0kWv7neG
 w4O35oZdLSzCYQjmopah6kdfG9+l3b6LTTKhjERGAiNbZtBo7G5BJ8fP/3RKwhMYC5vsXZpWz
 4MlS+DP0miOVMadxkKvnxP8WIBT50Li1UIa9yDWCP2XPwK7IArMv3rud7IiFCXZgWfnahWHZW
 ZrfmCdPFglDVlt/04mWy4F7a/aNrKzaq+74GpOyjZa/jhohOEQ9jLTzYPvbilPrexsiT6mX1N
 519XJjvTbdvlry9kh2nTWx1O2BW774Ni4bCACgIciMtfk2X3m/uHnC3yuLqMsODkeyH9xoJAs
 g28J5WlMY+Jf5QlttcO8AB4QcAGDGCs4whJtuCoklYhHozJQrOvFOg/lTsRO4Y8QAD8LMmCOM
 f43d/IfqxjXPMRKPT0Dd50JrJw3p3togrc2k1O6is3j2oj4BHfDOZ3Tau
Subject: [cocci] [PATCH resent] Input: iforce - Fix exception handling in
 iforce_usb_probe()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 936
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
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/89445996-9dd8-fd02-79cb-8123827e26fd%40web.de>

Date: Sun, 19 Mar 2023 18:50:51 +0100

The label =E2=80=9Cfail=E2=80=9D was used to jump to another pointer check=
 despite of
the detail in the implementation of the function =E2=80=9Ciforce_usb_probe=
=E2=80=9D
that it was determined already that a corresponding variable contained
still a null pointer.

1. Use more appropriate labels instead.

2. Reorder jump targets at the end.

3. Delete a redundant check.


This issue was detected by using the Coccinelle software.

Fixes: 81fd43132684605b21600fa5e27f23034e18dfd3 ("Input: iforce - move tra=
nsport data into transport modules")
Fixes: ^1da177e4c3f41524e886b7f1b8a0c1fc7321cac ("Linux-2.6.12-rc2")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/input/joystick/iforce/iforce-usb.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/input/joystick/iforce/iforce-usb.c b/drivers/input/jo=
ystick/iforce/iforce-usb.c
index cba92bd590a8..f4d70831adf1 100644
=2D-- a/drivers/input/joystick/iforce/iforce-usb.c
+++ b/drivers/input/joystick/iforce/iforce-usb.c
@@ -210,15 +210,15 @@ static int iforce_usb_probe(struct usb_interface *in=
tf,

 	iforce_usb =3D kzalloc(sizeof(*iforce_usb), GFP_KERNEL);
 	if (!iforce_usb)
-		goto fail;
+		goto exit;

 	iforce_usb->irq =3D usb_alloc_urb(0, GFP_KERNEL);
 	if (!iforce_usb->irq)
-		goto fail;
+		goto free_usb;

 	iforce_usb->out =3D usb_alloc_urb(0, GFP_KERNEL);
 	if (!iforce_usb->out)
-		goto fail;
+		goto free_urb_irq;

 	iforce_usb->iforce.xport_ops =3D &iforce_usb_xport_ops;

@@ -237,18 +237,18 @@ static int iforce_usb_probe(struct usb_interface *in=
tf,

 	err =3D iforce_init_device(&intf->dev, BUS_USB, &iforce_usb->iforce);
 	if (err)
-		goto fail;
+		goto free_urb_out;

 	usb_set_intfdata(intf, iforce_usb);
 	return 0;

-fail:
-	if (iforce_usb) {
-		usb_free_urb(iforce_usb->irq);
-		usb_free_urb(iforce_usb->out);
-		kfree(iforce_usb);
-	}
-
+free_urb_out:
+	usb_free_urb(iforce_usb->out);
+free_urb_irq:
+	usb_free_urb(iforce_usb->irq);
+free_usb:
+	kfree(iforce_usb);
+exit:
 	return err;
 }

=2D-
2.40.0

