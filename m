Return-Path: <SRS0=fnKQ=IW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B80C433DB
	for <cocci@archiver.kernel.org>; Wed, 24 Mar 2021 20:31:30 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E5FE619FF
	for <cocci@archiver.kernel.org>; Wed, 24 Mar 2021 20:31:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E5FE619FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 12OKVQfP008325;
	Wed, 24 Mar 2021 21:31:26 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 6804677CA;
	Wed, 24 Mar 2021 21:31:26 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id CAC3D3E8A
 for <cocci@systeme.lip6.fr>; Wed, 24 Mar 2021 21:31:24 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 12OKVOGG006949
 for <cocci@systeme.lip6.fr>; Wed, 24 Mar 2021 21:31:24 +0100 (CET)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ApUwnRqgmawWInLhM+gfn6+LDFnBQXjsji2hD?=
 =?us-ascii?q?6mlwRA09T+WzkceykPMHkSLlkTp5YgBFpfmsMLSNKEm2ybdb+o8UVI3JYCDHvy?=
 =?us-ascii?q?+SIJhm/c/exVTbehHW0s54+eNef7NlCNv2ZGIK6PrSxAWjCd4vzJ2m3cmT5dv2?=
 =?us-ascii?q?9HtmQQF0Z6wI1W4QNi+hHkJ7XwVAD5YifaDshfZvnSaqengcc62AaEUtYu6rnb?=
 =?us-ascii?q?H2va79bQVDLxAq7xTmt0LL1JfKVynd5BsYXj9VqI1OzUHOmWXCiZmejw=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.81,275,1610406000"; d="scan'208";a="376775754"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Mar 2021 21:31:24 +0100
Date: Wed, 24 Mar 2021 21:31:23 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Denis Efremov <efremov@linux.com>
In-Reply-To: <20210308073018.108487-1-efremov@linux.com>
Message-ID: <alpine.DEB.2.22.394.2103242131140.7838@hadrien>
References: <20210308073018.108487-1-efremov@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 24 Mar 2021 21:31:26 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 24 Mar 2021 21:31:24 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH] coccinelle: misc: update
 uninitialized_var.cocci documentation
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



On Mon, 8 Mar 2021, Denis Efremov wrote:

> Remove the documentation link from the warning message because commit
> 3942ea7a10c9 ("deprecated.rst: Remove now removed uninitialized_var")
> removed the section from documentation. Update the rule documentation
> accordingly.
>
> Signed-off-by: Denis Efremov <efremov@linux.com>

Applied, thanks.

julia

> ---
>  scripts/coccinelle/misc/uninitialized_var.cocci | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/scripts/coccinelle/misc/uninitialized_var.cocci b/scripts/coccinelle/misc/uninitialized_var.cocci
> index 8fa845cefe11..69bbaae47e73 100644
> --- a/scripts/coccinelle/misc/uninitialized_var.cocci
> +++ b/scripts/coccinelle/misc/uninitialized_var.cocci
> @@ -1,7 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  ///
>  /// Please, don't reintroduce uninitialized_var().
> -/// From Documentation/process/deprecated.rst:
> +///
> +/// From Documentation/process/deprecated.rst,
> +/// commit 4b19bec97c88 ("docs: deprecated.rst: Add uninitialized_var()"):
>  ///  For any compiler warnings about uninitialized variables, just add
>  ///  an initializer. Using warning-silencing tricks is dangerous as it
>  ///  papers over real bugs (or can in the future), and suppresses unrelated
> @@ -11,6 +13,11 @@
>  ///  obviously redundant, the compiler's dead-store elimination pass will make
>  ///  sure there are no needless variable writes.
>  ///
> +/// Later, commit 3942ea7a10c9 ("deprecated.rst: Remove now removed
> +/// uninitialized_var") removed this section because all initializations of
> +/// this kind were cleaned-up from the kernel. This cocci rule checks that
> +/// the macro is not explicitly or implicitly reintroduced.
> +///
>  // Confidence: High
>  // Copyright: (C) 2020 Denis Efremov ISPRAS
>  // Options: --no-includes --include-headers
> @@ -40,12 +47,10 @@ position p;
>  p << r.p;
>  @@
>
> -coccilib.report.print_report(p[0],
> -  "WARNING this kind of initialization is deprecated (https://www.kernel.org/doc/html/latest/process/deprecated.html#uninitialized-var)")
> +coccilib.report.print_report(p[0], "WARNING this kind of initialization is deprecated")
>
>  @script:python depends on org@
>  p << r.p;
>  @@
>
> -coccilib.org.print_todo(p[0],
> -  "WARNING this kind of initialization is deprecated (https://www.kernel.org/doc/html/latest/process/deprecated.html#uninitialized-var)")
> +coccilib.org.print_todo(p[0], "WARNING this kind of initialization is deprecated")
> --
> 2.26.2
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
