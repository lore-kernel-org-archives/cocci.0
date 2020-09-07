Return-Path: <SRS0=+34m=CQ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22C4C43461
	for <cocci@archiver.kernel.org>; Mon,  7 Sep 2020 13:11:56 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A107320768
	for <cocci@archiver.kernel.org>; Mon,  7 Sep 2020 13:11:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A107320768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 087DBYGZ029147;
	Mon, 7 Sep 2020 15:11:34 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A2B067595;
	Mon,  7 Sep 2020 15:11:34 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 763214316
 for <cocci@systeme.lip6.fr>; Mon,  7 Sep 2020 15:11:33 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 087DBWi9010518
 for <cocci@systeme.lip6.fr>; Mon, 7 Sep 2020 15:11:32 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.76,359,1592863200"; d="scan'208";a="466412596"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 Sep 2020 15:11:31 +0200
Date: Mon, 7 Sep 2020 15:11:31 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <477abcea-e008-e509-d03f-f2753ebdfb20@web.de>
Message-ID: <alpine.DEB.2.22.394.2009071506350.2476@hadrien>
References: <25b804fd-0d04-475d-f614-26c03c9fd544@web.de>
 <5f9fdd59-4b0b-1cb5-c3a2-92efc5bb3841@web.de>
 <alpine.DEB.2.22.394.2009071357140.2476@hadrien>
 <477abcea-e008-e509-d03f-f2753ebdfb20@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1914540151-1599484292=:2476"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 07 Sep 2020 15:11:34 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 07 Sep 2020 15:11:32 +0200 (CEST)
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
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1914540151-1599484292=:2476
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Mon, 7 Sep 2020, Markus Elfring wrote:

> >> +@display depends on context@
> >> +expression base, device1, device2, index, private, resource;
> >> +@@
> >> +(
> >> +*resource = platform_get_resource(device1, IORESOURCE_MEM, index);
> >> + base =
> >> +*       devm_ioremap_resource
> >> +                             (&device1->dev, resource);
> >
> > Why do you require these statements to be next to each other?
>
> I would appreciate indications for a general change acceptance
> also according to such a simple transformation approach.
> I imagine that it will become more challenging to tolerate extra
> source code between these function calls (by the specification
> of special SmPL filters).
>
>
> >> +|
> >> +*private->res = platform_get_resource(device1, IORESOURCE_MEM, index);
> >> + base =
> >> +*       devm_ioremap_resource
> >> +                             (device2, private->res);
> >
> > Why do you have this special case?
>
> The usage of the data structure member “res” triggers corresponding
> software design consequences.

I don't think this is a reliable rule.  You included two examples below.
They involve structures of different types. It seems unlikely that there
is a guarantee that the res field of all structures is used in the same
way.  Furthermore, this is the context case.  What is the purpose of
making the distinction?  The user will have to figure out what to do by
hand in any case.

> The expressions which are passed as the first function call parameters
> can be different.
>
>
> >> +@replacement depends on patch@
> >> +expression base, device1, device2, index, private, resource;
> >> +@@
> >> +(
> >> +-resource = platform_get_resource(device1, IORESOURCE_MEM, index);
> >> + base =
> >> +-       devm_ioremap_resource
> >> ++       devm_platform_get_and_ioremap_resource
> >> +                             (
> >> +-                             &
> >> +                               device1
> >> +-                                     ->dev
> >> +                              ,
> >> +-                             resource
> >> ++                             index, &resource
> >> +                             );
> >> +|
> >> +-private->res = platform_get_resource(device1, IORESOURCE_MEM, index);
> >> + base =
> >> +-       devm_ioremap_resource
> >> ++       devm_platform_get_and_ioremap_resource
> >> +                             (device2,
> >
> > It is very suspicious that in one case you change the first argument of
> > devm_platform_get_and_ioremap_resource and in one case you don't.
>
> I noticed a few special cases during my source code analysis approach.

This is not a reasonable answer.  Does the rule work correctly or not?  If
it doesn't work correctly, it needs to be removed.

> > If you don't know how to make the change in some cases, it would be better
> > to do nothing at all.
>
> How do you think about to take another look at any update candidates?
>
> Examples:
> * mvebu_sei_probe
>   https://elixir.bootlin.com/linux/v5.9-rc4/source/drivers/irqchip/irq-mvebu-sei.c#L368
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/irqchip/irq-mvebu-sei.c?id=f4d51dffc6c01a9e94650d95ce0104964f8ae822#n368

I don't see any purpose to providing two links for everything.

julia

>
> * hi655x_pmic_probe
>   https://elixir.bootlin.com/linux/v5.9-rc4/source/drivers/mfd/hi655x-pmic.c#L92
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/mfd/hi655x-pmic.c?id=f4d51dffc6c01a9e94650d95ce0104964f8ae822#n92
>
> Regards,
> Markus
>
--8323329-1914540151-1599484292=:2476
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1914540151-1599484292=:2476--
