Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2206AC7EE2F
	for <cocci@archiver.kernel.org>; Tue, 23 May 2023 17:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=4miiF7THSo4FXcc52y442OwYk9av8Qx/d0HgHiyhktQ=;
  b=ukq4jG6RcwNV7K2+B6zWXNM+Bv3jdX2ieH88qowwkaIzBleCG49ifSRX
   TEBFxZfA4VEZ8f/rSXX0tt4fqSvkbInLK5DFuYKfpFJd9+/c5Afq98m2x
   SKS017TIs9XmHBXwZOCD0yAkHPC/U9Cf5K0xQnN/fc4hautOvUHlmHc0W
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
X-IronPort-AV: E=Sophos;i="6.00,187,1681164000"; 
   d="scan'208";a="109304996"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 May 2023 19:44:27 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 60DB1E0298; Tue, 23 May 2023 19:44:27 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 0240DE00A8
	for <cocci@sympa.inria.fr>; Tue, 23 May 2023 19:44:22 +0200 (CEST)
IronPort-SDR: 646cfb74_CN9S/IL5MvTp6FKzDDQNn4bU3cZcDfKohcL5gpjyuIHx6Fk
 0st4HjekCsKgJtkttIICnbdxyVGy6bB5N9Rrdyw==
X-IPAS-Result: =?us-ascii?q?A0GDAwCZ+mxkhwQP49RaHgEBCxIMQIFEC4IveFMwBAtGh?=
 =?us-ascii?q?FKPE4InhDOHMIdEiGqBVoFAPg8BAwENQQECBAEBAwQ4hEcChVsCHQcBBDAJD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFAQIQAQEBIxcHDhAnhWgNg?=
 =?us-ascii?q?jcpARFkgQgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARICRz8DAyMEGQEBESYBD?=
 =?us-ascii?q?x8BBQImAgJXBgEMBgIBAYJ6gigBAzEHrUV/M4EBgggBAQaCZZkoHywiVYFeC?=
 =?us-ascii?q?YEVLY0tgzd6Jw+BVUSBPAyBCYIthAuEFIJnjy2DEolzgTBygSOBKIECAgkCE?=
 =?us-ascii?q?WeBDghmgXNAAg1kCwtsgTtaQ4FpAgIRQgwVBVgCgQQQARMDBwQCgQ4QMQcEN?=
 =?us-ascii?q?wshBgkdNS0GXQcvJAkTFVMHhCsDCgoTJQQOAxkrHUACAQs7Oj01BgMLHwYmH?=
 =?us-ascii?q?wKCAwSBCXsGASQkoCKBDoJ2lgCZYJQSNQeCLoFagV0MnxYGEy+XEQ4Gkioul?=
 =?us-ascii?q?1sgqBCBYzqBXDMaJIM2TwMZD44gGYQNjwkBPj80OwIHCwEBAwmFRgEBgySCW?=
 =?us-ascii?q?gEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 T3TFrMc8/RxLlxUqT4v28GG
IronPort-HdrOrdr: A9a23:hcvGXq20hjUvcxdGNWOYPgqjBGYkLtp133Aq2lEZdPWaSL39qy
 ncpoV56faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SPjUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyWMbEQt6bHCWeDYrMd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: 9a23:jFU9fG5LRJtjD/Xi79ss6lUeAJgPU0Tn6FSNKEDhNX1uYpetRgrF
X-Talos-MUID: =?us-ascii?q?9a23=3A8j73UA//jXHyIYQ2Ssdnh9+Qf+lioKWIUUZKqp4?=
 =?us-ascii?q?Hhs+ZJS5WBWiDlB3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,187,1681164000"; 
   d="scan'208";a="109304993"
X-MGA-submission: =?us-ascii?q?MDHBO3d32WjER7PNOsl2BdlSzTzL6C6wMv/hSk?=
 =?us-ascii?q?XmBfKJuadOq4urrVSK0QLbjQ9A6rRPjKAvxqGWTrSUH08u8Sw6mf7eBQ?=
 =?us-ascii?q?6eHD0crExcgvw+HDSBjKPYEsPNJA+6ks4SNQkcqdig9bRqF+6cGIj2/G?=
 =?us-ascii?q?b5QCa8tz3UUz7SOxwPeR/6Dg=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 19:44:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1684863855; i=markus.elfring@web.de;
	bh=7d1ZHf1OTR0FUWvsWH8nz9gvTQZMaXN4+xkGz9tx3Zc=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=vZNcfhsicZ+SSZexfuYZTsKMga++w0EzveWxLURbnOkoPcYrzzptlNLbd1hJPzPrs
	 WFvulXOuxB7/aX7nGINIHm3Iq4/xiXM8yhsh8XYhzwJONeQNk2ctEkBBCC4/y1g5x3
	 C2jknyjB6tYPmoSddJ8CBABIuSLIWCXeX+cK4DDLt7Di2UPWQ+4ZQX8UFGmZQvZ2Zp
	 OWgrGcO3ZTJiH5xdTtg93OemWxk0eXCGfatEcusp4q4rHf7i98p2TtiYSSGTSo7N5J
	 D6EgE1Lfrtgrsl1+KcAU67f+iXhP6dWn8cTvc1RFYOrgbxI7HL7Vo/Ms3RHT2k29cQ
	 K3GPlxh2iouuQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MJnrh-1phuha1zYX-00JvlZ; Tue, 23
 May 2023 19:44:15 +0200
