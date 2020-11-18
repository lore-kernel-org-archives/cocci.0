Return-Path: <SRS0=W2IF=EY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD030C5519F
	for <cocci@archiver.kernel.org>; Wed, 18 Nov 2020 13:16:21 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1804241A5
	for <cocci@archiver.kernel.org>; Wed, 18 Nov 2020 13:16:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1804241A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0AIDFw1i001673;
	Wed, 18 Nov 2020 14:15:58 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 69C817789;
	Wed, 18 Nov 2020 14:15:58 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 09EE15C34
 for <cocci@systeme.lip6.fr>; Wed, 18 Nov 2020 14:15:56 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0AIDFsbs025280
 for <cocci@systeme.lip6.fr>; Wed, 18 Nov 2020 14:15:54 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.77,486,1596492000"; d="scan'208";a="478177596"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Nov 2020 14:15:54 +0100
Date: Wed, 18 Nov 2020 14:15:53 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <62af4a93-dbc3-8aa0-6924-4dc479001d34@web.de>
Message-ID: <alpine.DEB.2.22.394.2011181413280.2641@hadrien>
References: <20201118080242.t6u6lchj5ww2fac4@adolin>
 <62af4a93-dbc3-8aa0-6924-4dc479001d34@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1777813137-1605705354=:2641"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 18 Nov 2020 14:15:58 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 18 Nov 2020 14:15:54 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Gilles Muller <Gilles.Muller@lip6.fr>, kernel-janitors@vger.kernel.org,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] [PATCH v2] coccinelle: locks: Add balancedlock.cocci
 script
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

--8323329-1777813137-1605705354=:2641
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

> > +++ b/scripts/coccinelle/locks/balancedlock.cocci
> …
> > +//# False positives may be generated due to locks released within a nested
> > +//# function call or a goto block.
> > +///
> > +// Confidence: Moderate
>
> How good does such information fit together?
>

What kind of response do you expect?  There are some concerns, so it's not
High confidence.  It works pretty well so it's not low confidence.  So
it's moderate confidence.  What else is there to say?

> …
> >+ (
> > +mutex_lock@p(E);
> > +|
> > +read_lock@p(E);
> > +|
> …
>
> Why did you not reorder the elements of such a SmPL disjunctions according to
> an usage incidence (which can be determined by another SmPL script like
> “report_lock_calls.cocci”)?

I don't recall ever seeing any evidence that it has an impact for function
calls.  Furthermore, the numbers will change over time.  So why change it?

> …
> > +msg = "This code segment might have an unbalanced lock."
> > +coccilib.org.print_todo(j0[0], msg)
>
> Please pass the string literal directly.
>
> +coccilib.org.print_todo(j0[0], "This code segment might have an unbalanced lock.")

The code is fine as it is.

julia
--8323329-1777813137-1605705354=:2641
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1777813137-1605705354=:2641--
