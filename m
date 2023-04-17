Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F50CC77B76
	for <cocci@archiver.kernel.org>; Mon, 17 Apr 2023 17:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=B6o2Jv4FuGiLXDXn4OzRH8bxZaBuNzkFzrLXs3RG86E=;
  b=EXmINq34JghrrcCRgJ3DIa1siMNr6+/0xz9iNWXyRJRUR0xPgtrnooPn
   UkgocHnAM7j/Txrlv/GZWCZ3+mcZLe/VTQ1Syx/Na/TyF//YAdRJfyqfU
   EpOFYlpG9GW/SR0Aem3fdmAMnck5v//wQIr/FCD6qW8MVqPCl3Oa6zapO
   M=;
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
X-IronPort-AV: E=Sophos;i="5.99,204,1677538800"; 
   d="scan'208";a="103477396"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Apr 2023 19:09:28 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id ABFB5E033A; Mon, 17 Apr 2023 19:09:29 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6D956E00A8
	for <cocci@sympa.inria.fr>; Mon, 17 Apr 2023 19:09:22 +0200 (CEST)
IronPort-SDR: 643d7d41_LAwxaaZLZ6bWyARM9B2UFphaKSGulethMI6X7qnM5NJQy2N
 rI5V8KiN0uIAP00hA9Ma/1lu1Sq9u/P1mnkVZew==
X-IPAS-Result: =?us-ascii?q?A0FfAABbfD1khwQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0FAQELAYItgUsvBAtGhFORAjGEMIcujCWEA4FWgUA+DwEDAQ1BAQIEAQEDB?=
 =?us-ascii?q?DiERwKFPAIdBwEEMgcOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAUBA?=
 =?us-ascii?q?hABAQEaCRcHDhAFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QESAkc+AwMjBBkBAREmAQ8ZBgYCJgICVwYBCQMGAgEBgnqCKAEDMQetXH8zg?=
 =?us-ascii?q?QGCCAEBBoJjmSgfLCJUgV4JgRQtAY0KgzZ6Jw+BVUSBPIJTb4gfgmeCIZg6g?=
 =?us-ascii?q?TR2gSAOgTyBBAIJAhFrgRAIa4F5QAINZAsOb4FJY0yBewQCFEQOHCUEDgMZK?=
 =?us-ascii?q?x1AAgELOzo9NQYDCx8GVmsCCSMREwUDCxUqRwQIOAYcNBECCA8SDyxEDEI3M?=
 =?us-ascii?q?xMGXAEpCw4RA02BRgSBC4EBBgEmJJ8gexOCdpJYkkaeIDQHgiuBVoFZDJ8NB?=
 =?us-ascii?q?hMvlwkOBpIlLpdJIKd/gWoNJoFcMxokgzZPAxkPjiAZhAyPSD80PQIHCwEBA?=
 =?us-ascii?q?wmFRgEBhX0BAQ?=
IronPort-PHdr: A9a23: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
 klQqY4=
IronPort-Data: A9a23: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
 bkjx5E7AvR9LlyFiwreCjxXTNqLHs/n+08=
IronPort-HdrOrdr: A9a23:JuAJcqNMZ17MVcBcThWjsMiBIKoaSvp037Dk7TEUdfUnSL36qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFg7X5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YGT0EUMr3N5DZB/KPHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-Talos-CUID: =?us-ascii?q?9a23=3AJerjbGtlvIhkV1G9WDYj/C356IsjMXje7FqJD3W?=
 =?us-ascii?q?4BCVHS5e4DhiK+Iddxp8=3D?=
X-Talos-MUID: 9a23:l06sUQYMtgJcc+BTtgTOnBVjOMdT+K2cE0ZWtaUt+OycOnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,204,1677538800"; 
   d="scan'208";a="53582763"
X-MGA-submission: =?us-ascii?q?MDG7V9lrztvql+0xWgzjJ3iJTvEVaRD53pLxXh?=
 =?us-ascii?q?xdOQexEDM+QyWqznpkz5QTQPiKXfwHu2XyrFIXFsl64BPGa/SLYKVBT/?=
 =?us-ascii?q?IgWCcpuBMww4s1BPy6Ce4mw+I0WsS+DKbry0DrVRZapTdJ+/wXXGzaX9?=
 =?us-ascii?q?qBkYrqEfSWnOiC4ut1Xbw79A=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 19:09:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681751361; i=markus.elfring@web.de;
	bh=CH/S5Fc7UoGh1xjg82419MPjBayEPlMTm1xEy6w33kw=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=tErYliEu5xXGpGlqvGL47W69s5YrXLa792idxGbalC0m+PuN+PeAUl4v+q1Ti3OP7
	 3MKgriHmVU00prjKarc+NJEFiVjUlGK03OmNN58DyiPWZnlkR9sHAhQCVnO/5txUaT
	 JQz1cRScHT0k75HWQI5SgmbRojYNO2FmCYtSU9/qDzBiQlrMCwwZkBnkbg0yaqSluQ
	 J3moFLp/n0qAP5GyWWhb6MzfkZOwUmGGJrUfeUqfnHsMDiPai7nXPiugrdizG3TAbm
	 GcEw2DkGKDTMG6z+EUKzv58knOZihRdc+Jlq1SHzJ8IHXzWf+8nOT2S9rL7iti5Hoq
	 b5tMxh+sX/VfA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MYclj-1pt0mx3pul-00VanN; Mon, 17
 Apr 2023 19:09:20 +0200
