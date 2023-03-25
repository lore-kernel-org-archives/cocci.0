Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6407C6FD1F
	for <cocci@archiver.kernel.org>; Sat, 25 Mar 2023 14:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=8IJLvyL3JyjmFpkYnhruGfn5ph2921jn2wBuULP5gIQ=;
  b=cMCoVzfXNcc3W+DQbAmzpEPh+1NUfuvSEchWsakI4864SOb6uceOqxsB
   wp+KXZVDqINo+ahhKrSLObrDQjgZNVEDa+cn2eJMzGt4D+k+kt4RSTm45
   8PbsnUWSpe+ImHx1XrzTyRkAcpO39ni8JdwHL5s4px+ijdityj+OfcEY+
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
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="99066057"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2023 15:10:29 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2E976E0D45; Sat, 25 Mar 2023 15:10:28 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 09EF5E0D40
	for <cocci@sympa.inria.fr>; Sat, 25 Mar 2023 15:10:23 +0100 (CET)
IronPort-SDR: 641f00ce_clkhnHT0+3VPmnjNGdA9cQwi5WW0igxh8s3LMO4bF1LQyHb
 M6ZI4w80udWSsCE7eUBDZ8lSlObG3M4K+WXhqLw==
X-IPAS-Result: =?us-ascii?q?A0ErAAAKAB9khwQP49RaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YItgUsvBAtGhFOIH4hiLgOEL4cshzqEZ4QCgVaBQD4PAQMBDUEBAgQBAQMEO?=
 =?us-ascii?q?IFTgnMChToCHQcBBDAJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEA?=
 =?us-ascii?q?QECEAEBARoJFwcOEAUihWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBARICR1M9AwMjBBkBAREmAQ8fBgImAgJXBgEMBgIBAYJ6gigBAzEHsTV/M?=
 =?us-ascii?q?4EBgggBAQaCY5knHywiU4FeCYEULQGNBIM2eicPgVVEgTyDQYgcgmeCKIdWh?=
 =?us-ascii?q?yWILwqBNHWBIA6BPYEEAgkCEWuBEghrgX1AAg1kCw5vgUoCZEyBHiUEDgMZK?=
 =?us-ascii?q?x1AAgELOzo/NQYDCyAGWGsCCSMREwUDCxUqRwQIOQYcNBECCA8SDyxEDkI3N?=
 =?us-ascii?q?BMGXAEpCw4RA1CBRwSBCoEBBgEmJJpxAgGBdFMgAVI7TCaCBJJYkkCeDjQHg?=
 =?us-ascii?q?iiBVYFZDJ8MBhMulwgOBpIjLoctkA8goliFIoFjOoFcMxokgzZPAxkPjiAZh?=
 =?us-ascii?q?AyPR0A0OwIHAQoBAQMJhUYBAYV7AQE?=
IronPort-PHdr: A9a23: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
 Q==
IronPort-Data: A9a23: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
 D3GxkDNAw==
IronPort-HdrOrdr: A9a23:G16/8KqVp3VEIR8ZYiiJyD8aV5r/eYIsimQD101hICG9vPbo8/
 xG785rtiMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLWvbUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAamSS5vyb3ODXKadE/PC60OSPmfrUyWtrQDpncqd68m5Ce3um+wFNJTWvHvACZe
 GhDyd81kCdkf97VK6GOkU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="51233211"
X-MGA-submission: =?us-ascii?q?MDFqbh1Hm/f0voYZr2EEG48+bXbpcDn6ISJOcZ?=
 =?us-ascii?q?TdO4VEVPEGcbeDHfWmh9ImR61x4v9L7qAa27B4b5fSpdzLeLBm7RJX84?=
 =?us-ascii?q?gJUO77pnOCevWiMWaynYLXRFZxosBhxrRUYEHjWHPmUZsGicifX3bMCb?=
 =?us-ascii?q?2WX5PuhwUFd/FRzZiZjSnlkA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 15:10:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679753418; i=markus.elfring@web.de;
	bh=TytmCl7R54fjCo6yXfS+aU2NP1BzqsLZ/dFngEJ/kG0=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=eiXtzo5uImrdeBYOmmgBsDhee2yIA5fDB2MJ6w7B9ztm925xFi8UUqr4trrJ1ZYcC
	 Q6VgtC8c60gi4qpeIaQen+OmH9BIBiyv3rncsPd9QnRE9ka5Imf3jX5aMAbXa6S5O7
	 oS/Rqv3Lk0rR+VWBOdEFbVysNZp7MRJs/XP5ER23VO8XIrS2jJwFl3IlbMmzbS23YN
	 4qbajtd8VzD2IpJpqFQscDirm47nCw2IZk5Kq6J53XCb+45Rs/hZOAqojukl9LXwa0
	 7RNB+YXyw2LJEnGkm1FCeAZ+qUxV4GJeTFxevEELeXTb95JH03FrceDbgzLk3Sg2gg
	 G0OnM8hwzwoRA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MCGWc-1poMKu1ehW-009OmB; Sat, 25
 Mar 2023 15:10:18 +0100
