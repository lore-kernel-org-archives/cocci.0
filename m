Return-Path: <SRS0=Ry+S=T6=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E27EC28CC0
	for <cocci@archiver.kernel.org>; Thu, 30 May 2019 00:24:36 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7540243A5
	for <cocci@archiver.kernel.org>; Thu, 30 May 2019 00:24:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7540243A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4U0OLM0006888;
	Thu, 30 May 2019 02:24:21 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 31A007762;
	Thu, 30 May 2019 02:24:21 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 6735C7756
 for <cocci@systeme.lip6.fr>; Thu, 30 May 2019 02:24:19 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4U0OIdB006370
 for <cocci@systeme.lip6.fr>; Thu, 30 May 2019 02:24:18 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.60,529,1549926000"; d="scan'208";a="307641128"
Received: from unknown (HELO hadrien) ([207.96.196.254])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 30 May 2019 02:24:17 +0200
Date: Wed, 29 May 2019 20:24:15 -0400 (EDT)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Timur Tabi <timur@kernel.org>
In-Reply-To: <CAOZdJXVd9cc4LdDmrC3=dUUEa=KqYWj6gesd=y9tNk6pUTuLMw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1905292023340.2483@hadrien>
References: <CAOZdJXUYqKX6KEwzXqMR-Wq-gsdHOZzHu9O--5HD2gmb56O36g@mail.gmail.com>
 <alpine.DEB.2.21.1905242147210.2514@hadrien>
 <CAOZdJXXV0a7VgRvLcYvzLZrPzVNsr6+WAxf4e6HDsE+U59zShA@mail.gmail.com>
 <alpine.DEB.2.21.1905242211550.2514@hadrien>
 <CAOZdJXUK1BvbfrG2KTW4r-36A115izB+cYwuaAQ8xTmu5WMHHA@mail.gmail.com>
 <CAOZdJXX_if3sa_qrVRPF-wpwEmM-_Yb=45gr+ZF==PUA3B79dA@mail.gmail.com>
 <fad7175b0c56154744004ef4a6ad248c@lip6.fr>
 <CAOZdJXVd9cc4LdDmrC3=dUUEa=KqYWj6gesd=y9tNk6pUTuLMw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 30 May 2019 02:24:21 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Thu, 30 May 2019 02:24:18 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking if a line of code *does not* exist
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



On Wed, 29 May 2019, Timur Tabi wrote:

> On Wed, May 29, 2019 at 3:31 PM Julia Lawall <Julia.Lawall@lip6.fr> wrote:
> > The + code has to be adjacent to some - or context code.  So you may
> > need to duplicate some   code in the different branches of the
> > disjunction.
>
> So you're saying that the context code can't be a disjunction?

Sort of.  If the context code is something that you want to attach added
code to, then no it cannot be a disjunction.

julia

>
> I broke my script up into two rules, and it works now.  It's not
> really that elegant, but it works.  Thanks.
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