Message-ID: <1eda9f53-6d60-288d-857d-c7a730d7a0c0@web.de>
Date: Mon, 17 Apr 2023 19:09:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>, kernel-janitors@vger.kernel.org,
 linux-media@vger.kernel.org, Devin Heitmueller
 <dheitmueller@kernellabs.com>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <622ed461-059b-455f-8a7b-7200a834bdc4@web.de>
 <8153cc88-2cea-0528-9d54-bda72cbaac5b@xs4all.nl>
 <bd1878d9-7c10-084f-cf73-711b577af5eb@web.de>
In-Reply-To: <bd1878d9-7c10-084f-cf73-711b577af5eb@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XpRNwZ9/TpmsZiDWNRGUuJJd56Fqg7HlVuwP4qPcDOOPJ+vkQ4i
 BUnCSwAl6NFN7J7oxsT4amOJiTcCuB4NW2pWbFuLSAZg2NNbEI8L6hD78Wy0LnmP/kb/iND
 h6FGh6ilzfQVS1mfUKLmuSQJK+09F/oyuX2Cr4VdMkD6xpzKYeNlxzJE4bWuD+vfwG6A2YU
 pPKQK1s3wkuvGVInkqWkg==
UI-OutboundReport: notjunk:1;M01:P0:6j/TSNmiI4c=;GGjOGljC1wz0K0GIs8WXPnwDmk8
 /3ckzlpK+JzEbN7M+dzdxtDM/NZUr3cALFx501WRQ1lUX/pjC1Rwk/SWSXvE4ikXXKkbbI5cB
 5ehpzkUqqksDvMW2mMFPuQF+mHdeb2K5HHMaL0WhvuEa6ZaMpVvYrzCFCd5trZTEMj3S5qCZp
 HkUbJN/BJTSeu/Gg3haKFx+delzYnOFmc4LBjM7LISAQP5+a1NcUgW7QPIzB88Wao9TFgHhfD
 vP8d+eUoyTJod/MkqsM3YQECUGlp3WWURxr8UFTKqx3s93FN08GQlOTP/ZIlGRVdJXKgPOalP
 qQB2MhZB3Gt408fZEeABiJ1uufrFJb9paTfBiJ9XGQcmRJrztGgDv9cu6HOu0Tvzxl579UsA+
 8/myH7wJFjEy8HqA1R58Bxc+H0K7WNfyjsiE+aRoEMvrAiuGbgpwXZu6nMVgZGt/yh2ntnGAr
 qci2Fp2eYlTM2KTv08tAQ5ruXZqPUxZXanwQjh/IdOhJMPyF1ACbwBBHfRh5y45dtbMzueFwc
 wmE66mAYy/eV9/Sh7ByXwvUlQouHUpdpZORspgSYwxGrwZkwB75WD3iFjfCQUHHqmlcqA7S/X
 KmofQMW6fNgNnXSs71PxUiNzwgb5i5Hj0VAYDDuCtBS7PpqdxodOM2f9SaxYjn0llSnfveRiY
 rOkOwddTZQQPXJN9YMiPp5tB7GTb0x1JxHM9s8ehDOsVAH52aOnE/sdha1IsCxa6+bD8hLdMw
 /HnOeQjqYS77kaCpFUsksOgmr0Tu5Oa968Rsxbw+aAyDALq6LwJ6mMF6oDzHX3oFmlVlDse63
 O2gm367ZsPrEKuknqokQRFb7jr3KfBJhpoQ4Z61bRkWg4+wxWXeQkDy7m5qkFcnSy3EZFR803
 8jMll9pLlNYJQGOMmWSm4B5mlmG4ygYqxl4ro0+8mD+ggW9sIzvSH7N3u
Subject: [cocci] [PATCH 5/5] media: au0828: Use common error handling code
 in au0828_init_isoc()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1081
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/1eda9f53-6d60-288d-857d-c7a730d7a0c0%40web.de>

Date: Mon, 17 Apr 2023 18:32:10 +0200

Add two jump targets so that a bit of exception handling can be better
reused at the end of this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/media/usb/au0828/au0828-video.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/media/usb/au0828/au0828-video.c b/drivers/media/usb/a=
u0828/au0828-video.c
index ce8050186a4c..9ca20f411ce8 100644
=2D-- a/drivers/media/usb/au0828/au0828-video.c
+++ b/drivers/media/usb/au0828/au0828-video.c
@@ -232,8 +232,7 @@ static int au0828_init_isoc(struct au0828_dev *dev, in=
t max_packets,
 		urb =3D usb_alloc_urb(max_packets, GFP_KERNEL);
 		if (!urb) {
 			au0828_isocdbg("cannot allocate URB\n");
-			au0828_uninit_isoc(dev);
-			return -ENOMEM;
+			goto e_nomem;
 		}
 		dev->isoc_ctl.urb[i] =3D urb;

@@ -241,8 +240,7 @@ static int au0828_init_isoc(struct au0828_dev *dev, in=
t max_packets,
 			sb_size, GFP_KERNEL, &urb->transfer_dma);
 		if (!dev->isoc_ctl.transfer_buffer[i]) {
 			au0828_isocdbg("cannot allocate transfer buffer\n");
-			au0828_uninit_isoc(dev);
-			return -ENOMEM;
+			goto e_nomem;
 		}
 		memset(dev->isoc_ctl.transfer_buffer[i], 0, sb_size);

@@ -271,12 +269,17 @@ static int au0828_init_isoc(struct au0828_dev *dev, =
int max_packets,
 		if (rc) {
 			au0828_isocdbg("submit of urb %i failed (error=3D%i)\n",
 				       i, rc);
-			au0828_uninit_isoc(dev);
-			return rc;
+			goto uninit_isoc;
 		}
 	}

 	return 0;
+
+e_nomem:
+	rc =3D -ENOMEM;
+uninit_isoc:
+	au0828_uninit_isoc(dev);
+	return rc;
 }

 /*
=2D-
2.40.0

