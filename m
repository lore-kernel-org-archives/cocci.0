Return-Path: <SRS0=DmmV=57=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB14C2BA19
	for <cocci@archiver.kernel.org>; Wed, 15 Apr 2020 17:52:41 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CD1A20787
	for <cocci@archiver.kernel.org>; Wed, 15 Apr 2020 17:52:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CD1A20787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03FHqK9a024944;
	Wed, 15 Apr 2020 19:52:20 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 91CA27755;
	Wed, 15 Apr 2020 19:52:20 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 773463DC8
 for <cocci@systeme.lip6.fr>; Wed, 15 Apr 2020 19:52:18 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03FHqHqi018933
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Wed, 15 Apr 2020 19:52:17 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.72,387,1580770800"; d="scan'208";a="445293567"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 15 Apr 2020 19:52:17 +0200
Date: Wed, 15 Apr 2020 19:52:17 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <25b804fd-0d04-475d-f614-26c03c9fd544@web.de>
Message-ID: <alpine.DEB.2.21.2004151949230.2381@hadrien>
References: <25b804fd-0d04-475d-f614-26c03c9fd544@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1557453758-1586973137=:2381"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 15 Apr 2020 19:52:21 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 15 Apr 2020 19:52:17 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Dejin Zheng <zhengdejin5@gmail.com>, Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking the replacement of two specific function calls
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

--8323329-1557453758-1586973137=:2381
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Wed, 15 Apr 2020, Markus Elfring wrote:

> Hello,
>
> I noticed the suggestion “i2c: busses: convert to devm_platform_get_and_ioremap_resource”.
> https://lore.kernel.org/linux-i2c/20200414134827.18674-1-zhengdejin5@gmail.com/
> https://lore.kernel.org/patchwork/patch/1223734/
>
> I got into the mood to try another script out for the semantic patch language.
>
>
> @replacement@
> expression* base, device, resource;
> @@
> -resource = platform_get_resource(device, IORESOURCE_MEM, 0);
>  base =
> -       devm_ioremap_resource(&device->dev, resource)
> +       devm_platform_get_and_ioremap_resource(device, 0, &resource)
>  ;
>
>
> Source file example:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/i2c/busses/i2c-rcar.c?id=8632e9b5645bbc2331d21d892b0d6961c1a08429#n921
> https://elixir.bootlin.com/linux/v5.7-rc1/source/drivers/i2c/busses/i2c-rcar.c#L921
>
> // SPDX-License-Identifier: GPL-2.0
> // deleted part
> static int rcar_i2c_probe(struct platform_device *pdev)
> {
> 	struct rcar_i2c_priv *priv;
> 	struct i2c_adapter *adap;
> 	struct device *dev = &pdev->dev;
> // deleted part
> 	priv->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>
> 	priv->io = devm_ioremap_resource(dev, priv->res);
> 	if (IS_ERR(priv->io))
> 		return PTR_ERR(priv->io);
> // deleted part
> }
> // deleted part
>
>
> Now I wonder why the expected patch is not generated by the software
> “Coccinelle 1.0.8-00029-ga549b9f0” at the moment.
> How should this situation be improved?

Probably Coccinelle is not able to determine that priv->res and priv->io
are pointers, if you have not given it enough encouragement to look for
header files to find the defintion of the type of the priv structure.

I don't think that there is any need for the * in the metavariable
declaration.  If the various expressions are not pointers, the C compiler
would have complained.

julia


>
> Regards,
> Markus
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
--8323329-1557453758-1586973137=:2381
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-1557453758-1586973137=:2381--
