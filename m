Return-Path: <SRS0=+34m=CQ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EF0C43461
	for <cocci@archiver.kernel.org>; Mon,  7 Sep 2020 17:03:25 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB6B5207DE
	for <cocci@archiver.kernel.org>; Mon,  7 Sep 2020 17:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB6B5207DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 087H39P9009224;
	Mon, 7 Sep 2020 19:03:09 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5C8E97595;
	Mon,  7 Sep 2020 19:03:09 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id BE43B4316
 for <cocci@systeme.lip6.fr>; Mon,  7 Sep 2020 19:03:07 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 087H35vj023323
 for <cocci@systeme.lip6.fr>; Mon, 7 Sep 2020 19:03:05 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.76,359,1592863200"; d="scan'208";a="358316533"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 Sep 2020 19:03:05 +0200
Date: Mon, 7 Sep 2020 19:03:05 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <4b505afc-ae48-d8eb-f4e1-8e3f7192f73d@web.de>
Message-ID: <alpine.DEB.2.22.394.2009071900450.2476@hadrien>
References: <25b804fd-0d04-475d-f614-26c03c9fd544@web.de>
 <5f9fdd59-4b0b-1cb5-c3a2-92efc5bb3841@web.de>
 <4b505afc-ae48-d8eb-f4e1-8e3f7192f73d@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 07 Sep 2020 19:03:09 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 07 Sep 2020 19:03:06 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: kernel-janitors@vger.kernel.org, Michal Marek <michal.lkml@markovi.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Dejin Zheng <zhengdejin5@gmail.com>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci]
 =?utf-8?q?=5BPATCH_v2=5D_Coccinelle=3A_api=3A_Add_SmPL_sc?=
 =?utf-8?b?cmlwdCDigJx1c2VfZGV2bV9wbGF0Zm9ybV9nZXRfYW5kX2lvcmVtYXBfcmVz?=
 =?utf-8?b?b3VyY2UuY29jY2nigJ0=?=
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
> Date: Mon, 7 Sep 2020 18:38:04 +0200
>
> Another wrapper function is available since the commit 890cc39a879906b63912482dfc41944579df2dc6
> ("drivers: provide devm_platform_get_and_ioremap_resource()").
> Provide safe design options for the adjustment of affected source code
> by the means of the semantic patch language (Coccinelle software).
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>
> v2:
> Julia Lawall requested to omit case distinctions (disjunctions) from
> the first SmPL script.
> The usage of different expression metavariables for the first parameter
> of function calls was too questionable for the proposed source
> code transformation.
>
>
>  ...vm_platform_get_and_ioremap_resource.cocci | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 scripts/coccinelle/api/use_devm_platform_get_and_ioremap_resource.cocci
>
> diff --git a/scripts/coccinelle/api/use_devm_platform_get_and_ioremap_resource.cocci b/scripts/coccinelle/api/use_devm_platform_get_and_ioremap_resource.cocci
> new file mode 100644
> index 000000000000..319583716ac8
> --- /dev/null
> +++ b/scripts/coccinelle/api/use_devm_platform_get_and_ioremap_resource.cocci
> @@ -0,0 +1,48 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/// Simplify a function call combination by using a known wrapper function.
> +//
> +// Keywords: wrapper function conversion ioremap resources
> +// Confidence: High

Shouldn't there be some options?  --no-includes and perhaps
--include-headers would seem reasonable.

Please also remove all of the rule names except for "or" which is
necessary.  The rest just add clutter and make it harder to find the
useful information, which is the depends on.  Rules only need names if
some other rule inherits their metavariables.

julia

> +
> +virtual context, patch, report, org
> +
> +@display depends on context@
> +expression base, device, index, resource;
> +@@
> +*resource = platform_get_resource(device, IORESOURCE_MEM, index);
> + base =
> +*       devm_ioremap_resource
> +                             (&device->dev, resource);
> +
> +@replacement depends on patch@
> +expression base, device, index, resource;
> +@@
> +-resource = platform_get_resource(device, IORESOURCE_MEM, index);
> + base =
> +-       devm_ioremap_resource
> ++       devm_platform_get_and_ioremap_resource
> +                             (
> +-                             &
> +                               device
> +-                                    ->dev
> +                              ,
> +-                             resource
> ++                             index, &resource
> +                             );
> +
> +@or depends on org || report@
> +expression base, device, index, resource;
> +position p;
> +@@
> + resource = platform_get_resource(device, IORESOURCE_MEM, index);
> + base = devm_ioremap_resource@p(&device->dev, resource);
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
