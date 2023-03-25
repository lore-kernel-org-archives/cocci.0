Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8DBFC6FD1C
	for <cocci@archiver.kernel.org>; Sat, 25 Mar 2023 09:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=t4NuwjFUzFRBy3bl261irHDEh7nQl8b8WPPEFzUoFO8=;
  b=awN8Q9duMVowHRw8B2IzbzCaL0FDABZlS793J8B+XwSAdXMHgRvUx7Zl
   kpZXF6Gmo1+MA9yGehNI1Ve8Dc8xLDP2z8Kss0BBVyw3qj8ssu8SRvOwU
   5o/ti4Pnt0aY0ingMSrnbhk6V8sCeXv94O6aS5JrYA/MK+cBpG7f08vw8
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
   d="scan'208";a="99046038"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2023 10:23:18 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 455E7E0D44; Sat, 25 Mar 2023 10:23:17 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C2085E0D40
	for <cocci@sympa.inria.fr>; Sat, 25 Mar 2023 10:23:09 +0100 (CET)
IronPort-SDR: 641ebd7f_MWmBWmuRoj/olabFINGEnc8ZobO9Skny6FDYLjrn3JkCcYN
 ejbfdSiJykLXhl62u1ETLOKDCSoLowgu+n5UylA==
X-IPAS-Result: =?us-ascii?q?A0FgAABPvB5khk7ASNlaHQEBAQEJARIBBQUBQIE9BgELA?=
 =?us-ascii?q?YItgUsvBAtGhFORAS4DhC+HLJAjgVaBQD4PAQMBDUEBAgQBAQMEOIFTgnMCh?=
 =?us-ascii?q?ToCHQcBBDIHDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEAQECEAEBA?=
 =?us-ascii?q?RgJGQcOEAUihWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARICR?=
 =?us-ascii?q?1M9AwMjBBkBAREmAQ8fBgImAgJXBgEMBgIBAYJ6gigBAzEHsSJ/M4EBgggBA?=
 =?us-ascii?q?QaCY5knHywiU4FeCYEULQGNBIM2eicPgVVEgRUnDIM1iByCZ4Ioh1aHJYgvC?=
 =?us-ascii?q?oE0dYEgDoE9gQQCCQIRa4ESCGuBfUACDWQLDm+BSgJkTCN7JQQOAxkrHUACA?=
 =?us-ascii?q?Qs7Oj81BgMLIAZYawIJIxETBQMLFSpHBAg5Bhw0EQIIDxIPLEQOQjc0EwZcA?=
 =?us-ascii?q?SkLDhEDUIFHBIEKgQEGASYkmnECAYJnAVI7TCZSZUANK5ItEZIvng40B4Iog?=
 =?us-ascii?q?VWBWQyfDAYTLpcIDgaSIy6XPCCneoFqAzCBXDMaJIM2TwMZD44gGYQMjwkBP?=
 =?us-ascii?q?UA0OwIHAQoBAQMJhUYBAYV7AQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:1tmpSqnZhOqCeJQkPGhC6goGnsrpDfL43DAbv31ZSRFFG/FwWf
 re+MjzpiWE6wr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQmVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6voSizPZLz9P+qjjzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="99046033"
