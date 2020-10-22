Return-Path: <SRS0=Kimj=D5=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2ABC388F7
	for <cocci@archiver.kernel.org>; Thu, 22 Oct 2020 12:35:55 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 935A922267
	for <cocci@archiver.kernel.org>; Thu, 22 Oct 2020 12:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 935A922267
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09MCZ6pO009298;
	Thu, 22 Oct 2020 14:35:06 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id BAF8D75B4;
	Thu, 22 Oct 2020 14:35:06 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A9673445E
 for <cocci@systeme.lip6.fr>; Thu, 22 Oct 2020 14:35:04 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09MCZ4kQ013751
 for <cocci@systeme.lip6.fr>; Thu, 22 Oct 2020 14:35:04 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.77,404,1596492000"; d="scan'208";a="473857495"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Oct 2020 14:35:03 +0200
Date: Thu, 22 Oct 2020 14:35:03 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <acaed49b9195d47e252a0b67551f87e96324d004.camel@web.de>
Message-ID: <alpine.DEB.2.22.394.2010221434210.5113@hadrien>
References: <78f8b08754dde286adf7e11e1eeb3bb8ad500d8b.camel@web.de>
 <acaed49b9195d47e252a0b67551f87e96324d004.camel@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-24693990-1603370104=:5113"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 22 Oct 2020 14:35:07 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 22 Oct 2020 14:35:04 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>, kernel-janitors@vger.kernel.org,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] =?utf-8?q?Coccinelle=3A_Checking_the_influence_of_?=
 =?utf-8?b?4oCcR3JlcCBxdWVyeeKAnQ==?=
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

--8323329-24693990-1603370104=:5113
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Thu, 22 Oct 2020, Markus Elfring wrote:

> > A disjunction is applied by this script for the semantic patch language.
> > This construct uses short-circuit evaluation. It has got the consequence
> > that the last element of the specified condition will only be checked
> > if all previous parts did not match. Such a technical detail leads to
> > a recommended ordering of condition parts if you would like to care for
> > optimal run time characteristics of SmPL code.
>
> I imagine that such information can trigger further software evolution
> at more places.
>
>
> > +++ b/scripts/coccinelle/iterators/for_each_child.cocci
>
> The software “Coccinelle 1.0.8-00177-g28737419” displays the following data.
>
> elfring@Sonne:~/Projekte/Linux/next-patched> spatch -D patch --parse-cocci
> scripts/coccinelle/iterators/for_each_child.cocci
> …
> Grep query
> for_each_node_with_property || for_each_node_by_type || for_each_node_by_name ||
> for_each_matching_node_and_match || for_each_matching_node ||
> for_each_compatible_node || for_each_child_of_node ||
> for_each_available_child_of_node
>
>
> I suggest to take another closer look at the presented ordering for
> these identifiers.
> It deviates from the proposed listing for the SmPL disjunction.
> Now I am curious if this difference can be meaningful.
>
> If the exact “grep” is performed, it might happen that short-circuit evaluation
> would be applied also by the corresponding software component (or known tool).
> Will any adjustments become relevant then accordingly?

It doesn't matter.  The purpose is just to select files that are relevent
for consideration.  If a file is selected for two reasons instead of one
reason, it doesn't matter; it's still selected.

julia
--8323329-24693990-1603370104=:5113
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-24693990-1603370104=:5113--
