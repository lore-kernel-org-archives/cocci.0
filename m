Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A0A1C77B72
	for <cocci@archiver.kernel.org>; Fri, 14 Apr 2023 19:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=vJHJN1fUjMHpDxZNsRXNGa/60+tTgfHExE43A74Z8Qw=;
  b=R/5m0FP7RNKpuNmV/BO6xLM8d/9LK8J9eCxl0PSkgsOvC88aKI8KuOpe
   ZOBqzEMbScMXWpnoLT785oRJ31a9qzzKPJffwnEiCp/3DNOU37u5cBGWB
   6jVhc143xZ/IWX6rsUEsizXoSdntb+AHXYqzaHqdyo3Z9kyphaPbys9k7
   E=;
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
X-IronPort-AV: E=Sophos;i="5.99,197,1677538800"; 
   d="scan'208";a="103170654"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Apr 2023 21:10:48 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 090EEE0B0D; Fri, 14 Apr 2023 21:10:49 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E8857E0171
	for <cocci@sympa.inria.fr>; Fri, 14 Apr 2023 21:10:43 +0200 (CEST)
IronPort-SDR: 6439a533_rdo4x2SpdBbmUs6zX3MQGeFBgJcEYWe1QBgVs2UqReQN45K
 CCf0a/OeqAeArs3FA/hFw0ubX3x/6bxKwQdARfg==
X-IPAS-Result: =?us-ascii?q?A0FTAACvozlkhwwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0FAQELAYItgUsvBAtGhFORAi4DhDCFdYE5jCWEA4FWgUA+DwEDAQ1BAQIEA?=
 =?us-ascii?q?QEDBDiBU4J0AoU8Ah0HAQQyBw4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBA?=
 =?us-ascii?q?QIEBQECEAEBARoJFwcOEAUihWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBARICRz4DAyMEGQEBESYBDx8GAiYCAlcGAQwGAgEBgnqCKAEDMQeua?=
 =?us-ascii?q?n8zgQGCCAEBBpwLHywiVIFeCYEULQGNCoQwJw+BVUSBFSeCU2+EC4QUgmeRb?=
 =?us-ascii?q?YhlgTR2gSAOgTyBBAIJAhFrgRAIaoF5QAINZAsOb4FJY0yBewQCFEQOGCUED?=
 =?us-ascii?q?gMZKx1AAgELOzo/NQYDCyAGVmsCCSMREwUDCxUqRwQIOAYbNBECCA8SDyxED?=
 =?us-ascii?q?EI3MxMGXAEpCw4RA06BRwSBCYEBBgEmJJ4qcgENRTtMgh0NkjudApN+NAeCK?=
 =?us-ascii?q?4FWgVkMnw0GEy+XCQ4GkiQBLpdHIKd/gWoGLYFcMxokgzZPAxkPjiAZHoNuj?=
 =?us-ascii?q?0g/ND0CBwEKAQEDCYVGAQGDJIJZAQE?=
IronPort-PHdr: A9a23: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
 /Qg3r7ya4geZNST5g==
IronPort-Data: A9a23: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
 D3VxpE80tVdDH2kqSb/K8FXWdta+84=
IronPort-HdrOrdr: A9a23:oQgNDKPdI5t+RMBcTtqjsMiBIKoaSvp037BL7S1MoHNuA6+lfq
 yV9sjzqyWbtN9hYh0dcLm7UcHqfZqfz/9ICOIqUotKMjOHhILRFvAB0bff
X-Talos-CUID: =?us-ascii?q?9a23=3AjFAd/Glec6gN9qoRTpcjtBOhhxHXOXTh6GjUclS?=
 =?us-ascii?q?5MEZsY76KaXOa8680yNU7zg=3D=3D?=
X-Talos-MUID: 9a23:ZxJrigb1O9o19+BTqmfHmgBeCOBS6f7xLVgvrKormeSUKnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,197,1677538800"; 
   d="scan'208";a="53400168"
X-MGA-submission: =?us-ascii?q?MDEp8wMYQ2eHXzkLAHbC+f2/cSaUZfeAG8G0IZ?=
 =?us-ascii?q?fv+cULffZkmyZ9DmBLku917i4q8maGZLMHGcRfewf5Wtxxzu34dzeZD7?=
 =?us-ascii?q?4QpaLolgiZd0/b0g6Z21ab0cZt3XDUldFEFRtWaB5qJZbLlxZtgEVX57?=
 =?us-ascii?q?IWzP5tXkvR6YMAvmvvZDW95A=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 21:10:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681499441; i=markus.elfring@web.de;
	bh=/k5mLcf3PcXvyy80GatszyeTbPSBpGko03VRjcR8zaw=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=FGM2Z5JXW5hgwAvsTronox7cNROvsp0VlQWGmFWmNyIujLz/pXYhVlrrWkHnHr/SE
	 9rarwM6Znop7exYcH6wfbQIdo2kYKhogu/eaOn0A2mYx3CI+ocQ0yu3zylCTnw+NSI
	 bSyUGiALYUQih+79Ih1rKZbImO1HVYBOKHgjWBCTFok5tV427j+hoH7AwyOaDBOR/O
	 KYbHNYcQeObm8zi/jLsScsdmZb8A/7MhCE75okSqVrVl/0c6Jk7rgasdjawEq/Pg6G
	 UfZhM9x7n5qUMfIv/Km20zd4+a7vsi96sY+mhq8VKGu96fxN2TXio9DxQvRXpF+vsT
	 CTMNIZSlYRz0g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MvKbj-1qdqsa1MMT-00qxur; Fri, 14
 Apr 2023 21:10:41 +0200
