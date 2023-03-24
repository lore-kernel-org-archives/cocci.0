Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2AC9C6FD1C
	for <cocci@archiver.kernel.org>; Fri, 24 Mar 2023 17:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=X64T9HATr/8c9bjGYXnFBo+Ndk06YqweX2B/6HxN6j8=;
  b=M0VsRAeeuHM6s4MUrq7k+D7xS8jOmj0/idfYlZNQZSMbpEuYEgVUBE/D
   KVMeIODXAe0SqA0RFfu2m5ilAxy7cw5IaQJQ75Libu+PdHFNP+44Y92B8
   PB1T7H8tFssQr41zKwaTaVABQoUDKXXT/YJ2uh18FVOqYivN8tMOqEQvR
   E=;
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
X-IronPort-AV: E=Sophos;i="5.98,288,1673910000"; 
   d="scan'208";a="98990310"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Mar 2023 18:02:30 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DBBFCE0D44; Fri, 24 Mar 2023 18:02:29 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id CD406E0D40
	for <cocci@sympa.inria.fr>; Fri, 24 Mar 2023 18:02:25 +0100 (CET)
IronPort-SDR: 641dd79c_hCiit5/O+E0r4MLAqjqyX4PbrM6DoV2EitxF6mE6RKB1ea+
 cyxmdpRzBs43VHZVfhU8wsAQ/3KDFOX7tyL3eQQ==
X-IPAS-Result: =?us-ascii?q?A0FEAwBc1x1khwwR49RaDg8BAQEBCQESAQUFAUCBT4Iug?=
 =?us-ascii?q?UsvBAtGhFORAS4DhC+HLIc6hGeEAoMWPg8BAwENQQECBAEBAwQ4gVOCcwKFO?=
 =?us-ascii?q?gIdBwEENBMBAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAEBAhABAQEaC?=
 =?us-ascii?q?RcHDhAFIoVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQESAkdTP?=
 =?us-ascii?q?QMDIx0BAREmAQ8fBgImAgJXBgEMBgIBAYJ6gigBAzEHshGBMoEBgggBAQaCY?=
 =?us-ascii?q?5knHywiU4FeCYEULY0FgzZ6Jw+BVUSBPINBiByCZ5EViC0KgTR1gSAOgT2BB?=
 =?us-ascii?q?AIJAhFrgRIIa4F9QQINZAsOb4FLAmRMgRclBA4DGSsdQAIBCzs6PzUGAwshB?=
 =?us-ascii?q?lhrAgkjERMFAwsVKkcECDkGGjQRAggPEg8sQw5CNzQTBlwBKQsOEQNQgUcEg?=
 =?us-ascii?q?QqBAQYBJiSaagIBgXVzAVI7TCaCBMMmNAeCKIFVgVkMnwwGEy6XCA4GkiMuh?=
 =?us-ascii?q?y2QDyCneoF6I4FcMxokgzZPAxkPjiAZhAyPAQgBPUA0OwIHAQoBAQMJhUYBA?=
 =?us-ascii?q?YV7AQE?=
IronPort-PHdr: A9a23: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
 hNk0mND
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:XzwtSq+x8FsvsstVsOhuk+AMI+orL9Y04lQ7vn2ZhyYlFvBw5P
 re/8jzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNWftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIOb+EYZmIbsS+V2njcL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,288,1673910000"; 
   d="scan'208";a="51180301"
X-MGA-submission: =?us-ascii?q?MDFFeiARv3POSb2m8XGUOcai/lAO6a+FMAbyOG?=
 =?us-ascii?q?GpEg9FGzxtINsMXy3e9WQT4RU96uqqutDYyBkxIE+WYP5nTIlT161Eai?=
 =?us-ascii?q?+6m5v78ZXIpa36mQVl6t1lxJLrknczdgd2IaqsA8se/JZGA9z6+/ecpk?=
 =?us-ascii?q?Mvld21D+PFJrlXLjqfd7P9jg=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 18:02:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679677333; i=markus.elfring@web.de;
	bh=H/V7TWYn+gTu4OjUGyFg3i0V3d8XfJeAA5FWbAtfR0w=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=nRHWIbeozCtZmcCsnD5Adh2wBoXPERPzs2OpKcw2xTjVCuVzfI61mk3xaNmUBb8RM
	 FrvbO49l0TijLD8i6+o2FUzIvv3xzuLvcrkuzwzb/xxUw1Rr3LGnfoXvcmNb/qYAkv
	 OXLDxCuhxWpNVR37bfangZ9advm8JbsFK0dEtT9FMBJIyYRPIxYiGM2h3zWTQU4SIb
	 KSnEn8HPH9lU3IIWiyHlBYXNU5P+eXnsCdbi9ZJ/7i0Trr2FU1NT7I74qcgDA2+2EF
	 ENj7lHTWlSabLveLoB5O8FjB7UT7N6NVIfNirGR4ChURBK0RLXstt8/rA+6bBOQz3S
	 Z/wd0Q464YFZQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MTOli-1q2p4b2TT2-00UAbj; Fri, 24
 Mar 2023 18:02:13 +0100
