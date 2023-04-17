Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE62AC77B70
	for <cocci@archiver.kernel.org>; Mon, 17 Apr 2023 12:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=3wAUppwb1XgTB3vYZKNO4rgejlRYe2gMDz1cNcEyobE=;
  b=Q+r3tSy3lo/OSxfygcJ2xZCX9wD0JJ27RCsBhKEf1+JwQesjM5I4eeUj
   60YUU3UrIwh/7ZbEiPmEHiyv3+2ZjZc4rr9XA5tMIv28BUmAJd85UsI+V
   plbX6ODs0oDX/sbvKTEStemkootlrXR/6OgiI8xbjtTZ9FV9GLBvcOiN7
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
X-IronPort-AV: E=Sophos;i="5.99,204,1677538800"; 
   d="scan'208";a="103422197"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Apr 2023 14:42:22 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7274AE0297; Mon, 17 Apr 2023 14:42:22 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id DA91EE00A8
	for <cocci@sympa.inria.fr>; Mon, 17 Apr 2023 14:42:18 +0200 (CEST)
IronPort-SDR: 643d3eaa_6ndrqWrPD2aPcu4S7PtRaZpk6vM6cpTtCVj9FW7im6ovOUa
 JjZ9/VbKDEcEdYJYBmrmbSaz/pv0+E9kFp+jVSQ==
X-IPAS-Result: =?us-ascii?q?A0EpAAAyPj1khw4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYItdVYvBAtGhFOIHohkMYQwjmyEZ4QDgVaBQD4PAQMBDTsGAQIEA?=
 =?us-ascii?q?QEDBDiERwKFPAIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECB?=
 =?us-ascii?q?AUBAhABAQEaCRcHDhAFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQESAg06PgMDIwQZAQERJgEPGQYGAiYCAlcGAQwGAgEBgnoBgicBAzEHD?=
 =?us-ascii?q?K07fzOBAYIIAQEGgUABmkofLCJUgV4DBoEULQGNCoM2eicPgVVEgRUnDIEJg?=
 =?us-ascii?q?i2IH4JnmlaBNHaBIA6BPIEEAgkCEWuBEAhqgXlAAg1kCw5vgUljTB+BXAQCF?=
 =?us-ascii?q?EQOHSUEDgMZKx1AAgELOzo/NQYDCyAGVmsCCSMREwUDCxUqRwQIOAYbNBECC?=
 =?us-ascii?q?A8SDyxEDEI3MxMGXAEpCw4RA06BRwSBCYEBBgEmJJ8ggQ4sUIF6wz40B4Irg?=
 =?us-ascii?q?VaBWQyKDZUABhMvlwkOBpIlLocykBcgi0SBb5pMgWM6gVwzGiSDNk8DGQ+OI?=
 =?us-ascii?q?AwNCRWDboRhiigBPj80AjsCBwEKAQEDCYVGAQGDJi2CKgEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 ewjFrbM0tRdD32nqSv/JhB2vAu/+s7n+w==
IronPort-HdrOrdr: A9a23:sk1lyauIE1XfOPkJBe5uTnrA7skDotV00zEX/kB9WHVpmwKj5q
 STdYcgpHzJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniFhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfD9HZK3BgDVQfexQpeWvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-Talos-CUID: =?us-ascii?q?9a23=3A8atPq2kw8ql6lAd6d3gzBB7d7WjXOUPl116TCl+?=
 =?us-ascii?q?EMkJkFL2/E06e8px7w+M7zg=3D=3D?=
X-Talos-MUID: 9a23:VXpNQgnZ6N9p8XXdhTaRdnoyN5thzIayFntSsqRdoZW1GipxZhCk2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,204,1677538800"; 
   d="scan'208";a="53552878"
X-MGA-submission: =?us-ascii?q?MDF34RhCfaB9wV5bPkJzglDuNhFwe+OQc85zCx?=
 =?us-ascii?q?MspPObGQ3qCQfUiaMJMMF/hNNw/9Z/fGyITrnA1KSIFMy8ybjR7VHbw8?=
 =?us-ascii?q?5UTjh6NOEgktKhAvNB3XAj2giQ09QD3w3SGGCcxiQgYOZTGAVcnwhC2z?=
 =?us-ascii?q?XqX/cCnSjY8isQdB/ZCxMSHg=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 14:42:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681735321; i=markus.elfring@web.de;
	bh=/7c9gMj4NjcLvGOLI8XeYKs0UQMjflGtLvrD94aZldM=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=Yr6MzbXfXp6dUy1u9zOA1ynxGRukQ6znbHe9Xu38jlkZMWrFPs8tRDJh/MvWx5mIP
	 9nLOjvAchnSwqS9DRLdu7RZf9j6txlI5FhP8k9zaBUh2cVVkijlgjTPMn5L9pD6lQ4
	 bPRAixQJutGqTtzwBpm8ZcKsNA89Ucz7N6TQIsuMBPKpvkU/IX7QodF+r+mtCOxjHg
	 FerXX+Vfzc6sLrt+1cA8iO/so4BRGW37s3GLuszDPUnYbFo7eyAfsIhgXLoBF8EB42
	 68ctrtMoP9ASeDZUL1+k4ynlSMZGOkw5kJ7niZMjEOBT/rnScWZnFD2RA7/ZKZ4KAC
	 m0DmPmrvbNtjg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MFayw-1pYNDa3oy6-00HVAa; Mon, 17
 Apr 2023 14:42:00 +0200
