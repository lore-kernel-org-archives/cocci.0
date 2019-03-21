Return-Path: <SRS0=Ea+1=RY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C34AC43381
	for <cocci@archiver.kernel.org>; Thu, 21 Mar 2019 20:23:13 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1110218D3
	for <cocci@archiver.kernel.org>; Thu, 21 Mar 2019 20:23:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1110218D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2LKMwvZ010315
          ; Thu, 21 Mar 2019 21:22:58 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4A4047724;
	Thu, 21 Mar 2019 21:22:58 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 84525771B
 for <cocci@systeme.lip6.fr>; Thu, 21 Mar 2019 21:22:56 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2LKMt5n025373
 for <cocci@systeme.lip6.fr>; Thu, 21 Mar 2019 21:22:55 +0100 (CET)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.60,254,1549926000"; d="scan'208";a="375167910"
Received: from abo-58-107-68.mrs.modulonet.fr (HELO hadrien) ([85.68.107.58])
 by mail2-relais-roc.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 21:22:55 +0100
Date: Thu, 21 Mar 2019 21:22:55 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <8ec4ef8bd54fd9067d95685a708414ef3cf8c594.camel@sipsolutions.net>
Message-ID: <alpine.DEB.2.21.1903212121460.4720@hadrien>
References: <fa68a6e4e3047058d9f0dfc572cf5fbbe7f07367.camel@sipsolutions.net>
 <alpine.DEB.2.20.1903211439590.4279@hadrien>
 <df8e76baa2c2d7b5f483a27b23d1ff5b0dee54c0.camel@sipsolutions.net>
 <alpine.DEB.2.21.1903212033190.2491@hadrien>
 <8ec4ef8bd54fd9067d95685a708414ef3cf8c594.camel@sipsolutions.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 21 Mar 2019 21:22:58 +0100 (CET)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Thu, 21 Mar 2019 21:22:55 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] modifying C99 initializers?
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



On Thu, 21 Mar 2019, Johannes Berg wrote:

> On Thu, 2019-03-21 at 20:33 +0100, Julia Lawall wrote:
> >
> > On Thu, 21 Mar 2019, Johannes Berg wrote:
> >
> > > On Thu, 2019-03-21 at 14:40 +0100, Julia Lawall wrote:
> > > >
> > > > > @@
> > > > > identifier list;
> > > > > @@
> > > > > struct my_struct list[] = {
> > > > > <...
> > > > >  {
> > > > > +       .field = 27,
> > > > >  },
> > > > > ...>
> > > > > };
> > > > Try without the <... ...>.
> > >
> > > I did :-)
> > >
> > > If I just remove the <... ...> then it only changes an array that has a
> > > single entry. If I add ... at the end, it only changes the first entry.
> >
> > OK, how about ... before and after?
>
> Huh. I was going to say I tried this, but apparently I didn't since it
> actually works!

If it is .x = e, I think it would have worked without any kind of ... at
all.  But array elements are ordered, so the ... are needed.  The pattern
matches multiple times, one time for each array element.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
