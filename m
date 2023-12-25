Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E10C3DA6E
	for <cocci@archiver.kernel.org>; Mon, 25 Dec 2023 17:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=qxzo2IuPlIMF77pqVTSBIf1Ysjzr3fjOeoPqc9dYDdk=;
  b=qNvJXQ5qJgKaX2E+E0cGK40lhmxKdD5qUFSPq4tT3IQjI02xzpuEsEwa
   FE27O4mJg7dpRUVmxJ/EadU5+78trVLpBPyvQq3I1Vj0R0Pg1ILIs6VNV
   ekNDojpGDKNSH5wVruOf1ite0ujOFrOn/e1yjhp6nKGzK0V4uaaP3tKpP
   Y=;
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
X-IronPort-AV: E=Sophos;i="6.04,303,1695679200"; 
   d="scan'208";a="143989805"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Dec 2023 18:34:56 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3C2B8E0CCA; Mon, 25 Dec 2023 18:34:56 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 41AB9E004E
	for <cocci@sympa.inria.fr>; Mon, 25 Dec 2023 18:34:54 +0100 (CET)
IronPort-SDR: 6589bd3e_dXgczdO6eGjQvh7BMQCi8r1Fr/mZuC3M1TNskm5ensUVyWx
 5DFkTqBwbJzRr+jv0FLhQ0sYJuSv4iMJpeuxYvA==
X-IPAS-Result: =?us-ascii?q?A0FGAACou4ll/07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYI4B4FLMgQLSIRTiB2HJIF1LQOEO4c1h0yIb4FWgUA+DwEDAQ1BA?=
 =?us-ascii?q?QIEAQEDBDiBU4J0Aoc2Ah4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBA?=
 =?us-ascii?q?QIBAQIEBgECgQYThWwNglwBEIEMgR4BAQEBAQEBAQEBAQEBAQEBAQEXAkdCB?=
 =?us-ascii?q?iMdAQERJgEPHwEFAiYCAlYGARICAQGCfIIrAQMxB68ggTKBAYIKAQEGgmasc?=
 =?us-ascii?q?h8sIlaBYAmBGi4BiBoBhWeDQXonD4FVRIEVJ4NBiB6CaIkcBzKCHINPkVl9B?=
 =?us-ascii?q?UFwGwMHA38PKwcEMCIGCRQtIwZQBCghCRMSQIFegVIKfj8PDhGCPiICPTYZS?=
 =?us-ascii?q?IJbFQw0BEZ1ECoEFBeBDm4bEh43ERAXDQMIdB0CESM8AwUDBDMKHQshBVYDQ?=
 =?us-ascii?q?gZJCwMCGgUDAwSBMAUNGgIQLCcDAxJJAhAUAzsDAwYDCjEDMFVEDFADbB8yC?=
 =?us-ascii?q?TwPDBoCGx4NJyMCLEIDCQoFEAIWAyQWBDYRCQsoAywGOAISDAYGCV0mBw8JB?=
 =?us-ascii?q?CUDCAQDKykDI3QRAwQKAxQHCwdSAxkrHUACAQttPTUGAwsbBj4CpkQHUygTT?=
 =?us-ascii?q?IIqknKTHZ5yNAeCNIFggWEMnysGEy+XJg4GklQumB8gqEaBYz2BWTMaJIM2T?=
 =?us-ascii?q?wMZD44gDBaECY8JAT1ANTsCBwEKAQEDCYVGAQGDWoFGAQE?=
IronPort-PHdr: A9a23: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
 Et5KHHbSrgXg7YyLQiDZyfDtJEJFfMOFMV5
