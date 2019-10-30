Return-Path: <SRS0=bhL7=YX=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF89CA9EC5
	for <cocci@archiver.kernel.org>; Wed, 30 Oct 2019 20:44:48 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F07E2080F
	for <cocci@archiver.kernel.org>; Wed, 30 Oct 2019 20:44:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F07E2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9UKiXMa016910;
	Wed, 30 Oct 2019 21:44:33 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 6BB2776F8;
	Wed, 30 Oct 2019 21:44:33 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2533874CD
 for <cocci@systeme.lip6.fr>; Wed, 30 Oct 2019 21:44:31 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9UKiUN6027993
 for <cocci@systeme.lip6.fr>; Wed, 30 Oct 2019 21:44:30 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.68,248,1569276000"; d="scan'208";a="325166754"
Received: from abo-81-75-68.mrs.modulonet.fr (HELO hadrien) ([85.68.75.81])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 30 Oct 2019 21:44:30 +0100
Date: Wed, 30 Oct 2019 21:44:30 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <3389d97e-37a6-e755-bfb6-73b98cfd5bca@web.de>
Message-ID: <alpine.DEB.2.21.1910302144050.3273@hadrien>
References: <fe6868a4-01f5-2832-9081-7643be0ab4a1@web.de>
 <3e3f40db-2422-c64d-3825-35f8c2471eb7@web.de>
 <161bbb97-09d9-f128-bd25-ef9348534144@web.de>
 <bd082d16-3038-1c8f-0a8a-bef8e6498aae@web.de>
 <2db8691d768571f6c275f3d89401df23@lip6.fr>
 <3389d97e-37a6-e755-bfb6-73b98cfd5bca@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1556839087-1572468270=:3273"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 30 Oct 2019 21:44:34 +0100 (CET)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Wed, 30 Oct 2019 21:44:30 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] xusb-tegra186: Adding a function call behind a label
 with SmPL?
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

--8323329-1556839087-1572468270=:3273
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Wed, 30 Oct 2019, Markus Elfring wrote:

> > There is no reason why a patch should be generated in this case.
> > As you should know well, A ... B only matches in a transformation case
> > if every path from A leads to code matching B.  That is not the case in your example.
>
> The exception handling code should usually be executed at the end of
> function implementations after an error situation was detected.
>
> Do you try to refer to specific information from the software documentation
> like the following?
>
> https://github.com/coccinelle/coccinelle/blob/ed1eb8e06f800739d3992158d36945c0c4c6f0c7/docs/manual/cocci_syntax.tex#L179
> “…
> A depends on clause can further indicate whether the clause should be satisfied
> for all the branches (forall) or only for one (exists). exists is the default.
> …”

There is no depends on in your code.  The cited text is not relevant.

julia

>
> The following simple transformation approach seems to work in the way
> which I expected somehow initially.
>
> @addition exists@
> expression object;
> @@
>  object = kzalloc(...)
>  ... when any
>  device_unregister(...);
>  out:
> +kfree(object);
>  return ERR_PTR(...);
>
>
> Does this change specification indicate then a disagreement about
> a default SmPL rule property?
>
> Regards,
> Markus
>
--8323329-1556839087-1572468270=:3273
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1556839087-1572468270=:3273--
