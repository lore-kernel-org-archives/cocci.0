Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB5ECC76196
	for <cocci@archiver.kernel.org>; Tue, 11 Apr 2023 16:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=polh7QyNGEMjE8ip3sB4mZi82pDoJiW4H/3z9m9nwlI=;
  b=NE+g8f3LL4MnTxT0JizuvjpGo3iDNsXQPX+LAVmD5s9DY8s4K99j4Fah
   qIySiVx9+NW0bLLAoKD4rO+UwIS/m/6v2ZYtcizpO4fve0e7ArAG1y+sv
   y4n1CDA1sNg9I5wsw80hqgVuB2RDan8Rdi/yIAhkFtXc4WIHKrCPPQMEh
   8=;
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
X-IronPort-AV: E=Sophos;i="5.98,336,1673910000"; 
   d="scan'208";a="102490968"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Apr 2023 18:39:04 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9B4F0E7312; Tue, 11 Apr 2023 18:39:04 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3A571E72F8
	for <cocci@sympa.inria.fr>; Tue, 11 Apr 2023 18:38:59 +0200 (CEST)
IronPort-SDR: 64358d22_xk0iAKRi5wZLCBANroE6Ce/bhC2SoXDgufaIQDxWjn4M3cT
 j1b4YlT3/lDfTVdXPtW7WrWIFDjarMx99gsixlg==
X-IPAS-Result: =?us-ascii?q?A0EgAACsjDVkhwQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYItgUsvBAtGhBY9iB6JDwOEMIcukCmBVoFAPg8BAwENQQECBAEBA?=
 =?us-ascii?q?wQ4gVOCdAKFPQIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECB?=
 =?us-ascii?q?AUBAhABAQEaCRcHDhAFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQESAkc+AwMMFwQZAQERJgEPCRYGAiYCAlcGAQwGAgEBgnqCKAEDMQeQd?=
 =?us-ascii?q?ZwZfzOBAYIIAQEGnAsfLCJUgV4JgRQtAYxKP4QwJw+BVUSBPAyBCYE+bogfg?=
 =?us-ascii?q?meRZYgPPAqBNHaBIA6BPYEEAgkCEWuBEAhmOYFAQAINZAsOcYFJY0yBewQCF?=
 =?us-ascii?q?D4lBA4DGSsdQAIBCzs6PzUGAwsfBlhrAgkjERMFAwsVKkcECDgGGzQRAggPE?=
 =?us-ascii?q?g8sRA5CNzMTBgVXASkLDhEDT4EiHwYEJGl8CgYBJiSde3IBUjtMgV4/DZI7s?=
 =?us-ascii?q?Hs0B4IrgVaBWQyfDQYQAy+XCQ4GkiQBl3Mgp3+BYzqBXDMaJIM2TwMZD44gG?=
 =?us-ascii?q?R6Dbo8JAT4/ND0CBwEKAQEDCYVGAQGFfQEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 RoiFrEc8/R/LlyFhQre2xBjvdpa+w==
IronPort-HdrOrdr: A9a23:SWHh8aF+6WjJPm09pLqEPMeALOsnbusQ8zAXPo5KOHtom7+j5q
 OTdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/hyAV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAsxD4bbLbWSS4/yKhTWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,336,1673910000"; 
   d="scan'208";a="102490953"
X-MGA-submission: =?us-ascii?q?MDEcb0JCzH8yIXQ05aiSyQZztaTIz80i+1qAxN?=
 =?us-ascii?q?XPXQ3KFCx5/82TuPTOKKTG6Xw2wg6Qa7u+PgZKFL7jYV/3Qh1t3YC9Do?=
 =?us-ascii?q?dY8QYz1s0vIfRgFxVTZEyfHxe8vhHR4uZTpYsvszUL7Sna+DvMKicSlw?=
 =?us-ascii?q?xvf0db3jCgIiXLSi9MzW4hiw=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 18:38:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681231106; i=markus.elfring@web.de;
	bh=KodfLgUceH7tlWIE/lBj4FeAVMbCd67EcM5rAgQ6bC0=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=ncSLNpg33w/+yGLxpXuqEKQjIF8sMjD/dStGvM3hLwghOGSzrS0oZoswUxq8273Ax
	 /odn+t/Ulhd5QE9FDqPNBjBj/8nX+uJZTDinfxPnOuQsX+2rRvTX95aoLoeahIiKyN
	 5lH43kIT2YUVeDqa/oeHTqKFiWs5NrEN/tIkYjACABi/02vUB/zTRQVWcE4/3pdRaq
	 lE8ZUXIPNy+waArASHvdzDWQXBh02bIfKh0Q/MtG6XMk1rdqcY7CIyr1NmN8wKSk0/
	 fGNeydCdrOXTtqelprPzB0ddXzXdeEkP7oS+VkaD3MwmjBlrJidGsnOsBcNTkU9tyL
	 0P/w1l759iy9Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MFayw-1palVH36HW-00HVEC; Tue, 11
 Apr 2023 18:38:25 +0200
