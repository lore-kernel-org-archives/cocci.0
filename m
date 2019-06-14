Return-Path: <SRS0=u2QG=UN=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5FAC31E44
	for <cocci@archiver.kernel.org>; Fri, 14 Jun 2019 09:28:07 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 820052133D
	for <cocci@archiver.kernel.org>; Fri, 14 Jun 2019 09:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 820052133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5E9RoF4027086;
	Fri, 14 Jun 2019 11:27:50 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 70E777777;
	Fri, 14 Jun 2019 11:27:50 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E54137762
 for <cocci@systeme.lip6.fr>; Fri, 14 Jun 2019 11:27:48 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5E9RmbB028545
 for <cocci@systeme.lip6.fr>; Fri, 14 Jun 2019 11:27:48 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.63,372,1557180000"; d="scan'208";a="309239293"
Received: from unknown (HELO hadrien.local) ([163.173.90.224])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 14 Jun 2019 11:27:47 +0200
Date: Fri, 14 Jun 2019 11:27:47 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <032e347f-e575-c89c-fa62-473d52232735@web.de>
Message-ID: <alpine.DEB.2.20.1906141127030.9068@hadrien>
References: <20190406061112.31620-1-himanshujha199640@gmail.com>
 <f09006a3-691c-382a-23b8-8e9ff5b4a5f1@web.de>
 <alpine.DEB.2.21.1906081925090.2543@hadrien>
 <7b4fe770-dadd-80ba-2ba4-0f2bc90984ef@web.de>
 <f573b2d3-11d0-92b5-f8ab-4c4b6493e152@metux.net>
 <032e347f-e575-c89c-fa62-473d52232735@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 14 Jun 2019 11:27:50 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Fri, 14 Jun 2019 11:27:48 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: kernel-janitors@vger.kernel.org, Michal Marek <michal.lkml@markovi.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] drivers: Inline code in
 devm_platform_ioremap_resource() from two functions
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



On Fri, 14 Jun 2019, Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 14 Jun 2019 11:05:33 +0200
>
> Two function calls were combined in this function implementation.
> Inline corresponding code so that extra error checks can be avoided here.

I don't see any point to this at all.  By inlining the code, you have
created a clone, which will introduce extra work to maintain in the
future.

julia


>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/base/platform.c | 39 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 34 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 4d1729853d1a..baadca72f949 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -80,8 +80,8 @@ struct resource *platform_get_resource(struct platform_device *dev,
>  EXPORT_SYMBOL_GPL(platform_get_resource);
>
>  /**
> - * devm_platform_ioremap_resource - call devm_ioremap_resource() for a platform
> - *				    device
> + * devm_platform_ioremap_resource
> + * Achieve devm_ioremap_resource() functionality for a platform device
>   *
>   * @pdev: platform device to use both for memory resource lookup as well as
>   *        resource management
> @@ -91,10 +91,39 @@ EXPORT_SYMBOL_GPL(platform_get_resource);
>  void __iomem *devm_platform_ioremap_resource(struct platform_device *pdev,
>  					     unsigned int index)
>  {
> -	struct resource *res;
> +	u32 i;
>
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, index);
> -	return devm_ioremap_resource(&pdev->dev, res);
> +	for (i = 0; i < pdev->num_resources; i++) {
> +		struct resource *res = &pdev->resource[i];
> +
> +		if (resource_type(res) == IORESOURCE_MEM && index-- == 0) {
> +			struct device *dev = &pdev->dev;
> +			resource_size_t size = resource_size(res);
> +			void __iomem *dest;
> +
> +			if (!devm_request_mem_region(dev,
> +						     res->start,
> +						     size,
> +						     dev_name(dev))) {
> +				dev_err(dev,
> +					"can't request region for resource %pR\n",
> +					res);
> +				return IOMEM_ERR_PTR(-EBUSY);
> +			}
> +
> +			dest = devm_ioremap(dev, res->start, size);
> +			if (!dest) {
> +				dev_err(dev,
> +					"ioremap failed for resource %pR\n",
> +					res);
> +				devm_release_mem_region(dev, res->start, size);
> +				dest = IOMEM_ERR_PTR(-ENOMEM);
> +			}
> +
> +			return dest;
> +		}
> +	}
> +	return IOMEM_ERR_PTR(-EINVAL);
>  }
>  EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource);
>  #endif /* CONFIG_HAS_IOMEM */
> --
> 2.22.0
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
