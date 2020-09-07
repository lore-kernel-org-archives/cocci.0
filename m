Return-Path: <SRS0=+34m=CQ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58227C433E2
	for <cocci@archiver.kernel.org>; Mon,  7 Sep 2020 12:00:49 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89B2120738
	for <cocci@archiver.kernel.org>; Mon,  7 Sep 2020 12:00:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89B2120738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 087C0MOD026532;
	Mon, 7 Sep 2020 14:00:22 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 341607595;
	Mon,  7 Sep 2020 14:00:22 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A363D4316
 for <cocci@systeme.lip6.fr>; Mon,  7 Sep 2020 14:00:20 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 087C0KlW029444
 for <cocci@systeme.lip6.fr>; Mon, 7 Sep 2020 14:00:20 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.76,359,1592863200"; d="scan'208";a="358282836"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 Sep 2020 14:00:19 +0200
Date: Mon, 7 Sep 2020 14:00:19 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <5f9fdd59-4b0b-1cb5-c3a2-92efc5bb3841@web.de>
Message-ID: <alpine.DEB.2.22.394.2009071357140.2476@hadrien>
References: <25b804fd-0d04-475d-f614-26c03c9fd544@web.de>
 <5f9fdd59-4b0b-1cb5-c3a2-92efc5bb3841@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 07 Sep 2020 14:00:22 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 07 Sep 2020 14:00:20 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: kernel-janitors@vger.kernel.org, Michal Marek <michal.lkml@markovi.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Dejin Zheng <zhengdejin5@gmail.com>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci]
 =?utf-8?q?=5BPATCH=5D_Coccinelle=3A_api=3A_Add_SmPL_scrip?=
 =?utf-8?b?dCDigJx1c2VfZGV2bV9wbGF0Zm9ybV9nZXRfYW5kX2lvcmVtYXBfcmVzb3Vy?=
 =?utf-8?b?Y2UuY29jY2nigJ0=?=
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



On Mon, 7 Sep 2020, Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 7 Sep 2020 13:14:44 +0200
>
> Another wrapper function is available since the commit 890cc39a879906b63912482dfc41944579df2dc6
> ("drivers: provide devm_platform_get_and_ioremap_resource()").
> Provide design options for the adjustment of affected source code
> by the means of the semantic patch language (Coccinelle software).
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  ...vm_platform_get_and_ioremap_resource.cocci | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 scripts/coccinelle/api/use_devm_platform_get_and_ioremap_resource.cocci
>
> diff --git a/scripts/coccinelle/api/use_devm_platform_get_and_ioremap_resource.cocci b/scripts/coccinelle/api/use_devm_platform_get_and_ioremap_resource.cocci
> new file mode 100644
> index 000000000000..8e67359f6b76
> --- /dev/null
> +++ b/scripts/coccinelle/api/use_devm_platform_get_and_ioremap_resource.cocci
> @@ -0,0 +1,71 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/// Simplify a function call combination by using a known wrapper function.
> +//
> +// Keywords: wrapper function conversion ioremap resources
> +// Confidence: High
> +
> +virtual context, patch, report, org
> +
> +@display depends on context@
> +expression base, device1, device2, index, private, resource;
> +@@
> +(
> +*resource = platform_get_resource(device1, IORESOURCE_MEM, index);
> + base =
> +*       devm_ioremap_resource
> +                             (&device1->dev, resource);

Why do you require these statements to be next to each other?

> +|
> +*private->res = platform_get_resource(device1, IORESOURCE_MEM, index);
> + base =
> +*       devm_ioremap_resource
> +                             (device2, private->res);

Why do you have this special case?

> +)
> +
> +@replacement depends on patch@
> +expression base, device1, device2, index, private, resource;
> +@@
> +(
> +-resource = platform_get_resource(device1, IORESOURCE_MEM, index);
> + base =
> +-       devm_ioremap_resource
> ++       devm_platform_get_and_ioremap_resource
> +                             (
> +-                             &
> +                               device1
> +-                                     ->dev
> +                              ,
> +-                             resource
> ++                             index, &resource
> +                             );
> +|
> +-private->res = platform_get_resource(device1, IORESOURCE_MEM, index);
> + base =
> +-       devm_ioremap_resource
> ++       devm_platform_get_and_ioremap_resource
> +                             (device2,

It is very suspicious that in one case you change the first argument of
devm_platform_get_and_ioremap_resource and in one case you don't.  If you
don't know how to make the change in some cases, it would be better to do
nothing at all.

julia

> +-                             private->res
> ++                             index, &private->res
> +                             );
> +)
> +
> +@or depends on org || report@
> +expression base, device1, device2, index, private, resource;
> +position p;
> +@@
> +(
> + resource = platform_get_resource(device1, IORESOURCE_MEM, index);
> + base = devm_ioremap_resource@p(&device1->dev, resource);
> +|
> + private->res = platform_get_resource(device1, IORESOURCE_MEM, index);
> + base = devm_ioremap_resource@p(device2, private->res);
> +)
> +
> +@script:python to_do depends on org@
> +p << or.p;
> +@@
> +coccilib.org.print_todo(p[0], "WARNING: opportunity for devm_platform_get_and_ioremap_resource()")
> +
> +@script:python reporting depends on report@
> +p << or.p;
> +@@
> +coccilib.report.print_report(p[0], "WARNING: opportunity for devm_platform_get_and_ioremap_resource()")
> --
> 2.28.0
>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
