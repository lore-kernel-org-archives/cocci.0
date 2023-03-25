Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F69C6FD20
	for <cocci@archiver.kernel.org>; Sat, 25 Mar 2023 09:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=u17pA45hkSNie92KiUNPOnAOIekxYz2O/Zzpj7sGxbY=;
  b=KaYWC52AIw+UAkqAa8HyzCwAcTzXofy2rNJqjfyKAw60fP5tccx4Vu26
   gjwCvmTElBulK886zIWJAzei18auCUwlDMq8BvgKPWNVneuyHqWQ0Qyjh
   fc6+0n4SUzPthUmOavsUAcMkhkrjY3MgJpkzaStvzZlF/2wd8dCDbX/Gn
   Q=;
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
   d="scan'208";a="99046154"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2023 10:25:10 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5B08EE0D44; Sat, 25 Mar 2023 10:25:09 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E32FFE0D40
	for <cocci@sympa.inria.fr>; Sat, 25 Mar 2023 10:25:07 +0100 (CET)
IronPort-SDR: 641ebdf3_zLnYIKKUOYSHFgjvlK1y1hcpFAJ7istW/Bxm18gwewUplSO
 N6Tu82c4qxD5qaDZriNurtV/WXIOeFKNk0QV2XA==
X-IPAS-Result: =?us-ascii?q?A0EuAAC6vB5khwMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwGAQELAYItgUsvBAtGhFORAS4DhC+HLJAjgVaBQD4PAQMBDUEBAgQBAQMEO?=
 =?us-ascii?q?IFTgnMChToCHQcBBDEIDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEA?=
 =?us-ascii?q?QECEAEBARoJFwcOEAUihWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBARICR1M9AwMjBBkBAREmAQ8fBgImAgJXBgEMBgIBAYJ6gigBAzEHsSR/M?=
 =?us-ascii?q?4EBgggBAQaCY5knHywiU4FeCYEULQGNBIM2eicPgVVEgRUnDIM1hCaDdoJng?=
 =?us-ascii?q?iiHVocliC8KgTR1gSAOgT2BBAIJAhFrgRIIa4F9QAINZAsOb4FKAmRMgR4lB?=
 =?us-ascii?q?A4DGSsdQAIBCzs6PzUGAwsgBlhrAgkjERMFAwsVKkcECDkGHDQRAggPEg8sR?=
 =?us-ascii?q?A5CNzQTBlwBKQsOEQNQgUcEgQqBAQYBJiSacQIBgmcBUjtMJoF3DZJYEZIvn?=
 =?us-ascii?q?g40B4IogVWBWQyfDAYTLpcIDgaSIy6XPCCneoFlATeBXDMaJIM2TwMZD44gG?=
 =?us-ascii?q?YQMjwkBPUA0OwIHAQoBAQMJhUYBAYV7AQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:Lu7qfKz+GzlV6aZCF6FdKrPw+L1zdoMgy1knxilNoNJuA6ilfr
 OV7ZcmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bBYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebrN5DNB7foSjjPIduoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="51220072"
X-MGA-submission: =?us-ascii?q?MDGYZ8mgaGl4vqhc5Hl0eOs5T4YRt+rFsRbTVW?=
 =?us-ascii?q?4rU7eVif/YbjjSGL0Y/wcFBBH3UvzmORq9dUZX9Q2BMrAfC7Pu3a0rW/?=
 =?us-ascii?q?PKx2XUf0dEoXOoW2+Vj+vWfwQqy5FgRGgXaTpameMnVKAvUZLWGwOvfy?=
 =?us-ascii?q?lgvc9nRO9BBcY+1km4CqGSTg=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 10:25:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679736299; i=markus.elfring@web.de;
	bh=T8LPUtGu7m45KRdmDCmPNW1EQCSsVw1mLYq1oAiqX+E=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=YWUEpYsP9XshdyjfbFLzHUz4/R1EUKCzwaJEbvnWwyUuINq2kSJFQUsBKqk7b+OUW
	 BZ9Uskni/a6mDUutRZLKnZ0MoO84wUXJXBAIbMqzyBYi9gYKvEQnywfV60uamrK1ez
	 27Jpo85adG/WP0Hn1kLcpoGJZ/AF6tZ6nKEMGiwLc/A84Nr4RZ/Uwnzvo6zrMYR8xt
	 BbBSEpJwhPhU2z7ZWVIaxc8ChN62TQmHb4G2Vi67cnqhTUH2HFX+nGfv2EP2hGCn4V
	 EgALuQgN3v50WsA0VE6D8e7TUbiBiAUc+F3y1+DPaxCQF+9MTlsyPCfel4Oh4+9Bvv
	 whlNyhrb9yUjw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mf3ug-1q7t6v0keo-00gVFM; Sat, 25
 Mar 2023 10:24:59 +0100
