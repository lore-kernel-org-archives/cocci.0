Return-Path: <SRS0=jpx+=MF=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F2EC07E95
	for <cocci@archiver.kernel.org>; Tue, 13 Jul 2021 21:33:23 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDED661363
	for <cocci@archiver.kernel.org>; Tue, 13 Jul 2021 21:33:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDED661363
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 16DLXItk023248;
	Tue, 13 Jul 2021 23:33:18 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id AB997776E;
	Tue, 13 Jul 2021 23:33:18 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4CBFA3F5A
 for <cocci@systeme.lip6.fr>; Tue, 13 Jul 2021 23:33:16 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 16DLXF7k006246
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 13 Jul 2021 23:33:15 +0200 (CEST)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AywMQU6h2J3nGR6e/vqyf7z2903BQXr8ji2hC?=
 =?us-ascii?q?6mlwRA09TyX4rbHMoB1/73TJYVkqN03I9ervBEDiexPhHPxOgLX5VI3KNGPbUQ?=
 =?us-ascii?q?CTQL2Kg7GO/wHd?=
X-IronPort-AV: E=Sophos;i="5.84,237,1620684000"; d="scan'208";a="387979542"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 13 Jul 2021 23:33:15 +0200
Date: Tue, 13 Jul 2021 23:33:15 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Joe Perches <joe@perches.com>
In-Reply-To: <afd3a282ca57a4a400c8bae9879a7c57bc507c59.camel@perches.com>
Message-ID: <alpine.DEB.2.22.394.2107132332030.3024@hadrien>
References: <08b89608cfb1280624d1a89ead6547069f9a4c31.camel@perches.com>
 <alpine.DEB.2.22.394.2107102149140.46528@hadrien>
 <afd3a282ca57a4a400c8bae9879a7c57bc507c59.camel@perches.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 13 Jul 2021 23:33:19 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 13 Jul 2021 23:33:15 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: kernel-janitors@vger.kernel.org, cocci <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Cocci] cocci script to convert linux-kernel allocs with
 BITS_TO_LONGS to bitmap_alloc
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr



On Sat, 10 Jul 2021, Joe Perches wrote:

> On Sat, 2021-07-10 at 21:50 +0200, Julia Lawall wrote:
> > On Fri, 9 Jul 2021, Joe Perches wrote:
> >
> > > Here is a cocci script to convert various types of bitmap allocations
> > > that use BITS_TO_LONGS to the more typical bitmap_alloc functions.

I see that there is also a bitmap_free.  Maybe the rule should be
introducing that as well?

julia

> > >
> > > Perhaps something like it could be added to scripts/coccinelle.
> > > The diff produced by the script is also below.
> > >
> > > $ cat bitmap_allocs.cocci
> > > // typical uses of bitmap allocations
> []
> > > @@
> > > expression val;
> > > expression e1;
> > > expression e2;
> > > @@
> > >
> > > -	val = kcalloc(BITS_TO_LONGS(e1), sizeof(*val), e2)
> > > +	val = bitmap_zalloc(e1, e2)
> >
> > Is there something that guarantees that val has a type that has a size that
> > is the same as a long?
>
> no, but afaict, all do.
>
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
