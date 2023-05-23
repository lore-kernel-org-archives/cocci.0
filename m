Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD01C7EE2E
	for <cocci@archiver.kernel.org>; Tue, 23 May 2023 17:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Yh5Jp4G9BUp+K0Npbuk0/du3Tzu1q5HtxUDgxbZu8HY=;
  b=Rvj/YcTbcDfWkQX0iyNNlF+DMLMN67iFORdDChcjEGyZpNN3zx7HXTjB
   eixBCcyX6Q0Y+s/wNOgcdXayhe0FQSlKGuctAb3B7fMdDESCUDehYXnKG
   I1ZdNv4ZMXqIEqmald7Pqf29UfUhQ6EC73vNAAWDiesLLOlA4HpvTovuN
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
X-IronPort-AV: E=Sophos;i="6.00,187,1681164000"; 
   d="scan'208";a="109304680"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 May 2023 19:40:29 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 68B91E0298; Tue, 23 May 2023 19:40:29 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id AA0EBE00A8
	for <cocci@sympa.inria.fr>; Tue, 23 May 2023 19:40:25 +0200 (CEST)
IronPort-SDR: 646cfa87_UgJQXLUgiB4tRQh5/jrZ9Mo6FY1PIf/rr7EgWa+bcF8FC7d
 woqAr6efD7yCD+jEVbVuUfjDTGK4/eVxb3XIR5w==
X-IPAS-Result: =?us-ascii?q?A0EoAACe+WxkhwQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYIudQNTMAQLRoRSiB2GdoIkA4Qzl16BVoFAPg8BAwENOwYBAgQBA?=
 =?us-ascii?q?QMEOIRHAoVbAh0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEB?=
 =?us-ascii?q?QECEAEBASMXBw4QJ4VoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QESAg06PwMDIwQZAQERJgEPHwEFAiYCAlcGAQwGAgEBgnoBgicBAzEHDK00f?=
 =?us-ascii?q?zOBAYIIAQEGgmWZKB8sIlWBXgMGgRUtAY0sgzd6Jw+BVUSBPIEVgi2IH4Jnj?=
 =?us-ascii?q?y2DEolzgTBygSOBKIECAgkCEWeBDghmgXNAAg1kCwtsgTtaQ4FpAgIRQgwVB?=
 =?us-ascii?q?VgCgQQQARMDBwQCgQ4QMQcENwshBgkdNS0GXQcvJAkTFVMHhCsDCgoTJQQOA?=
 =?us-ascii?q?xkrHUACAQs7Oj01BgMLHwYmHwKCAwSBCXsGASQknSIDgn0BKVETFBhGCoF6k?=
 =?us-ascii?q?m6DEq1yNQeCLoFagV0MihCVBgYTL5cRDgaSKi6XWyCLSYFxmlaBYzqBXDMaJ?=
 =?us-ascii?q?IM2TwMZD44gGYQNhGGKKAE+PzQ7AgcBCgEBAwmFRgEBhX4BAQ?=
IronPort-PHdr: A9a23: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
 wpoOWWdL1q0p6RtfyZnhV2E0aY=
IronPort-Data: A9a23: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
 RHyN0Ac5iSM/6w=
IronPort-HdrOrdr: A9a23:CahpeaokPVDV8cRGPwFWRL8aV5rdeYIsimQD101hICG9Evbyqy
 ncppUmPHjP+U0ssRAb6LS90ca7LE80maQFgrX5Xo3PYOCFggGVxVFZnO7fKlTbckXDH4hmu5
 uIGJIOauEYY2IbsS+32maFOudl+8Of+KSkwc/V0ndqSmhRGtldxjY8MRyDGkl6ADFbCYY0UL
 qQj/A3wAaISDAtdN2yAnRAZeTZuNHR/aiWGCIuNloc8QGLgHeS5KTnFgXw5GZ5bw9y
X-Talos-CUID: =?us-ascii?q?9a23=3AKAAM6mtzZ83E4lGXVIS8CAve6IslcT793VXrZHb?=
 =?us-ascii?q?oJkRgF6SyVw624oprxp8=3D?=
X-Talos-MUID: 9a23:hXvcrgkWxt0+QwrOn1X3dnp4LoRrz/SrOnkJjNJaos6CcjZMPi6C2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,187,1681164000"; 
   d="scan'208";a="109304676"
