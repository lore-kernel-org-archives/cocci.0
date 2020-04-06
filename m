Return-Path: <SRS0=ND+5=5W=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB8CC2BA2B
	for <cocci@archiver.kernel.org>; Mon,  6 Apr 2020 19:15:55 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF3CC206C3
	for <cocci@archiver.kernel.org>; Mon,  6 Apr 2020 19:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF3CC206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 036JFa0N022403;
	Mon, 6 Apr 2020 21:15:36 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 323FA7815;
	Mon,  6 Apr 2020 21:15:36 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A2DE377FC
 for <cocci@systeme.lip6.fr>; Mon,  6 Apr 2020 21:15:33 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 036JFUSQ028834
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 6 Apr 2020 21:15:30 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.72,352,1580770800"; d="scan'208";a="345152404"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Apr 2020 21:15:29 +0200
Date: Mon, 6 Apr 2020 21:15:29 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Alex Dewar <alex.dewar@gmx.co.uk>
In-Reply-To: <20200403173011.65511-1-alex.dewar@gmx.co.uk>
Message-ID: <alpine.DEB.2.21.2004062115000.10239@hadrien>
References: <20200403173011.65511-1-alex.dewar@gmx.co.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 06 Apr 2020 21:15:36 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 06 Apr 2020 21:15:30 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, cocci@systeme.lip6.fr,
        Allison Randal <allison@lohutok.net>
Subject: Re: [Cocci] [PATCH] Coccinelle: zalloc_simple: Fix patch mode for
 dma_alloc_coherent()
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



On Fri, 3 Apr 2020, Alex Dewar wrote:

> Commit dfd32cad146e ("dma-mapping: remove dma_zalloc_coherent()"), in
> removing dma_zalloc_coherent() treewide, inadvertently removed the patch
> rule for dma_alloc_coherent(), leaving Coccinelle unable to auto-generate
> patches for this case. Fix this.
>
> Fixes: dfd32cad146e ("dma-mapping: remove dma_zalloc_coherent()")
> CC: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Alex Dewar <alex.dewar@gmx.co.uk>
> ---
>  scripts/coccinelle/api/alloc/zalloc-simple.cocci | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/scripts/coccinelle/api/alloc/zalloc-simple.cocci b/scripts/coccinelle/api/alloc/zalloc-simple.cocci
> index 26cda3f48f01..c53aab7fe096 100644
> --- a/scripts/coccinelle/api/alloc/zalloc-simple.cocci
> +++ b/scripts/coccinelle/api/alloc/zalloc-simple.cocci
> @@ -70,6 +70,15 @@ statement S;
>  - x = (T)vmalloc(E1);
>  + x = (T)vzalloc(E1);
>  |
> +- x = dma_alloc_coherent(E2,E1,E3,E4);
> ++ x = dma_alloc_coherent(E2,E1,E3,E4);

Hi,

I don't understand the above case.  The before and after code seem to be
the same?

julia


> +|
> +- x = (T *)dma_alloc_coherent(E2,E1,E3,E4);
> ++ x = dma_alloc_coherent(E2,E1,E3,E4);
> +|
> +- x = (T)dma_alloc_coherent(E2,E1,E3,E4);
> ++ x = (T)dma_alloc_coherent(E2,E1,E3,E4);
> +|
>  - x = kmalloc_node(E1,E2,E3);
>  + x = kzalloc_node(E1,E2,E3);
>  |
> --
> 2.26.0
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
