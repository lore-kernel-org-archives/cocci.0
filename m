Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F1C0C761AF
	for <cocci@archiver.kernel.org>; Thu, 30 Mar 2023 09:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=nZaCbnIy4OpZmElryA402bgT4/eK9KqgqCpSUQ8pW7U=;
  b=tYsk12XCUzP0Otf3AaNVCkXDZ6o+p/9vQeie/niXKJhvPDQFfnKnf4xw
   O/8LZqQMfPKl56WerIDtjw/qxj8Gh55qA7bosml97XqpL7AkqfFdFP2Yb
   p9aLc8CmEnU0wikzrk/bS0jHJLBgFeW4yrx2q+2IPjetnCJTlQbXCQL1f
   A=;
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
X-IronPort-AV: E=Sophos;i="5.98,303,1673910000"; 
   d="scan'208";a="99852416"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Mar 2023 11:00:33 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EFB30E019F; Thu, 30 Mar 2023 11:00:34 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 63183E013A
	for <cocci@sympa.inria.fr>; Thu, 30 Mar 2023 11:00:27 +0200 (CEST)
IronPort-SDR: 64254fa9_DImwUbCLe3sgYW9OIAuqmjNDa8N3LNg35QlA+bTs5oSga7+
 hXBZbZMHfgRq3QgIoHsNAc3y8A+Cl0ErbEPSsHg==
X-IPAS-Result: =?us-ascii?q?A0HHAADHTiVkhwwR49RaHQEBAQEJARIBBQUBQIE+BQELA?=
 =?us-ascii?q?YItgUsvBAtGhFORAS4DhC+HLJAjgxY+DwEDAQ1BAQIEAQEDBDiBU4JzAoU6A?=
 =?us-ascii?q?h0HAQQzBg4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAEBAhABAQEaC?=
 =?us-ascii?q?RcHDhAFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQESAkdTP?=
 =?us-ascii?q?QMDIwQZAQERJgEPHwYCJgICVwYBDAYCAQGCeoIoAQMxB6wdfzOBAYIIAQEGg?=
 =?us-ascii?q?mOZJx8sIlOBXgmBFC0BjQSDNnonD4FVRIEVJ4EVgiyEHIQAgmeCKYdVj1UKg?=
 =?us-ascii?q?TRzgSAOgT2BBAIJAhFrgRIIa4F8QAINZAsOcYFKAmRMgS8lBA4DGSsdQAIBC?=
 =?us-ascii?q?zs6PzUGAwsgBlhrAgkjERMFAwsVKkcECDkGGzQRAggPEg8sRA5CNzQTBlwBK?=
 =?us-ascii?q?QsOEQNQgUcEgQ18CgYBJiSdfjccKBNMJoIEklgRki+eDjQHgiiBVYFZDJ8MB?=
 =?us-ascii?q?hMulwgOBpIjLoctkA8gokuFL4F5JIFcMxokgzZPAxkPjiAMDQmEA49IPzQ7A?=
 =?us-ascii?q?gcBCgEBAwmFRgEBgyOCWAEB?=
IronPort-PHdr: A9a23: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
 dXF0q7+em8qGz384sYWQcTZepvvDQ==
IronPort-Data: A9a23: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
 u3yNpE90tZdD32pqSsuCiSHvNpa
IronPort-HdrOrdr: A9a23:tKe6d6nYIrUAxu72GfoGqjyQYhHpDfL43DAbv31ZSRFFG/FwWf
 re+MjzpiWE6wr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQmVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6voSizPZLz9P+qjjzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,303,1673910000"; 
   d="scan'208";a="99852313"
X-MGA-submission: =?us-ascii?q?MDF2eaKS3Bwy8ONNXRG93ppvfvOX57W9dcH4XO?=
 =?us-ascii?q?hqjOR1ysZYz+YRIVLw4gfjgdIzMthJskTIAEgCpmgYXcIAtxSHEDsrxY?=
 =?us-ascii?q?KqVc9xzFxIBZpwteJzmJZGGOrZJycwH/s3r2rkmlnY9A5nPsqzEGKBSG?=
 =?us-ascii?q?DOwJ3QfqyPA0NenecejTKHlA=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 11:00:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1680166826; i=markus.elfring@web.de;
	bh=v4nzZfv3+7yve8LIUHG9Bb5iKrIXbswUjpSv9Se9yA4=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=VLAVYONldkp/U8sEz6dkukyqBcjvKKWOqAWbeqqkTTzHw/QtRzkH2bkRm/9pKoF60
	 J9j/QW/9z2InVguQhapE4K4dclLwLwJm8ikjY8Mz65zs/MkcMvl2H0XU6sjhgIJX5w
	 /0BIlEDOpvY+L+0GWmZ7MBa1Mwy4HZd8UKmV8n+tF71kiB8xUdd5HN87Pj5ohnSmO9
	 obj28Wq1DE1XUEMnnbfJK5hS+d8ocvHh6wkiQiJl+kkzlHoN/b0xVDRSCXX8joWdr6
	 +Hew0i8hk6gjowfkth/ATcxhKsw7UMZtzYcp/IWs6RzqjiHjqo2ha5B/odYMQIf2GC
	 J7vxsZJnBP6kw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M2gkf-1pjAO50ooh-0041dA; Thu, 30
 Mar 2023 11:00:26 +0200
