Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA62C77B61
	for <cocci@archiver.kernel.org>; Sun, 16 Apr 2023 09:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=HZBoWojFNuJmcqPHbZB1MR3lVGGsssfCKdEHtDQlzbM=;
  b=A6i+NlSiU0FzXZ+1g6qAvwFciNxWrP/awlX3zHOwz/g+SSWdncO4BCcT
   nKh4cSWkf8uiufz49Pw71EiEnYGADclJHP4Tp0C5mPGfjUHzKwszGbsJz
   oqO+n9OXjVLzb4oKWm+5ZJs6CgSxIdCXcYl6ooVgP02UejMuWBv5clGuw
   w=;
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
   d="scan'208";a="103272093"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Apr 2023 11:54:39 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 22E0BE033A; Sun, 16 Apr 2023 11:54:39 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3D6A9E00A8
	for <cocci@sympa.inria.fr>; Sun, 16 Apr 2023 11:54:33 +0200 (CEST)
IronPort-SDR: 643bc5d8_fQgMO47xKXuIucLXea/JrR64tNeyuj0n8qJ7lsYYshIqrMp
 JRewSZuPAGnmi7OSI69tYcxVcSFLtCC/Q3dGxPw==
X-IPAS-Result: =?us-ascii?q?A0EGAADTxDtkhwwR49RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE8BAEBAQELAYItgUsvBAtGhFORAjGEMIcuhz6EZ4QDgVaBQ?=
 =?us-ascii?q?D4PAQMBDUEBAgQBAQMEOIRHAoU8Ah0HAQQxCA4BAgQBAQEBAwIDAQEBAQEBA?=
 =?us-ascii?q?wEBBQEBAQIBAQIEBQECEAEBARoJFwcOEAUihWgNgjcpARFkgQgBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBARICRz4DAyMEGQEBESYBDx8GAh8HAgJXBgEMBgIBA?=
 =?us-ascii?q?YJ6gigBAzEHrgt/M4EBgggBAQacCx8sIlSBXgmBFC0BjQqDNnonD4FVRIE8D?=
 =?us-ascii?q?IEJgT5viB+CZ4lrkGuBNHaBIA6BPIEEAgkCEWuBEAhqgXlAAg1kCw5vgUljT?=
 =?us-ascii?q?IF7BAIURA4dJQQOAxkrHUACAQs7Oj81BgMLIAZWawIJIxETBQMLFSpHBAg4B?=
 =?us-ascii?q?hs0EQIIDxIPLEQMQjczEwZcASkLDhEDToFHBIEJgQEGASYknyA9UYJ2wz40B?=
 =?us-ascii?q?4IrgVaBWQyfDQYTL4N9kwwOBjGRdC6HMpAXIKd/gWUDNYFcMxokgzZPAxkPj?=
 =?us-ascii?q?iAZHoNujwkBPj80PQIHAQoBAQMJhUYBAYV9AQE?=
IronPort-PHdr: A9a23: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
 QMqzBRza6Ih+WW0i7/YDkXHrm08nRto8eg=
IronPort-Data: A9a23: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
 c42ohXNA/R6/n2lqSv/KBB2bSeLC842Hk41xH0=
IronPort-HdrOrdr: A9a23:IwWlQ6ggVXb2W9UfUFrwIasCqnBQXg4ji2hC6mlwRA09TyVXrb
 HLoB1p726WtN93YgBZpTngAtj4fZq4z/VICOYqUotKMDOW2ldAabsSi7cKoAePJ8SdzIJgPM
 5bGsASNDSzNykcsS+Q2mmF+rgbsby62ZyJwcHD0nxqUQZmUK146RxlYzzrb3GeCDMmOXIjfq
 DsnfavSgDQA0j+5amAbEU4Yw==
X-Talos-CUID: 9a23:0dZaHGBe5NwQW5P6EwQg9RQLEcR6S1DYzE/7fRaSUkpJZbLAHA==
X-Talos-MUID: 9a23:u/5uogVistJSZgrq/ADomQhQF+pY352VBnEWyJED6u6jbDMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,201,1677538800"; 
   d="scan'208";a="103272090"
X-MGA-submission: =?us-ascii?q?MDGUNLDDgDzSjuMuOYKp5+hGeR/t2vZu3RruRW?=
 =?us-ascii?q?15uutCc/fuPukP9g2PjfmrMirCX4wa/dcHMPF4qFifFWk0kvkWwwy5k9?=
 =?us-ascii?q?7R2oawuBTgqginYo5yqfWxBN1RQOUQB1SVhNIacDoy/8FU+Syjq/vD2h?=
 =?us-ascii?q?6Gp4ax0q5KYdj8i29ZzzOpWA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 11:54:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681638869; i=markus.elfring@web.de;
	bh=LY4EBg2BdWLPjNGYjC3YZ3qcq9tadoc7hWdZSllHPfc=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=fIp3mt6z4Wd5OdTAyC9IBAdEfhqiFBFwdrQqcpb6UV2VQJ4ZVDCoHgSxWOtRfczNx
	 kSq9flOmYAXNOwfESKIL4b63criUjaG0aFdEyGN4P2TlBlO4wtEtIi8ogklzJaFgVE
	 HKMcKnu+eJnca4fgXf2sSXJnjtfhmwQ7JvIXJ4vcdpFKmSjXExeGlPs+2GyDytR6Hi
	 0MuGkXoZvyovKYHWjadLn4w3YKPNhZHzfMGD7lr0xRu3LVTix4O6r72l50MrBongRM
	 We3Dw4xSFG7femJBozqMV/4lQLEmmjsL5qkTUcily1DL86I8cJobwUhT6fyU2f89vx
	 IcTS9OtGHe2FA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MFJjP-1pYMyD3UzJ-00FPCj; Sun, 16
 Apr 2023 11:54:28 +0200
