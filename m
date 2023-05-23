Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B39C7EE23
	for <cocci@archiver.kernel.org>; Tue, 23 May 2023 17:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=c/jtrBYHfqbMum5nydTOPBWwVlORrAgYbwejEexfXgc=;
  b=VNp2Km//wlQItyYLAqvmYdPhrxdRIWSzPmx41zzOwK1f1kVgE62TzbNY
   ith+x4eN2L860m3dTglpDZEGgBueUJ4J5S7kkqSNd5/dJWTtJgph1o5vn
   VIgzMAC8q4X8JdAuLzsypB5Ex8vrWpVQJbFTkB2X50V6KmWOvCSAovv0u
   0=;
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
   d="scan'208";a="109304842"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 May 2023 19:42:40 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6F1CEE033A; Tue, 23 May 2023 19:42:40 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 02BB1E00A8
	for <cocci@sympa.inria.fr>; Tue, 23 May 2023 19:42:38 +0200 (CEST)
IronPort-SDR: 646cfb07_p5HWg9gBU1A/Qwmw0w2JeX+LjzWO/snJtESGyRYnBBlViny
 H2+XHeoSgFmyrn6jpAucpPFDnag4g9qRTYXMFfQ==
X-IPAS-Result: =?us-ascii?q?A0EpAACZ+mxkhw4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYIueFMwBAtGhFKIHYZ2gieEM4cwh0SIaoFWgUA+DwEDAQ1BAQIEA?=
 =?us-ascii?q?QEDBDiERwKFWwIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECB?=
 =?us-ascii?q?AUBAhABAQEjFwcOECeFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBEgJHPwMDIwQZAQERJgEPHwEFAiYCAlcGAQwGAgEBgnqCKAEDMQetRX8zg?=
 =?us-ascii?q?QGCCAEBBoJlmSgfLCJVgV4JgRUtAY0sgzd6Jw+BVUSBPIEVgT5vhAuEFIJni?=
 =?us-ascii?q?VGFXIMSiXOBMHKBI4EogQICCQIRZ4EOCGaBc0ACDWQLC2yBO1pDgWkCAhFCD?=
 =?us-ascii?q?BUFWAKBBBABEwMHBAKBDhAxBwQ3CyEGCR01LQZdBy8kCRMVUweEKwMKChMlB?=
 =?us-ascii?q?A4DGSsdQAIBCzs6PTUGAwsfBiYfAoIDBIEJewYBJCSgInsTgnaWAJlglBI1B?=
 =?us-ascii?q?4IugVqBXQyfFgYTL5cRDgaSKi6XWyCoEIFjOoFcMxokgzZPAxkPjiAZHoNvj?=
 =?us-ascii?q?wkBPj80OwIHAQoBAQMJhUYBAYMkgloBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 z3TFr0c8yVdGq1UeNs=
IronPort-HdrOrdr: A9a23:PmOb8q8hHfCfU10aSm5uk+AMI+orL9Y04lQ7vn2ZhyYlFvBw5P
 re/8jzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNWftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIOb+EYZmIbsS+V2njcL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: =?us-ascii?q?9a23=3AAbqOtWk47JdOkAOVMMqXHYjGvwPXOUD41EzBPxT?=
 =?us-ascii?q?mMnlwSeCnS3XTyJhWqsU7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A9AT1WA72xdnbW9mVuvKA7YDLxowr2IT+MWtKzql?=
 =?us-ascii?q?bhNmVKRB8AxiZkDmoF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,187,1681164000"; 
   d="scan'208";a="109304835"
X-MGA-submission: =?us-ascii?q?MDFeMXuRIeGBtpx8JwBSWDPQhbq88J+2JithTY?=
 =?us-ascii?q?zflOPDM9w5NqZQntstbkI4snBj2iUBl7M0rlzGoLRNkDzq1wwllpXVPW?=
 =?us-ascii?q?3knLv2wM3ol8RD/IYICEUJfJStyShRj1wxLtv1WH2wHSxTaiCbpXOlpt?=
 =?us-ascii?q?rnXkqccN/1KlZmdaBAs+0uQg=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 19:42:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1684863744; i=markus.elfring@web.de;
	bh=lKBfTptu9Yk0RQSj++IPm6JAi+bwbGuVxyt0o9ceU4k=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=lgZTLp8kl9zRaRvchrcTf3KHvKGb4a400uR4X10G81FxNZVvc8kMFT7gi+zx+oaXS
	 wu+qHUUzkchh1vo3+IW1992v1jvYXzd6ZBs3h99uXoZPncVgvkpc8P3/Ntgi2ITIDz
	 LU6b2y/tWqpdTsxnzFD/OgtN2Q5X9WwejL0oU1yzBpkIhWSHT2kU2y/aZw+6lBjgsB
	 JjFYge+R8Cl193g8RPQbId50ZMMptHHIXYhpF6snf71ItPSsPBZGqNgcdUhk5+bT8e
	 rahZAVr/nZMbsb6ivk5NVTr6pbDorudLc969YFaKEvE/JwrbPbrRuLRyTomGuUB53M
	 tptkR0Jax09Ng==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MWQud-1pe0i31eOJ-00Xctg; Tue, 23
 May 2023 19:42:24 +0200
