Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28033C6FD1C
	for <cocci@archiver.kernel.org>; Sat, 25 Mar 2023 15:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ySQj8Y13DE/W+Kfiin50bM5TyN6pmnd2sv7tqR+cfHY=;
  b=LS3XU/QF51uY9ZjynnAiwnhQ3WCqpJqALjqVUYy9KG+/g/GVSoTEvbIt
   1hQ8CJVDwwfIanAr9haMm8MQrk6WJqt75773LjxvEvKFL4Cwd2qcs0jHw
   Hj6/R5uuu5pxr0v2XDUBrZLsU0USzCJrqSqP0lW9NUaTWp0FssWV2lJxJ
   A=;
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
   d="scan'208";a="99074360"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2023 16:42:45 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6CAB2E0D46; Sat, 25 Mar 2023 16:42:44 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id F3EE0E0D41
	for <cocci@sympa.inria.fr>; Sat, 25 Mar 2023 16:42:40 +0100 (CET)
IronPort-SDR: 641f1672_XfEEnK1ixk/PAwyQp0kk98kYiY+3q0qbG6uK/n3T241P/Zo
 tXQHqT6O54rOpgC0piFSmXwnhthsVbBkpIJ4Iuw==
X-IPAS-Result: =?us-ascii?q?A0GhCACiFR9khwQP49RaHgEBCxIMQIFEC4IugUsvBAtGh?=
 =?us-ascii?q?FORATGEL4cskCOBVoFAPg8BAwENQQECBAEBAwQ4hEYChToCHQcBBDAJDgECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEAQECEAEBARoJFwcOEAUihWgNC?=
 =?us-ascii?q?IIvKQERZIEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQESAkdTPQMDIx0BAREmA?=
 =?us-ascii?q?Q8fBgImAgJXBgEMBgIBAYJ6gigBAzEHsSGBMoEBgggBAQaCY5knHywiU4FeC?=
 =?us-ascii?q?YEULY0FgzZ6Jw+BVUSBFScMgQmCLIgcgmeZUgqBNHWBIA6BPYEEAgkCEWuBE?=
 =?us-ascii?q?ghrgX1AAg1kCw5vgUoCZEyBHiUEDgMZKx1AAgELOzo/NQYDCyAGWGsCCSMRE?=
 =?us-ascii?q?wUDCxUqRwQIOQYcNBECCA8SDyxEDkI3NBMGXAEpCw4RA1CBRwSBCoEBBgEmJ?=
 =?us-ascii?q?JpxAgGCZ4EOgnbDJjQHgiiBVYFZDJ8MBhMulwgOBpIjki2FPSCneoFjOoFcM?=
 =?us-ascii?q?xokgzZPAxkPjiAMDQkVg26PCQE9QDQ7AgcLAQEDCYVGAQGFewEB?=
IronPort-PHdr: A9a23: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
 xQMCQ==
IronPort-Data: A9a23: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
 D3GxkDNAw==
IronPort-HdrOrdr: A9a23:eezSwKj9qJWXrZVnJYcAF3StAXBQXg4ji2hC6mlwRA09TyVXrb
 HLoB1p726WtN93YgBZpTngAtj4fZq4z/VICOYqUotKMDOW2ldAabsSi7cKoAePJ8SdzIJgPM
 5bGsASNDSzNykcsS+Q2mmF+rgbsby62ZyJwcHD0nxqUQZmUK146RxlYzzrb3GeCDMmOXIjfq
 DsnfavSgDQA0j+5amAbEU4Yw==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="99074358"
X-MGA-submission: =?us-ascii?q?MDFZdUKlE0FJWfXQdgVToRwHK8mvzAzWOv1aFi?=
 =?us-ascii?q?Sr06XUBxH5ouOAtjksLRrJB3RgIw/SdI6HmLEqpEqs+rgaJG+2y4qPYS?=
 =?us-ascii?q?v3xfLt9eHOd+no/0lKIgrm+Clmc+5CytpSNwOFcHo4oKGE9grBXIQtRa?=
 =?us-ascii?q?SFxv/rz/L2hSW+WKZPUg6nEQ=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 16:42:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679758955; i=markus.elfring@web.de;
	bh=EoRziNXExaeEEA1SaFMevNWF4aSIGRCu/s2BvgBaahM=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=fM/nPMwJS7AvoJElbwIW0H0kCO4DdN/lLaveWbJuRh+qaymmU20G5jrRw09QCzLvT
	 FPRvXnmeHgv21IhhKka6aSBRfbLT68i2oh1CdngFRvgcXS1tAPxuVp3GSKQq2a57BU
	 Qv8Jn4bzHf5ECXE7QhVJ6d2vlCr5BJNHT8BwGk1j3jNFaE2bDD05ALA6Z2akSV6yvE
	 nrJTv0B/lMZn5rSYQQNaclLNET2X3GypE98dCdetmDAs1al3q5Kp+7oZJcnSRLh8S+
	 ShkGiuH6m4Xg6sIGm8IRKJSrLEhcVrpzf4E+FnlpDWddOQ5bLruZi10wdv06zprqSK
	 hMHBd597sijuA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M9Zdw-1paZjT1ZAa-005Wwk; Sat, 25
 Mar 2023 16:42:35 +0100
