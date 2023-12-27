Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD8BC46CD4
	for <cocci@archiver.kernel.org>; Wed, 27 Dec 2023 10:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=fnaZuvDgAmJ8WilQ4afAiNgYa1xuyR+joX2/cuNXWl0=;
  b=CPI6KkXhOwU2y2evXxtC1svxVXTIQ1kSjKvQG/xsuXpasb5nomLV2h7R
   +l53q48KMTmL3QIWERoKZoFv9utCOc2SucNbDeq7XH7HoSaNpsFCfvYXX
   8qRuQ5TZvRTY7JfDDoxKMDNhDWBkPM7TAG5Hyz/Ly2gVk1Q5ei+rvsFoD
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
X-IronPort-AV: E=Sophos;i="6.04,308,1695679200"; 
   d="scan'208";a="144117796"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Dec 2023 11:05:19 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 732EEE0CCA; Wed, 27 Dec 2023 11:05:18 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 0326EE004E
	for <cocci@sympa.inria.fr>; Wed, 27 Dec 2023 11:05:12 +0100 (CET)
IronPort-SDR: 658bf6c7_88rzWnkOiAJ1hB3quifVPhFC6GsQwl2a1Z9dj1MBtpahSWX
 w2Tqn0wzppxxUlMnG6AFIhS8i8f74bT/qMiff1A==
X-IPAS-Result: =?us-ascii?q?A0GTBAA+9otlfQsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+COX9TMgQLSIRTj0GBdS0DhDuHNYw3hASDFj4PAQMBDUEBAgQBAQMEOIFTg?=
 =?us-ascii?q?WCBFAKHNgIeBwEENBMBAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECE?=
 =?us-ascii?q?AEBJBgGDhAnhWwNglwBEIEMgR4BAQEBAQEBAQEBAQEBAQEBAQEXAkdCAwMjB?=
 =?us-ascii?q?BkBAREmAQ8fAQUCHwcCAlYGARICAQGCfIIrAQMxB65wfzOBAYIKAQEGr1gfL?=
 =?us-ascii?q?CJWgWAJgRouiBsBhWeDQXonD4FVRIEVJwuDNogegmiJGwcygh2DUJFXfQVBc?=
 =?us-ascii?q?BsDBwN/DysHBDAiBgkULSMGUAQoIQkTEkCBXYFSCoEBPw8OEYI+IgI9NhlIg?=
 =?us-ascii?q?lgVDDUERnUQKgQUF4EPbhsSHjcREBcNAwh0HQIRIzwDBQMEMwoSDQshBVYDQ?=
 =?us-ascii?q?gZJCwMCGgUDAwSBMAUNGgIQLCcDAxJJAhAUAzsDAwYDCjEDMFVEDFADaR8yC?=
 =?us-ascii?q?TwPDBoCGx4NJyMCLEIDEQUQAhYDJBYENhEJCygDLAY4AhIMBgYJXSYHDwkEJ?=
 =?us-ascii?q?QMIBAMrKQMjdBEDBAoDFAcLB1IDGSsdQAIBC209NQYDCxsGPgKmRQdTKBNMJ?=
 =?us-ascii?q?oF3DZJ5sgg0B4I0gWCBYQyfKwYTL5cmDgaSVB4Qh1CQTyCoRoF6I4FcMxokT?=
 =?us-ascii?q?4JnTwMZD44gOINzj0dANTsCBwEKAQEDCYVGAQGDWoFGAQE?=
IronPort-PHdr: A9a23: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
 XE=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:WU/5ZqBm7kS+RJ/lHel455DYdb4zR+YMi2TDGXoBLSC9Afbo9P
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkOss1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QFJSWY+eRMbEVt7ee3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-Talos-CUID: 9a23:nPTclW92KWUstGN2+7uVvxcROO8ZXGb59Sv/L1OmKkdGVruJZWbFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3A/cFOSAwhL1KiPjRPMpbnnvwpREWaqKb1EBgWwJM?=
 =?us-ascii?q?nh9OZBSl+Pi+NkD+0G7Zyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,308,1695679200"; 
   d="scan'208";a="75398542"
