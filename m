Return-Path: <SRS0=q5PQ=UV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D682C43613
	for <cocci@archiver.kernel.org>; Sat, 22 Jun 2019 13:58:59 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB22C20652
	for <cocci@archiver.kernel.org>; Sat, 22 Jun 2019 13:58:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB22C20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5MDwiQN020625;
	Sat, 22 Jun 2019 15:58:44 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1D9AD7779;
	Sat, 22 Jun 2019 15:58:44 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A89517770
 for <cocci@systeme.lip6.fr>; Sat, 22 Jun 2019 15:58:41 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5MDwfj3018875
 for <cocci@systeme.lip6.fr>; Sat, 22 Jun 2019 15:58:41 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.63,404,1557180000"; d="scan'208";a="311073795"
Received: from abo-12-105-68.mrs.modulonet.fr (HELO hadrien) ([85.68.105.12])
 by mail3-relais-sop.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2019 15:58:40 +0200
Date: Sat, 22 Jun 2019 15:58:40 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <4dfb9359-ab09-d206-3110-0fd177ba34b3@web.de>
Message-ID: <alpine.DEB.2.21.1906221555220.3253@hadrien>
References: <f1bb347b-7318-f69f-ad86-bd633c72b375@web.de>
 <alpine.DEB.2.21.1906212251430.2538@hadrien>
 <9d2ef926-62b9-d182-d6d6-cd82ca13173f@web.de>
 <alpine.DEB.2.21.1906221517080.3253@hadrien>
 <4dfb9359-ab09-d206-3110-0fd177ba34b3@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 22 Jun 2019 15:58:44 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Sat, 22 Jun 2019 15:58:41 +0200 (CEST)
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



On Sat, 22 Jun 2019, Markus Elfring wrote:

> > It could be helpful to replace the last line by:
> >
> > (
> >   e3 = <+...var...+>
>
> Can this SmPL specification make sense as another when constraint?

No.  When is about the code between the code that matches what is before
or after.  If you put when, you will get a false positives for var = var +
1.

>
>
> > |
> > * var = e3
> > )
> >
> > In that case, it would also be beneficial to remove the *
>
> I find the asterisk required here

Yu can do whatever you want, but you will get lotsof false positives if
you keep it.  If you really want a star on the declaration then you need
to make two rules.  The first that finds the positions of the places that
match and the second that only puts a * when there is both a matched
declaration and a matched reinitialization.  But I wold imagine that from
the reinitialization, it would be easy to find the declaration, so it
doesn't seem worth further complicating the rule.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
