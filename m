Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 493D4C282DE
	for <cocci@archiver.kernel.org>; Tue,  4 Mar 2025 19:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=7bItaIpL50iONjJ6ezepTySgEuIy1conWnocyy7c1HI=;
  b=n27S+ikr+bANOM9ShRQdTGBvlqRNwwWS6VPb2ckVHcxEn8MZsVeHjemx
   b2jK/MKMZ2kHdXl85lT2kCQVPvLzIgFeqVY9+7KgA3qEeWtJVEfIJoWHm
   uAM+pBufgUo1JFQOcZDYNgKVFl/7B2X+qURmI2KLT08CcpygbfbGTH6um
   Y=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.14,220,1736809200"; 
   d="scan'208";a="211199626"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Mar 2025 20:22:12 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EDEFAE0D1D; Tue,  4 Mar 2025 20:22:11 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D1B3DE0260
	for <cocci@sympa.inria.fr>; Tue,  4 Mar 2025 20:22:09 +0100 (CET)
IronPort-SDR: 67c752e1_V2dpTzJ0A4I9HIp7TLELtHSiepUPnhpEjX7zM1Kcidi+VIt
 tEG7B79EObuBNrBbzUuCi5fdBnhw6IxqBEd32Vw==
X-IPAS-Result: =?us-ascii?q?A0E+AAD5Ucdng07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBAtIhFaIHYcygXQtA4Q7hzuMQoQGgVaBfg8BAwENQQECB?=
 =?us-ascii?q?AEBAwQ4gVSCdAKLFgIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECA?=
 =?us-ascii?q?QECBAYBAhABAQE6Bw47hXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QCAQMjB?=
 =?us-ascii?q?BkBAREmAQ8fAQUCJgICVgYBEgIBAYJ+gjABAzEHr39/M4EBggwBAQaCaddzH?=
 =?us-ascii?q?ywiV4FlCYEaLgGFa4JjAYVrO4Q8Jw+BVUSBFSeDQYgegmmCM4Fqgz2BbIpTH?=
 =?us-ascii?q?C2CJZkwgU0cA1ksAVUTFwsHBYE5OAMgCjQUBBkCFCwGEARqQzeCRWlJOgINA?=
 =?us-ascii?q?jWCHiRYgitqBAWDW4Q9hECCQVGCQoIRcYEXgjGFUIEthHAdQAIBC209NwYDC?=
 =?us-ascii?q?xsGPaF0OoRBAVI7TCaCBJMMk2mfHTQHgjiBZoFjDJ9eBhMvl0UOBpJ8AS6HZ?=
 =?us-ascii?q?TWQNSKpD4FnOoFcMxokgzZPAxkPjiEZH4N1yDlCNTwCBwEKAQEDCYVGAQGKV?=
 =?us-ascii?q?IFLAQE?=
IronPort-PHdr: A9a23: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
 bIRR7UdWFFnTpsn
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:h6B+tqE4bK+qXGJwpLqEPMeALOsnbusQ8zAXPo5KOHlom7+j5q
 eTdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/hzAV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAsxD4bbLbWSS4/yKgjWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-Talos-CUID: 9a23:3t+sRGCWqsmJepn6EzFB8hUdMc49SXf64C7CPGiCJF15RaLAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3ArHsWhwyGVmoGGawJz4cKuy8PaqyaqPq/GAcVkK0?=
 =?us-ascii?q?jh/CBbAF3F3CcsRSzXYByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,220,1736809200"; 
   d="scan'208";a="110662266"
X-MGA-submission: =?us-ascii?q?MDHKJ/UdLq+ohbiiygF2KbwrEGEtFnj6nDf1PM?=
 =?us-ascii?q?pLQy/TPmraJyXJIlHnDoCSBG5IlCgqeWYgd3rZJkmDPkF+l+qaNRry5x?=
 =?us-ascii?q?tUHtfX9LwBoJvU38nw1L1LlF7Zfy/NLK7k//ZcuS+9sdh2YDqkaNdRsM?=
 =?us-ascii?q?lE8iDi+ORddP3JN7Z52L+GBg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 20:22:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741116117; x=1741720917; i=markus.elfring@web.de;
	bh=7bItaIpL50iONjJ6ezepTySgEuIy1conWnocyy7c1HI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KBZjIhKSGu+H7K0E+EmJW7txizonPwtF66pEUvS9fagnc5l+pb/HAzddRr0fZCu8
	 PHvrGleKfwz7NzUpkhSAz7ojIfz623sJAYVysL5zi8T6FQwuuSmwEQhx0XTjQu5F6
	 7k4yw7oQB2QPMVS6Pb+Bjwz5at56x9RfJX6+qTZiwBi7bSSDpmUP67ZGAF04lrgVD
	 +yzDbRQXcVoYn8OhHOSdnTX9EnFXc4jUEJ5wfG2kNY5815IqMilwXFnq1wWmaysjG
	 R0KQE6kQmLAbyACKj+dcKdL9PPLzAuJSpjWKP0cM7+hRbOFqM0HTuRSd4iNjdDrTc
	 sWSTHq6uie7WC9Qv/w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.64]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MfKtN-1tMFUk24Et-00nQUv; Tue, 04
 Mar 2025 20:21:57 +0100