Message-ID: <04e2c1f5-26c7-9a23-5861-3d8757556cdd@web.de>
Date: Sun, 16 Apr 2023 11:54:28 +0200
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
X-Provags-ID: V03:K1:J0e0yr1JxAVW3GPnlcv9HTk5ueCQ7OmAOHYr8TWyPkLUlQZIYjp
 OxRdTBXpMLWU0b8VR/zdDxoteTVBlphkcMQsA+TCyfRmpGUtGb/0B1GUBa7R+u3jjV4jaWE
 L2UR+mx95QDP/punzQSPXWIT1wo/t60xwdO/4pDH4onlUewnnkUhEFWOK5AZm041A4f/Zq1
 HV7TkKbzM9gZI8/irNBCQ==
UI-OutboundReport: notjunk:1;M01:P0:iY2Ybj487Zs=;+JKNvsw6oP2MgAkUx4t/u031lMc
 U3Rs6wOrpAxEjeAeRvV3et1BdZArX4mqWjt0VQULSV7XTzfb2eoADJnsv7cEtCvNm/CB7SQAk
 hxIaODuGSUQ7WwM/RYzDZ5+Lh5JJRyVhK5KYOVTomffp3qqkNjcpf5in7DmGgWCqTonnWGL2E
 3Z8rEyFOp/2wH68GMRm3ZTFRu0+3r5zpcr0Dz3nOLv9ostgvNRVvtqm9XpJhyLv9FTjkZsJDg
 BqvyuBJLZNraxwfk3jHCLhdGbhSTUTM2/EPOms3W0y/aTnIaICVjR4BhFbC0BBo56fru0DLuj
 1jiE7zZREF9QBiVkyQo0buYIVcZ12Z04w9/ykPxqCXVza9rvAiuHpnsTKUONqzhxqUlb78Pjm
 gK4oYiE+m34/VfHG+vDS/OBXweQRkpIZzH2aJEC5P2K4Y2SHlaUlOoBpZUVLcd29nCMmVVSFz
 FQqFYeiyXGmP2HITOq9nQLDB+fNpFsQJHD6AyKRrS47cnr+bfsRCvgTBnuCABu3FeKEWIEBPq
 UCtnC+/MVD4f5YLF+mMPrgh1ZS6eF07f12+KdpVH15vq+rZwSH+sOX9AJMO4PLEp/9FJsaAUm
 DSuNMyPVi91eP7Cb33zWfBpJAdrYbVl9M7ALbi0LdSnIikPjFY4Qb4zuJ+ve77zf3p856qUPa
 64kK6Z0pps3CLSL38F8UQZMmQxUxHQWTnL29YSBDaT/Egk4eyjYVJ8XD+f1c/9xl1mnSp7UvX
 unBoK8DpSvr+ZKBxAcIdF3gEv1E8pCxOlWZ3BeWwq7GkpHBjnnNBk+HlzXJPnGATRxFRcc39B
 Qaez1bKLpdDeLqoYVS1gsAciyxd9WlegVYGsVtSqGojw6G/3Bm6cvYnXyqQc0B9s3PXH6xzkH
 8MEJDdrruDsPHB1sX6G+GNYcakFoCrumKq41fVk1/hf0aAyhUbUdGOk3e
Subject: [cocci] [PATCH 8/9] drm/nouveau/pci: Move an expression into a
 function call parameter in nvkm_pcie_set_link()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1068
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/04e2c1f5-26c7-9a23-5861-3d8757556cdd%40web.de>

Date: Sun, 16 Apr 2023 08:45:31 +0200

The variable =E2=80=9Cpbus=E2=80=9D was read only once in the implementati=
on of
the function =E2=80=9Cnvkm_pcie_set_link=E2=80=9D.
Thus move the usage of an expression into a parameter for a function call.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/pcie.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/pcie.c b/drivers/gpu/=
drm/nouveau/nvkm/subdev/pci/pcie.c
index b295f100e1c1..dd18d9d0bade 100644
=2D-- a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/pcie.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/pcie.c
@@ -116,12 +116,10 @@ nvkm_pcie_set_link(struct nvkm_pci *pci, enum nvkm_p=
cie_speed speed, u8 width)
 {
 	struct nvkm_subdev *subdev;
 	enum nvkm_pcie_speed cur_speed, max_speed;
-	struct pci_bus *pbus;
 	int ret;

 	if (!pci || !pci_is_pcie(pci->pdev))
 		return 0;
-	pbus =3D pci->pdev->bus;

 	if (!pci->func->pcie.set_link)
 		return -ENOSYS;
@@ -135,7 +133,7 @@ nvkm_pcie_set_link(struct nvkm_pci *pci, enum nvkm_pci=
e_speed speed, u8 width)
 	}

 	cur_speed =3D pci->func->pcie.cur_speed(pci);
-	max_speed =3D min(nvkm_pcie_speed(pbus->max_bus_speed),
+	max_speed =3D min(nvkm_pcie_speed(pci->pdev->bus->max_bus_speed),
 			pci->func->pcie.max_speed(pci));

 	nvkm_trace(subdev, "current speed: %s\n", nvkm_pcie_speeds[cur_speed]);
=2D-
2.40.0

