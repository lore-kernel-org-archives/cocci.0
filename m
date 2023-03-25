Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB1E0C6FD1F
	for <cocci@archiver.kernel.org>; Sat, 25 Mar 2023 15:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=RX2+oyGuNkt824H4mglVPvpRiElvtWll8B9I4iN4qhc=;
  b=nFsoGkLJwtw0RniDbwxWQgr8RRItT6GGyiY7wteEc5iXRT1e8xUPQ+jY
   4T6yNPL7dwN8303XmSty1xIkKW4kS1lCk1kacI6IDkCqET32x8VweADO+
   Ty/jSbkNne6W+YJp7zes7FZItRNsgBU9LH7rVgC0h2vDJ+eavGPFtU35f
   s=;
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
   d="scan'208";a="99074041"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2023 16:38:40 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 04D9BE0D45; Sat, 25 Mar 2023 16:38:40 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9B93BE0D40
	for <cocci@sympa.inria.fr>; Sat, 25 Mar 2023 16:38:34 +0100 (CET)
IronPort-SDR: 641f157c_sDkn9/2rF6DYwyshJokfkt7Gn7F1bm46eQjD/cMxfjrCPcU
 WPBVEG3hVzrw2g808MGZwjKBurELqCuUXEOab1g==
X-IPAS-Result: =?us-ascii?q?A0GYAAB3FB9khwQP49RaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YItgUsvBAtGhFOIH4hiLgOEL4csjCGEAoFWgUA+DwEDAQ1BAQIEAQEDBDiBU?=
 =?us-ascii?q?4JzAoU6Ah0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAEBA?=
 =?us-ascii?q?hABAQEaCRcHDhAFIoVoDQiCLykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBEgJHUz0DAyMEGQEBESYBDx8GAiYCAlcGAQwGAgEBgnqCKAEDMQexJX8zg?=
 =?us-ascii?q?QGCCAEBBoJjmScfLCJTgV4JgRQtAY0EgzZ6Jw+BVUSBFAEnDIM1iByCZ4Ioh?=
 =?us-ascii?q?1aHJYgvCoE0dYEgDoE9gQQCCQIRa4ESCGuBfUACDWQLDm+BSgJkTIEeJQQOA?=
 =?us-ascii?q?xkrHUACAQs7Oj81BgMLIAZYawIJIxETBQMLFSpHBAg5Bhw0EQIIDxIPLEQOQ?=
 =?us-ascii?q?jc0EwZcASkLDhEDUIFHBIEKgQEGASYkmnECAYJnAVI7TCaBN0ANklgRki+eD?=
 =?us-ascii?q?jQHgiiBVYFZDJ8MBhMulwgOBpIjLoctkA8gp3qBYzqBXDMaJIM2TwMZD44gD?=
 =?us-ascii?q?A0JFYNujwkBPUA0OwIHAQoBAQMJhUYBAYV7AQE?=
IronPort-PHdr: A9a23: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
 B49XAo=
IronPort-Data: A9a23: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
 e0jx0A=