Message-ID: <d7b2c8ac-e052-4b93-964b-4cc58a459ba0@web.de>
Date: Tue, 4 Mar 2025 20:21:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-mtd@lists.infradead.org,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <3675f707-bff0-3caf-29a2-b99e5b9c6554@web.de>
Content-Language: en-GB
In-Reply-To: <3675f707-bff0-3caf-29a2-b99e5b9c6554@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qKFVHeZFM8z5ZXsxO57qi6A5GLqriqNvol5/pp2fC4KpApqiHG1
 JjUKwLrZAmwzXRM5ufs7amW+9qBBkD9yaLqmHKD8kkpwnPbN3gkC4y4NhG4sgBQSKVOSecT
 4PQYkNBXjfG+6QnCVZwruHG9o6ZwvJhk5dwQql7N6A+YbNOar8t2XaQhNzJOkpi9VWhjW4i
 3SkCydtmLEmhP4fG/46zg==
UI-OutboundReport: notjunk:1;M01:P0:7XhKd8N636g=;17LWSq/5A434rFvDzWDT7dvIXld
 67ohFCtij2fYZibsznLRTKx3adqcpAeJos1pj2NqbmitXewkIUxZrE84wL7fQkp2HqQgFULKG
 ED4aqqTgQyTICT3Un2pIbMx4+r403h16ErubFPZ7bAJgdrmWJKUzEw6ypD9KxZuk8LhwGhJz4
 g9MFzPBSCuQUACLvaFGSIJrNE1BEZrZxROkkluMV+YwAmmYABU5Vk41mI7ZzOAK+E9owC6hj3
 a1HLMuTImfMKcsiZOA8C8pnIhzyy68kmJomSP6zgGn5SAOTrwdHwYuHb0F0RXnEKjp6WwXIzT
 v2lJN7Q9xyEgjrwgpU8iqjLOaVsxWbsmj6iVT24JLytlb5iCPzEeI7g4psektbejP9wkVtN90
 h66aMzIVqLFgj3SxnbEDKAm6CkTa7+3bvj6UDcUdqgvQzInIPURcy0KBd9uXUbmaMTu789f+t
 RRG17WIP+3K+Dhb/CW7PsYF4M1zMdu3/xLWFfn/6R/5giK6pXD0TiM5LzEn64WTETY2nmVShF
 5tU76uLwnNehzLOPg9iuYWzAkimO4jRITTxuNnQkWH4Rhwpjsz8v6hXBRDk/xmHANgAUv5REY
 TgEvBXxIqKi0N2eeP3F1zmdMfK14qFvQMSpVpgzSZUGTtNs17j/MOKlx00bzIu7cWvRNJRJm8
 YYz3cfrzZXxCTTCG+KfdFbXIJRsk4Lz14McTi3X7FlLvDyJQBQcQHf4xEfTQiv5v8OyufYXtw
 nwl51afKB3/+0zjoiwqJ5Cx7x3g05XE/08zuEcJ4Apmi4g0wIENjXaZmk+nvnTWO7pWZcjGug
 RPJT5oWwKzPB6OK7at/sceNmtAxwF5vCLJ06gFAJq1gQTGqccHZ2Cew0arYbRfF6I6kobIt9m
 6BdcT9RC6upuAd7/4sv8lmIn24yEWyUqH4UecKfgTC84vJeG6gdt65tWTZomdDaXyMFg6etQb
 As2CCP08OzyrtfFlfGyKTw3Y9Vfuu7Hb0FVf5+PJAi8IydpmySTAVULT0q8p546JX0IqEndo+
 1Bgk0+0Fr1oWFFNFwxUrSxz0xemK3dT4nuw01F0krrhLXnhNUD0LSzi+TRUorxJXGXzEkmuGi
 t3IF0yWJnOR4fF+SaxhOfHmZ07vxON95iA94gguhdmqUlHeoclxgoOFO6fNV+nHSjS6GT4fkP
 mOnXHJNe6+htnbJvB9RvPIh6W4RuxEsL4gdhF4934ohzyQyl6F/Li0z4mY6Fe/idzLVYeY5nY
 6PpdQP1Aa/nxp9KJxQ/we6A2pAUSav6cbtc+1ngAf8Ty9RftHZ+eynvFm3iEuq6VTHOXsxrdr
 qFvi3N481CAQyQ+dxFFC/f/Fh4y88y9bh/Y4MJpqOfnN7cNjuqDx0gON0XyK62NLQZiR2oNC4
 BF98kTmJ4xPEGfyXGM2//Gmtj3GvAUuNh2CTdZJWaZ5X27uyvHgy9tax3GhmfzruX8TYnVrQP
 Gk/GHoqXkje3IjrImP6HOOtpU3Xw=
