Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F5CC3DA6E
	for <cocci@archiver.kernel.org>; Fri,  5 Jan 2024 17:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=YEo/JuJB8KGhnW96MJrqEOvoqawhBcxMUq6nH76RtJ0=;
  b=novcpXwRaHqzhoaW5X2HAhicLlYe5XWQSF/iK9fD8BPsMnLumxdI0u8m
   tpJrqPuc6xLU2gcuAokO6UVcZKRJ/9dgWKcKuIPAeqVfWpz3mxNS0a6OX
   1c/ONcW5oRGx5tEERGd9FewcnH026KMNGp5sjsu96VA3kzJ3jkWgzurHb
   0=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail02.safebrands.com ip4:128.93.142.0/24
  ip4:192.134.164.0/24 ip4:128.93.162.160 ip4:89.107.174.7 mx
  ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.04,334,1695679200"; 
   d="scan'208";a="145131547"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Jan 2024 18:43:23 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0D2CCE0CCA; Fri,  5 Jan 2024 18:43:23 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 67D5FE004E
	for <cocci@sympa.inria.fr>; Fri,  5 Jan 2024 18:43:22 +0100 (CET)
IronPort-SDR: 65983fb3_Z0LrKhtw84IZw4up+caCOe1JyzFwb1Z0PZY0Pw1lyoQAavL
 3SNU6o5fXPGAMALIe5WMLIXl+RQVz3LStBClztA==
X-IPAS-Result: =?us-ascii?q?A0FDAABHP5hl/wMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwGAQELAYI4B1sdUzIEC0iEU49BgXUwhDuHNYdMiG+BVhSBLD4PAQMBDUEBA?=
 =?us-ascii?q?gQBAQMEOIRHAoc5Ah4HAQQxCA4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBA?=
 =?us-ascii?q?QIEBgECgQYThWwNCIJUARCBDIEeAQEBAQEBAQEBAQEBAQEBAQEBFwJHQgEEA?=
 =?us-ascii?q?SMdAQERJgEECwsUBgIRFQICVgYBFAEBgnyCKwEDDiMHsROBMoEBggoBAQaCZ?=
 =?us-ascii?q?qxyHywiVoFgCYEaLgGIGgGFZ4NBeicPgVVEgTyDAz6DfIEGgxyCaIIcg0KKI?=
 =?us-ascii?q?IUcUn8fA4EFBFwPGw8eNxEQEw0DCG4dAjE8AwUDBDIKEgwLIQVVA0AGSQsDA?=
 =?us-ascii?q?hoFAwMEgTAFDRoCEBoGDCYDAxJJAhAUAzsDAwYDCjEDMFVCDFADZR8yCTwLB?=
 =?us-ascii?q?AwaAhseDScjAixCAxEFEAIWAyQWBDQRCQsoAywGOAISDAYGCV0mBw8JBCUDC?=
 =?us-ascii?q?AQDKykDI3QRAwQKAxQHCwdjAxkrHUACAQttPTUGAwsbBj0ClwCBDoI/kzqxf?=
 =?us-ascii?q?jQHgjSBYIFhDJ8rBhMvg24TkyUOBpJUmE0ggjGmFYFlATqBWTMaJIM2TwMZD?=
 =?us-ascii?q?44ghCuPCQE9QDU7AgcLAQEDCYVGAQGDWoFGAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:TIOXJqxnD019bHwfmvxEKrPw+L1zdoMgy1knxilNoNJuA6ilfr
 OV7ZcmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bBYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebrN5DNB7foSjjPIduoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-Talos-CUID: 9a23:wUehH26LFox1znHa29ssqU02MOV1bkDn6ynaMkSbM11vGJm1YArF
X-Talos-MUID: 9a23:uwc0JgrnQgRdNnkwBbUez2BbE8V15qKvM1AMuIo95JfcKQZ6YzjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,334,1695679200"; 
   d="scan'208";a="145131537"
X-MGA-submission: =?us-ascii?q?MDGtpu1JhMmniAM+To2+VylTq3usW+1n6kH6m1?=
 =?us-ascii?q?po0tfOv+lObZHhvB/8eaF1LNjuUNTRbzS8UNX/kMGqxcERFAmm9oFA8O?=
 =?us-ascii?q?VOt2AormP3fPlu7Fgi9AkyO4zatPPQwl7497KUaMInuoqioKp1UAGKJM?=
 =?us-ascii?q?gqAc4pLtLadQgQpSTU7X1amA=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2024 18:43:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704476573; x=1705081373; i=markus.elfring@web.de;
	bh=wS6PsNt2y18wBuHSYkuJprLzMZM4lOzVE4kOejHdGJY=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=lq67GxWJRGfWDFM4hyAkBMKMcaHlk13zd6znpFgEpJpfUlLXls1iWoacwPmMzlbw
	 NusFy5rCO0Ep0RNpefUSE4YLq3a/KY9x5LNPGfmqkNPNZ7bJNDPQbQSvdXT7au5iQ
	 KwadT2y4CxO1taJKxbo3LfI2V8H0bDSoeSFf+JRwo/iOaB09W4O2mnUoIvjmEbZIE
	 JzM0vMa6GmvlUHjQuJtiJeosOJAIDMErIE53ks7rQ6FSf1VR2wh7sYLnG4ZyeHeI5
	 xaf9H2r/NtUV/Y5W6L1u70UimZt09lH7SokDAjSh0XfQIhkOJthGUAqz6y1ITQ2Os
	 y/KxE7HuG4jHHrxq9w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mr7ek-1qsjvv1WcA-00oMI5; Fri, 05
 Jan 2024 18:42:53 +0100
