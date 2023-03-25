Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5811AC6FD1C
	for <cocci@archiver.kernel.org>; Sat, 25 Mar 2023 09:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=5rnL4182HVf+VrU/r7ihbrpoXdcBHnNPOCNy8mgPyFk=;
  b=blzLXU0pxoDUxwFeHPJaNGqpAxVBnX7yzeqHOsjgBmHidpaexO32MLt1
   Hyi2wWjteswV6+Rmx+woEdFJtHFawPwdcCRqck6Pitxa9SUFUazWPkSUo
   gVq3UUD7w4otog9xunv29J188tVTDDvOt1ysqpukxHafHUJdEV0WkykO7
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
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="99045148"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2023 10:10:31 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C66C2E0D42; Sat, 25 Mar 2023 10:10:30 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 79BF1E0D40
	for <cocci@sympa.inria.fr>; Sat, 25 Mar 2023 10:10:26 +0100 (CET)
IronPort-SDR: 641eba83_HxWfRymtUmsboVJa1/Urjw8OwxgEcnLDiblJ3MR2V6Fgi2s
 dPFyzKnFZLCPx9FYIMCk6wd5cwJWwpgoWUDpZvw==
X-IPAS-Result: =?us-ascii?q?A0FCAwCjuR5khk7ASNlaHQEBAQEJARIBBQUBQIFPgi6BS?=
 =?us-ascii?q?y8EC0aEU5EBMYQvhyyQI4MWPg8BAwENQQECBAEBAwQ4hEYChToCHQcBBDQTA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBAQIQAQEBGAkZBw4QBSKFa?=
 =?us-ascii?q?A2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEgJHUz0DAyMdAQERJ?=
 =?us-ascii?q?gEPHwYCHwcCAlcGAQwGAgEBgnqCKAEDMQexJ4EygQGCCAEBBpwKHywiU4FeC?=
 =?us-ascii?q?YEULY0FgzZ6Jw+BVUSBFScMgzWIHIJngQyYRgqBNHWBIA6BPYEEAgkCEWuBE?=
 =?us-ascii?q?ghrgX1AAg1kCw5vgUoCZEyBHiUEDgMZKx1AAgELOzo/NQYDCyAGWGsCCSMRE?=
 =?us-ascii?q?wUDCxUqRwQIOQYcNBECCA8SDyxEDkI3NBMGXAEpCw4RA1CBRwSBCoEBBgEmJ?=
 =?us-ascii?q?JpxAgGCZ4EPgnXDJjQHgiiBVYFZDJ8MBhMulwgOBpIjki2FPSCneoF6I4FcM?=
 =?us-ascii?q?xokgzZPAxkPjiAZHoNuj0dANDsCBwsBAQMJhUYBAYV7AQE?=
IronPort-PHdr: A9a23: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
 iM=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:FS2bD67X38JktndOLwPXwBzXdLJyesId70hD6qm+c20wTiXqrb
 HMoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhX4tKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkYNDSaNzhHZKjBkWyFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="99045145"
X-MGA-submission: =?us-ascii?q?MDESJcYFgIp6eF4r0RBKCCN8gTZlV1kUhcgXyN?=
 =?us-ascii?q?D2MgNsazbAU8IrtspGUm2vgpzchbHgEdGDfU32b6r0RqyPxoBwzIARlR?=
 =?us-ascii?q?3aPhhqlEp+hDJ6GGyZQKtfMgCSfuKI0M0YAulePgFXe6XfstH4uCg1xX?=
 =?us-ascii?q?VeTtvxGtqsF8sZyJeRCnofew=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 10:10:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679735425; i=markus.elfring@web.de;
	bh=a8UrZPN5DyNXa/e97H5Lr67zVbMcpnJR74lNRXgHk/0=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=SQUyyTD4uXywtbWCxAXaGR4Kkr5M7O8KaaLXO8Am7uIBiXXC9RD38cDeWM/EGrZ+r
	 oZepH0cwsjx+TjnqhvVu7Wu3HwSW19QtW0wUjvXAd2d6jBHLsTgSuauHgO2cKMD8Yk
	 YD/4qwbwAoU2lbceePUEoXhk5HHDlbkR7zD9CnFjjY7nK/hG0CQCico8tvCc31CmLz
	 0gnZnLslAwfnd61lqvyU3aOscxgTZuGXKaX6rFnKjM5n7BUQic/O3PKPfVLx39iXkR
	 BL8CRzo4W4j007vXPxtOrGxLzOABNoZNUeI5S8Bv03pTZJhDI1439nutN4Blra2yTN
	 LNUSmRxoXvIow==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MKMA1-1pu5MM0VO3-00Lkld; Sat, 25
 Mar 2023 10:10:25 +0100
Message-ID: <01a2eba9-a623-0700-871f-42677cc70d50@web.de>
Date: Sat, 25 Mar 2023 10:10:24 +0100
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
X-Provags-ID: V03:K1:N0PKGN88EH82Vyue3QpslMAr7dg+tQUZuoz4tXzdki2rA14K3OW
 lcA7+2sWxUvjCtwd7Fvlo5KvY+oXBCaEsqcvRbTKrFWkP4OeCviyKOgYruCOQaz5Ubn6Doh
 zY/k2498VFan0EpGgcHxTF8niJkliUgAntDWZCRKgxC4sPLvXJDMpLQ4x3utUmccHSr1qTQ
 QwBpKw8c6PxCykQVB8PQw==
