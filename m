Return-Path: <SRS0=5LVs=CK=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DDBC433E2
	for <cocci@archiver.kernel.org>; Tue,  1 Sep 2020 09:06:30 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 787A82071B
	for <cocci@archiver.kernel.org>; Tue,  1 Sep 2020 09:06:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 787A82071B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08196405016274;
	Tue, 1 Sep 2020 11:06:04 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0EA86742E;
	Tue,  1 Sep 2020 11:06:04 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8E14F4385
 for <cocci@systeme.lip6.fr>; Tue,  1 Sep 2020 11:06:02 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 081961rc009868
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 1 Sep 2020 11:06:01 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.76,359,1592863200"; d="scan'208";a="357773374"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 01 Sep 2020 11:06:00 +0200
Date: Tue, 1 Sep 2020 11:06:00 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Denis Efremov <efremov@linux.com>
In-Reply-To: <20200901071533.2725-1-efremov@linux.com>
Message-ID: <alpine.DEB.2.22.394.2009011103480.2533@hadrien>
References: <20200811210127.11889-1-efremov@linux.com>
 <20200901071533.2725-1-efremov@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 01 Sep 2020 11:06:04 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 01 Sep 2020 11:06:01 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: "Gustavo A . R . Silva" <gustavoars@kernel.org>, cocci@systeme.lip6.fr,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH v2] coccinelle: misc: add
 uninitialized_var.cocci script
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



On Tue, 1 Sep 2020, Denis Efremov wrote:

> Commit 63a0895d960a ("compiler: Remove uninitialized_var() macro") and
> commit 4b19bec97c88 ("docs: deprecated.rst: Add uninitialized_var()")
> removed uninitialized_var() and deprecated it.

I'm not really sure to understand the above.  How can something that has
already been removed be deprecated, since it doesn't exist any more?
Maybe the commits should be mentioned in the opposite order?

Personally, I would find the sentence a lot easier to read without the
commit subject lines in parentheses in the middle of it.  It inspires me
to just ignore the paragraph completely.  I wonder if it could be allowed
to just mention the commit ids in the sentence and then put the ids
followed by the subject line afterwards?

julia

>
> The purpose of this script is to prevent new occurrences of open-coded
> variants of uninitialized_var().
>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
> Changes in v2:
>  - Documentation cited in the script's description
>  - kernel.org link added to the diagnostics messages
>  - "T *var = &var;" pattern removed
>  - "var =@p var", "var =@p *(&(var))" patterns added
>
>  .../coccinelle/misc/uninitialized_var.cocci   | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 scripts/coccinelle/misc/uninitialized_var.cocci
>
> diff --git a/scripts/coccinelle/misc/uninitialized_var.cocci b/scripts/coccinelle/misc/uninitialized_var.cocci
> new file mode 100644
> index 000000000000..8fa845cefe11
> --- /dev/null
> +++ b/scripts/coccinelle/misc/uninitialized_var.cocci
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +///
> +/// Please, don't reintroduce uninitialized_var().
> +/// From Documentation/process/deprecated.rst:
> +///  For any compiler warnings about uninitialized variables, just add
> +///  an initializer. Using warning-silencing tricks is dangerous as it
> +///  papers over real bugs (or can in the future), and suppresses unrelated
> +///  compiler warnings (e.g. "unused variable"). If the compiler thinks it
> +///  is uninitialized, either simply initialize the variable or make compiler
> +///  changes. Keep in mind that in most cases, if an initialization is
> +///  obviously redundant, the compiler's dead-store elimination pass will make
> +///  sure there are no needless variable writes.
> +///
> +// Confidence: High
> +// Copyright: (C) 2020 Denis Efremov ISPRAS
> +// Options: --no-includes --include-headers
> +//
> +
> +virtual context
> +virtual report
> +virtual org
> +
> +@r@
> +identifier var;
> +type T;
> +position p;
> +@@
> +
> +(
> +* T var =@p var;
> +|
> +* T var =@p *(&(var));
> +|
> +* var =@p var
> +|
> +* var =@p *(&(var))
> +)
> +
> +@script:python depends on report@
> +p << r.p;
> +@@
> +
> +coccilib.report.print_report(p[0],
> +  "WARNING this kind of initialization is deprecated (https://www.kernel.org/doc/html/latest/process/deprecated.html#uninitialized-var)")
> +
> +@script:python depends on org@
> +p << r.p;
> +@@
> +
> +coccilib.org.print_todo(p[0],
> +  "WARNING this kind of initialization is deprecated (https://www.kernel.org/doc/html/latest/process/deprecated.html#uninitialized-var)")
> --
> 2.26.2
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
