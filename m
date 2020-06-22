Return-Path: <SRS0=BYw3=AD=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF68C433E0
	for <cocci@archiver.kernel.org>; Mon, 22 Jun 2020 12:19:20 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61215206FA
	for <cocci@archiver.kernel.org>; Mon, 22 Jun 2020 12:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61215206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05MCJ9G8025880;
	Mon, 22 Jun 2020 14:19:09 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 9580E7773;
	Mon, 22 Jun 2020 14:19:09 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 589223BAB
 for <cocci@systeme.lip6.fr>; Mon, 22 Jun 2020 14:19:07 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05MCJ6MV011145
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 22 Jun 2020 14:19:06 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.75,266,1589234400"; d="scan'208";a="352352552"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 22 Jun 2020 14:19:06 +0200
Date: Mon, 22 Jun 2020 14:19:06 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Denis Efremov <efremov@linux.com>
In-Reply-To: <e57c419b-a64a-55a1-be7a-8f45edaea3bf@linux.com>
Message-ID: <alpine.DEB.2.22.394.2006221418110.2531@hadrien>
References: <20200615102045.4558-1-efremov@linux.com>
 <20200619131313.15468-1-efremov@linux.com>
 <alpine.DEB.2.22.394.2006212255140.2501@hadrien>
 <e57c419b-a64a-55a1-be7a-8f45edaea3bf@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 22 Jun 2020 14:19:09 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 22 Jun 2020 14:19:07 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH v3] coccinelle: misc: add array_size_dup script
 to detect missed overflow checks
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



On Mon, 22 Jun 2020, Denis Efremov wrote:

> What do you think about removing duplicates warning from the rule?
>
> I mean this kind of warnings: "WARNING: same array_size (line {p1[0].line})"
>
> As for now, I think it's better to not disturb developers with this kind
> of things.

I agree.  I guess there is a small overhead for the test, but if the code
is not performance critical, being simpler is probably better.

julia


>
> Thanks,
> Denis
>
> >> +@as_dup@
> >> +expression subE1 <= as.E1;
> >> +expression subE2 <= as.E2;
> >> +expression as.E1, as.E2, E3;
> >> +assignment operator aop;
> >> +position p1, p2;
> >> +@@
> >> +
> >> +* array_size(E1, E2)@p1
> >> +  ... when != \(E1\|E2\|subE1\|subE2\) aop E3
> >> +      when != &\(E1\|E2\|subE1\|subE2\)
> >> +* array_size(E1, E2)@p2
> >> +
> >> +@script:python depends on report@
> >> +p1 << as_dup.p1;
> >> +p2 << as_dup.p2;
> >> +@@
> >> +
> >> +coccilib.report.print_report(p2[0],
> >> +f"WARNING: same array_size (line {p1[0].line})")
> >> +
> >> +@script:python depends on org@
> >> +p1 << as_dup.p1;
> >> +p2 << as_dup.p2;
> >> +@@
> >> +
> >> +coccilib.org.print_todo(p2[0],
> >> +f"WARNING: same array_size (line {p1[0].line})")
> >> +
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
