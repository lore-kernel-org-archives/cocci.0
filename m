Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B95C1C282CD
	for <cocci@archiver.kernel.org>; Mon,  3 Mar 2025 19:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=p/1y8E3y+CaOKzyRHNzCHL74cbkCQAfumb6We0o3vWU=;
  b=WSR6Ies4UYn4eBl1c8PRAHpRVP6WzowTOm75AoWMpp1fI1eiyoQpOMhm
   E8aLv/rRHdDWVlFDC7EWDJ9Mw5Zm9BLYnPVVg01QTMM3tKAzRIIJziXjp
   CRfYMp79CF1dRiso5osgWRz1q8DAsILQuTqBkPz033VJ2issYIrcbz+31
   c=;
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
X-IronPort-AV: E=Sophos;i="6.13,330,1732575600"; 
   d="scan'208";a="210965230"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Mar 2025 20:52:51 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0EB7FE0261; Mon,  3 Mar 2025 20:52:51 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 553E3E0260
	for <cocci@sympa.inria.fr>; Mon,  3 Mar 2025 20:52:45 +0100 (CET)
IronPort-SDR: 67c6088c_cg9IkRFslch66/KLmjt7jVXzcjEbZ5p7OAG6SlbzQjpGGab
 1H1IxiSwXLK3t4akIuKWzI5OuLAi3QK34YHtZtA==
X-IPAS-Result: =?us-ascii?q?A0FfAQBkB8ZnfgQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDYnUzBAtIhFaIHYcygXQtA4Q7hzuQSIFWgX4PAQMBDUEBAgQBA?=
 =?us-ascii?q?QMEOIFUgnQCixUCHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBA?=
 =?us-ascii?q?gQGAQIQAQE7Bw4JATGFew2CYgGBJIEmAQEBAQEBAQEBAQEBHQJHRAIBAyMEG?=
 =?us-ascii?q?QEBESYBDx8BBQImAgJWBgESAgEBgn6CMAEDMQevZH8zgQGCDAEBBoJp13MfL?=
 =?us-ascii?q?CJXgWUJgRouAYVrgmMBhiaEPCcPgVVEgRUngRSCLYgegmmEHYM9qFiBTRwDW?=
 =?us-ascii?q?SwBVRMXCwcFgTk4AyAKNDECFB0PBhAEanqCRWlJOgINAjWCHiRYgitqBAWDW?=
 =?us-ascii?q?4Q9hECCP1GCQoIRcYEXgjGFUYEthGsdQAIBC209NwYDCxsGPaFuOoNOcwFSI?=
 =?us-ascii?q?hlMJoIEkwwJAQeTWJ8dNAeCOIFmgWMMn14GEy+XRQ4GknwBLodlkGoiqQ+BZ?=
 =?us-ascii?q?zqBXDMaJIM2TwMZD44hDBaEC48KAbkWQjU8AgcBCgEBAwmFRgEBilSBSwEB?=
IronPort-PHdr: A9a23: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
 /ogxLTlMcIMO4e910EwMjGSeazVFkCWUd0f+kVc
IronPort-Data: A9a23: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
 ITteV15fQ==
IronPort-HdrOrdr: A9a23:Rh8IjK7jcP3AmZzx1QPXwN3XdLJyesId70hD6qkRc31om6Oj5q
 OTdZggviMc6wx+ZJhDo7y90cC7KBvhHPhOi7X5Vo3MYOCJggaVBbAnx43k3jXrBmnf+4dmtZ
 tdTw==
X-Talos-CUID: 9a23:pflOZ26+B0TgHd8FTtss91E1IpEsVnjk0ljCEXKxNW9HVYGsRgrF
X-Talos-MUID: =?us-ascii?q?9a23=3AOQGncg0RndhkXtJFqfHlhDfzVzUj4Z6gUX88zpw?=
 =?us-ascii?q?9tu6rOSFTJmbD3SznXdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,330,1732575600"; 
   d="scan'208";a="110543406"
X-MGA-submission: =?us-ascii?q?MDEDmelO09swltPV73aEY7iJnm9xTg95keXQbl?=
 =?us-ascii?q?BIm7U5FKj1b78gmQalFZSdkG4s6kO01DCvajv+2L7BN4QaTeyQHlCppG?=
 =?us-ascii?q?gZMucGlmvzy1dA6eomKfdZmQCiXDDJknUi0TnFOBC0hyQS0AcCDINsgD?=
 =?us-ascii?q?UxfpbnL4QkuunmgDIyBm12aQ=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 20:52:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741031542; x=1741636342; i=markus.elfring@web.de;
	bh=p/1y8E3y+CaOKzyRHNzCHL74cbkCQAfumb6We0o3vWU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ppJFF5ncblNd32Rn6q0Nz7PhAQF9Y4OjPI9faI7Oe/EEIQSgv8rlWW23u6lTpbK2
	 Dh/3VibQbUt9Lap/9o2j+VQsM7nz5zfqY1JbQBZ53lJDGYCdYuIxD78zXlM0M08Ee
	 4MeXITMuSQbZ4PyjDjsMJCY9Evx3nHaukhPmj2u32jMRSBOsaOn59d7591iAhcPgH
	 riCkgnxJgGXi5vruwtTQRvS2o4HWrpNXutF8R/ieMQQoc9GOYAXPb0LJayz9wzdKK
	 LSKAuM+YUv1DHxpMnCIzIPPPO3wJx46USo0f6HeKw77KNH050goMBSW2K9duxaPkp
	 Dy8efTxGc3Y/+ObsIQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.19]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MIL0C-1u1LRC1jV6-00Aj73; Mon, 03
 Mar 2025 20:52:22 +0100