Message-ID: <b8f68d5b-461e-9753-349e-3f4907ccf32f@web.de>
Date: Sat, 25 Mar 2023 10:24:57 +0100
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
X-Provags-ID: V03:K1:TmLr0aveQr6L3Bg5eS/KOe4pOrQcdxP9t+11nvhqPZsiZG569LH
 o6Ot6RFaSXfsyQWIRmN/1OSxrYx/crIUyx4MpbU5p8c78WwTUdgMGUXHRlrKEkQEa4mfTaX
 TRGfKHkBh/5PA0uQrLDg01Zc2jZUDfwnh/FbzLjmLEwGMqLdgxnaxMNNvGDJw6cWJO1L/0q
 /q9oI3NBNyOIOB4oM4srw==
UI-OutboundReport: notjunk:1;M01:P0:bY4uY+EnUl8=;sjIUjFVnkw+Um/42RVka3k2Lf4j
 g93G3QES6v4A4LBLvn3jb4wSK0hHPVvqtB34pESErvK8pn37r+iYYB9ztnmgtWQmduYkUe8bx
 3O6t1q7wrD++D60BgBnOPUrxrZaybjBwgBYI1MAjJMjIhXBUPNpB+1I2EaBdcHYcuIwiHEDNR
 DFv5Oje164zu6FUd0D5KG+Sw+sEPdTe7yVZ9WoqPvI34w7hHoNesboHh1c2a3vWsFg4nbeNtI
 RoJklyJtGwDvJ/k4IO4OcofhWMomPMaIbk7OXCIzFPVQyKG5Qzw0ypF/dvK+gF4h5jXZCnVZe
 y/l0PeXdbUpbmgFJC/lNizNHWMKvgabBxhdbAxKGpL2VusnrdD1u20W4ZbjKy1gAIm2aC1751
 7XsR+2/G2B3VdXeNn85fy7573yR6HMLGbg0Sv8RJdLBXuuqShRDTM/dV7KkJg08wc6QTCa6x0
 IECkWELtyfYUn7X6UyflsxppEBR+NCn3Qgu8IPDhsQ624+w0ABbBDOYyyvoVSaTumHNTodkI0
 lz/HMnZR11Dg2zKS957qz69sM0Te9A2PANJ2zQKze8kaEuC/sozKmoypqr1AEEF4C6KefYLIX
 wKU+Cyvm2hLfhqzf2Dmum6fa60VYG2gHGbPmbslZV0wje8uTridrF2WE2xzyAbCrxDULXesAB
 JiLGxyHNTl+nAEm3fPEMIO1C12yVUQIRJi/9d7U0DGiwziREOlRQ2WDxJqRCUTSlqH40EVR6P
 OAK3JZolVlcISFH/TAFifye3tBsitcsFYhcq+JqgqJHQJikqpY0HyXKeFPTnmaqQqFFcn9GhR
 T6bOHhlcXZ3buqEgZPiCdp8XRfQYbp+4T3r9vUs246ayfbRnKw4AtJRLwbaz+py+NPZwMd3cF
 zcJy3kMhWmy3BHSev479txyZfF/UfUhWkNTsSIS4Da/ZfQQJhrKj49AK7
Subject: [cocci] [PATCH resent 2/2] md/raid10: Fix exception handling in
 setup_conf()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 931
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/b8f68d5b-461e-9753-349e-3f4907ccf32f%40web.de>

Date: Mon, 20 Mar 2023 17:15:07 +0100

The label =E2=80=9Cout=E2=80=9D was used to jump to another pointer check =
despite of
the detail in the implementation of the function =E2=80=9Csetup_conf=E2=80=
=9D
that it was determined already that a corresponding variable contained
still a null pointer because of a failed function call.

1. Thus use more appropriate labels instead.

2. Reorder jump targets at the end.

3. Delete a redundant check.

4. Move an assignment for the variable =E2=80=9Cerr=E2=80=9D.

5. Omit an extra initialisation (for the variable =E2=80=9Cconf=E2=80=9D)
   which became unnecessary with this refactoring.