Message-ID: <dbb3fcf7-9f10-2c44-2ca0-49606ce1812e@web.de>
Date: Thu, 30 Mar 2023 11:00:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-unionfs@vger.kernel.org,
 Miklos Szeredi <miklos@szeredi.hu>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>,
 Christian Brauner <brauner@kernel.org>
References: <6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de>
 <87b65f8e-abde-2aff-4da8-df6e0b464677@web.de>
In-Reply-To: <87b65f8e-abde-2aff-4da8-df6e0b464677@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:44FIi0YQWq9W8aUC9oorou6zomFdtmPMZFSjIFiLi9ffpmWNWa7
 XTCzHvFz68TSL3iNOssuvdBlAgdCjOC80gI6cG0hqi5ig8mpXCymxw17aQer97dUSZqclzX
 pLDK+XdZ0xyfKuKIXHoU94Pa9kSAhTIGN8vQs017RU136VjFiLC7FQwsToAM5gfos3lZjDW
 maI6LkuOoVarse0kF1Guw==
UI-OutboundReport: notjunk:1;M01:P0:LSe1II9AiP4=;FEned8RpzSHauannDi36ZQIhzBR
 mvtd37sJwoGJFcfbqItvQGxmoyOTDGWNkx52gJVSDVwHXSE2hYFvxBjKvoAmeL+pU5dkX1dgB
 IJbkjQ19FAT4KDG5mK8ltpNYGyrb0BMLpMJ3bsuQhvaHCL+0kmXcYVSi5OqUlX40GnsZ8SSIy
 8jwmE3f3VYUtJHjnhq/UQ5HYqhTQ7j5CrstrLo/NXH5V7bzamu/ve/OitSfqqxmJiVKK9kR9Q
 toLMv3+Gt3l0o1lSV5Y1DeRgmRrZpV64DMQTVdCAd2+j++7WpKEN0UiRsRfvUlVBt4kGjWaX9
 J0KVol7c85nOS4cBIMcjYnYCQ8IPm+aSxLk+hxg5tkTaTbXMdqwoqGFrfwVbvDYX2r/lmw4Hs
 RLXg0FTI0LuQLKOe8KhoEh2WSEeGHnyZwKOlIyhXsNryKwlmgKUYPdvNn+CfBkaicNMZT/K/8
 e1tzP3Hg/ajxEvOZslO+6Mh2x1xWgzq0fHRVtW2zVhzGOkZvvGU0lTgUBP7TJ/lfO5cIDx7Dt
 8YPEujJRogdVRUYtR9xA1BZAqkKJeRgUmGHd87XS/41wLygT5Mpi6TvmCC/p8IDQidmDWv0Uz
 rpZ2PmAXAQ7pSwIboRvOrdP7rqXXfrBv07cLJjumd6oql92T+Ty0gPepUgyIh9V52i8k5mGPQ
 OTVBjTE3uIcrM1atqe8YlPvvc94BDqo0MfJor4/OHVQvzydq/mKfO1DMRPWoSaKsQv7EFf6uo
 jMjqNkQ7oWDozHPeA3C+mVtPB1yx9I/cUiAtTmISQrRWCUju7KZzl/6Nj4gqSZLld3z23ZzYq
 rNtYitT8gYqetVjWL4PXOTEhBUzJ6e9X3Gg5LhQiGm/1OybF+pPsvKN7wm8qNtvysaIIYbY8H
 f4xm/ciQzDNPESxpo6RN/FUGZQ7nDVQl2q7yTjeUbxpps6yUH/mzlRGL8
Subject: [cocci] [PATCH 3/4] overlayfs: Improve exception handling in
 ovl_fill_super()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 991
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/dbb3fcf7-9f10-2c44-2ca0-49606ce1812e%40web.de>

Date: Thu, 30 Mar 2023 09:51:02 +0200

The label =E2=80=9Cout_err=E2=80=9D was used to jump to a kfree() call des=
pite of
the detail in the implementation of the function =E2=80=9Covl_fill_super=
=E2=80=9D
that it was determined already that a corresponding variable contained
a null pointer because of a failed memory allocation.