Message-ID: <fb65b3c3-00b2-4c33-8ab1-8e60b4159c3f@web.de>
Date: Mon, 3 Mar 2025 20:52:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, Agathe Porte
 <agathe.porte@canonical.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Andrew Morton <akpm@osdl.org>, Evgeniy Dushistov <dushistov@mail.ru>,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Jesper Juhl <jesper.juhl@gmail.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <9d975625-672c-ab81-2e78-c3fa48747913@web.de>
Content-Language: en-GB
In-Reply-To: <9d975625-672c-ab81-2e78-c3fa48747913@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YsISSegg3lcQ3hmqRzFgdivEeAVL0GWFjbgRAsPOJh7cfonv/eR
 /ZRmIN+xHxCwxcEuyGHP+l+dYl+M3uf2p5OSoES/URxruvATvajdjtbaqd9DTP/NRX49EVN
 ic7+wrTwsrXf7WhAjOkXOLAE3f+i6+XR1dZ14C4WhLaWlf1nm3xldhro1VJ+bBntnsv3F5t
 6vps+sy62rHMU8Q0hwmAQ==
UI-OutboundReport: notjunk:1;M01:P0:V1/6gYigggU=;L3OHYIdZuntwDgsrHAQo83kdWle
 D5fCV9moqOaiq+5g/sIBBsbr5AwFlbQZ4d6rSpdm4QOmA5oxExd5NLbMfEdtD8AGljB69cEy1
 NlgDe12wGcW+Pg4/onP+NRvDf5gFkIpWw3AyR364O6l4uD7632YJv1Bc9w/ACiEFi39FzZLjA
 vQo8eVhThiFlRIvhofvVUo7t24IBGJsTTW1skl3AiIidH2DvqUQtfgyVTrXiIYWHNs6ecvous
 aCbGoVgC8f5sdYOvLdBVgqtAMaKSX1QdAUGNZmBdsclWzpv1KOX5cCgOaFD5j0p2GODrP8Q4+
 AWc4EfvsdtczAy85JS6ORkSzhC3RToKg5qnhmK+ge2iu52KnA4iHs1A2YnQygF8Aidsr73gOZ
 WNzErbfnw3i+/SNSbkg7RHIlVohflQ2yZRIitQ/q9WXYahuFCcV0rWf8x3AM2AtLfZsWJNV9i
 iey3ggzIm6zMAYQ3lsbC593vTzNgNcH+WXjesNIX0k5vx4/9klOmlb2AJMn8J9owgfzmzFZqg
 G2g93Olpu5XImJFN0nGytMyK+yNhaq0s2CfYYgtB44+6hTQdxM+D+eqY0+6OzPFyGuf5lqMyc
 249dTbPsM47ntMLwmiQiyNnfk0xV6zUl7f1zeo2kAlZMe7Jo0v0WVaemvEUHNE5gHsjA+vBNG
 +qlxZAx+jizgqVrHxwet6QHs/U8N/CUq7FbVQ63NYSdr1zTfoKvEGeNQi9DSxTB0h/ro9mwdu
 hh8em2EyO9IjmcJdvTe3/M0YqJGhfAujhLuL2rgOHJl5MceuxN8EfIS27fy4aLGI5CPtiwa4d
 hoJ77z25Qmy6c5synXJd5UP/HinYEghMlo5bj9n1ZFg1G351rlyJZvUjlB+TyE5d2fzpwNUKE
 uV1S0lElH7CmIfrXRBlV33srHkZyVmiJRpk+x1OA8EQjuJgfkBJZ1Mx6DWeSDRptjbjYI18+P
 H/Rh0e66D10p+7RPJfXAzPql1gGxRQvNvjTNWqWT+KBsooOH3bwBI6DQn35hDEF0LdbkyL1ci
 vacyLCSMk5IXuESOKmP0Ya+lQaq1lHt2KJ6cQxRnzKNfKg9TxKVEOyvQKWzyRfXGCeRzhuhQC
 gugoBjFMaqOpfIpqTQoe+Qkb64Pi2tAARHrrkXNHLDG0GnoWHVdzjaMPKehHYz7foXEYULVgK
 qBqhfuwvwD+OdGcou+xFoK5Q2tlvnxjBhaiqNjN75ll8mX4yLb+5qtlWuZ95R+arvfbVEicvG
 ZcnCfSnz8PMYNQAN6gLOdVb/oh8JLJeT7JNb7cZGkdhKOXbc64+WYQojQv5ysjJiVjbaHIbBP
 Gp0FrM3oBW9UlUuz0sJ0iOuzEvIP1IEUrpPaSbBPhCiv6qO81sRLJZm94zDyRfBFmECm8ZsA+
 YmN4rGapGZ5u0JA9cWKEif0p4eOPVF5kaWwmn10+KOJi+d/QkypB+nvPUmnePLtxs5C7ofb8r
 vAOJVFmNq9L/ItoMWlL3kjLEaMCc=
Subject: [cocci] [PATCH RESEND] ufs: Fix exception handling in
 ufs_fill_super()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2485
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/fb65b3c3-00b2-4c33-8ab1-8e60b4159c3f%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
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

Fixes: f99d49adf527 ("[PATCH] kfree cleanup: fs")
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
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

