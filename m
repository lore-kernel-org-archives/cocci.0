Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F07BC77B61
	for <cocci@archiver.kernel.org>; Sun, 16 Apr 2023 09:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=M2N+E0WM8uuVF2AfJODA6aVJfCl434cfIYaOJFzcWz8=;
  b=hQgTdiq0tfnbxgsRrtTu2R/v4Zj6kNkyh6TtVZcQF2szy5uYtMh1KyTa
   5nck5VJOI5ccUU7DXY6cedcaotUdGnyGH/mcjn72shDPC66s6K4lStb7X
   spF6fnX7ki+8uDlC0/L5HLgfwNcivAeESBQU/+XhobTiKAxh7CpFG5lW0
   Q=;
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
X-IronPort-AV: E=Sophos;i="5.99,201,1677538800"; 
   d="scan'208";a="103271692"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Apr 2023 11:44:21 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id ACAC6E033A; Sun, 16 Apr 2023 11:44:21 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 5602DE00A8
	for <cocci@sympa.inria.fr>; Sun, 16 Apr 2023 11:44:15 +0200 (CEST)
IronPort-SDR: 643bc36e_6UO1mY0lGW5rt3UDfLZRBJCflwEVztAfXjGQkPD5v1NZcFY
 qEiUHdHJiuNszoEULxkwlSOPYL4mJGy1PQ0SNVw==
X-IPAS-Result: =?us-ascii?q?A0EFAADEwjtkhw4P49RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE7BQEBAQELAYItgUsvBAtGhFOIHohkLgOEMIcukCiBVoFAP?=
 =?us-ascii?q?g8BAwENQQECBAEBAwQ4gVOCdAKFPAIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBA?=
 =?us-ascii?q?QMBAQUBAQECAQECBAUBAhABAQEaCRcHDhAFIoVoDYI3KQERZIEIAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQESAkc+AwMjBBkBAREmAQ8fBgIfBwICVwYBDAYCA?=
 =?us-ascii?q?QGCeoIoAQMxB64IfzOBAYIIAQEGnAsfLCJUgV4JgRQtAYxLP4M2eicPgVVEg?=
 =?us-ascii?q?TyCU2+ECxsRg2iCZ5FviCJFgTR2gSAOgTyBBAIJAhFrgRAIajmBQEACDWQLD?=
 =?us-ascii?q?m+BSWNMgXsEAhREDh0lBA4DGSsdQAIBCzs6PzUGAwsgBlZrAgkjERMFAwsVK?=
 =?us-ascii?q?kcECDgGGzQRAggPEg8sRAxCNzMTBgVXASkLDhEDToEiHwYEJGWBAQYBJiSeL?=
 =?us-ascii?q?nIBUjtMgiqSO7EDNAeCK4FWgVkMnw0GEy+XCQ4GkiUuhzKQFyCnf4FjOoFcM?=
 =?us-ascii?q?xokgzZPAxkPjiAZHoNujwkBPj80PQIHAQoBAQMJhUYBAYMkglkBAQ?=
IronPort-PHdr: A9a23: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
 BI72FMWiQUF8TDx/xEoK1CMqCZiyCEM
IronPort-Data: A9a23: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
 bkjx5E7AvR9LlyFiwreCjxXTNqLHs/n+08=
IronPort-HdrOrdr: A9a23:LvDhJahcTgg5xRHQub4kt+1vInBQXg4ji2hC6mlwRA09TyVXrb
 HLoB1p726WtN93YgBZpTngAtj4fZq4z/VICOYqUotKMDOW2ldAabsSi7cKoAePJ8SdzIJgPM
 5bGsASNDSzNykcsS+Q2mmF+rgbsby62ZyJwcHD0nxqUQZmUK146RxlYzzrb3GeCDMmOXIjfq
 DsnfavSgDQA0j+5amAbEU4Yw==
X-Talos-CUID: =?us-ascii?q?9a23=3AGO+/5GmRGEN0fBy9B9LxYUIeFCXXOWHF9lTQAQy?=
 =?us-ascii?q?JMl1wa7vFdRiuxZs4rsU7zg=3D=3D?=
X-Talos-MUID: 9a23:hBKUfQlktsjkagegdWvDdno7Psgz++OBBHoMgJApg+2dN3BqAjmk2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,201,1677538800"; 
   d="scan'208";a="103271689"
X-MGA-submission: =?us-ascii?q?MDEuCaEImR1NkU26kUxfIiqCN9EQP5S87PbU7K?=
 =?us-ascii?q?KM6EiAOvZEq20wyv3FFr1awKCPl/O5IPEZ73gs2zo6qqiQiBJr7Ksx8E?=
 =?us-ascii?q?8iK3JyfyyDz6O4HHCNiktn25OYXd9FMLRb4xYXeAdD/qtUC3F5xTvQjt?=
 =?us-ascii?q?cDKryeYQKz0ZzdBnE0TquIZw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 11:44:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681638251; i=markus.elfring@web.de;
	bh=n41gQARwukkaDyUnJDCzmOZrW02lD6AxTHrmVuVuCEg=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=RJ80FrIqGvs6zBpUClKiNhle9Yu4n+NMVf3DqRPZJyvhldcuSg9t4rykBvsWSWx6I
	 /T+GtC2utkKxFSaOJoxKERM1bWq/nybgmppzTbkcs+h8aQjHMuCbokHDFzlbe9qTP4
	 keVVwzHud+EYV+Li5I7SXMiYTWYjCaf9d4c2EbhsttJ90BIpvl7x3qw259xTsSyKT3
	 uO6iIgHMgDskXfHZ0b7F4ofFivQS0c7alcAT+d6GAyLrOQO0CwcPgUBLmR1JqMl6QF
	 E58v59Ytd0xj3ztAVRuIc1zGtNPMaTNxdlr2Wg/yIUsoOD2/RbDGdQ+K289WtbAt2/
	 Q4hgNoHpMyYkw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MCGSU-1pefFp1ysc-009TBU; Sun, 16
 Apr 2023 11:44:11 +0200