1. Thus use more appropriate labels instead.

2. Omit an extra initialisation (for the variable =E2=80=9Csplitlower=E2=
=80=9D)
   which became unnecessary with this refactoring.


This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/overlayfs/super.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index c721d6fe9cb4..df5628056d93 100644
=2D-- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1890,7 +1890,7 @@ static int ovl_fill_super(struct super_block *sb, vo=
id *data, int silent)
 	struct ovl_fs *ofs;
 	struct ovl_layer *layers;
 	struct cred *cred;
-	char *splitlower =3D NULL;
+	char *splitlower;
 	unsigned int numlower;
 	int err;

@@ -1906,7 +1906,7 @@ static int ovl_fill_super(struct super_block *sb, vo=
id *data, int silent)
 	err =3D -ENOMEM;
 	ofs->creator_cred =3D cred =3D prepare_creds();
 	if (!cred)
-		goto out_err;
+		goto out_free_ofs;

 	/* Is there a reason anyone would want not to share whiteouts? */
 	ofs->share_whiteout =3D true;
@@ -1918,32 +1918,32 @@ static int ovl_fill_super(struct super_block *sb, =
void *data, int silent)
 	ofs->config.metacopy =3D ovl_metacopy_def;
 	err =3D ovl_parse_opt((char *) data, &ofs->config);
 	if (err)
-		goto out_err;
+		goto out_free_ofs;

 	err =3D -EINVAL;
 	if (!ofs->config.lowerdir) {
 		if (!silent)
 			pr_err("missing 'lowerdir'\n");
-		goto out_err;
+		goto out_free_ofs;
 	}

 	err =3D -ENOMEM;
 	splitlower =3D kstrdup(ofs->config.lowerdir, GFP_KERNEL);
 	if (!splitlower)
-		goto out_err;
+		goto out_free_ofs;

 	err =3D -EINVAL;
 	numlower =3D ovl_split_lowerdirs(splitlower);
 	if (numlower > OVL_MAX_STACK) {
 		pr_err("too many lower directories, limit is %d\n",
 		       OVL_MAX_STACK);
-		goto out_err;
+		goto out_free_splitlower;
 	}

 	err =3D -ENOMEM;
 	layers =3D kcalloc(numlower + 1, sizeof(*layers), GFP_KERNEL);
 	if (!layers)
-		goto out_err;
+		goto out_free_splitlower;

 	ofs->layers =3D layers;
 	/* Layer 0 is reserved for upper even if there's no upper */
@@ -1970,12 +1970,12 @@ static int ovl_fill_super(struct super_block *sb, =
void *data, int silent)
 		err =3D -EINVAL;
 		if (!ofs->config.workdir) {
 			pr_err("missing 'workdir'\n");
-			goto out_err;
+			goto out_free_splitlower;
 		}

 		err =3D ovl_get_upper(sb, ofs, &layers[0], &upperpath);
 		if (err)
-			goto out_err;
+			goto out_free_splitlower;

 		upper_sb =3D ovl_upper_mnt(ofs)->mnt_sb;
 		if (!ovl_should_sync(ofs)) {
@@ -1983,13 +1983,13 @@ static int ovl_fill_super(struct super_block *sb, =
void *data, int silent)
 			if (errseq_check(&upper_sb->s_wb_err, ofs->errseq)) {
 				err =3D -EIO;
 				pr_err("Cannot mount volatile when upperdir has an unseen error. Sync=
 upperdir fs to clear state.\n");
-				goto out_err;
+				goto out_free_splitlower;
 			}
 		}

 		err =3D ovl_get_workdir(sb, ofs, &upperpath);
 		if (err)
-			goto out_err;
+			goto out_free_splitlower;

 		if (!ofs->workdir)
 			sb->s_flags |=3D SB_RDONLY;
@@ -2000,7 +2000,7 @@ static int ovl_fill_super(struct super_block *sb, vo=
id *data, int silent)
 	oe =3D ovl_get_lowerstack(sb, splitlower, numlower, ofs, layers);
 	err =3D PTR_ERR(oe);
 	if (IS_ERR(oe))
-		goto out_err;
+		goto out_free_splitlower;

 	/* If the upper fs is nonexistent, we mark overlayfs r/o too */
 	if (!ovl_upper_mnt(ofs))
@@ -2067,9 +2067,11 @@ static int ovl_fill_super(struct super_block *sb, v=
oid *data, int silent)
 out_free_oe:
 	ovl_entry_stack_free(oe);
 	kfree(oe);
-out_err:
+out_free_splitlower:
 	kfree(splitlower);
+out_put_path:
 	path_put(&upperpath);
+out_free_ofs:
 	ovl_free_fs(ofs);
 	return err;
 }
=2D-
2.40.0

