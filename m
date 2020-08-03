Return-Path: <SRS0=D+wQ=BN=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67235C433E0
	for <cocci@archiver.kernel.org>; Mon,  3 Aug 2020 13:21:32 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE0F8206DA
	for <cocci@archiver.kernel.org>; Mon,  3 Aug 2020 13:21:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE0F8206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 073DLKPS001196;
	Mon, 3 Aug 2020 15:21:20 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D53A576BF;
	Mon,  3 Aug 2020 15:21:20 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 16A9D41F5
 for <cocci@systeme.lip6.fr>; Mon,  3 Aug 2020 15:21:19 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 073DLGrD003775
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 3 Aug 2020 15:21:16 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.75,430,1589234400"; d="scan'208";a="355862004"
Received: from clt-128-93-177-162.vpn.inria.fr ([128.93.177.162])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 03 Aug 2020 15:21:15 +0200
Date: Mon, 3 Aug 2020 15:21:15 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <cd186837-3753-436a-b1f6-7e1dfe5ff5e0@web.de>
Message-ID: <alpine.DEB.2.22.394.2008031519520.27678@hadrien>
References: <cd186837-3753-436a-b1f6-7e1dfe5ff5e0@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-183462625-1596460875=:27678"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 03 Aug 2020 15:21:21 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 03 Aug 2020 15:21:16 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>, kernel-janitors@vger.kernel.org,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] [PATCH] coccinelle: api: add kvmalloc script
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

--8323329-183462625-1596460875=:27678
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Mon, 3 Aug 2020, Markus Elfring wrote:

> …
> > +++ b/scripts/coccinelle/api/kvmalloc.cocci
> …
> > +@opportunity depends on !patch@
> > +expression E, E1, size;
> > +position p;
> > +@@
> > +
> > +(
> …
> > +|
> > +* E = \(kmalloc\|kzalloc\|kcalloc\|kmalloc_node\|kzalloc_node\|
> > +*       kmalloc_array\|kmalloc_array_node\|kcalloc_node\)(..., size, ...)
> > +  ... when != E = E1
> > +      when != size = E1
> > +      when any
> > +* if (\(!E\|E == NULL\))@p {

Actually, you shouldn't need both E == NULL and !E.  E == NULL should be
sufficient.

julia

> …
>
> I suggest to extend the SmPL code exclusion specification so that
> pointer dereferences will be filtered out before the shown null pointer detection.
>
>
> > +@depends on patch@
> > +expression E, E1, flags, size, node;
> > +identifier x;
> > +type T;
> > +@@
> > +
> > +(
> > +- if (\(size <= E1\|size < E1\|size == E1\|size > E1\))
>
> This condition check is repeated a few times.
> Thus I imagine that the usage of another metavariable with a SmPL constraint
> can eventually be helpful.
>
> +binary operator bo = {<=, <, ==, >};
> …
> +-if (size bo E1)
>
>
>
> > +-    E = kmalloc(size, flags);
> > +- else
> > +-    E = vmalloc(size);
>
> Will it be interesting to support also the use of conditional operators
> by another part of a SmPL disjunction?
>
> -E = (…) ? kmalloc(size, flags) : vmalloc(size);
>
>
> > ++ E = kvmalloc(size, flags);
> > +|
> > +- E = kmalloc(size, flags | __GFP_NOWARN);
> > +- if (\(!E\|E == NULL\))
> > +-   E = vmalloc(size);
> > ++ E = kvmalloc(size, flags);
>
> This source code replacement line is repeated. Thus I imagine
> that it would be nice if such SmPL code duplication could be avoided
> by the application of another SmPL disjunction.
> Unfortunately, the software “Coccinelle 1.0.8-00146-g04f36d53” presents
> the error message “15: no available token to attach to” then.
> Would you like to adjust anything in this area?
>
> Regards,
> Markus
>
--8323329-183462625-1596460875=:27678
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-183462625-1596460875=:27678--
