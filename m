Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06056C6FD1C
	for <cocci@archiver.kernel.org>; Wed, 22 Mar 2023 21:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=zQCAprBs0qfP0PLyNfndDWAA+i9ct2H8JZa+PhK5VBk=;
  b=jyaObw+6ZV5kkUmr0sflyeZekf35JwGIw9gNjsNReUUHwchRVlW53s/0
   pBGo7qg6ph9bEvIzJkTRRbxNBLu5N1wp8Pt9ho+s6Xqmb6w25E0cWW9k7
   TNwQ/Py3ravtVQIZxNPaHR5LyVvaDQjLsh+GhmyQBdZ7thDJ8daJBEdEa
   c=;
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
X-IronPort-AV: E=Sophos;i="5.98,282,1673910000"; 
   d="scan'208";a="98612064"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Mar 2023 22:20:20 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0548CE0D3E; Wed, 22 Mar 2023 22:20:20 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 2A94FE0131
	for <cocci@sympa.inria.fr>; Wed, 22 Mar 2023 22:20:15 +0100 (CET)
IronPort-SDR: 641b710e_egwczIfZw0UoNP6PU7n27GhWSVu1gZjNbm0j2NAojR40hIO
 9JHX2zpk1UJSKUJejg9pNP/wkQl4beiy9u02hkg==
X-IPAS-Result: =?us-ascii?q?A0ExBACScBtkhwMP49RaHgEBCxIMQIFEC4IugUsvBAtGh?=
 =?us-ascii?q?FOPCoF3LgOEL4cskCOBVoFAPg8BAwENQQECBAEBAwQ4gVOCcwKFNgIdBwEEM?=
 =?us-ascii?q?gcOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBAQIQAQEBGgkXBw4QB?=
 =?us-ascii?q?SKFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEgJHUz0DAyMEG?=
 =?us-ascii?q?QEBESYBDwkWBgImAgJXBgEMBgIBAYJ6gigBAzEHlxacF38zgQGCCAEBBoJjm?=
 =?us-ascii?q?ScfLCJTgV4JgRQtjQWEMCcPgVVEgRUngRWCLIgcgmeCKYdXhnOIKwqBNHaBI?=
 =?us-ascii?q?A6BPYEEAgkCEWuBEghrgX1BAg1lCw5xgUsCZE07JQQOAxkrHUACAQs7Oj81B?=
 =?us-ascii?q?gMLIAZYawIJIxETBQMLFSpHBAg5Bhs0EQIIDxIPLEQOQjc0EwZcASkLDhEDT?=
 =?us-ascii?q?4FHBIENgQEGASYknB1zAVIiGUwmggSSWAkBB5Ivng40B4IogVWBWQyfDAYTL?=
 =?us-ascii?q?pcIDgaSIgEuhy2QDyCneoFqCyiBXDMaJIM2TwMZD44gDA0JhAOPR0A0OwIHA?=
 =?us-ascii?q?QoBAQMJhUYBAYV7AQE?=
IronPort-PHdr: A9a23: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
 chWIoI=
IronPort-Data: A9a23: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
 Qkix0DN
IronPort-HdrOrdr: A9a23:jBEw3qzqkEE18LgUQooOKrPxfuskLtp133Aq2lEZdPU1SL3+qy
 nKpp8mPHDP5Qr5NEtLpTn4AtjifZq+z+8Q3WBuB9iftWDd0QOVxedZg7cK7AeAJ8SUzIJgPM
 lbE5RWOZnaDUtzisjziTPIbOrIuOP3kpxBborlvhJQZDAvTbph4Qd/AgPeKEtrXwNLQboBfa
 DsnvZvln6adXMec8ihQkMIRPfOvPrCkJ6OW297OzcXrDKDiju05KW/KQGR2j0XTylCqI1SjF
 TtokjD6qKqrv2hjiXE32vo5ZJMlLLau6F+Lf3JscQTIijhkUKTfYxkYaCLoTxdmpDV1H8a1O
 Xnj1MbIsxv92m5RBDSnTLdnzXL/HIS+2bvoGXo+EfenQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,282,1673910000"; 
   d="scan'208";a="50971647"
X-MGA-submission: =?us-ascii?q?MDG+gGwZiH1cgByyPdLjaUffPwjVdsmB+r66G8?=
 =?us-ascii?q?ENbgdroxj4hOMIvSRL1AHndduIXh65DaD/ivjmAJlxVcDyzfJAyyLYt/?=
 =?us-ascii?q?hCIfIRG8Kg7nc9L9Uyt3MRLt4wplBhnzH/7KYneRGD54fpjMrleiSQ/8?=
 =?us-ascii?q?YWph+MdieLXqY30mFoPF2l7A=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 22:20:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679520013; i=markus.elfring@web.de;
	bh=zQCAprBs0qfP0PLyNfndDWAA+i9ct2H8JZa+PhK5VBk=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=wdQmPDywOgsjnr3PU8NEYRb5EX/21c6zAZdawXLmugibMD17qeSiUIff0D86zizUM
	 V3Bzg/Mna0BIKwgUoPaFvhOjMR3qS/O+/xyry8Cy11oT9adZU4SFCkEWA1jil3hdE+
	 /0kfDRhwRZiBbFFzT4YvX5jWt3Xu+kAdkLHR1S4jhf4NHJxn767pgCzwgu8ZxijvT1
	 aZm5AT3YAvLqZuQW67aCfuToONU5prcN6F0j7egkcZO/1LNMF1CagSME4NzJVn8ry9
	 gF4U5GYEGVZkgIM3i4uwFGjfVgh2zS8CQgaLJNEgvUSoXe5WKkwQPn+o8Xqy037T8f
	 dJiof4HdOXfmw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MnX5F-1qO1U00lSX-00jSKP; Wed, 22
 Mar 2023 22:20:13 +0100