Message-ID: <38cd2e4b-3df4-6c69-b790-5762d24e2c29@web.de>
Date: Tue, 23 May 2023 19:42:20 +0200
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
X-Provags-ID: V03:K1:cIiD/3rphgcPVqhe67vJf8y6VoJI/n/QR2GFc1c9K5abaHhowmJ
 sppU53ZnhqnqHBkTPjF/q/4Ma9/csQfLzdkPCs/4SbAPjEMIoxSi95YlYv+xy0yUccc00c+
 b7BVJsnZ2AlwU3MSGnPD5w6ySQOZueGp+1Tz/ewlnJuydCQJformWJA1m66VEsM3w2lgm3X
 vnnVCZFZWpIFOfoPxm4QQ==
UI-OutboundReport: notjunk:1;M01:P0:YwI6WV7bh40=;7PZ1ie+t6oU9R9z/HAP67KK71vU
 Hc/pMcNxMuEcHbx1sM9IBfF3GFAlnxjNN3sKX9BKRWrTpwtrnjJxiWj12q33yMP/dZp1YWQGM
 JROTGmn/heJzzh9R3ocYQPJmROQjKPLaYlCT7wapaYOQ/oimg92dZgjhBGqiMUgGDCqxbbbLy
 d14G8D1c7G8+LXmyrsteArat/BV9id5N1UfNt++fGojuIw3phOoftmFSokj3rFXHApFntb7rB
 OdF9Kv/mIUWUtixDhekHM7U+Slhq0MhtOFwnpiSUzfwLTF7CpYqnJLPcmyFhGUZFrdGTcKyyr
 zbVxIuBwOF05eo1x3NRBTRqBkXVcqpukRlB2fEvdDAci376bKNWCoV1t8pOLNIoUtHtLfdN18
 QjiJ6rBvOyGmOvxabivF7TKrUjYce4k3KxSYgjPvVJCYcdo0kmdACvw7YjYxHUbqEnj3FBTwQ
 On3nBolXVJgbc5f9HTyba3xLkaoqPYqvcN5gnGxOfGDT335wKt8XSqx68FRl39emppg960p45
 ElEGl2BE1+7W/JQWnr+2Bn7sslboiPVfR2YGvtsZFykvkD+KSidQA1DLYzBgbMSP9ILX3fNHt
 iY6BnbebQWsBvqhyTI8eKJZB7mG5bdbtwIyrSypQCJu6X4gKZOW8K/fRZJ3XCs3YxLWjVtAI4
 8LTcp6yQ8fZ5JeS6+PDZK/bKR6GAI/pLWUzzWB77nwHCTs8w/WGgGHmkwT3PPiJe7Xa7nGV9k
 VkijTVNOKsMUEzCr3G+R74jgFBJtrrOmeIa247Ck057XjQXQk90HxGEfSPlY5vXpmHCvkhirk
 KZs3L869sKJRGGSpMPfx0URvU31UccZJWMwULbRFospEpqW2OPqb5ewgftqOHKW/eZWQ+AIeQ
 iNQWLZjc5gA5fgHajmAV6xdsKf4hyCe6Dg7emJJpjfoSoW0QPlf2Ai+Otl9ezMyQPy6nooY29
 4j1HOA==
Subject: [cocci] [PATCH 3/4] fbdev: imsttfb: Move a variable assignment for
 an error code in imsttfb_probe()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1150
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-05/38cd2e4b-3df4-6c69-b790-5762d24e2c29%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 23 May 2023 18:30:26 +0200

The value =E2=80=9C-ENOMEM=E2=80=9D was assigned to the variable =E2=80=9C=
ret=E2=80=9D
at the beginning.
Move this statement directly before the first ioremap() call.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/video/fbdev/imsttfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/imsttfb.c b/drivers/video/fbdev/imsttfb.c
index 6490f544f8eb..90c72428e8d7 100644
=2D-- a/drivers/video/fbdev/imsttfb.c
+++ b/drivers/video/fbdev/imsttfb.c
@@ -1484,7 +1484,6 @@ static int imsttfb_probe(struct pci_dev *pdev, const=
 struct pci_device_id *ent)
 	ret =3D aperture_remove_conflicting_pci_devices(pdev, "imsttfb");
 	if (ret)
 		return ret;
-	ret =3D -ENOMEM;

 	dp =3D pci_device_to_OF_node(pdev);
 	if(dp)
@@ -1525,6 +1524,7 @@ static int imsttfb_probe(struct pci_dev *pdev, const=
 struct pci_device_id *ent)
 	}

 	info->fix.smem_start =3D addr;
+	ret =3D -ENOMEM;
 	info->screen_base =3D (__u8 *)ioremap(addr, par->ramdac =3D=3D IBM ?
 					    0x400000 : 0x800000);
 	if (!info->screen_base)
=2D-
2.40.1

