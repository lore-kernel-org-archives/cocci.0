Return-Path: <SRS0=OH0s=7R=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124D7C433E0
	for <cocci@archiver.kernel.org>; Thu,  4 Jun 2020 15:56:57 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC566206A2
	for <cocci@archiver.kernel.org>; Thu,  4 Jun 2020 15:56:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC566206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 054FusVp011154;
	Thu, 4 Jun 2020 17:56:54 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1731D7567;
	Thu,  4 Jun 2020 17:56:54 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0DFDD5D47
 for <cocci@systeme.lip6.fr>; Thu,  4 Jun 2020 17:56:53 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 054FupZb024353
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 4 Jun 2020 17:56:51 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.73,472,1583190000"; d="scan'208";a="350606174"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Jun 2020 17:56:39 +0200
Date: Thu, 4 Jun 2020 17:56:38 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <96653281-3812-8b44-0dd8-6e7540a26a89@web.de>
Message-ID: <alpine.DEB.2.21.2006041755360.2577@hadrien>
References: <96653281-3812-8b44-0dd8-6e7540a26a89@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-914190676-1591286199=:2577"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 04 Jun 2020 17:56:54 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 04 Jun 2020 17:56:51 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>, kernel-janitors@vger.kernel.org,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] [PATCH] coccinelle: api: add kzfree script
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

--8323329-914190676-1591286199=:2577
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Thu, 4 Jun 2020, Markus Elfring wrote:

> > Check for memset() with 0 followed by kfree().
>
> I suggest to simplify the SmPL code a bit like the following.
>
>
> > +virtual context
> > +virtual org
> > +virtual report
> > +virtual patch
>
> +virtual context, org, report, patch

This is pointless.

>
>
> …
> > +@@
> > +
> > +(
> > +* memset(E, 0, ...);
> > +|
> > +* memset(E, '\0', ...);
> > +)
> > +* kfree(E)@p;
>
> +@@
> +*memset(E, 0, ...);
> +*kfree(E)@p;
>
>
> How does the SmPL asterisk functionality fit to the operation
> modes “org” and “report”?

make coccicheck uses the option --no-show-diff for the org and report
modes.

>
> > +@@
> > +
> > +(
> > +- memset(E, 0, ...);
> > +|
> > +- memset(E, '\0', ...);
> > +)
> > +- kfree(E);
> > ++ kzfree(E);
>
> +@@
> +-memset(E, 0, ...);
> +-kfree
> ++kzfree
> +       (E);
>
> I got the impression that the specification of a SmPL disjunction
> could be omitted because of the technical detail that the isomorphism
> “zero_multiple_format” should handle such an use case already.
>
> Would you like to tolerate any extra source code between these function calls?

I already addressed these issues.

julia
--8323329-914190676-1591286199=:2577
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-914190676-1591286199=:2577--
