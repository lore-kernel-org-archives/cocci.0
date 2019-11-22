Return-Path: <SRS0=0+7Q=ZO=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3579C432C0
	for <cocci@archiver.kernel.org>; Fri, 22 Nov 2019 15:10:46 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BED12071C
	for <cocci@archiver.kernel.org>; Fri, 22 Nov 2019 15:10:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BED12071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAMFAYlr009300;
	Fri, 22 Nov 2019 16:10:34 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 082AB77E3;
	Fri, 22 Nov 2019 16:10:34 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 00FB177D2
 for <cocci@systeme.lip6.fr>; Fri, 22 Nov 2019 16:10:32 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAMFAWIg008211
 for <cocci@systeme.lip6.fr>; Fri, 22 Nov 2019 16:10:32 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.69,230,1571695200"; d="scan'208";a="413073183"
Received: from portablejulia.rsr.lip6.fr ([132.227.76.63])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Nov 2019 16:10:32 +0100
Date: Fri, 22 Nov 2019 16:10:32 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: julia@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <87ef6d2d-a66c-5566-ee27-db360235c332@web.de>
Message-ID: <alpine.DEB.2.21.1911221609420.2793@hadrien>
References: <cc561358-4d00-9f1f-eaa2-8fae400ccc8b@web.de>
 <alpine.DEB.2.21.1911221025570.2793@hadrien>
 <8a44f286-72ad-14c4-6ee9-b8aa25ccba3e@web.de>
 <alpine.DEB.2.21.1911221050320.2793@hadrien>
 <46f7430f-8176-27ed-1150-af9fc69b03a7@web.de>
 <alpine.DEB.2.21.1911221134210.2793@hadrien>
 <da29f2ea-7037-3237-8ec5-4464379e7a54@web.de>
 <alpine.DEB.2.21.1911221155320.2793@hadrien>
 <599a5c47-75c5-f0a8-afe9-3563a20b70d3@web.de>
 <alpine.DEB.2.21.1911221351470.2793@hadrien>
 <87ef6d2d-a66c-5566-ee27-db360235c332@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-480775527-1574435433=:2793"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 22 Nov 2019 16:10:35 +0100 (CET)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Fri, 22 Nov 2019 16:10:32 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Concerns around type safety for usage of expressions
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

--8323329-480775527-1574435433=:2793
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Fri, 22 Nov 2019, Markus Elfring wrote:

> > T *ptr for example.
>
> 1. Does this information for a “type constraint” distract from my questions?
>
> 2. Can the data type become restricted not only by the detail
>    that it refers to a pointer?

You can put any type, such as int x;.  You can also put parts of types
such as expression * x; or struct x;

>
> 3. Why should such a SmPL specification matter for the handling of
> expressions?

Only expressions have types.

julia
--8323329-480775527-1574435433=:2793
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-480775527-1574435433=:2793--
