Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BCA6C46CD4
	for <cocci@archiver.kernel.org>; Wed, 27 Dec 2023 17:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=+O0oPr+Mg6QszQgfZABvkLHy4AjtH4pOlEZxLxJuPoU=;
  b=HUx6XwUENWuHSKcMk/+fgxw6bJP3O6VB3vGUylcd2U8jcnZFPC6SFmk6
   5vSgVTXoJ69cwFJYpfgzEz4Y+8wHQJyOTwGoWXFDC511PtT8Q6ZfI+M7g
   8rQ1ljwsFUTr0v8wb5zqy2/EscR5SE5L6wD4qnSoBU8IhBdDj7EGmnpWY
   w=;
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
X-IronPort-AV: E=Sophos;i="6.04,309,1695679200"; 
   d="scan'208";a="144152022"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Dec 2023 18:18:27 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 903D0E0CCA; Wed, 27 Dec 2023 18:18:27 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 1429BE004E
	for <cocci@sympa.inria.fr>; Wed, 27 Dec 2023 18:18:25 +0100 (CET)
IronPort-SDR: 658c5c60_pbKqg9PRnZrjctNf+qExgeeKh71wd9eAz81nerY0Wkj6Dfy
 u5UX03iS2OBuYlYyGRGK/WpbqUDuisBdvemdRNg==
X-IPAS-Result: =?us-ascii?q?A0H0AwDlWoxl/wMP49RaHgEBCxIMQIFEC4I5B3hTMgQLS?=
 =?us-ascii?q?IRTj0GBdTCEO4c1h0yEa4QEgVaBQD4PAQMBDUEBAgQBAQMEOIRHAoc2Ah4HA?=
 =?us-ascii?q?QQwCQ4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECgQYThWwNglwBE?=
 =?us-ascii?q?IEMgR4BAQEBAQEBAQEBAQEBAQEBAQEXAkdCBiMdAQERJgEPHwEFAiYCAlYGA?=
 =?us-ascii?q?RICAQGCfIIrAQMxB64zgTKBAYIKAQEGgmasch8sIlaBYAmBGi6IGwGFZ4NBe?=
 =?us-ascii?q?icPgVVEgTwLgkB2iB6CaINmhTYHMoIcg0+RVn0FQXAbAwcDfw8rBwQwIgYJF?=
 =?us-ascii?q?C0jBlAEKCEJExJAgV+BUgqBAT8PDhGCPiICPTYZSIJYFQw0BEZ1ECoEFBeBD?=
 =?us-ascii?q?m4bEh43ERAFEg0DCHQdAhEjPAMFAwQzChINCyEFVgNCBkkLAwIaBQMDBIEwB?=
 =?us-ascii?q?Q0aAhAsJwMDEkkCEBQDOwMDBgMKMQMwVUQMTwNsHzIJPA8MGgIbHg0nIwIsQ?=
 =?us-ascii?q?gMRBRACFgMkFgQ0EQkLKAMsBjsCEgwGBgldJgcPCQQlAwgEAyspAyN0EQMEC?=
 =?us-ascii?q?gMUBwsHUgMZKx1AAgELbT01BgMLGwY+AqZNgQ6CdsUBNAeCNIFggWEMnysGE?=
 =?us-ascii?q?AMvlyYOBpJULodQkE8gqEaBYz2BWTMaJIM2TwMZD44gOINzj0dANTsCBwsBA?=
 =?us-ascii?q?QMJhUYBAYNagUYBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:lB3Ej6uLTEGqaraQh0ZnWHmj7skDotV00zEX/kB9WHVpmwKj5q
 STdYcgpHzJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniFhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfD9HZK3BgDVQfexQpeWvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-Talos-CUID: =?us-ascii?q?9a23=3Am6oanGq9EcKkzXzQApaAr4rmUfomf2WCykrKGE+?=
 =?us-ascii?q?9JTppU4y2EUS08poxxg=3D=3D?=
X-Talos-MUID: 9a23:iqAxLwpyKUSmghFFlWsezyF9ZOxa/LqIMUZTkoQ6ipOfGgtcaw7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,309,1695679200"; 
   d="scan'208";a="144152019"
X-MGA-submission: =?us-ascii?q?MDFRBSEBHP9/p6vPS5lwCcr0iU4HIDHXNRIQbE?=
 =?us-ascii?q?N3hgnaaN6EyeIVFwMB+mR6etN2L2WZL/xtD1AW5JHYJFEbolqHP8OlcY?=
 =?us-ascii?q?LjAnHLN0Bzx94v2e2HBfctXzBxrt2iVxJxLaEc59+Y2/SVaQXj1/3qBR?=
 =?us-ascii?q?hOC9g3LFIOkrrI1XJbnjxFBA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 18:18:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703697488; x=1704302288; i=markus.elfring@web.de;
	bh=dwFepwTmoz1K5UBHElv534KOXOgEY3BfjF5zKd4bVyg=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=PWyawNPC21xNRABWg/UjEGrcxM8lY6DWQkdkc0YOqXNNk7ndtp8CHqNT/7AxnVRs
	 vY+eRPVcxm08w4WnQ3bBq4Wvs9+iwu6tdrZYbDOVStXMkirOUxmwz0n2zu21Ejyno
	 5/60gSbl1KZe2Cv/yaFTKVXF/wa/OxoP9q7ZAuzIkPHwot098Mu3CfTTb2sRYiAG9
	 hyNp7SoUx4yj7gMO5tg05TXIWLN94jmPLxgMyHjk7168ZAPcSR7wcBdfuJ2kvLeCf
	 rvnkC2a57MzRgp4ISBg/lM2vSQQclUkQrZ0P8I+Pi21faj1OsSHo/VPFCMb+zraYi
	 yxo+EzVjzJwZs29JCA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M6pYY-1rKA6Y2S34-008fhK; Wed, 27
 Dec 2023 18:18:08 +0100
