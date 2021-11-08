Return-Path: <SRS0=6jWL=P3=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD9DC433F5
	for <cocci@archiver.kernel.org>; Mon,  8 Nov 2021 17:40:23 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 874CA61989
	for <cocci@archiver.kernel.org>; Mon,  8 Nov 2021 17:40:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 874CA61989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.87,218,1631570400"; 
   d="scan'208";a="2626840"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Nov 2021 18:40:21 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DAACBE006B; Mon,  8 Nov 2021 18:40:20 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTP id CB7DBE004C
	for <cocci@sympa.inria.fr>; Mon,  8 Nov 2021 18:40:17 +0100 (CET)
IronPort-Data: =?us-ascii?q?A9a23=3AWAWG/aoJbTsZZG9Fu1zawJa+zgZeBmLZZxIvgKr?=
 =?us-ascii?q?LsJaIsI5as4F+vmMWX2CGPamPamOjeohzPYuwoBwA7MKExoM1SAs6qCE3QiMRo?=
 =?us-ascii?q?6IpJ/zJdxaqZ3v6wu7rFR88sZ1GMrEsFC2FJ5Pljk/F3oPJ8D8sislkepKmULS?=
 =?us-ascii?q?dY3kpFVc9IMscoUkLd9AR09cAbeeRU1vlVePa+6UzCXf9s9JGGjp8B5Gr9HuDi?=
 =?us-ascii?q?M/PVAYw5TTSUxzkUGj2zBH5BLpHTU24wuCRroN8RoZWTM6bpF21E/+wwvsjNj+?=
 =?us-ascii?q?luu6TnkwiQrfeJwmDjBK6WYDy314c9mpriP99baVHAatUo2zhc9RZyshJtJX2T?=
 =?us-ascii?q?Q42N6nIsOUbSRhRVS9kVUFD0OWZeybv6pH7I0ruNiGEL+9VJGQ/J44F4aBaBW9?=
 =?us-ascii?q?U9PoXAC8AZFaPioqe3riyQOplrt8+N8StN5F3knpnxjrYJe03RIjKBaTM/95Rm?=
 =?us-ascii?q?jkq7v2it962i9ExMGU0Kk2aOlsRahFHVdQkkfnunXflNTtVtDqoSWMMyzC75GR?=
 =?us-ascii?q?MPHLFabI5ouC3ePg=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Aefp4ZqHOn7GOFv07pLqEbceALOsnbusQ8zAX?=
 =?us-ascii?q?PhZKOHlom6uj5rWTdZUgpG3JYVkqKRcdcO67Sd29qB/nmqKcD+EqTMmftCePgh?=
 =?us-ascii?q?rZEGhJ1/qf/9XYcxeOh9K0P89bAttD4aTLfCdHZKXBkW2F+qgbsb66GfuT9IXj?=
 =?us-ascii?q?Jh5WJGkAAcwN0+pgMHfjLqRYfngwOXNTLuvm2iMonVSdkbV+VLXAOlA1G8Xqhb?=
 =?us-ascii?q?Tw9a7OUFoqCxUm4A7mt1OVwY+/PhSS3h8YFwpGy7Ur/2StqX2b2k0t28vLtyP0?=
 =?us-ascii?q?xivf459XkNykwsJbH8qShsV9EESVtjqV?=
X-IronPort-AV: E=Sophos;i="5.87,218,1631570400"; 
   d="scan'208";a="2626835"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 18:40:18 +0100
Date: Mon, 8 Nov 2021 18:40:17 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
cc: Vlastimil Babka <vbabka@suse.cz>, cocci@inria.fr
In-Reply-To: <96c0476d-beef-ed62-26d3-5f754cec0f45@web.de>
Message-ID: <alpine.DEB.2.22.394.2111081839430.65268@hadrien>
References: <17a7a40f-b736-e0ea-02ae-1b03ef4483bf@suse.cz> <a02a8c42-011d-0f9c-6a2f-7d45a3f216a5@web.de> <alpine.DEB.2.22.394.2111071321530.2988@hadrien> <000e221f-1bac-6e29-8c68-2c1eab5b2128@web.de> <89bb8f39-4527-a1b4-dab9-82929773e9d9@suse.cz>
 <alpine.DEB.2.22.394.2111071908410.2988@hadrien> <96c0476d-beef-ed62-26d3-5f754cec0f45@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] mm/slab: prepare for struct page conversion by spatch
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 100
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-11/alpine.DEB.2.22.394.2111081839430.65268%40hadrien>



On Mon, 8 Nov 2021, Markus Elfring wrote:

> > > - struct page *page;
> > > + struct slab *slab;
> >
> > If you first rename struct page as strict slab and then do
> >
> > struct slab *
> > - page
> > + slab
> >   ;
> >
> > it might work even for the multiple declaration case.
>
> Will there are need occur to adjust any more variable names?
> (Would different suffixes matter for corresponding identifiers?)

Something could be done with python/ocaml.  But if the result is
satisfactory already, then there is no need for that.

julia