Message-ID: <622ed461-059b-455f-8a7b-7200a834bdc4@web.de>
Date: Fri, 14 Apr 2023 21:10:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-media@vger.kernel.org,
 Devin Heitmueller <dheitmueller@kernellabs.com>,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ftoItQtzS+2xmqkpUDiGyVaEga6k/2Tq5OVA4z3COpVKgnq7yvZ
 RTqu5Wk/nixASz+Rm2cv8ekaiVdskTQT26o7UFnHbH8oCzmLweWRD68gZwJJtJ4DAFo+7e4
 Bgq+wLhWzsjzwVWFFHPw2+a70+DLQrElrQj1XXksZihZtFHuRCmjsrGsj+KLGP+J/+o7RMj
 Ho98KdzvxdcNrkyR7bX+Q==
UI-OutboundReport: notjunk:1;M01:P0:TaBrzo54iRY=;93CingdgtK40woxT5meTopCu1DG
 jO5OR7GkfT4nLbeY/972Uutc+dPqvuR0VJjS32pdd2TYKo76wqdmjoJYQCVdBB9bk9pYGJu1L
 HAixW7MIVEWAedICwzjSKamAneGVkcYLqJG4Tt2yOct/8EKbKjrBBfR1qgagbeWZ4kDDcJbqW
 sxpg9BSDrL4gGsgeqOdtEdz/lmgkBeCc0aUCBhAXZpbMHcJsFu5YlvAdo1UgnDxahy7V4XpsU
 A5cz669Vq5c98T8o45QgeMp36qH9dBeV+1ifwtsxpdIlMM5xcyku4lyJO9GAGptsZ13vTRLQQ
 Lm+WX1pNLF0LwD3wFI1OcVU1dpp7m9/XqM2H2WYUl0xFHsGD4w6g7SoOGdx0QEIdAXX0iwSaR
 YxGDoqbJhTlHnKg3oq7qLCu+TEFlGslLA6EOG0uysUv6fmMSzE2WqoC/xczofdYi94puGBsfz
 txZ2ME+KDHbi24k7Q+r9Ns/qjkXfLif5MYpjRLHWo0Gs1/TuEOxgs6cIUyTOtV/cCel3Pw65z
 HqHnWxSNcv6VaJWxMxdiG6mZxCqyHPy0IzAVSTzt+19U1faOP5YsindmfOjEicXEQwTvK/lZo
 sE738Q9OdQBnwlTlVi6KFWZtU/ZvO7mJ4JZUeJ9kxuDpzL+G/Z6HQ5K661ruUmei1wkAcKmVU
 Tu6oaAVW63UCodmXg39WZFumr55Klzzr/k9u3vspEoLSh8SRn4VLN+7LKAVOgh7iNVRzufCc3
 N7S7I9Bf2em8az8EokSqep+rg0wSVeVpOI8BeMWp8JgfYjWP/ttz4vIPXHWFeZ2pGnyFiCAcM
 xXhiyWhr2IO5d8ZbFdcXGAx2GoBBnQwvkAnXS18DfFY6XioYp+L6bQkoY/yw4+Ha2B4p/w14r
 jKMmvTcAtUS7p5iXHjg7cMvi39IursYF1UQqx1svMpmbUtHWlt/VnJ4Uc
Subject: [cocci] [PATCH] media: au0828: Move a variable assignment behind
 condition checks in au0828_isoc_copy()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1051
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/622ed461-059b-455f-8a7b-7200a834bdc4%40web.de>

Date: Fri, 14 Apr 2023 21:00:45 +0200

The address of a data structure member was determined before
a corresponding null pointer check in the implementation of
the function =E2=80=9Cau0828_isoc_copy=E2=80=9D.

Thus avoid the risk for undefined behaviour by moving the assignment
for the variable =E2=80=9Cvbi_dma_q=E2=80=9D behind some condition checks.

This issue was detected by using the Coccinelle software.

Fixes: 7f8eacd2162a39ca7fc1240883118a786f147ccb ("V4L/DVB: Add closed capt=
ioning support for the HVR-950q")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/media/usb/au0828/au0828-video.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/au0828/au0828-video.c b/drivers/media/usb/a=
u0828/au0828-video.c
index fd9fc43d47e0..c0c5f2ed65e3 100644
=2D-- a/drivers/media/usb/au0828/au0828-video.c
+++ b/drivers/media/usb/au0828/au0828-video.c
@@ -491,7 +491,7 @@ static inline int au0828_isoc_copy(struct au0828_dev *=
dev, struct urb *urb)
 	struct au0828_buffer    *buf;
 	struct au0828_buffer    *vbi_buf;
 	struct au0828_dmaqueue  *dma_q =3D urb->context;
-	struct au0828_dmaqueue  *vbi_dma_q =3D &dev->vbiq;
+	struct au0828_dmaqueue  *vbi_dma_q;
 	unsigned char *outp =3D NULL;
 	unsigned char *vbioutp =3D NULL;
 	int i, len =3D 0, rc =3D 1;
@@ -521,6 +521,8 @@ static inline int au0828_isoc_copy(struct au0828_dev *=
dev, struct urb *urb)
 	if (vbi_buf !=3D NULL)
 		vbioutp =3D vb2_plane_vaddr(&vbi_buf->vb.vb2_buf, 0);

+	vbi_dma_q =3D &dev->vbiq;
+
 	for (i =3D 0; i < urb->number_of_packets; i++) {
 		int status =3D urb->iso_frame_desc[i].status;

=2D-
2.40.0

