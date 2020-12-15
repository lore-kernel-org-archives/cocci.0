Return-Path: <SRS0=J+fH=FT=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80495C4361B
	for <cocci@archiver.kernel.org>; Tue, 15 Dec 2020 19:58:04 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CA6022A99
	for <cocci@archiver.kernel.org>; Tue, 15 Dec 2020 19:58:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CA6022A99
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0BFJvg3e006493;
	Tue, 15 Dec 2020 20:57:42 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 87FB977A4;
	Tue, 15 Dec 2020 20:57:42 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 717423A53
 for <cocci@systeme.lip6.fr>; Tue, 15 Dec 2020 20:57:41 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0BFJtqm9016176
 for <cocci@systeme.lip6.fr>; Tue, 15 Dec 2020 20:55:52 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.78,422,1599516000"; d="scan'208";a="367761533"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 15 Dec 2020 20:55:46 +0100
Date: Tue, 15 Dec 2020 20:55:46 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Maxime Ripard <maxime@cerno.tech>
In-Reply-To: <20201215122459.283702-1-maxime@cerno.tech>
Message-ID: <alpine.DEB.2.22.394.2012152055380.2879@hadrien>
References: <20201215122459.283702-1-maxime@cerno.tech>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 15 Dec 2020 20:57:42 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 15 Dec 2020 20:55:53 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: michal.lkml@markovi.net, Gilles.Muller@lip6.fr,
        Jani Nikula <jani.nikula@intel.com>, nicolas.palix@imag.fr,
        linux-kernel@vger.kernel.org, Julia.Lawall@lip6.fr,
        Mark Brown <broonie@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Thierry Reding <treding@nvidia.com>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH v2] coccinnelle: Remove ptr_ret script
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



On Tue, 15 Dec 2020, Maxime Ripard wrote:

> The ptr_ret script script addresses a number of situations where we end up
> testing an error pointer, and if it's an error returning it, or return 0
> otherwise to transform it into a PTR_ERR_OR_ZERO call.
>
> So it will convert a block like this:
>
> if (IS_ERR(err))
>     return PTR_ERR(err);
>
> return 0;
>
> into
>
> return PTR_ERR_OR_ZERO(err);
>
> While this is technically correct, it has a number of drawbacks. First, it
> merges the error and success path, which will make it harder for a reviewer
> or reader to grasp.
>
> It's also more difficult to extend if we were to add some code between the
> error check and the function return, making the author essentially revert
> that patch before adding new lines, while it would have been a trivial
> addition otherwise for the rewiever.
>
> Therefore, since that script is only about cosmetic in the first place,
> let's remove it since it's not worth it.
>
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> Acked-by: Julia Lawall <julia.lawall@inria.fr>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Applied

> ---
>
> Changes from v1:
>   - Collected the tags
>
>  scripts/coccinelle/api/ptr_ret.cocci | 97 ----------------------------
>  1 file changed, 97 deletions(-)
>  delete mode 100644 scripts/coccinelle/api/ptr_ret.cocci
>
> diff --git a/scripts/coccinelle/api/ptr_ret.cocci b/scripts/coccinelle/api/ptr_ret.cocci
> deleted file mode 100644
> index e76cd5d90a8a..000000000000
> --- a/scripts/coccinelle/api/ptr_ret.cocci
> +++ /dev/null
> @@ -1,97 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -///
> -/// Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR
> -///
> -// Confidence: High
> -// Copyright: (C) 2012 Julia Lawall, INRIA/LIP6.
> -// Copyright: (C) 2012 Gilles Muller, INRIA/LiP6.
> -// URL: http://coccinelle.lip6.fr/
> -// Options: --no-includes --include-headers
> -//
> -// Keywords: ERR_PTR, PTR_ERR, PTR_ERR_OR_ZERO
> -// Version min: 2.6.39
> -//
> -
> -virtual context
> -virtual patch
> -virtual org
> -virtual report
> -
> -@depends on patch@
> -expression ptr;
> -@@
> -
> -- if (IS_ERR(ptr)) return PTR_ERR(ptr); else return 0;
> -+ return PTR_ERR_OR_ZERO(ptr);
> -
> -@depends on patch@
> -expression ptr;
> -@@
> -
> -- if (IS_ERR(ptr)) return PTR_ERR(ptr); return 0;
> -+ return PTR_ERR_OR_ZERO(ptr);
> -
> -@depends on patch@
> -expression ptr;
> -@@
> -
> -- (IS_ERR(ptr) ? PTR_ERR(ptr) : 0)
> -+ PTR_ERR_OR_ZERO(ptr)
> -
> -@r1 depends on !patch@
> -expression ptr;
> -position p1;
> -@@
> -
> -* if@p1 (IS_ERR(ptr)) return PTR_ERR(ptr); else return 0;
> -
> -@r2 depends on !patch@
> -expression ptr;
> -position p2;
> -@@
> -
> -* if@p2 (IS_ERR(ptr)) return PTR_ERR(ptr); return 0;
> -
> -@r3 depends on !patch@
> -expression ptr;
> -position p3;
> -@@
> -
> -* IS_ERR@p3(ptr) ? PTR_ERR(ptr) : 0
> -
> -@script:python depends on org@
> -p << r1.p1;
> -@@
> -
> -coccilib.org.print_todo(p[0], "WARNING: PTR_ERR_OR_ZERO can be used")
> -
> -
> -@script:python depends on org@
> -p << r2.p2;
> -@@
> -
> -coccilib.org.print_todo(p[0], "WARNING: PTR_ERR_OR_ZERO can be used")
> -
> -@script:python depends on org@
> -p << r3.p3;
> -@@
> -
> -coccilib.org.print_todo(p[0], "WARNING: PTR_ERR_OR_ZERO can be used")
> -
> -@script:python depends on report@
> -p << r1.p1;
> -@@
> -
> -coccilib.report.print_report(p[0], "WARNING: PTR_ERR_OR_ZERO can be used")
> -
> -@script:python depends on report@
> -p << r2.p2;
> -@@
> -
> -coccilib.report.print_report(p[0], "WARNING: PTR_ERR_OR_ZERO can be used")
> -
> -@script:python depends on report@
> -p << r3.p3;
> -@@
> -
> -coccilib.report.print_report(p[0], "WARNING: PTR_ERR_OR_ZERO can be used")
> --
> 2.28.0
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
