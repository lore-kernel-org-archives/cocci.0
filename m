Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B70C77B75
	for <cocci@archiver.kernel.org>; Tue, 18 Apr 2023 17:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=MDv5e5WAXuubz3XZZk6f4wf/ZpGCTxeLvYq/42W004Y=;
  b=fB0ypGOpLSbc0tVD1nNDq9+ndF0XYdB+cHfFC5i1tOEaEZBJa1aWJFLr
   kL+lulYSH88GiwylLvv2ll7KvYRQ4pd2FgjHC+v4cZRDs1v2aFfUfIa+r
   JaET66BuM/KXObA1wB2HtFCVFwDG00KDmeZ7LoD3wYjp5nG00WqSIKV2f
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
X-IronPort-AV: E=Sophos;i="5.99,207,1677538800"; 
   d="scan'208";a="103677619"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Apr 2023 19:45:20 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8EC30E0298; Tue, 18 Apr 2023 19:45:20 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E6493E00A8
	for <cocci@sympa.inria.fr>; Tue, 18 Apr 2023 19:45:15 +0200 (CEST)
IronPort-SDR: 643ed72b_GoaOagE2UrdkTTFdyk+/VKBnV8Py+bolBEEsV7mKbEkEsWd
 HuAsmzW3Z5B5zst2RlTPuLhXQQu1rsyE5pB5iKQ==
X-IPAS-Result: =?us-ascii?q?A0HkAAAw1j5khwwR49RSCBsBAQEBAQEBAQUBAQESAQEBA?=
 =?us-ascii?q?wMBAQFAgU+CLoFLLwQLRoRTkQUxhDCHLoc+hGeEA4MWPg8BAwENQQECBAEBA?=
 =?us-ascii?q?wQ4hEcChTwCHQcBBDQTAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAUBA?=
 =?us-ascii?q?hABAQEaCRcHDhAFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QESAkc+AwMjBBkBAREmAQ8fBgIfBwICVwYBDAYCAQGCeoIoAQMxB6wvfzOBA?=
 =?us-ascii?q?YIIAQEGnAsfLCJUgV4JgRQtjRGDNnonD4FVRIEVJwyBCYIthAsShAKCZ5ppg?=
 =?us-ascii?q?TR2gSAOgTyBBAIJAhFrgRAIaoF5QAINZAsOcYFJY0yBewQCFEQOGAYOJQQOA?=
 =?us-ascii?q?xkrHUACAQs7Oj01BgMLHwZWawIJIxETBQMLFSpHBAg4Bhs0EQIIDxIPLEQMQ?=
 =?us-ascii?q?jczEwZcASkLDhEDToFHBIELfAoGASYknzGBDoJ2wz40B4IrgVaBWQyfDQYTL?=
 =?us-ascii?q?5cJDgaSJS6HMpAXIKd/gXojgVwzGiSDNk8DGQ+OIBkeg26PSD80PQIHAQoBA?=
 =?us-ascii?q?QMJhUYBAYMkglkBAQ?=
IronPort-PHdr: A9a23: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
 5cEDLNWBgRd/hYyFUlvWtAPcs8fYw==
IronPort-Data: A9a23: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
 D3VxpE80tVdDH2kqSb/K8FXWdta+84=
IronPort-HdrOrdr: A9a23:GFXBraEJwnKeIbL9pLqEx8eALOsnbusQ8zAXPiFKOH5om6mj/a
 2TdZsguSMc5Ax/ZJhYo6HkBEDYewK5yXcX2/hzAV7BZmjbUQKTRekI0WKF+UyHJ8SUzI5gPM
 lbHZSWR+eAamSTfqzBkXCF+q4bsaO6GVeT9JrjJ88Gd3AQV0jI1XYANjqm
X-Talos-CUID: 9a23:NWa4n2zGGKpJs5ADW1+IBgULN8Ebfm3+8k3ZGEmbEmoqdqGeSH25rfY=
X-Talos-MUID: 9a23:V5hizwlq+zaiEsGizHGSdnpuL8xL4I+1JXwymJEYgteKbBRUYiu02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,207,1677538800"; 
   d="scan'208";a="53689712"
X-MGA-submission: =?us-ascii?q?MDFqj+GXcdeeVUe2oRl0jRcrzGPqK+4AjwVO/v?=
 =?us-ascii?q?wtZ82znXyIAJTzqjz3vZv92RjR1cneJbZUjcRJZkRlEapmB1JD1OZmN+?=
 =?us-ascii?q?KH/4SUK10Gw3LZc11bEbfsaWLn2uRf0FHwyyJ0YXb1xPvIAZHGsDdr+R?=
 =?us-ascii?q?lNfBP89dUD+Ik5AozPrXc77Q=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 19:45:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681839915; i=markus.elfring@web.de;
	bh=s4LhqrWCxFPT8xFhEc126ghULGfH2snipwUVNEaQBXg=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=ak8NRoRmzge/WgL5P13drhG442zAVeUwWu6x04Z7LWJwtLrP77ZUgBUFuAFYvGdk0
	 NWvxoOAt96URrCRXLcVNFDRPDY8yggL78+qiYcCnjPHSPhv0c5Z31tDKKVOvi70wFz
	 TALGbcO3nMASX2J1o59uLyidAo5nDVYtRIkauHZMvTv6lUbyDMdD4Wc/89tYGgwx/9
	 zDFYe5dqkveSuiNNBFsAUgbswZi2HNGp90qogd3TT30CAm+S8fIWnI5nbCiHnTNPLR
	 OR40qwKR9xYfGbzOogLzsDy74kqcpTXgrbM2U+ymM4kemuwzm3UrAFZULmJwBD+JID
	 64hmZaETRBkDQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N7xeb-1qRxVY0EBH-014hgf; Tue, 18
 Apr 2023 19:45:15 +0200
