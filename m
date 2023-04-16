Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A66D0C77B76
	for <cocci@archiver.kernel.org>; Sun, 16 Apr 2023 09:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=NGIsVAP6u64QdnfH0Z1T2d3xPrr8gjFZdW9Br/io1V0=;
  b=t4W/htyfzbo3poQP6WCF1uvPUklUVB51ylbrGWzICgud8Dl5K/F4Dqjc
   PBsk/3RLq/YSI1vq94edfK4REUrqxl6JdUN0GQjJKBeEPpBwkY3En7vr1
   EKdObgMZb6nwIO81NHwt6xRpp/iAbJkn3eaokjcmQtWUV2HThrg+euE6Q
   I=;
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
   d="scan'208";a="103271621"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Apr 2023 11:42:22 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EC287E0298; Sun, 16 Apr 2023 11:42:21 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 29567E00A8
	for <cocci@sympa.inria.fr>; Sun, 16 Apr 2023 11:42:20 +0200 (CEST)
IronPort-SDR: 643bc2fb_+1AA1DBNEiX504+94iYc4KHoS3VcFPz92MrpusrrTFn6f11
 dpUT0jT+Fs96z7O0sjVVehN6VMLmlQ+nKLgLBRw==
X-IPAS-Result: =?us-ascii?q?A0EtAAAywjtkhw4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYItgUsvBAtGhFOIHohkLgOEMIcujCWEA4FWgUA+DwEDAQ1BAQIEA?=
 =?us-ascii?q?QEDBDiBU4J0AoU8Ah0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBA?=
 =?us-ascii?q?QIEBQECEAEBARoJFwcOEAUihWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBARICRz4DAyMEGQEBESYBDx8GAh8HAgJXBgEMBgIBAYJ6gigBAzEHr?=
 =?us-ascii?q?gp/M4EBgggBAQacCx8sIlSBXgmBFC0BjQqDNnonD4FVRIE8g0KEJoN5gmeJa?=
 =?us-ascii?q?4gEiGeBNHaBIA6BPIEEAgkCEWuBEAhqgXlAAg1kCw5vgUljTIF7BAIURA4dJ?=
 =?us-ascii?q?QQOAxkrHUACAQs7Oj81BgMLIAZWawIJIxETBQMLFSpHBAg4Bhs0EQIIDxIPL?=
 =?us-ascii?q?EQMQjczEwZcASkLDhEDToFHBIEJgQEGASYkni5yAVI7QwmCKpI7sQM0B4Irg?=
 =?us-ascii?q?VaBWQyfDQYTL5cJDgaSJS6HMpAXIKd/gWM6gVwzGiSDNk8DGQ+OIBkeg26PC?=
 =?us-ascii?q?QE+PzQ9AgcBCgEBAwmFRgEBhX0BAQ?=
IronPort-PHdr: A9a23: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
 BI72FMWiQsF6zrmpVs6dAOimQ==
IronPort-Data: A9a23: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
 Yl2x0Ac9SRdDn2kqSj/KxB7bSpaKivm+081
IronPort-HdrOrdr: A9a23:EzX9Yq8mjXS3kHlLUhVuk+AMI+orL9Y04lQ7vn2ZhyYlFvBw5P
 re/8jzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNWftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIOb+EYZmIbsS+V2njcL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: 9a23:GpJ7325s0dR2GgEsPNss0REJK+QYLWXh5nrQHRKaMWJyYbrIYArF
X-Talos-MUID: 9a23:KAX7OAWeKM1RC8Hq/BnroWBDBfV12ePtKBw/gboZgtmOJAUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,201,1677538800"; 
   d="scan'208";a="53467248"
X-MGA-submission: =?us-ascii?q?MDEkZfSsdMUYSonS7E80+OQRCZz5VGx6C8D3/d?=
 =?us-ascii?q?+slUpfmML+iO8h0weNbV+Nu2xI0GoovPW69aotN2v04fOLJWujrOdugl?=
 =?us-ascii?q?37f6BqfDO2bhlG2RX2QduhdJh0vbK7j8zY87R/qe3seGFsrjACkPVvBo?=
 =?us-ascii?q?h62+CGUS+X3i9sEB3Y/yiihg=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 11:42:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681638136; i=markus.elfring@web.de;
	bh=lgS1D4M4giXfq9onDRIVPrtymyGrqry6IsUpJ8t1W14=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=SrFM4vR0iVIhNqq/22VSIFSKpmJJjqkaX+yf08tztkbRzvWZOekuAmLpz7IzHbNxG
	 EwVqvPsywpIGLW29aQO8AuhlZQokzUpuHFmapW3CYQIjyFWJQ2VtHjzDaz8rP46Oce
	 FbxRNOUKUzYR48EDjjlpxVgjYJUnhHHu2NC4RlLP5ncemXv9ZZUfzwZwNxSGFEvwQ1
	 YfIBK3Biqycn2LOVg2dJQiCcbXcBm4PYPc3YhTmL+DgzyKvYFnak4hEtvgC3u7BWIN
	 E3a7ypDyXxoCU2IHRw7qdxzax06ui+3u2vMkxtaq+IE6HBvWDImTGnl29r8rQf4gxd
	 JfI7lw0ahYtnw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MdO9E-1qN2bH3Yw4-00ZUwb; Sun, 16
 Apr 2023 11:42:15 +0200
