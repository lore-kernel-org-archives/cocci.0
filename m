Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE9CC761AF
	for <cocci@archiver.kernel.org>; Thu, 30 Mar 2023 08:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=X3EN32GCkdQdWFPBU1PdCILfnz3Q2gCpTxZljNeUeko=;
  b=k1wKTimfrz+VqSnf00ZAV23fmdjFoh/FUKYXbEimonxA6XZKwdeZ+mDJ
   9JVoAiKNEVFBGYSw8spqbo+5D2OvVYXb+qOTGJdVU5G7sDxjwn+ohOpG5
   oTdZBXJgg1U9Fro7tOqv982HXujpCbsMOF35GvbwLerBBkbZ35sy9YJVz
   k=;
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
   d="scan'208";a="99851041"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Mar 2023 10:56:03 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8DED2E019E; Thu, 30 Mar 2023 10:56:03 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 5E4A3E00CE
	for <cocci@sympa.inria.fr>; Thu, 30 Mar 2023 10:56:02 +0200 (CEST)
IronPort-SDR: 64254ea1_FilGlmWpOn6XQVHHZTVIO/gZNd5YO2MT2131DHclHWzph0n
 uQoo3MFLCyFYxYpVVR8gxpN4ywLCjsz6OhqsVuQ==
X-IPAS-Result: =?us-ascii?q?A0FCAwAyTSVkhk7ASNlaHQEBAQEJARIBBQUBQIFPgi6BS?=
 =?us-ascii?q?y8EC0aEU5EBMYQvhyyHOohpgxY+DwEDAQ1BAQIEAQEDBDiERgKFOgIdBwEEN?=
 =?us-ascii?q?BMBAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAEBAhABAQEYCRkHDhAFI?=
 =?us-ascii?q?oVoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQESAkdTPQMDIwQZA?=
 =?us-ascii?q?QERJgEPHwYCJgICVwYBDAYCAQGCeoIoAQMxB6wXfzOBAYIIAQEGgmOZJx8sI?=
 =?us-ascii?q?lOBXgmBFC2NBYM2eicPgVVEgTyBFYE+bogcgmeCKYdVj1UKgTRzgSAOgT2BB?=
 =?us-ascii?q?AIJAhFrgRIIa4F8QAINZAsOcYFKAmRMH4EQJQQOAxkrHUACAQs7Oj81BgMLI?=
 =?us-ascii?q?AZYawIJIxETBQMLFSpHBAg5Bhs0EQIIDxIPLEQOQjc0EwZcASkLDhEDUIFHB?=
 =?us-ascii?q?IENfAoGASYknX43V3KCBJJYkkCeDjQHgiiBVYFZDJ8MBhMulwgOBpIjLoctk?=
 =?us-ascii?q?A8gp3qBeiOBXDMaJIM2TwMZD44gDA0JhAOPSD80OwIHAQoBAQMJhUYBAYV7A?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
 J7DmfCrQN+t283Z940QCpqNQP8=
IronPort-Data: A9a23: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
 PrxgKfOxMkzsfmosfkx3Tg7YjqiOw==
IronPort-HdrOrdr: A9a23:/T9QNa6A7FnHIVBEngPXwBzXdLJyesId70hD6qm+c20wTiXqrb
 HMoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhX4tKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkYNDSaNzhHZKjBkWyFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,303,1673910000"; 
   d="scan'208";a="51678069"
X-MGA-submission: =?us-ascii?q?MDHLF2Im7pwpu4MaSK9DJFpYfS0l6rOfRBo6Dc?=
 =?us-ascii?q?tQVSwvqE4WJ3mIOhhwjzowoRdB+iTF0549IlcJZeO9DFiQCdVL+Khl4k?=
 =?us-ascii?q?J9qGF8u4p34P6xR28W3iwmC7i2QNdZAR5z9r0ssiNNET1npVxdp7FOnO?=
 =?us-ascii?q?1QffKEr53HGryX7e/A+EWh2g=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 10:56:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1680166560; i=markus.elfring@web.de;
	bh=drYyPKUIQ/t3L/XbZS7hq8i7R4/wMIHwrMSc73A/kFU=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=tl3nWdmVup0pSKhqR7UV4FsafNBb3nS7q74m2ktmQgAgt0IgqdTs4PdfXbPbjpALz
	 x8KOMbbxSBTyUY5ostt2V5T203yyK4ApP+El9x6zh+luu9zTZuooUx7w71CiRRpkfw
	 +3Ij2rxKjKFe/kS4jRwe3WAjIx3ZZ1Xdq1wbWI18FAw3eVvHaa3bg1guhlhjWD96ol
	 ohkC7Ao8rp7PwGXp30F2oMEHj1mcEolHrIIflOfPeh9SoVudBnczfvWgr91OB6Q0sy
	 zQ9SAXDnKZ32EguBEkXWN2YnSlgMDkSfNHaDgOYKK0n6wC2iXATFpMPGmyUq6i5cv1
	 Esu2oug/DEfRw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N9LEU-1qTDeu1pbw-015TBT; Thu, 30
 Mar 2023 10:56:00 +0200
