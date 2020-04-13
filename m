Return-Path: <SRS0=NqNQ=55=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2F5C2BA2B
	for <cocci@archiver.kernel.org>; Mon, 13 Apr 2020 16:00:35 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B31420735
	for <cocci@archiver.kernel.org>; Mon, 13 Apr 2020 16:00:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B31420735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03DG0AGn026756;
	Mon, 13 Apr 2020 18:00:10 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7FD937816;
	Mon, 13 Apr 2020 18:00:10 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 400B27755
 for <cocci@systeme.lip6.fr>; Mon, 13 Apr 2020 18:00:08 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03DG07dl016268
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 13 Apr 2020 18:00:07 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.72,378,1580770800"; d="scan'208";a="345770452"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 13 Apr 2020 18:00:07 +0200
Date: Mon, 13 Apr 2020 18:00:06 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <12e1bffb-9df2-3b58-a58e-2235f745524b@web.de>
Message-ID: <alpine.DEB.2.21.2004131758380.3035@hadrien>
References: <146360ce-9cfb-e6f5-1601-fa95460c2cd5@web.de>
 <alpine.DEB.2.21.2004101712080.3039@hadrien>
 <f0b37f45-5144-a1c5-3f52-5bfbb6f3635f@web.de>
 <alpine.DEB.2.21.2004111600560.2369@hadrien>
 <fcbca1d9-7375-b488-54b2-a3934b90c6ed@web.de>
 <alpine.DEB.2.21.2004112036270.2369@hadrien>
 <d878a25d-29fd-28b1-fa6f-2e0f44763d73@web.de>
 <alpine.DEB.2.21.2004121050210.2419@hadrien>
 <ab6d402e-3c12-25ab-162a-f200c382dd0a@web.de>
 <d68533a4-554a-fd38-a940-1c3fb15c4dae@web.de>
 <alpine.DEB.2.21.2004130957540.3035@hadrien>
 <7228efff-76bb-44c9-e2cd-ea19bbd49abf@web.de>
 <alpine.DEB.2.21.2004131553460.3035@hadrien>
 <d4324b34-0040-0fb7-d24c-b738ed811c0c@web.de>
 <alpine.DEB.2.21.2004131627470.3035@hadrien>
 <8c9431e7-64e9-9f00-3f10-6fa8e316dcca@web.de>
 <alpine.DEB.2.21.2004131658380.3035@hadrien>
 <12e1bffb-9df2-3b58-a58e-2235f745524b@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 13 Apr 2020 18:00:10 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 13 Apr 2020 18:00:07 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] More support for SmPL data processing with databases?
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



On Mon, 13 Apr 2020, Markus Elfring wrote:

> >>> Maybe you consider the following results to be a problem:
> >>>
> >>> kzalloc mcde [("mcde_probe", 2, 0, 198, 1, "m.c", 16, 1, 16, 3)]
> >>> kzalloc ! mcde [("mcde_probe", 2, 0, 198, 1, "m.c", 16, 1, 16, 3)]
> >>> platform_get_irq irq [("mcde_probe", 2, 0, 198, 1, "m.c", 97, 1, 97, 3)]
> >>> platform_get_irq ! irq [("mcde_probe", 2, 0, 198, 1, "m.c", 97, 1, 97, 3)]
> >>>
> >>> The positions are the same.  The result is because of an isomorphism that
> >>> exchanges the branches of a conditional.
>
> I would find it nice to explain the different software behaviour for the mentioned
> SmPL code variants

Run spatch -parse-cocci and you will easily see.  The if stays in the same
place.  When the isomorphism exchanges the branches, the condition gets
negated, so in one case you get the position of the full condition and in
the other case you get the position of the part of the condition under the
negation.

julia

>
> A:
>  if@p (
> (     <+... result ...+>
> &     check
> )     )
>
>
> B:
>  if (
> (   <+... result ...+>
> &   check@p
> )   )
>
>
>
> >> Can the data which are provided because of isomorphism transformations
> >> be distinguished by an additional attribute?
> >
> > I think that you just want to disable the isomorphism.  Put disable neg_if
> > in the initial @@ of your rule.
>
> Thanks for this suggestion.
>
> Source code analysis can be continued also with this configuration option.
>
>
> Now I become also more interested in improvements around parallel data processing.
> Which data structures would support aggregate computations for a growing code base?
>
> Regards,
> Markus
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