X-MGA-submission: =?us-ascii?q?MDFXqV39MABBwIS2Z8WCx1KChcd+HV2JdDFX0U?=
 =?us-ascii?q?UNGKQ5m132ejpZMDNK9WhhKcNh+vFDAac8fLdwe02qNnMveWhqr2DCcB?=
 =?us-ascii?q?VufxK7apZXywe+lrOScEGpS8JB/ErmUIn1Gc8EOPweKLLm8Ov9YDoW0O?=
 =?us-ascii?q?0AzcgcHYArw1P39hJYpIEdUA=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 11:04:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703671494; x=1704276294; i=markus.elfring@web.de;
	bh=xHDdrd92yyItWY6iNqPqDxvi3VGdAbzM/GdBjxnBIjU=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=i0yqvxdibEe/ej4aoOGhrJ+jRkN1c/4v7nVEuREJzalFp5jep2qKiJb9N8EutEY7
	 jWLfSSEM0Fk3F0tu2FXYK+vH/P3q8U831CsjHNIHkepOKsGspQp/x30qYHjHRZDjw
	 x9zOqgYs8BQd8jB2AgRYajo1aPr6Qlx6mwAcxD65Vgu1+wtoXsM/Idvv+4P0ZvJKu
	 hFLV7n2Wthsgo1dWHb6PxpZMkOIBJODEeV6WOXwMzukKLr3LvNn6VQ6MkrcA8eCBj
	 gUqerzoYx2ff56ezZjXb7PwinNy8EXOQeCpQek1sscOdzAshyax8cCCy/g6jTHF8j
	 BhhZXSzU62GAeqh44Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M59jC-1rJWi20DFk-001LeM; Wed, 27
 Dec 2023 11:04:54 +0100
Message-ID: <3d16ddfe-f10a-4188-a9c6-e92655c0b01a@web.de>
Date: Wed, 27 Dec 2023 11:04:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-scsi@vger.kernel.org, MPT-FusionLinux.pdl@broadcom.com,
 kernel-janitors@vger.kernel.org, Sathya Prakash
 <sathya.prakash@broadcom.com>, Sreekanth Reddy
 <sreekanth.reddy@broadcom.com>,
 Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <c8b0d40c-2f48-46fa-8311-258985e9eee3@web.de>
In-Reply-To: <c8b0d40c-2f48-46fa-8311-258985e9eee3@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BXTXEcL23YW2+L4v3sU1O+CqZc9VLmoulmh0iGtLNO9bLfdJ2Py
 qEWNjvHmkGprxRLQJFq38Tl2jiUPQ2Yflt8EDKQOgoBsVCqGoFoEmEK0hxdNS1FgzAUaNji
 5Dc7sKFUWHs3BqAPNJ72IqbzZbCVecbHkDAdnag9IVBBLDg04WWMFyka/2jb4iXJeC0xrd6
 ZbmBv/W860kVn6g5bl7gg==
