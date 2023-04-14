Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EEE9C77B71
	for <cocci@archiver.kernel.org>; Fri, 14 Apr 2023 18:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ui38aPU8PITDpl60dWAnkxQVrreBpXSBV3p6xtYYmRs=;
  b=tVw/e3N4KMcb/D+5q+9u89lOoBn5b7m64dJ1lIDiKDq0M6ncBf5CkZJ8
   9YiEV/ssux8FtBcHAHySYkJv1VnrsW8igam8YKAnqyuzlj929tFX8nA2Z
   O7CXj1EdlbZDJ2IVUprihxuSWQZgwbCd65iHUQ294OlmGs4MAbba4yadi
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
X-IronPort-AV: E=Sophos;i="5.99,197,1677538800"; 
   d="scan'208";a="103168280"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Apr 2023 20:31:13 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 12D0DE0C55; Fri, 14 Apr 2023 20:31:14 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 17278E0171
	for <cocci@sympa.inria.fr>; Fri, 14 Apr 2023 20:31:11 +0200 (CEST)
IronPort-SDR: 64399bd4_fyFKXHaY4fs4vIhFSo/z8BMzkHA2/M7iZykJVzg/lLcXDq8
 FKxWixT2o9grO853LXk+2lgBjk138YXQn1RMqcQ==
X-IPAS-Result: =?us-ascii?q?A0E1AAAfmzlkh07ASNlaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YItgUsvBAtGhFOIHohkLgOEMIcujCWEA4FWgUA+DwEDAQ1BAQIEAQEDBDiBU?=
 =?us-ascii?q?4J0AoU9Ah0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBQECE?=
 =?us-ascii?q?AEBARgLFwcOEAUihWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RICRz4DAyMEGQEBESYBDx8GAh8HAgJXBgEMBgIBAYJ6gigBAzEHrwh/M4EBg?=
 =?us-ascii?q?ggBAQacCx8sIlSBXgmBFC0BjQqEMCcPgVVEgTyBFYIthAuEFIJnkXeIXgqBN?=
 =?us-ascii?q?HaBIA6BPIEEAgkCEWuBEAhqgXlAAg1kCw5vgUljTIF7BAIURA4YJQQOAxkrH?=
 =?us-ascii?q?UACAQs7Oj81BgMLIAZWawIJIxETBQMLFSpHBAg4Bhs0EQIIDxIPLEQMQjczE?=
 =?us-ascii?q?wZcASkLDhEDToFHBIEJgQEGASYknityAVI7TIIqkjuxADQHgiuBVoFZDJ8NB?=
 =?us-ascii?q?hMvlwkOBpIkAS6HMJAXIKd/gWM6gVwzGiSDNk8DGQ+OIAwNCRWDbo8JAT4/N?=
 =?us-ascii?q?D0CBwEKAQEDCYVGAQGDJIJZAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 d0GUIfu5egRk9iJndUQLekPhjuiO9E=
IronPort-HdrOrdr: A9a23:ZG226qgK8d27ZbnsItJwIXRQ0XBQXg4ji2hC6mlwRA09TyVXrb
 HIoB1p726WtN93YgBZpTngAtj4fZq4z/VICOYqUotKMDOW2ldAabsSi7cKoAePJ8SdzIJgPM
 5bGsASNDSzNykfsS+Q2mmF+rgbsby62ZyJwcHD0nxqUQZmUK146RxlYzzrb3GeCDMmOXIjfq
 DsnfavSgDQA0j+5amAbEU4Yw==
X-Talos-CUID: 9a23:DHrMIWPUHMgsgu5DACl2qmBXIpAfLHSNzF7qDR6aLTlRcejA
X-Talos-MUID: =?us-ascii?q?9a23=3A+j+T/w2eoT1G23VPVqKPIL5ajTUjoIeEFFtOjLo?=
 =?us-ascii?q?8n8iELhZ1CzOaizbve9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,197,1677538800"; 
   d="scan'208";a="53398330"
X-MGA-submission: =?us-ascii?q?MDH5VskryHEInc3yHO4dQbDlCrgilUGVM6abvi?=
 =?us-ascii?q?VOsL6sXNlT1q5a2wb80XsuHoeI6FDBeNbsoPRhW6aQcz4UofOulMB7jq?=
 =?us-ascii?q?KvlU2pKPha+6MLIg6jEiO6afyN9r/O2TiYM7WDhtzgkTounj4qaUKgkt?=
 =?us-ascii?q?fHtC1Q354MyxPKL/WYd+DTNA=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 20:30:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681497022; i=markus.elfring@web.de;
	bh=4THy5S1zSzl+WBFeDQSgq2WZGHTK5AmyAL0vwl6Ck5c=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=h622cmztAaAGVGdPYsd7j+2mcKuXgZm2NVYEiicB87AUVf/HDr/sYg6/CEwm9ucfM
	 6W6HOQ2U65h/bdmFxpdhbLI6YqsI9xosoYo62E9GX1qA/CwsKzDCLrkGFLBA8oNkyf
	 7xzjoVEYTfIDNP9E6jOd9Dc2wIHE6Vw/sRn6mzRQB0rnwX+EEohMdG+RYWQmKtlcT0
	 QjEWsZR9W9fbrE0tNa1osPcCuAl51YRJG3toABIhEZ8kYvrD2Vkn2UbBeSfp/5dlq/
	 TsiS34dxM3X+8w1z+BPhvkDzJqaO3GhZcy9m6naPT4Wl6nA6PsRmVUBDDeCh9TNJsq
	 tycqO0RQMVXUA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MwjJo-1qY2U80Ehu-00ySyr; Fri, 14
 Apr 2023 20:30:22 +0200
