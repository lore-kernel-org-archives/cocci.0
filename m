Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B733C77B76
	for <cocci@archiver.kernel.org>; Sun, 16 Apr 2023 09:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=3pJ2M8XJYjc+0viUO4bzSzAq+PKck6voKoWoIyCNZhw=;
  b=e4uEskQJTSxgIjYUSMxg0bEuqkcp521NgIYEsexwppv4ZrTNEfTfJVZD
   rZdMsr9YlYkpeAspGw/aJdf292tKAEekGJjStWk5eBUax9daLgRj3sAQj
   yV7EppJyHlLF8prthRn+ol1XuOdsyzh7myfjLgMBNnkAcvkYtyAqCd+zM
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
   d="scan'208";a="103271204"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Apr 2023 11:33:52 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 59156E0298; Sun, 16 Apr 2023 11:33:52 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 754FBE00A8
	for <cocci@sympa.inria.fr>; Sun, 16 Apr 2023 11:33:49 +0200 (CEST)
IronPort-SDR: 643bc0fd_I4almdfodO3/mk+Iu+SaGHzH8NQobuL5wfUlljDbfa7qIh6
 L0YM1a9kYZx24EjvagxXepFd3cYcUW+LubqA3Og==
X-IPAS-Result: =?us-ascii?q?A0EFAACOwDtkhwMP49RODBoBAQEBAQEBAQEBAwEBAQESA?=
 =?us-ascii?q?QEBAQICAQEBAUCBOwUBAQEBCwGCLYFLLwQLRoRTiB6IZC4DhDCHLowlhAOBV?=
 =?us-ascii?q?oFAPg8BAwENQQECBAEBAwQ4gVOCdAKFPAIdBwEEMAkOAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBAQMBAQUBAQECAQECBAUBAhABAQEaCRcHDhAFIoVoDYI3KQERZIEIAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQESAkc+AwMdBgQZAQERJgEPHwYCHwcCAlcGA?=
 =?us-ascii?q?QwGAgEBgnqCKAEDMQeuBX8zgQGCCAEBBpwLHywiVIFeCYEULQGNCoM2eicPg?=
 =?us-ascii?q?VVEgTyBFYE+b4QCAYQcgmeJa4gEiGeBNHaBIA6BPIEEAgkCEWuBEAhqgXlAA?=
 =?us-ascii?q?g1kCw5vgUljTB+BXAQCFEQOHSUEDgMZKx1AAgELOzo/NQYDCyAGVmsCCSMRE?=
 =?us-ascii?q?wUDCxUqRwQIOAYbNBECCA8SDyxEDEI3MxMGXAEpCw4RA06BRwSBCYEBBgEmJ?=
 =?us-ascii?q?J4ucgEwIjtMgiqSO7EDNAeCK4FWgVkMnw0GEy+XCQ4GkiUuhzKQFyCnf4FjO?=
 =?us-ascii?q?oFcMxokgzZPAxkPjiAZHoNujwkBPj80PQIHAQoBAQMJhUYBAYV9AQE?=
IronPort-PHdr: A9a23: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
 vselQZ0J+ggpm+E3g==
IronPort-Data: A9a23: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
 T3SFrAc8PR8LlGFiNv/PsCGvNo=
IronPort-HdrOrdr: A9a23:jXFrfawV6pc18jYDMkznKrPw+L1zdoMgy1knxilNoNJuA6ilfr
 OV7ZcmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bBYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebrN5DNB7foSjjPIduoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-Talos-CUID: =?us-ascii?q?9a23=3AKfXlLWgXKD1jsRBe09zjcTGwmzJuXibE8m7cCUG?=
 =?us-ascii?q?EJk03dbGSYmGLx4gjup87?=
X-Talos-MUID: =?us-ascii?q?9a23=3AT2TqdQwloQt1GaQ6OYo2H7ymtSGaqKXwUm8Cib4?=
 =?us-ascii?q?th5fHchZxEDqzjzbsXrZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,201,1677538800"; 
   d="scan'208";a="103271201"
X-MGA-submission: =?us-ascii?q?MDH1vW5VAw0iukXYLwCECkYXArQ/MJ+f/kzuud?=
 =?us-ascii?q?jCQXnNzqRfHXw3+yC6Zf4mW4xQQFRjxvcZjhWYMSmw6YeDMODAdmIf5Y?=
 =?us-ascii?q?zyVTLNO0idDFhiyoU4IjV/uhCnRdh01+JESoJLfr7PM8TX9xSaSkAUDm?=
 =?us-ascii?q?FPmryNtRlwghX25thrNeyVnQ=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 11:33:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681637625; i=markus.elfring@web.de;
	bh=8uHpunreb8Uo0Uleoeb/IuBORjGn6rkAngQmsnHu6wo=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=uNQkI3B/K8Z8M3MrlYgymN/aLA3rRG1QZdl7qfW7GGfTCt2ZwMWJYT1D0At4y2bxz
	 +5Kp5gsNaVI7W18qozcx7W9097C6nbxGmnKFhYjg+J1JO3Pq/Ktu8dbdOZjJKHHfEY
	 fylNNvDuVmR8gTQ3WaLYsM7kQST9RWzk3OBd4n0c++b2bq9b7ENYRv2ylivJ/Y9xYQ
	 pENXBa3nibtcnNjkMRciQtq3jJWUPvlwKZ6LFLhBu6nWkdUWsYQEQzlA86tWJl/hZq
	 svypQZHuGRnMrnUHiucUDoBihHH0y3YmLM3Pbes+EkZboJPEVp47jjw3A+zYKFPJCK
	 bujavS4tyRXZA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MsaS7-1qbYVm0bDH-00tdS0; Sun, 16
 Apr 2023 11:33:45 +0200