Message-ID: <80830e38-7088-301a-58d7-7e3ec332f765@web.de>
Date: Sat, 25 Mar 2023 16:42:34 +0100
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
X-Provags-ID: V03:K1:XnYB/hZgRJooVzYgr6ZJry5EE5pKliLp8xmZtGZKqmXjJFgX2sN
 UpoQLGvjV6T0hgPS3CmxNhs5slzFs7chA2lAt9Avdn94ChMgIDKtFpRmlgzZBo+uQQ2dq92
 8SqWvPrDRqcXbs+H5Pn7yclkBJg4Jpsp1VyuYsPlbCdb45CL7zDHbSNimDzn6oJUsllxewW
 CoMhoZ+v9AXVD9naZr4Cg==
UI-OutboundReport: notjunk:1;M01:P0:TXstjKGD8nI=;5IhciEE7zgUVH144yHI8O773sfI
 GJs3PWdGfovuMaFyVSAV+nGI3ngGmgmbzLFq+aZAWtxeZGsPFnM7qbOgpU6YfpARZCfbuK8CI
 WZorr1IEi+6imADHlGh7bO2061x3I/E7t1QmrYXjqYXtrnIB6Nt+D8dZffIJCelo5pOyXCZCc
 3HOzt+N44cjwDk2xx6i5jS3UDLuIS1Yoq6pkB019QoKHpmf8lu5R7r2DLDiygSngK8Uf4FDWJ
 T7R+Ytq8Ch5PB667X13gFRLnMD03FheE06HIJFeUNmb2GZjRt5kPmt7E6y6P8S2Rj0RCQYGdb
 es+UXSxA901aA5soMm31w/zkooJQP/jFz6nAv2fmXkKYeHTSNmja6+ftYIHOZ95k/6LCmN3to
 9yaIjymALOtQGF2vsEr1P4v6rCs4ts2sfuSzsFNni6orxXfYfnt4RtDJEgg67W5nTvUG3WRA7
 BzNGz9b7VBqMMqVwuVkGfitW2MgazYHRm0oU1FyD5TuXST3WSH7zIEaKsj0mT2SsMrU6HIqwM
 HDJqDAU3qcofmR41xM6sdnmDytxKZYigTk0KFklwvg8tA04zE71UIIwDB5AeEH78PAGsXztzj
 qRi3GW2UYDapY/qwH0ScDM8MILUa8lFcnc93pDug+6a9+iNtv2OH/f8qYeZAFLnSfsLPPySSP
 qjKXGCYHGt0Ogn2mFoUIzZ7GPd/ex4zdUelNplA57EmZi4h9OA2GFibXq3ZFlGlzx4TA3rsWP
 NLl0lVgpR9eVed/ONaDSupx2qtGmI2tIS5qwRqnyd/VcaBz2mgXBnEzhaBswJviG7pvaDaAV5
 TKHHQO3m/cwo9KCisE3Q9PST5aT/0n00Vq0hxwEl/UtsCOMTLV5SC2F4vVGWxz6IZ2NdV4b9g
 CHeCAtZmNq4UTNy9vPz/fPZ/+r6MVVy+jLWhT5BviZMJ2cf1nN2qfnDhk
Subject: [cocci] [PATCH v2 4/4] powerpc/4xx: Delete unnecessary variable
 initialisations in four functions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 956
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/80830e38-7088-301a-58d7-7e3ec332f765%40web.de>

Date: Sat, 25 Mar 2023 16:00:36 +0100

Some local variables will be set to an appropriate value before usage.
Thus omit explicit initialisations at the beginning of these functions.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 arch/powerpc/platforms/4xx/pci.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/4xx/pci.c b/arch/powerpc/platforms/4xx=
/pci.c
index 46ba0a4e5b04..6fb7f9c966a6 100644
=2D-- a/arch/powerpc/platforms/4xx/pci.c
+++ b/arch/powerpc/platforms/4xx/pci.c
@@ -323,8 +323,8 @@ static void __init ppc4xx_probe_pci_bridge(struct devi=
ce_node *np)
 	struct resource rsrc_cfg;
 	struct resource rsrc_reg;
 	struct resource dma_window;
-	struct pci_controller *hose =3D NULL;
-	void __iomem *reg =3D NULL;
+	struct pci_controller *hose;
+	void __iomem *reg;
 	const int *bus_range;
 	int primary =3D 0;

@@ -523,8 +523,8 @@ static void __init ppc4xx_probe_pcix_bridge(struct dev=
ice_node *np)
 	struct resource rsrc_cfg;
 	struct resource rsrc_reg;
 	struct resource dma_window;
-	struct pci_controller *hose =3D NULL;
-	void __iomem *reg =3D NULL;
+	struct pci_controller *hose;
+	void __iomem *reg;
 	const int *bus_range;
 	int big_pim =3D 0, msi =3D 0, primary =3D 0;

@@ -1403,7 +1403,7 @@ static struct ppc4xx_pciex_hwops ppc_476fpe_pcie_hwo=
ps __initdata =3D
 static int __init ppc4xx_pciex_check_core_init(struct device_node *np)
 {
 	static int core_init;
-	int count =3D -ENODEV;
+	int count;

 	if (core_init++)
 		return 0;
@@ -1905,10 +1905,10 @@ static void __init ppc4xx_configure_pciex_PIMs(str=
uct ppc4xx_pciex_port *port,
 static void __init ppc4xx_pciex_port_setup_hose(struct ppc4xx_pciex_port =
*port)
 {
 	struct resource dma_window;
-	struct pci_controller *hose =3D NULL;
+	struct pci_controller *hose;
 	const int *bus_range;
 	int primary =3D 0, busses;
-	void __iomem *mbase =3D NULL, *cfg_data =3D NULL;
+	void __iomem *mbase, *cfg_data =3D NULL;
 	const u32 *pval;
 	u32 val;

=2D-
2.40.0