Message-ID: <529fe82e-59f0-71a2-1e33-b051f833b67c@web.de>
Date: Sun, 16 Apr 2023 11:42:15 +0200
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
X-Provags-ID: V03:K1:aiPmQfJG06hSJK2eCipymGgnde+p2W0i8rwt96FvWfIh709EcJo
 huBlDJaHqtKRwjAw5FzH739qc+nTz+sl7BKJQuDI6zQP3z0vowOFIdOxbwP7Hwl8QLmhJfe
 7DwTfvwy3jdKcqhGSUC4FoykEWy7zvQSdAji7Q7MiY8hB1EvSgcBoYP3NvQqrNvu0rgzYHl
 gBZaGVhMoZbinNL4Wyhrg==
UI-OutboundReport: notjunk:1;M01:P0:WfemR50h7fw=;I11z2a74WOXS6RqcP5qwGcJ9Mrs
 TkV/M5RkJMl9d5KvBZSijoUqI/pHt4AjPLB9Zhm2Orm3adoBtEfu2Vuq8wV00x9TcXQIfKy2c
 NAteq8yGb7mwsVeCFTljwhBR9DoObdCs3TaxMc2zNCIRQAmjXRftFOSgMl/xXg3SRY2emzUdA
 U6wRjmY6u8ofo/vI6gApnlhyX/XsZqatiJcJeVS/tl97TMe5Fa0Pabt8eLKa/LsDH/JMcAjtu
 p5rp8P1CYPbb+aEHcdJVfFElIxEtLvirpJMHTOW3smFoGhfzrGyV3tvWT5rRrK7g02J/H158K
 YTGen6ipZxaR3GnG7pnzOHTAv1qka7RQ0NT9k14WpdRAZXAu0nZFHVaR2a9b1KKdYr7bfTT4X
 AaExemkCRuM3zU9anbFOhNFhIfiomVDMZMO0qUupgm+CWU9G22912OZGy55ZlAPvE8le0KGsC
 MLTIoDLNzl4GR8Tof3RCU7KRJD/31Drm/3N3iTGlwGTcDCKK1KMwJJNgghLHpO79QaQ4/tyUb
 qVIX55yOJyb1I86CTBHTKGAve4qPdJSeN8nqWTTH9BsskD4bawcTVftSi3pj4igEAfq8naYdQ
 zi/yDa3ozYoywgWSDHt9RHbMaz1bZ4nFqqUysjagGWKeHV7N96CpX4JCh3kcvRmE8PAAyBcd1
 ZHZNnuMRrWyE3WDed2ncjcPUXIcHCrv7JPk9PlBX488cntWFsW2ocbslyuEZtMlJ4AdaRZS49
 9i8O7BKNgtp3u2dNMvW7G8Ae7SQ/lVdXipx0fqeV1Zizhgje0MrV6ksLGRkq3+pTgkzF426q7
 kj4XUiVdx8wkj8Zv3/QoWevlRb7NNs5DgiW98Nz/5F1kR0viY1aR9jRjqDGYwXsd6zeHXwJHV
 fOk0ALSWX2GtS4OlbI9aiPpClaLbkyCjcaQWm0NE/0gjiq5ECktJQj2pi
Subject: [cocci] [PATCH 5/9] drm/nouveau/bios/power_budget: Move an
 expression into a macro call parameter in nvbios_power_budget_header()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1065
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/529fe82e-59f0-71a2-1e33-b051f833b67c%40web.de>

Date: Sat, 15 Apr 2023 22:30:30 +0200

The address of a data structure member was determined before
a corresponding null pointer check in the implementation of
the function =E2=80=9Cnvbios_power_budget_header=E2=80=9D.

Thus avoid the risk for undefined behaviour by moving the usage
of an expression into a parameter for a macro call in one if branch.

This issue was detected by using the Coccinelle software.

Fixes: e5f8eabc0077ea3f77b3362e28d3969ae62e70f0 ("drm/nouveau/bios/power_b=
udget: Add basic power budget parsing")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/power_budget.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/power_budget.c b/dri=
vers/gpu/drm/nouveau/nvkm/subdev/bios/power_budget.c
index 03d2f970a29f..2ba992bdb19d 100644
=2D-- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/power_budget.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/power_budget.c
@@ -59,7 +59,6 @@ int
 nvbios_power_budget_header(struct nvkm_bios *bios,
                            struct nvbios_power_budget *budget)
 {
-	struct nvkm_subdev *subdev =3D &bios->subdev;
 	u8 ver, hdr, cnt, len, cap_entry;
 	u32 header;

@@ -82,7 +81,7 @@ nvbios_power_budget_header(struct nvkm_bios *bios,
 	}

 	if (cap_entry >=3D cnt && cap_entry !=3D 0xff) {
-		nvkm_warn(subdev,
+		nvkm_warn(&bios->subdev,
 		          "invalid cap_entry in power budget table found\n");
 		budget->cap_entry =3D 0xff;
 		return -EINVAL;
=2D-
2.40.0

