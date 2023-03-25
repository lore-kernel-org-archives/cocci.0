Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50183C6FD1F
	for <cocci@archiver.kernel.org>; Sat, 25 Mar 2023 15:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=1esgu3V/WL3sGIpxl5CmZdNQ6r6mqJEREO1tznCsZzA=;
  b=cteDyjieCSJcBgFCcibyyuP/BZ1yaUeCB4CDOceZwf2ne0fl/uJ3uyTP
   D2lVkmpL6zo126FPOKS/Pn1hBuDCs/JNUz1Dz2xxz/3Otx8diLGb0dI2y
   mQmE1aQrcWSw9AMcPhQmKO39ddt4Wk/VKZSHZoSECnPZ6nlN5i+kBSbFM
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
   d="scan'208";a="99074276"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2023 16:40:58 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B86CBE0D45; Sat, 25 Mar 2023 16:40:57 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 2D0DCE0D40
	for <cocci@sympa.inria.fr>; Sat, 25 Mar 2023 16:40:56 +0100 (CET)
IronPort-SDR: 641f1609_qXGChc3234WUVAmjSHj9/UfgLGJR+CV2HZfyBLM3cLg5nWQ
 OFHr8sDERL5KL9rh+eWJriC8zarDZ602q3ESs0A==
X-IPAS-Result: =?us-ascii?q?A0FoAACiFR9khw4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYItgUsvBAtGhFOIH4hiLgOEL4csjCGEAoFWgUA+DwEDAQ1BAQIEA?=
 =?us-ascii?q?QEDBDiBU4JzAoU6Ah0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBA?=
 =?us-ascii?q?QIEBAEBAhABAQEaCRcHDhAFIoVoDQiCLykBEWSBCAEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBEgJHUz0DAyMEGQEBESYBDx8GAiYCAlcGAQwGAgEBgnqCKAEDM?=
 =?us-ascii?q?QexIX8zgQGCCAEBBoJjmScfLCJTgV4JgRQtAY0EgzZ6Jw+BVUSBFSeDQYgcg?=
 =?us-ascii?q?meCKIdWhyWILwqBNHWBIA6BPYEEAgkCEWuBEghrgX1AAg1kCw5vgUoCZEyBH?=
 =?us-ascii?q?iUEDgMZKx1AAgELOzo/NQYDCyAGWGsCCSMREwUDCxUqRwQIOQYcNBECCA8SD?=
 =?us-ascii?q?yxEDkI3NBMGXAEpCw4RA1CBRwSBCoEBBgEmJJpxAgGCZwFSO0wmgTdADZJYE?=
 =?us-ascii?q?ZIvng40B4IogVWBWQyfDAYTLpcIDgaSIy6HLZAPIKd6gWM6gVwzGiSDNk8DG?=
 =?us-ascii?q?Q+OIAwNCYQDjwkBPUA0OwIHAQoBAQMJhUYBAYV7AQE?=
IronPort-PHdr: A9a23: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
 VNpPnHISuAJ54Y=
IronPort-Data: A9a23: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
 T3Tx5EoAiWM/w==
IronPort-HdrOrdr: A9a23:QrGhealJ8MKOQ8xx+iDITaluQtzpDfL43DAbv31ZSRFFG/FwWf
 re+MjzpiWE6wr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQmVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6voSizPZLz9P+qjjzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="99074272"
X-MGA-submission: =?us-ascii?q?MDF7IKtIfl3eRV7f+Bb6j+dcFopZRJsAqrUwcL?=
 =?us-ascii?q?qLP6MOwRk3dQeluu5Js8VVuh/eO8KrOfR7YbfmRArNLem/Z/fPS7R6NI?=
 =?us-ascii?q?mLaoCCkxUNKATvgaPXrusMByPj0Sqq8H5oO/IOH3n4U+VJq8bThlMc5I?=
 =?us-ascii?q?78DXy31k8KR9ye7HpFy1p7tQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 16:40:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679758850; i=markus.elfring@web.de;
	bh=vxJeVMuug3pta5u7U+BXQXjVk22xErBl9rDMN3Qsnmg=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=IbqTVxsDWkQtAsS5xiPwW2cSwzjbjC+b9AaNL/knLSQD7NtJAT2aayvuSSKNzy5hW
	 Rwdqv6E/v+ZD8e7KojBkN2y++qfOiQQVxvcEX8QbEBEo/tVzRy/kEj6irS8oOwXCfS
	 XlweOe0XVWvIRgidhN5bxu7CkoqJokia8WSgYgWqEKm23SzyQNTk6jnmENg5+xCRJ3
	 s2mNvMn2/NUngk6fkrNNpnKGMvWNq3gSkz+2hXSm4JfptlAn1r5sioGbS5Vc3WvGRe
	 Okf6NQ49Dh+9GivyJ/D2936uOMizFdQOnmaa5D8PJoGImDzAXTtA1UCwkWidE9XSgX
	 jPlywfFeWCe3g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MPKB7-1ppmH91gRp-00PfCE; Sat, 25
 Mar 2023 16:40:50 +0100
