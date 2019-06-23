Return-Path: <SRS0=b71c=UW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3810C43613
	for <cocci@archiver.kernel.org>; Sun, 23 Jun 2019 13:13:38 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C8C020820
	for <cocci@archiver.kernel.org>; Sun, 23 Jun 2019 13:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C8C020820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5NDDOjY017536;
	Sun, 23 Jun 2019 15:13:24 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id EDAD9776C;
	Sun, 23 Jun 2019 15:13:23 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E6AA07761
 for <cocci@systeme.lip6.fr>; Sun, 23 Jun 2019 15:13:21 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5NDDKCT012296
 for <cocci@systeme.lip6.fr>; Sun, 23 Jun 2019 15:13:20 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.63,408,1557180000"; d="scan'208";a="388679180"
Received: from abo-12-105-68.mrs.modulonet.fr (HELO hadrien) ([85.68.105.12])
 by mail2-relais-roc.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jun 2019 15:13:20 +0200
Date: Sun, 23 Jun 2019 15:13:20 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <bf3a5ea0-3cda-4342-a6af-b27a4cc0295e@web.de>
Message-ID: <alpine.DEB.2.21.1906231511450.4961@hadrien>
References: <f1bb347b-7318-f69f-ad86-bd633c72b375@web.de>
 <alpine.DEB.2.21.1906212251430.2538@hadrien>
 <9d2ef926-62b9-d182-d6d6-cd82ca13173f@web.de>
 <alpine.DEB.2.21.1906221517080.3253@hadrien>
 <4dfb9359-ab09-d206-3110-0fd177ba34b3@web.de>
 <alpine.DEB.2.21.1906221555220.3253@hadrien>
 <5f436d79-b510-b0a3-d11a-d92b8d175f7f@web.de>
 <alpine.DEB.2.21.1906231454520.4961@hadrien>
 <bf3a5ea0-3cda-4342-a6af-b27a4cc0295e@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 23 Jun 2019 15:13:24 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Sun, 23 Jun 2019 15:13:20 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking redundant variable initialisations with SmPL?
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



On Sun, 23 Jun 2019, Markus Elfring wrote:

> > Try
> >
> > ... when any
> >
> > just before the final ).  In some circumstaces the parser doesn't accept
> > an expression at the end of a sequence like you have here.
>
> Thanks for your quick response.
>
> The addition of such a SmPL ellipsis helps somehow.
> But I am still not pleased with the generated transformation result.
> So I am curious on how this software clarification will evolve further.

I am not pleased is not especially descriptive.  If you have a question
about something, provide the semantic patch and the code on which you get
an undesired result.

I believe that you put a * on an assignment with var on the right hand
side, which at least doesn't correspond to my understanding of what you
are trying to do, so perhaps that is the problem.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
