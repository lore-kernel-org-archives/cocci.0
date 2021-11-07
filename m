Return-Path: <SRS0=h9ga=P2=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF0AC433EF
	for <cocci@archiver.kernel.org>; Sun,  7 Nov 2021 18:10:24 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 233A061244
	for <cocci@archiver.kernel.org>; Sun,  7 Nov 2021 18:10:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 233A061244
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
IronPort-Data: =?us-ascii?q?A9a23=3AkfYTN6B9ZKphmxVW/zjiw5YqxClBgxIJ4g17XOL?=
 =?us-ascii?q?fAQLth2h3hWRUz2pLDWCCOKuKMWH9KN4iO4y08E4Gvp+Ax9UxeLYW3SE0HigS8?=
 =?us-ascii?q?aIpJvzAcxyuZ3vKRiH7ofMOA/w2MrEsF+hpCC+DzvuRGuK59yAljPnXHuOU5NP?=
 =?us-ascii?q?sYUideyc1EU/Ntjozw4bVsqYw6TSIK1vlVeHa+6UzC3f5s9JACV/43orYwP9ZU?=
 =?us-ascii?q?FsejxtD1rA2TagjUFYzDBD5BrpHTU26ByOQroW5goeHq+j/ILGRpgs1/j82G9a?=
 =?us-ascii?q?9m/D6dFcLS/jcJ2BiiFIPAfjk00ME/3JolP9lbJLwam8O49mNt9t2w95M8JuvT?=
 =?us-ascii?q?wozFqzKguUUFRdCe817FfcdqeOWeSDXXcu7iheun2HX6/5pB0o3FYQC8eZ2H2x?=
 =?us-ascii?q?Us/8VMjYAalaEne3e6Li6UfJ9iMoLI8ziPYdZsXZlpRnSCvsgTJbrTKDD5Nse1?=
 =?us-ascii?q?zA17uhCFPCYZYwGaD5rbR3FeDVAP14WDNQ1m+LArnX2bTxUs1WTqaQ450DcyQV?=
 =?us-ascii?q?w1P7mN9+9UtCHA95Sg1SR4GnB5Wn/HhAcHNOawDuBtHmrg4fnljjmXIYDPLK/8?=
 =?us-ascii?q?fFujRuYwWl7IBcbU1a3oPqlok6zWtRSbVYT8Sk1xYA58EusVfH/Xxa8p3mf+BU?=
 =?us-ascii?q?bXrJ4H+Q86QyJjK7Z8Q2QAG8sSj9HYcYh8sgsSlQC3V+Tnsj1AiRv9reSRHKY6?=
 =?us-ascii?q?b6QoT6oESwUK2UDeWkPSg5t3jVJiOnflTrXVNFvVaq0lcH4Aiypk3aLqjI/jvM?=
 =?us-ascii?q?dl6Y2O2yA1Qivq1qRSlLhEmbZPjnqY18=3D?=
X-IronPort-AV: E=Sophos;i="5.87,216,1631570400"; 
   d="scan'208";a="2394900"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Nov 2021 19:10:03 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 552E5E006A; Sun,  7 Nov 2021 19:10:03 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 939E5E004C
	for <cocci@sympa.inria.fr>; Sun,  7 Nov 2021 19:10:00 +0100 (CET)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Ayt4rQq1P+zMR6cSq6Z3YHAqjBKckLtp133Aq?=
 =?us-ascii?q?2lEZdPU1SK2lfq+V98jzuSWftN9zYh8dcLK7VJVoKEm0naKdirN/AV7WZniFhI?=
 =?us-ascii?q?LeFvAG0WKN+VDd8lXFh41gPPBbE5RDNA=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="398466664"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2021 19:10:00 +0100
Date: Sun, 7 Nov 2021 19:09:59 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Vlastimil Babka <vbabka@suse.cz>
cc: Markus Elfring <Markus.Elfring@web.de>, 
    Luis Chamberlain <mcgrof@kernel.org>, cocci@inria.fr
In-Reply-To: <89bb8f39-4527-a1b4-dab9-82929773e9d9@suse.cz>
Message-ID: <alpine.DEB.2.22.394.2111071908410.2988@hadrien>
References: <17a7a40f-b736-e0ea-02ae-1b03ef4483bf@suse.cz> <a02a8c42-011d-0f9c-6a2f-7d45a3f216a5@web.de> <alpine.DEB.2.22.394.2111071321530.2988@hadrien> <000e221f-1bac-6e29-8c68-2c1eab5b2128@web.de> <89bb8f39-4527-a1b4-dab9-82929773e9d9@suse.cz>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] mm/slab: prepare for struct page conversion by spatch
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 93
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-11/alpine.DEB.2.22.394.2111071908410.2988%40hadrien>



On Sun, 7 Nov 2021, Vlastimil Babka wrote:

> On 11/7/21 13:50, Markus Elfring wrote:
> >>> * Will any guidance help to find nicer solutions?
> >>
> >> Luis already proposed a perfectly reasonable solution.
> >
> > His proposal can look a bit too terse (for affected implementation details),
> > can't it?
> > https://sympa.inria.fr/sympa/arc/cocci/2021-11/msg00017.html
> > https://lore.kernel.org/cocci/YYVZva1hfwanXdyB@bombadil.infradead.org/
>
> I don't mind terse, I wasn't asking for complete fixup of my patches,
> but for hints, and I got plenty from all of you, thanks! Will try to
> apply everything tomorrow.
>
> > @@
> > @@
> > -struct page
> > +struct slab
>
> The above is itself incomplete to go from "struct page *page" to "struct
> slab *slab", but will results in "struct slab *page".
>
> So my attempts included:
> - struct page *page
> + struct slab *slab
>
> But that for some reason resulted in spatch reporting (IIRC) syntax

A variable declaration needs a semicolon.

> errors, so I had to change it to this:
>
> - struct page *page;
> + struct slab *slab;

If you first rename struct page as strict slab and then do

struct slab *
- page
+ slab
 ;

it might work even for the multiple declaration case.

julia

> And that worked in most cases, but didn't handle the multiple variables
> being declared nor declaration+assignment.
>
> But I assume Luis' suggestion is supposed to work together with the rule
> that does simply -page +slab. I'll see how it works out, and also
> Julia's suggestion "just have one rule to change all occurences of page
> to slab, and then have individual rules to change eg page_address(slab)
> to slab_address(slab)."
>
> Thanks,
> Vlastimil
>
