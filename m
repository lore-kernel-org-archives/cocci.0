Return-Path: <SRS0=EuJX=WI=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3DEC31E40
	for <cocci@archiver.kernel.org>; Mon, 12 Aug 2019 10:26:10 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F0E720842
	for <cocci@archiver.kernel.org>; Mon, 12 Aug 2019 10:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F0E720842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7CAPrA8013234;
	Mon, 12 Aug 2019 12:25:53 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E278E7778;
	Mon, 12 Aug 2019 12:25:52 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id CFB0A76C5
 for <cocci@systeme.lip6.fr>; Mon, 12 Aug 2019 12:25:46 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7CAPkFR003365
 for <cocci@systeme.lip6.fr>; Mon, 12 Aug 2019 12:25:46 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.64,377,1559512800"; d="scan'208";a="316182877"
Received: from portablejulia.rsr.lip6.fr ([132.227.76.63])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Aug 2019 12:25:45 +0200
Date: Mon, 12 Aug 2019 12:25:45 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: julia@hadrien
To: Alexander Popov <alex.popov@linux.com>
In-Reply-To: <3ee24295-6d63-6da9-774f-f1a599418685@linux.com>
Message-ID: <alpine.DEB.2.21.1908121210570.3718@hadrien>
References: <20190326220348.61172-1-jannh@google.com>
 <9ced7a06-5048-ad1a-3428-c8f943f7469c@linux.com>
 <alpine.DEB.2.21.1908091555090.2946@hadrien>
 <3ee24295-6d63-6da9-774f-f1a599418685@linux.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 12 Aug 2019 12:25:58 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Mon, 12 Aug 2019 12:25:46 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Jens Axboe <axboe@kernel.dk>, Michal Marek <michal.lkml@markovi.net>,
        Jann Horn <jannh@google.com>, Mukesh Ojha <mojha@codeaurora.org>,
        Jiri Kosina <jikos@kernel.org>, Nicolas Palix <nicolas.palix@imag.fr>,
        linux-kernel@vger.kernel.org, Denis Efremov <efremov@linux.com>,
        linux-block@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] floppy: fix usercopy direction
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


On Fri, 9 Aug 2019, Alexander Popov wrote:

> On 09.08.2019 16:56, Julia Lawall wrote:
> > On Fri, 9 Aug 2019, Alexander Popov wrote:
> >> On 27.03.2019 1:03, Jann Horn wrote:
> >>> As sparse points out, these two copy_from_user() should actually be
> >>> copy_to_user().
> >>
> >> I also wrote a coccinelle rule for detecting similar bugs (adding coccinelle
> >> experts to CC).
> >>
> >>
> >> virtual report
> >>
> >> @cfu@
> >
> > You can replace the above line with @cfu exists@.  You want to find the
> > existence of such a call, not ensure that the call occurs on every
> > control-flow path, which is the default.
>
> Thanks Julia, I see `exists` allows to drop `<+ +>`, right?

Exists is more efficient when it is possible.  It just finds the existence
of a path that has the property rather than collecting information about
all paths.  It is related to <+... ...+> because for that there has to
exist at least one match.  You could probably do something like

... when any
copy_from_user
... when any

Then with exists you will consider each call one at a time.

>
> > Do you want this rule to go into the kernel?
>
> It turned out that sparse already can find these bugs.

If sparse is already doing this, then perhaps that's sufficient.  Someone
just has to be running it :)

julia

> Is this rule useful anyway? If so, I can prepare a patch.
>
> >> identifier f;
> >> type t;
> >> identifier v;
> >> position decl_p;
> >> position copy_p;
> >> @@
> >>
> >> f(..., t v@decl_p, ...)
> >> {
> >> <+...
> >> copy_from_user@copy_p(v, ...)
> >> ...+>
> >> }
> >>
> >> @script:python@
> >> f << cfu.f;
> >> t << cfu.t;
> >> v << cfu.v;
> >> decl_p << cfu.decl_p;
> >> copy_p << cfu.copy_p;
> >> @@
> >>
> >> if '__user' in t:
> >>   msg0 = "function \"" + f + "\" has arg \"" + v + "\" of type \"" + t + "\""
> >>   coccilib.report.print_report(decl_p[0], msg0)
> >>   msg1 = "copy_from_user uses \"" + v + "\" as the destination. What a shame!\n"
> >>   coccilib.report.print_report(copy_p[0], msg1)
> >>
> >>
> >> The rule output:
> >>
> >> ./drivers/block/floppy.c:3756:49-52: function "compat_getdrvprm" has arg "arg"
> >> of type "struct compat_floppy_drive_params __user *"
> >> ./drivers/block/floppy.c:3783:5-19: copy_from_user uses "arg" as the
> >> destination. What a shame!
> >>
> >> ./drivers/block/floppy.c:3789:49-52: function "compat_getdrvstat" has arg "arg"
> >> of type "struct compat_floppy_drive_struct __user *"
> >> ./drivers/block/floppy.c:3819:5-19: copy_from_user uses "arg" as the
> >> destination. What a shame!
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
