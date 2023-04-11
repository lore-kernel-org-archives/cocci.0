Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF216C76196
	for <cocci@archiver.kernel.org>; Tue, 11 Apr 2023 13:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=JNg7BJbDmRwVpZivLziV7qOXeSAJ/5aNd3IQCYfn1Kk=;
  b=UfzOoQZqJQgqrx21fJayr+Pu8kOc872jIF9m+j9y3mbnFSaf5jSK+kTl
   PGihRElImqkqz1y24ZXpfoybyLYGQZm7dF0LPlQSKw+w984PKL9JIcJQv
   AtHUeEV1FuVWc5K0/2w/PdHvKsqGMSw2PnNgwtyhXGVIAJaOuQAw6JZbU
   0=;
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
   d="scan'208";a="102453317"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Apr 2023 15:42:42 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EC0F3E7314; Tue, 11 Apr 2023 15:42:41 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 7E25CE72F8
	for <cocci@sympa.inria.fr>; Tue, 11 Apr 2023 15:42:34 +0200 (CEST)
IronPort-SDR: 643563c3_/NfdSzMU3rWcw3EAwhhKCqJVupHltQ8sAp69ieiTitVqf3H
 6YurYZ6ItnYoS3I1lKUoD6Hz15C0i/f4tNBpgQQ==
X-IPAS-Result: =?us-ascii?q?A0F8AgBrYzVkhwMP49RaHgEBCxIMQIFEC4IugUsvBAtGh?=
 =?us-ascii?q?FORLQOEMIcuhz6EaIQDgVaBQD4PAQMBDUEBAgQBAQMEOIFTgnQChT0CHQcBB?=
 =?us-ascii?q?DAJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFAQIQAQEBGgkXBw4QB?=
 =?us-ascii?q?SKFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEgJHPgMDIwQZA?=
 =?us-ascii?q?QERJgEPHwYCHwcCAlcGAQwGAgEBgnqCKAEDMQesYX8zgQGCCAEBBpwLHywiV?=
 =?us-ascii?q?IFeCYEULYxLP4M2eicPgVVEgTyBFYE+boQLhBSCZ5FjiA88CoE0doEgDoE9g?=
 =?us-ascii?q?QQCCQIRa4EQCGY5gUBAAg1kCw5xgUljTB+BXAQCFDolBA4DGSsdQAIBCzs6P?=
 =?us-ascii?q?zUGAwsfBlhrAgkjERMFAwsVKkcECDgGGzQRAggPEg8sRA5CNzMTBgVXASkLD?=
 =?us-ascii?q?hEDT4EiHwYEJGl8CgYBJiSdeXIBUjtMgh0NkjuwezQHgiuBVoFZDJ8NBhMvl?=
 =?us-ascii?q?wkOBpIlLocwkBUgp3+BYzqBXDMaJIM2TwMZD44gGR6Dbo8JAT4/ND0CBwEKA?=
 =?us-ascii?q?QEDCYVGAQGDJIJZAQE?=
IronPort-PHdr: A9a23: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
 zWLmm0=
IronPort-Data: A9a23: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
 T3SFrAc8PR8LlGFiNv/PsCGvNo=
IronPort-HdrOrdr: A9a23:/6VSwK8AsG3xZuRaLb9uk+AMI+orL9Y04lQ7vn2ZhyYlFvBw5P
 re/8jzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNWftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIOb+EYZmIbsS+V2njcL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,336,1673910000"; 
   d="scan'208";a="53097090"
X-MGA-submission: =?us-ascii?q?MDGaimBjCPrqH8B1BiehMccLb1VPNMZkRkYAMH?=
 =?us-ascii?q?BGo+GEHDN+xxLjSWjXJ7frnBfOiKjU2Bwov6yhuB/OnNrGjfx2kEMzo1?=
 =?us-ascii?q?GtlN+tZue+dz7u0OGWCm5txYXXH8Wyffnu3HWUpzreLRYYkVIyO+hF9I?=
 =?us-ascii?q?uWTEpVsBgczXzrDDu7VJB0lQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 15:42:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681220529; i=markus.elfring@web.de;
	bh=MdVoBfc/dINhWnEEIR/uciIViBWA6WiKvA2ZgQLTO6U=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=LJvC47Keh162g60XJxLk25jMiGsplj3uqBrXyV0WKxPlF5qGl+XdM7ARKYR5L71JE
	 1b9sMiQ65irha7oV82FWxVd4SzME7q8Whi317lDv4PnsOw1kXFpGuEW4nErDoDKXwh
	 srg2XlbsAsWku69qqHL86adLV4o4uCHza6M8I5TdHSA812He42XG5StoVU8k/9s3hl
	 Czk1Swjq4qpPdFy1emDuRxtwyt5sLqD2W3ID4nex/yAb4gvSSaHzxvLU6UPzyScouf
	 fC28gyJvIjIpvem0ns93BHSZbbX0py8Nn5TECeaFfKbqUtsryNqEB4kp+smxkEyNS0
	 SdPkXCb0MBGSA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MidHP-1qGMD93cff-00fjHF; Tue, 11
 Apr 2023 15:42:09 +0200
