Return-Path: <SRS0=PWh2=XB=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PLING_QUERY,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF32C43331
	for <cocci@archiver.kernel.org>; Fri,  6 Sep 2019 20:20:02 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BD76207FC
	for <cocci@archiver.kernel.org>; Fri,  6 Sep 2019 20:20:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BD76207FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x86KJZls004321;
	Fri, 6 Sep 2019 22:19:35 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 209F27797;
	Fri,  6 Sep 2019 22:19:35 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 72EA77793
 for <cocci@systeme.lip6.fr>; Fri,  6 Sep 2019 22:19:31 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x86KJL3o004369
 for <cocci@systeme.lip6.fr>; Fri, 6 Sep 2019 22:19:21 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.64,474,1559512800"; d="scan'208";a="400644695"
Received: from abo-12-105-68.mrs.modulonet.fr (HELO hadrien) ([85.68.105.12])
 by mail2-relais-roc.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2019 22:19:21 +0200
Date: Fri, 6 Sep 2019 22:19:21 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Denis Efremov <efremov@linux.com>
In-Reply-To: <20190829171013.22956-1-efremov@linux.com>
Message-ID: <alpine.DEB.2.21.1909062217240.2643@hadrien>
References: <20190825130536.14683-1-efremov@linux.com>
 <20190829171013.22956-1-efremov@linux.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 06 Sep 2019 22:19:35 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Fri, 06 Sep 2019 22:19:21 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>, Joe Perches <joe@perches.com>,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH v2] scripts: coccinelle: check for !(un)?likely
	usage
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



On Thu, 29 Aug 2019, Denis Efremov wrote:

> This patch adds coccinelle script for detecting !likely and
> !unlikely usage. These notations are confusing. It's better
> to replace !likely(x) with unlikely(!x) and !unlikely(x) with
> likely(!x) for readability.
>
> The rule transforms !likely(x) to unlikely(!x) based on this logic:
>   !likely(x) iff
>   !__builtin_expect(!!(x), 1) iff
>    __builtin_expect(!!!(x), 0) iff
>   unlikely(!x)
>
> For !unlikely(x) to likely(!x):
>   !unlikely(x) iff
>   !__builtin_expect(!!(x), 0) iff
>   __builtin_expect(!!!(x), 1) iff
>   likely(!x)
>
> Signed-off-by: Denis Efremov <efremov@linux.com>
> Cc: Julia Lawall <Julia.Lawall@lip6.fr>
> Cc: Gilles Muller <Gilles.Muller@lip6.fr>
> Cc: Nicolas Palix <nicolas.palix@imag.fr>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: Markus Elfring <Markus.Elfring@web.de>
> Cc: Joe Perches <joe@perches.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Acked-by: Julia Lawall <julia.lawall@lip6.fr>

A small improvement though would be to improve the explicit dependency of
the last four python rules on r1 and r2.  Those rules won't execute unless
the inherited metavariable has a value, which makes the same dependency.

julia


> ---
>  scripts/coccinelle/misc/neg_unlikely.cocci | 89 ++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
>  create mode 100644 scripts/coccinelle/misc/neg_unlikely.cocci
>
> diff --git a/scripts/coccinelle/misc/neg_unlikely.cocci b/scripts/coccinelle/misc/neg_unlikely.cocci
> new file mode 100644
> index 000000000000..9aac0a7ff042
> --- /dev/null
> +++ b/scripts/coccinelle/misc/neg_unlikely.cocci
> @@ -0,0 +1,89 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/// Use unlikely(!x) instead of !likely(x) and vice versa.
> +/// Notations !unlikely(x) and !likely(x) are confusing.
> +//
> +// Confidence: High
> +// Copyright: (C) 2019 Denis Efremov, ISPRAS.
> +// Options: --no-includes --include-headers
> +
> +virtual patch
> +virtual context
> +virtual org
> +virtual report
> +
> +//----------------------------------------------------------
> +//  For context mode
> +//----------------------------------------------------------
> +
> +@depends on context disable unlikely@
> +expression E;
> +@@
> +
> +*! \( likely \| unlikely \) (E)
> +
> +//----------------------------------------------------------
> +//  For patch mode
> +//----------------------------------------------------------
> +
> +@depends on patch disable unlikely@
> +expression E;
> +@@
> +
> +(
> +-!likely(!E)
> ++unlikely(E)
> +|
> +-!likely(E)
> ++unlikely(!E)
> +|
> +-!unlikely(!E)
> ++likely(E)
> +|
> +-!unlikely(E)
> ++likely(!E)
> +)
> +
> +//----------------------------------------------------------
> +//  For org and report mode
> +//----------------------------------------------------------
> +
> +@r1 depends on (org || report) disable unlikely@
> +expression E;
> +position p;
> +@@
> +
> +!likely@p(E)
> +
> +@r2 depends on (org || report) disable unlikely@
> +expression E;
> +position p;
> +@@
> +
> +!unlikely@p(E)
> +
> +@script:python depends on org && r1@
> +p << r1.p;
> +@@
> +
> +coccilib.org.print_todo(p[0], "unlikely(!x) is more readable than !likely(x)")
> +
> +@script:python depends on org && r2@
> +p << r2.p;
> +@@
> +
> +coccilib.org.print_todo(p[0], "likely(!x) is more readable than !unlikely(x)")
> +
> +@script:python depends on report && r1@
> +p << r1.p;
> +@@
> +
> +coccilib.report.print_report(p[0],
> +	"unlikely(!x) is more readable than !likely(x)")
> +
> +@script:python depends on report && r2@
> +p << r2.p;
> +@@
> +
> +coccilib.report.print_report(p[0],
> +	"likely(!x) is more readable than !unlikely(x)")
> +
> --
> 2.21.0
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
