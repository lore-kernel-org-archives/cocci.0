Return-Path: <SRS0=7S2e=HT=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D161C433E0
	for <cocci@archiver.kernel.org>; Wed, 17 Feb 2021 21:31:24 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 896A964E58
	for <cocci@archiver.kernel.org>; Wed, 17 Feb 2021 21:31:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 896A964E58
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 11HLV8Wn002104;
	Wed, 17 Feb 2021 22:31:08 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 080E777C0;
	Wed, 17 Feb 2021 22:31:08 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id CD5C424DD
 for <cocci@systeme.lip6.fr>; Wed, 17 Feb 2021 22:31:06 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 11HLV6Ux012125
 for <cocci@systeme.lip6.fr>; Wed, 17 Feb 2021 22:31:06 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.81,185,1610406000"; d="scan'208";a="373372739"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Feb 2021 22:31:06 +0100
Date: Wed, 17 Feb 2021 22:31:05 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Denis Efremov <efremov@linux.com>
In-Reply-To: <20210216080133.455456-1-efremov@linux.com>
Message-ID: <alpine.DEB.2.22.394.2102172224570.3081@hadrien>
References: <20210216080133.455456-1-efremov@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 17 Feb 2021 22:31:08 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 17 Feb 2021 22:31:06 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH] coccinelle: misc: add swap script
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

> +@depends on patch@
> +identifier tmp;
> +expression a, b;
> +type T;
> +@@
> +
> +(
> +- T tmp;
> +|
> +- T tmp = 0;
> +|
> +- T *tmp = NULL;
> +)
> +... when != tmp
> +- tmp = a;
> +- a = b;
> +- b = tmp;
> ++ swap(a, b);
> +... when != tmp

In this rule and the next one, if you remove the final ; from the b = tmp
line and from the swap line, and put it into context code afterwards, them
the generated code looks better on cases like fs/xfs/xfs_inode.c in the
function xfs_lock_two_inodes where two successive swap calls are
generated.

There are also some cases such as drivers/net/wireless/ath/ath5k/phy.c in
the function ath5k_hw_get_median_noise_floor where the swap code makes up
a whole if branch.  In this cases it would be good to remove the {}.

julia

> +
> +@depends on patch@
> +identifier tmp;
> +expression a, b;
> +@@
> +
> +- tmp = a;
> +- a = b;
> +- b = tmp;
> ++ swap(a, b);
> +
> +@script:python depends on report@
> +p << r.p;
> +@@
> +
> +coccilib.report.print_report(p[0], "WARNING opportunity for swap()")
> +
> +@script:python depends on org@
> +p << r.p;
> +@@
> +
> +coccilib.org.print_todo(p[0], "WARNING opportunity for swap()")
> --
> 2.26.2
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
