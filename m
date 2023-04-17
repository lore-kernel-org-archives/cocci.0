Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72001C77B76
	for <cocci@archiver.kernel.org>; Mon, 17 Apr 2023 17:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=2Gx5m3hr5AmO1HS4OfrVYRPuHGaDNWM7riMlQvSoVYA=;
  b=PSz3k54lCowpgLsPmCx+ogYc2I3j3zF8gFj7KHwFk0OuAZewq77t8qrJ
   dcXbK0WJRz39gNvIkIHUC+ulJ78DuIqgCBtrwqkhyf5lb+3xYFjrFMtmo
   DeGViDjAVYkmoFJrSzjcthC3avfSgdmdHqZG+hNFRkRuxSyWr24O57uwq
   U=;
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
   d="scan'208";a="103476514"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Apr 2023 19:02:53 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 41B36E0298; Mon, 17 Apr 2023 19:02:54 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 0BF5EE00A8
	for <cocci@sympa.inria.fr>; Mon, 17 Apr 2023 19:02:50 +0200 (CEST)
IronPort-SDR: 643d7bb8_DSyDuw8K5dJXkB0CvixFW2kFyqUOj9l2NQoNMFmM5zjV8z1
 yAUSAlBEcs0peflpj4TqLvrHyLz38Zm1eRY2ydg==
X-IPAS-Result: =?us-ascii?q?A0ENAABhej1khw4P49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBOwYBAQELAYItgUsvBAtGhFOIHohkMYQwhy6MJYQDgVaBQD4PAQMBD?=
 =?us-ascii?q?UEBAgQBAQMEOIRHAoU8Ah0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBA?=
 =?us-ascii?q?QIBAQIEBQECEAEBARoJFwcOEAUihWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBARICRz4DAyMEGQEBESYBDxkGBgImAgJXBgEMBgIBAYJ6gigBA?=
 =?us-ascii?q?zEHrVx/M4EBgggBAQacCx8sIlSBXgmBFC0BjQqDNnonD4FVRIEVJ4NCiB+CZ?=
 =?us-ascii?q?5pbgTR2gSAOgTyBBAIJAhFrgRAIa4F5QAINZAsOb4FJY0yBewQCFEQOHCUED?=
 =?us-ascii?q?gMZKx1AAgELOzo9NQYDCx8GVmsCCSMREwUDCxUqRwQIOAYcNBECCA8SDyxED?=
 =?us-ascii?q?EI3MxMGXAEpCw4RA02BRgSBC4EBBgEmJJ8ggQ6CdpJpsFU0B4IrgVaBWQyfD?=
 =?us-ascii?q?QYTL5cJDgaSJS6XSSCnf4FjOoFcMxokgzZPAxkPjiAZHoNuj0g/ND0CBwsBA?=
 =?us-ascii?q?QMJhUYBAYV9AQE?=
IronPort-PHdr: A9a23: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
 /Qg3r7ya4geZNST5g==
IronPort-Data: A9a23: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
 ewjFrbM0tRdD32nqSv/JhB2vAu/+s7n+w==
IronPort-HdrOrdr: A9a23:PpdJnaGaHlPzLpGFpLqEPMeALOsnbusQ8zAXPo5KOHhom7+j5q
 OTdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/hyAV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAs9D4bbLbWSS4/yKhTWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-Talos-CUID: =?us-ascii?q?9a23=3A3raUUmvBVet6EybSNx1KM/kr6Is0clLmz1Hrc3a?=
 =?us-ascii?q?WAEhGSZOEEH3T06hNxp8=3D?=
X-Talos-MUID: 9a23:hlT0bAvss9101oRYP82nhhVCGJ9TwJWSLn9TscVXtsSeEnJTAmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,204,1677538800"; 
   d="scan'208";a="103476502"
X-MGA-submission: =?us-ascii?q?MDFIb2zXv+oIpjvF4bpdLXlpvNdJBLKeMbDqlR?=
 =?us-ascii?q?cvZz6zrIbUqs8V9qetL0bEnE9/IfEvBEZARc3ne3M/jO3dBNumCe/iug?=
 =?us-ascii?q?2m9DGncY+O0I34beborz+nhdGMCEGM4o6pa4hlMBPq2RgVHzhGI/QVqa?=
 =?us-ascii?q?NPidUblO2ZpKxKFQjhePCocw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 19:02:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681750968; i=markus.elfring@web.de;
	bh=Qn1tcYWIKyNttZ/9ZfB+zuHdLbUikBWEYe/pmtmdyRg=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=A/nX5BOzQeO0mUiedgFARUKiwmJjr050BsaplrqROkAspzOy0YrfVD78aOB4pE7Ga
	 41dv5ckMRNPW/jolFLN21DB+ZWTccE/jzh75Ky6qejvLLaPlXd1NWo45Zi+8FASgOw
	 mzQfp+X9OWaW/RGvKhrSwy2HZ2Eyrw5PeHxpiiE9wZYjoHs+6FQ66/Vvjb03C4RqlU
	 emUM+jazpFxvB3sCGcxznuPKhm2uA+5hLz7Yso3J01Mra6LZblPnOleMdzFHVzofI0
	 FO+cPqWA5dPIxLrXIIzMmhRxHSPmwvmX85YYzwUpblH56wOG2j7noZmSdjOmcOZ1T7
	 3MKFSYxUQnJ3Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M1JB0-1pmnI23JO6-002qch; Mon, 17
 Apr 2023 19:02:48 +0200
