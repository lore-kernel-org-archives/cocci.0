Return-Path: <SRS0=mj88=UE=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5163C28CC5
	for <cocci@archiver.kernel.org>; Wed,  5 Jun 2019 19:59:53 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 739E4207E0
	for <cocci@archiver.kernel.org>; Wed,  5 Jun 2019 19:59:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 739E4207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x55JxOQX006141;
	Wed, 5 Jun 2019 21:59:24 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 49132776A;
	Wed,  5 Jun 2019 21:59:24 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 65BAF7767
 for <cocci@systeme.lip6.fr>; Wed,  5 Jun 2019 21:59:23 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x55JxMob004445
 for <cocci@systeme.lip6.fr>; Wed, 5 Jun 2019 21:59:22 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.60,556,1549926000"; d="scan'208";a="386162339"
Received: from abo-161-111-68.mrs.modulonet.fr (HELO hadrien) ([85.68.111.161])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Jun 2019 21:56:20 +0200
Date: Wed, 5 Jun 2019 21:56:20 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
In-Reply-To: <bd88dcf8-e3cb-4a63-8ebd-ce703506890e@metux.net>
Message-ID: <alpine.DEB.2.21.1906052154110.2622@hadrien>
References: <bd88dcf8-e3cb-4a63-8ebd-ce703506890e@metux.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 05 Jun 2019 21:59:24 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Wed, 05 Jun 2019 21:59:22 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] splitting and fingerprinting findings
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



On Wed, 5 Jun 2019, Enrico Weigelt, metux IT consult wrote:

> Hi folks,
>
>
> I'd like to hack up some scripts that automatically scan and report
> findings on a daily basis, eg. on the linux-next tree. Obviously,
> nobody can seriously read this all at once, especially not on a
> daily basis.
>
> Therefore I need to:
>
> * split the findings (eg. by ruleset or affected files / subsystems)
> * filter out findings that already have been reported.
>
> The second part seems to be trickiest one, as the code might slightly
> change in the meantime, laeding to different patch outputs. Ignoring
> the @@ lines should at least drop a large portion of the duplicates,
> but I'll yet have to see how well that works ...
>
> Did anyone else already working on that topic ?

The 0-day people do something.

The tool Herodotos addressed this, but seems to be hard to get working.

In general, you need to just interpret the report line numbers and the
diff hunks to figure out whether the report lines are or are not in the
changed lines of code.

For example, if the report was on line 69 and is now on line 70, and the
only change was to replace line 2-3 by lines 2-4, ie add a new line, then
the report on line 70 is the same as the report on line 69.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
