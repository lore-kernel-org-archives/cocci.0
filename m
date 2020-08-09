Return-Path: <SRS0=Y7kI=BT=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE319C433DF
	for <cocci@archiver.kernel.org>; Sun,  9 Aug 2020 11:26:02 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40C89206A2
	for <cocci@archiver.kernel.org>; Sun,  9 Aug 2020 11:26:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40C89206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 079BPdRW014036;
	Sun, 9 Aug 2020 13:25:39 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 71C46428B;
	Sun,  9 Aug 2020 13:25:39 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 269434084
 for <cocci@systeme.lip6.fr>; Sun,  9 Aug 2020 13:25:37 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 079BPZuQ026495
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 9 Aug 2020 13:25:35 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.75,453,1589234400"; d="scan'208";a="356217592"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Aug 2020 13:25:35 +0200
Date: Sun, 9 Aug 2020 13:25:34 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <b5c83a17-e04f-2d10-9506-12c50b3de9b9@web.de>
Message-ID: <alpine.DEB.2.22.394.2008091324530.2450@hadrien>
References: <1ae3eefe-fa5a-a497-f00b-5638f4191e90@web.de>
 <b5c83a17-e04f-2d10-9506-12c50b3de9b9@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 09 Aug 2020 13:25:39 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 09 Aug 2020 13:25:36 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>, kernel-janitors@vger.kernel.org,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] [PATCH] Coccinelle: Reduce duplicate code for patch
 rules of memdup_user.cocci
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



On Sun, 9 Aug 2020, Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 9 Aug 2020 11:11:20 +0200
>
> Another patch rule was added. A bit of code was copied from a previous
> SmPL rule for this change specification.
>
> * Thus reduce duplicate code by using another SmPL disjunction.

I don't care about this issue.

>
> * Increase the precision a bit for desired source code adjustments.

This gives no information.  If you explain the improvement in an
understandable way, I will consider whether it is useful to take the
patch.

julia

> Fixes: 9c568dbd677bcfc975220d3157c89c48669a23e3 ("coccinelle: api: extend memdup_user rule with vmemdup_user()")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  scripts/coccinelle/api/memdup_user.cocci | 44 +++++++++---------------
>  1 file changed, 16 insertions(+), 28 deletions(-)
>
> diff --git a/scripts/coccinelle/api/memdup_user.cocci b/scripts/coccinelle/api/memdup_user.cocci
> index e01e95108405..7cf698b4e925 100644
> --- a/scripts/coccinelle/api/memdup_user.cocci
> +++ b/scripts/coccinelle/api/memdup_user.cocci
> @@ -27,34 +27,22 @@ expression from,to,size;
>  identifier l1,l2;
>  position p : script:python() { relevant(p) };
>  @@
> -
> --  to = \(kmalloc@p\|kzalloc@p\)
> --		(size,\(GFP_KERNEL\|GFP_USER\|
> --		      \(GFP_KERNEL\|GFP_USER\)|__GFP_NOWARN\));
> -+  to = memdup_user(from,size);
> -   if (
> --      to==NULL
> -+      IS_ERR(to)
> -                 || ...) {
> -   <+... when != goto l1;
> --  -ENOMEM
> -+  PTR_ERR(to)
> -   ...+>
> -   }
> --  if (copy_from_user(to, from, size) != 0) {
> --    <+... when != goto l2;
> --    -EFAULT
> --    ...+>
> --  }
> -
> -@depends on patch@
> -expression from,to,size;
> -identifier l1,l2;
> -position p : script:python() { relevant(p) };
> -@@
> -
> --  to = \(kvmalloc@p\|kvzalloc@p\)(size,\(GFP_KERNEL\|GFP_USER\));
> -+  to = vmemdup_user(from,size);
> + to =
> +(
> +-     \(kmalloc@p\|kzalloc@p\)
> ++     memdup_user
> +      (
> +-      size, \( \(GFP_KERNEL\|GFP_USER\) \| \(GFP_KERNEL\|GFP_USER\)|__GFP_NOWARN \)
> ++      from, size
> +      )
> +|
> +-     \(kvmalloc@p\|kvzalloc@p\)
> ++     vmemdup_user
> +      (
> +-      size, \(GFP_KERNEL\|GFP_USER\)
> ++      from, size
> +      )
> +);
>     if (
>  -      to==NULL
>  +      IS_ERR(to)
> --
> 2.28.0
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
