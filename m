Return-Path: <SRS0=ECaW=GD=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3531C433E0
	for <cocci@archiver.kernel.org>; Thu, 31 Dec 2020 20:49:47 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 186C6207A3
	for <cocci@archiver.kernel.org>; Thu, 31 Dec 2020 20:49:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 186C6207A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0BVKnPWt013615;
	Thu, 31 Dec 2020 21:49:25 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 39F393A53;
	Thu, 31 Dec 2020 21:49:25 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9F499373F
 for <cocci@systeme.lip6.fr>; Thu, 31 Dec 2020 21:49:23 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0BVKnN7f013408
 for <cocci@systeme.lip6.fr>; Thu, 31 Dec 2020 21:49:23 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.78,464,1599516000"; d="scan'208";a="484981279"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 31 Dec 2020 21:49:22 +0100
Date: Thu, 31 Dec 2020 21:49:22 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Joe Perches <joe@perches.com>
In-Reply-To: <eaa30016de67722c9595c3233b32b94474280a0a.camel@perches.com>
Message-ID: <alpine.DEB.2.22.394.2012312147060.20387@hadrien>
References: <58a84d03b714f71d231f9cac04af09a6b97c6f04.camel@perches.com>
 <cc5722eb472a0a94f3418f6081b10f3c4a7e156d.camel@perches.com>
 <alpine.DEB.2.22.394.2012312124290.20387@hadrien>
 <eaa30016de67722c9595c3233b32b94474280a0a.camel@perches.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 31 Dec 2020 21:49:25 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 31 Dec 2020 21:49:23 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] cocci: missed strlcpy->strscpy conversion?
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



On Thu, 31 Dec 2020, Joe Perches wrote:

> On Thu, 2020-12-31 at 21:27 +0100, Julia Lawall wrote:
> > On Thu, 31 Dec 2020, Joe Perches wrote:
> > > On Thu, 2020-12-31 at 11:04 -0800, Joe Perches wrote:
> > > > strlcpy is deprecated.  see: Documentation/process/deprecated.rst
> > > >
> > > > Change the calls that do not use the strlcpy return value to the
> > > > preferred strscpy.
> > > >
> > > > Done with cocci script:
> > > >
> > > > @@
> > > > expression e1, e2, e3;
> > > > @@
> > > >
> > > > -	strlcpy(
> > > > +	strscpy(
> > > > 	e1, e2, e3);
> > > >
> > > > This cocci script leaves the instances where the return value is
> > > > used unchanged.
> > >
> > > Hey Julia.
> > >
> > > After using the cocci script above on a test treewide conversion,
> > > there were a few instances with no return use that were not converted.
> > >
> > > Any idea why these were not converted?
> []
> > The parse is not happy about the for_each_possible_cpu.  It seems that the
> > heuristic for detecting that as a loop expects that the body of the loop
> > will have braces.  You can see this with the --parse-c option, ie
> >
> > spatch --parse-c drivers/block/rnbd/rnbd-clt.c
> >
> > The offending line will have BAD in front of it.
>
> Thanks.
>
> Do you consider the for_each heuristic a defect? (I'm not sure I do)

It could be improved.  I was wondering if the indentation was not correct.
If there was a space in the line with the for_each, then the two lines
would be equally indented, which would certainly confuse the heuristics.
But that is not the case; the indentation is fine.

And the file contains a previous for_each_possible_cpu that has braces, so
it should have taken note of that and detected that the next one should
also be a loop.

>
> I hope it's time for you to stop working today...
>
> cheers and happy new year,  Joe

Thanks!  Happy new year :)

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
