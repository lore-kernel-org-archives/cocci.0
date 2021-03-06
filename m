Return-Path: <SRS0=bgrw=IE=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1254FC433E0
	for <cocci@archiver.kernel.org>; Sat,  6 Mar 2021 14:09:25 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 258C865000
	for <cocci@archiver.kernel.org>; Sat,  6 Mar 2021 14:09:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 258C865000
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 126E8w1E017062;
	Sat, 6 Mar 2021 15:08:58 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 785D977CC;
	Sat,  6 Mar 2021 15:08:58 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 04BC9571B
 for <cocci@systeme.lip6.fr>; Sat,  6 Mar 2021 15:08:57 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 126E8uh7011090
 for <cocci@systeme.lip6.fr>; Sat, 6 Mar 2021 15:08:56 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.81,228,1610406000"; d="scan'208";a="496489458"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Mar 2021 15:08:56 +0100
Date: Sat, 6 Mar 2021 15:08:56 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Denis Efremov <efremov@linux.com>
In-Reply-To: <20210219090655.8985-1-efremov@linux.com>
Message-ID: <alpine.DEB.2.22.394.2103061503290.2976@hadrien>
References: <20210216160326.1341741-1-efremov@linux.com>
 <20210219090655.8985-1-efremov@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 06 Mar 2021 15:08:59 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 06 Mar 2021 15:08:56 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH v2 RESEND] coccinelle: misc: add minmax script
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

> Check for opencoded min(), max() implementations.
>
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>
> Changes in v2:
>  - <... ...> instead of ... when any
>  - org mode reports fixed
>  - patch rule to drop excessive ()
>
>  scripts/coccinelle/misc/minmax.cocci | 224 +++++++++++++++++++++++++++
>  1 file changed, 224 insertions(+)
>  create mode 100644 scripts/coccinelle/misc/minmax.cocci
>
> diff --git a/scripts/coccinelle/misc/minmax.cocci b/scripts/coccinelle/misc/minmax.cocci
> new file mode 100644
> index 000000000000..61d6b61fd82c
> --- /dev/null
> +++ b/scripts/coccinelle/misc/minmax.cocci
> @@ -0,0 +1,224 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +///
> +/// Check for opencoded min(), max() implementations.
> +/// Generated patches sometimes require adding a cast to fix compile warning.
> +/// Warnings/patches scope intentionally limited to a function body.
> +///
> +// Confidence: Medium
> +// Copyright: (C) 2021 Denis Efremov ISPRAS
> +// Options: --no-includes --include-headers
> +//
> +// Keywords: min, max
> +//
> +
> +
> +virtual report
> +virtual org
> +virtual context
> +virtual patch
> +
> +@rmax depends on !patch@
> +identifier func;
> +expression x, y;
> +binary operator cmp = {>, >=};
> +position p;
> +@@
> +
> +func(...)
> +{
> +	<...
> +*	x cmp@p y ? x : y

The rule below indicated with FIXME is supposed to deal with the
possibility of () that are unnecessary when using min and max.  It doesn't
work, because <... P ...> allow P to match 0 or more times, and thus
func@p matches every function.

A simpler solution is to just allow arbitrary () in the pattern, eg:

  (x) cmp@p (y) ? (x) : (y)

That will allow each occurrence of x and y to occur with and without
parentheses.  In the submitted  semantic patch, the () issue was only
considered in the patch case.  But it actually affects the purely matching
cases too, because () can be used at one occurrence, but not the other.

> +@script:python depends on report@
> +p << rmax.p;
> +@@
> +
> +coccilib.report.print_report(p[0], "WARNING opportunity for max()")

p is an array because it can be bound to different positions on different
control-flow paths.  Notably this occurs with <... ...>.  If there are
multiple occurrences of the pattern, there will be one match that contains
all of them.  Thus the reporting code should be:

for p0 in p:
  coccilib.report.print_report(p0, "WARNING opportunity for max()")

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
