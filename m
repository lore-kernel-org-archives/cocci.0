Return-Path: <SRS0=TTUf=7S=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECFAC433DF
	for <cocci@archiver.kernel.org>; Fri,  5 Jun 2020 21:19:38 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19DC82074B
	for <cocci@archiver.kernel.org>; Fri,  5 Jun 2020 21:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19DC82074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 055LJZ97001355;
	Fri, 5 Jun 2020 23:19:35 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5F5A17567;
	Fri,  5 Jun 2020 23:19:35 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0A1FB3F9A
 for <cocci@systeme.lip6.fr>; Fri,  5 Jun 2020 23:19:34 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 055LJXrq024306
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 5 Jun 2020 23:19:33 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.73,477,1583190000"; d="scan'208";a="453259960"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Jun 2020 23:19:33 +0200
Date: Fri, 5 Jun 2020 23:19:32 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Denis Efremov <efremov@linux.com>
In-Reply-To: <43cead50-05f8-67ce-c1de-ce3acefb0dec@linux.com>
Message-ID: <alpine.DEB.2.21.2006052318310.28300@hadrien>
References: <20200605204237.85055-1-efremov@linux.com>
 <alpine.DEB.2.21.2006052249160.28300@hadrien>
 <43cead50-05f8-67ce-c1de-ce3acefb0dec@linux.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 05 Jun 2020 23:19:35 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 05 Jun 2020 23:19:33 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH] coccinelle: api: add kvfree script
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



On Sat, 6 Jun 2020, Denis Efremov wrote:

> On 6/5/20 11:51 PM, Julia Lawall wrote:
> > Is there a strong reason for putting the choice rule first?  It may make
> > things somewhat slower than necessary, if it matches in many places,
> > because the opportunity rule will have to detect that it doesn't care
> > about all of those places.
>
> No, I didn't know that order of rules matters. I just checked it, my PC
> shows no difference in exec time if I swap these rules.

OK, probably choice doesn't match in very many places, so there is not
much impact.

julia

>
> "choice" doesn't check the size. "opportunity" is more strict.
> The motivation for adding 2 rules is that we could recommend to use
> kvmalloc* only when there is a size condition. At the same time, we
> should skip all if (...) {kmalloc()} else {vmalloc()},
> res = kmalloc() if (!res) {vmalloc()} cases as false positives.
>
> It seems that it's not possible to use subexpression rule
> "expression size <= choice.E" in this case.
>
> > Also, there is no need to exceed 80 characters here.  You can put a
> > newline in the middle of a \( ... \)
>
> Ok, I will fix it in v2 after all comments/suggestions.
>
> Thanks,
> Denis
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
