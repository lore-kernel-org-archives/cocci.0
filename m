Return-Path: <SRS0=yQhI=R6=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67096C43381
	for <cocci@archiver.kernel.org>; Wed, 27 Mar 2019 10:30:25 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E497A2075C
	for <cocci@archiver.kernel.org>; Wed, 27 Mar 2019 10:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E497A2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2RAUCYv026769
          ; Wed, 27 Mar 2019 11:30:12 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 68D6C7663;
	Wed, 27 Mar 2019 11:30:12 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A57FA3B64
 for <cocci@systeme.lip6.fr>; Wed, 27 Mar 2019 11:30:10 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2RAU9jF012846
 for <cocci@systeme.lip6.fr>; Wed, 27 Mar 2019 11:30:09 +0100 (CET)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.60,276,1549926000"; d="scan'208";a="300877815"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Mar 2019 11:30:09 +0100
Date: Wed, 27 Mar 2019 11:30:06 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Michael Stefaniuc <mstefani@mykolab.com>
In-Reply-To: <b4e082410353f7abda6a777cde0583ad@mykolab.com>
Message-ID: <alpine.DEB.2.20.1903271129350.4827@hadrien>
References: <51927c57-784e-6154-7032-0a4a266ac6f0@mykolab.com>
 <alpine.DEB.2.21.1903270826060.2461@hadrien>
 <b4e082410353f7abda6a777cde0583ad@mykolab.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 27 Mar 2019 11:30:12 +0100 (CET)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Wed, 27 Mar 2019 11:30:09 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Capturing all array initializers?
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



On Wed, 27 Mar 2019, Michael Stefaniuc wrote:

> On 2019-03-27 08:26, Julia Lawall wrote:
> > On Wed, 27 Mar 2019, Michael Stefaniuc wrote:
> >
> > > Hello,
> > >
> > > I'm trying to do this transformation,
> > > from:
> > >     const WCHAR wstr[] = {'u','t','f','1','6','
> > > ','s','t','r','i','n','g','\0'};
> > > to:
> > >     const WCHAR wstr[] = u"utf16 string";
> > >
> > > I had hoped to be able to use an expression list for the array
> > > initializer, but that produces a parse error. I know that technically an
> > > array initializer is not an expression list, but it looks like one.
> > > Is there another metavariable that I can use instead?
> >
> > I think that there is initializer list?
> Indeed there is, thanks!
>
> But 'initializer' is totally missing from
> http://coccinelle.lip6.fr/docs/main_grammar002.html , there's where I have
> looked for it.

OK, thanks for the feedback.  It was a later addition...  I will update
it.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
