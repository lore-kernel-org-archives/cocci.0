Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 583F1C6FD18
	for <cocci@archiver.kernel.org>; Tue, 18 Apr 2023 17:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=L79qqJu3hulCY5VGSzp+j0TaSRNJ+xZh7XyRxjZbTa0=;
  b=HK2x5ipEk++xKCOj411kWkoLMb3W/yjo24qfxEGi6hlBwmtt1uUo/yvg
   QbtSHzn1aPXwmEollUe6WJgrSMBP+aqj+KVXkBOxqZDFiVWwXEzlr9LPD
   REo9uW0/2RFK7N1D8ETulRx3wL+8Hqr9X7tYzfBn1lr8L6lxXhVIbWEYf
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
X-IronPort-AV: E=Sophos;i="5.99,207,1677538800"; 
   d="scan'208";a="103677721"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Apr 2023 19:46:49 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 57296E033A; Tue, 18 Apr 2023 19:46:49 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id DBE55E00A8
	for <cocci@sympa.inria.fr>; Tue, 18 Apr 2023 19:46:47 +0200 (CEST)
IronPort-SDR: 643ed788_c5u0iKEZt7wtV2LBqPa5eh9hlBKHO5T8u8Cn2QLQwHSQp7k
 Ownpv78mkBT1FIAFmD7TicuPQL4FsoZJTvQbWcg==
X-IPAS-Result: =?us-ascii?q?A0GoAwA+1z5khwsR49RaHgEBCxIMQIFEC4IugUsvBAtGh?=
 =?us-ascii?q?FORBTGEMIcukCiBVoFAPg8BAwENQQECBAEBAwQ4hEcChTwCHQcBBDEIDgECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFAQIQAQEBGgkXBw4QBSKFaA2CN?=
 =?us-ascii?q?ykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEgJHPgMDIwQZAQERJgEPH?=
 =?us-ascii?q?wYCJgICVwYBDAYCAQGCeoIoAQMxB6wvfzOBAYIIAQEGgmOZKB8sIlSBXgmBF?=
 =?us-ascii?q?C2NEYM2eicPgVVEgTwMgQmCLYgfgmeaaYE0doEgDoE8gQQCCQIRa4EQCGqBe?=
 =?us-ascii?q?UACDWQLDnGBSWNMgXsEAhREDhgGDiUEDgMZKx1AAgELOzo9NQYDCx8GVmsCC?=
 =?us-ascii?q?SMREwUDCxUqRwQIOAYbNBECCA8SDyxEDEI3MxMGXAEpCw4RA06BRwSBC3wKB?=
 =?us-ascii?q?gEmJJ8xgQ5DgjPDPjQHgiuBVoFZDJ8NBhMvlwkOBpIll3cgp3+BZQM1gVwzG?=
 =?us-ascii?q?iSDNk8DGQ+OIBmEDI9IPzQ9AgcLAQEDCYVGAQGFfQEB?=
IronPort-PHdr: A9a23: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
 sNmol5zUVsoCrUFB04jENFQeP9K
IronPort-Data: A9a23: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
 Yl2x0Ac9SRdDn2kqSj/KxB7bSpaKivm+081
IronPort-HdrOrdr: A9a23:HpF7HK7szDSK2QIc1wPXwBzXdLJyesId70hD6qm+c20wTiXqrb
 HMoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhX4tKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkYNDSaNzhHZKjBkWyFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: =?us-ascii?q?9a23=3AOF13jGghMaNi1Jm9bfyX9zS4nTJuTkbdz1L5DR6?=
 =?us-ascii?q?DUThUaP68VlnI+ZJNnJ87?=
X-Talos-MUID: 9a23:Wq2LzQRhNgA6fLGDRXTyuSF7aPpRvZ/yS2kxqqVa4fWfJAtZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,207,1677538800"; 
   d="scan'208";a="103677720"
X-MGA-submission: =?us-ascii?q?MDEf7gy4VvHBMb2Ot5IBE7hs4kVbRtpY64Iq2/?=
 =?us-ascii?q?qCdpYut5p7KxdKaL3DOgDvqTXoSaBrSXeLaHeqp1NcMdd+wFP4n190YS?=
 =?us-ascii?q?6Xq2cRbT1DO8bxAHq81dI5INkDSQF6U5vIqDImL++IkjCBKD48tVZvJg?=
 =?us-ascii?q?ZETSBJm4SpSUx+5TeQu5sllQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 19:46:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681840007; i=markus.elfring@web.de;
	bh=+AKsDaCi07+Mwzo+q6MfjF7GsVw0I3JjOS68skkZnfQ=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=JuQizrlXzrKU/cGg8U7V5n2aZtDlFutY0JRSWVSetJkBiBto6/FfTSIKmRfXKSoqD
	 IaOZxe6yGcjkSFZLH60dY3B5Nj86+l7SgLPSPQWk0cNNaQWUyfmML3KlnflEfB/1bS
	 G23nHSHn0kNs3G0I242w5FuPrgOaPRFIZNRtgPAlndi0TiG4khjcoJ1ByjTPJK3Ck4
	 xz+ir5BTljaoQu2yKaYhWWli/Ck+aFIOAf1wTNqA91cRyMM/1hsgSg2jvUG4VWNULb
	 B7uVc1X/xNyG+GzeoKhoMuwCySxUvr6b/b0x8gvj9pdR5q3nxXl9l0WbRuNKMoUhU2
	 lIfJa+CBT2QCw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MUU6E-1pxasA3hS4-00Qjtl; Tue, 18
 Apr 2023 19:46:46 +0200