Message-ID: <6435d829-2c9b-a3f7-c8cd-cf923508a092@web.de>
Date: Sun, 16 Apr 2023 11:44:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <2a746461-844a-2ad6-7b52-03f13fe1b9bf@web.de>
In-Reply-To: <2a746461-844a-2ad6-7b52-03f13fe1b9bf@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ODzhENw+XW+cNy69bxLsZXHfyG05+9RtBh+2vTyrh6Z+8DxqdGR
 8OAVcxt8+Utl3xdxvXvI3nY5PpyoGQTUGr06U+RSDttOnkz6tMsVf29j+mn5mwOImjmcVpo
 zWH6m+duQWzHeABBTzABLHiuwtpJty+AOIuX8o6RsJNSXbVaXyc5HmacSlKbDZH5g8SSEqw
 D8/R+9tdCjVHoMl8cqriA==
UI-OutboundReport: notjunk:1;M01:P0:fBJoNokfgZo=;9w9dNcYmRVyg5DJZRXvBx+samPs
 ztj0sTDy/hrsksoH9Xx+u5tZIeizXgpcXDG0id/w/nPQTXkMuJuh9GQW4+txG7p91qw4L6opG
 K6KTIbM7NSkQSO4eVOVSLT3WWv9P5Pf8wMt5vyeX6Gw4yuOQwrHrXwjkxmvYwR0DoT8op7tb9
 Hrv9WkRb5Wd5NTzuvfN6cUOLm+4xEJkGrjtfJvIV+wEOe/47FmycJCMH/A+gQIV19nu8ZH9Ui
 Cf3PS5Gu89ZxZT5wfD5GTJFGpsWvUtfeNKTULL8bz6jV8E7ZJElcZg4rzF+pZ2G0ToecCf54v
 7lOvEIz6Hl1CNCVmPFMRQe4rHzFGQmpd/oHg0n3QzXOtaa374qpVpFTkiqEmPZjN7S+tKOm/X
 8G5oDGYqzM0KP6QVPSDfqtliMmCRhWeNKNYNlgm49E5Y7wWoEsK7Z9DEIMpS3EbswQExFt98B
 t4Ir89kPLpzskp8AXXWroBF8V3SSuKgQOWulWsxMmC851QlW9J1NeoU11w1r8JW1inTbHNfwT
 SFZIUZjjbWg3xwQJRg22ruxDzy7q/yidUp+gUd/FmpCgZUv6IKvUTa2sFyoDCjah+7DsFe2Vn
 OtFGdFkTeTFV5huDhVXFdaqgZrXHjIq0qfuLOxQ8ZdWET8TQIWOFO+kQnX75Pc/TEtfcG3NCd
 ysVr61bHNUzdbJhTbiu9TRIYrty4sLs3jHp1BngcKUEn44qo4Sxtrq/LlwywJsmUUZfZtcmuL
 SwwNhZQ3Pn/xET1UeTNdQoIUOlWx7NODN4LxANwE/uLcmVTHf0ZBt77fP7j7I7kwLu1hYHVXX
 Mt9CPqNn59z20+mIusoc7SsPwOD9/X5AEFkb0vWED99suFm2Po8tvOF/hamU0rql9ZOOH6HNE
 UF2vfFFM3gXYmqfKDT0vbMm0V9bukwbRhbaBbygLQqR0BjBsnrFROsvV4
Subject: [cocci] [PATCH 6/9] drm/nouveau/clk: Move a variable assignment
 behind a null pointer check in nvkm_pstate_new()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1066
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/6435d829-2c9b-a3f7-c8cd-cf923508a092%40web.de>

Date: Sun, 16 Apr 2023 07:45:54 +0200

The address of a data structure member was determined before
a corresponding null pointer check in the implementation of
the function =E2=80=9Cnvkm_pstate_new=E2=80=9D.

Thus avoid the risk for undefined behaviour by moving the assignment
for the variable =E2=80=9Ccstate=E2=80=9D behind the null pointer check.

This issue was detected by using the Coccinelle software.

Fixes: 7c856522069755ab9d163a24ac332cd3cb35fe30 ("drm/nouveau/clk: impleme=
nt power state and engine clock control in core")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c b/drivers/gpu/=
drm/nouveau/nvkm/subdev/clk/base.c
index da07a2fbef06..178dc56909c2 100644
=2D-- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
@@ -417,7 +417,6 @@ nvkm_pstate_new(struct nvkm_clk *clk, int idx)
 		return 0;

 	pstate =3D kzalloc(sizeof(*pstate), GFP_KERNEL);
-	cstate =3D &pstate->base;
 	if (!pstate)
 		return -ENOMEM;

@@ -427,6 +426,7 @@ nvkm_pstate_new(struct nvkm_clk *clk, int idx)
 	pstate->fanspeed =3D perfE.fanspeed;
 	pstate->pcie_speed =3D perfE.pcie_speed;
 	pstate->pcie_width =3D perfE.pcie_width;
+	cstate =3D &pstate->base;
 	cstate->voltage =3D perfE.voltage;
 	cstate->domain[nv_clk_src_core] =3D perfE.core;
 	cstate->domain[nv_clk_src_shader] =3D perfE.shader;
=2D-
2.40.0

