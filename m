Return-Path: <SRS0=hcCA=UU=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AC4C43613
	for <cocci@archiver.kernel.org>; Fri, 21 Jun 2019 14:53:49 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BAEB208C3
	for <cocci@archiver.kernel.org>; Fri, 21 Jun 2019 14:53:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BAEB208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5LErVf7023801;
	Fri, 21 Jun 2019 16:53:32 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id CFA567779;
	Fri, 21 Jun 2019 16:53:31 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8C121776C
 for <cocci@systeme.lip6.fr>; Fri, 21 Jun 2019 16:53:30 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5LEqUvs017472
 for <cocci@systeme.lip6.fr>; Fri, 21 Jun 2019 16:52:30 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.63,400,1557180000"; d="scan'208";a="311013097"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 21 Jun 2019 16:52:19 +0200
Date: Fri, 21 Jun 2019 16:52:16 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <452fc5f1-bcaa-c9a5-9600-0278594e5e6f@web.de>
Message-ID: <alpine.DEB.2.20.1906211651550.3740@hadrien>
References: <05d85182-7ec3-8fc1-4bcd-fd2528de3a40@web.de>
 <alpine.DEB.2.21.1906202046550.3087@hadrien>
 <34d528db-5582-5fe2-caeb-89bcb07a1d30@web.de>
 <alpine.DEB.2.21.1906202110310.3087@hadrien>
 <13890878-9e5f-f297-7f7c-bcc1212d83b7@web.de>
 <alpine.DEB.2.20.1906211119430.3740@hadrien>
 <452fc5f1-bcaa-c9a5-9600-0278594e5e6f@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 21 Jun 2019 16:53:32 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Fri, 21 Jun 2019 16:52:30 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>, kernel-janitors@vger.kernel.org,
        Nicolas Palix <nicolas.palix@imag.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        Ding Xiang <dingxiang@cmss.chinamobile.com>,
        Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Coccinelle: Add a SmPL script for the reconsideration
 of redundant dev_err() calls
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



On Fri, 21 Jun 2019, Markus Elfring wrote:

> > I still don't see the point of specifying return.  Why not just S, where S
> > is a statement metavariable?
>
> Do you find the following SmPL change specification more appropriate?

It looks better.

>
> @deletion depends on patch@
> expression e;
> statement s;
> @@
>  e = devm_ioremap_resource(...);
>  if (IS_ERR(e))
> (
> -{
> -   dev_err(...);
>     s
> -}
> |
>  {
>  <+...
> -   dev_err(...);
>  ...+>
>  }
> )
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