Message-ID: <9d975625-672c-ab81-2e78-c3fa48747913@web.de>
Date: Wed, 22 Mar 2023 22:20:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
 Evgeniy Dushistov <dushistov@mail.ru>, Jesper Juhl <jesper.juhl@gmail.com>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jS633dLKzDN7vOa2hxRydEX8hWFI+DFSOv0CqmPUPLQ76Pilu8k
 SicVT/4GWU3iKhpp3MXjl6wmIvQ1sfE5ACOEvub2u25aAuyv1sg2oMeBefDscmASFB1mZ2M
 17yKyla2+PqFElupsq/eUrbhKHh1tLcochVCHBrqahmizB6iZZmh/NuaSpA2jO+fAevtGkN
 gRZnANa4UsIfo9gpSKerw==
UI-OutboundReport: notjunk:1;M01:P0:b/UYcFs0Q4E=;5Ox881kvbvXYK4IUZLrkZPDPkZI
 02kZbmjCCI3N9waUzQOfS3igDsKYt0ezAIraO65RuFjcZtUmQupbflrIjNsD3AXc58Mr1U77A
 B4MROuiArr2RBs+vpMbTMtduiH4s7161RjTkOqipx0bWcims/UHBB8AGI1mI2WlL/VlcEe0lP
 t2W9bATTnuVcFhBibezLGo0s3AdCJT4yDc3dn0hM6A9qCalUMQcsaU2r2zp3+SrgB8wOr1wqS
 5Knf8Wp65BmYDf9e4DcvQ5P0qTYK1QG8iDmaQwyMiWRkUKYv5zeRVVSz9yZvMniYu19tsRZMJ
 ckNgrzoJyTCHVtsPRJjMd4TIn0qCaIjbhc2eOZu/c7ACeXA7jK5p+U6yeaWnokL7ipMNCErQd
 Fd58juu1jbY+gswG+1Ilyp1eKNqRIknEeV944hVySBdPpDKLTopOnMU9p+kbhkXm8AJR9mBWy
 A5/44Hb9HBOb1CZHYsTqt9ON66bBqfxKNpPW4+UPGPxacLqM1uD9RqhYUMYUy2LIHwbTo7fv2
 8fyPGRXHYyOEqMv9yFQx6ihVTv7QMLTXI5VA2vKMVMu4KBDJgr28jBN6xH7L3AfPx7FwNVwon
 U/T3cUq3hvGqlerWK3Nf3bWTrOIwKaw6B1RfA/ep89NpFpcDwBzspDTNCVkSyjDX7FPQgUViX
 Fmnk1990c2FO7LqtmONxmL4YJHAoeRta5qgdqIEBl+Vn+fXe77BV7KmsbxgEGyOWqsMuvb0J3
 aEsHXmGV+LElc9efDKjGURxvP0zs8aendWfl/dowWRveyMQ3t7Hr5aehtS0jmuYJ2vCcbtPC7
 Hf9p5Db0nBOMJ8OR6BwfzlWY8OXHdaQ0IPDY2Z7fuT4K0hBsXWtAVHoEFNxDKF+Q0u6oYfR/n
 81DeEo9jvUo1e9zIow4iXcdIF5Ipg5xKXlBL8DC/TnSaIksjtsEwOGEMO/4E9d59MhCGJrrhR
 +Wc23zbgZosfwUY1DHU1ZqyY8ePcP54T5BH4hQM0RYYjhBH09SfObdvglhSFDpDeQUI3og==
Subject: [cocci] [PATCH] ufs: Fix exception handling in ufs_fill_super()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 912
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/9d975625-672c-ab81-2e78-c3fa48747913%40web.de>

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
=C2=A0=C2=A0 at the beginning which became unnecessary with this refactori=
ng.


This issue was detected by using the Coccinelle software.