IronPort-Data: A9a23:YnjiFaBPpuV6BhVW/0zmw5YqxClBgxIJ4kV8jS/XYbTApD0qhmBWy
 GYfWT2COPaPMGKjfd0ib4W+9h8P6p/UztJlOVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yM6j8lkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1rlV
 eja/YuHZDdJ5xYuajhPsvjZ9Us21BjPkGpwUmIWNagjUGD2zCF94KI3fcmZM3b+S49IKe+2L
 86rIGaRows1Vz90Yj+Uuu6Tnn8iGtY+DiDS4pZiYJVOtzAZzsAEPgnXA9JHAatfo23hc9mcU
 7yhv7ToIesiFvWkdOjwz3C0usyxVEFL0OavHJSxjSCc5xP7XEHH7v9zN3xoBpUc6PRJRnFTq
 cVNfVjhbjjb7w636Le8V/UqmckpasXmVG8dkis5kneGV7B/EMqFHPWiCdxwhF/cguhrFOzde
 tFfRD5hdhXGbDVQN11RBJ9WcOKA3yWkIm0J+ArJzUYxy2/f1FxYiJzuCuDIIPuvRt9bpkyGr
 22TqgwVBTlfbrRz0wGt+XWnje7nhjL+QItUFbui9/csjkf7+4AIIBgRSEf9vvSzzEKzMz5CF
 3EpFuMVhfBa3CSWohPVBnVUeVbV4EBOaMkaCOAg9gCGx4zd5gvTVCBOTSdMZJZi/IU6TCAjn
 A3B1d74Jy1dgJvMQ1Kk95CQsWyTPwoRJjQ8fiMqd1YOzOTih4ARtSjxaOhfPpS7tfDPIgGo8
 Qu29HA/o54xkf80076K+AGbojC0+bnMYA0HxiTWeWOHtTFGRZOXSLGpzXP57v9wCpmTYXfcn
 XoDmumYtPsvC7PUngOzYew9JpObzNfbDy/5nnhUAIgHyzSh31WBbLJgymhyC2kxO/lVZAKzR
 lHYvD1gwaN6PVyoXPdRWJ2wAcF79prQP43ped6MZ+Uff6UrUhGM+RxvQkui32rNtkwIuoNnM
 Le5dfecN1orOZ5F/hGXGdhEiaQKwxogz1z9XZr4lhSr8YSPbU6vFIsqDgG8UfAb3oil/iPu7
 NdtB+mbwU5+Ucr/QBXt36w9EFQoFUU/VLfK85F5V+jbOQd3OnATO9mIy5MbRoFVtaB0lODJw
 3KDZnFl2GfP3UPgFwHbRU1gOZXOXIl+p00VJSYDH0il8Fl9bJeN7JUwTYoWf74m+LZdzNpxd
 f0ketqBMNtLWD/o6zQQVrijjY1AJTCApxOCADqhWxc7J6Vffg3u/sT2WyfS7wwMM3aHjtQ/q
 LieyQ/re5oPaAB8BsLwavj07VeOkVUCueB1BW3kH8JyfRjyzY1UNCDBtP87DMUSIxHlxDHB9
 QK3Aw8dlNbdsb0O79jFqqCVnbiHS9IkMBJhIFDayrKqOQ3x3Gmpm9ZAWdnVWwHtbjr//aH6a
 NhFy/35DuY8o29LlIhBCJdu87M14or+hr1dzzk8Jk7xUXaQNupCLEWFjO51jY8c4p9CuACzZ
 FCDxckCB5WNJ/HeMQAwICgLU7298M86yxjo0OQNAUTl5SVI0qKNfmdMMjKt1iFMDrtHH7k04
 OUmucQpulWzoUdxAOmnkxJ7ymWoBV4DWpUBqZs1LtLKiA0q61caer3aKHb8z6+uYuV2EHsBA
 2Grlo/dobVD1G/uTmEWF0WR7dFChJ8Lhg9G/GUCK3uNhNDBoP09hz9VzhgaUSVXyU9h/99oG
 202KXBwG7qCzw1oiOdHQWqoPQNLXz+d207pzmo2hH/rdFapWkPNPV8CF760pm5ByF1lfx9f4
 L2840TmW2yzfMjOgw0DaXQ8oPnnFdFM5gnOnf68JPu8Hr44XCHEh5G/bm9ZujrlBsIM3Hf8n
 9dIx9opS6PHNn83mZYZWrmqjeFaDFjOIWFZWvhu8Z8YBWyWKnn4xTGKLFv3Yc9XYeDD9UijE
 cF1O8ZTTFKE2T2TqiwAT7s5S1OucCXFOPJZEl8qGYIHj1dbhj9urY6W6SX0wmMmKzmrfQDRN
 auJHw9u0ETJ7ZeXp4MJhNZJMCy0bLHooSXiifut/rxh+40r6YlRnIJb7ldwl2qYOk1r8np4e
 e8Fi7D+l4Rf9Gino2cg/mivyel5xRMfmdlkKDyOjuk=
