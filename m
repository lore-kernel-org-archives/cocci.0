Return-Path: <SRS0=WeMo=3E=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371A1C33CB1
	for <cocci@archiver.kernel.org>; Wed, 15 Jan 2020 16:01:21 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B99F22187F
	for <cocci@archiver.kernel.org>; Wed, 15 Jan 2020 16:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B99F22187F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00FG0xAg001705;
	Wed, 15 Jan 2020 17:00:59 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 86F2477F5;
	Wed, 15 Jan 2020 17:00:59 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 99D2E77E3
 for <cocci@systeme.lip6.fr>; Wed, 15 Jan 2020 17:00:57 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00FG0p1D024815
 for <cocci@systeme.lip6.fr>; Wed, 15 Jan 2020 17:00:51 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.70,323,1574118000"; d="scan'208";a="431529079"
Received: from roc040r.vpn.inria.fr ([128.93.183.40])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 15 Jan 2020 17:00:51 +0100
Date: Wed, 15 Jan 2020 17:00:51 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: Oleg Nesterov <oleg@redhat.com>
In-Reply-To: <20200115155902.GA8632@redhat.com>
Message-ID: <alpine.DEB.2.21.2001151700090.5079@hadrien>
References: <20200115112540.GA18161@redhat.com>
 <alpine.DEB.2.21.2001151308380.5079@hadrien>
 <20200115153035.GA9172@redhat.com>
 <alpine.DEB.2.21.2001151641200.5079@hadrien>
 <20200115155902.GA8632@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 15 Jan 2020 17:00:59 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 15 Jan 2020 17:00:51 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Q: does spatch understand typeof?
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



On Wed, 15 Jan 2020, Oleg Nesterov wrote:

> On 01/15, Julia Lawall wrote:
> >
> > On Wed, 15 Jan 2020, Oleg Nesterov wrote:
> >
> > > $ spatch --sp-file test.cocci test.c
> > >
> > > 	(ONCE) Expected tokens mem TTT
> > > 	Skipping: test.c
> > >
> > > I tried to play with various --.*include.* options, but nothing seems to work
> > > unless I add "inc.h" to the command line explicitly.
> >
> > The problem is that the file filtering happens before the parsing, and it
> > is the parsing that finds the includes.
>
> Yes, thanks, this was clear to me,
>
> > You can disable the file
> > filtering with --disable-worth-trying-opt.
>
> Heh. I swear, I even did
>
> 	$ spatch --longhelp 2>&1 | grep disable
>
> but apparently I can't read.

The name is not super intuitive, and is more tied to the code than the
user intuition.  I spent some time searching for -no- and for something
about files.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
