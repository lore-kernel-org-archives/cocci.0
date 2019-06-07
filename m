Return-Path: <SRS0=qtAw=UG=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C9CC2BCA1
	for <cocci@archiver.kernel.org>; Fri,  7 Jun 2019 12:30:48 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2054212F5
	for <cocci@archiver.kernel.org>; Fri,  7 Jun 2019 12:30:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2054212F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x57CUaEJ000887;
	Fri, 7 Jun 2019 14:30:36 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 57D6F7770;
	Fri,  7 Jun 2019 14:30:36 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7F4B2776C
 for <cocci@systeme.lip6.fr>; Fri,  7 Jun 2019 14:30:35 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x57CUZsu010864
 for <cocci@systeme.lip6.fr>; Fri, 7 Jun 2019 14:30:35 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.63,563,1557180000"; d="scan'208";a="386464837"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 Jun 2019 14:30:34 +0200
Date: Fri, 7 Jun 2019 14:30:33 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
In-Reply-To: <a2d09fdf-456d-e6ae-1dae-b24b9f683d57@metux.net>
Message-ID: <alpine.DEB.2.20.1906071427420.3692@hadrien>
References: <alpine.DEB.2.21.1906060743270.2653@hadrien>
 <5be7081a-8c90-ed59-34da-21c523580aa7@web.de>
 <alpine.DEB.2.20.1906061233360.21477@hadrien>
 <a2d09fdf-456d-e6ae-1dae-b24b9f683d57@metux.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 07 Jun 2019 14:30:36 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Fri, 07 Jun 2019 14:30:35 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Markus Elfring <Markus.Elfring@web.de>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] How to replace obsolete #ifdef's?
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



On Fri, 7 Jun 2019, Enrico Weigelt, metux IT consult wrote:

> On 06.06.19 12:34, Julia Lawall wrote:
> >
> >
> > On Thu, 6 Jun 2019, Markus Elfring wrote:
> >
> >>> #ifdefs are comments.
> >>
> >> I wonder about this wording.
> >
> > Ifdefs are parsed as comments.
>
> Any chance that it gets extended to understand at least such rather
> simple cases ?

Maybe it's possible.  A complexity is that structure field initializers
are considered to be unordered.  Ie if you put

- .a = e1,
- .b = e2,

it will also match a structure declaration in which there is

.b = 3,
.a = 4,

But it would have to detect that the ifdefs and endif are attached to
something specific.

Getting the newlines to work when removing and adding back the
initializers is more likely to work in the short term.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
