Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE88C77B7A
	for <cocci@archiver.kernel.org>; Mon, 17 Apr 2023 17:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=VQrvPPECPRnGsRF1P5cOUG+tON+AI/8Ebq8Ijgj3wm4=;
  b=DrB+VGp2v2Cg30x8z7is+xlWu7+mGCQ7rOsmOOvCjINXzvHeQge4GD7G
   fIDokqpVYkSaMKBmR7ale9Eu/qYgoP7/M4CCVUvR3YKhZINKuSdle0HD5
   CHHkV+gcmFCZQGUmyurEJfePdV05k371UEfucHjDUYcdN4Sj7TgSAlMQZ
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
X-IronPort-AV: E=Sophos;i="5.99,204,1677538800"; 
   d="scan'208";a="103476842"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Apr 2023 19:05:19 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 86F74E033A; Mon, 17 Apr 2023 19:05:20 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 0DBCBE00A8
	for <cocci@sympa.inria.fr>; Mon, 17 Apr 2023 19:05:17 +0200 (CEST)
IronPort-SDR: 643d7c4b_blqQ6CsZghiqaDYzc6225jmU1Gkwxn4lFHm4dtyJsMJlOBw
 jmiOoPK8Lt1Vyvij4ZLJCliN/imJC7d0JSdW/tg==
X-IPAS-Result: =?us-ascii?q?A0EpAABeez1khwQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYItgUsvBAtGhFOIHohkMYQwhy6HPoRnhAOBVoFAPg8BAwENQQECB?=
 =?us-ascii?q?AEBAwQ4hEcChTwCHQcBBDAJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBA?=
 =?us-ascii?q?gQFAQIQAQEBGgkXBw4QBSKFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBEgJHPgMDIwQZAQERJgEPGQYGAiYCAlcGAQwGAgEBgnqCKAEDMQetX?=
 =?us-ascii?q?X8zgQGCCAEBBoJjmSgfLCJUgV4JgRQtAY0KgzZ6Jw+BVUSBFSeCU2+IH4Jnm?=
 =?us-ascii?q?luBNHaBIA6BPIEEAgkCEWuBEAhrgXlAAg1kCw5vgUljTIF7BAIURA4cJQQOA?=
 =?us-ascii?q?xkrHUACAQs7Oj01BgMLHwZWawIJIxETBQMLFSpHBAg4Bhw0EQIIDxIPLEQMQ?=
 =?us-ascii?q?jczEwZcASkLDhEDTYFGBIELgQEGASYknyCBDoJ2wz40B4IrgVaBWQyfDQYTL?=
 =?us-ascii?q?5cJDgaSJS6XSSCnf4FjOoFcMxokgzZPAxkPjiAMDQkVg26PSD80PQIHAQoBA?=
 =?us-ascii?q?QMJhUYBAYV9AQE?=
IronPort-PHdr: A9a23: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
 BYCh7/1f9x7Cw==
IronPort-Data: A9a23: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
 D3VxpE80tVdDH2kqSb/K8FXWdta+84=
IronPort-HdrOrdr: A9a23:GDLKOKyzGLMN3uk81FUKKrPw+L1zdoMgy1knxilNoNJuA6ilfr
 OV7ZcmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bBYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebrN5DNB7foSjjPIduoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-Talos-CUID: =?us-ascii?q?9a23=3AQEjwR2iSKBzohC6mZEj1EOVOtTJuakee80/xOU2?=
 =?us-ascii?q?EFmtqRJmxbUStxZJijJ87?=
X-Talos-MUID: 9a23:aaXSmgiezE1nlZrBO1OiXMMpF5ZUvaSXAkk0v7YosceeDyJxCRLDtWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,204,1677538800"; 
   d="scan'208";a="103476827"
X-MGA-submission: =?us-ascii?q?MDHjm6U+k+OkDPBpJBLCIM17zbXP0j7DCHSllp?=
 =?us-ascii?q?J3gO4zIovKZ1GcAezB1OtEgqF2Bv9/JO1hN72BpC8mOXprtZda5KqH8s?=
 =?us-ascii?q?vkzz3Sp2Mx9QsnkN4sHjiIVjkf2b3r6tER8NhYnRjIsPXubX+7/XLuvB?=
 =?us-ascii?q?89Lhvcmhj221ls28NM5deDNA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 19:05:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681751116; i=markus.elfring@web.de;
	bh=dAgHnL65PhpwZ0xZ/VqFXnxkditjDTzj7MsRPmt9OyQ=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=wfGtuEh3ITXEVM1aHxGY8h6wtOaghEsEB5qYr9MYpg8y0eUiItwcIW567CKF2oUzL
	 1b06uFcfHB839BRLPE6+SnZM3ZvDmFrZSoeyglpOvnwnGJewmUNLdWqTXDAYQAe8X8
	 0ry8usgWrJGdABly9CY2MkPM8gBtMyaY0TJLgaWSYroEoWOIK+yOdIXlIZoZ0ZPSy/
	 213X1jxDbo2KdK+KXC8SHPFo0TXI+HrySnoc9GiwItHEpgNrP5wwwq1i93oE1B+eKt
	 kpa2OHGBxx8BdeYStKfXAyY2H6MLMoeYFGsQ0cBWyCzyoebNGACLoB7OSKUurw84oP
	 HRW2eFcwDb1uQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Ma0PY-1prd9D3hBs-00VvuO; Mon, 17
 Apr 2023 19:05:15 +0200
