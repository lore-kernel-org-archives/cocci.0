Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71761C282CD
	for <cocci@archiver.kernel.org>; Sun,  2 Mar 2025 20:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=mGq/gU9aiLC9wUlZmOgz0EtXdzSoBZk03x6MS/EQwvY=;
  b=iYqRg9d6Zwxp0VT1QKKgezgLSwqyx1KMriVGLYJ+Gple/vcU3R/Y8yq3
   NUWQyZBJU9MJmsq8yLXwJ7iY3Q+uIqMXPAN73J2eDekRY1HekDc4UyPNZ
   FUyWi3OHASlg4QT3TjWUgx0z4YeUMQCOlXWkpkmGbh71MDwp1aLULQAjd
   w=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.13,328,1732575600"; 
   d="scan'208";a="210756582"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Mar 2025 21:57:17 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BDAE2E0264; Sun,  2 Mar 2025 21:57:16 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C4AE4E0260
	for <cocci@sympa.inria.fr>; Sun,  2 Mar 2025 21:57:14 +0100 (CET)
IronPort-SDR: 67c4c62a_qbiyV6+HbBndR8pYGm+9EzLAWeK6FeZr1ftmnGhN4ti6mgD
 904KiqaymX0S2X+xMjqSfkYKPwM8IGMhUVy6sDw==
X-IPAS-Result: =?us-ascii?q?A0FeAAChxcRngAMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDYnUzBAtIhBo8iB2HMoF0LQOEO4c7kEiBVoF+DwEDAQ1BAQIEA?=
 =?us-ascii?q?QEDBDiBVIJ0AosVAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBA?=
 =?us-ascii?q?QIEBgECEAEBOwcOCjGFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQJHRAIBAwwXB?=
 =?us-ascii?q?BkBAREmAQ8JFgEFAh8HAgJWBgESAgEBgn6CMAEDMQeSaZxFfzOBAYIMAQEG2?=
 =?us-ascii?q?lwfLCJXgWUJgRouAYVrgmMBhVJUhDwnD4FVRIE8C4EJgT5viB6CaYNuL4M9q?=
 =?us-ascii?q?FiBTRwDWSwBVRMXCwcFgTk4AyAKNBQEGQIUHAEPBhAEanqCRWlJOgINAjWCH?=
 =?us-ascii?q?iRYgitqBAWDW4Q9hECCP1GCQoIRcYEXiAKBLYRqHUACAQttPTcGAwsbBj2hb?=
 =?us-ascii?q?jqDT3IBUjtMgV4/DZJvsyM0B4I4gWaBYwyfXgYTL5dFDgaSfAGYfSKpD4FnO?=
 =?us-ascii?q?oFcMxokgzZPAxkPjiE4g3WPCgG5LkI1PAIHAQoBAQMJhUYBAYpUgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 VUIeA==
IronPort-HdrOrdr: A9a23:hoJAZq1BlY5lIfoZTe+1jAqjBGYkLtp133Aq2lEZdPWaSL38qy
 ncpoV96faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SPzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyVMbEQt6bHCWeDYrQd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: =?us-ascii?q?9a23=3A9W2BC2iwBdNFtVPwA4/SfUoacTJua33xwkvCKEm?=
 =?us-ascii?q?EJl1Fb6GYdHm73P1Vqp87?=
X-Talos-MUID: 9a23:0psFbwgYCTaWylkesgWqY8MpCM4035ifLng0qIRYltKEJRJxZSvetWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,328,1732575600"; 
   d="scan'208";a="210756581"
