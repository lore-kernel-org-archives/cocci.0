Return-Path: <SRS0=PWh2=XB=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAA6C43331
	for <cocci@archiver.kernel.org>; Fri,  6 Sep 2019 07:00:04 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 549F9206BB
	for <cocci@archiver.kernel.org>; Fri,  6 Sep 2019 07:00:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 549F9206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x866xo7l007418;
	Fri, 6 Sep 2019 08:59:50 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id BE59877BE;
	Fri,  6 Sep 2019 08:59:49 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8C0C17793
 for <cocci@systeme.lip6.fr>; Fri,  6 Sep 2019 08:59:04 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x866x4as016215
 for <cocci@systeme.lip6.fr>; Fri, 6 Sep 2019 08:59:04 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.64,472,1559512800"; d="scan'208";a="318476281"
Received: from abo-12-105-68.mrs.modulonet.fr (HELO hadrien) ([85.68.105.12])
 by mail3-relais-sop.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2019 08:59:02 +0200
Date: Fri, 6 Sep 2019 08:59:02 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <7818ad20-615c-2ce9-c0d1-3f7a09bedf34@web.de>
Message-ID: <alpine.DEB.2.21.1909060857290.2975@hadrien>
References: <5d71eb6f.1c69fb81.31bc8.da2d@mx.google.com>
 <7818ad20-615c-2ce9-c0d1-3f7a09bedf34@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 06 Sep 2019 08:59:50 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Fri, 06 Sep 2019 08:59:04 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Fri, 06 Sep 2019 08:59:47 +0200
Cc: Rob Herring <robh@kernel.org>, Michal Marek <michal.lkml@markovi.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Nicolas Palix <nicolas.palix@imag.fr>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Javier Martinez Canillas <javierm@redhat.com>, cocci@systeme.lip6.fr,
        Russell King <linux@armlinux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [Cocci] [PATCH -next] coccinelle: platform_get_irq: Fix parse
	error
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



On Fri, 6 Sep 2019, Markus Elfring wrote:

> > > minus: parse error:
> > >   File "./scripts/coccinelle/api/platform_get_irq.cocci", line 24, column 9, charpos = 355
> > >   around = '\(',
> > >   whole content = if ( ret \( < \| <= \) 0 )
> > >
> > > In commit e56476897448 ("fpga: Remove dev_err() usage
> > > after platform_get_irq()") log, I found the semantic patch,
> > > it fix this issue.
> > >
> > > Fixes: 98051ba2b28b ("coccinelle: Add script to check for platform_get_irq() excessive prints")
> > > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > > ---
> >
> > Hmm I had this earlier but someone asked me to change it.
>
> I proposed something also during the development for this SmPL script.
> https://lkml.org/lkml/2019/7/24/274
> https://lore.kernel.org/r/c98b8f50-1adf-ea95-a91c-ec451e9fefe2@web.de/

Markus,

This is not the first time you have suggested to someone to do something
that was simply incorrect.  Please actually test your suggestions before
proposing them.

> > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
>
> Should disjunctions eventually work in the semantic patch language also together with
> comparison operators?
> https://github.com/coccinelle/coccinelle/issues/40

No.

> Will any additional software adjustments be taken into account?

No.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