IronPort-HdrOrdr: A9a23:kGX02qM8URiNT8BcThWjsMiBIKoaSvp037Dk7TEUdfUnSL36qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFg7X5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YGT0EUMr3N5DZB/KPHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="99074034"
X-MGA-submission: =?us-ascii?q?MDFN6FtJiLcK1Q7NZpA97qXLuobbRc33WnPbKu?=
 =?us-ascii?q?9LOnf0CFOIWbVrfv5d67zSz471QPJ5KxGB47r3Yz5TP2u34AYbr46LIf?=
 =?us-ascii?q?mqQyf5wz+rq7n2sfd8rVN1ON+HzT6TQO5vjsMhUbRFYmcBJxfZY2oayk?=
 =?us-ascii?q?vLSTG18MOEPOpGkph8EgWC3A=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 16:38:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679758709; i=markus.elfring@web.de;
	bh=kGVqaXqBe7nnB6KlTFMTxkDCEKhsqhrzx/0lrJqo6FI=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=SRkAEFE19ino1XyXXmRbFkJd+p2BVpGiAQDlVJMWn6YCUyUppESqUqk8Puh5Uqip7
	 FZyaYzKDw2Kbr5fKohkNdt1E0ipSJCLrJUHnSD0OBbi3GjDVdpryuhvfxshp3g/gmQ
	 okSwb2rEfs2BSsFu1IMigfBhdlM9pBMHQNa9mFS/cuAzXPCm+43gnMZJhIaxKYqTds
	 HgHDv809BlwZntZU5eUlBfdErUsqhJoMCpcT+tTsxf2JGcFVcL7L9WpOnT5ZdvBCUR
	 1hvjyQ6zNn5ZwRYoYmyNDUt6/dqmNZc/B2GNG/VUPG1tDzhqJnSZeyzA1Etxrt8mir
	 n3EyHdEyRCXEg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MlLA1-1qKh2n3gL7-00lkOz; Sat, 25
 Mar 2023 16:38:28 +0100
Message-ID: <d4e1fd7e-7c14-b89f-9018-2f215ddb7cdd@web.de>
Date: Sat, 25 Mar 2023 16:38:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Josh Boyer <jwboyer@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Stefan Roese <sr@denx.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <72a7bfe2-6051-01b0-6c51-a0f8cc0c93a5@web.de>
 <ecda8227-d89a-9c23-06b7-54f9d974af5e@web.de>
In-Reply-To: <ecda8227-d89a-9c23-06b7-54f9d974af5e@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FuJ2T36n5Mx4iRJoOQfcaoWMbaE4fTlrFjbB20unG49TrSc4NTj
 MyyEsvXkQd+8j61oHeKywsK4x5Azcp4yy4kHRqW6zCMkIEahYUDyl6L9DfQLroc01dtCFDu
 31gpx8yHcyvBiZvQGKYRYdE8axSYc0WmsJknlnEVe5h34r5noNW6RG9Ej3EDIviFJL8McAF
 A3fy68t+6C0nXFfyEcydQ==
UI-OutboundReport: notjunk:1;M01:P0:fQblvlT0JS0=;yWi4bUsU6M0XMS6VtTspfVUjaMc
 q88oQs5i0Fowjyrdti5bBCLDAq2chg890SUXADWXlC8awrHONHCVDmrvEaWa7jumAZ61C+96M
 E57CO6eBCSgqdzZ64Ta/BDE8bCcan4D3Ir2Gnseq+vgY+SSWNPioryv8iiF41ZvZeNXIIubEz
 BcJfNs81JuIMsfAwuTYmOeOMTQPZF4ixz0f1Cbw0Nm8+hPushz/Bl0OdZsW5e5Gh0NcInZn42
 vu+agrZP447/L0E4+JddDooGq2UGPIqjXSnH7jRtCNUAn/hTwbF9GOyi+JRElktr/vdryGZeI
 6DfJ8suB96yC0ynIfWdWdsSkPn9Ephoyb+6BMvOQZi4Dtu9ehDpGgDegP9XtnhUPuMRZaNwAE
 99XBDBJyCo2sGm6iSKrCFqYK7UINNVzRtTGrmvFyCKSb+gVxkv13Axn4EYYNv0iOjKsOmQzQP
 6/n3GLACj209qm8X8eF8XCtZZuWq+o4XeiE5mQnWbVxcIPpTZtAha3w/NH5Sm6KXaHKQyxe/m
 7DKNUYaEwZsjB2zkTl98fojambJxjaqGJ1ijUjKeP32T4/40hRj6Jw+jQqk3Fsl1rC5dKCFen
 MEs+NvGP+RS//tsLQqxi95i+GViECllDf3HuC2OFpP40p+vO0IqkmSty5GlQXMn4BU8AV14UE
 fr0kP8zYcKCPg9hebjm9YpdJPY49YJOGPKjkKjehztogW/zDF7aLus9x3vshWihdhwb5vnEXb
 xj/oL+3QSCGuo1HjLFdnVioZ8wwBc/09F2HIK4V4Uaop04dIiNvgz14P7NV7hW16sG/lQyX07
 9CrwaFxTJiWAeGil+s9+DrSFP/cZnnU18HMWq93h8afC95aHjJWt9KG+HbItMLB3LyzisXL9g
 viPGNQ5SnWnRiLxVMZJC1hZM2+5I37IVVT4Mg8y4U/RNYhtkT8HpdJXGt
