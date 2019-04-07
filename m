Return-Path: <SRS0=K+oe=SJ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2301BC10F0E
	for <cocci@archiver.kernel.org>; Sun,  7 Apr 2019 19:19:08 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2B7620879
	for <cocci@archiver.kernel.org>; Sun,  7 Apr 2019 19:19:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2B7620879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x37JIpOJ028143
          ; Sun, 7 Apr 2019 21:18:51 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 448727704;
	Sun,  7 Apr 2019 21:18:51 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id BD7F87673
 for <cocci@systeme.lip6.fr>; Sun,  7 Apr 2019 21:18:49 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x37JImAf025015
 for <cocci@systeme.lip6.fr>; Sun, 7 Apr 2019 21:18:48 +0200 (CEST)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.60,322,1549926000"; d="scan'208";a="377568794"
Received: from abo-75-106-68.mrs.modulonet.fr (HELO hadrien) ([85.68.106.75])
 by mail2-relais-roc.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Apr 2019 21:18:48 +0200
Date: Sun, 7 Apr 2019 21:18:48 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <4a22aba7-4983-3f17-a51e-7ad6d4f3eac2@roeck-us.net>
Message-ID: <alpine.DEB.2.21.1904072118280.18180@hadrien>
References: <4a22aba7-4983-3f17-a51e-7ad6d4f3eac2@roeck-us.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 07 Apr 2019 21:18:52 +0200 (CEST)
X-Greylist: Delayed for 00:08:56 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Sun, 07 Apr 2019 21:18:48 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] ormatting problems when introducing a function with
 coccinelle
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

On Sun, 7 Apr 2019, Guenter Roeck wrote:

> Hi Coccinelle experts,
>
> I am trying to introduce a new function with coccinelle.
>
> The semantic patch is something like
>
> @devm depends on prb@
> identifier r.initfn;
> identifier fname.clkfunc;
> @@
> + static void clkfunc(void *data) { clk_disable_unprepare(data); }
>   initfn(...) { ... }
>
> This works, but the resulting output is always
>
> +static void armada_clk_disable_unprepare(void *data) {
> +       clk_disable_unprepare(data);
> +}
> +
>  static int armada_37xx_wdt_probe(struct platform_device *pdev)
>
> meaning the opening '{' is in the same line as the function declaration.
> It doesn't matter if I provide the function in a single line or
> in multiple lines. It also doesn't matter if I try to manipulate
> the function afterwards. The output looks always the same.

You can try the new version on github.

julia


>
> Is there a way to tell coccinelle that it should generate
>
> +static void armada_clk_disable_unprepare(void *data)
> +{
> +       clk_disable_unprepare(data);
> +}
> +
>  static int armada_37xx_wdt_probe(struct platform_device *pdev)
>
> instead ?
>
> Thanks,
> Guenter
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
