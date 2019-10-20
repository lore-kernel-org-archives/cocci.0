Return-Path: <SRS0=QaTm=YN=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DE7CA9EA9
	for <cocci@archiver.kernel.org>; Sun, 20 Oct 2019 05:42:58 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2EF321929
	for <cocci@archiver.kernel.org>; Sun, 20 Oct 2019 05:42:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2EF321929
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9K5geKp012441;
	Sun, 20 Oct 2019 07:42:40 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DFCD57792;
	Sun, 20 Oct 2019 07:42:39 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 733BE76F6
 for <cocci@systeme.lip6.fr>; Sun, 20 Oct 2019 07:42:38 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9K5gb4Z012806
 for <cocci@systeme.lip6.fr>; Sun, 20 Oct 2019 07:42:37 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.67,318,1566856800"; d="scan'208";a="323338896"
Received: from ip-121.net-89-2-166.rev.numericable.fr (HELO hadrien)
 ([89.2.166.121])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 20 Oct 2019 07:42:37 +0200
Date: Sun, 20 Oct 2019 07:42:36 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <958b4a11-e45b-3795-a3cb-08f98aaa40d6@web.de>
Message-ID: <alpine.DEB.2.21.1910200741180.3689@hadrien>
References: <24130ec6-4a20-7be4-755f-a6dfffcb6c97@web.de>
 <alpine.DEB.2.21.1910101509370.2305@hadrien>
 <45be389f-23f9-cbff-fa5f-8ad111124f94@web.de>
 <alpine.DEB.2.21.1910181530460.3697@hadrien>
 <1a3776fe-7f18-e072-9bda-30d10ffd1c07@web.de>
 <32b67cc6-0dd9-6615-d8ed-5c2dfe2af863@web.de>
 <alpine.DEB.2.21.1910191740020.3272@hadrien>
 <958b4a11-e45b-3795-a3cb-08f98aaa40d6@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-305256650-1571550157=:3689"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 20 Oct 2019 07:42:40 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Sun, 20 Oct 2019 07:42:37 +0200 (CEST)
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

--8323329-305256650-1571550157=:3689
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sat, 19 Oct 2019, Markus Elfring wrote:

> >> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/gpu/drm/arm/display/komeda/komeda_dev.c?id=c4b9850b3676869ac0def5885d781d17f64b3a86#n222
> >>
> >> …
> >> @@ -222,… @@ struct komeda_dev *komeda_dev_create(str
> >>
> >>  	clk_prepare_enable(mdev->aclk);
> >>
> >> -	mdev->funcs = product->identify(mdev->reg_base, &mdev->chip);
> >>  	if (!komeda_product_match(mdev, product->product_id)) {
> >> …
> >> 	mdev->funcs->init_format_table(mdev);
> >>
> >> 	err = mdev->funcs->enum_resources(mdev);
> >> …
> >>
> >>
> >> Now I would appreciate once more if the description for the supported
> >> software behaviour can be completed for the safe usage of SmPL
> >> code exclusion specifications.
> …
> > I have no idea what you are asking about here.
>
> I hope that another wording approach can contribute another bit
> to a better common understanding of the involved source code
> analysis expectations.
>
>
> > Are you concerned that you don't know the return type of mdev->funcs->init_format_table?
>
> No, not in this test case.
>
> This member function is declared with the return type “void”.
> https://elixir.bootlin.com/linux/v5.4-rc2/source/drivers/gpu/drm/arm/display/komeda/komeda_dev.h#L83
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/gpu/drm/arm/display/komeda/komeda_dev.h?id=c4b9850b3676869ac0def5885d781d17f64b3a86#n94
>
> I would find this function call questionable otherwise.
>
> The desired function is determined over the pointer “mdev->funcs”
> which was provided by a call of the function “product->identify(…)”.
> The provided function pointer is actually not directly checked
> after the data structure member assignment.
> This could be an analysis concern. (But it can be determined by inspection
> of involved source files that a valid pointer will probably be set.
> I assume that the exclusion of null pointers would be too challenging
> for the discussed tiny SmPL script.)
>
> The uncertainty around the partly (un)documented software behaviour
> for SmPL when constraints makes it unclear then if the presented
> source code place should finally be treated as a false positive.
> Should it have been excluded because pointer expressions should be detectable
> for the metavariable “y” (a bit later)?

Coccinelle only knows the type of mdev->funcs if it sees the type
definition of mdev.  It doesn't take into account the subsequent usage of
mdev->funcs to determine that this value is a pointer.

julia

>
> Regards,
> Markus
>
--8323329-305256650-1571550157=:3689
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-305256650-1571550157=:3689--
