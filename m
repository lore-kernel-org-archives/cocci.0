Return-Path: <SRS0=UL0A=QQ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F87C282C4
	for <cocci@archiver.kernel.org>; Sat,  9 Feb 2019 19:20:40 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66E2A217D8
	for <cocci@archiver.kernel.org>; Sat,  9 Feb 2019 19:20:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66E2A217D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x19JKIKj024689
          ; Sat, 9 Feb 2019 20:20:19 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C23AF76F5;
	Sat,  9 Feb 2019 20:20:18 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4889876E9
 for <cocci@systeme.lip6.fr>; Sat,  9 Feb 2019 20:20:17 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x19JKGmo005388
 for <cocci@systeme.lip6.fr>; Sat, 9 Feb 2019 20:20:16 +0100 (CET)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.58,352,1544482800"; d="scan'208";a="368707933"
Received: from abo-58-107-68.mrs.modulonet.fr (HELO hadrien) ([85.68.107.58])
 by mail2-relais-roc.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Feb 2019 20:10:54 +0100
Date: Sat, 9 Feb 2019 20:10:53 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Wen Yang <yellowriver2010@hotmail.com>
In-Reply-To: <HK0PR02MB3634D25073591A4AB6D41D32B26A0@HK0PR02MB3634.apcprd02.prod.outlook.com>
Message-ID: <alpine.DEB.2.21.1902092007450.2512@hadrien>
References: <HK0PR02MB3634D25073591A4AB6D41D32B26A0@HK0PR02MB3634.apcprd02.prod.outlook.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 09 Feb 2019 20:20:21 +0100 (CET)
X-Greylist: Delayed for 00:09:22 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Sat, 09 Feb 2019 20:20:16 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        "cocci@systeme.lip6.fr" <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] [PATCH] coccinelle: semantic patch for missing
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



On Sat, 9 Feb 2019, Wen Yang wrote:

> The of_find_device_by_node() takes a reference to the underlying device
> structure, we should release that reference.
> Use this semantic patch, we've found some object reference leaks,
> such as:
> 11907e9d3533 ("ASoC: fsl-asoc-card: fix object reference leaks in fsl_asoc_card_probe")
> a12085d13997 ("mtd: rawnand: atmel: fix possible object reference leak")
> 11493f26856a ("mtd: rawnand: jz4780: fix possible object reference leak")
> There are still dozens of reference leaks in the kernel code.
>
> Signed-off-by: Wen Yang <yellowriver2010@hotmail.com>
> ---
>  scripts/coccinelle/free/put_device.cocci | 54 ++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 scripts/coccinelle/free/put_device.cocci
>
> diff --git a/scripts/coccinelle/free/put_device.cocci b/scripts/coccinelle/free/put_device.cocci
> new file mode 100644
> index 0000000..d3e3ba9
> --- /dev/null
> +++ b/scripts/coccinelle/free/put_device.cocci
> @@ -0,0 +1,54 @@
> +/// Find missing put_device for every of_find_device_by_node.
> +///
> +// Confidence: Moderate
> +// Copyright: (C) 2018-2019 Wen Yang, ZTE.  GPLv2.
> +// Comments:
> +// Options: --no-includes --include-headers
> +
> +virtual report
> +virtual org
> +
> +@search@

Just put exists after search, and then drop the when exists below.

> +local idexpression id;
> +expression x,e;
> +position p1,p2;
> +type T;
> +@@
> +
> +id = of_find_device_by_node@p1(x)
> +... when != e = id

This should not use the same e as in the when's below.  Make a new
matavariavle e1 and use that here.

> +if (id == NULL || ...) { ... return ...; }
> +... when != put_device(&id->dev)

I have the impression that you should also consider platform_device_put.

> +    when != of_dev_put(&id)
> +    when != if (id) { ... put_device(&id->dev) ... }
> +    when != e = (T)id
> +    when != e = &id->dev
> +    when != e = gen_pool_get(&id->dev, ...)
> +    when != e = platform_get_drvdata(id)
> +    when exists
> +(
> +return id;
> +|
> +return dev_get_drvdata(&id->dev);
> +|
> +return platform_get_drvdata(id)

Make a new type metavariable T1 amd use it to put a cast on the result of
platform_get_drvdata.  For dev_get_drvdata, I didn't actually find any
examples with a cast, but it wouldn't hurt to put a cast there too

Thanks,
julia

> +|
> +return@p2 ...;
> +)
> +
> +@script:python depends on report@
> +p1 << search.p1;
> +p2 << search.p2;
> +@@
> +
> +msg = "ERROR: missing put_device; of_find_device_by_node on line %s and return without releasing on line %s" % (p1[0].line,p2[0].line)
> +coccilib.report.print_report(p2[0],msg)
> +
> +@script:python depends on org@
> +p1 << search.p1;
> +p2 << search.p2;
> +@@
> +
> +msg = "ERROR: missing put_device; of_find_device_by_node on line %s and return without releasing on line %s" % (p1[0].line,p2[0].line)
> +cocci.print_main(msg,p1)
> +cocci.print_secs("",p2)
> --
> 2.7.4
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