X-MGA-submission: =?us-ascii?q?MDEGaosVNeZ9jie3owYU2IkIM0FpbXNvhmObCZ?=
 =?us-ascii?q?BQ+Jr5lCpA3HLSXIBt/jmMfuQGdJ9olWUrecyMt9N87z4MZqdCjcdjf0?=
 =?us-ascii?q?phz1OqTzlszdPyg1cILhM97evdyZ/IiwQQ4RmyEMhEf8T3Y9THT8SFOQ?=
 =?us-ascii?q?WUeIELhWN9HgscXDMDHuk9QQ=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 10:23:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679736179; i=markus.elfring@web.de;
	bh=MRffXbn9b4Tb1jtRiHGMK/jenWnYco5r7G/ZxtKqmJ0=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=YiHCZQUmt+/Br7UOeXET4GICZ0RtTKRmu4atmnbCSremQAXNOh+IWRKywN4dG6/lt
	 WY9gGm06JoI1V4ZsIVNQ6x7nqNciJdtiJHeD/UR+AE0w3YHQ0VweLXyGW+c7PhhlZy
	 BX4GFfcJ3F9swEd5zHl0WFiTQWJ9gZLplvAcL3Jy10YOW7SxrH9eZTwfeNg/00heCD
	 0LjvrnbgGdvS6h9mw1rPjFbM5v4OUNOXmLLRnGvPrFdj7scUyxQotRvnVoeJJ+/im8
	 QhESiGrBoUNePpHqN4YLkHUkNpMBJ7cmZJQAxRdGtZXHeLVXvu9Bc5zfuma36RNWti
	 TZfMsHasx3Hbg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Ma0Tu-1q0ubH2xRE-00WLSk; Sat, 25
 Mar 2023 10:22:59 +0100
Message-ID: <5476e173-567a-2177-6bf5-59e85b09388b@web.de>
Date: Sat, 25 Mar 2023 10:22:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-raid@vger.kernel.org,
 Coly Li <colyli@suse.de>, Jens Axboe <axboe@kernel.dk>,
 Kent Overstreet <kent.overstreet@gmail.com>,
 Maciej Trela <Maciej.Trela@intel.com>, Neil Brown <neilb@suse.de>,
 Shaohua Li <shli@fb.com>, Song Liu <song@kernel.org>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <6ee3b703-2161-eacd-c12f-7fa3bedf82dc@web.de>
 <49adf0c8-825a-018f-6d95-ce613944fc9b@web.de>
In-Reply-To: <49adf0c8-825a-018f-6d95-ce613944fc9b@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rBCTVwstJu/E7rwD7wKCuz6Y3xNcwF/aN+0GpSYe/S9DVLQfwWc
 3Ke8NPfFhlMvYRUskk3QGLpcp1v3U3K21RPiiztboLRGtI8mbXnd8ELjNXtK3hWB9UP6lJb
 83mb4iZWFyim3qgXcy1NTg7CBlyD4NoMUuTGIYFduLDxfyCS7FGi+kulfi35e0EHLx6Q9wx
 C/ZXsp8FDc2vIwkifH6CA==
UI-OutboundReport: notjunk:1;M01:P0:sYqW1wb9aE0=;iEquouVomjl/F8y6AervA82YqfB
 cXcWkwJ0y7q43/mpQlALzWuqRXbQ/M/oAdzad19AFj9JPoGVwK66yuyQ2mc83FL0H21rQpkf/
 oIHDZb7a7OJF1Aephb/2D92vCwKiKCNVJ6xcxDLUSrXGDXIVdb5GpcRCMcrwPmhf42H+fXcmr
 suyT424WKxibeVF5ZsjHswoMxERY/E+3hpG/gKtKCVSlbehoNKFt/L/xMYiPNG2TAKCwiqDWW
 oSWF9j8B9SFzFs46MDWmO5qpGEdHSIc3iNRgC6yZeKaaYWgkkQCwVCX/PM+JgwZyXRaizg5JE
 +p2H/9oNTiBuI2w4rzvbgMwEFi/XnZv6avt1XZFk1cwJMlAAT/FKSE6QVuOJPp27SBfrLDzaa
 mdQyXBRCtr8V1DLmjSBL6dv7UzvHJ85gh78kWHO9lKP11jh4wqSKts9RKdnsuvv/1ZFtwG7Xg
 EeiC/J/F6pZQPri5n/pNuZo2XyNNPOBDZkTgxWHVPcN0h54X9S4EQdjHkLVazbouJCV/HHg+4
 H8gue/qwXzlYWnwcJ31vbrD7B88Am2h0IU5+iJfoL9JLpongWUEoukKY5JlVQBkQ1QmF7edkd
 v84inJX2I9iuhyUMygUawNmzLuHqlDHsabEdAS1Yii3gmr1/biDwg678EsM8nvuEm712Zk6+h
 6o4izevNpNBvfPNOlhjEO5eax+f4Ogm/VQXl6VOKToMGorljQpottfSv9Gyt+nMTT1HZEs+RK
 wLiirWkY7BaeZ7qWxFtCw8lQrgHPOLyVxYYCBQ6YfFTD3bBbe8fBhOGpDOLsFXb7aqwq0ZMZ5
 u4urYogckifgrXn3NtTWQ7lELFtoQix4BkAeIsmjkEQLx0ScSyYjGOceMmLUGZjpejNoD+kn2
 Zq3wUTbuVYZe+pN9vb5gOhU7xMVHUD7s4V80Yht4aCreUaRtX7cSCJf76