Message-ID: <5b217de0-398c-c3d5-1c9b-07517ae610c9@web.de>
Date: Sat, 25 Mar 2023 16:40:49 +0100
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
X-Provags-ID: V03:K1:CB+IOdGg3hyFDo0PPlZl0Eb3klmpd1neqi1rUBroa/iLvc9FReg
 tULI/hUKDULarYls56l7VAI/xZ/y5x78LVpZl3NxX0UD/M3+xdJTT34UjK/YbqKvQXmTvyU
 S/Eko7uAlZvNQs+KnbOAOKKAN2OQiL37eF3zfrhWmBPeCoaeuWzX96YlWlHMdqI/TeRbaYi
 cgby7EIrzPc4Go6FyiWOQ==
UI-OutboundReport: notjunk:1;M01:P0:rrRdGlGaDII=;ROurm/cF+sUxkF2qEvPOMK8mRGU
 ntOlOlUjU3a5V+WwkhTicA2Uo4g27L+vTk4Ab1s+ZN1SEVROiR6KHSjgR1mr5mHfpzBDvFWME
 JRsDcuY9y0msTTV+r1jAtQNl79pCXHxWOfHW2QR6j5KQz6QMZ3ZdL/az3rspP5BBhzTraVAGH
 rYwmSOF0Aw6ktB2yU72Tb19CKYNKpFhd56O1bXETVLVae2bwRhoNc9d/VTvGcA391ZB9APVuD
 PHDLamZZtI/i1aar8yYZeWVK+D1fWqPiPImB+wN5JB2KrExCW9rPJ8Vn2QQCX9rMr82QGzne0
 I27lSG2DVA+34iCVapDWqPt+4NlD56w0+n3AZd4duAAqe5P26Uu4NZUeo2eou5buc73Hgc+Jr
 XJEt+ztYA3X3Uwjga7ob9pZNY+mkeTJ90ot8mMPLH6BC24YJXwtRZpEfC6YRyVHbBG8OK5X6u
 cEJqZ1uLJ06HhbFo5Fv8/d88Vmn6llyJLwfdKw9PVin1k6keaRrTJ6Y6SHA5sQMJDVZU2qwIK
 5t6Gosu9QcUalmYM3UYoaWUg+LpkNd3tP2vfGr6hS2igki4ffncJwOpGGeUPgIShq81Yi24zB
 EVUsH3Wy4VvzjFT1qf9k45cAF4nu+ZCMZmilIx0yUOGrBv8VesvYnVYrUX2rWuqOmRe6hl8hL
 xfLMMATud52eZHGz3cT7xiYS8c7C5DdblCcxsVvPP5+lTm9zxXGO5pB49lPm5jjdeJcsGuX/6
 vcicT72QvUJ3AuOBh6bO1zqLus8r+kFokQbwobSoy9iTFfZ8sY4Odm+zeckSH/CCWi9+OnxRw
 t+Qjc2F3mv+8ellCgU+SVTspmRdPVzKI2dOznxj4R8P2QMUile+AZVfZ2BTHNPRMLcl+vIFiX
 5sJkHLjdRrnFkzmnZZFt3Hdtzp0t2roxVCGPozceahOppeZ+YJC/DPv5B
Subject: [cocci] [PATCH v2 3/4] powerpc/4xx: Fix exception handling in
 ppc4xx_probe_pci_bridge()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 955
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/5b217de0-398c-c3d5-1c9b-07517ae610c9%40web.de>

Date: Sat, 25 Mar 2023 15:56:09 +0100

The label =E2=80=9Cfail=E2=80=9D was used to jump to another pointer check=
 despite of
the detail in the implementation of the function =E2=80=9Cppc4xx_probe_pci=
_bridge=E2=80=9D
that it was determined already that the corresponding variable contained
a null pointer (because of a failed function call in two cases).

1. Thus return directly after a call of the function =E2=80=9Cioremap=E2=
=80=9D failed.

2. Use a more appropriate label instead.

3. Delete two questionable checks.

4. Adjust the exception handling for another if branch a bit more.

5. Remove a return statement at the end.


This issue was detected by using the Coccinelle software.

Fixes: c839e0eff500af03de65e560c2e21c3831586e6e ("[POWERPC] 4xx: PLB to PC=
I 2.x support")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
V3:
A closing parenthesis (which was overlooked somehow) was preserved
for an if statement.

 arch/powerpc/platforms/4xx/pci.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/4xx/pci.c b/arch/powerpc/platforms/4xx=
/pci.c
index fdf13e12ca9d..46ba0a4e5b04 100644
=2D-- a/arch/powerpc/platforms/4xx/pci.c
+++ b/arch/powerpc/platforms/4xx/pci.c
@@ -358,13 +358,13 @@ static void __init ppc4xx_probe_pci_bridge(struct de=
vice_node *np)
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
@@ -383,8 +383,10 @@ static void __init ppc4xx_probe_pci_bridge(struct dev=
ice_node *np)
 	pci_process_bridge_OF_ranges(hose, np, primary);

 	/* Parse inbound mapping resources */
-	if (ppc4xx_parse_dma_ranges(hose, reg, &dma_window) !=3D 0)
-		goto fail;
+	if (ppc4xx_parse_dma_ranges(hose, reg, &dma_window)) {
+		pcibios_free_controller(hose);
+		goto unmap_io;
+	}

 	/* Configure outbound ranges POMs */
 	ppc4xx_configure_pci_PMMs(hose, reg);
@@ -393,14 +395,8 @@ static void __init ppc4xx_probe_pci_bridge(struct dev=
ice_node *np)
 	ppc4xx_configure_pci_PTMs(hose, reg, &dma_window);

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

 /*
=2D-
2.40.0

