Return-Path: <SRS0=hgwh=XT=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A829C432C1
	for <cocci@archiver.kernel.org>; Tue, 24 Sep 2019 20:52:56 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C9B1207FD
	for <cocci@archiver.kernel.org>; Tue, 24 Sep 2019 20:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C9B1207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8OKqh31002840;
	Tue, 24 Sep 2019 22:52:43 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1DFFA77AB;
	Tue, 24 Sep 2019 22:52:43 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 30E36779E
 for <cocci@systeme.lip6.fr>; Tue, 24 Sep 2019 22:52:41 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8OKqeUi006031
 for <cocci@systeme.lip6.fr>; Tue, 24 Sep 2019 22:52:40 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.64,545,1559512800"; d="scan'208";a="320517069"
Received: from ip-215.net-89-2-7.rev.numericable.fr (HELO hadrien)
 ([89.2.7.215])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Sep 2019 22:52:40 +0200
Date: Tue, 24 Sep 2019 22:52:40 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <3628f3d4-b9c2-d42a-b1a9-d5e7fe32f171@web.de>
Message-ID: <alpine.DEB.2.21.1909242249540.2589@hadrien>
References: <e07ce253-8a13-0f90-3ee0-79c1a0e78b38@web.de>
 <alpine.DEB.2.21.1909231058380.2283@hadrien>
 <e3e922ef-fab2-ee5c-57f1-0f36ccc682fd@web.de>
 <alpine.DEB.2.21.1909242219450.2589@hadrien>
 <3628f3d4-b9c2-d42a-b1a9-d5e7fe32f171@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-731177375-1569358360=:2589"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 24 Sep 2019 22:52:43 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Tue, 24 Sep 2019 22:52:40 +0200 (CEST)
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

--8323329-731177375-1569358360=:2589
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Tue, 24 Sep 2019, Markus Elfring wrote:

> >> I suggest to compare this output with the following source code transformation approach.
> …
> >> * Why are the functions “ptrace_hbp_create” and “ptrace_hbp_fill_attr_ctrl”
> >>   presented here?
> >
> > What does "here" mean.  You give two semantic patches with two sets of
> > output.  Which is here?
>
> Please check the relevance of the mentioned two function names once more.
>
>
> >> * Why is the first variable declaration from the function “ptrace_hbp_set_addr”
> >>   not marked by the SmPL asterisk functionality in this test example?
> >
> > I don't know what you ae referring to so I can't answer precisely,
>
> Do you find corresponding links clearer?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/kernel/ptrace.c?id=08f103b9a9502974109fab47ea35ca8542c4e57a#n451
> https://elixir.bootlin.com/linux/v5.3.1/source/arch/arm64/kernel/ptrace.c#L451
>
>
> > but you should know that the only connection between your first two rules with a *
> > is the name of an identifier.
>
> I would expect that the selected identifier should refer to the same scope
> of the enclosing function implementation.

It doesn't.  Identifier metavariables have no scope, and scope is only
taken into account within a rule, not beterrn rules.

>
>
> > There is no guarantee that the two rules match code in the same function.
>
> Will any additional metavariables be needed to achieve this?

Maybe you can match the whole function definition.

julia
--8323329-731177375-1569358360=:2589
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-731177375-1569358360=:2589--
