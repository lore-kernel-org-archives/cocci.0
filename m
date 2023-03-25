Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E3EC6FD1F
	for <cocci@archiver.kernel.org>; Sat, 25 Mar 2023 09:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=PJ3x3c3wdZuib7AnEIA7IYqMXSjXZkYM7nu/DdZB+vw=;
  b=tHdkpplKa1DbmbOJLLFNALdb8pj3xKitjHyNZ2ACCcG9TXFLj8MZpE4J
   t8yFxJWFZQ3kPPErGdhRgInLDG/uhBqbmXlppNzgz0tKdk58O6NndVYOk
   ophGqLynZ/kwoOP4Mlqj0tY4YLX3LQlTWhB6ff7CCxi6F29vuTnnVVZ3m
   4=;
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
   d="scan'208";a="99047965"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2023 10:44:12 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D0D8EE0D44; Sat, 25 Mar 2023 10:44:11 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id DA7E6E0D40
	for <cocci@sympa.inria.fr>; Sat, 25 Mar 2023 10:44:06 +0100 (CET)
IronPort-SDR: 641ec266_X03xvs9WRY61XgH7f9+hihCU/jdrv4Lf1ECse0U9Ka/BtG7
 MZxVKJ2rVj8991ClVSIWrBNhTHMBsv5bcE1tWdQ==
X-IPAS-Result: =?us-ascii?q?A0ErAAAcwR5khw4P49RaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YItgUsvBAtGhFOIH4hiLgOEL4csjCGEAoFWgUA+DwEDAQ1BAQIEAQEDBDiBU?=
 =?us-ascii?q?4JzAoU6Ah0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAEBA?=
 =?us-ascii?q?hABAQEaCRcHDhAFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QESAkdTPQMDIwQZAQERJgEPHwYCJgICVwYBDAYCAQGCeoIoAQMxB7EjfzOBA?=
 =?us-ascii?q?YIIAQEGgmOZJx8sIlOBXgmBFC0BjQSDNnonD4FVRIEVJwyDNYgcgmeCKI57i?=
 =?us-ascii?q?C8KgTR1gSAOgT2BBAIJAhFrgRIIa4F9QAINZAsOb4FKAmRMgR4lBA4DGSsdQ?=
 =?us-ascii?q?AIBCzs6PzUGAwsgBlhrAgkjERMFAwsVKkcECDkGHDQRAggPEg8sRA5CNzQTB?=
 =?us-ascii?q?lwBKQsOEQNQgUcEgQqBAQYBJiSacQIBgmcBUjtMJoIEkliSQJ4ONAeCKIFVg?=
 =?us-ascii?q?VkMnwwGEy6XCA4GkiMuhy2QDyCneoFjOoFcMxokgzZPAxkPjiAZHoNuj0dAN?=
 =?us-ascii?q?DsCBwEKAQEDCYVGAQGFewEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:bu2iYKC6aaFja0HlHel455DYdb4zR+YMi2TDGXoBLSC9Afbo9P
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkOss1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QFJSWY+eRMbEVt7ee3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="99047960"
X-MGA-submission: =?us-ascii?q?MDGsq0LStgcX1w77f/EgLcPMdKPZpEzYmIigyK?=
 =?us-ascii?q?EMKEfUzSlJasrAcyLOmy+f8px2Epmj/EbpWsF+QXK+BnCi3X8GidLO+Q?=
 =?us-ascii?q?FnbGFD1hqXBvDjEfWz2gHsPQdRTwGPXeb2WQocm0dEIsF7GwS4/QP0Fk?=
 =?us-ascii?q?NLmmSsfEEfFFAyFtHMcgcj/w=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 10:44:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679737434; i=markus.elfring@web.de;
	bh=KT3i+XCwOpBgEiE2fWQZLWXtbQK7aLmFAw3Ez2jHa1Y=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=jboFmKu+n5eM01Gkil+cVMh5DMDjPj6tHWmGomWZU80m4AImJbbCpEE4l3yah3gUD
	 irYtT4Ppy/lwuuS2YXz98HB/UQ6BDvckGWSQEIwPRDdAdl0SXghKZVsUKjIZ6VHrrd
	 zitnxGwyxe7jx6lOb3SkZxJ5Lt1vlkeO5fjQ+8gLZ/grYkWA6jFRQLe1aJAcTjv5VR
	 +Y6zy5OFJBgBishIuj4g3KpLWWg4xsnzZSIeE/IZCEbS6ohlV94rL48odPs6hk274o
	 N+XcEgi9wFINHRZdV31Xo8lYOCRBaIdkcAXKkPiiDaSfBhLAmukTxjE8Xc94dqn1x0
	 GfG8h8RHORWDw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Myv70-1qRf6e1jH8-00vo7V; Sat, 25
 Mar 2023 10:43:54 +0100