Subject: [cocci] [PATCH v2 2/4] powerpc/4xx: Fix exception handling in
 ppc4xx_probe_pcix_bridge()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 954
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/d4e1fd7e-7c14-b89f-9018-2f215ddb7cdd%40web.de>

Date: Thu, 16 Mar 2023 19:09:33 +0100

The label =E2=80=9Cfail=E2=80=9D was used to jump to another pointer check=
 despite of
the detail in the implementation of the function =E2=80=9Cppc4xx_probe_pci=
x_bridge=E2=80=9D
that it was determined already that the corresponding variable contained
a null pointer (because of a failed function call in two cases).

1. Thus return directly after a call of the function =E2=80=9Cioremap=E2=
=80=9D failed.

2. Use a more appropriate label instead.

3. Delete two questionable checks.

4. Adjust the exception handling for another if branch a bit more.

5. Remove a return statement at the end.


This issue was detected by using the Coccinelle software.

Fixes: 5738ec6d00b7abbcd4cd342af83fd18d192b0979 ("[POWERPC] 4xx: PLB to PC=
I-X support")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 arch/powerpc/platforms/4xx/pci.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/4xx/pci.c b/arch/powerpc/platforms/4xx=
/pci.c
index 7336c7039b10..fdf13e12ca9d 100644
=2D-- a/arch/powerpc/platforms/4xx/pci.c
+++ b/arch/powerpc/platforms/4xx/pci.c
@@ -564,13 +564,13 @@ static void __init ppc4xx_probe_pcix_bridge(struct d=
evice_node *np)
 	reg =3D ioremap(rsrc_reg.start, resource_size(&rsrc_reg));
 	if (reg =3D=3D NULL) {
 		printk(KERN_ERR "%pOF: Can't map registers !", np);
-		goto fail;
+		return;
 	}

 	/* Allocate the host controller data structure */
 	hose =3D pcibios_alloc_controller(np);
 	if (!hose)
-		goto fail;
+		goto unmap_io;

 	hose->first_busno =3D bus_range ? bus_range[0] : 0x0;
 	hose->last_busno =3D bus_range ? bus_range[1] : 0xff;
@@ -595,8 +595,10 @@ static void __init ppc4xx_probe_pcix_bridge(struct de=
vice_node *np)
 	pci_process_bridge_OF_ranges(hose, np, primary);

 	/* Parse inbound mapping resources */
-	if (ppc4xx_parse_dma_ranges(hose, reg, &dma_window) !=3D 0)
-		goto fail;
+	if (ppc4xx_parse_dma_ranges(hose, reg, &dma_window)) {
+		pcibios_free_controller(hose);
+		goto unmap_io;
+	}

 	/* Configure outbound ranges POMs */
 	ppc4xx_configure_pcix_POMs(hose, reg);
@@ -605,14 +607,8 @@ static void __init ppc4xx_probe_pcix_bridge(struct de=
vice_node *np)
 	ppc4xx_configure_pcix_PIMs(hose, reg, &dma_window, big_pim, msi);

 	/* We don't need the registers anymore */
+unmap_io:
 	iounmap(reg);
-	return;
-
- fail:
-	if (hose)
-		pcibios_free_controller(hose);
-	if (reg)
-		iounmap(reg);
 }

 #ifdef CONFIG_PPC4xx_PCI_EXPRESS
=2D-
2.40.0

