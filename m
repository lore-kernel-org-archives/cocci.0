Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B7D4C46CD4
	for <cocci@archiver.kernel.org>; Wed, 27 Dec 2023 14:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=M9PtoZboLCxyWg0de68eF9tWTsdIodn+PL4vJ4imMvo=;
  b=hqyBMs//dxO3QWkVxKbxaKgXiGyykd0F1gkWIVm0U+9O4ZJkiVKZmXU9
   +7C3caJtYPj/zgCYBDshCsMEbKkHvhecIvuPuxTG+4KVZXagQ9s/f57on
   aCi0Inhacyvjdfx7/OMuKy1SGP7J6xHfMBF+DJfZoPgNTqdfRdpYhzXfq
   E=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail02.safebrands.com ip4:128.93.142.0/24
  ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:89.107.174.7 mx
  ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,309,1695679200"; 
   d="scan'208";a="144142123"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Dec 2023 15:45:34 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 90ED8E0CCE; Wed, 27 Dec 2023 15:45:34 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8DC44E004E
	for <cocci@sympa.inria.fr>; Wed, 27 Dec 2023 15:45:28 +0100 (CET)
IronPort-SDR: 658c3888_8YeQ1Tl0qrGKNYGRhUvoI5JNWu/xC8u+WQrXBVnvIxCe+0p
 kcHOXUS5G7CIakV1ZaD323CEdORu7bjhIYNrGvw==
X-IPAS-Result: =?us-ascii?q?A0EHAAA+N4xlew4P49RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE7BQEBAQELAYI4f1MyBAtIhFOIHYckgXUtA4Q7hzWHTIhvg?=
 =?us-ascii?q?VaBQD4PAQMBDUEBAgQBAQMEOIFTgnQChzYCHgcBBDAJDgECBAEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEIAQEFAQEBAgEBAgQGAQIQAQEkGAYOBQsnhWwNglwBEIEMgR4BAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEXAkdCAwMjBBkBAREmAQ8fAQUCJgICVgYBEgIBAYJ8g?=
 =?us-ascii?q?isBAzEHrjt/M4EBggoBAQaCZqxyHywiVoFgCYEaLgGIGgGFZ4NBeicPgVVEg?=
 =?us-ascii?q?TwLgzaECoQUgmiDZoU2BzKCHINPkVZ9BUFwGwMHA38PKwcEMCIGCRQtIwZQB?=
 =?us-ascii?q?CghCRMSQIFfgVIKgQE/Dw4Rgj4iAj02GUiCWBUMNARGdRAqBBQXgQ5uGxIeN?=
 =?us-ascii?q?xEQBRINAwh0HQIRIzwDBQMEMwoSDQshBVYDQgZJCwMCGgUDAwSBMAUNGgIQL?=
 =?us-ascii?q?CcDAxJJAhAUAzsDAwYDCjEDMFVEDE8DbB8yCTwPDBoCGx4NJyMCLEIDEQUQA?=
 =?us-ascii?q?hYDJBYENBEJCygDLAY7AhIMBgYJXSYHDwkEJQMIBAMrKQMjdBEDBAoDFAcLB?=
 =?us-ascii?q?1IDGSsdQAIBC209NQYDCxsGPgKmRgdTKBNMJoIEsECUQTQHgjSBYIFhDJ8rB?=
 =?us-ascii?q?hMvlyYOBpJULodQkE8gqEaBYzqBXDMaJIM2TwMZD44gDBYWg3OPR0A1OwIHC?=
 =?us-ascii?q?wEBAwmFRgEBgyY0gUYBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:pDPYiq5+E2raQDzUggPXwBzXdLJyesId70hD6qm+c20wTiXqrb
 HMoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhX4tKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkYNDSaNzhHZKjBkWyFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: =?us-ascii?q?9a23=3Anh2/pmsq5OZEHg222dFyj1by6It1Xn+HlSfZGna?=
 =?us-ascii?q?xDF1sd5GUFl+X1axNxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3ARJw9GgzAQSnxXlDc6JPzb1pG0yCaqKH3OnwGrck?=
 =?us-ascii?q?XguOZLBJNKzq8kgmHU4Byfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,309,1695679200"; 
   d="scan'208";a="75412410"
X-MGA-submission: =?us-ascii?q?MDFqBkg67PjEgjQFiYPnteOO5Yd8i42IcCs03Z?=
 =?us-ascii?q?NIpjgB3OHWzpz1C7SmbeB68LRGcY+itgS+iNJdsAb505EuIr3F8Q1ynU?=
 =?us-ascii?q?wMlTFohnlFT/jkVyPLEBinszl3sB8Be0yBUWzsQ5Z8+zYT7oaMHtBCOn?=
 =?us-ascii?q?EfkY4kUFhq0LtWBTriHrIyfA=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 15:45:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703688317; x=1704293117; i=markus.elfring@web.de;
	bh=t84TSl+EluuPPFuJEer5T9HrQmpz9O6xB+/yns+xpbg=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=H/m2q2Kb4PMC5SWfgWh4y4kWC1MkytkybccUGoogQu06U4j8fAwIBnZ2sg28HD28
	 Rry7HheBp8jVcB8aTAfBgqAlYxIFLOjEil5Jyn4jynQJWHjWZ5D7mzjvypV3Zbeb2
	 muVERTBMDAtTQ9CtIuWNCcBXbJxtBAZFJrQCp8Z6svtTKI3+cmRptxaWjEqK6sBot
	 AVdbVW+T0lWyUDntX9U2rVd3mNrYD9O86cB8oSn76sfUfsai1LaxxCmvBz1JwNv4s
	 sgmJb7nrkD8phbu8Fxg0n4xN5Zi8Y3hMBiLBDoK9akN5GaY1ZY0mlOsCmzc0Rgdes
	 CrSAV/zXrqnPYeNs7Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MDe2F-1rR0020xc7-00AbzV; Wed, 27
 Dec 2023 15:45:17 +0100
