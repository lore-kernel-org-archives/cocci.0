Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E7B4C6FD1F
	for <cocci@archiver.kernel.org>; Sat, 25 Mar 2023 08:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=rR7+pf6ZexlyoZtDsku1zjqISGMzM4PRT1W6D1RGhlU=;
  b=aGEoBsLXCjWNsRxkOPWc8GWQMMoPq5PhQMCkSDYrKKvhT6AO5XDJmnF0
   pDsoZn9JFAnD7/QrHyu6UT+KxWaqacFNQJbXjxHWjn/CBDW+Fl6xI4aO5
   I/q9d9/iPF6lConyyMy91vB0HSegjHcLWsYGUjol9dJkaTajw14uEH664
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
   d="scan'208";a="99042367"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2023 09:32:18 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EECB3E0D41; Sat, 25 Mar 2023 09:32:17 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9FEBCE0D40
	for <cocci@sympa.inria.fr>; Sat, 25 Mar 2023 09:32:13 +0100 (CET)
IronPort-SDR: 641eb18d_JAXTC0a8phEIu6m1dgBoIgkhboqfohSLqHdnoqizXvG1zdr
 As5xCJ3yFeFbFqV3RNrcNzlA7Jty/xWcqiRPM4Q==
X-IPAS-Result: =?us-ascii?q?A0EqAAC/sB5khwwR49RaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YItgUsvBAtGhFOIH4hiLgOEL4cskCOBVoFAPg8BAwENQQECBAEBAwQ4gVOCc?=
 =?us-ascii?q?wKFOgIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBAQIQA?=
 =?us-ascii?q?QEBGgkXBw4QBSKFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBE?=
 =?us-ascii?q?gJHUz0DAyMEGQEBESYBDx8GAiYCAlcGAQwGAgEBgnqCKAEDMQexJ38zgQGCC?=
 =?us-ascii?q?AEBBoJjmScfLCJTgV4JgRQtAY0EgzZ6Jw+BVUSBFSeBFYIsiByCZ4Ioh1aHJ?=
 =?us-ascii?q?YgvCoE0dYEgDoE9gQQCCQIRa4ESCGuBfUACDWQLDm+BSgJkTIEeJQQOAxkrH?=
 =?us-ascii?q?UACAQs7Oj81BgMLIAZYawIJIxETBQMLFSpHBAg5Bhw0EQIIDxIPLEQOQjc0E?=
 =?us-ascii?q?wZcASkLDhEDUIFHBIEKgQEGASYkmnECAYF0cwFSIhlMJoIEklgJAQeSL54ON?=
 =?us-ascii?q?AeCKIFVgVkMnwwGEy6XCA4GkiMuhy2QDyCneoFjOoFcMxokgzZPAxkPjiAMD?=
 =?us-ascii?q?QmEA49HQDQ7AgcBCgEBAwmFRgEBhXsBAQ?=
IronPort-PHdr: A9a23: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
 NTCxvqbwNZq9tXJ4Y0DCsKSJM/VaBIc
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:cPChTqjHfaHT9q4i+sfm2Ae+nXBQXioji2hC6mlwRA09TyX5ra
 uTdZMgpH3JYVcqKRIdcL+7UpVoLUmwyXcX2+ks1NWZMjUO0VHARL2KwrGP/9SKIUzDH4Bmup
 tIQuxEEsT5CVU/pczm4A++euxQueWvweSSn/7Xy3oodR1nd60lzwoRMHf+LmRGADJdHJI8Gd
 6n6tFZqyHIQwVzUi1XPAh8YwHYnaytqLvWJSQeDxorrDKDly+s9dfBYn6l4is=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="99042364"