IronPort-HdrOrdr: A9a23:SqxscqhwACTfsu0WQYUHGNbUnHBQXg4ji2hC6mlwRA09TyVXrb
 HLoB1p726WtN93YgBZpTngAtj4fZq4z/VICOYqUotKMDOW2ldAabsSi7cKoAePJ8SdzIJgPM
 5bGsASNDSzNykcsS+Q2mmF+rgbsby62ZyJwcHD0nxqUQZmUK146RxlYzzrb3GeCDMmOXIjfq
 DsnfavSgDQA0j+5amAbEU4Yw==
X-Talos-CUID: 9a23:Shfkl26ozyb86iFT5tssqnM7IOsIeGDm8SnrO0uqG1guWKDJcArF
X-Talos-MUID: =?us-ascii?q?9a23=3AIHduVQy8SKngdAaQVhflC5v30mWaqKOiEBAkybE?=
 =?us-ascii?q?FgfOZbwtVOC2TtD6pS4Byfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,303,1695679200"; 
   d="scan'208";a="143989804"
X-MGA-submission: =?us-ascii?q?MDEZtZkLu/yM9gLhFRwyQucedkuAi0uxRPRk7z?=
 =?us-ascii?q?wqamdS0xd9bc9SyIbDrtQqSH+wmjhJZVR77qXvsn916buvGvn4wKYMd1?=
 =?us-ascii?q?2gnt/IWaTudkPH6hakqqDoQYxMpXD9oXCMS+gjRgomBSCSyZ0NC7wfvE?=
 =?us-ascii?q?uTwR4XG1tg+1RxF5pRS91wwA=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2023 18:34:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703525670; x=1704130470; i=markus.elfring@web.de;
	bh=j6FHLbZ6EBvMZbptdGfZ3V+AeSOWsmTN5Ko7ce58BaI=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=br0QXRIgnHm+0r/fqNOkmZ7dy4gxmFHao4MJzm3oslO0OBWqyM3/h5+Wfy756MDA
	 1v5FB3rys0J51CiqbzvSJrkuQJSyJe2SgCkmvWfyx2wgSTX8P86cSv0QW+kneR5X7
	 tyoI41CZHNJ8Cfio3NqbyirM/71FMHMnErqmmuB+lizmzKpIgmG8cQa+O5DO+e2GR
	 jsjZ+d5S8qnMaSWXo4Bfmqi3FsAVNAexCYXhgS6/9bvM6l3pL30GXgMLpyvPUlMM6
	 giwU63TqA9DubTNppfdmWnFencNMU9QYMBAuPGLl27R8T4LGNnzJPzuCIME5QUXqf
	 IGeKUlUC9NwqZsZTIQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mq184-1qwBTI1nKU-00n33M; Mon, 25
 Dec 2023 18:34:30 +0100
Message-ID: <4bc19468-2d48-44cd-aaad-610e720c5449@web.de>
Date: Mon, 25 Dec 2023 18:34:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-edac@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Robert Richter
 <rric@kernel.org>, Tony Luck <tony.luck@intel.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr,
 Muralidhara M K <muralidhara.mk@amd.com>
References: <8c9e2c01-9ed0-4392-af40-4e8eb393cb67@web.de>
In-Reply-To: <8c9e2c01-9ed0-4392-af40-4e8eb393cb67@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sjToRHI4MMrjyzP45y6E1rvyjbGx5h7TCYxL4k4HHDpRGp6hR+B
 obPNhszGYCl8HdYPTLgIC2eip8304vmkOHjWrM+y66oi7vOSmkcKbOnQceOyOca4TlLoR0M
 KJB1oKzmiXyltmG+r6PMdGPZ+MWdtiIwp9yjMK2tnfiw8jn2h6UhwqEfhbewzao5qq/kSV0
 jtISuwg5a+IMRRFZMhUSA==
