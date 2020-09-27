Return-Path: <SRS0=onlg=DE=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EDCC4346E
	for <cocci@archiver.kernel.org>; Sun, 27 Sep 2020 19:35:53 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFA6E2311C
	for <cocci@archiver.kernel.org>; Sun, 27 Sep 2020 19:35:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA6E2311C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08RJZb09008938;
	Sun, 27 Sep 2020 21:35:37 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 163BE5F8F;
	Sun, 27 Sep 2020 21:35:37 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3B2864316
 for <cocci@systeme.lip6.fr>; Sun, 27 Sep 2020 21:35:34 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08RJZXh5002275
 for <cocci@systeme.lip6.fr>; Sun, 27 Sep 2020 21:35:33 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.77,311,1596492000"; d="scan'208";a="469742917"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Sep 2020 21:35:32 +0200
Date: Sun, 27 Sep 2020 21:35:32 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Joe Perches <joe@perches.com>
In-Reply-To: <983c49ebe4bbe0435a73d25cd8525764a4f8adac.camel@perches.com>
Message-ID: <alpine.DEB.2.22.394.2009272132110.2839@hadrien>
References: <87r1qqvo2d.fsf@nanos.tec.linutronix.de>
 <a53048f738dacc1c58654eb94e229de79d4f94c2.camel@perches.com>
 <alpine.DEB.2.22.394.2009271907270.2839@hadrien>
 <983c49ebe4bbe0435a73d25cd8525764a4f8adac.camel@perches.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 27 Sep 2020 21:35:37 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 27 Sep 2020 21:35:33 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Giuseppe Scrivano <gscrivan@redhat.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        lkp <lkp@intel.com>, kernelnewbies <kernelnewbies@kernelnewbies.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, cocci <cocci@systeme.lip6.fr>,
        Andy Whitcroft <apw@shadowen.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Cocci] coccinelle: Convert comma to semicolons (was Re:
 [PATCH] checkpatch: Add test for comma use that should be semicolon)
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



On Sun, 27 Sep 2020, Joe Perches wrote:

> On Sun, 2020-09-27 at 19:08 +0200, Julia Lawall wrote:
> > I end up with 208 patches.  I'm not sure that sending them all at once
> > would be a good idea...
>
> Last I looked the diffstat for comma -> semicolon was:
>
> 234 files changed, 509 insertions(+), 509 deletions(-)
>
> So it would be nearly 1 patch per individual file,

I have 282 files.

>
> Greg KH does send hundreds of patches for -stable at a time.
>
> So, maybe or maybe not send them all at once.
> Maybe send it in batches of 25 or so.
>
> There's no single right way to do this.
>
> Maybe put up a git tree somewhere and let the
> kernel-robot test compilation.

I compiled all but about 15 and checked those 15 an extra time.

I'll try the small batch approach to get started.

thanks,
julia

> (A nicety might be for the kernel-robot to have some
>  option to test pre and post compilation object code
>  differences with an optional report)
>
> When I automated 491 patches for /* fallthrough */ to
> fallthrough;, the robot caught a couple problems which
> was great.
>
> https://repo.or.cz/linux-2.6/trivial-mods.git/shortlog/refs/heads/20200310_fallthrough_2
>
> I only posted the first ~30 patches though with
> about 50% acceptance. Gustavo Silva picked up the
> effort and did a great job.  Eventually, a single
> treewide patch was posted and accepted by Linus for
> this though after dozens of individual patches went
> through various maintainer trees:
>
> $ git log --shortstat -1 df561f6688fe
> commit df561f6688fef775baa341a0f5d960becd248b11
> Author: Gustavo A. R. Silva <gustavoars@kernel.org>
> Date:   Sun Aug 23 17:36:59 2020 -0500
>
>     treewide: Use fallthrough pseudo-keyword
>
>     Replace the existing /* fall through */ comments and its variants with
>     the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
>     fall-through markings when it is the case.
>
>     [1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=>
>
>     Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>
>  1148 files changed, 2667 insertions(+), 2737 deletions(-)
>
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