Message-ID: <4170e338-44dd-d6b3-a8f2-dfa4c3a20c5b@web.de>
Date: Sat, 25 Mar 2023 15:10:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <3151f1ef-63c6-d016-7c6a-2572e3d93d8f@web.de>
In-Reply-To: <3151f1ef-63c6-d016-7c6a-2572e3d93d8f@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HKoYyhZSXf6Kbwzkw8+DX1Hkc+SGu5iGOqHh3eQVlUXcppEedHb
 Z+MtZeAIvPrKI3Vn2bbZ8CJ+aYG8A7n7VG8Y/sNFVVmWLQA/GxCi5l1Ia5kD/sKQ9QzmJM8
 LgkG/tGKTcaiReNRtM2j0/H7QEZV5cz5LN5ZmxJyuh9Ux8jri3qSseT+4Ig4X4U3swIEVQC
 dtcZg6dRLDJHmyI8m9xTQ==
UI-OutboundReport: notjunk:1;M01:P0:+04DdIkKrG4=;vkGhPfBLJfCcZs1UAJtfzkYAPUV
 ciHxRYFDhorrFyhkJXeWKv6HaAxb6J5OMaMN6rJmJO3GwRQjPQbsD0x6jWNXgqtvqvXUFFLmZ
 tW4RwH3bQjM8rbVtL9NrQiSO17Gp/e0LKy0U2ivyLLtDdK+zYmcoMrPiLXyZWPJ78pxfsSIQV
 LcPoWWKxr0DAWFaWD/MuJekaGnzWDYVrmIzOxPqkJkCahvT4RcT47e2GNtHI6qy9Zb8QZEE0Y
 2JH4lxs+mqUPHvLzHfTKHbvqnWDLySWwSkU3EeB2HcBdHb7KI7o1LsZdaxaqED0/Lx/HiYYOT
 yDElB8loJDrPY2bQXsgnMblYw2LTvmif/+7cd9oHn6btNm8Irg+CoSyOLbpkDlEy1dXzQxzF9
 TwGzE0ulQXzLCHw55cpN4szHTjVv0H++PLo49guwYJ5lBsYR8ennf/BeOucPGcWrNotWfM8C1
 bseHgo/Fc2L/K3mjidGKlTXZfZRgfMvsHPvNGmQ2xk2NdmT0+ZcyYUFzsMZ5OLBZ7c/7nZXUD
 uSyDz9U74lyOJW0Z0lM7Agq0CyD0RLTu+WaL60LH8Vc+yjL40CtGA7yQznEoftRaPWORCy82V
 09IHgUF1jtMGshdbmHMbBdnHVfAdHIkjLneXDYAI9CJblaiGllAmfPSw+lpUIGQJ18yuxMges
 uXNQgkl2MPh6cBOAHZ3h1NR4gY8gZ4UEzc98mqbnlVeKVZ2qZ3gapODlcaAMpLiCtbF1Ythrc
 u39TzflXNs1IPz49n0GY78meYnxBYj/lCgfe6JbHXUFpzjCRkYME2Uot886s5TImme8h5ga6w
 v7h2Apr5ej1Nj5MLrj0lP3lRCm9h9guaMrLhEZ5asW3kYbdFUBbEV8WpLtOkbiagyDnPM7+Rm
 l7mPVMwUq80aVVdf1SAIvm2hxxM+2Bjqvc5eAIdja3iiKCWWQiPP5Dtrq
Subject: [cocci] [PATCH resent] blk-mq: Add two labels in
 blk_rq_prep_clone()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 950
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/4170e338-44dd-d6b3-a8f2-dfa4c3a20c5b%40web.de>

Date: Fri, 17 Mar 2023 17:20:22 +0100

The label =E2=80=9Cfree_and_out=E2=80=9D was used to jump to another point=
er check despite of
the detail in the implementation of the function =E2=80=9Cblk_rq_prep_clon=
e=E2=80=9D
that it was determined already that the corresponding variable contained
a null pointer (because of a failed function call).

Thus use additional labels so that duplicated checks will be avoided.

This issue was detected by using the Coccinelle software.

Fixes: 06c8c691e2820077936e59ad334eb806e90b69eb ("block: move request base=
d cloning helpers to blk-mq.c")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 block/blk-mq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a875b1cdff9b..4b290d8cb6a0 100644
=2D-- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3118,10 +3118,10 @@ int blk_rq_prep_clone(struct request *rq, struct r=
equest *rq_src,
 		bio =3D bio_alloc_clone(rq->q->disk->part0, bio_src, gfp_mask,
 				      bs);
 		if (!bio)
-			goto free_and_out;
+			goto unprep_clone;

 		if (bio_ctr && bio_ctr(bio, bio_src, data))
-			goto free_and_out;
+			goto put_bio;

 		if (rq->bio) {
 			rq->biotail->bi_next =3D bio;
@@ -3149,7 +3149,9 @@ int blk_rq_prep_clone(struct request *rq, struct req=
uest *rq_src,

 free_and_out:
 	if (bio)
+put_bio:
 		bio_put(bio);
+unprep_clone:
 	blk_rq_unprep_clone(rq);

 	return -ENOMEM;
=2D-
2.40.0