Message-ID: <b6ad0941-f38e-b95d-6428-ed749ebfdb00@web.de>
Date: Tue, 18 Apr 2023 19:46:46 +0200
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
X-Provags-ID: V03:K1:rDOvoM8Wkk1sbCpjSzfdXAl8EV0zrOu6AR+UrZowo7OkQvuFMMY
 B7eb6qlsaPe6B1iuPCjdYqTs/9Uoy5E0Ym6O2IZsB7BqaK9XYzchjw4vVvyiaKBukbGJvwy
 wyReIKfe+C0Y5HhvenzQj2Ajc6BWGLDjSQ0pSjCN/uZnEmylA+sGXviZyehZsGl9ge4I1lt
 1NP4wpQ3jOY7aVkhYK+Uw==
UI-OutboundReport: notjunk:1;M01:P0:2qnmA2PaRm8=;GkbI5ta7EvY9R3z131af8SoAkXj
 IhvW9H4fDSvrwkIxddeprgJq9Omxmu6yjUDR4p5tf+SPEUzzxI0zolDkqVBMFyt3xhVv+oxiK
 7czCu3AEX24kzS5BC6n+p6pJNKKLv2gBypGVbLi9Bm6KUvyv7LZmElL9HwrI2osxijXF3493M
 kv5ayv50xAP1gOuu3CUVRkQiHoPRkB546skDtycmeJFkG0QY4gBceIe1AFgCJNc4DtbvFLMtw
 Kmo0zv+ZRAAS7FTxg7afRiz2MHj2CI8DudV13OjOHFoyk/QBUJusUDdp9cwF8VkG20pJPwhVH
 u/aPl6q34SaPq68y8JowOIxUmZ7cgXzKEx1kVYd586F7rSZJBnfYarGLlELuuXIDyuIi7EO7+
 nLmlWCgNHG8f6Nn7pOUB9v20Ll6fXuHXjA7Axe/6EEXie1f09himyL87ZbiDM9lgAh1Iohi+z
 QNxMS/knLRhZvwEumPePRFtR11SvKNc3DR5ZZKiRKJuJmZBo5epv9wMZAwQWeTJpeWm/Jawxo
 uj8umhKSDC+OaC2rGO6jdzJQ4HFrFPZhaX1Fy1RLV4vPsbuKk9LUPRmTpynUQWwZrWc25Rdkd
 prAX0cVbx5DTP+GYLRB+5jPwCW47KzWGcSdU0jkHd1AY+h4isAgCTXEuo+JFcQJ0n71ydHJTf
 q+qtHEOMntYID2ysuK7Yh7CXsm307gRyVXxNCsP3Qs6GVtU55hmfaQ8t1LkUjopuzEmcV6YxJ
 Wiw63RKtmWn9RSIOKTOW0RclYs2aik51gMfI2RzQtIdAKiKYdrwsjFZ2uPUHFWBLZsZjLav5R
 7q4j/iRKcLbU1HOxYVm/IbJOtEEghO5fHPvXdUA9dPIdctA3iLZDuSPuYFrkUUCJj9mBY01pN
 sAkBp+SJ/25EaMkiAdcDkZiFFfQWUXYA17ohJyL2lbgZr+pqhtLVax7Jp
Subject: [cocci] [PATCH v2 3/4] media: adv7604: Improve three size
 determinations
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1091
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/b6ad0941-f38e-b95d-6428-ed749ebfdb00%40web.de>

Date: Tue, 18 Apr 2023 18:45:22 +0200

Replace the specification of data structures by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/media/i2c/adv7604.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/adv7604.c b/drivers/media/i2c/adv7604.c
index 1f743b89f31b..4d0df7f325db 100644
=2D-- a/drivers/media/i2c/adv7604.c
+++ b/drivers/media/i2c/adv7604.c
@@ -1464,7 +1464,7 @@ static int read_stdi(struct v4l2_subdev *sd, struct =
stdi_readback *stdi)

 	if (stdi->lcf < 239 || stdi->bl < 8 || stdi->bl =3D=3D 0x3fff) {
 		v4l2_dbg(2, debug, sd, "%s: invalid signal\n", __func__);
-		memset(stdi, 0, sizeof(struct stdi_readback));
+		memset(stdi, 0, sizeof(*stdi));
 		return -1;
 	}

@@ -1565,7 +1565,7 @@ static int adv76xx_query_dv_timings(struct v4l2_subd=
ev *sd,
 	struct v4l2_bt_timings *bt;
 	struct stdi_readback stdi;

-	memset(timings, 0, sizeof(struct v4l2_dv_timings));
+	memset(timings, 0, sizeof(*timings));

 	if (no_signal(sd)) {
 		state->restart_stdi_once =3D true;
@@ -1668,7 +1668,7 @@ static int adv76xx_query_dv_timings(struct v4l2_subd=
ev *sd,

 	if (no_signal(sd)) {
 		v4l2_dbg(1, debug, sd, "%s: signal lost during readout\n", __func__);
-		memset(timings, 0, sizeof(struct v4l2_dv_timings));
+		memset(timings, 0, sizeof(*timings));
 		return -ENOLINK;
 	}

=2D-
2.40.0