UI-OutboundReport: notjunk:1;M01:P0:aqVwaolc6BE=;EIRN57N0btRcuRJ3W4C5usXyncP
 stxFd72pw0T5isIca5Thm+fqD9O8fOUsGKshK/83BZBiR9e07lir80XRa78D/u/wGvJocyQr8
 WvKhzEjt+ndqNGXLYTLGg4GtBX1PvdrVUkFjQ2dgfmpEj4N/Waad/yrZh4sfkUDfChErWyi0t
 M4Ci/lOY5fYbRyUj7rrd1nJvrrmFad4m5eUaFupyuPy4qUlNjiAEovVJW/l0l0CvpshGRjWaV
 r5EFHh9jRIAt+P2yKEDflAAFkLSqDbKKCbnZ+xlCUf3pe2GfRtVxFH/p1uIY90LCaZbLMoBPK
 /67jghay0/WfqfSZyOpZEibZuz7oSRTSuMmXmS36Klv+aRhepaE1GIIA3/Duzmk2ZCJbLTFkE
 0j7Il9O0OHuXMEUjn1Sm3/apTXBeN+SHvif33yA7w3fHm+rIDpsfuwNVHrGQwbiKTQU9C/V7M
 WTtue0Sn0dNO9NWLhGIG6rIGzUeBJq5iargl8JE6+4RUJEEtWOPAW4bGEJfC+VhSqa2/ebglw
 rheV4n/Hdphy/r72r5NyzjMa/GZJAex+QZNnr/2GMmEbiGhlv9v/LVvm7b/SsEKjd+zyrN5dk
 KuNWKzKSV9OrMbTai5sYf+2aerR7w5G4DcQ6/ZfjP9Ij12F4Mg3K/wkYU5be+ZcVIL9EXzNr4
 p8zW5b8BdJ8DFqiySuhLttyX7TJFQOtFiUUZJVePRb8MLlAXbKpug2uRVa0w6TiqaCwnGOq6g
 CNim5BeYCRDPbm4mlil5MiicZsh+g5yaAJy3zTl7c/VXHStiGsP9hYyvw36ny4SwLLpxjHFgZ
 Jzka5W3eFkdZVGcJ+T1iEGUVAWAS1l9DFEKAfCltopP29NAY7YkR1g1+3CUqHpkRFLOwyL3o1
 wOwgv7bLW0S+ls2Oy486bROCWlzKL4cuR/M7fV2U0wRnqbwypJiF4ShRrI7J22UbpLY5THMSO
 aexB4TtOW3FeZmGDRBMRbq9utgs=
Subject: [cocci] [PATCH 1/2] scsi: message: fusion: Improve data processing
 in mptsas_find_phyinfo_by_phys_disk_num()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1410
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/3d16ddfe-f10a-4188-a9c6-e92655c0b01a%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 27 Dec 2023 10:23:09 +0100

The kfree() function was called in one case by the
mptsas_find_phyinfo_by_phys_disk_num() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

1. Thus use another label.

2. Delete an initialisation for the variable =E2=80=9Cphys_disk=E2=80=9D
   which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/message/fusion/mptsas.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/message/fusion/mptsas.c b/drivers/message/fusion/mpts=
as.c
index 300f8e955a53..452635a50c4c 100644
=2D-- a/drivers/message/fusion/mptsas.c
+++ b/drivers/message/fusion/mptsas.c
@@ -4171,7 +4171,7 @@ mptsas_find_phyinfo_by_phys_disk_num(MPT_ADAPTER *io=
c, u8 phys_disk_num,
 {
 	struct mptsas_phyinfo *phy_info =3D NULL;
 	struct mptsas_portinfo *port_info;
-	RaidPhysDiskPage1_t *phys_disk =3D NULL;
+	RaidPhysDiskPage1_t *phys_disk;
 	int num_paths;
 	u64 sas_address =3D 0;
 	int i;
@@ -4182,11 +4182,13 @@ mptsas_find_phyinfo_by_phys_disk_num(MPT_ADAPTER *=
ioc, u8 phys_disk_num,
 	/* dual port support */
 	num_paths =3D mpt_raid_phys_disk_get_num_paths(ioc, phys_disk_num);
 	if (!num_paths)
-		goto out;
+		goto lock_mutex;
+
 	phys_disk =3D kzalloc(offsetof(RaidPhysDiskPage1_t, Path) +
 	   (num_paths * sizeof(RAID_PHYS_DISK1_PATH)), GFP_KERNEL);
 	if (!phys_disk)
-		goto out;
+		goto lock_mutex;
+
 	mpt_raid_phys_disk_pg1(ioc, phys_disk_num, phys_disk);
 	for (i =3D 0; i < num_paths; i++) {
 		if ((phys_disk->Path[i].Flags & 1) !=3D 0)
@@ -4211,6 +4213,7 @@ mptsas_find_phyinfo_by_phys_disk_num(MPT_ADAPTER *io=
c, u8 phys_disk_num,
 	 * Extra code to handle RAID0 case, where the sas_address is not updated
 	 * in phys_disk_page_1 when hotswapped
 	 */
+lock_mutex:
 	mutex_lock(&ioc->sas_topology_mutex);
 	list_for_each_entry(port_info, &ioc->sas_topology, list) {
 		for (i =3D 0; i < port_info->num_phys && !phy_info; i++) {
=2D-
2.43.0