X-MGA-submission: =?us-ascii?q?MDG6GWlu/0OPIIFgnjYua6McOZ9m/4SvB5WQav?=
 =?us-ascii?q?r/PZIa8PsASQWCrUViTOU3K+E8AMff5JDOT40HfqAqUZRx9+1iVs5C+g?=
 =?us-ascii?q?zRWSXz0aQbmWYp9TimaJsRNGXGZBK8IZF97W2fB6Kx306B6vGRGIFfcW?=
 =?us-ascii?q?VODd/X3XpWg56wthYCHjd/qQ=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 19:40:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1684863617; i=markus.elfring@web.de;
	bh=dZAZTWocFmwMeI41tgq/9qsNmxwFlyNoBkJGWPDlc2o=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=TKbqjsJmtPL45O1znHWMPToDR9bFUNTuQ1s2jsH61QLvye+vZgklvo5BvFp3pDddX
	 paugPZdaO0U1i6F8MHtlRyecNYCKHIYfktwHj5a6+yGnU1bQBKRSKxpdaJNTc2BCBN
	 yv6jz4WpqYakQJRm/VUIjH7Tfp16+/qNbcO1OtfV82jZZ08CXm5uPFYdinYIAzGegN
	 ipPGRUvxJuNnVQdV28rPRMLA+9BmYMR7xJCAQ26WyCoQfTBcw9vmuZhWptMroO/Wmo
	 pfw2Fye41Wp9nBCrRVAC6OAkeMgLtux28OobwOEywkdWJGLK80EwzfrIfnpNZJ0o1s
	 pwtsbGLti5TPA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M3m9H-1q2L4c0WV1-000rbV; Tue, 23
 May 2023 19:40:17 +0200
Message-ID: <e98a620b-7b3b-0d5c-3bc8-4cbbda1dd057@web.de>
Date: Tue, 23 May 2023 19:40:16 +0200
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
X-Provags-ID: V03:K1:QEbEaGKrHnj4+xdRAtEbFhnE4hMSAqjN7cMcZwRbJ8dJbVU/4d4
 ByOLqxblchi7JQSn8cPTXzH1zV8mA1mHfFoABa2g4g0eLCs2CLSreMzfCw7vZkt6F5EFgnd
 V+X0cTAjciIjUK47hK5j1bGelm2QKEWqdzdu7ORuj8D7WqFl1YnDpqkYwEAyy3e8m09hyse
 qpU60cSjf3UyOFC/pZfCA==
UI-OutboundReport: notjunk:1;M01:P0:ZNlXuM4RdCo=;W5fkWHl/pqYc20ijGSe8Hf1TdNL
 tB9uZ85T5H28Hm/ceg0bsGRqO83ivcj4UULZUZxIN6X6VbiTLCnYrlNig0CqIRKFjqhAE6qo/
 Wx7JUlGABKw0CWIfHKisjWwwaGO/bVBuuJWL/ojKnrHdTqTL3zeivSziYeJKs2YppjqdLSbT2
 v1cGTSIBIO034RbsrQEzMu37d+Bh/BPpac+zRUdVH6uLNottNBvMLwBRBthpEVJGTlYbaTL4/
 wCGbiSw+Jm//J3N+wSJD+crp9kmgzeF5EHZ548/woy7w3/uD+TsSGOd9m1OMt9wHaHW4BNClj
 Z2vG5GM/trXPEOsiJmOY2bR9bVKCo0Vf5uzjaqE/BGnlyYBjb2tMa8ylcJG5mLfN4f7eX39t9
 5oqOcZTezhuNdaIMdwiMzRwqCbnw971PjDUMdyUTKSjKfj8bzBUUO02vmmWHEkcV05afvYfmh
 hl7+YX8PSxD+oAqCyjDqpPUqFS9444/hpqANO+B/bAfFbDZeCQLxZXFJHhIifniHgKpC3aAWJ
 4MjLfQPdAY+xzwGhl0IYx+G8YkzEAYvSQBRd2ajBFT18a4jGjNvFgFGSlX/YBT8ssfPMvhk3g
 ZtCUpVzQObmagl38+4dn664MGl8f2LUr7kS6k6u9bfYvvK1ad8n4it2d+D8tMJzSX2uTp50g8
 v3s4b/wvNmK7KLXncufqAEc8Jh4HFAeZsrMOa5PfdklabzFEGNJS9aqokWQtHYUycHrzxyKZV
 hasFFneuaGn+/h537NX2eZXOF6nUWrF/iIRup9GawY8zpDz7GTxOQbhEPPBQNoMO+Wn2F7DyC
 RWx3VrBBLF9Qs7nvgOQFnWTePXvzMi9efKpdhW+cV7uf9NXbJmgr+h0VYZJoaSsMiywTy8mpu
 WtqpT1gqtYkgCIgunVxzsuGmCRvmijPs5xT19AqWK7PVPtO3ycO2EaUXR4FgqAfoUFZuyT1GB
 o1QPSw==
