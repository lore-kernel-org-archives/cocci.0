Return-Path: <SRS0=mKsa=TZ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3EEC282CE
	for <cocci@archiver.kernel.org>; Sat, 25 May 2019 13:41:20 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF39820862
	for <cocci@archiver.kernel.org>; Sat, 25 May 2019 13:41:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF39820862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4PDf4jh006750;
	Sat, 25 May 2019 15:41:04 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8F0AE7752;
	Sat, 25 May 2019 15:41:04 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id CFC5A774C
 for <cocci@systeme.lip6.fr>; Sat, 25 May 2019 15:41:02 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4PDf19r011411
 for <cocci@systeme.lip6.fr>; Sat, 25 May 2019 15:41:01 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.60,511,1549926000"; d="scan'208";a="307195885"
Received: from smb-adpcdg1-02.hotspot.hub-one.net (HELO hadrien)
 ([213.174.99.130])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 May 2019 15:41:01 +0200
Date: Sat, 25 May 2019 15:41:00 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <14711fc9-6071-3f3b-9f99-1b0f56c2b4d6@web.de>
Message-ID: <alpine.DEB.2.21.1905251538500.2799@hadrien>
References: <alpine.DEB.2.21.1905222114490.2618@hadrien>
 <81b409c6-5986-5961-5edf-843c6737d88c@web.de>
 <alpine.DEB.2.20.1905231500230.3573@hadrien>
 <b5c322d3-3162-953f-a985-53abc5064482@web.de>
 <0782D580-3DD6-4419-B5E1-C04215FB2E3B@lip6.fr>
 <bcc5a120-dc66-7511-a401-e14c322dd67b@web.de>
 <4FE72A81-9D85-4786-898C-A84E2AC5B520@lip6.fr>
 <14711fc9-6071-3f3b-9f99-1b0f56c2b4d6@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-309149042-1558791661=:2799"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 25 May 2019 15:41:04 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Sat, 25 May 2019 15:41:01 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] accessing comments
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

--8323329-309149042-1558791661=:2799
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sat, 25 May 2019, Markus Elfring wrote:

> > There is one in an argument list that is within a statement.
>
> This would only matter for the second call of the function “foo”
> in the example function “main”, wouldn't it?
> https://github.com/coccinelle/coccinelle/blob/210ce894d2dd1572fff9e1c98ae443e6df14f4c7/demos/comments.c#L2
>
>
> How does your software decide which comment should be treated
> as simple text before or after an item?

It takes all of the comments before (up to the preceding non comment
token if any) within and after (up to the following non comment token if
any).

I'm not sure what happens at the end of a function.  I suspect that the
end of a function is the end.  The comments that are before the start of
the next function are not considered to be after the function that
precedes them.

julia
--8323329-309149042-1558791661=:2799
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-309149042-1558791661=:2799--
