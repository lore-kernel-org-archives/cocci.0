Return-Path: <SRS0=ddCJ=DU=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226C4C433DF
	for <cocci@archiver.kernel.org>; Tue, 13 Oct 2020 20:25:08 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21F57208D5
	for <cocci@archiver.kernel.org>; Tue, 13 Oct 2020 20:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21F57208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09DKOrCY017501;
	Tue, 13 Oct 2020 22:24:53 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3B00374CE;
	Tue, 13 Oct 2020 22:24:53 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id CAEE2578C
 for <cocci@systeme.lip6.fr>; Tue, 13 Oct 2020 22:24:51 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09DKOojk000246
 for <cocci@systeme.lip6.fr>; Tue, 13 Oct 2020 22:24:50 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.77,371,1596492000"; d="scan'208";a="361694125"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 13 Oct 2020 22:24:18 +0200
Date: Tue, 13 Oct 2020 22:24:18 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <trinity-991d9da6-7a4f-4f30-a645-5f4d54b80c53-1602620539556@3c-app-webde-bs30>
Message-ID: <alpine.DEB.2.22.394.2010132223050.18876@hadrien>
References: <trinity-d2989d61-4401-4280-9989-055536630329-1602595815473@3c-app-webde-bs30>
 <alpine.DEB.2.22.394.2010131535170.2674@hadrien>
 <trinity-75bb5607-ae06-450d-95a6-fa9cb0aaf732-1602599807925@3c-app-webde-bs30>
 <alpine.DEB.2.22.394.2010131647490.2674@hadrien>
 <trinity-add9d6f9-2889-4bf6-97b3-83add07516ff-1602607555446@3c-app-webde-bs30>
 <alpine.DEB.2.22.394.2010131851300.18876@hadrien>
 <trinity-a1f3e64f-e955-45f2-8ee7-0a26c2974e38-1602614175986@3c-app-webde-bs30>
 <alpine.DEB.2.22.394.2010132100350.18876@hadrien>
 <trinity-991d9da6-7a4f-4f30-a645-5f4d54b80c53-1602620539556@3c-app-webde-bs30>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1982981802-1602620659=:18876"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 13 Oct 2020 22:24:53 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 13 Oct 2020 22:24:50 +0200 (CEST)
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
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1982981802-1602620659=:18876
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 13 Oct 2020, Markus Elfring wrote:

> > The rule is applied independently to each node in the control-flow graph.
>
> Please explain a specific technical detail once more.
> Is short-circuit evaluation applied for a disjunction (according to macro calls)
> in the discussed SmPL rule “r”?

The short circuit evaluation is applied at the level of CFG nodes.  For
each CFG node, it tries the sequence of patters one by one until it finds
one that matches.

julia
--8323329-1982981802-1602620659=:18876
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1982981802-1602620659=:18876--