This issue was detected by using the Coccinelle software.

Fixes: dab8b29248b3f14f456651a2a6ee9b8fd16d1b3c ("md: Add support for Raid=
0->Raid10 takeover")
Fixes: afeee514ce7f4cab605beedd03be71ebaf0c5fc8 ("md: convert to bioset_in=
it()/mempool_init()")
Fixes: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 ("Linux-2.6.12-rc2")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/md/raid10.c | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 6c66357f92f5..12ce3e69e6f7 100644
=2D-- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -4006,7 +4006,7 @@ static int setup_geo(struct geom *geo, struct mddev =
*mddev, enum geo_type new)

 static struct r10conf *setup_conf(struct mddev *mddev)
 {
-	struct r10conf *conf =3D NULL;
+	struct r10conf *conf;
 	int err =3D -EINVAL;
 	struct geom geo;
 	int copies;
@@ -4016,41 +4016,41 @@ static struct r10conf *setup_conf(struct mddev *md=
dev)
 	if (copies =3D=3D -2) {
 		pr_warn("md/raid10:%s: chunk size must be at least PAGE_SIZE(%ld) and b=
e a power of 2.\n",
 			mdname(mddev), PAGE_SIZE);
-		goto out;
+		goto exit;
 	}

 	if (copies < 2 || copies > mddev->raid_disks) {
 		pr_warn("md/raid10:%s: unsupported raid10 layout: 0x%8x\n",
 			mdname(mddev), mddev->new_layout);
-		goto out;
+		goto exit;
 	}

 	err =3D -ENOMEM;
 	conf =3D kzalloc(sizeof(struct r10conf), GFP_KERNEL);
 	if (!conf)
-		goto out;
+		goto exit;

 	/* FIXME calc properly */
 	conf->mirrors =3D kcalloc(mddev->raid_disks + max(0, -mddev->delta_disks=
),
 				sizeof(struct raid10_info),
 				GFP_KERNEL);
 	if (!conf->mirrors)
-		goto out;
+		goto free_conf;

 	conf->tmppage =3D alloc_page(GFP_KERNEL);
 	if (!conf->tmppage)
-		goto out;
+		goto free_mirrors;

 	conf->geo =3D geo;
 	conf->copies =3D copies;
 	err =3D mempool_init(&conf->r10bio_pool, NR_RAID_BIOS, r10bio_pool_alloc=
,
 			   rbio_pool_free, conf);
 	if (err)
-		goto out;
+		goto put_page;

 	err =3D bioset_init(&conf->bio_split, BIO_POOL_SIZE, 0, 0);
 	if (err)
-		goto out;
+		goto mempool_exit;

 	calc_sectors(conf, mddev->dev_sectors);
 	if (mddev->reshape_position =3D=3D MaxSector) {
@@ -4059,7 +4059,7 @@ static struct r10conf *setup_conf(struct mddev *mdde=
v)
 	} else {
 		if (setup_geo(&conf->prev, mddev, geo_old) !=3D conf->copies) {
 			err =3D -EINVAL;
-			goto out;
+			goto bioset_exit;
 		}
 		conf->reshape_progress =3D mddev->reshape_position;
 		if (conf->prev.far_offset)
@@ -4077,22 +4077,26 @@ static struct r10conf *setup_conf(struct mddev *md=
dev)
 	init_waitqueue_head(&conf->wait_barrier);
 	atomic_set(&conf->nr_pending, 0);

-	err =3D -ENOMEM;
 	conf->thread =3D md_register_thread(raid10d, mddev, "raid10");
 	if (!conf->thread)
-		goto out;
+		goto e_nomem;

 	conf->mddev =3D mddev;
 	return conf;

- out:
-	if (conf) {
-		mempool_exit(&conf->r10bio_pool);
-		kfree(conf->mirrors);
-		safe_put_page(conf->tmppage);
-		bioset_exit(&conf->bio_split);
-		kfree(conf);
-	}
+e_nomem:
+	err =3D -ENOMEM;
+bioset_exit:
+	bioset_exit(&conf->bio_split);
+mempool_exit:
+	mempool_exit(&conf->r10bio_pool);
+put_page:
+	safe_put_page(conf->tmppage);
+free_mirrors:
+	kfree(conf->mirrors);
+free_conf:
+	kfree(conf);
+exit:
 	return ERR_PTR(err);
 }

=2D-
2.40.0