X-MGA-submission: =?us-ascii?q?MDEooZwdyywvz1fFukhjiaMzVW5RlbYy4BnomC?=
 =?us-ascii?q?aEUn/4XZHBx9vB2R9O8cO3PoweCaVrhlR+a+oKBZ5L7jRJEBM3bHyi8P?=
 =?us-ascii?q?VEggCFHirT2KseszY+DBFd3O9V3gkFHqLx5/kUYyr0DWK/4rQ6ooqZT6?=
 =?us-ascii?q?mTIudL82r6Wnaq0lmdMd28Zg=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 21:57:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740948962; x=1741553762; i=markus.elfring@web.de;
	bh=mGq/gU9aiLC9wUlZmOgz0EtXdzSoBZk03x6MS/EQwvY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fHY9471ddlM03q0Z3Z3datTM3jBbdpRS22zBeKT8ZliBajHIdlhHQvGGEo6+58c/
	 aW/Veu4zpHaWYtpfla1mnxKePDKXcoTsODUenhZTQeA2VCMi3DsQD0MuTyIoBTl/i
	 4gZwYLSC4+E+9PgGeTXl1FGO7fuOpxUE+IsEHRBsrMFejAJoZMM/1ldkENDxTfguL
	 hFmR3HsGN8XJESDazCiRHCYD3LEVdr89EL+QKiKUQt9uHfNCVgShdvN0ZpzDAwpu+
	 hgArzZXRhJl6XDfjpzygg9k84ChZb6Vy1mdhpjn0l+k6vq6Am/oX/hnj4dSo4qnmn
	 VcnftArw3ZeAqk/ifg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.30]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLzmv-1tXRvX2K49-00Mg55; Sun, 02
 Mar 2025 21:56:02 +0100
Message-ID: <54c30a69-71cf-4582-9086-50eb0d39f273@web.de>
Date: Sun, 2 Mar 2025 21:56:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, freedreno@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Archit Taneja <architt@codeaurora.org>, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Jeykumar Sankaran <jsanka@codeaurora.org>,
 Jordan Crouse <jordan@cosmicpenguin.net>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
 Simona Vetter <simona@ffwll.ch>, Vinod Koul <vkoul@kernel.org>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <13566308-9a80-e4aa-f64e-978c02b1406d@web.de>
Content-Language: en-GB
In-Reply-To: <13566308-9a80-e4aa-f64e-978c02b1406d@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZXKKocm9YimrPH2Ai0mrevWkO84hjFpKhemYZk0/ziXAXy6/WRt
 MVT16mJFRDXIppSjxv77pPSQJFitb+KAakBf3ndC0onKZSiEhxx92Rw7fKew5iXRUWM/kbA
 NXlThqdMLWdKw4ICz/gOgP2zk7b1y5j85NjdlXYP0URExCPCbJ/ep3jYrenWGue6Bouz2qL
 Apu5N46AkpQFobLYGONFA==