Subject: [cocci] [PATCH RESEND] mtd: cfi_cmdset_0001: Fix exception handling
 in cfi_intelext_setup()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2535
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/d7b2c8ac-e052-4b93-964b-4cc58a459ba0%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 21 Mar 2023 20:13:51 +0100

The label =E2=80=9Csetup_err=E2=80=9D was used to jump to another pointer =
check despite of
the detail in the implementation of the function =E2=80=9Ccfi_intelext_set=
up=E2=80=9D
that it was determined already that a corresponding variable contained
a null pointer because of a failed memory allocation.

* Thus use more appropriate labels instead.

* Delete a redundant check.


This issue was detected by using the Coccinelle software.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/mtd/chips/cfi_cmdset_0001.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/chips/cfi_cmdset_0001.c b/drivers/mtd/chips/cfi_c=
mdset_0001.c
index 54f92d09d9cf..a06318cd5ea4 100644
=2D-- a/drivers/mtd/chips/cfi_cmdset_0001.c
+++ b/drivers/mtd/chips/cfi_cmdset_0001.c
@@ -614,7 +614,7 @@ static struct mtd_info *cfi_intelext_setup(struct mtd_=
info *mtd)
 				    sizeof(struct mtd_erase_region_info),
 				    GFP_KERNEL);
 	if (!mtd->eraseregions)
-		goto setup_err;
+		goto free_mtd;

 	for (i=3D0; i<cfi->cfiq->NumEraseRegions; i++) {
 		unsigned long ernum, ersize;
@@ -630,7 +630,7 @@ static struct mtd_info *cfi_intelext_setup(struct mtd_=
info *mtd)
 			mtd->eraseregions[(j*cfi->cfiq->NumEraseRegions)+i].numblocks =3D ernu=
m;
 			mtd->eraseregions[(j*cfi->cfiq->NumEraseRegions)+i].lockmap =3D kmallo=
c(ernum / 8 + 1, GFP_KERNEL);
 			if (!mtd->eraseregions[(j*cfi->cfiq->NumEraseRegions)+i].lockmap)
-				goto setup_err;
+				goto release_loop;
 		}
 		offset +=3D (ersize * ernum);
 	}
@@ -638,7 +638,7 @@ static struct mtd_info *cfi_intelext_setup(struct mtd_=
info *mtd)
 	if (offset !=3D devsize) {
 		/* Argh */
 		printk(KERN_WARNING "Sum of regions (%lx) !=3D total size of set of int=
erleaved chips (%lx)\n", offset, devsize);
-		goto setup_err;
+		goto release_loop;
 	}

 	for (i=3D0; i<mtd->numeraseregions;i++){
@@ -660,18 +660,18 @@ static struct mtd_info *cfi_intelext_setup(struct mt=
d_info *mtd)
 	/* This function has the potential to distort the reality
 	   a bit and therefore should be called last. */
 	if (cfi_intelext_partition_fixup(mtd, &cfi) !=3D 0)
-		goto setup_err;
+		goto release_loop;

 	__module_get(THIS_MODULE);
 	register_reboot_notifier(&mtd->reboot_notifier);
 	return mtd;

- setup_err:
-	if (mtd->eraseregions)
-		for (i=3D0; i<cfi->cfiq->NumEraseRegions; i++)
-			for (j=3D0; j<cfi->numchips; j++)
-				kfree(mtd->eraseregions[(j*cfi->cfiq->NumEraseRegions)+i].lockmap);
+release_loop:
+	for (i=3D0; i<cfi->cfiq->NumEraseRegions; i++)
+		for (j=3D0; j<cfi->numchips; j++)
+			kfree(mtd->eraseregions[(j*cfi->cfiq->NumEraseRegions)+i].lockmap);
 	kfree(mtd->eraseregions);
+free_mtd:
 	kfree(mtd);
 	kfree(cfi->cmdset_priv);
 	return NULL;
=2D-
2.40.0