Message-ID: <93cceba1-ae51-0ab6-cc8a-53ce7143832a@web.de>
Date: Thu, 30 Mar 2023 10:55:59 +0200
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
X-Provags-ID: V03:K1:1duuIaFg92d/oBGy+oH7hOT7sOMnF+xSXfBzyRr5EeTw/pLfrvV
 1jY2ferJlYd2d3BqMuDjHnQfsXYM98hJCLIw8V1EjN4wW0IHL3+duk88q3O5M2SlPHVLIou
 pqFkbFMgupexRldyH9awwSM/ihZqKtW/Anp8aU55Twv0ytUnZmkxEEojp6GgkmLnWJ9Ze+I
 GCNgv6XUCv8Q4YyaHD6AQ==
UI-OutboundReport: notjunk:1;M01:P0:ZAY9iwWyeag=;n+aDBO/OHlxtJAKbrJpUa5PNhOp
 hyIsGm/HJGw5H+PX28wzzTMTYGN9BAVojF8k/1I3z7DuJe15h6+02LYH2+oOfGe7jtUof7RhS
 jp8VxzYxCzYCteHTtr2xfdCZ0FrrGSrZw94Zga6tvb8XOOSwkBqjB2wqQ7xQ+6Y0X3j2BdebM
 NwGvlj/9JneX6MIhtrqV39wM0GlxgTQIYh2+sMp/mkza5HENGQYomuh9uwvkQP7BBK2DMIold
 GBmGWGhKXmJR2eXbHKfhO8f+xH69IFyMWKNE4bj2GCKmyM5yAOlYLZS835tzLqySnuq3PpSnT
 IKnS1H7AKPav39mDKsOEsWutXMueZGlfZuBureFE2+l0NyjMkALMllXyoIhV7awkkSQsMbg7m
 QRvHwMg0JmAw27nUn2bfX+2vhv1+3gKlWdEgge+FE6gGwTWwNasDUlbvxj1Trr0QP19k2j6CA
 K7Flt19mFtX7yptl8bxd48zUBbuQiqaqTWOOOo97DV9ve0nWNgtoX2jR1ThWnOAP5w01elG7U
 IkkcuOIKLB1lMTkjpig4tCtbF5bCKjedftB3XSJC7Tx1yGa7qXhUz5uYNvoO9r4FdYOW4NffN
 NY1bPg6ndcu1IbFqKYB0DUkLTYKsXK2cwnsPmLquruPs010ZtxXXUlas1Y5wrMjyTfkVYaIhb
 /TbKo0leVhLaSS1vwjyVvCAQNKaALxCuFri6F/jH4+j5GeOgaQzAtRvq5bg8yjjLTpL6jZ6j+
 UUCw636R6pyzk34SVRweY6DlSjljeEGrHGU/0eGQSA4dzyTEyjEoLhVqHvZiRy2GNl++89y+9
 drhnkbYneN2xPDBImjSAKGHy3yNtIj3Oxy2vFP7RkBT8TVpiU+GdVHe3z5FhGmcuw370w4N0h
 tEmwkCb/84RpBKdW22XNNsvHua69lLq36YHWLQtL6m4raJ7STENnuNIfh
Subject: [cocci] [PATCH 1/4] overlayfs: Return directly for two checks in
 ovl_fill_super()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 989
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/93cceba1-ae51-0ab6-cc8a-53ce7143832a%40web.de>

Date: Thu, 30 Mar 2023 08:48:34 +0200

1. Return directly after a call of the function =E2=80=9Ckzalloc=E2=80=9D =
failed
   or the =E2=80=9Cuser_ns=E2=80=9D was different in a data structure
   at the beginning.

2. Delete the label =E2=80=9Cout=E2=80=9D which became unnecessary with th=
is refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/overlayfs/super.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index f97ad8b40dbb..c0d33ab331ec 100644
=2D-- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1894,16 +1894,14 @@ static int ovl_fill_super(struct super_block *sb, =
void *data, int silent)
 	unsigned int numlower;
 	int err;

-	err =3D -EIO;
 	if (WARN_ON(sb->s_user_ns !=3D current_user_ns()))
-		goto out;
+		return -EIO;

 	sb->s_d_op =3D &ovl_dentry_operations;

-	err =3D -ENOMEM;
 	ofs =3D kzalloc(sizeof(struct ovl_fs), GFP_KERNEL);
 	if (!ofs)
-		goto out;
+		return -ENOMEM;

 	err =3D -ENOMEM;
 	ofs->creator_cred =3D cred =3D prepare_creds();
@@ -2073,7 +2071,6 @@ static int ovl_fill_super(struct super_block *sb, vo=
id *data, int silent)
 	kfree(splitlower);
 	path_put(&upperpath);
 	ovl_free_fs(ofs);
-out:
 	return err;
 }

=2D-
2.40.0