Message-ID: <13566308-9a80-e4aa-f64e-978c02b1406d@web.de>
Date: Tue, 11 Apr 2023 18:38:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, freedreno@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Archit Taneja <architt@codeaurora.org>, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Jeykumar Sankaran <jsanka@codeaurora.org>,
 Jordan Crouse <jordan@cosmicpenguin.net>, Rob Clark <robdclark@gmail.com>,
 Sean Paul <sean@poorly.run>, Vinod Koul <vkoul@kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zjK3SgYZaTts3/DQmbn/tMUYAcK3xW8qYes08fJbQNKGfzUlL9m
 5uWvPtORkJBHASGS2jNgG8WVIgvsXC+AQSuteZtj4VjoaJFWNI8wa2uN5TBPSd6RRKigne/
 j1pErNZFJBEn4fy7mWQF/6r8oAyyMhcZ6b+u6e6glOpsVo25RWg0+iBQfEEm0ZG09EuJAGh
 X5sNGqJBRWPSLc9Fkqe3g==
UI-OutboundReport: notjunk:1;M01:P0:l3q5fR6k0sY=;7nvV/vmOPtMbKD90qGjin3PTyFK
 n1B6dfk8P3JdVmj9jf0XvgukO7IxLqG8cpOTDR7V2i//l0/jS1QBs3W9KsbPEhkM9KN0Z8vH5
 RI4bLeqeKIHkDn1VNG0iSuwQVEkv3CeOybmzIFzDsDo2A+qL0Di65w91/5uLuP1EAJKPyJ4f5
 V6rdkNcz19kCXgJA7VuA56jToT8vYgr/twtKzG5SjJ6TR26tTh31dHXYjzcLi9c2MKhMczGPu
 zGJLkHVLnddFUajffsBkxV4qRZWvmxiIDZzXye9pCoRB8cwSD5vFIhcW2L5gmhoMG+q07KBuL
 07mdTZw2SJzdxpJXKyG/4e83l9dW4d5D7gXCeaCj33RFuNeZkJJn52GebZJNBDQ3pN0URw0re
 CHaOgqwLYrWXQ/kqk4C062w3f57itEy06LvyaTi2WcEWxBBIrxHh2B2uqXIkUcXB9gKhS05lL
 cyoFxgQNIXKj9gMbelj2otJ2/4GKjDoUoC2mMUead3TuHoemnBWZlcusjjLJzLjAO6xhU1yFz
 39GS1cSklSER+qVxBILtvxQ5lD+JOWEP4y+uFGprbwE3oE/jy5RsrMrG8daJWFZTBx0ZBhGis
 tDyH/prWGKl5tZlQuYvb1YSijBOtjurNgKysUh7WsuRsie3J+NLVS1oqFnW+EqcFr418hPvqd
 VW0gwtDWM8JAJLAB2CVtjp0Uc8nUYRLRSA7JziSlkEXVeGF5voXlO0q3aX0dBMd8fBGJphcNN
 O+GU8OzCi4k7mfV5CJ9uLO/v0A9G6eQpN0d28U2mprOljbkY20Wg9FzyMNXMPUNjg+mXJWx7g
 /8LYuy9QDPQTmyOScyNPhvk34kQ14ejC/fv34BoeCKM8Fou3OvgovGD2wno7zV3orbjw05U8v
 MEZh3YQ6iAn/xa6uUXasbc7y+E7Oah+djeZdFXUFpVTyN080hiWgvTgSk
Subject: [cocci] [PATCH] drm/msm/dpu: Delete a variable initialisation
 before a null pointer check in two functions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1036
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/13566308-9a80-e4aa-f64e-978c02b1406d%40web.de>

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

Fixes: 25fdd5933e4c0f5fe2ea5cd59994f8ac5fbe90ef ("drm/msm: Add SDM845 DPU =
support")
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

