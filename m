Return-Path: <SRS0=yhX/=IB=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A09C433E0
	for <cocci@archiver.kernel.org>; Wed,  3 Mar 2021 16:38:18 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4043D64E6F
	for <cocci@archiver.kernel.org>; Wed,  3 Mar 2021 16:38:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4043D64E6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 123GbvOZ025084;
	Wed, 3 Mar 2021 17:37:57 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2649577CC;
	Wed,  3 Mar 2021 17:37:57 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id EDCB5571B
 for <cocci@systeme.lip6.fr>; Wed,  3 Mar 2021 17:37:54 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 123Gbsve029987
 for <cocci@systeme.lip6.fr>; Wed, 3 Mar 2021 17:37:54 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.81,220,1610406000"; d="scan'208";a="495951182"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 03 Mar 2021 17:37:54 +0100
Date: Wed, 3 Mar 2021 17:37:54 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Denis Efremov <efremov@linux.com>
In-Reply-To: <20210219092448.13760-1-efremov@linux.com>
Message-ID: <alpine.DEB.2.22.394.2103031736290.2980@hadrien>
References: <20210216080133.455456-1-efremov@linux.com>
 <20210219092448.13760-1-efremov@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 03 Mar 2021 17:37:57 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 03 Mar 2021 17:37:54 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH v2] coccinelle: misc: add swap script
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



On Fri, 19 Feb 2021, Denis Efremov wrote:

> Check for opencoded swap() implementation.
>
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
> Changes in v2:
>  - additional patch rule to drop excessive {}
>  - fix indentation in patch mode by anchoring ;
>
>  scripts/coccinelle/misc/swap.cocci | 101 +++++++++++++++++++++++++++++
>  1 file changed, 101 insertions(+)
>  create mode 100644 scripts/coccinelle/misc/swap.cocci
>
> diff --git a/scripts/coccinelle/misc/swap.cocci b/scripts/coccinelle/misc/swap.cocci
> new file mode 100644
> index 000000000000..d5da9888c222
> --- /dev/null
> +++ b/scripts/coccinelle/misc/swap.cocci
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +///
> +/// Check for opencoded swap() implementation.
> +///
> +// Confidence: High
> +// Copyright: (C) 2021 Denis Efremov ISPRAS
> +// Options: --no-includes --include-headers
> +//
> +// Keywords: swap
> +//
> +
> +virtual patch
> +virtual org
> +virtual report
> +virtual context
> +
> +@r depends on !patch@
> +identifier tmp;
> +expression a, b;
> +type T;
> +position p;
> +@@
> +
> +(
> +* T tmp;
> +|
> +* T tmp = 0;
> +|
> +* T *tmp = NULL;
> +)
> +... when != tmp
> +* tmp = a;
> +* a = b;@p
> +* b = tmp;
> +... when != tmp
> +
> +@rpvar depends on patch@
> +identifier tmp;
> +expression a, b;
> +type T;
> +@@
> +
> +(
> +- T tmp;
> +|
> +- T tmp = 0;
> +|
> +- T *tmp = NULL;
> +)
> +... when != tmp
> +- tmp = a;
> +- a = b;
> +- b = tmp
> ++ swap(a, b)
> +  ;
> +... when != tmp
> +
> +
> +@rp depends on patch@
> +identifier tmp;
> +expression a, b;
> +@@
> +
> +- tmp = a;
> +- a = b;
> +- b = tmp
> ++ swap(a, b)
> +  ;

A rule like the above should also appear in the non-patch case.

> +
> +@depends on (rpvar || rp)@

This needs to be depends on patch && (rpvar || rp).  It doesn't make much
sense, because rpvar and rp both depend on patch, but at the moment that
information isn't propagate everywhere that it is needed.

thanks,
julia

> +@@
> +
> +(
> +  for (...;...;...)
> +- {
> +	swap(...);
> +- }
> +|
> +  while (...)
> +- {
> +	swap(...);
> +- }
> +|
> +  if (...)
> +- {
> +	swap(...);
> +- }
> +)
> +
> +
> +@script:python depends on report@
> +p << r.p;
> +@@
> +
> +coccilib.report.print_report(p[0], "WARNING opportunity for swap()")
> +
> +@script:python depends on org@
> +p << r.p;
> +@@
> +
> +coccilib.org.print_todo(p[0], "WARNING opportunity for swap()")
> --
> 2.26.2
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