Message-ID: <148fa3e4-f3be-82e4-3b73-e838c9620aef@web.de>
Date: Fri, 24 Mar 2023 18:02:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-ext4@vger.kernel.org,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 Carlos Maiolino <cmaiolino@redhat.com>, Eric Biggers <ebiggers@google.com>,
 Lukas Czerner <lczerner@redhat.com>, Theodore Ts'o <tytso@mit.edu>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <7214c986-4d0e-ad78-6312-c84515dc9abf@web.de>
In-Reply-To: <7214c986-4d0e-ad78-6312-c84515dc9abf@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A+p5yM+TXg+JOLZzQLPwVVK4sKBoTIxOXhJcQxhFP1GXIXNov9g
 n/49Q/Aw7pI9cKxrOAOkmPDPw6KUysRZMRwfnwT3soTSL3ROEPhLb4qehblF53J2kyJR8Px
 +ue9Y6ATcYclQfMeUlqR6P/nf1jJMf2MaHP8OXp1RBwf5CBZ7EqYy7TLz8EJbeDag6avY/p
 OgfMY6MwwXPbem4jbVWgA==
UI-OutboundReport: notjunk:1;M01:P0:2w5SuqYa95g=;WE/hx6ceZD1Ds0SzkFRu4fw2Wtk
 18IVTVDG4PGub3pQlsJoNYXaKvH1Ut2pFI3011Y0BBcEbhi2dgXOWI8iEjxu4id5wv5U/15ur
 YTOMYhGgTRdKUTulfpfNTKc0hyDVLPUaSPz/m+A25seJRVwgxypqk0Q9z/HrFZ7rBXCZe98QZ
 QaMDcT5LZsh0GeG3/6Xnmcv6wQmWDYd7QtECsGHXXLG6Rp9xmitp0Txb9/+tySHEfqk6TDBXD
 4VeyNSh8909zZlGzLwH8tgezBi0i8v51hkyn0lbjAIx5bnHGZ+9v1SRl1I+mdV4WmTajv2ksj
 YMAqcI/HANHsgXSx2mqHZDpBCzXfJPiH62A/qGTpnAWpg02yYwrKvFhV64nN1duOsG5UlAAbe
 CzgDE/MtFLFH+uCZX1Xex/tO9in3aj2uBZRjvnRgL6YhwssdjDUAXvdVecYmG7LoPsY4Ss5Gd
 GAADw7G++0ntphwN7I2jAqb3Lxjgxauu0WtTeprplUeDIH6otoudm1Ti/zDm/25hi/PSxGzoF
 q9x/QIjKrdLy25JPS6062ADFi7JlGtBxI9a8glsIoTdg4d5HCMo0oPgbDkGfcZRIBUbvRUgch
 yOvDFLK/K188mOImr6eqErEc0GSMOWIB0uW5w+xOqvHbwAmoEYG+t8bBLCakF5OGQckmgP40Z
 1iE6++2gDA24xMMecapyz3iOlIT87nww09Npvwp8A34vogkRISdR8jJ+9fpjAShVBaAWAhoHa
 R0six2vX5wnacszHwH3Wrvr2tlf7Rxe/Q3k2+obeok7rDr0LIujFGVtDlpig9tP6IentDnLyq
 JXoxBz/hhf4eWBKStfYZ7Mi8vhCHJR9NMJlbqEEilM7wXYGDxRVIT9ZblHf4mSWrwzxDPXIHK
 RKcJCYV8pHsDrs8/bDC3P4cgteSMrR79d+21moXoStr77EJkOUOggR3ph
Subject: [cocci] [PATCH resent] ext4: Fix exception handling in
 parse_apply_sb_mount_options()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 918
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/148fa3e4-f3be-82e4-3b73-e838c9620aef%40web.de>

Date: Tue, 21 Mar 2023 22:33:06 +0100

The label =E2=80=9Cout_free=E2=80=9D was used to jump to another pointer c=
heck
despite of the detail in the implementation of the function
=E2=80=9Cparse_apply_sb_mount_options=E2=80=9D that it was determined alre=
ady
that a corresponding variable contained a null pointer.

* Thus use an additional label.

* Delete a redundant check.


This issue was detected by using the Coccinelle software.

Fixes: 7edfd85b1ffd36593011dec96ab395912a340418 ("ext4: Completely separat=
e options parsing and sb setup")
Fixes: c069db76ed7b681c69159f44be96d2137e9ca989 ("ext4: fix memory leak in=
 parse_apply_sb_mount_options()")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/ext4/super.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index e6d84c1e34a4..c0bc46956353 100644
=2D-- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2435,7 +2435,7 @@ static int parse_apply_sb_mount_options(struct super=
_block *sb,

 	fc =3D kzalloc(sizeof(struct fs_context), GFP_KERNEL);
 	if (!fc)
-		goto out_free;
+		goto free_mount_opts;

 	s_ctx =3D kzalloc(sizeof(struct ext4_fs_context), GFP_KERNEL);
 	if (!s_ctx)
@@ -2467,10 +2467,9 @@ static int parse_apply_sb_mount_options(struct supe=
r_block *sb,
 	ret =3D 0;

 out_free:
-	if (fc) {
-		ext4_fc_free(fc);
-		kfree(fc);
-	}
+	ext4_fc_free(fc);
+	kfree(fc);
+free_mount_opts:
 	kfree(s_mount_opts);
 	return ret;
 }
=2D-
2.40.0

