Return-Path: <SRS0=qeJI=VW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DE5C7618B
	for <cocci@archiver.kernel.org>; Thu, 25 Jul 2019 11:22:09 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0003A2238C
	for <cocci@archiver.kernel.org>; Thu, 25 Jul 2019 11:22:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0003A2238C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6PBLqpl008243;
	Thu, 25 Jul 2019 13:21:52 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 63E44777C;
	Thu, 25 Jul 2019 13:21:52 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id AE79176BF
 for <cocci@systeme.lip6.fr>; Thu, 25 Jul 2019 13:21:50 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6PBLoPn001523
 for <cocci@systeme.lip6.fr>; Thu, 25 Jul 2019 13:21:50 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.64,306,1559512800"; d="scan'208";a="393273205"
Received: from c-73-22-29-55.hsd1.il.comcast.net (HELO hadrien) ([73.22.29.55])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Jul 2019 13:21:32 +0200
Date: Thu, 25 Jul 2019 06:21:29 -0500 (CDT)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Matthias Maennich <maennich@google.com>
In-Reply-To: <20190725101705.179924-1-maennich@google.com>
Message-ID: <alpine.DEB.2.21.1907250621120.2535@hadrien>
References: <20190725101705.179924-1-maennich@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 25 Jul 2019 13:21:52 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Thu, 25 Jul 2019 13:21:50 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>, gregkh@linuxfoundation.org,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        linux-spdx@vger.kernel.org, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] coccinelle: api/atomic_as_refcounter: add SPDX
 License Identifier
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



On Thu, 25 Jul 2019, Matthias Maennich wrote:

> Add the missing GPLv2 SPDX license identifier.
>
> It appears this single file was missing from 7f904d7e1f3e ("treewide:
> Replace GPLv2 boilerplate/reference with SPDX - rule 505"), which
> addressed all other files in scripts/coccinelle. Hence I added
> GPL-2.0-only consitently with the mentioned patch.
>
> Cc: linux-spdx@vger.kernel.org
> Cc: Elena Reshetova <elena.reshetova@intel.com>
> Signed-off-by: Matthias Maennich <maennich@google.com>

Acked-by: Julia Lawall <julia.lawall@lip6.fr>

Thanks!


> ---
>  scripts/coccinelle/api/atomic_as_refcounter.cocci | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/coccinelle/api/atomic_as_refcounter.cocci b/scripts/coccinelle/api/atomic_as_refcounter.cocci
> index 988120e0fd67..0f78d94abc35 100644
> --- a/scripts/coccinelle/api/atomic_as_refcounter.cocci
> +++ b/scripts/coccinelle/api/atomic_as_refcounter.cocci
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>  // Check if refcount_t type and API should be used
>  // instead of atomic_t type when dealing with refcounters
>  //
> --
> 2.22.0.657.g960e92d24f-goog
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