X-MGA-submission: =?us-ascii?q?MDGfCdmynMpbgzYMV3QdTbL1eBDhWWGgL8U2E2?=
 =?us-ascii?q?l7ma65qSjISFIMN+GcM6GVrKOgF9mgMqKWcdzdw2FxROdndU5bbRyEU8?=
 =?us-ascii?q?NItUxhPUHWhE1I6SjaozOgnMevvddBQE2QYoragH40rMjSnOwEs1DavE?=
 =?us-ascii?q?YEVSYueawzOoBr3bg63qwX8g=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 09:32:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679733132; i=markus.elfring@web.de;
	bh=pssSElNdSr6kze802HH6SWYXEnsA3iWWg41+N1vUi4Q=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=TSoH/eqWMhSPd8lP8AGsseBTNA0jLbjvUvvEtiE8BNK1t2gyn7RdAbmu/qUkMlclv
	 lGVwhO4YgI5mwhyOi12pCmBnh7PSnYQt7WdvEvtsCgDpQakLu7X4yD3szDS08RgXK+
	 zSZLiSwmPwssgg0m4umF5NCBnXvUDf9GIZuIHSAIrjzoF3q+lmwzrp+gF/Vgk20laK
	 roN6ILBZ24AzHZ3CygEbzp0TOd4m9dNuun9QWNOczm17sEcsUDLdMy8nmwXuL+jHpp
	 GNAGkJLJNiLfUw1KNcXQC/mFS00Tw6bFJczi3CpfJy5g0WxNlG2UEwCj5Y6gPyHr3c
	 7gZv5zHjDUWDA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MOUtg-1ppP863MPG-00PrWj; Sat, 25
 Mar 2023 09:32:12 +0100
Message-ID: <c9771d4b-ccf9-5def-b004-9db7ecdfed1e@web.de>
Date: Sat, 25 Mar 2023 09:32:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
 Evgeniy Dushistov <dushistov@mail.ru>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <9d975625-672c-ab81-2e78-c3fa48747913@web.de>
In-Reply-To: <9d975625-672c-ab81-2e78-c3fa48747913@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+7G1G2hb4Ak+++hdUFQSVMLr60vSiJ9DmeuaBzPrq4We/ZuNQMS
 BD9t1/8HS5wb7o17smm/tFZfZscapClutTw/xTU9GlWe5NJHHAtDph0oHBjXe/iE97hl9tc
 r/2vMLr1TxHcd1ljJvwvH5Rme3vcq/6clOMrH2eyfvWKyjRn2UQ4+zHO00N0vDNbM7cBMT8
 p4RQ6g9boaRrjidDKVrCw==
UI-OutboundReport: notjunk:1;M01:P0:blgz8S4Mngw=;MsScSl/zYz3w02HvHrXqLizAJ1/
 zd7YNWL9/Gd10J1MYop1ixw8PUQnOKKd3AXag7k9KtQhfaZrdoWioPgVXqT1pdrC3OSdTEIeF
 mYTmNe3AySBCcupez6EwHI5RmD2HRyFwGZE6hk9R1WXtmQ2Hn6HcEbUoT/D9qNl/KbWLMcpCS
 zI8VktZ1yPmkzes7xsNVApdtJoLzO7AFfHzZd0RTyQT/CMl1V960Xc3mcqMiS/cpw28W0AgD1
 /40KSU+/DSE3yNtWQq8El/J6ZzqusCdszYFBW5FFkaGp7B/bcaDfhykVvKMMdzBnhoM2LzgfM
 comLByLew1Z4nPiFqivB1p5L/VXF0XmD6Q7xj3n7cVS/d9laTDXvWkLqZ2Fb6jmFQZzg9l0YA
 3VFDEsLnL75CpvznvujuPIaF3e3VwhWADpwtG6R4bA5faR1H5q1x+/yK5Ufd//4SKuquwLlAq
 PX9hP7ELnOdY9JEQrENdguiepCdT64HMWHhWzEloJKdcJJutxddLHmkeI9RG/vMqxBhEoGFeD
 mb0Pbql0r8iWYh9i22i79J1iJOJvmqk6c6wmoSwpQ2CS1iJB+csAVz45BIu5gmAcQzziXdfCP
 Gfq61ByBz6MoQ7cUac4UKvns2bUpNONTC7gsRBLQ6nGg4gZmKlpqR3dpzoEQFFgn7ypLA+ojZ
 GZKiykvwQ4eGnD1lhBnAQ7gue+7BG7AUbWQgRVzzXbwlAlbexJrUVJ0P1qv15E8G4sWO3+f4O
 D9MDXQcGSRFsFy4pdgLZI9rTpbYd1FNVlPuszJR28FbSxOFzou2XpCuOZ7yQEeMqyBp8XUTVK
 ie3h88Pu0OT514TbQtOBxy1JTOiO20x/kg1me5c9yrLWa49jOtmSdrznQfXX0PkvwnDVL52LO
 +s1q4+Tz+JFOIdIFLtIXbnY90zDx7SLF8AGmvbCPTg2tzfXkODHESyCOZ
