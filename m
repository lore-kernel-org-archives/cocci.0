Return-Path: <SRS0=D+wQ=BN=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960F1C433DF
	for <cocci@archiver.kernel.org>; Mon,  3 Aug 2020 05:46:29 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4B2120678
	for <cocci@archiver.kernel.org>; Mon,  3 Aug 2020 05:46:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4B2120678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0735kGSs028293;
	Mon, 3 Aug 2020 07:46:16 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 62FF076BF;
	Mon,  3 Aug 2020 07:46:16 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9C0365F8F
 for <cocci@systeme.lip6.fr>; Mon,  3 Aug 2020 07:46:14 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0735kEmE007990
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 3 Aug 2020 07:46:14 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.75,429,1589234400"; d="scan'208";a="462220546"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 03 Aug 2020 07:46:13 +0200
Date: Mon, 3 Aug 2020 07:46:13 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <3474ebf5-c902-63e9-8244-08a0f3407b72@web.de>
Message-ID: <alpine.DEB.2.22.394.2008030742430.2463@hadrien>
References: <e4f3c4e8-03e8-dbc2-5871-0d111b3086a4@web.de>
 <alpine.DEB.2.22.394.2008020904310.2531@hadrien>
 <eead5e2a-da8d-83cd-eeb4-f193702b800f@web.de>
 <alpine.DEB.2.22.394.2008021348430.2531@hadrien>
 <82af6b44-ea09-b86f-81f7-e96e8594a31d@web.de>
 <alpine.DEB.2.22.394.2008021513010.2531@hadrien>
 <065fee88-5206-5d9b-c83c-4e6a20aefd85@web.de>
 <alpine.DEB.2.22.394.2008021632210.2531@hadrien>
 <8f357aa0-7811-a5b8-a061-814899654e88@web.de>
 <alpine.DEB.2.22.394.2008021733340.2531@hadrien>
 <c1822815-456f-316d-93b5-88beb55a0d69@web.de>
 <alpine.DEB.2.22.394.2008021814220.2531@hadrien>
 <74a5a472-4431-46e7-bd8b-95886f031c93@web.de>
 <alpine.DEB.2.22.394.2008021859010.2531@hadrien>
 <3474ebf5-c902-63e9-8244-08a0f3407b72@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-179170918-1596433574=:2463"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 03 Aug 2020 07:46:16 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 03 Aug 2020 07:46:14 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] [00/43] cocci: Add support for meta attributes to SmPL
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

--8323329-179170918-1596433574=:2463
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Mon, 3 Aug 2020, Markus Elfring wrote:

> >> Do you care if a SmPL name variable would accidentally not be used
> >> (like in the script “https://github.com/coccinelle/coccinelle/blob/04f36d537b9f6c0c127d05184cccd21f1a46b952/tests/metaattr.cocci#L2”)?
> >
> > It actually is used, to help parsing the .c file.  This information will
> > be added to the documentation shortly.
>
> I would expect that the following SmPL script variant will generate
> also a patch.
> (Why would extra “help” be needed for parsing source files?)
>
> @replacement@
> attribute a;
> identifier b;
> @@
> -int
> +char
>  b a = 1;

Only if the C code is able to be parsed (note that you could have tested
this instead of expecting something).

It's not well defined whether something is an attribute or not.
Coccinelle has some heuristics for that.

But even if the declaration is completely useless, I also don't care.
It's one line in a test case.  It hurts nothing.  Much more time has been
wasted on this discussion than on any confusion that line would cause.

>
>
> By the way:
> I have noticed another detail which I find questionable at the moment.
>
> elfring@Sonne:~/Projekte/Coccinelle/20160205> spatch --parse-cocci tests/metaattr-2.cocci
> …
> (
> -int
>   >>> char
>  b a = 1;
> |
> -signed
>   >>> char
> -int b a = 1;
> )
> …
>
> I would interpret the display for the second part of such a SmPL
> disjunction in the way that a variable definition will be deleted
> (instead of taking only the key word “signed” also into account
> according to the isomorphism “add_signed”).

I'm not sure why the whole declaration became removed.  Thanks for the
report.

julia
--8323329-179170918-1596433574=:2463
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-179170918-1596433574=:2463--