Message-ID: <56d92e42-db9e-4767-bcb1-9686bdf34a03@web.de>
Date: Wed, 27 Dec 2023 15:45:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-mtd@lists.infradead.org, kernel-janitors@vger.kernel.org,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <74183091-4c8d-4c92-b3f9-cebaacb41efd@web.de>
In-Reply-To: <74183091-4c8d-4c92-b3f9-cebaacb41efd@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DsSL0eMHaC2Rk2bw2q1D0zcazt2/fVc+/haL7c/aRJkCieBC1tt
 0AXAwa47Os+poIspl2AHdEo5Z2KI+HFZ8C+kWvuMOXzmUi04y27MTHCaZ4S63IVf3/kQf3Z
 ae89RkE7EPfLGSuhxATXgiCcaIb7MRxaSo2mNdZwiFjvT9gfysj/3ZTtLca3OMFUHxbJkBE
 0DH7shC3T+uLv9aVTo7Dw==
UI-OutboundReport: notjunk:1;M01:P0:43YQzShyX3A=;Ym3MFRhSF+BgUSwIX1xJPMjb5eg
 OrUoJO8pr+zYBSTiBAAl7M1mwf/bpo/+kf4cCjuVBVsl/YRMGD9TNV0W4T776DTorY4brh61U
 KYwd6aAmS8KQ6N02Ucm4EXPyAX4qprD66QosY55lm/+2S6Yo464UbbDVYPrtDWxqUDUJ39Q57
 bc66AUAd+5hHxQaaqoKhfO2zXFJjtUAoiIDNnVzvkz3Ip+eomd3i9vvKW6kGY8Uy9Gb6x49qy
 MYQS8cN/4ShzTEJ2+GAVbrE/y/caS6k/5+mWH3JobIXgJRy0zhCSnu0ugZmRiZhiXSapFv144
 gvF2thSS4OiixNpQjohoLsCBC/mbjKUwuODFmhUuRIg99GU1rQFCR0rj4WwdoGTdJqW37lcVZ
 MmP2uhpY9YMS0K6ifMVQAEOMS+LThmtvMZJLzQM9vwiAEcIBLo+cg0pqUJIsqu2lVj3o6NbHY
 BED9msOL9wWM21z4YBe8QV1RrOXlKAgUidWGjFLG1u5nfCKa2xkxjQozsXWIxLMlCNiZZgI7J
 yg55oNgrWQwEvLI1AjX3svQ5dYFxK1uFQD8FwcsK17HX4WEIpBD4d9U8lAtPflEgVwx0ltuJW
 gznDq6fOUGvIRQ1gOfhLH0F04ZQSXmHGlFrRpoflaO9d6XAb1aQGPARd+diDnTko8kFeTbOZO
 IVwoLEvvuy2dW0DYQm+G8rAJYEXiGXnAWY+PtGBROxQcVlIPEqo1R4Kko2PjP7hZrU12FsrAK
 X6iTVqHqbRM900sJZBork0oNaiktsUPFW8ct62gnKrMU7/XSTB5UYZhmDScxQyl2Oe95csP+u
 bsduiDeYiwJZvOCTKqWSHpKLfzuAM7DzxBEpMBYJTkKBLz16ibxjz2b+n7IvERUF4EycU1B+2
 kSkzyfVRW+M0GNoF12PsGlEtLixSxOW0gXe+SRa3G35q9BNoCvEVRy/V/y8tWCBRivhR4u3tB
 2TuarK8cb68v5enFWHzhNPEB5oc=
Subject: [cocci] [PATCH 1/3] mtd: ssfdc: One function call less in
 ssfdcr_add_mtd() after error detection
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1414
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/56d92e42-db9e-4767-bcb1-9686bdf34a03%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 27 Dec 2023 13:21:52 +0100

The kfree() function was called in one case by
the ssfdcr_add_mtd() function during error handling
even if the passed data structure member contained a null pointer.
This issue was detected by using the Coccinelle software.

Thus use another label.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/mtd/ssfdc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/ssfdc.c b/drivers/mtd/ssfdc.c
index 211f279a33a9..3ee8535d4515 100644
=2D-- a/drivers/mtd/ssfdc.c
+++ b/drivers/mtd/ssfdc.c
@@ -332,7 +332,7 @@ static void ssfdcr_add_mtd(struct mtd_blktrans_ops *tr=
, struct mtd_info *mtd)
 		kmalloc_array(ssfdc->map_len,
 			      sizeof(ssfdc->logic_block_map[0]), GFP_KERNEL);
 	if (!ssfdc->logic_block_map)
-		goto out_err;
+		goto out_free_ssfdc;
 	memset(ssfdc->logic_block_map, 0xff, sizeof(ssfdc->logic_block_map[0]) *
 		ssfdc->map_len);

@@ -350,6 +350,7 @@ static void ssfdcr_add_mtd(struct mtd_blktrans_ops *tr=
, struct mtd_info *mtd)

 out_err:
 	kfree(ssfdc->logic_block_map);
+out_free_ssfdc:
         kfree(ssfdc);
 }

=2D-
2.43.0