Message-ID: <a4751b95-635e-5b53-ed0c-90cc1c447a28@web.de>
Date: Mon, 17 Apr 2023 19:05:15 +0200
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
X-Provags-ID: V03:K1:kZ2+Y/lH40O/wkBoxk4/IIv7Kd6pQ6VyiLEAQKUZOYPFvvra4sn
 ke6lmsHjFRn9u7bo8keSRLWJ9WhBp3sx6MRE//IpGqOSM7zCEGnuNysg6QC/ZkyKW9SC7ok
 QVDOEJJgj1mXouA20gz4o3BsFS/A62z6vXfsuzRiCPcm2kFDX9SLJ1+u2RqM3qXUqV572Iy
 tXijKnbPOh+rDBiKp7Dbw==
UI-OutboundReport: notjunk:1;M01:P0:c4IScrl5nNs=;cjREuDNqHHqkyyIMk26ry3/Ixdi
 peHSWnbF1k8XuV/n/dRLswdZ6hplqjMed/e7SZNeiSRUvXRqkNDCvdHhX++aEYYQZF/KFmYjD
 n+LfeeRt/UNtRlLUkI822mGhD5yeFJ35/RkoK7nr5Evcie3IxAkNtYjztIFn1htudVSYN73fN
 8aU/u516YT6K4hNWbhvGoQ9gzmgl0X2hvxHTqJ0n0CujtAyerj0sQwRHLeGA7aI13A8WtYyzU
 hDtNowWRSrVQ5DjcZtfZhXqB6J238G+miq6IBpuGimd0ZN8fREwGnmtvQFuSEA0eysTY1fTLa
 HcLzfCAS+Xj7VkqGDxmz06Pkh5v0ln2RgNlkOadM4gUQtZrsjKatZd94Jj0SDWv1ovZxylq6g
 552dXUZZY0P7xUFyDAIO2NU9UG43QYxfSB+k5MLSIx6Qa1o0EHVYjrBGRxydWEqYO/faQuQM7
 Oa84USUPydyR0xjtGksoezA8z56w3JI4IX/pTFYv2jXKWb1RVtC5OzqqhdWUWWFIT95TnHq2N
 XSzzBS6jzruLlRmlnMcNaYvYmgpUW5YBqGmhgBAFYBAhK5RHTFNclFns4S7Uec6xVjWnmajzs
 2wsl1Q8I0FE9FaD/yI0AwwXcCcr/VxK4/6dOquiSO8YSUcaCgV0Fhk2Z7p1a02bOUnz8EhAA1
 o6gguKPKemEWjGeCY+Tl4gMbZQaLXrMK2r9p5dnl/B6EGzCIYc4opnwfWa5sR+xVq1aaxBIo0
 pWJ+0w4cn8WG9E6CJWhC+RJRhj5qYuK1z3ihel3QKKcxw8kcC9KNUIgVJaXcU+3Iq1OfFEbHo
 Yth7D/fHGjDeL6FWxVVMpwDccd8ukX8SZBsQzsKe002freR8rNyQbKNZWDdFcOd4uxO6Jk4ta
 QD3TSuCXp+OoW0BR137gf19U4ROHnxBpIFSfTelVR3/PFzkNsNv2vs9kp
Subject: [cocci] [PATCH 3/5] media: au0828: Return a status code only as a
 constant in au0828_isoc_copy()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1079
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/a4751b95-635e-5b53-ed0c-90cc1c447a28%40web.de>

Date: Mon, 17 Apr 2023 17:06:00 +0200

* Return a status code without storing it in an intermediate variable.

* Delete the local variable =E2=80=9Crc=E2=80=9D which became unnecessary
  with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/media/usb/au0828/au0828-video.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/au0828/au0828-video.c b/drivers/media/usb/a=
u0828/au0828-video.c
index 27bb62e2b20c..448cc296f0f7 100644
=2D-- a/drivers/media/usb/au0828/au0828-video.c
+++ b/drivers/media/usb/au0828/au0828-video.c
@@ -492,7 +492,7 @@ static inline int au0828_isoc_copy(struct au0828_dev *=
dev, struct urb *urb)
 	struct au0828_buffer    *vbi_buf;
 	struct au0828_dmaqueue *dma_q, *vbi_dma_q;
 	unsigned char *outp, *vbioutp;
-	int i, len, rc =3D 1;
+	int i, len;
 	unsigned char *p;
 	unsigned char fbyte;
 	unsigned int vbi_field_size;
@@ -613,7 +613,7 @@ static inline int au0828_isoc_copy(struct au0828_dev *=
dev, struct urb *urb)
 		if (dev->vbi_read >=3D vbi_field_size && buf !=3D NULL)
 			au0828_copy_video(dev, dma_q, buf, p, outp, len);
 	}
-	return rc;
+	return 1;
 }

 void au0828_usb_v4l2_media_release(struct au0828_dev *dev)
=2D-
2.40.0