Message-ID: <40059711-eec1-4e52-9ef8-1ebf066aa11d@web.de>
Date: Wed, 27 Dec 2023 18:18:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-nvme@lists.infradead.org, kernel-janitors@vger.kernel.org,
 Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 James Smart <james.smart@broadcom.com>, Sagi Grimberg <sagi@grimberg.me>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <6b821c46-7248-4882-aa6b-0279803f4235@web.de>
In-Reply-To: <6b821c46-7248-4882-aa6b-0279803f4235@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aUG30CfZLJU1YbJxvTKb5BgY2Fh5dGqh4jBoV4TVF1WoxvGbQjt
 ilLMXEtVceGDKtnCW5fqr736P+8WTFRJy9I7KmsiKE7AgAYPUKdMgIY4139MmtTwdukN344
 dudh+1cIBRZFvAT7dqOyQnoZXRPp2ICnsqlRjvBBSrde7naIRdQl3CI18QcrlvLVXU74kM4
 5np5ozRi0Ux0rqBYokQyg==
UI-OutboundReport: notjunk:1;M01:P0:CBX/uooqcM8=;WzKz1uEE85xPvuxjzgRPPWoEw79
 UuoBnLCA0bmw0gB2lANhPNXrTNr2RH3SG6ZX8uoL5tH391fp59GcwkPeqNJazkSfyD/6/tfAY
 U73rwP7hripkGjTGQcq98S6VJwDPqbsPESGUZgIJry43L5hU0Q/LPROkClR53dB2+cA3ZgXDO
 RiUr1Jid4uziu62aB5hC/q3s5aOYgA6AmBOn0/wLlJC+uQ2UC8StnX6zg6gs6GAWhjv3/LKaU
 Qf63cav4DChBGg3H5Ztv+hA9LbjZW+pmihnX3qf4HVlUCNJTtKIpIvBUac/yGNMlPjOhkIaKA
 Kb8VofK+gu4CQxPCLTAz68Kb1IIoAiJ5VLkpYSmduqBzklUeiATSxq1/GPaZSY6pY6RTNT6/z
 ksbzKDhyQBLX3G1yidETNZUlrWi1nDzJTQ2uDO9w65JU4dSYLsQTJaRnLX8uIrCVAjM0WK+kn
 icIQ9nt0p04ZhmOVSOISfkbZdSm6uewvnKyl2giEK9FVMtiknOREbJ9q41GrljudrUCT0rWx6
 oqLvrCv3hpkbSXOXcuJHC52OsOZWE41honvBEGq5NU3xJNWOIEkO2nEgzuUB4Xp4CMBjipRN7
 Z+HVQSJLapvTnkDL98YFQZ0SZGS3OX2OAdsuP85T5rA0gt0sgmVmk/4mtcm34orsWzbGlEMM9
 5uMjGjhb4nT7HzRYguPMoJfldS5gFPac2DEYhUQVzh0Y1ZAE1OGa2CdGlfYeWC4d9wSauLwgU
 e5wcU2vd4c+UWnpadtpobvpwr3Cg5zir4YYgD36U73I92qcJHp23inQgTeIOSCCg3cn4YaYCQ
 uR3xstgt9WcEW6mALEy5S7r9UvyOnmKN4S6g1gapasa+FQPk1IZuCWLI3GHak2HrqTC6EFYDV
 3UH/tMKfO3eof5CqwS0bOBgEFnqdxywNjTZg3v6EQ0cJavRq+Qg72y+TV+EIXaqpsCyTGUoMD
 8VZcGQ==
Subject: [cocci] [PATCH 2/2] nvmet-fc: Improve a size determination in
 nvmet_fc_alloc_ls_iodlist()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1421
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-12/40059711-eec1-4e52-9ef8-1ebf066aa11d%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 27 Dec 2023 18:03:10 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/nvme/target/fc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 856a68404f32..ada257b3c681 100644
=2D-- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -537,8 +537,7 @@ nvmet_fc_alloc_ls_iodlist(struct nvmet_fc_tgtport *tgt=
port)
 	struct nvmet_fc_ls_iod *iod;
 	int i;

-	iod =3D kcalloc(NVMET_LS_CTX_COUNT, sizeof(struct nvmet_fc_ls_iod),
-			GFP_KERNEL);
+	iod =3D kcalloc(NVMET_LS_CTX_COUNT, sizeof(*iod), GFP_KERNEL);
 	if (!iod)
 		return -ENOMEM;

=2D-
2.43.0