Message-ID: <ecc3a3ea-e199-4d57-b244-9811b5e408e4@web.de>
Date: Fri, 5 Jan 2024 18:42:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
X-Provags-ID: V03:K1:zlLBn14E+TDhGhUEP6jHPfOKj+JOryPQzEfKwTZPn9VnLpoNOWk
 povpIOGxci93DD4OQ/nyOXkfEbUxDLyobedMEKhL3zb+nMzue9M9TR3B7R3nzWvgszWO9SW
 EZKE7FXceD19TgMmqAGY7VJ9VK1HZABLig9YT0s58t6k8V52guQycNjO1y4cb4TMY5IvGl7
 AS/rulsxSv/Kya1J0AXLg==
UI-OutboundReport: notjunk:1;M01:P0:a/PxcM6gL48=;hh+akCP6GjvdmxP77qr8CwY8Muu
 l3Nx8PTqKpbr7FACJ91WCKUmGSyEsJdKzbD0rd21/mAmN8LQ5riMx+yLrvNYv/uDN2SjaVvMt
 Ldcj0yZgirw1rpno3hD8mGQ2jLp0Cq/2CTXwgd9B4IqoGqkvcviOuLnPCJLG1HCYWEbxYoV0L
 UuEdwG3ktj9bA51saHYDq8i5qk8wE3cGu1lCxWHULJ0feMroT5/q5inhUvGKIzXyepfAUMObF
 xH/M+oVrsQuXW/yqBfTvpdJeyGLkv3hBnrR+1hgIoklym4WWHPKPj/iTLVSfxwVya3+RggSUb
 SUA/3xa3TX61JKt2DZ0EMfKTnT7uPIYgLzuY+/p45BLqhSDJXYER87iX3/eLmO8pe9Ot856IB
 CMvSV/k/tDR17WUCCuFY1OI+MFKcJQHVirSk05JCu41VeF3mbpn0PxlcVrSpdAChj9/PGdlQt
 PDAubueycD6xze5PGjyqNGHbNl/H27p2574LNrvsz23xVjsh956o9Hu5UKLHwLM71eQBkeTkH
 JEo2tgYJxh2nSUvGKtVd9EgZCuSY1rpPbNklWwx2dfenIWf0gt5KU4AC6cAKF4buACL8EDv8T
 yAuBpHRmN7X3GEvqb8+xhQZNLygtP65zLDItZGik9ApIoawowVDPMb/J3vvOU3k5VsN6NynGm
 GXrATSuC8IXzu5a8kUU5HFy5kGG8ykb6fhCS5NFRYQD54vBiGbQjeLLHf6vlal8hzMkPMyBKZ
 WkLQdmmT448o8OHyKVid5M0oqmIThs6XqlPc+wjR4i6hbK50RJX11NGSHaWIs+y8gwudB+bwY
 wESX3Vq5hgiVTy5eGW9iZ1VgaXC2/OBAo7e3TZAAKXe+7pXq6kBfWQQvwCOmiFrN+m1PuVlCg
 6sM+tW5LQ5Nh+RDPCZUUwvy4UEQnTJBt40QJNb2ch8kKYiFvbY3xZKhWFQx4ko2xzGy88Vqsr
 /a4h4w==
Subject: Re: [cocci] [PATCH v2 0/4] powerpc/4xx: Adjustments for four
 function implementations
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1433
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/ecc3a3ea-e199-4d57-b244-9811b5e408e4%40web.de>

> Date: Sat, 25 Mar 2023 16:10:23 +0100
>
> Some update suggestions were taken into account
> from static source code analysis.
>
> Markus Elfring (4):
>   Fix exception handling in ppc4xx_pciex_port_setup_hose()
>   Fix exception handling in ppc4xx_probe_pcix_bridge()
>   Fix exception handling in ppc4xx_probe_pci_bridge()
>   Delete unnecessary variable initialisations in four functions
>
>  arch/powerpc/platforms/4xx/pci.c | 69 ++++++++++++++------------------
>  1 file changed, 31 insertions(+), 38 deletions(-)

Is this patch series still in review queues?

Regards,
Markus
