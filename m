Return-Path: <SRS0=eIV6=GP=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ABB6C433E0
	for <cocci@archiver.kernel.org>; Tue, 12 Jan 2021 17:07:09 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F5092311A
	for <cocci@archiver.kernel.org>; Tue, 12 Jan 2021 17:07:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F5092311A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 10CH6rvm028846;
	Tue, 12 Jan 2021 18:06:53 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 9D53E77B8;
	Tue, 12 Jan 2021 18:06:53 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9BBAE37BB
 for <cocci@systeme.lip6.fr>; Tue, 12 Jan 2021 18:06:52 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 10CH6qnC012967
 for <cocci@systeme.lip6.fr>; Tue, 12 Jan 2021 18:06:52 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.79,341,1602540000"; d="scan'208";a="486721239"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Jan 2021 18:06:52 +0100
Date: Tue, 12 Jan 2021 18:06:51 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Denis Efremov <efremov@linux.com>
In-Reply-To: <4e87794f-1e17-babb-54fe-f190df0b877c@linux.com>
Message-ID: <alpine.DEB.2.22.394.2101121806290.2766@hadrien>
References: <9bd6a75e-c595-a623-de09-04d261263167@linux.com>
 <alpine.DEB.2.22.394.2101121708580.2766@hadrien>
 <4e87794f-1e17-babb-54fe-f190df0b877c@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 12 Jan 2021 18:06:53 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 12 Jan 2021 18:06:52 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] How to match switch cases and their absence with
 coccinelle?
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



On Tue, 12 Jan 2021, Denis Efremov wrote:

>
>
> On 1/12/21 7:13 PM, Julia Lawall wrote:
> >
> >
> > On Tue, 12 Jan 2021, Denis Efremov wrote:
> >
> >> Hi,
> >>
> >> Let's suppose I have this pattern:
> >> @fix exists@
> >> position p;
> >> @@
> >>
> >> binder_release_work(...)
> >> {
> >> 	...
> >> 	switch (...) {
> >> *		case BINDER_WORK_NODE: ... break;@p
> >> 	}
> >> 	...
> >
> > Add when any to the outer ...s
>
> Thanks, this helped.
>
> >
> >> }
> >>
> >> and I want to match binder_release_work() function in drivers/android/binder.c
> >> file (linux kernel, master)
> >>
> >> Seems like the rule is not enough, it gives nothing:
> >> $ spatch --cocci-file binder.cocci drivers/android/binder.c
> >> init_defs_builtins: /usr/lib64/coccinelle/standard.h
> >> HANDLING: drivers/android/binder.c
> >>
> >> 1) What can I do to reliable check that there is a special case in a switch?
> >> 2) Is it possible to check that there is no case handling with something like:
> >> 	switch (...) {
> >> 		... when != case BINDER_WORK_NODE: ... break;
> >> 	}
> >
> > I don't know if that will work.  But you can do it with two rules.  In the
> > first rule, you could put a position variable on the switch, and then in
> > the second rule, you could make a position variable that is required to be
> > different than the first one, and that is also attached to a switch.
>
> Yes, I use this method currently.
>
> Also I faced the problem when I can't use ... in the beginning of enum, i.e.:
> struct binder_work {
>         ...
>         enum binder_work_type {
>                 ... // <== will not work

Probably the ... needs a comma.

julia

> *               BINDER_WORK_NODE,
>                 ...
>         } type;
> 	...
> }
>
> This works:
> struct binder_work {
>         ...
>         enum binder_work_type {
> 		// BINDER_WORK_TRANSACTION = ..., // also will not work
>                 BINDER_WORK_TRANSACTION = 1,
>                 BINDER_WORK_TRANSACTION_COMPLETE,
>                 BINDER_WORK_RETURN_ERROR,
> *               BINDER_WORK_NODE,
>                 ...
>         } type;
>         ...
> }
>
> Thanks,
> Denis
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