Message-ID: <1903e057-57d3-e12e-da37-008e23afd2e2@web.de>
Date: Sun, 16 Apr 2023 11:33:44 +0200
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
X-Provags-ID: V03:K1:4oF3Th7JF7y2HCnR8fozd4gR12wECkP6ixJoym1j256YmWiDIVo
 8GgH4sILld65578JRcAcU0gwMo0Bqhm9yfFuy3aU4LPez80+WkLFlNb+mZ1sk/pKTiK+que
 d1iRYCljX6TbqL+5MQ7+Pjz07Cp/Xqvo8DOxxV/na0LIac1BqwyBmnVHbu2AzbIHi0WS/La
 vNUKTLphOY36wAc8QbohQ==
UI-OutboundReport: notjunk:1;M01:P0:iverrg5pEh8=;DgI8r5RfixMh57awQv5JoZe9evv
 FG026mdqqPWNWrAvBJwwgQkDaDRe9GIGjwdYnulqjkjXH9OxOoVtQDCqCYF4jBX4qFufLR2tT
 K07kZrysvb13t7DHKd198A6WaXaXie5YiPndQY1Wj9SzkSrL1gUSu81eC9EuQHEblM90Ajk5g
 KA0IAq992HsqnhHvUYEx//kGmOHkfVk10qlAOhxFMbLzXm2nOgZDdUhsvzki8jWpTBigY704a
 6qqhue2nxvUiX4VD2asBzlB0McVEHc3cVxhTDmYexHoOxqVamMIBPHclnpQP/2Iy/jzzGzEdJ
 tnyKHXDgpN6iTXflWXXkFYq6h+l55bHqfyhwLvreL0Q1zOYq9i+/elzESPjnlx2GxyJLESEil
 k0na8bx9hUP/okmOgfO3tZRMZ1a49uTpk/phfd088SoSAsvcQlq7iro2dk/iZmM3SMS7lka2m
 kXjElSWdxCRYl8I1vQRvyGGYFoxiXs5UeIQbt5CIqQpPQgqYJbEBz3zZYu4NANb/K0fvKLLsB
 MPBKn1dnDAObTimJQVNTLW4uIFBfR3ufOOKOJ4uPIfjzzBQX0idBIUv+RuUljNsWO4UAt7SqV
 iBpvg0nd2xJY1pAfcNLtegzqYLDtDL/56z8k85pSLR+AfUgFNGd52in+Corq9sIZ988qDQVZ7
 wzP6pm8C4QVN1OIsbxy7LztjbLHp0mbOOYaeoGXpOq9WNa2V2XeSunBZz3JXLd56QL+tbQ3WI
 E8IK+yIdYDr4Q5kEWWKcAERvP33BuKuEdxQjVKtiOjmhk2LStc2kQHWR6MCc0eV3HsGkV0Ixg
 iQUs9kWfVGpLNLHvNiPwbmrpo5Ta67t+SGIn9N20KADseQJ4E5/MaLNDIV/Q8lhI2v3pk/Zsa
 6ztUaI4J3uzedEMBRimgkMSEu4fIdRUviFq5TDrHxMujjVKal9L+fbZNH
Subject: [cocci] [PATCH 1/9] drm/nouveau/debugfs: Move an expression into a
 function call parameter in nouveau_debugfs_pstate_set()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1061
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/1903e057-57d3-e12e-da37-008e23afd2e2%40web.de>

Date: Sat, 15 Apr 2023 21:06:06 +0200

The address of a data structure member was determined before
a corresponding null pointer check in the implementation of
the function =E2=80=9Cnouveau_debugfs_pstate_set=E2=80=9D.

Thus avoid the risk for undefined behaviour by moving the usage
of an expression into a parameter for a function call at the end.

This issue was detected by using the Coccinelle software.

Fixes: 6e9fc177399f08446293fec7607913fdbc95e191 ("drm/nouveau/debugfs: add=
 copy of sysfs pstate interface ported to debugfs")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/nouveau/nouveau_debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.c b/drivers/gpu/drm/n=
ouveau/nouveau_debugfs.c
index 2a36d1ca8fda..44e26b6e74c7 100644
=2D-- a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
+++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
@@ -144,7 +144,6 @@ nouveau_debugfs_pstate_set(struct file *file, const ch=
ar __user *ubuf,
 	struct seq_file *m =3D file->private_data;
 	struct drm_device *drm =3D m->private;
 	struct nouveau_debugfs *debugfs =3D nouveau_debugfs(drm);
-	struct nvif_object *ctrl =3D &debugfs->ctrl;
 	struct nvif_control_pstate_user_v0 args =3D { .pwrsrc =3D -EINVAL };
 	char buf[32] =3D {}, *tmp, *cur =3D buf;
 	long value, ret;
@@ -188,7 +187,8 @@ nouveau_debugfs_pstate_set(struct file *file, const ch=
ar __user *ubuf,
 		return ret;
 	}

-	ret =3D nvif_mthd(ctrl, NVIF_CONTROL_PSTATE_USER, &args, sizeof(args));
+	ret =3D nvif_mthd(&debugfs->ctrl, NVIF_CONTROL_PSTATE_USER,
+			&args, sizeof(args));
 	pm_runtime_put_autosuspend(drm->dev);
 	if (ret < 0)
 		return ret;
=2D-
2.40.0