UI-OutboundReport: notjunk:1;M01:P0:kuP3KBswb/c=;sypnX5yZi7yu/vG/c6hJxyLA9sm
 4FFHfcQSG4QIpCBVcJ4623jDYFkTg7UBOSCc/c5lbAK880V3IIjOf932Ji3oe2JigEZlU+Lxu
 V/GEr8r/L6g8jm+hd53cinFUfMb/ZXxOJk0ZkJkSZUhjMiaOkGW6HWWIp+eLOCrEq6F+WVejU
 P1Y3iPVu/tOvw5Sb36cnOWDEbooRvc+76ttxhKGLioRNgQN9pINxdWGZXe9mkfhvUVFutjQbH
 +YQIDirHQMSXh/KGmFgbyuM8gJiypXUJjTrm7WutWHQ1gmWbGCaXKUTN+PdD6op7sacXpwrDj
 88skEnupulUC2wRnSHi/T6g/v47xUaU4zHStF5l3EdtBWxR7EuZ8WJQGT5FvkyPuE8Nj5/isy
 ESGdZNQ6ONGI14/6O5q6N9gch8qRMHIQr0ecpdVJt7Lh+Vv5jjTsvjItas1eF+M2v0zOlvP0b
 sMQYoRWmY7jtnzjOLEhCQ8X+O0RbShmqNetrvMMQSOnp/aQPM6i9Rluhf5L6cScZIdnTgTP2t
 d5e7dAk++hwUcRx7LtipOyZcVFtK1yMv+CnGD/L4s8dvIkbS/lQQgqzgtH6vZnKOm3928+cj7
 tpH7QjfcZvpOiWNkRlKvynX+IXQAs2plsiyvJBrN/NbNpwBWNhW+aEXa6ES+tuWyeUmcwlztm
 kS2zd+BHBiB1dWloIP2bIcUaaJzrCmHeKNrSJKCPNpPkLwpyGO+mUkSa3h5PHvXuyGVuPpkRS
 s2LsvkXgh1IkirHLe48B1kje4OSStHoUULlBWPS2q/FBEt16rXqn3RbYNRv6tZbdYz6AdXlJJ
 UIchkTLxZJgZDsjpzbDfagbNvB6kSctp/c1NfxTkQ9chfgnaaBSt6JQ1cez9LgNudeJbrNU84
 gbmMcs0iwvnJGmRs1ODQoBEl6kOU6ILn4X4pKd7kBGPswj87DNqn1QrZDMSI3Tbr6K+YEnzGz
 ViMRFwe7916RUnYV70lMOrYJTQBE8CO8FOe1PdPAqgu9++58oQD6zjCxXqMVTIBU1s4VNEaIO
 S6pTuSYmvHFttfd37kKiqikzJCCw+fl90dYNuQK+XaMKIOMc8IkuJFi/SEHwsYDYnL74SkRuM
 8fDQQT0ASTWwBv+86LV2vv01kwBoVHZOf+rJR2Wlo4aWUrhXN1sCnysVPVrEoRJVYRsnOOB/B
 RF+M2H/sOdKNAfbCCGn0CpFIEHRl/X2ngW139q8RnABV/B/ImcIjh6Tt+9++OcAYQWmG3tdFt
 8w0CVuB6bu5iFPGeBjfAp87r/t3+qi/l/RKg0d2cCEYRhqy5Lj/dCIX1A4xRTequnnSWsbbqk
 T5G+5TerQFlj4fBrOPJ8pkaiPZVlawL+pAl0e8RtUG15k16LCPfRx7j7B1SGEaB7DSBMSl/Kl
 PpTcXuUSKKZA8sBfxaV4TM5OHBPjRd9xAslXujSz6RfP5fgcsq6G/jQ06rZJQrUdh2s1cegqs
 WID3uCQ==
Subject: [cocci] [PATCH RESEND] drm/msm/dpu: Delete a variable
 initialisation before a null pointer check in two functions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2473
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/54c30a69-71cf-4582-9086-50eb0d39f273%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 11 Apr 2023 18:24:24 +0200

The address of a data structure member was determined before
a corresponding null pointer check in the implementation of
the functions =E2=80=9Cdpu_hw_pp_enable_te=E2=80=9D and =E2=80=9Cdpu_hw_pp=
_get_vsync_info=E2=80=9D.

Thus avoid the risk for undefined behaviour by removing extra
initialisations for the variable =E2=80=9Cc=E2=80=9D (also because it was =
already
reassigned with the same value behind this pointer check).

This issue was detected by using the Coccinelle software.

Fixes: 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c b/drivers/gpu=
/drm/msm/disp/dpu1/dpu_hw_pingpong.c
index 0fcad9760b6f..870ab3ebbc94 100644
=2D-- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
@@ -176,7 +176,7 @@ static int dpu_hw_pp_enable_te(struct dpu_hw_pingpong =
*pp, bool enable)
 static int dpu_hw_pp_connect_external_te(struct dpu_hw_pingpong *pp,
 		bool enable_external_te)
 {
-	struct dpu_hw_blk_reg_map *c =3D &pp->hw;
+	struct dpu_hw_blk_reg_map *c;
 	u32 cfg;
 	int orig;

@@ -221,7 +221,7 @@ static int dpu_hw_pp_get_vsync_info(struct dpu_hw_ping=
pong *pp,

 static u32 dpu_hw_pp_get_line_count(struct dpu_hw_pingpong *pp)
 {
-	struct dpu_hw_blk_reg_map *c =3D &pp->hw;
+	struct dpu_hw_blk_reg_map *c;
 	u32 height, init;
 	u32 line =3D 0xFFFF;

=2D-
2.40.0