Subject: [cocci] [PATCH 2/4] fbdev: imsttfb: Fix exception handling in
 imsttfb_probe()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1149
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-05/e98a620b-7b3b-0d5c-3bc8-4cbbda1dd057%40web.de>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 23 May 2023 15:40:43 +0200

The exception handling was incomplete.

The label =E2=80=9Cerror=E2=80=9D was used to jump to another pointer chec=
k despite of
the detail in the implementation of the function =E2=80=9Cimsttfb_probe=E2=
=80=9D
that it was determined already that the corresponding variable
contained a null pointer.

* Thus use more appropriate labels instead.

* Delete two redundant checks.


Reported-by: "Michal Koutn=C3=BD" <mkoutny@suse.com>
Link: https://lore.kernel.org/dri-devel/34gbv2k3lc5dl4nbivslizfuor6qc34j63=
idiiuc35qkk3iohs@7bshmqu2ue7a/
Fixes: c75f5a550610 ("fbdev: imsttfb: Fix use after free bug in imsttfb_pr=
obe")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/video/fbdev/imsttfb.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/video/fbdev/imsttfb.c b/drivers/video/fbdev/imsttfb.c
index d3532def4707..6490f544f8eb 100644
=2D-- a/drivers/video/fbdev/imsttfb.c
+++ b/drivers/video/fbdev/imsttfb.c
@@ -1503,8 +1503,8 @@ static int imsttfb_probe(struct pci_dev *pdev, const=
 struct pci_device_id *ent)

 	if (!request_mem_region(addr, size, "imsttfb")) {
 		printk(KERN_ERR "imsttfb: Can't reserve memory region\n");
-		framebuffer_release(info);
-		return -ENODEV;
+		ret =3D -ENODEV;
+		goto release_framebuffer;
 	}

 	switch (pdev->device) {
@@ -1521,34 +1521,42 @@ static int imsttfb_probe(struct pci_dev *pdev, con=
st struct pci_device_id *ent)
 			printk(KERN_INFO "imsttfb: Device 0x%x unknown, "
 					 "contact maintainer.\n", pdev->device);
 			ret =3D -ENODEV;
-			goto error;
+			goto release_region;
 	}

 	info->fix.smem_start =3D addr;
 	info->screen_base =3D (__u8 *)ioremap(addr, par->ramdac =3D=3D IBM ?
 					    0x400000 : 0x800000);
 	if (!info->screen_base)
-		goto error;
+		goto release_region;
+
 	info->fix.mmio_start =3D addr + 0x800000;
 	par->dc_regs =3D ioremap(addr + 0x800000, 0x1000);
 	if (!par->dc_regs)
-		goto error;
+		goto unmap_io_screen_base;
+
 	par->cmap_regs_phys =3D addr + 0x840000;
 	par->cmap_regs =3D (__u8 *)ioremap(addr + 0x840000, 0x1000);
 	if (!par->cmap_regs)
-		goto error;
+		goto unmap_io_dc_regs;
+
 	info->pseudo_palette =3D par->palette;
 	ret =3D init_imstt(info);
-	if (!ret)
-		pci_set_drvdata(pdev, info);
+	if (ret)
+		goto unmap_io_cmap_regs;
+
+	pci_set_drvdata(pdev, info);
 	return ret;

-error:
-	if (par->dc_regs)
-		iounmap(par->dc_regs);
-	if (info->screen_base)
-		iounmap(info->screen_base);
+unmap_io_cmap_regs:
+	iounmap(par->cmap_regs);
+unmap_io_dc_regs:
+	iounmap(par->dc_regs);
+unmap_io_screen_base:
+	iounmap(info->screen_base);
+release_region:
 	release_mem_region(addr, size);
+release_framebuffer:
 	framebuffer_release(info);
 	return ret;
 }
=2D-
2.40.1

