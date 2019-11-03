Return-Path: <SRS0=mv8w=Y3=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E551CA9EB0
	for <cocci@archiver.kernel.org>; Sun,  3 Nov 2019 19:39:55 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4435B2190F
	for <cocci@archiver.kernel.org>; Sun,  3 Nov 2019 19:39:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4435B2190F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xA3JdUs9014936;
	Sun, 3 Nov 2019 20:39:30 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3FC7976FC;
	Sun,  3 Nov 2019 20:39:30 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2297C61B4
 for <cocci@systeme.lip6.fr>; Sun,  3 Nov 2019 20:39:28 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xA3JdQ4c014779
 for <cocci@systeme.lip6.fr>; Sun, 3 Nov 2019 20:39:26 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.68,264,1569276000"; d="scan'208";a="410075222"
Received: from abo-45-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.45])
 by mail2-relais-roc.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Nov 2019 20:39:26 +0100
Date: Sun, 3 Nov 2019 20:39:26 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <042136cf-4e58-02bd-4d49-5d5055f22c65@web.de>
Message-ID: <alpine.DEB.2.21.1911032039150.2557@hadrien>
References: <042136cf-4e58-02bd-4d49-5d5055f22c65@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 03 Nov 2019 20:39:30 +0100 (CET)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Sun, 03 Nov 2019 20:39:26 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Palix <nicolas.palix@imag.fr>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] Coccinelle: zalloc-simple: Adjust a message
 construction
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



On Sun, 3 Nov 2019, Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 3 Nov 2019 20:00:30 +0100
>
> * Simplify a message construction in a Python script rule
>   for the semantic patch language.

The benefit is what?

julia

>
> * Delete also a duplicate space character then.
>
> Fixes: dfd32cad146e3624970eee9329e99d2c6ef751b3 ("dma-mapping: remove dma_zalloc_coherent()")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  scripts/coccinelle/api/alloc/zalloc-simple.cocci | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/coccinelle/api/alloc/zalloc-simple.cocci b/scripts/coccinelle/api/alloc/zalloc-simple.cocci
> index 26cda3f48f01..c14eae1f3010 100644
> --- a/scripts/coccinelle/api/alloc/zalloc-simple.cocci
> +++ b/scripts/coccinelle/api/alloc/zalloc-simple.cocci
> @@ -217,8 +217,10 @@ p << r2.p;
>  x << r2.x;
>  @@
>
> -msg="WARNING: dma_alloc_coherent use in %s already zeroes out memory,  so memset is not needed" % (x)
> -coccilib.report.print_report(p[0], msg)
> +coccilib.report.print_report(p[0],
> +                             "WARNING: dma_alloc_coherent use in "
> +                             + x
> +                             + " already zeroes out memory. Thus memset is not needed.")
>
>  //-----------------------------------------------------------------
>  @r3 depends on org || report@
> --
> 2.23.0
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
