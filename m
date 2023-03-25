Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78685C6FD1C
	for <cocci@archiver.kernel.org>; Sat, 25 Mar 2023 09:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=A/E7GhwGKgQc5vx+vA07U+3caLmkcJvfOncTzrwPgm0=;
  b=uYTXRGyg2eSd9GIYUX+5BKSMEX6tHRXqylSu7gfV3bSQ84iHWg+mZlxw
   rSutxqqMOJOxjAMVP8pvPf7QzEXvGeKp+Jhitdk03acvV/apPX3L9uiRn
   uxvGufrSF6GgGDYdJH55ZXSp6no0tDGs8ozVUXpRl995hsP+IZ8BHHq70
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
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="99044254"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2023 10:03:34 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6D421E0D44; Sat, 25 Mar 2023 10:03:33 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 2E971E0D40
	for <cocci@sympa.inria.fr>; Sat, 25 Mar 2023 10:03:29 +0100 (CET)
IronPort-SDR: 641eb8e0_Kz6D9iRgJJXbeZs0lJJNn3vKBfUscAcv1zTLfnmbCrAuND+
 1uH/D9/Lb7Y8Mov8a/jlFBwRqBuxMaoLawLjNnQ==
X-IPAS-Result: =?us-ascii?q?A0EuAADytx5khwwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwGAQELAYItgUsvBAtGhFORAS4DhC+HLJAjgVaBQD4PAQMBDUEBAgQBAQMEO?=
 =?us-ascii?q?IRGAoU6Ah0HAQQxCA4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAEBA?=
 =?us-ascii?q?hABAQEaCRcHDhAFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QESAkdTPQMDIwQZAQERJgEPHwYCHwcCAlcGAQwGAgEBgnqCKAEDMQexJn8zg?=
 =?us-ascii?q?QGCCAEBBpwKHywiU4FeCYEULQGNBIM2eicPgVVEgTwMgzWIHIJngQyBHJcqC?=
 =?us-ascii?q?oE0dYEgDoE9gQQCCQIRa4ESCGuBfUACDWQLDm+BSgJkTCN7JQQOAxkrHUACA?=
 =?us-ascii?q?Qs7Oj81BgMLIAZYawIJIxETBQMLFSpHBAg5Bhw0EQIIDxIPLEQOQjc0EwZcA?=
 =?us-ascii?q?SkLDhEDUIFHBIEKgQEGASYkmnECAYFrfIEPgnWSWBGSL54ONAeCKIFVgVkMn?=
 =?us-ascii?q?wwGEy6XCA4GkiMel0wgp3qBZQI2gVwzGiSDNk8DGQ+OIBkeg26PR0A0OwIHC?=
 =?us-ascii?q?wEBAwmFRgEBgyQtgioBAQ?=
IronPort-PHdr: A9a23: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
 RM8zAdzM7xFHNjE/Fo9YFbH9nJYrQ==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:4IgfJKx6ydBWXV16B5fxKrPw+L1zdoMgy1knxilNoNJuA6ilfr
 OV7ZcmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bBYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebrN5DNB7foSjjPIduoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="51218794"
X-MGA-submission: =?us-ascii?q?MDGwB07Anj/Bck4LtuGPu12hwrHIWeTYvpZd/r?=
 =?us-ascii?q?bGLrG48mvc2kOqwJSon6L47zTSnpHqmd0FltHFWogpip/j+jZePVnMqd?=
 =?us-ascii?q?8fMU6SqTtbvOGOF/1gosT3FqKOmrNbrEQi0GnEsVy99c6NVeqaOto0D5?=
 =?us-ascii?q?L8QxrmeuK/a419HQ1ohj7SuA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 10:03:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679735007; i=markus.elfring@web.de;
	bh=0M/6FzSrahyJxv/uWh+M4doNzgwORcXgsc2QkjQV2Nw=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=Y08dHBypWMSu6I/NcNgCW6qzZsVGlvQl6Z0dH8N13hqkeP8+Bgf8F+rrk1+0/Pugl
	 rAemIMjBBQGFXRYvNden5bkjexV2jasFHYqPYmCE7CAa7ufWoA+EF8gQzdyXqbEF2Y
	 2ptgURAhNxw/N9KxuIP1HzslkmLOi7oa0scLV2b6ksnxf2a5k73Z++iWWoHv80cy0N
	 O3E0wFgdElU4QYwCLwNnXvHJB14+RDgCPwnv3QHeiilr/OoLIjwOJGxzni04c44oha
	 tFW76xGwpeE98dfDdlSzqifkXKEKBOhihNjNAxHXLvNIeQnr3hAJQ3HexI7/gEebiY
	 9e19CWsoUq/FQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MUUAM-1q6Qcp0fyq-00Qrso; Sat, 25
 Mar 2023 10:03:27 +0100
