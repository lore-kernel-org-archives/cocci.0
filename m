Return-Path: <SRS0=rw5r=IR=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C90C433C1
	for <cocci@archiver.kernel.org>; Fri, 19 Mar 2021 21:10:30 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91DB46196E
	for <cocci@archiver.kernel.org>; Fri, 19 Mar 2021 21:10:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91DB46196E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 12JLACnV009531;
	Fri, 19 Mar 2021 22:10:12 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4774677CD;
	Fri, 19 Mar 2021 22:10:12 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 007357610
 for <cocci@systeme.lip6.fr>; Fri, 19 Mar 2021 22:10:10 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 12JLA8Jf008700
 for <cocci@systeme.lip6.fr>; Fri, 19 Mar 2021 22:10:08 +0100 (CET)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ATx039qH+DsOWGoOHpLqFZZLXdLJzesId70hD?=
 =?us-ascii?q?6mlYUhZVctOVmoSHgZ0gpFLJoRwWX2wtns3FBbKJRmnS+YUwzY4aO7qjWweOgh?=
 =?us-ascii?q?rsEKhJ64z+zzr8XxDv7+I179YjT4FSAMD9ZGIK6PrSzxK/F78boeWv1aCzmKP3?=
 =?us-ascii?q?1H1tTR5nApsQoztRLwaADwlWSAxebKBJW6a0w8pcun6BdB0sH46GL1wERfWGnt?=
 =?us-ascii?q?vQifvdEFA7Ljsm8hTLty+i8rTgExOVty1uEg9n5Lc57Cz4lBbk7b+oqPGxxnbn?=
 =?us-ascii?q?pi/uxrB3vPek9ddZHsyLjaEuW3bRoyKlfp5oVbHHnB1wgem06T8R4avxijMtJd?=
 =?us-ascii?q?565X+UXmzdm2qO5yDHyzgn7H/wwUKZh3yLm6zEbQsgB8BMiI5feBex0TtogPhG?=
 =?us-ascii?q?3KhG332UuvNsZHuq9kmQiLb1fipnj0+l5Ucl+NRjx0B3a5cUa7NasOUkjQhoOa?=
 =?us-ascii?q?oHdRiKi7wPIa1LBMHYy+1RdTqhHgTkl1gq5NStW3A6GVO8Xk0P/uiUySJbhhlC?=
 =?us-ascii?q?vjwl7f1aun8B8ZY0TN166//fMqJu/Ys+OPM+XOZYCP0aScW6TkzhBTPFKmP6Gy?=
 =?us-ascii?q?WTKIg3f0jk77Ln4LFwzuesf5AD0d8Tof36ITRlnF93QWqrJdyP2Nlu+hDJBEqn?=
 =?us-ascii?q?WzCF8LA527FJ/ofVAJb7MSnGclonlMytrpwkc73mcsf2AroTL+7iKS/QFZ1S3w?=
 =?us-ascii?q?v4MqMiWEU2YYkuo94+H3iOrsjIJpavieDBavbUI9PWYE8Zc1K6OGIKWHzYIsFK?=
 =?us-ascii?q?6CmQKwPFqSmUYWrkfgjT17gYKtmmw8EjjLIVPokJlwQLhVHR3LDyFRRy9pYudE?=
 =?us-ascii?q?87G7/jmrP+j2+r+nvS/wxSS2VgJ3cQ2qzpVzdwqRYNKF6cS8d4h/yvPVpK1H/C?=
 =?us-ascii?q?HAJ2Ut/NeTQv3GhfyOaMNpSVgR0jD9KhPAuh/gUujUPPfrNZuqqJ49vjd/oDf+?=
 =?us-ascii?q?UbcZ00JCGOLSVb8DwazFt+VA=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.81,262,1610406000"; d="scan'208";a="498969822"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Mar 2021 22:10:08 +0100
Date: Fri, 19 Mar 2021 22:10:07 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Thomas Adam <thomas@xteddy.org>
In-Reply-To: <CAOhcEPZuVRGFXTHj+jw_o7EqK1=m0ZpN2-SvPK3sQkS+r4sGow@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2103192206510.2947@hadrien>
References: <CAOhcEPYTkAqYM4q4p6q=nvF3eS6QX_-ajRykn08YfnOK9+VHUg@mail.gmail.com>
 <alpine.DEB.2.22.394.2103182020110.2984@hadrien>
 <CAOhcEPZuVRGFXTHj+jw_o7EqK1=m0ZpN2-SvPK3sQkS+r4sGow@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 19 Mar 2021 22:10:12 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 19 Mar 2021 22:10:08 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Removing the last return statement from a void function
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



On Fri, 19 Mar 2021, Thomas Adam wrote:

> On Thu, 18 Mar 2021 at 19:24, Julia Lawall <julia.lawall@inria.fr> wrote:
>
> > The ... in Coccinelle is based on control flow, so it is a bit hard to
> > find the return at the bottom of the function.  Actually, from
> > Coccinelle's point of view, all returns are at the bottom of the function,
> > because one leaves the function after a return.
>
> Interesting, that helps me understand a little more about Coccinelle.  Thanks.
>
> > You can try the following:
> >
> > @r@
> > position p;
> > identifier f;
> > }
> >
> > f(...) {
> > <...
> > { .. return@p; }
> > ...>
> > }
> >
> > @@
> > position p != r.p;
> > @@
> >
> > - return@p;
>
> So I tried this:
>
> @r@
> position p;
> identifier f;
> @@
>
> f(...) {
> <...
>    { ... return@p; }
> ...>
> }
>
> @@
> position p != r.p;
> @@
>
> - return@p;
>
> Which I ran as:
>
> spatch --in-place --debug --iso-file contrib/coccinelle/empty.iso \
>     --sp-file ./contrib/coccinelle/remove-void-return.cocci --dir fvwm
>
> With "--dir fvwm", I found that my CPU was being chewed at 100%, which I left
> running overnight.  Some 8 hours later, spatch was still running.  Presumably,
> Coccinelle is having an interesting time coordinating the positions?
>
> Instead, I decided to loop over the .c files which "--dir fvwm" would have
> done.  What I found was that for some files, spatch took a few seconds, and
> produced no output, yet for some, spatch was still running without any result
> known (so I killed it).
>
> Indeed, I'm attaching a debug run of spatch to this email (cocci-debug) for
> one file that definitely has functions where I would expect Coccinelle to have
> matched a "return;" statement to be removed, but this wasn't the case.
>
> Would you be able to suggest what I might have done wrong, or if there's any
> additional debugging I can provide?

If Coccinelle gets stuck on one part of a file, it won't move on to the
next part.  So the fact that the something should have been done in the
file is not really helpful.

You can use the argument --show-trying to see what function it is working
on at the moment.

You can use --timeout N to limit the treatment of a given file to N
seconds.

It may help to replace @r@ by @r exists@.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
