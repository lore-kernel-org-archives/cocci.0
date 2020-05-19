Return-Path: <SRS0=x7/Q=7B=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1B4C433DF
	for <cocci@archiver.kernel.org>; Tue, 19 May 2020 11:56:00 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DB332072C
	for <cocci@archiver.kernel.org>; Tue, 19 May 2020 11:55:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DB332072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04JBtuQX026306;
	Tue, 19 May 2020 13:55:56 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 68F1E7559;
	Tue, 19 May 2020 13:55:56 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2C2C83DC8
 for <cocci@systeme.lip6.fr>; Tue, 19 May 2020 13:55:55 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04JBtshv028427
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 19 May 2020 13:55:54 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.73,410,1583190000"; d="scan'208";a="450388544"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 May 2020 13:55:43 +0200
Date: Tue, 19 May 2020 13:55:43 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <9b764738-8c6d-b066-925e-03d26c5ed063@web.de>
Message-ID: <alpine.DEB.2.21.2005191355060.2503@hadrien>
References: <4a677190-b494-138c-4782-eec033a77377@web.de>
 <alpine.DEB.2.21.2005181118540.2467@hadrien>
 <0a93e321-42de-3534-9c4a-d67132a1289e@web.de>
 <alpine.DEB.2.21.2005181217580.2467@hadrien>
 <8f3cbbd1-653e-ab2d-5a41-18eec00ae828@web.de>
 <alpine.DEB.2.21.2005181234210.2467@hadrien>
 <e3d5a92f-0c78-c1ca-47ab-d2bb2864efaa@web.de>
 <alpine.DEB.2.21.2005181248310.2467@hadrien>
 <5c451649-4077-e54c-e01d-6bdbc0d02046@web.de>
 <alpine.DEB.2.21.2005191321270.2503@hadrien>
 <9b764738-8c6d-b066-925e-03d26c5ed063@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1881650090-1589889344=:2503"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 19 May 2020 13:55:56 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 19 May 2020 13:55:54 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Chuhong Yuan <hslester96@gmail.com>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] How to match function calls in macros?
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

--8323329-1881650090-1589889344=:2503
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Tue, 19 May 2020, Markus Elfring wrote:

> >> With which SmPL constructs should be ensured that a search pattern
> >> like “<+... f(...) ...+>” refers only to content from the same logical source line?
> >> https://en.cppreference.com/w/c/language/translation_phases#Phase_2
> >
> > Please stop asking the same question over and over.
>
> I hope that the expected and actually supported software functionality
> will become clearer.
>
>
> > In the context of a macro definition, <+... f(...) ...+> will only match
> > what is from the same logical source line.
>
> Does the functionality of the SmPL nest construct change according to
> previous source code?
>
> Are there more aspects to consider for the safe handling of physical source lines?
>
>
> > Because that is all that there is in a macro definition.
>
> We hope so also according to the initial clarification request for this issue.
>
>
> > If Coccinelle is working on a macro definition, it works only on that macro definition.
>
> Such an expectation can eventually be fine.
>
> Did I overlook any information for this detail in the software documentation so far?
> https://github.com/coccinelle/coccinelle/blob/7cf2c23e64066d5249a64a316cc5347831f7a63f/docs/manual/cocci_syntax.tex#L1736
>
>
> > If it is working on a function definition, it works only on that function definition.
>
> Does the position of the define directive influence this view?

I believe that the #defines inside of other top-level definitions are
ignored.

julia
--8323329-1881650090-1589889344=:2503
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1881650090-1589889344=:2503--