Subject: [cocci] [PATCH resent 1/2] md/raid1: Fix exception handling in
 setup_conf()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 930
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/5476e173-567a-2177-6bf5-59e85b09388b%40web.de>

Date: Mon, 20 Mar 2023 16:40:11 +0100

The label =E2=80=9Cabort=E2=80=9D was used to jump to another pointer chec=
k despite of
the detail in the implementation of the function =E2=80=9Csetup_conf=E2=80=
=9D
that it was determined already that a corresponding variable contained
still a null pointer because of a failed function call.

1. Thus use more appropriate labels instead.

2. Reorder jump targets at the end.

3. Delete a redundant check.

4. Move three assignments for the variable =E2=80=9Cerr=E2=80=9D.


This issue was detected by using the Coccinelle software.

Fixes: 709ae4879ae33628ded276ce7da8cd5acfec476b ("md/raid1: add takeover s=
upport for raid5->raid1")
Fixes: fd76863e37fef26fe05547fddfa6e3d05e1682e6 ("RAID1: a new I/O barrier=
 implementation to remove resync window")
Fixes: afeee514ce7f4cab605beedd03be71ebaf0c5fc8 ("md: convert to bioset_in=
it()/mempool_init()")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/md/raid1.c | 75 +++++++++++++++++++++++++++-------------------
 1 file changed, 44 insertions(+), 31 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 68a9e2d9985b..b614f50505ec 100644
=2D-- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -2978,54 +2978,54 @@ static struct r1conf *setup_conf(struct mddev *mdd=
ev)

 	conf =3D kzalloc(sizeof(struct r1conf), GFP_KERNEL);
 	if (!conf)
-		goto abort;
+		goto exit;

 	conf->nr_pending =3D kcalloc(BARRIER_BUCKETS_NR,
 				   sizeof(atomic_t), GFP_KERNEL);
 	if (!conf->nr_pending)
-		goto abort;
+		goto free_conf;

 	conf->nr_waiting =3D kcalloc(BARRIER_BUCKETS_NR,
 				   sizeof(atomic_t), GFP_KERNEL);
 	if (!conf->nr_waiting)
-		goto abort;
+		goto free_pending;

 	conf->nr_queued =3D kcalloc(BARRIER_BUCKETS_NR,
 				  sizeof(atomic_t), GFP_KERNEL);
 	if (!conf->nr_queued)
-		goto abort;
+		goto free_waiting;

 	conf->barrier =3D kcalloc(BARRIER_BUCKETS_NR,
 				sizeof(atomic_t), GFP_KERNEL);
 	if (!conf->barrier)
-		goto abort;
+		goto free_queued;

 	conf->mirrors =3D kzalloc(array3_size(sizeof(struct raid1_info),
 					    mddev->raid_disks, 2),
 				GFP_KERNEL);
 	if (!conf->mirrors)
-		goto abort;
+		goto free_barrier;

 	conf->tmppage =3D alloc_page(GFP_KERNEL);
 	if (!conf->tmppage)
-		goto abort;
+		goto free_mirrors;

 	conf->poolinfo =3D kzalloc(sizeof(*conf->poolinfo), GFP_KERNEL);
 	if (!conf->poolinfo)
-		goto abort;
+		goto put_page;
+
 	conf->poolinfo->raid_disks =3D mddev->raid_disks * 2;
 	err =3D mempool_init(&conf->r1bio_pool, NR_RAID_BIOS, r1bio_pool_alloc,
 			   rbio_pool_free, conf->poolinfo);
 	if (err)
-		goto abort;
+		goto free_poolinfo;

 	err =3D bioset_init(&conf->bio_split, BIO_POOL_SIZE, 0, 0);
 	if (err)
-		goto abort;
+		goto mempool_exit;

 	conf->poolinfo->mddev =3D mddev;

-	err =3D -EINVAL;
 	spin_lock_init(&conf->device_lock);
 	rdev_for_each(rdev, mddev) {
 		int disk_idx =3D rdev->raid_disk;
@@ -3037,8 +3037,11 @@ static struct r1conf *setup_conf(struct mddev *mdde=
v)
 		else
 			disk =3D conf->mirrors + disk_idx;

-		if (disk->rdev)
-			goto abort;
+		if (disk->rdev) {
+			err =3D -EINVAL;
+			goto bioset_exit;
+		}
+
 		disk->rdev =3D rdev;
 		disk->head_position =3D 0;
 		disk->seq_start =3D MaxSector;
@@ -3054,7 +3057,6 @@ static struct r1conf *setup_conf(struct mddev *mddev=
)
 	bio_list_init(&conf->pending_bio_list);
 	conf->recovery_disabled =3D mddev->recovery_disabled - 1;

-	err =3D -EIO;
 	for (i =3D 0; i < conf->raid_disks * 2; i++) {

 		disk =3D conf->mirrors + i;
@@ -3069,9 +3071,11 @@ static struct r1conf *setup_conf(struct mddev *mdde=
v)
 				disk->rdev =3D
 					disk[conf->raid_disks].rdev;
 				disk[conf->raid_disks].rdev =3D NULL;
-			} else if (!test_bit(In_sync, &disk->rdev->flags))
+			} else if (!test_bit(In_sync, &disk->rdev->flags)) {
 				/* Original is not in_sync - bad */
-				goto abort;
+				err =3D -EIO;
+				goto bioset_exit;
+			}
 		}

 		if (!disk->rdev ||
@@ -3083,26 +3087,35 @@ static struct r1conf *setup_conf(struct mddev *mdd=
ev)
 		}
 	}

-	err =3D -ENOMEM;
 	conf->thread =3D md_register_thread(raid1d, mddev, "raid1");
 	if (!conf->thread)
-		goto abort;
+		goto e_nomem;

 	return conf;

- abort:
-	if (conf) {
-		mempool_exit(&conf->r1bio_pool);
-		kfree(conf->mirrors);
-		safe_put_page(conf->tmppage);
-		kfree(conf->poolinfo);
-		kfree(conf->nr_pending);
-		kfree(conf->nr_waiting);
-		kfree(conf->nr_queued);
-		kfree(conf->barrier);
-		bioset_exit(&conf->bio_split);
-		kfree(conf);
-	}
+e_nomem:
+	err =3D -ENOMEM;
+bioset_exit:
+	bioset_exit(&conf->bio_split);
+mempool_exit:
+	mempool_exit(&conf->r1bio_pool);
+free_poolinfo:
+	kfree(conf->poolinfo);
+put_page:
+	safe_put_page(conf->tmppage);
+free_mirrors:
+	kfree(conf->mirrors);
+free_barrier:
+	kfree(conf->barrier);
+free_queued:
+	kfree(conf->nr_queued);
+free_waiting:
+	kfree(conf->nr_waiting);
+free_pending:
+	kfree(conf->nr_pending);
+free_conf:
+	kfree(conf);
+exit:
 	return ERR_PTR(err);
 }

=2D-
2.40.0