Message-ID: <a0db0847-e74d-650d-4570-3bd2492b835c@web.de>
Date: Sat, 25 Mar 2023 10:03:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-scsi@vger.kernel.org,
 MPT-FusionLinux.pdl@broadcom.com,
 Sathya Prakash <sathya.prakash@broadcom.com>,
 Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
 Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <46330de1-742d-f95d-e355-a214330698e7@web.de>
 <1595e3ec-d137-80f1-af27-b8fabd8bfd4f@web.de>
In-Reply-To: <1595e3ec-d137-80f1-af27-b8fabd8bfd4f@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vbr4Gzpg+heznG7faWnJdSDWP3+Orc5fIlJCf5xQLpvyMlQ+oKq
 8g5QX3l5prEA4KRY1AkLcz89+VQm5g/FqMapRM61oBg5tF/Z/BNd0d/n5/iUYyHw7lK/KQe
 +9XFwsKl4yLmaW0dcbFqqVp2HpuTVv3O9P5WXs+iFHiqpDndPt0nDV0N+698W6xzZGnVHX6
 He+1UX1aWnSSvc/hJ7qhQ==
UI-OutboundReport: notjunk:1;M01:P0:lDh4VgRXR+Y=;RNOFHUEGDrEzHzwV5qPh80SS7T8
 7yprrknHkhIAOJmUI6Dq+gbiNKuDLR8+0S/78lb4m83c+wpK2Hjz2/g1l7P9AKa5/MkP8ftwD
 3KY3SOrX9q0CLI+mem1Ag3hhejeZNZXb5kroJBefMgFAYzUqFBr0kC+SET8km5iWsFCjEKLEs
 U+ba5CeNnUR5WL736I4NyZ//xAzX5wNWmDKbvIjAZtLAXFa4T2t3dItcKS0Vyqn5ijkAZ5Zap
 oAmQSEOlh7kTLwE8mZIxlc1M20/R8cQUZL5qHgyPmX45sB+zoI7+zQLgN+fALy+W8WtW+sqkd
 anCDEXJxno6mTeri1hv0ODZN9ivpzEBCheUxT06/hzxFIjd+AKDMR7zva1t6w4+Vgxi7AcWrD
 n0Ss5sxlHjOxNpSyTv595JnOMlEDFHlKIyLqX8BLAmvKEH27B6Wflbl72IChs6Djs3Nii22MR
 nRHYO71434nYHgyJGFtRCUuUyjk2Ia/yazD5OX1+cV0JkwPPiX7JAhJ7pWyhra3vRGLN0KLtJ
 ZGXo4pf4kxp/25gkagP272G1QrSmcioIqodstx+jSrkT0urtTSRoW6HD3IM6KuTljfxsmgTon
 vLt6pQ/+k2fApRHg8+Yv1uMl6WFxZMNwzTN2DxX9e3eOqV5l+8tlAemOwyxGaEHXfZvOGjzNa
 wscUbzpqXzdtInsBh/jHbyhge1+jTGiBHXwpSbpXvYi3IEwVxlf2BuzJlBP9g6xT2h43xgbRT
 vuEQUyclBXeV4ehdl9XYB7wtyy5IApYBfSgGgMOFBpkOcR66kBuZub1DImCjqbKfKjnGRYBw8
 00FQpKZWFG6IyQi5LTrpgVFbletvxE0kFyj7eYZCr2jrkELsgzrZoHALbXywJ042EkEJu+LZL
 fH6OpcyNmAVanpp+sRvrxpIg1knqLQtO4P9oMScR7E3y2M6v6+r1SwBOH
Subject: [cocci] [PATCH resent 1/3] scsi: message: fusion: Return directly
 after input data validation failed in four functions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 926
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/a0db0847-e74d-650d-4570-3bd2492b835c%40web.de>

Date: Tue, 21 Mar 2023 15:02:37 +0100

