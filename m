Return-Path: <SRS0=v8PH=77=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34272C433DF
	for <cocci@archiver.kernel.org>; Thu, 18 Jun 2020 06:00:06 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8610E21655
	for <cocci@archiver.kernel.org>; Thu, 18 Jun 2020 06:00:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8610E21655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05I5xnHg017983;
	Thu, 18 Jun 2020 07:59:49 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1706E7577;
	Thu, 18 Jun 2020 07:59:49 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id EF81A402B
 for <cocci@systeme.lip6.fr>; Thu, 18 Jun 2020 07:59:46 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05I5xkdA015649
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 18 Jun 2020 07:59:46 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.73,525,1583190000"; d="scan'208";a="351937037"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Jun 2020 07:59:45 +0200
Date: Thu, 18 Jun 2020 07:59:45 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <dfd11c78ef60afd3dd45097e9bf738499f608867.camel@sipsolutions.net>
Message-ID: <alpine.DEB.2.22.394.2006180758241.2391@hadrien>
References: <812b3a31097815244e0f929552819ac1f119f5a0.camel@sipsolutions.net>
 <alpine.DEB.2.22.394.2006172314450.3083@hadrien>
 <dfd11c78ef60afd3dd45097e9bf738499f608867.camel@sipsolutions.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 18 Jun 2020 07:59:49 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 18 Jun 2020 07:59:46 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] moving variable declarations up
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



On Wed, 17 Jun 2020, Johannes Berg wrote:

> On Wed, 2020-06-17 at 23:15 +0200, Julia Lawall wrote:
> >
> > > +T x;
> >
> > Change the + to ++
>
> Hah, I think you mentioned that to me before, but I can never remember
> what it does ...
>
> > There is no guarantee on the order in which the variables will appear.
>
> That's ok, I don't really care :)
>
> > > +
> > >  E;
> > > ...
> >
> > Add when any after the ...
>
> What's the difference between "..." and "... when any"?

A ... B connects an A to the closest B, as you might like in some code
with lots of locks and unlocks.  When any picks up any subsequent B, even
if there is another B between the matched A and B.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