UI-OutboundReport: notjunk:1;M01:P0:CAEdyWEwjxs=;rAgHst3BMb6WjDycZy1UlGDdP7Q
 zvvGi/EraHs9IuktZ9RFGzVycUW2MvMey342NXF78Naoo4icMGF2mEwnKxG7RuOwscsUJLKtN
 ddyUkDipHnYF2rAZdAP60OQZF/8b53LR4NMrmTCXP26EFxvEt1BduXPdjWg8q/ftceIeJ2XsY
 nMCM6s3jcv7OnmnoEQ8dsb0ZLfsKLbfaeqELe94Y3SvU0ikVux58h6cpCjK3CmsqL5fpmcVVn
 zoWi3KScJNd3Rqjvv0yYFWEAgeVEgWvhdR/1MFmWZbkKJKMoi1h0sX/xKcimKlhulk7OoUAxd
 wkcaTKGLWcFg7S/W93f4eRThASos3ypu3KLkPfdt0irBmQHa7VPT8QLtF+JK+fWDpNwbuf/R+
 0iShsbmBE2evzjB5iDsnvUzrlp2pVWKSPQ5QO636sr33d+kYAwuqtcMQqnEo/Qfko810Nm7/q
 kp1iqRyHLy4QRcNRWq3Lz5aWFTVyv1Yn+aNiJ4AHZGW1GX7WGP8Nm0F9Q91gHPgolUlRHUepX
 wwk5YhW1UVg45TQy0Nw3ErLNaI5QOHhR8usq8Fmva0OD5ECuo5exF7an4k1OJWPF0yFBBsRA0
 UzbCc8vSqM3fm+8iui2oQWfl79AbEF6YViRMuHnwEPeJUBSsvcvL9Ev03tThl7iWhijC/qZ1R
 pVPrwpPwXf1LFLqbInz4kAU4mKvvXBj6VarV2ABurX28cU2yPTJMKlz+bedgstn5NZvmExskN
 CdB/BeD9KbNl8KWVYr7vIMpoKL4KFQztKNk81348BNM7hKg6TkXx35cdxxo1hr4nN6LWw2srF
 m5jb/F9VsrfJfe75Xc9SjDJs56ZPhOPLbApb0AhDPNrP4FOEWtfFvw3XstM32Sh7h6AZ8B31N
 oOR/JGBUL7J0U3/wlW0StS4FrwQOc0YG4HA8EEdVEDyhhe0l+U0/SpNu3jYavCZzIWVlqR32d
 W8lijQ==
Subject: [cocci] [PATCH 1/7] EDAC/amd64: Improve error handling in
 amd64_edac_init()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1385
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/4bc19468-2d48-44cd-aaad-610e720c5449%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 25 Dec 2023 16:21:34 +0100

The kfree() function was called in one case by the
amd64_edac_init() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

1. Return directly after a call of the function =E2=80=9Ckcalloc=E2=80=9D =
failed.

2. Move an error code assignment into an if branch.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/edac/amd64_edac.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 537b9987a431..f912cbadefa4 100644
=2D-- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -4414,14 +4414,15 @@ static int __init amd64_edac_init(void)

 	opstate_init();

-	err =3D -ENOMEM;
 	ecc_stngs =3D kcalloc(amd_nb_num(), sizeof(ecc_stngs[0]), GFP_KERNEL);
 	if (!ecc_stngs)
-		goto err_free;
+		return -ENOMEM;

 	msrs =3D msrs_alloc();
-	if (!msrs)
+	if (!msrs) {
+		err =3D -ENOMEM;
 		goto err_free;
+	}

 	for (i =3D 0; i < amd_nb_num(); i++) {
 		err =3D probe_one_instance(i);
=2D-
2.43.0

