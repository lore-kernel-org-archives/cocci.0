Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B8E4C77B70
	for <cocci@archiver.kernel.org>; Mon, 17 Apr 2023 12:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=AdTNdfngFza79TJjlriNkVPuTF/kZATl6LItXTeXEWE=;
  b=kFOdrEy0t85H+TESMngeqihXvJLCJHN5ffZUJ8fPnM/rcvzKbsGxPuVG
   uXRYm45BMwgHN2QAau/Q03l0KoNgqLPe/2Z8htW+xAHAwIOlxYRdo//Iv
   dh6XO4+r0r7P8bNVgkhUE4JgEcnrVE2Fi3phrJH6P753tXE/+mLqxhVQP
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
   d="scan'208";a="103422636"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Apr 2023 14:44:33 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0BE3BE033B; Mon, 17 Apr 2023 14:44:34 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 73682E00A8
	for <cocci@sympa.inria.fr>; Mon, 17 Apr 2023 14:44:32 +0200 (CEST)
IronPort-SDR: 643d3f2e_ZCxtGiHY9xeF2uWEDXolpGfk9NUpDvMrlkd23oMQl8jEpKJ
 ilLFYy3T9aEkBDpsIpLFkqLgGg6Za6NAXV8Ma9g==
X-IPAS-Result: =?us-ascii?q?A0EpAACMPj1khwMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYItgUsvBAtGhFOIHohkMYQwhy6MJYQDgVaBQD4PAQMBDUEBAgQBA?=
 =?us-ascii?q?QMEOIRHAoU8Ah0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEB?=
 =?us-ascii?q?QECEAEBARoJFwcOEAUihWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBARICRz4DAyMEGQEBESYBDxkGBgIfBwICVwYBDAYCAQGCeoIoAQMxB61Hf?=
 =?us-ascii?q?zOBAYIIAQEGnAsfLCJUgV4JgRQtAY0KgzZ6Jw+BVUSBFSeBFYItiB+CZ5pWg?=
 =?us-ascii?q?TR2gSAOgTyBBAIJAhFrgRAIaoF5QAINZAsOb4FJY0yBewQCFEQOHSUEDgMZK?=
 =?us-ascii?q?x1AAgELOzo/NQYDCyAGVmsCCSMREwUDCxUqRwQIOAYbNBECCA8SDyxEDEI3M?=
 =?us-ascii?q?xMGXAEpCw4RA06BRwSBCYEBBgEmJJ8ggQ6CdsM+NAeCK4FWgVkMnw0GEy+XC?=
 =?us-ascii?q?Q4GkiUuhzKQFyCnf4FjOoFcMxokgzZPAxkPjiAMDQkVg26PCQE+PzQ9AgcBC?=
 =?us-ascii?q?gEBAwmFRgEBhX0BAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 RoiFrEc8/R/LlyFhQre2xBjvdpa+w==
IronPort-HdrOrdr: A9a23:Hi/cPaCXHvGP9ajlHel455DYdb4zR+YMi2TDGXoBLSC9Afbo9P
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkOss1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QFJSWY+eRMbEVt7ee3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-Talos-CUID: =?us-ascii?q?9a23=3AdKzz9WuZdySzoU/2AoJQgt+g6IslKCbM01rMInW?=
 =?us-ascii?q?REHlWEeO3Sk6S9vN7xp8=3D?=
X-Talos-MUID: 9a23:joZsIwSahSKZOxJaRXT0tANlBMxQ6p+JKxkgncwdh8DaMA1ZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,204,1677538800"; 
   d="scan'208";a="103422627"
X-MGA-submission: =?us-ascii?q?MDEQvrvmhP6Kvu+WdW4SfhUqDF9ecJgNrKaoQw?=
 =?us-ascii?q?2Uc3g9icbD7MeA9TrOcForOs1t1+i+X09JhRqfmZQqm/jzogRFkEb+oG?=
 =?us-ascii?q?9IXIbTclbMcviygJ/L4l1mooJmNdw6WDDqHy78wGIGxslB+3YEaELOoR?=
 =?us-ascii?q?Ig0Gcij2C2wLzgVBSUO9K8PA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 14:44:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681735456; i=markus.elfring@web.de;
	bh=qDbD7coCJdS/2vghLIEPg9MEuMfbhlibiv4/QKu/6Ko=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=KEjOgP7eoC1d5PY6UHjH1inXCHIIDZLUn/kLNZRyKkntwWD2tiVRU60xuD2DIpdOV
	 yY5871reCDzSeViBoG7BQ+JOSZC6HgiYTOGfy54QUF3fztBcQAJ/mSsG+5QK8XgL5m
	 tdAT7alHVL99YMva8SIOzkxgo5qVGYGZmXm8zdDyX5MT3mdCy450IcfMQxLlBZ6su9
	 PkJb8o8tKK9d5E0f9pLnlyFt3g+CAjGdb3KcvVpOzlqdWit+AacQoq1OGX7K1sv5X4
	 csF/On+W6fvLyD8p20o9+0AADmvIV/UVK9qehvLbimc7cM5FjX5Bl16BpcUSLbf5BM
	 e0sjeD/2hKugA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MPrPT-1q1ucW3HwR-00Mp6E; Mon, 17
 Apr 2023 14:44:15 +0200
