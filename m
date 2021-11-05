Return-Path: <SRS0=AtCD=PY=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF884C433EF
	for <cocci@archiver.kernel.org>; Fri,  5 Nov 2021 21:43:14 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E82E66113B
	for <cocci@archiver.kernel.org>; Fri,  5 Nov 2021 21:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E82E66113B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
IronPort-Data: =?us-ascii?q?A9a23=3Amg8L2qAVAoPxgRVW/zjiw5YqxClBgxIJ4g17XOL?=
 =?us-ascii?q?fBAS91W4ngzIAxjYfUG2Ca6qKa2Ggeop0Odiz9BlUvcOAx9UxeLYW3SE0HigS8?=
 =?us-ascii?q?aIpJvzAcxyuZ3vKRiH7ofMOA/w2MrEsF+hpCC+DzvuRGuK59yAljPnVHuGU5NP?=
 =?us-ascii?q?sYUideyc1EU/Ntjozw4bVsqYw6TSIK1vlVeHa+6UzC3f5s9JACV/43orYwP9ZU?=
 =?us-ascii?q?FsejxtD1rA2TagjUFYzDBD5BrpHTU26ByOQroW5goeHq+j/ILGRpgs1/j82G9a?=
 =?us-ascii?q?9m/D6dFcLS/jcJ2BiiFIPAfjk00ME/3JolP9lbJLwam8O49mNt9t2w95M8JuvT?=
 =?us-ascii?q?wozFqzKguUUFRdCe817FfccpeOefSTXXcu7iheun2HX6/5pB0o3FYQC8eZ2H2x?=
 =?us-ascii?q?Us/8VMjYAalaEne3e6Li6UfJ9iMoLI8ziPYdZsXZlpRnSCvsgTJbrTKDD5Nse1?=
 =?us-ascii?q?zA17uhCFPCYZYwGaD5rbR3FeDVAP14WDNQ1m+LArnX2bTxUs1WTqaQ450DcyQV?=
 =?us-ascii?q?w1P7mN9+9UtCHA95Sg1SR4GnB5Wn/HhAcHNOawDuBtHmrg4fnljjmXIYDPLK/8?=
 =?us-ascii?q?fFujRuYwWl7IBcbU1a3oPqlok6zWtRSbVYT8Sk1xYA58EusVfH/Xxa8p3mf+BU?=
 =?us-ascii?q?bXrJ4H+Q86QyJjK7Z8Q2QAG8sSj9HYcYh8sgsSlQC3V+Tnsj1AiRv9reSRHKY6?=
 =?us-ascii?q?b6QoT6oESwUK2UDeWkPSg5t3jVJiOnflTrXVNFvVaq0lcH4Aiypk3aLqjI/jvM?=
 =?us-ascii?q?dl6Y2O2yA1Qivq1qRSlLhF2bZPjnqY18=3D?=
X-IronPort-AV: E=Sophos;i="5.87,212,1631570400"; 
   d="scan'208";a="2254144"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Nov 2021 22:43:13 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2BEE2E006B; Fri,  5 Nov 2021 22:43:12 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D228CE004C
	for <cocci@sympa.inria.fr>; Fri,  5 Nov 2021 22:43:06 +0100 (CET)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A01IvsK0XExB9M58vEjAbzgqjBI0kLtp133Aq?=
 =?us-ascii?q?2lEZdPWaSL3+qyncpoV/6faSskdqZJhAo6H6BEDkexmwyXcb2+gs1NuZLXDbUS?=
 =?us-ascii?q?6TXflfBOjZowEIeReRygc1784JGMQQNDSzNykdsS+Q2njbLz9P+qjizEnlv5a8?=
 =?us-ascii?q?80tQ?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="398384694"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 22:43:06 +0100
Date: Fri, 5 Nov 2021 22:43:06 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Vlastimil Babka <vbabka@suse.cz>
cc: cocci@inria.fr
In-Reply-To: <17a7a40f-b736-e0ea-02ae-1b03ef4483bf@suse.cz>
Message-ID: <alpine.DEB.2.22.394.2111052241170.3000@hadrien>
References: <17a7a40f-b736-e0ea-02ae-1b03ef4483bf@suse.cz>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] Need some help with spatch
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 82
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-11/alpine.DEB.2.22.394.2111052241170.3000%40hadrien>

> for example the cocci patch is supposed to change all "page" to "slab", but
> some lines are patched like this:
>
> -       __free_slab(page->slab_cache, page);
> +       __free_slab(page->slab_cache, slab);

OK, I can now reproduce this problem.  I think we both made the mistake of
not taking the code as it was before the 184d9494c1a4 commit.

On the other hand, the dropped newline problem in the same function has
been fixed.  The fix should be in the (slightly premature) recent release
of 1.1.1.

julia
