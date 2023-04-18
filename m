Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A0D9C77B76
	for <cocci@archiver.kernel.org>; Tue, 18 Apr 2023 10:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=dQjRhM/3qBpgStggiduPdTcaSzl4aokk0CSu3wA+Vpc=;
  b=aLfCiR9X17k9UzA1/psla27714VzDAU+nqgtiZR0ZLbgcQIkONyI2DU/
   PyHj0cFU6FrRPQOf27lNXGnT1E9kDrwzCLeePqsqRHC1kVznU1cbiz3i3
   y7hMsFomX1j5HhsUC6eFcwiMme7d2CkCn/gzZke4oWZPZfqhnJlMzG+8Z
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
X-IronPort-AV: E=Sophos;i="5.99,206,1677538800"; 
   d="scan'208";a="103586606"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Apr 2023 12:07:16 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 59120E0298; Tue, 18 Apr 2023 12:07:16 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 3853DE00A8
	for <cocci@sympa.inria.fr>; Tue, 18 Apr 2023 12:07:14 +0200 (CEST)
IronPort-SDR: 643e6bc0_LiA+n6Wbr5R4Uk+EvGdV3Ogv2dyH9fY9Ls04RK/dHBhcG2E
 tc6OAM3nZnTNgd7ls6tKoZ++5P4lfMJDdC8q79A==
X-IPAS-Result: =?us-ascii?q?A0EsAACIaz5khwMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYItgUsvBAtGhFOIHYhkMYQwhy6HPoRnhAOBVoFAPg8BAwENQQECB?=
 =?us-ascii?q?AEBAwQ4hEcChTwCHQcBBDAJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBA?=
 =?us-ascii?q?gQFAQIQAQEBGgkXBw4QBSKFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBEgJHPgMDIx0BAREmAQ8fBgImAgJXBgEMBgIBAYJ6gigBAzEHrCyBM?=
 =?us-ascii?q?oEBgggBAQacCx8sIlSBXgmBFC0BjQqDNnonD4FVRIE8DIM2hAuEFIJnmm6BN?=
 =?us-ascii?q?HaBIA6BPIEEAgkCEWuBEAhrgXlAAg1kCw5xgUljTIF7BAIURA4YECUEDgMZK?=
 =?us-ascii?q?x1AAgELOzo9NQYDCx8GVmsCCSMREwUDCxUqRwQIOAYcNBECCA8SDyxEDEI3M?=
 =?us-ascii?q?xMGXAEpCw4RA06BRwSBC3wKBgEmJJ81gQ6CdsM+NAeCK4FWgVkMnw0GEy+XC?=
 =?us-ascii?q?Q4GkiUuhzKQFyCnf4FjOoFcMxokgzZPAxkPjiAZHoNuj0g/ND0CBwsBAQMJh?=
 =?us-ascii?q?UYBAYMkglkBAQ?=
IronPort-PHdr: A9a23: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
 yY=
IronPort-Data: A9a23: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
 R3yN5E+0tVdAn2keArL2sGGvA==
IronPort-HdrOrdr: A9a23:KE/ZuK4plgl8kveVwAPXwBzXdLJyesId70hD6qm+c20wTiXqrb
 HMoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhX4tKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkYNDSaNzhHZKjBkWyFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: =?us-ascii?q?9a23=3AlCH1pWkFv8y4r8OAD1dL0ibRkOrXOWaN03rKCUS?=
 =?us-ascii?q?0M3RoT4HEEF2z3Y8jt/M7zg=3D=3D?=
X-Talos-MUID: 9a23:StqmewjTQBwQ5B6kPp/+XcMpEPpw2JuuUW83wbogtvaZLR1QEBGSpWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,206,1677538800"; 
   d="scan'208";a="53643088"
X-MGA-submission: =?us-ascii?q?MDGpz7scedob5/tdiBVr8TKUNajd4PfRFfb1UN?=
 =?us-ascii?q?SQlgi7sx7UDhEExDJsYOzzDdd0vbQU4Wva7qywsJHlBt4rMSJ5Vp0vmj?=
 =?us-ascii?q?c6gwHZ1ed4EJ1F3U9xpVpESpEoFHApvQW/K7BPTdq8++B7YjEnaR44km?=
 =?us-ascii?q?NHVh7cdVW9lbeJUSawJj0bpg=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 12:06:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681812413; i=markus.elfring@web.de;
	bh=Xj/YEyl5VYKkJwr5n03+IrlfSS/BXm6XzXwIAT9EU8A=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=ejbcQgU/cFpeR3k4qBQfvPDok5Ul7mp7OXGeSWsFOeT8QuqaSQsZRDA8kB95b8Zup
	 6FIiVgjpkbBt4ZTAxiZANt3x6QAUjf6fLJ+Mn/zouQMF6QE5uip7iMdoaBddWB5zdc
	 llaaCALTvudqV0rkkxRK5gFJjFn3+/a6fOTulMxNlvn5r++/GOfkT7pWeSSSiMhemz
	 4G3gm6RTikMuBqFK6ANdaGw17T90izFf96FABeA6v5GYkrPKvDSKI5/LmBbxdR3pi7
	 X5hPLnyNUX7E0lMNvIg0CEXN/wm2EtLa8YLs7Lc4S1Y03BBNVN8UOn/GOJqroQkh5T
	 mgk5qMIQacYIA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLRUV-1q5xs61fuN-00INlz; Tue, 18
 Apr 2023 12:06:53 +0200
