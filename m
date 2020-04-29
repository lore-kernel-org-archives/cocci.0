Return-Path: <SRS0=9rx2=6N=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D132C83000
	for <cocci@archiver.kernel.org>; Wed, 29 Apr 2020 15:26:14 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A11F521D79
	for <cocci@archiver.kernel.org>; Wed, 29 Apr 2020 15:26:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A11F521D79
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03TFQ2vL024922;
	Wed, 29 Apr 2020 17:26:02 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E80FD7816;
	Wed, 29 Apr 2020 17:26:01 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9933D7807
 for <cocci@systeme.lip6.fr>; Wed, 29 Apr 2020 17:26:00 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03TFQ0PN016751
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Wed, 29 Apr 2020 17:26:00 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.73,332,1583190000"; d="scan'208";a="447492191"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Apr 2020 17:25:59 +0200
Date: Wed, 29 Apr 2020 17:25:59 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Paul Chaignon <paul@cilium.io>
In-Reply-To: <20200429151608.GA5703@Mem>
Message-ID: <alpine.DEB.2.21.2004291725160.2450@hadrien>
References: <20200429143926.GA24738@Mem>
 <alpine.DEB.2.21.2004291704240.2450@hadrien> <20200429151608.GA5703@Mem>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 29 Apr 2020 17:26:02 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 29 Apr 2020 17:26:00 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Exit with non-zero status
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



On Wed, 29 Apr 2020, Paul Chaignon wrote:

> On Wed, Apr 29, 2020 at 05:07:56PM +0200, Julia Lawall wrote:
> >
> >
> > On Wed, 29 Apr 2020, Paul Chaignon wrote:
> >
> > > Hi everyone,
> > >
> > > I am trying to exit spatch with a non-zero exit status when required
> > > changes have been found. I have tried to add a rule with finalize:python
> > > and the following code:
> > >
> > >   @finalize:python@
> > >   @@
> > >   exit(cnt)
> > >
> > > where cnt is incremented by another Python rule everytime a required
> > > change is found. This works as expected except for the --in-place option
> > > which becomes ineffective.
> > >
> > > Is this a bug, or is finalize:python not intended to be used in that
> > > manner? Is it possible to overwrite spatch's exit status?
> >
> > I'm actually surprised that this would ever work...
> >
> > Finalize was intended for processing information in general, eg printing
> > some statistics about what was matched.
> >
> > Would it be feasible to print cnt instead?
>
> Sure. I can easily get around this issue by e.g. grepping for spatch's
> messages in a wrapper script. Getting spatch to return a non-zero exit
> status is just a convenience. I thought that would be a fairly common
> use case.

I'll add it to the "list of features someone has asked for and might get
implemented some day in the future"...

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
