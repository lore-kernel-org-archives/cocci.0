Return-Path: <SRS0=N5Dx=XY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8DCC4360C
	for <cocci@archiver.kernel.org>; Sun, 29 Sep 2019 16:32:31 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F131A217F5
	for <cocci@archiver.kernel.org>; Sun, 29 Sep 2019 16:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F131A217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8TGWGZs014255;
	Sun, 29 Sep 2019 18:32:16 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0335076E8;
	Sun, 29 Sep 2019 18:32:16 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 192D276D9
 for <cocci@systeme.lip6.fr>; Sun, 29 Sep 2019 18:32:14 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8TGWC4F026136
 for <cocci@systeme.lip6.fr>; Sun, 29 Sep 2019 18:32:12 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.64,563,1559512800"; d="scan'208";a="403854904"
Received: from 81-65-53-202.rev.numericable.fr (HELO hadrien) ([81.65.53.202])
 by mail2-relais-roc.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Sep 2019 18:32:12 +0200
Date: Sun, 29 Sep 2019 18:32:12 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Yuehaibing <yuehaibing@huawei.com>
In-Reply-To: <2c109d6b-45ad-b3ca-1951-bde4dac91d2a@huawei.com>
Message-ID: <alpine.DEB.2.21.1909291810300.3346@hadrien>
References: <20190928094245.45696-1-yuehaibing@huawei.com>
 <alpine.DEB.2.21.1909280542490.2168@hadrien>
 <2c109d6b-45ad-b3ca-1951-bde4dac91d2a@huawei.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 29 Sep 2019 18:32:16 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Sun, 29 Sep 2019 18:32:12 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: michal.lkml@markovi.net, nicolas.palix@imag.fr, maennich@google.com,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci] [RFC PATCH] scripts: Fix coccicheck failed
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



On Sun, 29 Sep 2019, Yuehaibing wrote:

> On 2019/9/28 20:43, Julia Lawall wrote:
> >
> >
> > On Sat, 28 Sep 2019, YueHaibing wrote:
> >
> >> Run make coccicheck, I got this:
> >>
> >> spatch -D patch --no-show-diff --very-quiet --cocci-file
> >>  ./scripts/coccinelle/misc/add_namespace.cocci --dir .
> >>  -I ./arch/x86/include -I ./arch/x86/include/generated
> >>  -I ./include -I ./arch/x86/include/uapi
> >>  -I ./arch/x86/include/generated/uapi -I ./include/uapi
> >>  -I ./include/generated/uapi --include ./include/linux/kconfig.h
> >>  --jobs 192 --chunksize 1
> >>
> >> virtual rule patch not supported
> >> coccicheck failed
> >>
> >> It seems add_namespace.cocci cannot be called in coccicheck.
> >
> > Could you explain the issue better?  Does the current state cause make
> > coccicheck to fail?  Or is it just silently not being called?
>
> Yes, it cause make coccicheck failed like this:
>
> ...
> ./drivers/xen/xenbus/xenbus_comms.c:290:2-8: preceding lock on line 243
> ./fs/fuse/dev.c:1227:2-8: preceding lock on line 1206
> ./fs/fuse/dev.c:1232:3-9: preceding lock on line 1206
> coccicheck failed
> make[1]: *** [coccicheck] Error 255
> make: *** [sub-make] Error 2

Could you set the verbose options to see what the problem is?  Maybe the
problem would be solved by putting virtual report at the top of the rule.
But it might still fail because nothing can happen without a value for the
virtual metavariable ns.

Should the coccinelle directory be only for things that work with make
coccicheck, or for all Coccinelle scripts?

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
