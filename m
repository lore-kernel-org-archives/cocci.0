Return-Path: <SRS0=PWh2=XB=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E002C43331
	for <cocci@archiver.kernel.org>; Fri,  6 Sep 2019 05:10:24 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B9B6206CD
	for <cocci@archiver.kernel.org>; Fri,  6 Sep 2019 05:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B9B6206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x865A4R5011018;
	Fri, 6 Sep 2019 07:10:04 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 199A07793;
	Fri,  6 Sep 2019 07:10:04 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 45B337790
 for <cocci@systeme.lip6.fr>; Fri,  6 Sep 2019 07:10:01 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8659xgR007019
 for <cocci@systeme.lip6.fr>; Fri, 6 Sep 2019 07:09:59 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.64,472,1559512800"; d="scan'208";a="318467270"
Received: from abo-12-105-68.mrs.modulonet.fr (HELO hadrien) ([85.68.105.12])
 by mail3-relais-sop.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2019 07:09:56 +0200
Date: Fri, 6 Sep 2019 07:09:56 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: YueHaibing <yuehaibing@huawei.com>
In-Reply-To: <20190906033006.17616-1-yuehaibing@huawei.com>
Message-ID: <alpine.DEB.2.21.1909060707330.2975@hadrien>
References: <20190906033006.17616-1-yuehaibing@huawei.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 06 Sep 2019 07:10:05 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Fri, 06 Sep 2019 07:09:59 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: michal.lkml@markovi.net, gregkh@linuxfoundation.org, nicolas.palix@imag.fr,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH -next] coccinelle: platform_get_irq: Fix parse
	error
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



On Fri, 6 Sep 2019, YueHaibing wrote:

> When do coccicheck, I get this error:
>
> spatch -D report --no-show-diff --very-quiet --cocci-file
> ./scripts/coccinelle/api/platform_get_irq.cocci --include-headers
> --dir . -I ./arch/x86/include -I ./arch/x86/include/generated -I ./include
>  -I ./arch/x86/include/uapi -I ./arch/x86/include/generated/uapi
>  -I ./include/uapi -I ./include/generated/uapi
>  --include ./include/linux/kconfig.h --jobs 192 --chunksize 1
> minus: parse error:
>   File "./scripts/coccinelle/api/platform_get_irq.cocci", line 24, column 9, charpos = 355
>   around = '\(',
>   whole content = if ( ret \( < \| <= \) 0 )
>
> In commit e56476897448 ("fpga: Remove dev_err() usage
> after platform_get_irq()") log, I found the semantic patch,
> it fix this issue.

Thanks very much for reporting the problem.

Acked-by: Julia Lawall <julia.lawall@lip6.fr>


>
> Fixes: 98051ba2b28b ("coccinelle: Add script to check for platform_get_irq() excessive prints")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  scripts/coccinelle/api/platform_get_irq.cocci | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/coccinelle/api/platform_get_irq.cocci b/scripts/coccinelle/api/platform_get_irq.cocci
> index f6e1afc..06b6a95 100644
> --- a/scripts/coccinelle/api/platform_get_irq.cocci
> +++ b/scripts/coccinelle/api/platform_get_irq.cocci
> @@ -21,7 +21,7 @@ platform_get_irq
>  platform_get_irq_byname
>  )(E, ...);
>
> -if ( ret \( < \| <= \) 0 )
> +if ( \( ret < 0 \| ret <= 0 \) )
>  {
>  (
>  if (ret != -EPROBE_DEFER)
> @@ -47,7 +47,7 @@ platform_get_irq
>  platform_get_irq_byname
>  )(E, ...);
>
> -if ( ret \( < \| <= \) 0 )
> +if ( \( ret < 0 \| ret <= 0 \) )
>  {
>  (
>  -if (ret != -EPROBE_DEFER)
> @@ -74,7 +74,7 @@ platform_get_irq
>  platform_get_irq_byname
>  )(E, ...);
>
> -if ( ret \( < \| <= \) 0 )
> +if ( \( ret < 0 \| ret <= 0 \) )
>  {
>  (
>  if (ret != -EPROBE_DEFER)
> --
> 2.7.4
>
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
