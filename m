Return-Path: <SRS0=N+LH=YL=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AFDCA9EA9
	for <cocci@archiver.kernel.org>; Fri, 18 Oct 2019 16:06:26 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 143C12067B
	for <cocci@archiver.kernel.org>; Fri, 18 Oct 2019 16:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143C12067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9IG69xw028813;
	Fri, 18 Oct 2019 18:06:09 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id AE6AA77B8;
	Fri, 18 Oct 2019 18:06:09 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5C12D77B4
 for <cocci@systeme.lip6.fr>; Fri, 18 Oct 2019 18:06:08 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9IG67jI015311
 for <cocci@systeme.lip6.fr>; Fri, 18 Oct 2019 18:06:07 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.67,312,1566856800"; d="scan'208";a="406869813"
Received: from portablejulia.rsr.lip6.fr ([132.227.76.63])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Oct 2019 18:06:07 +0200
Date: Fri, 18 Oct 2019 18:06:08 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: julia@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <1a3776fe-7f18-e072-9bda-30d10ffd1c07@web.de>
Message-ID: <alpine.DEB.2.21.1910181805380.3697@hadrien>
References: <24130ec6-4a20-7be4-755f-a6dfffcb6c97@web.de>
 <alpine.DEB.2.21.1910101509370.2305@hadrien>
 <45be389f-23f9-cbff-fa5f-8ad111124f94@web.de>
 <alpine.DEB.2.21.1910181530460.3697@hadrien>
 <1a3776fe-7f18-e072-9bda-30d10ffd1c07@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-517767944-1571414768=:3697"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 18 Oct 2019 18:06:10 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Fri, 18 Oct 2019 18:06:07 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Software analysis with SmPL around unchecked pointer
 function calls
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

--8323329-517767944-1571414768=:3697
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Fri, 18 Oct 2019, Markus Elfring wrote:

> > expression *y;
>
> This specific information is interesting.
>
> It was mentioned that further software development concerns
> can occur around the possible application of function pointers.
> Now I would like to point another analysis concern out.
>
> The following SmPL search approach does not present the source code place
>
> @display@
> expression* x, y;
> @@
> *y = (x)(...);
>  ... when != y

device_link_add does not look like a function pointer.

julia

>
>
> which can found by an other script variant for further considerations.
>
> @display@
> expression x;
> @@
> *x = device_link_add(...);
>  ... when != x
>
>
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/iommu/rockchip-iommu.c?id=c4b9850b3676869ac0def5885d781d17f64b3a86#n1057
>
> elfring@Sonne:~/Projekte/Linux/next-patched> spatch drivers/iommu/rockchip-iommu.c ~/Projekte/Coccinelle/janitor/show_unchecked_device_link_add1.cocci
> …
> @@ -1072,8 +1072,6 @@ static int rk_iommu_add_device(struct de
>  	iommu_group_put(group);
>
>  	iommu_device_link(&iommu->iommu, dev);
> -	data->link = device_link_add(dev, iommu->dev,
> -				     DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME);
>
>  	return 0;
>  }
>
>
> Would you like to check the desired data processing in more detail then?
>
> Regards,
> Markus
>
--8323329-517767944-1571414768=:3697
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-517767944-1571414768=:3697--