Message-ID: <69e9d2b7-5b8f-6796-0a96-6ec9f6b41667@web.de>
Date: Tue, 18 Apr 2023 19:45:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-media@vger.kernel.org,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <aa9d02cd-6178-036d-a785-c8d886dccacd@web.de>
 <6ba017ab-2d9d-623d-9b55-917d89bc7708@web.de>
In-Reply-To: <6ba017ab-2d9d-623d-9b55-917d89bc7708@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7jf7eOPsgNjCbvcwXV5e0QXz82FqHPCv7aVU0xosRLRIPnJoCVP
 8sxya6rwKeBVJGBINrGrow6wKP6fT9XxRSsru19AmOaGX15qEUGDUy/Io0LTQZmCkP8RFQq
 I1kyaJBJ3v3xyVv9MgMYdPe1Ra2NXoStdv0dJwOso2fMAiriSKMqszOz5FAlSCbua4+9epT
 KFD705hADNcuif5WXTvEw==
UI-OutboundReport: notjunk:1;M01:P0:nQKyKx6dtyY=;h73QdzIoAEgQlDIWrqzPOJJQd1W
 sjlTr1cznE6bg/vgQpCMA8YR+Et81H+390Rds3ZV2338CYt/DMyQP1iyfQn2xiO5ioYK52hMp
 yOdR62WDY5PwEvfLQ8Nweal1PC3cCUZReROf1vdOQuVDPG8fAsNdxyxHpHImxpfXDXlh+bMvN
 Um+S75P3qGjE94i5R8sHPx8h5VkT90pHovlDN5nDH2qvxb0ukqX5ezafatu8ToP2p0RK0mfm2
 1mavHm+Y42y+C1+y5/ucRqcET1clPCg3DOEA/710Yh1B+qHB8zCRhtzYEpCzMxoGkO5mZUTy/
 sDx8B+x9feQ7vjA8jQav+IyK6F4zA0m0UerKX8LmfDPQWetn2MXFRTSSfE8G994GWH1Yr+N4B
 1xsf+y3ex8TYcFdEJbwU39D275jkBp7dffLQcfGWlI8ORSVW0rWjT3Tcs2a4y5NnVLWI/H2gW
 eBFn+lOY/L7sQsjqDSdtwy+wyizr87WEolOl614/IrsI//q9AKL6bQmPdnFnq75aNlIvVrl5V
 9cvQCcxfAOYBWvo1cjQjwxQSZBiYZ4lsq3sNjEMOtMx3mWuBrqs1wAwqZC5yAAtE7SwBmcPri
 +hfcvtiMS/Raz+DKb/pabymRhCOgURp+HuFatvk/tUQsQGMlWyePqQ/69AzIrFG3AW4nyqxqV
 klSzt8iAYiJ+Sxqgr9u3MUyNACGabQtsfB9R5vcCNebMq6odg6oDFsjbEqWl2t/QXXj44DI1n
 OvYjxV4ZwHd8NI9EW0TQ3cwugOO1dmw5BuVPNGyaYyn5KY78gyp9gqMJHkd+KCR7p7oocyMy2
 PdNrKM8M8REdCM4qRZVXo4QMm/x7WMiGZZu0SyoE9O2SGJS1JSGGFWL2+MfnBuQcOhcormyXq
 jDl9s+mzbkBl/UjGQCSDscaEoJJdTToz7EZdFT6+IYLUkf15+pMGxQVWS
Subject: [cocci] [PATCH v2 2/4] media: adv7604: Move a variable assignment
 behind condition checks in adv76xx_query_dv_timings()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1090
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/69e9d2b7-5b8f-6796-0a96-6ec9f6b41667%40web.de>

Date: Tue, 18 Apr 2023 18:30:41 +0200

Convert the explicit initialisation of the local variable =E2=80=9Cbt=E2=
=80=9D
at the beginning to an assignment statement directly before
the source code place where this pointer is used.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/media/i2c/adv7604.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/adv7604.c b/drivers/media/i2c/adv7604.c
index d92a681f9176..1f743b89f31b 100644
=2D-- a/drivers/media/i2c/adv7604.c
+++ b/drivers/media/i2c/adv7604.c
@@ -1562,7 +1562,7 @@ static int adv76xx_query_dv_timings(struct v4l2_subd=
ev *sd,
 {
 	struct adv76xx_state *state =3D to_state(sd);
 	const struct adv76xx_chip_info *info =3D state->info;
-	struct v4l2_bt_timings *bt =3D &timings->bt;
+	struct v4l2_bt_timings *bt;
 	struct stdi_readback stdi;

 	memset(timings, 0, sizeof(struct v4l2_dv_timings));
@@ -1578,6 +1578,8 @@ static int adv76xx_query_dv_timings(struct v4l2_subd=
ev *sd,
 		v4l2_dbg(1, debug, sd, "%s: STDI/SSPD not locked\n", __func__);
 		return -ENOLINK;
 	}
+
+	bt =3D &timings->bt;
 	bt->interlaced =3D stdi.interlaced ?
 		V4L2_DV_INTERLACED : V4L2_DV_PROGRESSIVE;

=2D-
2.40.0