Message-ID: <12efbbad-cc54-0816-c729-d9e2c81d591d@web.de>
Date: Mon, 17 Apr 2023 14:41:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>, kernel-janitors@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org, Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
 Guo Zhengkui <guozhengkui@vivo.com>, Haowen Bai <baihaowen@meizu.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Mingjia Zhang <mingjia.zhang@mediatek.com>,
 Tiffany Lin <tiffany.lin@mediatek.com>,
 Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
 Yunfei Dong <yunfei.dong@mediatek.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <b98dcc94-13f3-a6cb-f5bd-f1f8644d87d1@web.de>
 <0341924c-7f0a-28aa-eeae-f7de69ab36d8@xs4all.nl>
 <1d945069-00d3-7d9e-b783-96c368ff114b@web.de>
In-Reply-To: <1d945069-00d3-7d9e-b783-96c368ff114b@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dmpSxqFnjQJG39btpsm/kJMi8zW5CbPNG2lpTaUEWts4Tb1l5n5
 j8DBuas0b2aKLCdMHlPQ2hupkb6bMJa45EtyuOq/LUSYnyiy87LEnoHQ5CyBJ9tSGctQOxz
 VvEge1nQ6mKXNb3HjKiL/r0qjwxRRiWaOtAGOALFMxQDjR9UxTa2QFb3QokMpDdAVd7n+Uj
 CaplmyzTnzmvAJo4ifPYA==
UI-OutboundReport: notjunk:1;M01:P0:Easlr+g+S+E=;dHeKA2+2cVRkKDVnkADABh4UljX
 OnDwg80UsQK6yGs6txcyAnJMy0jlbSqmhXzJB8eHxNzpPuaPFFmoOwh1KyK/Qx+jUK/ctUr9e
 FTiCJm5dHw4JgX2KpEEROgom8M6vKcfLcsGb+U+XAgTHNctyzpHBLswx+WJLpitCK9qHMX9TQ
 fGPsppc4/TWkNr2SsU/UMbo0V92Q8inaTD5OngjfXFaaiRqrlhUOj0DTe9ptMGi9uqzSyETXS
 BiIsOfwdcC3Ym8Rw10wK2m3u2cus65xkTUUC61JHeZ8llN9j/yxoLCbcrNtdQNEuaoIfJ2cVW
 5XiyyKgAU3V6NfjovRsyK5aDn5yKQBQ61LEc6hFvLOvot/H4ocHXP9xwb4MHnC0m3ZQZg/TO4
 w3w41y1FuODY79hjubw08GrIf5qYrrgxKwqFtri10O6kCo4/M85toriF8kFcr8f90PegVYFOE
 OB+RfnqGj6TpWn3NwJc6wHj4OJJeP8TfGH1l9s6/Z0BdPIHJetNY2UOgx3lSgVcF8nkyFq6r0
 /Lz3EH2Esr5wEGyx7cErGLGH8HTxSuNWdU/7Fpi3ew+o/olKfvSqs2Mol2df2+NPPWb1N75pO
 LA/gaOOTZKG4QSNE4Zbyl+pWH82CqYDqPnKE+yzHfznvTpxObkPciaoae+TsO6dYhx339+5u3
 c+dI8LKJvJE6gI+5O10KccJTaYISUAIY8mBnYQqxie8C94y0RQK42o9b7sjlToHjVHXziCJxz
 hcOzlPDDEE+ZNVICKZH4IlmDrMjsKECoFY6MWs6Q6KJ7r1wISaBdEds2dB4SJ0qqqjsyw6RzC
 BKYiydO1Oo8McfeFZ6kc4DLCkrh94WuMO9B0fNQTg12vVzrZtzuHYegLJaLGBe3hhCUi6y/s/
 teDfBz15//6hj6Drda9DdNGtZOS1zsDg90fEUPcSkxpQcBT3SX3i/UVeh
Subject: [cocci] [PATCH 1/2] media: mediatek: vcodec: Delete null pointer
 checks in vdec_vp9_slice_single_decode()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1074
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/12efbbad-cc54-0816-c729-d9e2c81d591d%40web.de>

Date: Mon, 17 Apr 2023 13:43:31 +0200

Extra null pointer checks became unwanted for
the input parameter validation in the implementation of
the function =E2=80=9Cvdec_vp9_slice_single_decode=E2=80=9D.
Thus omit an if statement at the beginning.

Link: https://lore.kernel.org/kernel-janitors/0341924c-7f0a-28aa-eeae-f7de=
69ab36d8@xs4all.nl/
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 .../media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c   | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_=
if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
index cf16cf2807f0..8430098ed0b1 100644
=2D-- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
@@ -1995,8 +1995,6 @@ static int vdec_vp9_slice_single_decode(void *h_vdec=
, struct mtk_vcodec_mem *bs,
 	struct mtk_vcodec_ctx *ctx;
 	int ret;

-	if (!instance || !instance->ctx)
-		return -EINVAL;
 	ctx =3D instance->ctx;

 	/* bs NULL means flush decoder */
=2D-
2.40.0

