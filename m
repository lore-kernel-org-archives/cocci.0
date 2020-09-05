Return-Path: <SRS0=yqrS=CO=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0956C43461
	for <cocci@archiver.kernel.org>; Sat,  5 Sep 2020 07:39:38 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCC3920760
	for <cocci@archiver.kernel.org>; Sat,  5 Sep 2020 07:39:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCC3920760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0857d9SD017540;
	Sat, 5 Sep 2020 09:39:09 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id CE236742E;
	Sat,  5 Sep 2020 09:39:09 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7AFB46717
 for <cocci@systeme.lip6.fr>; Sat,  5 Sep 2020 09:39:07 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0857d5BH017871
 for <cocci@systeme.lip6.fr>; Sat, 5 Sep 2020 09:39:05 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.76,359,1592863200"; d="scan'208";a="358156309"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Sep 2020 09:39:04 +0200
Date: Sat, 5 Sep 2020 09:39:04 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <afbbc6f1-ca60-e780-0139-d944165e456f@web.de>
Message-ID: <alpine.DEB.2.22.394.2009050937480.2363@hadrien>
References: <ed9a8046-4c21-e849-f68b-9e08991b701d@web.de>
 <8e76e81f-970b-b1f7-840d-10506dc3311a@linux.com>
 <alpine.DEB.2.22.394.2008151229540.2446@hadrien>
 <34004dc6-e7a6-7557-4c64-2ec74872baea@web.de>
 <alpine.DEB.2.22.394.2008170941280.2526@hadrien>
 <f8103248-4cbe-4c79-cdbf-d2fd758c83a4@web.de>
 <alpine.DEB.2.22.394.2008171001320.2526@hadrien>
 <cad4141c-8cba-3705-a502-0620ae3df027@web.de>
 <alpine.DEB.2.22.394.2008171023300.2526@hadrien>
 <1e60d36d-7f2b-98eb-5fe3-9729b97ba360@web.de>
 <alpine.DEB.2.22.394.2008171829080.2416@hadrien>
 <afbbc6f1-ca60-e780-0139-d944165e456f@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-687145294-1599291545=:2363"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 05 Sep 2020 09:39:10 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 05 Sep 2020 09:39:05 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] coccinelle: api: add sprintf() support to
	device_attr_show
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

--8323329-687145294-1599291545=:2363
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sat, 5 Sep 2020, Markus Elfring wrote:

> >>> What clarifications?
> >>
> >> Did you notice that my suggestion for the SmPL script variant “scripts/coccinelle/api/device_attr_show.cocci”
> >> can generate a patch?
> >> https://lore.kernel.org/cocci/0a9015b6-9037-59c5-31f2-cd2b32c86b50@linux.com/
> >>
> >> Unfortunately, it seems that this transformation approach produces also
> >> an inappropriate test result so far.
> >> Do we expect that the first part of the SmPL disjunction should match
> >> (for the source file “drivers/base/core.c” for example)?
> >
> > This semantic patch triggers the same problem as the original one,
>
> This view is interesting.
>
>
> > and should benefit from the same solution.
>
> I noticed the commit “improve andany optimization” yesterday.
> https://github.com/coccinelle/coccinelle/commit/1a5502d4be8db0623b5acead974943098bdcbf57
>
> The change description contains the following information.
>
> “…
> It also makes the test failing_andany work, which did not work previously.
> …”
>
> I would hope for further positive consequences. Thus I have tried
> the software “Coccinelle 1.0.8-00168-gc4048513” out again.
> But I observe that the expected patch is still not generated
> if a special SmPL disjunction should be applied in my test case.
> The expected test result is displayed if a source code search
> should be performed according to extracted code from the first branch
> of such a disjunction (so that no disjunction is specified in
> the SmPL script variant).
>
> How will the clarification be continued?

The clarification will be continued when you provide a small semantic
patch and a C file that causes a problem.  I'm not going to hunt in years
of mail archives to find it.  If you want something to happen you have to
provide that information now.

julia
--8323329-687145294-1599291545=:2363
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-687145294-1599291545=:2363--
