Return-Path: <SRS0=UFPg=6Q=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAF5C3A5A9
	for <cocci@archiver.kernel.org>; Sat,  2 May 2020 07:05:42 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A2FF216FD
	for <cocci@archiver.kernel.org>; Sat,  2 May 2020 07:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A2FF216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04275Vsj000701;
	Sat, 2 May 2020 09:05:31 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B8638757C;
	Sat,  2 May 2020 09:05:31 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C23BC3C89
 for <cocci@systeme.lip6.fr>; Sat,  2 May 2020 09:05:30 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04275U5k020420
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sat, 2 May 2020 09:05:30 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.73,343,1583190000"; d="scan'208";a="447847515"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 02 May 2020 09:05:30 +0200
Date: Sat, 2 May 2020 09:05:29 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <96ecd52e-ffa6-87a3-ad45-79ad6ec6176e@web.de>
Message-ID: <alpine.DEB.2.21.2005020904160.2538@hadrien>
References: <fd0d48f1-ba0a-74d6-6eeb-7494600067f7@web.de>
 <alpine.DEB.2.21.2005011348250.2504@hadrien>
 <96ecd52e-ffa6-87a3-ad45-79ad6ec6176e@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1228009143-1588403130=:2538"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 02 May 2020 09:05:32 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 02 May 2020 09:05:30 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Searching for global items in the source code
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

--8323329-1228009143-1588403130=:2538
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sat, 2 May 2020, Markus Elfring wrote:

> >> @display@
> >> identifier action;
> >> type return_type;
> >> @@
> >> *return_type action(...)
> >>  {
> >>  ...
> >>  }
> >>  EXPORT_SYMBOL(action);
> …
> > In this case, the problem entirely on your side.  You should separate the
> > two top-level declarations into two separate rules, just like any other
> > two top-level declarations you would like to match.
>
> My SmPL script example affects the understanding of the software behaviour
> also around the following information.
> https://github.com/coccinelle/coccinelle/blob/a549b9f0a20e14fe9c36f45990b40dc5708ef8f2/docs/manual/cocci_syntax.tex#L1649
>
> “…
> All matching done by a SmPL rule is done intraprocedurally.
> …”
>
>
> * How are items represented from the global name space?
>
> * Would the interpretation of the situation be adjusted if a macro call
>   and a function implementation would be moved into an other usage context
>   like a C++ class (or an enclosing function implementation)?

I don't understand any of the above.


>
>
> > You also need a
> >
> > declarer name EXPORT_SYMBOL;
> >
> > in the rule that you need to create for matching that part of the code.
>
> Can it become interesting to match a macro call (or a similar annotation/attribute)
> also without the declaration of such a metavariable?
> https://github.com/coccinelle/coccinelle/blob/a549b9f0a20e14fe9c36f45990b40dc5708ef8f2/docs/manual/cocci_syntax.tex#L310

It has nothing to do with EXPORT_SYMBOL being a macro.  The declaration is
needed to tell Coccinelle to look for the thing at top level.  Otherwise
EXPORT_SYMBOL(...); looks like a function call.

julia
--8323329-1228009143-1588403130=:2538
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1228009143-1588403130=:2538--
