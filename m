Return-Path: <SRS0=m0DH=ZT=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7B4C432C0
	for <cocci@archiver.kernel.org>; Wed, 27 Nov 2019 06:01:10 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9954C20684
	for <cocci@archiver.kernel.org>; Wed, 27 Nov 2019 06:01:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9954C20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAR60qhJ025369;
	Wed, 27 Nov 2019 07:00:52 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3ECA377D2;
	Wed, 27 Nov 2019 07:00:52 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C9ADF7705
 for <cocci@systeme.lip6.fr>; Wed, 27 Nov 2019 07:00:50 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAR60oTO017221
 for <cocci@systeme.lip6.fr>; Wed, 27 Nov 2019 07:00:50 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.69,248,1571695200"; d="scan'208";a="413689341"
Received: from abo-228-123-68.mrs.modulonet.fr (HELO hadrien) ([85.68.123.228])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Nov 2019 07:00:50 +0100
Date: Wed, 27 Nov 2019 07:00:49 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: David Frey <dpfrey@gmail.com>
In-Reply-To: <ce221377-e841-aef4-720d-0ea5a51102c6@gmail.com>
Message-ID: <alpine.DEB.2.21.1911270659540.2670@hadrien>
References: <c156dbfc-8c3d-4750-fa90-2bbd11060130@gmail.com>
 <alpine.DEB.2.21.1911252208260.2656@hadrien>
 <ce221377-e841-aef4-720d-0ea5a51102c6@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 27 Nov 2019 07:00:52 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 27 Nov 2019 07:00:50 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Problem writing simple patch
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



--- Please note the new email address ---


On Tue, 26 Nov 2019, David Frey wrote:

> On 11/25/2019 1:10 PM, Julia Lawall wrote:
> > On Mon, 25 Nov 2019, David Frey wrote:
> >
> >> Hi,
> >>
> >> I'm trying to write a .cocci file to transform all calls to a function
> >> "f(ex)" to something like this:
> >>
> >> #ifdef USE_F
> >> f(ex)
> >> #else
> >> g(ex)
> >> #endif
> >>
> >> The function has this signature:
> >> bool f(int x);
> >>
> >> This is the patch that I tried to use:
> >> @@
> >> expression ex;
> >> @@
> >> +#ifdef USE_F
> >>  f(ex)
> >> +#else
> >> +g(ex)
> >> +#endif
> >>
> >>
> >> This is the result of running it:
> >> $ spatch --show-c --sp-file test.cocci test.c
> >> init_defs_builtins: /usr/bin/../lib/coccinelle/standard.h
> >> plus: parse error:
> >>   File "test.cocci", line 7, column 1, charpos = 50
> >>   around = 'g',
> >>   whole content = +g(ex)
> >>
> >> What is wrong with the patch above?
> >
> > Coccinelle doesn't currently support adding ifdefs on expressions, only on
> > statements.
> >
> > You could try for some typical usage contexts, like
> >
> > +ifdef...
> > x = f(ex);
> > +#else
> > +x = g(ex);
> > +#endif
> >
> > julia
> >
>
>
> Hi Julia,
>
> Thanks for your explanation and your suggestion.  I ended up creating a
> new header that was like this:
>
> #ifdef SOMETHING
> #define foo_backport_x(_arg) bar_x(_arg)
> #define foo_backport_y(_arg) bar_y(_arg)
> #else
> #define foo_backport_x(_arg) foo_x(_arg)
> #define foo_backport_y(_arg) foo_y(_arg)
> #endif
>
> and then I defined coccinelle rules to change:
> foo_x -> foo_backport_x
> foo_y -> foo_backport_y
>
> It's not the most elegant solution, but it works.

Persoally, I would find lots of ifdefs around expressions in the code
rather ugly too, so I'm not sure that it is such a bad solution, although
the name is not pretty...

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
