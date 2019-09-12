Return-Path: <SRS0=dhti=XH=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC340C4CECB
	for <cocci@archiver.kernel.org>; Thu, 12 Sep 2019 11:32:07 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AB6B2081B
	for <cocci@archiver.kernel.org>; Thu, 12 Sep 2019 11:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AB6B2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8CBVrQS011200;
	Thu, 12 Sep 2019 13:31:53 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 75C117798;
	Thu, 12 Sep 2019 13:31:53 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9BDEA7797
 for <cocci@systeme.lip6.fr>; Thu, 12 Sep 2019 13:31:51 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8CBVp6r013879
 for <cocci@systeme.lip6.fr>; Thu, 12 Sep 2019 13:31:51 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.64,495,1559512800"; d="scan'208";a="319165150"
Received: from portablejulia.rsr.lip6.fr ([132.227.76.63])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Sep 2019 13:31:50 +0200
Date: Thu, 12 Sep 2019 13:31:52 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: julia@hadrien
To: =?ISO-8859-15?Q?Christoph_B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20190912111304.2fu3lcqmtgbnolpx@gintonic.linbit>
Message-ID: <alpine.DEB.2.21.1909121330300.2876@hadrien>
References: <20190912111304.2fu3lcqmtgbnolpx@gintonic.linbit>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1143615190-1568287912=:2876"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 12 Sep 2019 13:31:54 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Thu, 12 Sep 2019 13:31:51 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] const in parameter lists
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
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1143615190-1568287912=:2876
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 12 Sep 2019, Christoph Böhmwalder wrote:

> Hi,
>
> I'm having trouble removing const arguments from a function. I think this issue
> is best explained in code:
>
> $ cat repro.c
> f(int x,
>   const unsigned a,
>   const char *y)
> {
> }
>
> $ cat repro.cocci
> @@
> identifier a;
> @@
> f(...
> - , unsigned a
> + , unsigned b
> ,...)
> {
> ...
> }
>
> $ spatch --sp-file repro.cocci --very-quiet repro.c
> --- repro.c
> +++ /tmp/cocci-output-17454-200d33-repro.c
> @@ -1,5 +1,5 @@
> -f(int x,
> -  const unsigned a,
> +f(int x
> +  const, unsigned b,
>    const char *y)
>  {
>  }
>
>
> When I try to remove some parameter(s) in the middle (in my real use case
> I'm trying to remove 2) the 'const' ends up in weird places.
>
> Obviously I've tried (with and without disable optional_qualifier):
>
>     f(...
>     - , const unsigned a
>     + , const unsigned b
>     ,...)
>
> but that gives:
>
>     minus: parse error:
>       File "repro.cocci", line 5, column 19, charpos = 45
>       around = 'a',
>       whole content = - , const unsigned a
>
> How can I tell coccinelle that I want a const here?


Sorry, it's not clear to me what you want to do.  Do you want to verify
that there is a const before renaming the parameter?  Could you do

const unsigned
-a
+b

?

julia

>
> Thanks,
> --
> Christoph Böhmwalder
> LINBIT | Keeping the Digital World Running
> DRBD HA —  Disaster Recovery — Software defined Storage
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
--8323329-1143615190-1568287912=:2876
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1143615190-1568287912=:2876--