Message-ID: <b98dcc94-13f3-a6cb-f5bd-f1f8644d87d1@web.de>
Date: Fri, 14 Apr 2023 20:30:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
 Guo Zhengkui <guozhengkui@vivo.com>, Hans Verkuil
 <hverkuil-cisco@xs4all.nl>, Haowen Bai <baihaowen@meizu.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Mingjia Zhang <mingjia.zhang@mediatek.com>,
 Tiffany Lin <tiffany.lin@mediatek.com>,
 Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
 Yunfei Dong <yunfei.dong@mediatek.com>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2Yx9WQLSLdMDVajG3OxtB2qMwsC6ueaycbkN30z2vYmJGnKf0F9
 o6eB0KmGCQL7pz2RsLRFMm7I+/YbJlSUWNJkKwuotr+qmwsjFZw88uJSR1IbtlKqDbslrxu
 qM7HJxbvpcmRXvdkI/Png6qz/ujw8NPG5jt2MHLIRf4H3X59ROl6oZhzR2acSnvGwpyTfoX
 1KaUC7TMvrBwS1pQk9i2w==
UI-OutboundReport: notjunk:1;M01:P0:OAOICbMF1/w=;nFtDtiqPPaQNZHgMHXrS+LCw90r
 Zxo7ndExIT0qO4VqxPCfT42LW9RElUS2OReaQVG0DuQfSlZb1f29V8X4F+YiSi9oHtZ6Rm+py
 p638shBzq0vzN/KJ0bHPUMP6GPvEX4xZv5wUASglsfyZq/rdLdA3CvNw7MuMQUjLswQBLYTkO
 R79rMxjRhqiKlHLlEUrRHFhUYWhXzxw3CARfva1HM5wjcBVnqdpiTIIe0BRXlxpdxR7Ir6nWI
 lJd79sIXanFMF8rJ6dkzzvZCPw3lKmoHGqJfQ0MySE1sTLYeGp2TiBYr0GB2W3YlpWcmfvgQ1
 ZVk0UMYUkydvdZXn5ZxiRQprKjfPNRZG0B5CubLjzWJh5UW6khF5i6x0kgaGzQ5pvbrLxYkjx
 Tr4jZ+tuPDOLRt/duIyE33/DyzFzz54EUxeZGAtwwcGH1P8hKPBkfPcZOA5NYEF8iIJmv35FP
 r8289+UH2gOlFiNolkT9bu7AJRQ7jAAbr9j/WhP3IBh+GgyHPPoUwZ9dp9h8Wbjgexq6kj2ki
 hc8D2A/xMZ76ekZFiOSUTX9EyvN9k3blwTbBIC1uHYKENBsYfiQ15kcnRZbND5O3rR2T/zaHx
 6H8R0Vr0C0WT1iFJOzVbqsMOfCTUMf9+9Wl5NEgskp6yV9I1AXgevkFY1M9qxxo2rzL1ww/0B
 tYAXHyzCAehEkqAo16Lq1yT/xdjyDoL6S7vl3RyatJv9t9NEL58MStwk1IJ8ag/IyGfMXcN7z
 /vahBS1GrtsBx0GhUa864Tmrf/OOYvBb4wfK7EqEyyUx2rjuZ4pvFBFae0TizGamdjPkgKWpE
 7S/DbJ3ZwWXxg7Sn8Y2DRzxcNvdLcx0xZ/tAnIvBofJ4VXkphecac5k84EWhW4Le/ReVpov6F
 wvMGx0M17ydClLHrU5hPXPu4omgFK/FA1Uv/2robQDdWir+atRGBWTsa0
Subject: [cocci] [PATCH] media: mediatek: vcodec: Move a variable assignment
 behind condition checks in vdec_vp9_slice_single_decode()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1050
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/b98dcc94-13f3-a6cb-f5bd-f1f8644d87d1%40web.de>

Date: Fri, 14 Apr 2023 20:07:01 +0200

The address of a data structure member was determined before
a corresponding null pointer check in the implementation of
the function =E2=80=9Cvdec_vp9_slice_single_decode=E2=80=9D.

Thus avoid the risk for undefined behaviour by moving the assignment
for the variable =E2=80=9Cpfc=E2=80=9D behind some condition checks.

This issue was detected by using the Coccinelle software.

Fixes: b0f407c19648ae9110c932c91d6e1b9381ec0aeb ("media: mediatek: vcodec:=
 add vp9 decoder driver for mt8186")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 .../media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c  | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_=
if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
index cf16cf2807f0..22b27f7b57bf 100644
=2D-- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
@@ -1990,7 +1990,7 @@ static int vdec_vp9_slice_single_decode(void *h_vdec=
, struct mtk_vcodec_mem *bs,
 					struct vdec_fb *fb, bool *res_chg)
 {
 	struct vdec_vp9_slice_instance *instance =3D h_vdec;
-	struct vdec_vp9_slice_pfc *pfc =3D &instance->sc_pfc;
+	struct vdec_vp9_slice_pfc *pfc;
 	struct vdec_vp9_slice_vsi *vsi;
 	struct mtk_vcodec_ctx *ctx;
 	int ret;
@@ -2007,6 +2007,7 @@ static int vdec_vp9_slice_single_decode(void *h_vdec=
, struct mtk_vcodec_mem *bs,
 	if (!fb)
 		return -EBUSY;

+	pfc =3D &instance->sc_pfc;
 	vsi =3D &pfc->vsi;

 	ret =3D vdec_vp9_slice_setup_single(instance, bs, fb, pfc);
=2D-
2.40.0