UI-OutboundReport: notjunk:1;M01:P0:bOgi8AvZv8Q=;Q65wxB8krDu4wK8+N3dHm3bA8Ga
 DE1QYif58L3BFRz4Y0TJcV14gT0TkKaki6Swf3ufCjHLspHaEZ8PMiOrfmqkd9eqGLtiZuTZn
 PGb1qPR43tde5HYzcFAn4sST+i0BwWCXGLHA+2QeV0OdlR8Vj6A8VdBUvf00rT5Dbbt8Zw/OR
 hvayANyj5M5g+CrUrbgcjZDMD1cwO8pegJfmO1WIK4m5btcYJijJWy5L+mXm/et2f5aG7g8NW
 MEVEifE4J4B4mfYrWyApfa5VBiMa51hn9EKV+6wgQgl4cMho6EJwPxcQ2xFvJpj5uwrsZJY9p
 be4zzczRAawk26NfmiZci7+RitrltxNVst1edRhfdh2pxIyFkd6RwOutz1cp7RAO3tjoHaFxJ
 mmZXrikUoZTobIlqfY4Ypl4d7rt94aO3ny5DLukaUVkqBhlBZkncHGP1b8qm9dvrqMXCvLbmg
 /qltScIn+ctgu6IYfgUnHbavvDxUQmtZsUEQjsBg1NXnk4lukbNC7ilXSTp0d8z8Ku/5Ew0JU
 Ph4KJJ5rMl/TdZpFH3FO7hYYdhCGQ4VVwN4CFv/1EWZ3RvDxnjSD18KqfpuDZk7hMrQOcQzX5
 na+HrFrNB8sH81FsLjMn29GJ0CBoA899iAbmpmR9DUr88678q2VuwiqdkyTz332OjGlFoK219
 u+QrWLcKOPl6C/qOhok1aEGDqS4roFdVg+MOb3+HguaMSjR3CwADBNAwoXlorkqDxIhHUhsfZ
 lOPvWj0e09AcOtUky0LWABG0Ik4WiWw8VtW1p6+8FHj4vGd4UvUDC8NeqHCEj6BqCLkrJVbrp
 rpQ4X6lFRA618frF7eTROHH331OUJAat/98X+FfMnyYHmZuQXudE/9eZdp3CcoHBQEvmGY61a
 YI2QDRmiF9meJwNmLB69g0A899kgxBx3E4rRqEz2LW6UXBu7/DvKWzAcG
Subject: [cocci] [PATCH resent 3/3] scsi: message: fusion: Delete an
 unnecessary variable initialisation in four functions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 928
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/01a2eba9-a623-0700-871f-42677cc70d50%40web.de>

Date: Tue, 21 Mar 2023 16:15:40 +0100

A local variable will eventually be set to an appropriate pointer
a bit later. Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/message/fusion/mptbase.c | 4 ++--
 drivers/message/fusion/mptsas.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mpt=
base.c
index 59420590c5f7..60927c0ee4b8 100644
=2D-- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -5652,7 +5652,7 @@ mpt_inactive_raid_volumes(MPT_ADAPTER *ioc, u8 chann=
el, u8 id)
 	CONFIGPARMS			cfg;
 	ConfigPageHeader_t		hdr;
 	dma_addr_t			dma_handle;
-	pRaidVolumePage0_t		buffer =3D NULL;
+	pRaidVolumePage0_t		buffer;
 	int				i;
 	RaidPhysDiskPage0_t 		phys_disk;
 	struct inactive_raid_component_info *component_info;
@@ -6230,7 +6230,7 @@ mpt_get_manufacturing_pg_0(MPT_ADAPTER *ioc)
 	CONFIGPARMS		cfg;
 	ConfigPageHeader_t	hdr;
 	dma_addr_t		buf_dma;
-	ManufacturingPage0_t	*pbuf =3D NULL;
+	ManufacturingPage0_t	*pbuf;

 	memset(&cfg, 0 , sizeof(CONFIGPARMS));
 	memset(&hdr, 0 , sizeof(ConfigPageHeader_t));
diff --git a/drivers/message/fusion/mptsas.c b/drivers/message/fusion/mpts=
as.c
index 5c51339dfb9f..0f8eca1b5ed4 100644
=2D-- a/drivers/message/fusion/mptsas.c
+++ b/drivers/message/fusion/mptsas.c
@@ -682,7 +682,7 @@ mptsas_add_device_component_starget_ir(MPT_ADAPTER *io=
c,
 	CONFIGPARMS			cfg;
 	ConfigPageHeader_t		hdr;
 	dma_addr_t			dma_handle;
-	pRaidVolumePage0_t		buffer =3D NULL;
+	pRaidVolumePage0_t		buffer;
 	int				i;
 	RaidPhysDiskPage0_t 		phys_disk;
 	struct mptsas_device_info	*sas_info, *next;
@@ -4245,7 +4245,7 @@ mptsas_adding_inactive_raid_components(MPT_ADAPTER *=
ioc, u8 channel, u8 id)
 	CONFIGPARMS			cfg;
 	ConfigPageHeader_t		hdr;
 	dma_addr_t			dma_handle;
-	pRaidVolumePage0_t		buffer =3D NULL;
+	pRaidVolumePage0_t		buffer;
 	RaidPhysDiskPage0_t 		phys_disk;
 	int				i;
 	struct mptsas_phyinfo	*phy_info;
=2D-
2.40.0

