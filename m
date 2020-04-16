Return-Path: <SRS0=lBEj=6A=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36F1C2BB55
	for <cocci@archiver.kernel.org>; Thu, 16 Apr 2020 12:45:26 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42DBA21D94
	for <cocci@archiver.kernel.org>; Thu, 16 Apr 2020 12:45:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42DBA21D94
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03GCj80a018084;
	Thu, 16 Apr 2020 14:45:08 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B2109781F;
	Thu, 16 Apr 2020 14:45:08 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8C2D27816
 for <cocci@systeme.lip6.fr>; Thu, 16 Apr 2020 14:45:07 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03GCj7a6002624
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 16 Apr 2020 14:45:07 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.72,391,1580770800"; d="scan'208";a="346117496"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 16 Apr 2020 14:45:06 +0200
Date: Thu, 16 Apr 2020 14:45:06 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <0365dceb-3b66-48cd-c273-4bf7fceb4688@web.de>
Message-ID: <alpine.DEB.2.21.2004161444300.8125@hadrien>
References: <25b804fd-0d04-475d-f614-26c03c9fd544@web.de>
 <alpine.DEB.2.21.2004151949230.2381@hadrien>
 <5702b553-d054-33a4-8544-f68ed5457acc@web.de>
 <alpine.DEB.2.21.2004161052210.2447@hadrien>
 <0365dceb-3b66-48cd-c273-4bf7fceb4688@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 16 Apr 2020 14:45:08 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 16 Apr 2020 14:45:07 +0200 (CEST)
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr



On Thu, 16 Apr 2020, Markus Elfring wrote:

> >> elfring@Sonne:~/Projekte/Linux/next-patched> spatch --include-headers-for-types ~/Projekte/Coccinelle/janitor/use_devm_platform_get_and_ioremap_resource3.cocci drivers/i2c/busses/i2c-rcar.c
> >
> > No, include headers for types doesn't have any impact on how many header
> > files are included.  You need options like --all-includes or
> > --recursive-includes.
>
> I still observe that the known patch hunk is not generated even with the addition
> of one of these command options.
> https://lore.kernel.org/patchwork/patch/1223734/
> https://lore.kernel.org/linux-i2c/20200414134827.18674-1-zhengdejin5@gmail.com/
>
> Would I need any extra parameters here?

Perhaps -I options to help it find the relevant .h file.

julia

>
>
> Will the Coccinelle software need any further improvements also around the
> desired processing for pointers and corresponding data structures?
>
> Regards,
> Markus
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