Return directly after input data validation failed at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/message/fusion/mptbase.c | 18 ++++++------------
 drivers/message/fusion/mptsas.c  | 18 ++++++------------
 2 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mpt=
base.c
index 9b3ba2df71c7..4b097c1f95cb 100644
=2D-- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -5665,17 +5665,14 @@ mpt_inactive_raid_volumes(MPT_ADAPTER *ioc, u8 cha=
nnel, u8 id)
 	cfg.cfghdr.hdr =3D &hdr;
 	cfg.action =3D MPI_CONFIG_ACTION_PAGE_HEADER;

-	if (mpt_config(ioc, &cfg) !=3D 0)
-		goto out;
-
-	if (!hdr.PageLength)
-		goto out;
+	if (mpt_config(ioc, &cfg) || !hdr.PageLength)
+		return;

 	buffer =3D dma_alloc_coherent(&ioc->pcidev->dev, hdr.PageLength * 4,
 				    &dma_handle, GFP_KERNEL);

 	if (!buffer)
-		goto out;
+		return;

 	cfg.physAddr =3D dma_handle;
 	cfg.action =3D MPI_CONFIG_ACTION_PAGE_READ_CURRENT;
@@ -6249,17 +6246,14 @@ mpt_get_manufacturing_pg_0(MPT_ADAPTER *ioc)
 	cfg.action =3D MPI_CONFIG_ACTION_PAGE_HEADER;
 	cfg.timeout =3D 10;

-	if (mpt_config(ioc, &cfg) !=3D 0)
-		goto out;
-
-	if (!cfg.cfghdr.hdr->PageLength)
-		goto out;
+	if (mpt_config(ioc, &cfg) || !cfg.cfghdr.hdr->PageLength)
+		return;

 	cfg.action =3D MPI_CONFIG_ACTION_PAGE_READ_CURRENT;
 	pbuf =3D dma_alloc_coherent(&ioc->pcidev->dev, hdr.PageLength * 4,
 				  &buf_dma, GFP_KERNEL);
 	if (!pbuf)
-		goto out;
+		return;

 	cfg.physAddr =3D buf_dma;

diff --git a/drivers/message/fusion/mptsas.c b/drivers/message/fusion/mpts=
as.c
index 88fe4a860ae5..e0e861e79e64 100644
=2D-- a/drivers/message/fusion/mptsas.c
+++ b/drivers/message/fusion/mptsas.c
@@ -696,17 +696,14 @@ mptsas_add_device_component_starget_ir(MPT_ADAPTER *=
ioc,
 	cfg.action =3D MPI_CONFIG_ACTION_PAGE_HEADER;
 	cfg.timeout =3D SAS_CONFIG_PAGE_TIMEOUT;

-	if (mpt_config(ioc, &cfg) !=3D 0)
-		goto out;
-
-	if (!hdr.PageLength)
-		goto out;
+	if (mpt_config(ioc, &cfg) || !hdr.PageLength)
+		return;

 	buffer =3D dma_alloc_coherent(&ioc->pcidev->dev, hdr.PageLength * 4,
 				    &dma_handle, GFP_KERNEL);

 	if (!buffer)
-		goto out;
+		return;

 	cfg.physAddr =3D dma_handle;
 	cfg.action =3D MPI_CONFIG_ACTION_PAGE_READ_CURRENT;
@@ -4267,17 +4264,14 @@ mptsas_adding_inactive_raid_components(MPT_ADAPTER=
 *ioc, u8 channel, u8 id)
 	cfg.action =3D MPI_CONFIG_ACTION_PAGE_HEADER;
 	cfg.timeout =3D SAS_CONFIG_PAGE_TIMEOUT;

-	if (mpt_config(ioc, &cfg) !=3D 0)
-		goto out;
-
-	if (!hdr.PageLength)
-		goto out;
+	if (mpt_config(ioc, &cfg) || !hdr.PageLength)
+		return;

 	buffer =3D dma_alloc_coherent(&ioc->pcidev->dev, hdr.PageLength * 4,
 				    &dma_handle, GFP_KERNEL);

 	if (!buffer)
-		goto out;
+		return;

 	cfg.physAddr =3D dma_handle;
 	cfg.action =3D MPI_CONFIG_ACTION_PAGE_READ_CURRENT;
=2D-
2.40.0

