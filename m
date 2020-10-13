Return-Path: <SRS0=ddCJ=DU=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9555AC433E7
	for <cocci@archiver.kernel.org>; Tue, 13 Oct 2020 16:53:54 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D987252EA
	for <cocci@archiver.kernel.org>; Tue, 13 Oct 2020 16:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D987252EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09DGrSDi022081;
	Tue, 13 Oct 2020 18:53:28 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 674EB74CE;
	Tue, 13 Oct 2020 18:53:28 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id AF672578C
 for <cocci@systeme.lip6.fr>; Tue, 13 Oct 2020 18:53:26 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09DGrOvV021575
 for <cocci@systeme.lip6.fr>; Tue, 13 Oct 2020 18:53:24 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.77,371,1596492000"; d="scan'208";a="361683217"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 13 Oct 2020 18:53:23 +0200
Date: Tue, 13 Oct 2020 18:53:23 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <trinity-add9d6f9-2889-4bf6-97b3-83add07516ff-1602607555446@3c-app-webde-bs30>
Message-ID: <alpine.DEB.2.22.394.2010131851300.18876@hadrien>
References: <trinity-d2989d61-4401-4280-9989-055536630329-1602595815473@3c-app-webde-bs30>
 <alpine.DEB.2.22.394.2010131535170.2674@hadrien>
 <trinity-75bb5607-ae06-450d-95a6-fa9cb0aaf732-1602599807925@3c-app-webde-bs30>
 <alpine.DEB.2.22.394.2010131647490.2674@hadrien>
 <trinity-add9d6f9-2889-4bf6-97b3-83add07516ff-1602607555446@3c-app-webde-bs30>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 13 Oct 2020 18:53:28 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 13 Oct 2020 18:53:24 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>
Subject: Re: [Cocci] [PATCH v2] coccinelle: iterators: Add
 for_each_child.cocci script
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



On Tue, 13 Oct 2020, Markus Elfring wrote:

> > > Would you care a bit more for the clarification of the ordering for the shown macro names?
> >
> > Why does the ordering matter, since they are all distinct?
>
> * It might look promising to reorder macro calls according to name criteria
>   and passed parameters.
>
> * But I imagine that the functionality of disjunctions by the semantic patch language
>   can trigger further development considerations more in another direction.
>   https://github.com/coccinelle/coccinelle/blob/730dbb034559b3e549ec0b2973cd0400a3fa072f/docs/manual/cocci_syntax.tex#L1033
>
>   Later source code search patterns will only be checked in such SmPL disjunctions
>   if previous parts did not match.
>   Thus often used code variants should probably be specified at the beginning
>   while special selections should be moved to the end.
>   The sorting of macro calls according to an estimated or actual usage frequency
>   can influence the evaluation characteristics of affected SmPL code,
>   can't it?

No.  As I already pointed out, the different macros are disjoint.  The
order doens't matter.  Only one of the patterns will match any given loop.
If there are nested loops, the pattern will match multiple times.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