Message-ID: <b924f0b9-c769-3f9d-6242-c478408663fd@web.de>
Date: Tue, 23 May 2023 19:44:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Helge Deller <deller@gmx.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
 =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Zheng Wang <zyytlz.wz@163.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr,
 1395428693sheep@gmail.com, alex000young@gmail.com, hackerzheng666@gmail.com
References: <069f2f78-01f3-9476-d860-2b695c122649@gmx.de>
 <97807a2d-ccf2-1fbf-06f7-085bb1bdf451@web.de>
In-Reply-To: <97807a2d-ccf2-1fbf-06f7-085bb1bdf451@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1FZrJ8q5Usts1dKqw0p2/up3PDfR6unfNFSwyswIoBUo91rS47t
 KofXFn8jFWLVAmK0yjE3C6kVMrNxMmMFaVv1p79F9tDrvIIOc3GzOIvMKvHX8sAMcdP4fXf
 l72hDlCeMbeQwME8HPYAEYzjjBWC84b4tqjPTulj0qVJMWiOvqKw6Rr0nLBqn5lVWg3R3m8
 Wz3bmqIwAqhgsgS3W9V/g==
UI-OutboundReport: notjunk:1;M01:P0:vZrdde+8SPs=;EpAgtuyYllM+0Pt9GiQmYFXCmOv
 qF9a07CT9Tr/7PN0HB75GQTNSKM/vVFnjHKBJ71yIxjZfMc2sYgpg4QXQL7uvWYhuT6/0iY1+
 EZFBZVMTsOLQiWthRwtxvQ9Qg0NCNgnwBUyIfAqZL0VKRgKMsYVhHpq+afCKhSP0og3utGqoP
 5XfLOpfiAJtLVK5TCzaAcrEUd2IJPYuoqazXird4BvItpfhyDyrrwi6pM6oIy86aN9pFc4XH6
 muNSZWrFpwf04URPhLUSTkEDanxSdeVoxGLkc3u28cgHRogN7JLeglXpjUFhMtogTGJ66/60J
 URcH6pOijUMPU+Y5LtYcICjLfRhBbCOilFo4izqPini8jWXUnToKORnXMniycb2qfLrmuKxCJ
 l9iWcp/rSdUi0zGq9r/fhdiG5qzSelJe9KRM35zq2/SpJHe67nGsmqkeeSg66BRufb4qh5Pqh
 Y/d35lpyriJemowY4vxURajtSf2toNgT0yB5z2s6zMtXe9fcZ/90exWeWAEQ2gWrrz1kTSEHP
 m18e/+u6iiFSN4UpL5RyhMcj1CESGBlTGF0BhqWmJsFDifl/CvJr5JDsRHNdoNKGa3DQdVx7/
 KAXH3xTQhmtvXvR/PoL59l2ozqoRzyZcAEU5BZrTNpg3gr9NUyrC0daeYmANOxSWT5QjwvE+Q
 zYWEJHixBt0hgPt8RX/mphztrnoSFv564e4pL+HJ/UC6waSfltjb2AvhBD3IgAVSm6yMxqmTI
 5Sy6JYR1K6ToJ+vv6BCTws8qaOdKGhaJZv44pLrk+GBVwmB5kFA71o2z7bai9aB5JRE17d+ko
 lNHDuWUD3JOWetcyuyIlmkGgT6k1YLy0w2MwE7iGBKhbcaiBpspSzjf2VODDiTGX47/7VR7AI
 Hy/FMTfeSzUZWXxyCAbQ/5oBuqG/qd2nSSA8AbduK5qBdTxNrTJqRFePJuMupNQqcGlXZ9cdA
 f6FwgQ==
Subject: [cocci] [PATCH 4/4] fbdev: imsttfb: Improve a size determination in
 imsttfb_probe()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1151
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-05/b924f0b9-c769-3f9d-6242-c478408663fd%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 23 May 2023 18:50:53 +0200

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/video/fbdev/imsttfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/imsttfb.c b/drivers/video/fbdev/imsttfb.c
index 90c72428e8d7..346e0166c711 100644
=2D-- a/drivers/video/fbdev/imsttfb.c
+++ b/drivers/video/fbdev/imsttfb.c
@@ -1491,7 +1491,7 @@ static int imsttfb_probe(struct pci_dev *pdev, const=
 struct pci_device_id *ent)
 	else if (IS_ENABLED(CONFIG_OF))
 		printk(KERN_ERR "imsttfb: no OF node for pci device\n");

-	info =3D framebuffer_alloc(sizeof(struct imstt_par), &pdev->dev);
+	info =3D framebuffer_alloc(sizeof(*par), &pdev->dev);
 	if (!info)
 		return -ENOMEM;

=2D-
2.40.1