Message-ID: <57ac4c11-1877-5a72-aea7-2a8fea32bd1f@web.de>
Date: Tue, 18 Apr 2023 12:06:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-media@vger.kernel.org,
 Hans Verkuil <hans.verkuil@cisco.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <1137fa2f-3253-0f16-aadf-69166e11bd68@web.de>
 <1a27c4c2-5e44-c399-9092-a36c12ee20bc@web.de>
In-Reply-To: <1a27c4c2-5e44-c399-9092-a36c12ee20bc@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ptn6c0NDOGKcGH0IEiJy5Bf8FyZP5uQM+IIMgNwDKKquP7GY7Sp
 17ELYAh1HLtSpfQaxVDYz5BKflyjzRFVnduNEF0/GrB2uUxoM/FR3pzDL+HWlB57bnWt5S0
 7Nd3z3Kq0JqXMxHoTxK1TEwnQOvkfPvcioeV2MmIVq0JLLNu1ZptpA6bFedPz6A5/5glwgn
 1JzFl6Jm7WI6Pw4+tzXHg==
UI-OutboundReport: notjunk:1;M01:P0:NG86wCLbGNY=;hXZWoHRehpM6YZyBSuGN3MFDraF
 iSnxM0Rr8DmCLV5VLJCvFma+XvBEDO0P3OOw35kkQjsI7L3ZvTot3bZNCh7uVK1ymQZdNYwBT
 bPXfQD0Ivxl8tYwPOFfGnAXweoGxkgTfzAUh1zsO6YAZVnIOqR1/H/4dTWY9j+sclkHvQPBb6
 htzwWS6XEfOohLjN7kYyb13zKWRCFcKFU+0cek1CIQvhHRzUqzwAv2vIgSNUlkt7Rmd2mIy9Z
 WlOqGtokxUglD/GeuHYRfDckmbsXHE05ssnxJV9mf7iAw0ONU6G7rTgyzAhbdXslNUuu9bzjs
 6opmiL/UkZKKwLW5Rk0c+rfzDEMky6AO75J+sffntRh2di69naDgad9LsuCY519Mp0NimjeZm
 RJu42U5QRcDRC+Qy4FSqkW02ZJBAg2k245gJRL3RRqdHG0Idq5hYvQRcskD/bRwcTTjsFQXx/
 vyteGGPMppRxT/+5zZU9GMRWVPQGqtnw9+QUanr2mzJ5aFAioUBEUa7jxXdv3+KjlpHIKC3wF
 rIr8LguferLhO5Jddo9Za1rsbsCxRSZSPlX/qtY3K3lppm0FkMuopCQdiweqx6tc1Jk0JZE+7
 OnraqHo3uOOXPxI4AqunmaVwxo1WYEOwT/SExytZnEslsVHd0YMArFHG4ABVAa+hJ4/HGBSPm
 KUseIUcSd4Z6UIbDEYnKpyRpXY5TnkGANSGFGCvbRDldxtL++nC+q7yfyI2L2xz0W6xq6dAVS
 XnF0laDFIo7pYKovsVb97g5ArWXj/+hnbwsDPf2mJ0/vFFGokLUOwcN5w2Mgo40n7G2Xyj0px
 YL4XGOQBpoZI4ufw2WVWkRkG3lT/96iKTc4cn1GIWYu/Gz9n5hR5IQKYF2h+KevH7JihhdH2e
 E9q1HNJ0n0Uxg9LpR5hwB+W2THLqdGKk94A68GAllXkeKGIw0YhqOZQYH
Subject: [cocci] [PATCH v2 3/3] media: adv748x: Improve a size determination
 in adv748x_hdmi_query_dv_timings()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1087
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/57ac4c11-1877-5a72-aea7-2a8fea32bd1f%40web.de>

Date: Tue, 18 Apr 2023 11:00:13 +0200

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/media/i2c/adv748x/adv748x-hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/adv748x/adv748x-hdmi.c b/drivers/media/i2c/=
adv748x/adv748x-hdmi.c
index 14ff27aabe89..13bf9983a674 100644
=2D-- a/drivers/media/i2c/adv748x/adv748x-hdmi.c
+++ b/drivers/media/i2c/adv748x/adv748x-hdmi.c
@@ -278,7 +278,7 @@ static int adv748x_hdmi_query_dv_timings(struct v4l2_s=
ubdev *sd,
 	int pixelclock;
 	int polarity;

-	memset(timings, 0, sizeof(struct v4l2_dv_timings));
+	memset(timings, 0, sizeof(*timings));

 	/*
 	 * If the pattern generator is enabled the device shall not be queried
=2D-
2.40.0