Message-ID: <4a357fbe-4f9d-37d1-0be1-93ca754698e9@web.de>
Date: Mon, 17 Apr 2023 14:44:14 +0200
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
X-Provags-ID: V03:K1:6QuD1QlYQUklTPHI55F/pOJ74eoA08cFgoFR3pUXzqg7KkqkCGb
 vfSW0TZWJeguxYecDytyW8/z9+6AUkN6oXtchooluTt+S62j3IV+JyC86VDiFE65xtZa2Gh
 /68nhN6TfWRwWLTxgyzzmYPFt8D9Xlpyz2VTQlorBP/oo9rMUQTkqlkDuQ+26YtK0P6839A
 A1eAkYZIagDBFkTfXKAQA==
UI-OutboundReport: notjunk:1;M01:P0:CWNCASpe+a4=;1DRkwAqrwvRiACXmvTDeqvXjEmi
 oqdABA8YJZc/XMyY9mcjY4XPxroiRBLH/w3MpNK1GXPH8Sp/x/rSGZahYZm7U7Ry5c6d2YpYw
 GLC4ixDQ1QLfWFvzW6OtTHRmE/Dg5VjbocNbkIvuYprq50ytv7PlzMm07j7CrBMRtK9DQ9gAi
 T5Y4B1k5BHfTihy7o2w6NvdAIAe3nxOwBnR5aUgQjEWLFubluPSthoM4bvO1WLaaLzNKyJN5+
 Opg3KtWSABK5gvA35jorZ1SVmjXrlLn9pFJuEFmOQL20xydpD6wZlVXrKiOlJvR59+Nv/k949
 FhUtFYk6ij26La5xnOtnmLufrFWedksMGmOWDnmcoERfxvV4ObCaxm6Rx1huSnKTskEecso2G
 aNARatVRcVXOoIu15lSHBNF6pxAkctxLcbJzkkTL4Gb8vW30KVZ7eYM2Mi72E8IrTAdfQcgYC
 YohrIDyOvpYvkYbYj8Q3wF4pOrfb4QUDxAzICihFVXFQGo0CPoaAcRdaiJfo6SAf/KEhEd3Wr
 xsTaLG47SyU8PbszIs2cFP8kPJsZAuvuk/ZNimp3yIWgNLcXi7ifM/kkFYHZ29M1RyPf2YKm/
 K9TI71NA/iOFeGwPM+FL3Odn7EAUvsNj4bU1JgyHhhsbiazpT2NlqbAaxG3LDpYCRwF4PWXjo
 kk8naRv50fhphndGuElqL+ueTy56Fyw2xvkNnUXAMxhmkF879Bbey8JowItOV2B0ImhHqF4YO
 4Y1Bc0ANxy2d5q3Oewcr3+VSgM6h4msR4ayU+4jF8v1QbOxtBsrm4Rf7XHOsjOfSgB4pGtfkJ
 W4fFeUbInMnkj/H/YOVLxHvLW1rDW5ph8K4aTzZJcFyAWzrMNGuack9PIFNMW7KBAun9ZlxeJ
 lJ0eDPbY0nKn07JGThVfwaCKRewgIGmRh5F5gUESYo6rquJ0jhkT2o7xnimnS1U70JSWPYO08
 ooWviw==
Subject: [cocci] [PATCH 2/2] media: mediatek: vcodec: Move variable
 assignments behind null pointer checks in vdec_vp9_slice_single_decode()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1075
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/4a357fbe-4f9d-37d1-0be1-93ca754698e9%40web.de>

Date: Mon, 17 Apr 2023 14:19:13 +0200

The addresses which were assigned to the variables =E2=80=9Cinstance=E2=80=
=9D,
=E2=80=9Cpfc=E2=80=9D and =E2=80=9Cctx=E2=80=9D would not be used if a nul=
l pointer was passed by
the input parameter =E2=80=9Cbs=E2=80=9D.
Thus move these assignments behind corresponding pointer checks.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 .../platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c  | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_=
if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
index 8430098ed0b1..562fe07d3731 100644
=2D-- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
@@ -1989,22 +1989,23 @@ static int vdec_vp9_slice_get_param(void *h_vdec, =
enum vdec_get_param_type type,
 static int vdec_vp9_slice_single_decode(void *h_vdec, struct mtk_vcodec_m=
em *bs,
 					struct vdec_fb *fb, bool *res_chg)
 {
-	struct vdec_vp9_slice_instance *instance =3D h_vdec;
-	struct vdec_vp9_slice_pfc *pfc =3D &instance->sc_pfc;
+	struct vdec_vp9_slice_instance *instance;
+	struct vdec_vp9_slice_pfc *pfc;
 	struct vdec_vp9_slice_vsi *vsi;
 	struct mtk_vcodec_ctx *ctx;
 	int ret;

-	ctx =3D instance->ctx;
-
 	/* bs NULL means flush decoder */
 	if (!bs)
 		return vdec_vp9_slice_flush(h_vdec, bs, fb, res_chg);

+	instance =3D h_vdec;
+	ctx =3D instance->ctx;
 	fb =3D ctx->dev->vdec_pdata->get_cap_buffer(ctx);
 	if (!fb)
 		return -EBUSY;

+	pfc =3D &instance->sc_pfc;
 	vsi =3D &pfc->vsi;

 	ret =3D vdec_vp9_slice_setup_single(instance, bs, fb, pfc);
=2D-
2.40.0

