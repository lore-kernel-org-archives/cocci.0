Return-Path: <SRS0=17+G=QX=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2089C43381
	for <cocci@archiver.kernel.org>; Sat, 16 Feb 2019 16:33:23 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 726AE222E0
	for <cocci@archiver.kernel.org>; Sat, 16 Feb 2019 16:33:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 726AE222E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1GGX5GI027258
          ; Sat, 16 Feb 2019 17:33:05 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id BD0FD76FA;
	Sat, 16 Feb 2019 17:33:05 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id F0EA576F4
 for <cocci@systeme.lip6.fr>; Sat, 16 Feb 2019 17:33:03 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1GGX1J9025413
 for <cocci@systeme.lip6.fr>; Sat, 16 Feb 2019 17:33:01 +0100 (CET)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.58,377,1544482800"; d="scan'208";a="296397589"
Received: from abo-58-107-68.mrs.modulonet.fr (HELO hadrien) ([85.68.107.58])
 by mail3-relais-sop.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Feb 2019 17:33:00 +0100
Date: Sat, 16 Feb 2019 17:33:00 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Wen Yang <yellowriver2010@hotmail.com>
In-Reply-To: <HK0PR02MB36344E2B29CEB195892F6420B2610@HK0PR02MB3634.apcprd02.prod.outlook.com>
Message-ID: <alpine.DEB.2.21.1902161731500.2506@hadrien>
References: <HK0PR02MB36344E2B29CEB195892F6420B2610@HK0PR02MB3634.apcprd02.prod.outlook.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 16 Feb 2019 17:33:06 +0100 (CET)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Sat, 16 Feb 2019 17:33:01 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Markus Elfring <Markus.Elfring@web.de>,
        "cheng.shengyu@zte.com.cn" <cheng.shengyu@zte.com.cn>,
        "cocci@systeme.lip6.fr" <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] [PATCH v6] coccinelle: semantic code search for missing
 put_device()
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



On Sat, 16 Feb 2019, Wen Yang wrote:

> The of_find_device_by_node() takes a reference to the underlying device
> structure, we should release that reference.
> The implementation of this semantic code search is:
> In a function, for a local variable obtained by of_find_device_by_node(),
> a, if it is released by a function such as
>    put_device()/of_dev_put()/platform_device_put() after the last use,
>    it is considered that there is no reference leak;
> b, if it is passed back to the caller via
>    dev_get_drvdata()/platform_get_drvdata()/get_device(), etc., the
>    reference will be released in other functions, and the current function
>    also considers that there is no reference leak;
> c, for the rest of the situation, the current function should release the
>    reference by calling put_device, this code search will report an error
>    with a specific confidence.
>
> By using this semantic code search, we have found some issues, such as:
> commit 11907e9d3533 ("ASoC: fsl-asoc-card: fix object reference leaks in
> fsl_asoc_card_probe")
> commit a12085d13997 ("mtd: rawnand: atmel: fix possible object reference
> leak")
> commit 11493f26856a ("mtd: rawnand: jz4780: fix possible object reference
> leak")
>
> There are still dozens of reference leaks in the current kernel code.
>
> Further, for the case of b, the object returned to other functions may also
> have a reference leak, we will continue to develop other cocci scripts to
> further check the reference leak.
>
> Signed-off-by: Wen Yang <yellowriver2010@hotmail.com>
> Reviewed-by: Julia Lawall <Julia.Lawall@lip6.fr>

Acked-by: Julia Lawall <julia.lawall@lip6.fr>

> Reviewed-by: Markus Elfring <Markus.Elfring@web.de>
> Cc: Julia Lawall <Julia.Lawall@lip6.fr>
> Cc: Gilles Muller <Gilles.Muller@lip6.fr>
> Cc: Nicolas Palix <nicolas.palix@imag.fr>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: Markus Elfring <Markus.Elfring@web.de>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Wen Yang <wen.yang99@zte.com.cn>
> Cc: cheng.shengyu@zte.com.cn
> Cc: cocci@systeme.lip6.fr
> Cc: linux-kernel@vger.kernel.org
> ---
> v6:
> - to be double sure, replace &id->dev with (T)(&id->dev).
> - long string literals can be accepted because of error message search concerns around a tool like grep
> v5:
> - exchange the word patch by code search.
> - add a SPDX identifier.
> - a split string literal can be unwanted.
> - Change the content of the reported information.
> v4:
> - add Masahiro Yamada
> - omit a blank line
> - split the long message parameter
> - reduce the number of metavariables
> - Describe the implementation of the semantic patch,
>   explain the scenarios it can detect,
>   and further software development considerations.
> v3:
> - reduction of a bit of redundant C code within SmPL search specifications.
> - consider the message construction without using the extra Python variable msg.
> v2:
> - put exists after search, and then drop the when exists below.
> - should not use the same e as in the when's below.
> - Make a new type metavariable and use it to put a cast on the result of platform_get_drvdata.
>
>  scripts/coccinelle/free/put_device.cocci | 55 ++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 scripts/coccinelle/free/put_device.cocci
>
> diff --git a/scripts/coccinelle/free/put_device.cocci b/scripts/coccinelle/free/put_device.cocci
> new file mode 100644
> index 000000000000..96e2508c0be1
> --- /dev/null
> +++ b/scripts/coccinelle/free/put_device.cocci
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/// Find missing put_device for every of_find_device_by_node.
> +///
> +// Confidence: Moderate
> +// Copyright: (C) 2018-2019 Wen Yang, ZTE.
> +// Comments:
> +// Options: --no-includes --include-headers
> +
> +virtual report
> +virtual org
> +
> +@search exists@
> +local idexpression id;
> +expression x,e,e1;
> +position p1,p2;
> +type T,T1,T2;
> +@@
> +
> +id = of_find_device_by_node@p1(x)
> +... when != e = id
> +if (id == NULL || ...) { ... return ...; }
> +... when != put_device(&id->dev)
> +    when != platform_device_put(id)
> +    when != of_dev_put(id)
> +    when != if (id) { ... put_device(&id->dev) ... }
> +    when != e1 = (T)id
> +    when != e1 = (T)(&id->dev)
> +    when != e1 = get_device(&id->dev)
> +    when != e1 = (T)platform_get_drvdata(id)
> +(
> +  return
> +(    id
> +|    (T1)dev_get_drvdata(&id->dev)
> +|    (T2)platform_get_drvdata(id)
> +);
> +| return@p2 ...;
> +)
> +
> +@script:python depends on report@
> +p1 << search.p1;
> +p2 << search.p2;
> +@@
> +
> +coccilib.report.print_report(p2[0],
> +			     "ERROR: missing put_device; call of_find_device_by_node on line "
> +                             + p1[0].line
> +                             + ", but without a corresponding object release within this function.")
> +
> +@script:python depends on org@
> +p1 << search.p1;
> +p2 << search.p2;
> +@@
> +
> +cocci.print_main("of_find_device_by_node", p1)
> +cocci.print_secs("needed put_device", p2)
> --
> 2.20.1
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
