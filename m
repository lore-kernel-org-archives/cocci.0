Return-Path: <SRS0=cjTc=E2=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AD3C5519F
	for <cocci@archiver.kernel.org>; Fri, 20 Nov 2020 10:47:44 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FBAB2078B
	for <cocci@archiver.kernel.org>; Fri, 20 Nov 2020 10:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FBAB2078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0AKAlJ2t018737;
	Fri, 20 Nov 2020 11:47:19 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4E4A97789;
	Fri, 20 Nov 2020 11:47:19 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id EF1FE7B6
 for <cocci@systeme.lip6.fr>; Fri, 20 Nov 2020 11:47:16 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0AKAlGkC013084
 for <cocci@systeme.lip6.fr>; Fri, 20 Nov 2020 11:47:16 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.78,356,1599516000"; d="scan'208";a="365143387"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 20 Nov 2020 11:47:15 +0100
Date: Fri, 20 Nov 2020 11:47:15 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Joe Perches <joe@perches.com>
In-Reply-To: <b74517242de5790f8ab0cd9be00a70b9ab96564c.camel@perches.com>
Message-ID: <alpine.DEB.2.22.394.2011201140480.2750@hadrien>
References: <CA+U=Dspy5+RE9agcLr6eY9DCMa1c5+++0JLeugMMBRXz4YLj1w@mail.gmail.com>
 <CAHp75VcT5hZH6m0Dri1h_EFjc7=4+1XoE7sRuQyfO75k9A0GKA@mail.gmail.com>
 <b74517242de5790f8ab0cd9be00a70b9ab96564c.camel@perches.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 20 Nov 2020 11:47:19 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 20 Nov 2020 11:47:16 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: LKML <linux-kernel@vger.kernel.org>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Robo Bot <apw@canonical.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        cocci <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Proposal for a new checkpatch check;
 matching _set_drvdata() & _get_drvdata()
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



On Thu, 19 Nov 2020, Joe Perches wrote:

> On Thu, 2020-11-19 at 17:16 +0200, Andy Shevchenko wrote:
> > On Thu, Nov 19, 2020 at 4:09 PM Alexandru Ardelean
> > <ardeleanalex@gmail.com> wrote:
> > >
> > > Hey,
> > >
> > > So, I stumbled on a new check that could be added to checkpatch.
> > > Since it's in Perl, I'm reluctant to try it.
> > >
> > > Seems many drivers got to a point where they now call (let's say)
> > > spi_set_drvdata(), but never access that information via
> > > spi_get_drvdata().
> > > Reasons for this seem to be:
> > > 1. They got converted to device-managed functions and there is no
> > > longer a remove hook to require the _get_drvdata() access
> > > 2. They look like they were copied from a driver that had a
> > > _set_drvdata() and when the code got finalized, the _set_drvdata() was
> > > omitted
> > >
> > > There are a few false positives that I can notice at a quick look,
> > > like the data being set via some xxx_set_drvdata() and retrieved via a
> > > dev_get_drvdata().
> >
> > I can say quite a few. And this makes a difference.
> > So, basically all drivers that are using PM callbacks would rather use
> > dev_get_drvdata() rather than bus specific.
> >
> > > I think checkpatch reporting these as well would be acceptable simply
> > > from a reviewability perspective.
> > >
> > > I did a shell script to quickly check these. See below.
> > > It's pretty badly written but it is enough for me to gather a list.
> > > And I wrote it in 5 minutes :P
> > > I initially noticed this in some IIO drivers, and then I suspected
> > > that this may be more widespread.
> >
> > It seems more suitable for coccinelle.
>
> To me as well.

To me as well, since it seems to involve nonlocal information.

I'm not sure to understand the original shell script. Is there
something interesting about pci_set_drvdata?

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