Message-ID: <b04e6753-00eb-e7ce-87d9-0a37a9329ec1@web.de>
Date: Mon, 17 Apr 2023 19:02:48 +0200
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
X-Provags-ID: V03:K1:xGThtv6DKsFAhw5rRsNqTMxeTaskCTOJ2cc9UFyMaVVQdSHl+Rv
 oEMURSOrw+r4hDPPpPJMTug72V7VZbcUkpCsPoc+nN4FkHYoMlRrAzteEU40mskULU9wXeJ
 px1PNevDZw1JgnSPo2o5OMzx2fAyroJNyWoeun6TkjxclAV1ZGuly1FqC/sRCc66VQ20IAa
 zXQHHEfkoIP7nVRsjEIng==
UI-OutboundReport: notjunk:1;M01:P0:zMkuLog/MUU=;ghAvglvsErIkEBzCD7FyBgi91s3
 RxgsMtDONe4Vaqdh1Dxq4jkrtO+sl5n2BrX26HdugVTSGvt/o8KqDjpnzpJrCluipTo3KZFDe
 HMUu0+6Rq3SEFzhgHtFCuze3V8WgZ44RRRWwzv2gVfuAgS+yvvBTj3Dx3q67qSkfI/Tpey5uo
 8nyvRT8kv6En7IOuwzNVyUqXW4EafUbpy259PflNdr6CXPLKbzS8d/SXCZXGlOWUXWVuvMLIl
 kb+O9uxWuOW5j5twINi8+Nombkao4c4HNHcLz0x6RH8V01n+RXeQiLaMmYLTvgqJunFYBHAnU
 QYepyi1tZLGywXaZzQhtaMcv72QVdoxcwgPLRTuq6C46hY6U/VUOL21i1xxD/92l5TJ/agjel
 dJsmlk+WOC3qWD5+NJ6/7wbRSJE9YRam+NjHHtKpR0c6O1l9cCkLVapoY9+HILqnontsqCrxM
 HgClOouU+9EDgepcHNooIFRI1RqEjWN6bOBOwEwgPoE98YfwvqHHXLMon17iLOAfqBHuy2sLn
 DzCEM2dQSmVZ6vyvXlFLtps7v8gHS7IZeoyU6W+ekGgrmsQ8C6x1rJ8zVweuw6ZrHmXmftxXc
 uepP+gnjP/amlcmZE3GD31mkUJeGVjUz6M5HzZhgYZz6sBG3h+j3Mze11//8SlXnMZQ8eAWP4
 7l0RsHA2a2Yu6HGumCE7DmZ+wrdI5wN49l7H0teoG0Wgwn6vy1yCu/Z61cxfYwTnNdxrGiBWB
 KylGemcv5T7ClzSJo+TgRdlXlsC9D/5vmnFETvZj44sKtVV3FI1Di+duQ4Fv673HZDx7NfEMV
 xJ+2LZArki3RizSXQxMlX4N5y+cCOJuJw3RKog+HiQ//xiRChZsNuSTFQIKTAUCzshNRWESlN
 YnYgZThwjZ6OlQZrAqHdGvQdtvGtrpXomBwXT2mr5flfolcR78mUK3z+A
Subject: [cocci] [PATCH 2/5] media: au0828: Move variable assignments behind
 condition checks in au0828_isoc_copy()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1078
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/b04e6753-00eb-e7ce-87d9-0a37a9329ec1%40web.de>

Date: Mon, 17 Apr 2023 16:47:24 +0200

Some local variables will be set to an appropriate value before usage.
Thus omit explicit initialisations at the beginning of this function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/media/usb/au0828/au0828-video.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/media/usb/au0828/au0828-video.c b/drivers/media/usb/a=
u0828/au0828-video.c
index ce25ddc7fc7b..27bb62e2b20c 100644
=2D-- a/drivers/media/usb/au0828/au0828-video.c
+++ b/drivers/media/usb/au0828/au0828-video.c
@@ -490,11 +490,9 @@ static inline int au0828_isoc_copy(struct au0828_dev =
*dev, struct urb *urb)
 {
 	struct au0828_buffer    *buf;
 	struct au0828_buffer    *vbi_buf;
-	struct au0828_dmaqueue  *dma_q =3D urb->context;
-	struct au0828_dmaqueue  *vbi_dma_q =3D &dev->vbiq;
-	unsigned char *outp =3D NULL;
-	unsigned char *vbioutp =3D NULL;
-	int i, len =3D 0, rc =3D 1;
+	struct au0828_dmaqueue *dma_q, *vbi_dma_q;
+	unsigned char *outp, *vbioutp;
+	int i, len, rc =3D 1;
 	unsigned char *p;
 	unsigned char fbyte;
 	unsigned int vbi_field_size;
@@ -511,12 +509,11 @@ static inline int au0828_isoc_copy(struct au0828_dev=
 *dev, struct urb *urb)
 	}

 	buf =3D dev->isoc_ctl.buf;
-	if (buf !=3D NULL)
-		outp =3D vb2_plane_vaddr(&buf->vb.vb2_buf, 0);
-
+	outp =3D (buf ? vb2_plane_vaddr(&buf->vb.vb2_buf, 0) : NULL);
 	vbi_buf =3D dev->isoc_ctl.vbi_buf;
-	if (vbi_buf !=3D NULL)
-		vbioutp =3D vb2_plane_vaddr(&vbi_buf->vb.vb2_buf, 0);
+	vbioutp =3D (vbi_buf ? vb2_plane_vaddr(&vbi_buf->vb.vb2_buf, 0) : NULL);
+	dma_q =3D urb->context;
+	vbi_dma_q =3D &dev->vbiq;

 	for (i =3D 0; i < urb->number_of_packets; i++) {
 		int status =3D urb->iso_frame_desc[i].status;
=2D-
2.40.0

