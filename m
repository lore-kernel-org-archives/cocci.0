Return-Path: <SRS0=gEjp=YG=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430BBC4360C
	for <cocci@archiver.kernel.org>; Sun, 13 Oct 2019 16:38:09 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D17B02067B
	for <cocci@archiver.kernel.org>; Sun, 13 Oct 2019 16:38:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D17B02067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9DGbvce018292;
	Sun, 13 Oct 2019 18:37:57 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 634577784;
	Sun, 13 Oct 2019 18:37:57 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7C8E57415
 for <cocci@systeme.lip6.fr>; Sun, 13 Oct 2019 18:37:56 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9DGbuAc020083
 for <cocci@systeme.lip6.fr>; Sun, 13 Oct 2019 18:37:56 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.67,292,1566856800"; d="scan'208";a="405946326"
Received: from 81-65-53-202.rev.numericable.fr (HELO hadrien) ([81.65.53.202])
 by mail2-relais-roc.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Oct 2019 18:37:56 +0200
Date: Sun, 13 Oct 2019 18:37:55 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <21abdc24-95d3-be59-0a93-4b60e790a239@web.de>
Message-ID: <alpine.DEB.2.21.1910131836530.2565@hadrien>
References: <alpine.DEB.2.21.1910112200230.3284@hadrien>
 <11a68d96-ace6-889b-596b-e34590b7b965@web.de>
 <alpine.DEB.2.21.1910131806400.2565@hadrien>
 <21abdc24-95d3-be59-0a93-4b60e790a239@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 13 Oct 2019 18:37:57 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Sun, 13 Oct 2019 18:37:56 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: =?ISO-8859-15?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>,
        Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Adjusting macros with SmPL?
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



On Sun, 13 Oct 2019, Markus Elfring wrote:

> >> Does the semantic patch language (Coccinelle software) support
> >> the adjustment of preprocessor definitions as in the shown
> >> source code example?
> >
> > Can't you find the answer to this question by yourself by trying it?
>
> My test did not show an useful patch result for the shown SmPL transformation variant.
>
>
> I probably know another answer already if no other news will be contributed.
> Would you like to take another look at your commit from 2011-01-10?
> https://github.com/coccinelle/coccinelle/commit/5e3f73c732075f7afadf383d088f3b6d0e1345b1

This seems completely irrelevant.  The question was about #define, not
about #ifdef.  Changes within #define code should be supported if
Coccinelle is able to parse the code independently of its usage context.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
