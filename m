Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D3BC54ED1
	for <cocci@archiver.kernel.org>; Sat, 28 Jun 2025 20:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=5w5Vg4IOh58zLu6WL7wxj77jX3oSLYvehkr63dtwp8M=;
  b=cBaWuwnlLxrqCTQTgGMzX1IAuy8OxVvZ41egCkp3y47+zEU4AxuMNfVn
   a59tpOJoh7pev339T0t8EM16gbAHDP21MA7IjaFS1nV8p/WoUru41XNh6
   m2U5Cg8y8urRKXHImMBpeEyhR2Aryl93R42SMnk7db1Msrodg8I0o12Lg
   M=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.16,273,1744063200"; 
   d="scan'208";a="229435612"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jun 2025 22:44:28 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EA434E01A8; Sat, 28 Jun 2025 22:44:27 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9D1CEE0131
	for <cocci@sympa.inria.fr>; Sat, 28 Jun 2025 22:44:22 +0200 (CEST)
IronPort-SDR: 68605426_eo//bo13HEDw2X1Ctj46HCU5abDZmbwjTtYqmE3Anf7D+eU
 ZrbnpqKeoURN1Jig8VJAgV9cNakDBbHLS3V7Nrw==
X-IPAS-Result: =?us-ascii?q?A0GrAQCVUmBogAMP49RaHQEBAQEJARIBBQUBQIFCBQELA?=
 =?us-ascii?q?YJDgQZUMwQLSYRVj1CBdDCEO4c8h1OId4NSAg8BAwENTgECBAEBAwSFAAKLc?=
 =?us-ascii?q?gIeBwEEMwYOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABATsHD?=
 =?us-ascii?q?goxhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMdAQERJwQLCxoCJ?=
 =?us-ascii?q?gICVgYBFAEBgn6CIgEGEAEDDiQHsliBMoEBggwBAQbaXh8sIliBZQmBGy4Bh?=
 =?us-ascii?q?WyCZAGGJ4Q8Jw+BVUSBPIMDPogegmmCJoEWhU2UAFJ4HANZLAFVExcLBwWBI?=
 =?us-ascii?q?EMDKjQxIw88BS0dgSd/gU4cgx6BG4RFK0+CKAF7gXpBGUGDXR4GbQ8GgSEbN?=
 =?us-ascii?q?kACAQttPTcJCxsGPZMCqlqBNaFCNAeCOIFmgWQMn2kGEy+DcQGTWg4GkwKZB?=
 =?us-ascii?q?SKpGoF+JIFcMxokgzZPAxkPjiGEM7xDQTU8AgcLAQEDCYVGAQGKXYFLAQE?=
IronPort-PHdr: A9a23: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
 sfCnuT/JWUamzo11c4bGtSSN8+NdnYsY0KBJQ==
IronPort-Data: A9a23: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
 YT4eIycfHyGdA==
IronPort-HdrOrdr: A9a23:JxWHhKlOV5m/AAZDqSEoPtIOFFzpDfLy3DAbv31ZSRFFG/Fw5P
 re+cjzsiWE8Qr5OUtQ/+xoXZPqfZqyz/FICOUqTNOftUzdyQyVxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIOauEYZmIbsS+V2njaL/8d4J2g7L2ig/vYwkxgVAdwdshbnn1E40qgc3GfX2N9dOIE/X
 enl7F6T7HMQx4qUvg=
X-Talos-CUID: 9a23:q4k2wWOlEh2YDu5Dd3lKqBQKPJ8cY0KDx1XhLka0EXtzV+jA
X-Talos-MUID: =?us-ascii?q?9a23=3A72gA5Q9WGJLjRPqb5N15JeyQf5Z5yoipJH4Nq7A?=
 =?us-ascii?q?D48uOJ3Z+GBS4szviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,273,1744063200"; 
   d="scan'208";a="229435611"
X-MGA-submission: =?us-ascii?q?MDGpjOs1ZJxvu3wX9U3jH0h/fxJd3xzTbjSAQz?=
 =?us-ascii?q?CaRP7su3Tg3nZOwnlMKVRIo0rYJ/1uSJC51RTkIRGZwbD0A4LUrftzPW?=
 =?us-ascii?q?J4AjNtbMivsQHEGew+IqDYgV2Gw8WjJQ4x5S5dBnP07zWhTf7vG2B0nR?=
 =?us-ascii?q?/sHKCGflsJjvRlqy5Ib5F9dA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2025 22:44:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751143461; x=1751748261; i=markus.elfring@web.de;
	bh=5w5Vg4IOh58zLu6WL7wxj77jX3oSLYvehkr63dtwp8M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ipF57uO5XzN+THI+eHxaWk5Orobse1+VawRPZ5Y29iW1jFgsAlGWcxp7+3pZW6Gk
	 ABNaiAtG0TpV/31OErE3p3bsbwQutsCCpcGkOdxNeuHMcoGwLPI8U3xYRTKv+Kkbp
	 k9kGGVF8LS/t4Wr4DfKwvHjLeyEQB19NYaBTvGbLN52lxTW9yz8j67Gzz53IX7Kuf
	 2XiaS6fyfQSkg53m5c6wDjZbflbnP0jmvywnK3hTvjzMh/GBI7pEntqkcF2bzem6V
	 AKyiq+yl/Gxb1Pj2jcGnDtT6uRCDE+00KtDnIRQ+Ni3Ub+ll+3dr5NzJlmfsiiMiw
	 MYbnFXxDBb4AtoydHg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.176]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Movne-1v4Qah0xaQ-00csbJ; Sat, 28
 Jun 2025 22:44:21 +0200
Message-ID: <9e81fa9a-57b5-442a-a3e9-eff1a1a9d63f@web.de>
Date: Sat, 28 Jun 2025 22:44:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <2038c080-a429-44bb-a572-c1f9e733320d@web.de>
 <alpine.DEB.2.22.394.2506281638300.50494@hadrien>
 <1f3bd2ed-0252-4347-835f-5fecda857cf0@web.de>
 <alpine.DEB.2.22.394.2506282132040.50494@hadrien>
 <8737f8dc-a10e-4f2f-8a50-87edc5c2aa78@web.de>
 <alpine.DEB.2.22.394.2506282142200.50494@hadrien>
 <47efbf70-5b53-4e7f-922f-b6405e240134@web.de>
 <alpine.DEB.2.22.394.2506282156560.50494@hadrien>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2506282156560.50494@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:YM0St/4H72n2T+r/xJScLxk8J1XCL/VHlceB7AiPdawiwbY8jHB
 PIjODzBDlnaZwHxsW5Hl5SOMI1tjE9xTvDZn1domy3yrPmNyY7GS0JqxbmhjhySWL1u5f/Q
 eOtxd91Z0eqGJMurqhiKcr/mZ4RAc1g6w0vBtVLyOxCZHx5sTYq7K2/el3+Tbpk6Vrkcn3C
 mqxZfbLfdlBf9aWBdn/sw==
UI-OutboundReport: notjunk:1;M01:P0:xGE9fG+t3kc=;5fpI6vzDGC+TwK9z3/7K5kgcRBT
 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
 tAvo1uqFxZg==
Subject: Re: [cocci] Avoiding metavariable confusion for duplicate
 identifiers?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2806
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-06/9e81fa9a-57b5-442a-a3e9-eff1a1a9d63f%40web.de>

> What is the concern you are getting at?
Under which circumstances would you put such identifiers into different name spaces?

Regards,
Markus
