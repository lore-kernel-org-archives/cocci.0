Return-Path: <SRS0=hgwh=XT=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E053FC432C1
	for <cocci@archiver.kernel.org>; Tue, 24 Sep 2019 15:30:38 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F1F820665
	for <cocci@archiver.kernel.org>; Tue, 24 Sep 2019 15:30:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F1F820665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8OFUPpl016352;
	Tue, 24 Sep 2019 17:30:25 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 61EFD77AB;
	Tue, 24 Sep 2019 17:30:25 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 08719779E
 for <cocci@systeme.lip6.fr>; Tue, 24 Sep 2019 17:30:24 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8OFUN7N029025
 for <cocci@systeme.lip6.fr>; Tue, 24 Sep 2019 17:30:23 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.64,544,1559512800"; d="scan'208";a="320494961"
Received: from unknown (HELO hadrien) ([65.39.69.237])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Sep 2019 17:30:17 +0200
Date: Tue, 24 Sep 2019 17:30:00 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: julia@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <c4437d9b-8795-fdfa-7914-fc30ead14cf7@web.de>
Message-ID: <alpine.DEB.2.21.1909241729310.2282@hadrien>
References: <e07ce253-8a13-0f90-3ee0-79c1a0e78b38@web.de>
 <alpine.DEB.2.21.1909231058380.2283@hadrien>
 <c4437d9b-8795-fdfa-7914-fc30ead14cf7@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1702486555-1569339017=:2282"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 24 Sep 2019 17:30:25 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Tue, 24 Sep 2019 17:30:23 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Reducing source code around return statements with SmPL?
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

--8323329-1702486555-1569339017=:2282
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Tue, 24 Sep 2019, Markus Elfring wrote:

> >> @@
> >> -rc = x;
> >
> > Replace by - lrc@rc = x;
>
> I have constructed the following test script for the semantic patch language.
>
> @check1@
> expression x;
> identifier rc;
> local idexpression lrc;
> position p;
> @@
>  lrc@rc = x@p;
>  return lrc;
>
> @check2@
> identifier check1.rc;
> position p;
> type t;
> @@
>  t rc@p;
>  ... when != rc
>
> @script:python to_do1@
> p << check1.p;
> @@
> coccilib.org.print_todo(p[0],
>                         "WARNING: An expression was assigned to a local variable before it will be returned by the subsequent statement.")
>
> @script:python to_do2@
> p << check2.p;
> v << check2.rc;
> @@
> coccilib.org.print_todo(p[0],
>                         "INFO: May the local variable \""
>                         + v
>                         + "\" be deleted?")
>
>
> I wonder about a corresponding test result.
>
> elfring@Sonne:~/Projekte/Coccinelle/janitor> spatch --parse-cocci move_code_to_return1.cocci
> …
> scriptmeta: semantic error: bad rule check2 or bad variable rc
>   File "move_code_to_return1.cocci", line 26, column 14, charpos = 474
>   around = ';',
>   whole content = v << check2.rc;
>
>
> I imagine that it would be easier to understand that the content from
> the inherited metavariable can be directly used.
> The SmPL specification “v << check1.rc;” gets accepted by Coccinelle software
> and seems to work then in the way I would expect it also for the other script variant.
> Will any more adjustments become relevant for such a source code search approach?

rc comes from check1 so it should be inherited from check1.

julia
--8323329-1702486555-1569339017=:2282
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1702486555-1569339017=:2282--
