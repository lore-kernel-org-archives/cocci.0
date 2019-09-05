Return-Path: <SRS0=VydO=XA=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18DEC3A5A5
	for <cocci@archiver.kernel.org>; Thu,  5 Sep 2019 06:29:54 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51F962168B
	for <cocci@archiver.kernel.org>; Thu,  5 Sep 2019 06:29:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51F962168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x856Tdwa013056;
	Thu, 5 Sep 2019 08:29:39 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 83B107796;
	Thu,  5 Sep 2019 08:29:39 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 60EB1778F
 for <cocci@systeme.lip6.fr>; Thu,  5 Sep 2019 08:29:37 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x856TasT017488
 for <cocci@systeme.lip6.fr>; Thu, 5 Sep 2019 08:29:36 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.64,469,1559512800"; d="scan'208";a="318334487"
Received: from abo-12-105-68.mrs.modulonet.fr (HELO hadrien) ([85.68.105.12])
 by mail3-relais-sop.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2019 08:20:03 +0200
Date: Thu, 5 Sep 2019 08:20:02 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Denis Efremov <efremov@linux.com>
In-Reply-To: <20190904221223.5281-1-efremov@linux.com>
Message-ID: <alpine.DEB.2.21.1909050816370.2815@hadrien>
References: <20190904221223.5281-1-efremov@linux.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 05 Sep 2019 08:29:40 +0200 (CEST)
X-Greylist: Delayed for 00:09:33 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Thu, 05 Sep 2019 08:29:36 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] [RFC PATCH] coccinelle: check for integer overflow in
 binary search
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



On Thu, 5 Sep 2019, Denis Efremov wrote:

> This is an RFC. I will resend the patch after feedback. Currently
> I'm preparing big patchset with bsearch warnings fixed. The rule will
> be a part of this patchset if it will be considered good enough for
> checking.
>
> There is a known integer overflow error [1] in the binary search
> algorithm. Google faced it in 2006 [2]. This rule checks midpoint
> calculation in binary search for overflow, i.e., (l + h) / 2.
> Not every match is an actual error since the array could be small
> enough. However, a custom implementation of binary search is
> error-prone and it's better to use the library function (lib/bsearch.c)
> or to apply defensive programming for midpoint calculation.
>
> [1] https://en.wikipedia.org/wiki/Binary_search_algorithm#Implementation_issues
> [2] https://ai.googleblog.com/2006/06/extra-extra-read-all-about-it-nearly.html
>
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  scripts/coccinelle/misc/bsearch.cocci | 80 +++++++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 scripts/coccinelle/misc/bsearch.cocci
>
> diff --git a/scripts/coccinelle/misc/bsearch.cocci b/scripts/coccinelle/misc/bsearch.cocci
> new file mode 100644
> index 000000000000..a99d9a8d3ee5
> --- /dev/null
> +++ b/scripts/coccinelle/misc/bsearch.cocci
> @@ -0,0 +1,80 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/// Check midpoint calculation in binary search algorithm for integer overflow
> +/// error [1]. Google faced it in 2006 [2]. Not every match is an actual error
> +/// since the array can be small enough. However, a custom implementation of
> +/// binary search is error-prone and it's better to use the library function
> +/// (lib/bsearch.c) or to apply defensive programming for midpoint calculation.
> +///
> +/// [1] https://en.wikipedia.org/wiki/Binary_search_algorithm#Implementation_issues
> +/// [2] https://ai.googleblog.com/2006/06/extra-extra-read-all-about-it-nearly.html
> +//
> +// Confidence: Medium
> +// Copyright: (C) 2019 Denis Efremov, ISPRAS
> +// Comments:
> +// Options: --no-includes --include-headers
> +
> +virtual report
> +virtual org
> +
> +@r depends on org || report@
> +identifier l, h, m;
> +statement S;
> +position p;
> +// to match 1 in <<
> +// to match 2 in /
> +// Can't use exact values, e.g. 2, because it fails to match 2L.
> +// TODO: Is there an isomorphism for 2, 2L, 2U, 2UL, 2ULL, etc?
> +constant c;

As far as I can see, you aren't checking for 2 at all at the moment?  You
should be able to say constant c = {2, 2L, etc};.  Actually, we do
consider several variants of 0, so it could be reasonable to allow eg 2 to
match other variants as well.

> +// TODO: Is there an isomorphism for (a / 2) === (a >> 1)?

No.  I'm not sure it's common enough to be worth it.  But it could be
added if it seems like a good idea.

> +@@
> +(
> + while (\(l < h\|l <= h\|(h - l) > 1\|(l + 1) < h\|l < (h - 1)\)) {
> +  ...
> +(
> +  ((l + h)@p / c)
> +|
> +  ((l + h)@p >> c)
> +)
> +  ...
> + }
> +//TODO: Is it possible to match "do {} while ();" loops?

Not at the moment.  There is some work on it, but it is not complete
(adding Evan in CC).

julia

> +// |
> +//  do {
> +//   ...
> +// (
> +//   ((l + h)@p / c)
> +// |
> +//   ((l + h)@p >> c)
> +// )
> +//   ...
> +//  } while (\(l < h\|l <= h\|(h - l) > 1\|(l + 1) < h\|l < (h - 1)\));
> +|
> + for (...; \(l < h\|l <= h\|(h - l) > 1\|(l + 1) < h\|l < (h - 1)\);
> +      m = \(((l + h)@p / c)\|((l + h)@p >> c)\)) S
> +|
> + for (...; \(l < h\|l <= h\|(h - l) > 1\|(l + 1) < h\|l < (h - 1)\); ...) {
> +  ...
> +(
> +  ((l + h)@p / c)
> +|
> +  ((l + h)@p >> c)
> +)
> +  ...
> + }
> +)
> +
> +@script:python depends on org@
> +p << r.p;
> +@@
> +
> +coccilib.org.print_todo(p[0], "WARNING opportunity for bsearch() or 'm = l + (h - l) / 2;'")
> +
> +@script:python depends on report@
> +p << r.p;
> +@@
> +
> +msg="WARNING: custom implementation of bsearch is error-prone. "
> +msg+="Consider using lib/bsearch.c or fix the midpoint calculation "
> +msg+="as 'm = l + (h - l) / 2;' to prevent the arithmetic overflow."
> +coccilib.report.print_report(p[0], msg)
> +
> --
> 2.21.0
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