Message-ID: <0d4b92ab-f7c2-4f18-f3c3-c0f82ba47fc8@web.de>
Date: Tue, 11 Apr 2023 15:42:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Alan Liu <HaoPing.Liu@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Alex Hung <alex.hung@amd.com>,
 Alexey Kodanev <aleksei.kodanev@bell-sw.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Bhanuprakash Modem <bhanuprakash.modem@intel.com>,
 Candice Li <candice.li@amd.com>, Charlene Liu <charlene.liu@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 David Tadokoro <davidbtadokoro@usp.br>, Eryk Brol <eryk.brol@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>, hersen wu <hersenxs.wu@amd.com>,
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, Jun Lei <jun.lei@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Mikita Lipski <mikita.lipski@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Stanley Yang <Stanley.Yang@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Tom Rix <trix@redhat.com>, Victor Zhao <Victor.Zhao@amd.com>,
 Wayne Lin <Wayne.Lin@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>,
 Zhan Liu <zhan.liu@amd.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <2258ce64-2a14-6778-8319-b342b06a1f33@web.de>
In-Reply-To: <2258ce64-2a14-6778-8319-b342b06a1f33@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:25febEqWetoQFrH/VBrwzBfTZugoK4sRWe5E4/QkInoeM7mmYZD
 TAwrXHKHDI9pkIADa8o8P5ZXEeWc53/5VA2ElTgbNWnpDUpzd8KvpK80DhfwPvGN6e/Ecpa
 L9+Oy8j2pqZgtAhQTdDKZu2mzIKAq5DryqasE9YtyWkeT+b93vSX8KPc6BszT3hKXYoZxt3
 YG8zPMqts/i/f6BWFEEog==
UI-OutboundReport: notjunk:1;M01:P0:rk04CgmiAgM=;BjHW4/lmZCg4/XhetZVbD0uiU/7
 6xo7boTMuwYxpNVQsDmg37k+mhVfwgK5T6tbTthJjc0R7/TjZokWwAWgzkefPt3epO9/9BFOz
 pq6Toe1LfbPOPTR9QwrFxd7tRD+hBXGelxeor5euggerPKgvKDOZIBEGgN/ZsnNRVvnN6LxpM
 GCvhcL6GPK+D/uNk7iv+5wMnPH1IflQ+A3xOz15LXHDSAC7uQ/isKCWKST1PvUnkptJSrzw7u
 jgZxR3QI2WA58N4n/5HSx7zdm3lF5f8/5Zwg5BL+PW8b98YV0PrnNoTAp441+7ML71OpHpMOR
 lnaUfJx+yl0S70j42GgynhWHDdDtkut9hqIRZMa0oXvKQFN0mIc0xs6ZSY3Gg1LwiZ7WZPrvm
 LAIGAk89jrFoT6UdclsdWvyBgCdAdJX9f7uZQaABpBAROIiGBdtLcBx3SVtMwtm7wDStJSO4O
 BdkDzyZv3GgsCH3+73vMXdZW3nkrcfkC6dL9ptxhozWkd5NB6JR9X4CmOILZHMuP3UHzqoe2b
 +pcCtRRz5/g6lUxZ//771PTzwsKgYdzMs8tZG1Zmi97T9BfjeJzYMepSU21RFXrmXC+VZUpD7
 MJooViMRuqTey1bP3pfiM6KcMcR9HEx7Wz9IGQyCN5J3rG50x4/+68j7rtPepA04tNUdW9Pi3
 nuzTspL78ixzLw785rGRZ6TvI3Neu8IqHNPznd3h43PSjN6EcN6kxkUKivkYvEOCfjvr+Nby8
 QMyPvW1rypdAYWpla7LvgjIbatJJwbm73kwgrB6LtPB7qTZ752KgSTWM3jnb6abcl3VwatFsu
 b/C5xu/WxV6e7ectsHQj2L/ZU7i92GUREA0WKGNCBB6DFdX8U9kaLRspS4rmDfME6lKPGHvgO
 PpOl9b+2/01y1F71kTEcQDT5NcZ4755N8bC96sTBRKI/EWyg7aza/YCEk
Subject: [cocci] [PATCH 1/5] drm/amdgpu: Move a variable assignment behind a
 null pointer check in amdgpu_ras_interrupt_dispatch()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1029
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/0d4b92ab-f7c2-4f18-f3c3-c0f82ba47fc8%40web.de>

Date: Tue, 11 Apr 2023 10:52:48 +0200

The address of a data structure member was determined before
a corresponding null pointer check in the implementation of
the function =E2=80=9Camdgpu_ras_interrupt_dispatch=E2=80=9D.

Thus avoid the risk for undefined behaviour by moving the assignment
for the variable =E2=80=9Cdata=E2=80=9D behind the null pointer check.

This issue was detected by using the Coccinelle software.

Fixes: c030f2e4166c3f5597c7e7a70bcd9ab383695de4 ("drm/amdgpu: add amdgpu_r=
as.c to support ras (v2)")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ras.c
index 4069bce9479f..a920c7888d07 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1730,11 +1730,12 @@ int amdgpu_ras_interrupt_dispatch(struct amdgpu_de=
vice *adev,
 		struct ras_dispatch_if *info)
 {
 	struct ras_manager *obj =3D amdgpu_ras_find_obj(adev, &info->head);
-	struct ras_ih_data *data =3D &obj->ih_data;
+	struct ras_ih_data *data;

 	if (!obj)
 		return -EINVAL;

+	data =3D &obj->ih_data;
 	if (data->inuse =3D=3D 0)
 		return 0;

=2D-
2.40.0