Subject: [cocci] [PATCH resent] ufs: Fix exception handling in
 ufs_fill_super()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 923
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/c9771d4b-ccf9-5def-b004-9db7ecdfed1e%40web.de>

Date: Wed, 22 Mar 2023 21:50:45 +0100

The label =E2=80=9Cfailed=E2=80=9D was used to jump to another pointer che=
ck despite of
the detail in the implementation of the function =E2=80=9Cufs_fill_super=
=E2=80=9D
that it was determined already that a corresponding variable contained
a null pointer because of a failed call of the function =E2=80=9Ckzalloc=
=E2=80=9D
or =E2=80=9Cubh_bread_uspi=E2=80=9D.

1. Thus use two additional labels.

2. Delete a redundant check.

3. Omit extra assignments (for the variables =E2=80=9Cuspi=E2=80=9D and =
=E2=80=9Cubh=E2=80=9D)
   at the beginning which became unnecessary with this refactoring.


This issue was detected by using the Coccinelle software.

Fixes: f99d49adf527fa6f7a9c42257fa76bca6b8df1e3 ("[PATCH] kfree cleanup: f=
s")
Fixes: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 ("Linux-2.6.12-rc2")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/ufs/super.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index 23377c1baed9..017653c36080 100644
=2D-- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -789,8 +789,6 @@ static int ufs_fill_super(struct super_block *sb, void=
 *data, int silent)
 	unsigned maxsymlen;
 	int ret =3D -EINVAL;

-	uspi =3D NULL;
-	ubh =3D NULL;
 	flags =3D 0;

 	UFSD("ENTER\n");
@@ -821,7 +819,7 @@ static int ufs_fill_super(struct super_block *sb, void=
 *data, int silent)
 	ufs_set_opt (sbi->s_mount_opt, ONERROR_LOCK);
 	if (!ufs_parse_options ((char *) data, &sbi->s_mount_opt)) {
 		pr_err("wrong mount options\n");
-		goto failed;
+		goto free_sbi;
 	}
 	if (!(sbi->s_mount_opt & UFS_MOUNT_UFSTYPE)) {
 		if (!silent)
@@ -836,7 +834,7 @@ static int ufs_fill_super(struct super_block *sb, void=
 *data, int silent)
 	uspi =3D kzalloc(sizeof(struct ufs_sb_private_info), GFP_KERNEL);
 	sbi->s_uspi =3D uspi;
 	if (!uspi)
-		goto failed;
+		goto free_sbi;
 	uspi->s_dirblksize =3D UFS_SECTOR_SIZE;
 	super_block_offset=3DUFS_SBLOCK;

@@ -984,13 +982,13 @@ static int ufs_fill_super(struct super_block *sb, vo=
id *data, int silent)
 	default:
 		if (!silent)
 			pr_err("unknown ufstype\n");
-		goto failed;
+		goto free_uspi;
 	}

 again:
 	if (!sb_set_blocksize(sb, block_size)) {
 		pr_err("failed to set blocksize\n");
-		goto failed;
+		goto free_uspi;
 	}

 	/*
@@ -1000,7 +998,7 @@ static int ufs_fill_super(struct super_block *sb, voi=
d *data, int silent)
 	ubh =3D ubh_bread_uspi(uspi, sb, uspi->s_sbbase + super_block_offset/blo=
ck_size, super_block_size);

 	if (!ubh)
-            goto failed;
+            goto free_uspi;

 	usb1 =3D ubh_get_usb_first(uspi);
 	usb2 =3D ubh_get_usb_second(uspi);
@@ -1291,9 +1289,10 @@ static int ufs_fill_super(struct super_block *sb, v=
oid *data, int silent)
 	return 0;

 failed:
-	if (ubh)
-		ubh_brelse_uspi (uspi);
-	kfree (uspi);
+	ubh_brelse_uspi(uspi);
+free_uspi:
+	kfree(uspi);
+free_sbi:
 	kfree(sbi);
 	sb->s_fs_info =3D NULL;
 	UFSD("EXIT (FAILED)\n");
=2D-
2.40.0

