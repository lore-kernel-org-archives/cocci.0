Return-Path: <SRS0=qtAw=UG=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDEEC2BCA1
	for <cocci@archiver.kernel.org>; Fri,  7 Jun 2019 16:34:07 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7FF820825
	for <cocci@archiver.kernel.org>; Fri,  7 Jun 2019 16:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7FF820825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x57GXqod007141;
	Fri, 7 Jun 2019 18:33:52 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 04FAA7770;
	Fri,  7 Jun 2019 18:33:52 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id EC8C5776C
 for <cocci@systeme.lip6.fr>; Fri,  7 Jun 2019 18:33:50 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x57GXoc9004921
 for <cocci@systeme.lip6.fr>; Fri, 7 Jun 2019 18:33:50 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.63,563,1557180000"; d="scan'208";a="308555076"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 Jun 2019 18:33:50 +0200
Date: Fri, 7 Jun 2019 18:33:48 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <c2cf2b61-990d-af7b-2228-0e79e0daa0ce@web.de>
Message-ID: <alpine.DEB.2.20.1906071833010.14523@hadrien>
References: <69c34970-8b6d-a2a3-2e8b-0b6560f78505@metux.net>
 <6ebd6ec8-bcd0-3dac-8992-a6c8d9a14939@web.de>
 <alpine.DEB.2.20.1906061137570.7612@hadrien>
 <9745086a-cb39-b751-9cb4-faea0308e3a6@metux.net>
 <alpine.DEB.2.20.1906071430450.3692@hadrien>
 <c2cf2b61-990d-af7b-2228-0e79e0daa0ce@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-508351068-1559925228=:14523"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 07 Jun 2019 18:33:52 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Fri, 07 Jun 2019 18:33:50 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] How to replace obsolete #ifdef's?
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

--8323329-508351068-1559925228=:14523
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Fri, 7 Jun 2019, Markus Elfring wrote:

> > but not:
> >
> > @@
> > @@
> >
> > - #ifdef FOO
> >   bar();
> > - #endif
>
> The deletion of these preprocessor statements is not directly supported
> in the shown way by the Coccinelle software at the moment.
> But I got another code transformation idea which would not be so convenient.
>
> The semantic patch language supports the metavariable type “statement list”
> for a while.
> https://github.com/coccinelle/coccinelle/blob/cad4c0705f9e37f501531e133d3a47bc56ed0ce2/docs/manual/cocci_syntax.tex#L209
>
> I imagine then that the function call can be “intentionally” deleted
> and added back in such a simple SmPL script example.
>
> * Should any extra C code vanish after such a special adjustment
>   because specific parts were not restored?
>
> * Can it make sense here to change a bit of code even if it was originally
>   intended to keep it untouched?
>
>
> Will similar software updates become more challenging for the initially
> described handling of designated initialisers for known data structures?

This is in the spirit of the solution I already proposed.  The original
issue was about structure field initializations, not statements, so
statement list is not appropriate.

julia
--8323329-508351068-1559925228=:14523
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-508351068-1559925228=:14523--
