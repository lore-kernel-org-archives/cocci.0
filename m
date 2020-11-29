Return-Path: <SRS0=5OGr=FD=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF081C3E8C5
	for <cocci@archiver.kernel.org>; Sun, 29 Nov 2020 12:52:56 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF4ED2080C
	for <cocci@archiver.kernel.org>; Sun, 29 Nov 2020 12:52:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF4ED2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0ATCqVVo008201;
	Sun, 29 Nov 2020 13:52:31 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4D6CD779F;
	Sun, 29 Nov 2020 13:52:31 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B0E29454B
 for <cocci@systeme.lip6.fr>; Sun, 29 Nov 2020 13:52:29 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0ATCqTa0005317
 for <cocci@systeme.lip6.fr>; Sun, 29 Nov 2020 13:52:29 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.78,379,1599516000"; d="scan'208";a="480070705"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Nov 2020 13:52:29 +0100
Date: Sun, 29 Nov 2020 13:52:29 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <978f08c3-21ed-d434-d2ef-163335ae990e@web.de>
Message-ID: <alpine.DEB.2.22.394.2011291351210.2671@hadrien>
References: <13b38013-8d4f-55fa-3c0e-ead782031659@web.de>
 <alpine.DEB.2.22.394.2011281844070.2725@hadrien>
 <feb351dc-537f-0f83-d9ec-cf16796ac0ee@web.de>
 <alpine.DEB.2.22.394.2011281959330.2725@hadrien>
 <d78a46b3-7035-8300-6e8c-b9e823574ad9@web.de>
 <alpine.DEB.2.22.394.2011282048540.2725@hadrien>
 <8d2bfa68-c8e0-9c5a-b2f5-057e534f5976@web.de>
 <0148bab2-6148-e403-985d-df2e7cade490@web.de>
 <alpine.DEB.2.22.394.2011291250490.2671@hadrien>
 <3b134eb3-7ccf-454c-3266-64cfaec5a307@web.de>
 <alpine.DEB.2.22.394.2011291323290.2671@hadrien>
 <978f08c3-21ed-d434-d2ef-163335ae990e@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1400128556-1606654349=:2671"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 29 Nov 2020 13:52:31 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 29 Nov 2020 13:52:29 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Adjusting some calls according to pass-through functions
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
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1400128556-1606654349=:2671
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sun, 29 Nov 2020, Markus Elfring wrote:

> > A rule for each of the functions you have in the big disjunction
> > you have on the first line of your rule.
>
> I find that the size of such SmPL disjunctions can grow considerably.
>
>
> > But it only helps in your case because in your C code,
> > the first two lines have different function names.
>
> This would be usual for the C programming language.
> Would you ever like to consider additional development challenges for C++
> where distinctions would be more relevant for data types on input parameters?

I don't see any connection between your comment and what I said.  I think
that in both C and C++, people may call the same function on two
subsequent lines.

>
>
> >> Two changes should be performed in combination for a code replacement.
> >> How should a separation help then?
> >>
> >> Can the shown change pattern be applied recursively?
> >
> > You can follow the example in demos/iteration.cocci.
>
> Does a corresponding information like “Modification is not allowed when using iteration.”
> need further clarification for the discussed use case?
> https://github.com/coccinelle/coccinelle/blob/730dbb034559b3e549ec0b2973cd0400a3fa072f/docs/manual/cocci_syntax.tex#L1999

If you use the argument --in-place, there is no restriction.

julia
--8323329-1400128556-1606654349=:2671
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1400128556-1606654349=:2671--
