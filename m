Return-Path: <SRS0=v8/u=UF=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE9BC04AB5
	for <cocci@archiver.kernel.org>; Thu,  6 Jun 2019 09:39:14 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C39320693
	for <cocci@archiver.kernel.org>; Thu,  6 Jun 2019 09:39:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C39320693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x569d2eW005710;
	Thu, 6 Jun 2019 11:39:02 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C999F7760;
	Thu,  6 Jun 2019 11:39:02 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 289F0775C
 for <cocci@systeme.lip6.fr>; Thu,  6 Jun 2019 11:39:02 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x569d1K3018990
 for <cocci@systeme.lip6.fr>; Thu, 6 Jun 2019 11:39:01 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.63,558,1557180000"; d="scan'208";a="308366284"
Received: from unknown (HELO hadrien.local) ([132.227.124.70])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Jun 2019 11:39:01 +0200
Date: Thu, 6 Jun 2019 11:39:01 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <6ebd6ec8-bcd0-3dac-8992-a6c8d9a14939@web.de>
Message-ID: <alpine.DEB.2.20.1906061137570.7612@hadrien>
References: <69c34970-8b6d-a2a3-2e8b-0b6560f78505@metux.net>
 <6ebd6ec8-bcd0-3dac-8992-a6c8d9a14939@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 06 Jun 2019 11:39:03 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Thu, 06 Jun 2019 11:39:01 +0200 (CEST)
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

On Thu, 6 Jun 2019, Markus Elfring wrote:

> > It seems that spatch currently just doesn't understand preprocessor
> > directives at all,
>
> I find this view only partly appropriate.
> There is preprocessor functionality supported by the semantic patch language.
>
> Example:
> https://github.com/coccinelle/coccinelle/blob/cad4c0705f9e37f501531e133d3a47bc56ed0ce2/docs/manual/cocci_syntax.tex#L1125
>
>
> > just treats them as literal strings.
>
> See also:
> https://github.com/coccinelle/coccinelle/blob/cad4c0705f9e37f501531e133d3a47bc56ed0ce2/docs/manual/cocci_syntax.tex#L1765

To be less cryptic, Coccinelle supprorts matching and transformation for
#include and #define, and addition of comments pragmas and ifdefs.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
