Return-Path: <SRS0=yQoC=73=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC7CC433DF
	for <cocci@archiver.kernel.org>; Sun, 14 Jun 2020 08:48:03 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B00720714
	for <cocci@archiver.kernel.org>; Sun, 14 Jun 2020 08:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B00720714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05E8lxqZ009050;
	Sun, 14 Jun 2020 10:47:59 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5F36E7760;
	Sun, 14 Jun 2020 10:47:59 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0E30444A7
 for <cocci@systeme.lip6.fr>; Sun, 14 Jun 2020 10:47:57 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05E8lupo020382
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 14 Jun 2020 10:47:56 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.73,510,1583190000"; d="scan'208";a="351533315"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Jun 2020 10:47:50 +0200
Date: Sun, 14 Jun 2020 10:47:49 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Mike Galbraith <umgwanakikbuti@gmail.com>
In-Reply-To: <1592121650.2129.11.camel@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2006141043230.2849@hadrien>
References: <b14e6d1d-afa0-5c28-547a-9bb1a987f6fd@infradead.org>
 <1592115803.27290.33.camel@gmail.com>
 <alpine.DEB.2.22.394.2006140940000.2849@hadrien>
 <1592121432.2129.9.camel@gmail.com> <1592121650.2129.11.camel@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 14 Jun 2020 10:47:59 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 14 Jun 2020 10:47:56 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Randy Dunlap <rdunlap@infradead.org>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] coccinelle issues
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



On Sun, 14 Jun 2020, Mike Galbraith wrote:

> On Sun, 2020-06-14 at 09:57 +0200, Mike Galbraith wrote:
> > On Sun, 2020-06-14 at 09:42 +0200, Julia Lawall wrote:
> > >
> > > On Sun, 14 Jun 2020, Mike Galbraith wrote:
> > >
> > >
> > > > I didn't download, rather pulled/built.  I didn't have the same issue
> > > > you did, but make coccicheck was a bust here until I backed down to
> > > > version 1.0.6.  Neither HEAD, 1.0.8 or 1.0.7 ran, and following its
> > > > MODE=blah suggestion helped not at all.
> > >
> > > Did you get a segmentation fault?
> >
> > Nope.  Turned out to be a dinky install gotcha.  Creating a symlink..
> >
> > lrwxrwxrwx 1 root root 27 Jun 14 09:40 /usr/local/coccinelle/lib -> /usr/local/coccinelle/lib64
> >
> > ..seems to have fixed 1.0.8 all up.  The very first time I installed, I
> > had to create one directory (forget which) by hand as well.
>
> Oh well, not all fixed up, but it does run.
>
> ./fs/xfs/xfs_rmap_item.c:56:5-24: atomic_dec_and_test variation before object free at line 57.
> ./kernel/nsproxy.c:253:11-30: atomic_dec_and_test variation before object free at line 254.
> ./net/unix/scm.c:80:6-30: atomic_dec_and_test variation before object free at line 81.
> coccicheck failed
> make: *** [Makefile:1822: coccicheck] Error 2

Yeah, that's the segfault....  There is one rule that doesn't work well
with make coccicheck.  A patch has been proposed, but I don't know whether
it is upstream.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
