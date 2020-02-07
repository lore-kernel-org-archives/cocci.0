Return-Path: <SRS0=Ekfz=33=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9438CC2D0B1
	for <cocci@archiver.kernel.org>; Fri,  7 Feb 2020 06:48:46 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3594A2082E
	for <cocci@archiver.kernel.org>; Fri,  7 Feb 2020 06:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3594A2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0176mWAg022027;
	Fri, 7 Feb 2020 07:48:32 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 43F5377EF;
	Fri,  7 Feb 2020 07:48:32 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9C242772B
 for <cocci@systeme.lip6.fr>; Fri,  7 Feb 2020 07:48:30 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0176mSC4008065
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 7 Feb 2020 07:48:28 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.70,412,1574118000"; d="scan'208";a="338361646"
Received: from arennes-656-1-381-165.w90-32.abo.wanadoo.fr (HELO hadrien)
 ([90.32.253.165])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 Feb 2020 07:48:23 +0100
Date: Fri, 7 Feb 2020 07:48:22 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: Pan Nengyuan <pannengyuan@huawei.com>
In-Reply-To: <33151da0-3414-a1de-5828-58fc89d77390@huawei.com>
Message-ID: <alpine.DEB.2.21.2002070746330.2281@hadrien>
References: <33151da0-3414-a1de-5828-58fc89d77390@huawei.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 07 Feb 2020 07:48:32 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 07 Feb 2020 07:48:28 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: kuhn.chenqun@huawei.com, cocci@systeme.lip6.fr
Subject: Re: [Cocci] Q: does spatch understand g_autoptr/g_autofree?
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



On Fri, 7 Feb 2020, Pan Nengyuan wrote:

> Hello,
>
> I have an example:
>
>     @@ expression d,p; @@
>
>     - g_autoptr(d) p;
>     + g_autoptr(d) p = NULL;
>
> C source code:
>
>     void f(void)
>     {
>         g_autoptr(Test) *p1;
>     }
>
> Then I got this error:
> minus: parse error:
>   File "test.cocci", line 3, column 15, charpos = 38
>   around = 'p',
>   whole content = - g_autoptr(d) p;
>
>
> is it correct?

No, Coccinelle knows nothing about these things.  If you don't care about
the types of these variables, you can extend standard.h to say

#define g_autoptr(x) int

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
