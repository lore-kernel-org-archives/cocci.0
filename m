Return-Path: <SRS0=LZrr=U6=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD166C0650E
	for <cocci@archiver.kernel.org>; Mon,  1 Jul 2019 12:47:51 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6465B2053B
	for <cocci@archiver.kernel.org>; Mon,  1 Jul 2019 12:47:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6465B2053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x61Cla0K023122;
	Mon, 1 Jul 2019 14:47:36 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E5A3F7777;
	Mon,  1 Jul 2019 14:47:35 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id DD9B676B2
 for <cocci@systeme.lip6.fr>; Mon,  1 Jul 2019 14:47:33 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x61ClW3s003908
 for <cocci@systeme.lip6.fr>; Mon, 1 Jul 2019 14:47:32 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.63,439,1557180000"; d="scan'208";a="312023377"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 01 Jul 2019 14:47:31 +0200
Date: Mon, 1 Jul 2019 14:47:25 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
In-Reply-To: <0b48a5c5-0814-6414-39ba-beb1b8b5253a@metux.net>
Message-ID: <alpine.DEB.2.20.1907011442390.4005@hadrien>
References: <05d85182-7ec3-8fc1-4bcd-fd2528de3a40@web.de>
 <2744a3fc-9e67-8113-1dd9-43669e06386a@web.de>
 <0b48a5c5-0814-6414-39ba-beb1b8b5253a@metux.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 01 Jul 2019 14:47:36 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Mon, 01 Jul 2019 14:47:32 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Markus Elfring <Markus.Elfring@web.de>,
        Ding Xiang <dingxiang@cmss.chinamobile.com>,
        Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] [PATCH v2] Coccinelle: Add a SmPL script for the
 reconsideration of redundant dev_err() calls
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



On Mon, 1 Jul 2019, Enrico Weigelt, metux IT consult wrote:

> On 01.07.19 10:10, Markus Elfring wrote:
>
> Hi folks,
>
> > +@script:python to_do depends on org@
> > +p << or.p;
> > +@@
> > +coccilib.org.print_todo(p[0],
> > +                        "WARNING: An error message is probably not needed here because the devm_ioremap_resource() function contains appropriate error reporting.")
> > +
> > +@script:python reporting depends on report@
> > +p << or.p;
> > +@@
> > +coccilib.report.print_report(p[0],
> > +                             "WARNING: An error message is probably not needed here because the devm_ioremap_resource() function contains appropriate error reporting.")
> > --
>
> By the way: do we have any mechanism for explicitly suppressing
> individual warnings (some kind of annotation), when the maintainer is
> sure that some particular case is a false-positive ?
> (I'm thinking of something similar to certain #praga directives for
> explicitly ignoring invididual warnings in specific lines of code)
>
> I believe such a feature, so we don't get spammed with the same false
> positives again and again.

0-day takes care of it on its own.  Probably other such bots do the same.
I'm not sure that it is a good idea to clutter the kernel code with such
annotations, especially since the whole point of Ccocinelle is that the
rules are easy to change.  We also made a tool named Herodotos for
collecting identical reports over time, but it seems to be not so easy to
use.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
