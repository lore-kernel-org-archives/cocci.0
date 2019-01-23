Return-Path: <SRS0=BkxN=P7=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7934FC282C0
	for <cocci@archiver.kernel.org>; Wed, 23 Jan 2019 14:41:44 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0421B217D4
	for <cocci@archiver.kernel.org>; Wed, 23 Jan 2019 14:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0421B217D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x0NEfU7Z021277
          ; Wed, 23 Jan 2019 15:41:30 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4B16C76E9;
	Wed, 23 Jan 2019 15:41:30 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 11ADD76E3
 for <cocci@systeme.lip6.fr>; Wed, 23 Jan 2019 15:41:29 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x0NEfSjV011458
 for <cocci@systeme.lip6.fr>; Wed, 23 Jan 2019 15:41:28 +0100 (CET)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.56,511,1539640800"; d="scan'208";a="293036682"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 23 Jan 2019 15:41:27 +0100
Date: Wed, 23 Jan 2019 15:41:24 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <f2ce5bb5-0956-2ee7-4165-ebcbbedd9020@roeck-us.net>
Message-ID: <alpine.DEB.2.20.1901231540410.3584@hadrien>
References: <405551ab-2417-dc55-f429-421ae79a5d06@roeck-us.net>
 <alpine.DEB.2.21.1901230731450.2762@hadrien>
 <f2ce5bb5-0956-2ee7-4165-ebcbbedd9020@roeck-us.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 23 Jan 2019 15:41:30 +0100 (CET)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Wed, 23 Jan 2019 15:41:28 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] matching concatenated preprocessor tokens
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



On Wed, 23 Jan 2019, Guenter Roeck wrote:

> Hi Julia,
>
> On 1/22/19 10:35 PM, Julia Lawall wrote:
> >
> >
> > On Tue, 22 Jan 2019, Guenter Roeck wrote:
> >
> > > Hi,
> > >
> > > I am trying to match a construct such as
> > >
> > > #define func(a,b,c) \
> > >      some_call(a##b, c, NULL)
> > >
> > > to replace it with, for example,
> > >
> > > #define func(a,b,c) \
> > >     some_other_call(a##b, c)
> > >
> > > Is this possible with coccinelle ?
> > > I tried several variants, but I don't seem to be able to match "a##b".
> >
> > I doubt that ## is supported in the matching language.  I will add it.
> >
>
> All I was able to find about the subject was in the Coccinelle change log:
>
> 20.4 Internals:
> "reorganize the way we parse C identifiers, especially concatenated cpp
>  identifiers as in a##b. This may lead to some regressions as we may not
>  parse as much code as before."

Yeah, it's supported on the C side, but not on the pattern matching side.
I'm working on that.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
