Return-Path: <SRS0=VydO=XA=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C710C3A5A5
	for <cocci@archiver.kernel.org>; Thu,  5 Sep 2019 12:03:43 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EDEB2070C
	for <cocci@archiver.kernel.org>; Thu,  5 Sep 2019 12:03:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EDEB2070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x85C3VjU022242;
	Thu, 5 Sep 2019 14:03:31 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4E1E67797;
	Thu,  5 Sep 2019 14:03:31 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9E02A7796
 for <cocci@systeme.lip6.fr>; Thu,  5 Sep 2019 14:03:29 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x85C3T37000487
 for <cocci@systeme.lip6.fr>; Thu, 5 Sep 2019 14:03:29 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.64,470,1559512800"; d="scan'208";a="400402596"
Received: from portablejulia.rsr.lip6.fr ([132.227.76.63])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Sep 2019 14:03:29 +0200
Date: Thu, 5 Sep 2019 14:03:28 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: julia@hadrien
To: Valentin Schneider <valentin.schneider@arm.com>
In-Reply-To: <d9df847c-199d-e78d-aff2-6f14629d63b5@arm.com>
Message-ID: <alpine.DEB.2.21.1909051358550.2651@hadrien>
References: <d9df847c-199d-e78d-aff2-6f14629d63b5@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 05 Sep 2019 14:03:31 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Thu, 05 Sep 2019 14:03:29 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Matching variable declarations
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



On Thu, 5 Sep 2019, Valentin Schneider wrote:

> Hi,
>
> I'm trying to change the type of variables that match a certain rule.
> Abstracting away this specific rule and only looking at coming up with a
> rule to match variable declarations, I have a few newbie questions.
>
> Say I want to replace all long declarations into ints, this simple rule
> seems to be working fine:
>
> ---
> @@
> identifier var;
> type T = long;
> expression E;
> @@
>
> (
> - T var;
> + int var;
> |
> - T var = E;
> + int var = E;
> )

You could just replace the T by long in the above.

You could also forget about the declaration part and just put

- long
+ int

if you just want to change the types everywhere.

> ---
>
> I tried to write it as
> ---
> - T
> + int
> var
> ? = E
> ;
> ---
> but that doesn't seem to be a valid syntax.

No.  ? is restricted to complete statements.

>
>
> Now, I'd like to match declarations of several variables in a single
> statement as well.
>
> Say I want to get something like
>
> - long a, b = 2, c, d = 42, e;
> + long a, b = 2, c, e;
> + int d = 42;
>
>  (match on longs initialized to 42)
>
> My current attempt is
> ---
> @@
> identifier var;
> type T = long;
> expression L, R;
> @@
>
> T L,
> - var = 42
> R;
> + int var;
> ---
> But that isn't valid either. How should I go about writing this sort of
> rule?

Declaartions with multiple variables are tricky.  By the following may
work:

- long
+ int
  x;

Since you are leaving the variables alone in this case, I think this will
match thing that declare multiple variables as well.

>
> If you're curious, there's more context about what I'm trying to achieve
> at:
>
> https://lore.kernel.org/lkml/20190902210558.GA23013@avx2/

I guess your next question will be about converting %ld to %d, etc.

It may be helpful to look at coccinelle/demos/format.cocci

julia


>
> Thanks,
> Valentin
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
