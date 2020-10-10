Return-Path: <SRS0=mR64=DR=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EE9C433DF
	for <cocci@archiver.kernel.org>; Sat, 10 Oct 2020 19:27:52 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE4F0222D5
	for <cocci@archiver.kernel.org>; Sat, 10 Oct 2020 19:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE4F0222D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09AJRRdZ010220;
	Sat, 10 Oct 2020 21:27:27 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C7166769A;
	Sat, 10 Oct 2020 21:27:27 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7599C578C
 for <cocci@systeme.lip6.fr>; Sat, 10 Oct 2020 21:27:23 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09AJRM6P017347
 for <cocci@systeme.lip6.fr>; Sat, 10 Oct 2020 21:27:22 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.77,360,1596492000"; d="scan'208";a="471939804"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Oct 2020 21:27:22 +0200
Date: Sat, 10 Oct 2020 21:27:21 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Denis Efremov <efremov@linux.com>
In-Reply-To: <20201009125453.31217-1-efremov@linux.com>
Message-ID: <alpine.DEB.2.22.394.2010102127100.2691@hadrien>
References: <20201009125453.31217-1-efremov@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 10 Oct 2020 21:27:28 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 10 Oct 2020 21:27:22 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH] coccinelle: api: kfree_sensitive: print memset
 position
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



On Fri, 9 Oct 2020, Denis Efremov wrote:

> Print memset() call position in addition to the kfree() position to
> ease issues identification.
>
> Signed-off-by: Denis Efremov <efremov@linux.com>

Applied, thanks.

julia

> ---
>  scripts/coccinelle/api/kfree_sensitive.cocci | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/coccinelle/api/kfree_sensitive.cocci b/scripts/coccinelle/api/kfree_sensitive.cocci
> index e4a066a0b77d..8d980ebf3223 100644
> --- a/scripts/coccinelle/api/kfree_sensitive.cocci
> +++ b/scripts/coccinelle/api/kfree_sensitive.cocci
> @@ -85,14 +85,16 @@ type T;
>
>  @script:python depends on report@
>  p << r.p;
> +m << r.m;
>  @@
>
> -coccilib.report.print_report(p[0],
> -  "WARNING: opportunity for kfree_sensitive/kvfree_sensitive")
> +msg = "WARNING opportunity for kfree_sensitive/kvfree_sensitive (memset at line %s)"
> +coccilib.report.print_report(p[0], msg % (m[0].line))
>
>  @script:python depends on org@
>  p << r.p;
> +m << r.m;
>  @@
>
> -coccilib.org.print_todo(p[0],
> -  "WARNING: opportunity for kfree_sensitive/kvfree_sensitive")
> +msg = "WARNING opportunity for kfree_sensitive/kvfree_sensitive (memset at line %s)"
> +coccilib.org.print_todo(p[0], msg % (m[0].line))
> --
> 2.26.2
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