Message-ID: <5eeddd9f-7e68-6798-5a17-76e59278d968@web.de>
Date: Sat, 25 Mar 2023 10:43:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-mtd@lists.infradead.org,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <3675f707-bff0-3caf-29a2-b99e5b9c6554@web.de>
In-Reply-To: <3675f707-bff0-3caf-29a2-b99e5b9c6554@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SQOftfhZ5atvEUhY7+UaBk+J1ViVanb6XOugrqglrpZOrM5Ik0W
 vpnNbosTgnEQfItq5M5SrJOabW58VJd/dMZhN3LoHsE6JBic2otGqR1iqFNSg5AclLMwJb7
 CzF8vv2SlGzRpy/lhPhEvUeYgAWPZRGxTLgFMNAeWH5W1v0APcVI9nTAcovkmOGooDSkmB9
 vpyDWgrhFLUvrDf6bEakw==
UI-OutboundReport: notjunk:1;M01:P0:mIYw/rqJ+Zw=;muK+JFnOyudj8qp9W8OGaC/Y0e2
 Dw/VEetUaxOzhTaaHQEtNccC48YQL0q6QrpAo3MbP6Rf/Gi5fXC+JwclfQhcgjHjYPNxi1DY4
 L4kpMqyPXaaaWOMG5On6TvKTt2Wwa/bjSe9L9ZWCrXLNGmybgRYa9M0T+Bh4Y25e70E2rDtdR
 E+7dnz/cu47qstp9Fk55z+hcTN0wIc7L5etSTjPKhyxztLM5EY2cgmAbn7lGK6DLRtBv+P574
 S/JKE6UcG0uifuHvsaKIFe1sbFPjd3IfakZtWn+K9A9jqqMtWFyk8F5BuCRRIybVfGYHZgy+z
 7Vw86hpdgSMqPfEEVGhryqdyoeakNXJUn9etqdw3OPKQvsfc25v3yyckgfPkRDk9GxdJHC+i1
 xVgNf2YlLyCg9fj7zvJuaR3z43eQ1CgevrLG+oIGFWkReWj8XpfEjIsYCqKRTQyUDzoGpzHNs
 NMvQVueCm73ntmM1XBFEVidLGSXENGelAIUwOFyX6J6rHImJb5yaomiCJkI/6o3kZ6Q5OJQLU
 ypBNbmz+0UTD+b1Rmno7Qo9G2csr/uHkEkaSHZtcoX0PhTB73zrr4jtd31iqOqMSd3BVB0cJW
 5zm/fdHQm6Tk0P5mDfhVS83kZMRAJXWtDhJmA0Ffe3/fdU8JVwvQ3rgRlLYNkkiKX03mwfNSM
 AfcTZqhFrv+z+C+Ht06JzpIUzfsgYcNQ+OJNWyOMFzVObctuFcbCevpvJh7YD3BVAC0aPARj4
 W0/sKAX9CQ7iLoLl0Xe7+mKSTDkldwsk+K+opnjUI04yS1Ag7NTrId4lVezpa2ny+GxfNf6v0
 3cPNCWExWWIjxzsbUZNTbCSHQlmkBPJJz9ZqAzmfuUtPswd1le7PCRL+GNFxiUmeXP+GCysst
 gX7lfOK3GeTGFHV1caRB35HKkFTpLjrjCAQmuVFZggijGy+bRJ6BS0P7k
Subject: [cocci] [PATCH resent] mtd: cfi_cmdset_0001: Fix exception handling
 in cfi_intelext_setup()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 934
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/5eeddd9f-7e68-6798-5a17-76e59278d968%40web.de>

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

Fixes: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 ("Linux-2.6.12-rc2")
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

