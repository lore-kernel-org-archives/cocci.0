Return-Path: <SRS0=2FHN=YM=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F421ACA9EAC
	for <cocci@archiver.kernel.org>; Sat, 19 Oct 2019 15:41:59 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CC9420854
	for <cocci@archiver.kernel.org>; Sat, 19 Oct 2019 15:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CC9420854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9JFfjsX003029;
	Sat, 19 Oct 2019 17:41:45 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1E01A77B8;
	Sat, 19 Oct 2019 17:41:45 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2CE207792
 for <cocci@systeme.lip6.fr>; Sat, 19 Oct 2019 17:41:43 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9JFfgxu029721
 for <cocci@systeme.lip6.fr>; Sat, 19 Oct 2019 17:41:42 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.67,316,1566856800"; d="scan'208";a="323303959"
Received: from ip-121.net-89-2-166.rev.numericable.fr (HELO hadrien)
 ([89.2.166.121])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Oct 2019 17:41:42 +0200
Date: Sat, 19 Oct 2019 17:41:41 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <32b67cc6-0dd9-6615-d8ed-5c2dfe2af863@web.de>
Message-ID: <alpine.DEB.2.21.1910191740020.3272@hadrien>
References: <24130ec6-4a20-7be4-755f-a6dfffcb6c97@web.de>
 <alpine.DEB.2.21.1910101509370.2305@hadrien>
 <45be389f-23f9-cbff-fa5f-8ad111124f94@web.de>
 <alpine.DEB.2.21.1910181530460.3697@hadrien>
 <1a3776fe-7f18-e072-9bda-30d10ffd1c07@web.de>
 <32b67cc6-0dd9-6615-d8ed-5c2dfe2af863@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-992095152-1571499702=:3272"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 19 Oct 2019 17:41:45 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Sat, 19 Oct 2019 17:41:42 +0200 (CEST)
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

--8323329-992095152-1571499702=:3272
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sat, 19 Oct 2019, Markus Elfring wrote:

> > Now I would like to point another analysis concern out.
>
> You informed me about an approach for the usage of when constraints
> with the semantic patch language in the following way according to
> the discussion topic “Detection of unused function return values”
> (on 2011-12-11).
>
> “…
> Rule r checks that there is no use on any execution path.
> …”
>
>
> I came along the use case again to work with related information.
> The currently discussed SmPL script variant points also the following
> source code place out for further considerations.
> https://elixir.bootlin.com/linux/v5.4-rc2/source/drivers/gpu/drm/arm/display/komeda/komeda_dev.c#L210
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/gpu/drm/arm/display/komeda/komeda_dev.c?id=c4b9850b3676869ac0def5885d781d17f64b3a86#n222
>
> …
> @@ -222,… @@ struct komeda_dev *komeda_dev_create(str
>
>  	clk_prepare_enable(mdev->aclk);
>
> -	mdev->funcs = product->identify(mdev->reg_base, &mdev->chip);
>  	if (!komeda_product_match(mdev, product->product_id)) {
> …
> 	mdev->funcs->init_format_table(mdev);
>
> 	err = mdev->funcs->enum_resources(mdev);
> …
>
>
> Now I would appreciate once more if the description for the supported
> software behaviour can be completed for the safe usage of SmPL
> code exclusion specifications.
> I see that a function pointer is appropriately used here.
> Thus I wonder where my understanding of the software situation around
> the program “spatch” seems still too incomplete.

I have no idea what you are asking about here.  Are you concerned that you
don't know the return type of mdev->funcs->init_format_table?  Coccinelle
has limited access to type information, as it may not be able to find some
relevant header files.  It doesn't even try very hard to find header files
unless you use options such as --all-includes or --recursive-includes,
which will incur a substantial performance overhead.

julia
--8323329-992095152-1571499702=:3272
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-992095152-1571499702=:3272--