Fixes: f99d49adf527fa6f7a9c42257fa76bca6b8df1e3 ("[PATCH] kfree cleanup: f=
s")
Fixes: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 ("Linux-2.6.12-rc2")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
=C2=A0fs/ufs/super.c | 19 +++++++++----------
=C2=A01 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index 23377c1baed9..017653c36080 100644
=2D-- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -789,8 +789,6 @@ static int ufs_fill_super(struct super_block *sb, void=
 *data, int silent)
=C2=A0=C2=A0=C2=A0 =C2=A0unsigned maxsymlen;
=C2=A0=C2=A0=C2=A0 =C2=A0int ret =3D -EINVAL;
=C2=A0
-=C2=A0=C2=A0 =C2=A0uspi =3D NULL;
-=C2=A0=C2=A0 =C2=A0ubh =3D NULL;
=C2=A0=C2=A0=C2=A0 =C2=A0flags =3D 0;
=C2=A0=C2=A0=C2=A0 =C2=A0
=C2=A0=C2=A0=C2=A0 =C2=A0UFSD("ENTER\n");
@@ -821,7 +819,7 @@ static int ufs_fill_super(struct super_block *sb, void=
 *data, int silent)
=C2=A0=C2=A0=C2=A0 =C2=A0ufs_set_opt (sbi->s_mount_opt, ONERROR_LOCK);
=C2=A0=C2=A0=C2=A0 =C2=A0if (!ufs_parse_options ((char *) data, &sbi->s_mo=
unt_opt)) {
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0pr_err("wrong mount options\n"=
);
-=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0goto failed;
+=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0goto free_sbi;
=C2=A0=C2=A0=C2=A0 =C2=A0}
=C2=A0=C2=A0=C2=A0 =C2=A0if (!(sbi->s_mount_opt & UFS_MOUNT_UFSTYPE)) {
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0if (!silent)
@@ -836,7 +834,7 @@ static int ufs_fill_super(struct super_block *sb, void=
 *data, int silent)
=C2=A0=C2=A0=C2=A0 =C2=A0uspi =3D kzalloc(sizeof(struct ufs_sb_private_inf=
o), GFP_KERNEL);
=C2=A0=C2=A0=C2=A0 =C2=A0sbi->s_uspi =3D uspi;
=C2=A0=C2=A0=C2=A0 =C2=A0if (!uspi)
-=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0goto failed;
+=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0goto free_sbi;
=C2=A0=C2=A0=C2=A0 =C2=A0uspi->s_dirblksize =3D UFS_SECTOR_SIZE;
=C2=A0=C2=A0=C2=A0 =C2=A0super_block_offset=3DUFS_SBLOCK;
=C2=A0
@@ -984,13 +982,13 @@ static int ufs_fill_super(struct super_block *sb, vo=
id *data, int silent)
=C2=A0=C2=A0=C2=A0 =C2=A0default:
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0if (!silent)
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0pr_err("unk=
nown ufstype\n");
-=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0goto failed;
+=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0goto free_uspi;
=C2=A0=C2=A0=C2=A0 =C2=A0}
=C2=A0=C2=A0=C2=A0 =C2=A0
=C2=A0again:=C2=A0=C2=A0 =C2=A0
=C2=A0=C2=A0=C2=A0 =C2=A0if (!sb_set_blocksize(sb, block_size)) {
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0pr_err("failed to set blocksiz=
e\n");
-=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0goto failed;
+=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0goto free_uspi;
=C2=A0=C2=A0=C2=A0 =C2=A0}
=C2=A0
=C2=A0=C2=A0=C2=A0 =C2=A0/*
@@ -1000,7 +998,7 @@ static int ufs_fill_super(struct super_block *sb, voi=
d *data, int silent)
=C2=A0=C2=A0=C2=A0 =C2=A0ubh =3D ubh_bread_uspi(uspi, sb, uspi->s_sbbase +=
 super_block_offset/block_size, super_block_size);
=C2=A0=C2=A0=C2=A0 =C2=A0
=C2=A0=C2=A0=C2=A0 =C2=A0if (!ubh)
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto f=
ailed;
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto f=
ree_uspi;
=C2=A0
=C2=A0=C2=A0=C2=A0 =C2=A0usb1 =3D ubh_get_usb_first(uspi);
=C2=A0=C2=A0=C2=A0 =C2=A0usb2 =3D ubh_get_usb_second(uspi);
@@ -1291,9 +1289,10 @@ static int ufs_fill_super(struct super_block *sb, v=
oid *data, int silent)
=C2=A0=C2=A0=C2=A0 =C2=A0return 0;
=C2=A0
=C2=A0failed:
-=C2=A0=C2=A0 =C2=A0if (ubh)
-=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0ubh_brelse_uspi (uspi);
-=C2=A0=C2=A0 =C2=A0kfree (uspi);
+=C2=A0=C2=A0 =C2=A0ubh_brelse_uspi(uspi);
+free_uspi:
+=C2=A0=C2=A0 =C2=A0kfree(uspi);
+free_sbi:
=C2=A0=C2=A0=C2=A0 =C2=A0kfree(sbi);
=C2=A0=C2=A0=C2=A0 =C2=A0sb->s_fs_info =3D NULL;
=C2=A0=C2=A0=C2=A0 =C2=A0UFSD("EXIT (FAILED)\n");
=2D-
2.40.0


