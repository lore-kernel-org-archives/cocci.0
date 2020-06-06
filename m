Return-Path: <SRS0=zMkO=7T=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF23C433E0
	for <cocci@archiver.kernel.org>; Sat,  6 Jun 2020 09:28:05 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B4172073E
	for <cocci@archiver.kernel.org>; Sat,  6 Jun 2020 09:28:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B4172073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0569S2MM026393;
	Sat, 6 Jun 2020 11:28:02 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5C2795D47;
	Sat,  6 Jun 2020 11:28:02 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id CBFA73BAB
 for <cocci@systeme.lip6.fr>; Sat,  6 Jun 2020 11:28:00 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0569S0Ph014215
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sat, 6 Jun 2020 11:28:00 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.73,479,1583190000"; d="scan'208";a="350763717"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Jun 2020 11:27:59 +0200
Date: Sat, 6 Jun 2020 11:27:59 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Denis Efremov <efremov@linux.com>
In-Reply-To: <20200530205348.5812-3-efremov@linux.com>
Message-ID: <alpine.DEB.2.21.2006061122400.2578@hadrien>
References: <20200530205348.5812-1-efremov@linux.com>
 <20200530205348.5812-3-efremov@linux.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 06 Jun 2020 11:28:03 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 06 Jun 2020 11:28:00 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Joe Perches <joe@perches.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH 2/2] Coccinelle: extend memdup_user rule with
 vmemdup_user()
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



On Sat, 30 May 2020, Denis Efremov wrote:

> Add vmemdup_user() transformations to the memdup_user.cocci rule.
> Commit 50fd2f298bef ("new primitive: vmemdup_user()") introduced
> vmemdup_user(). The function uses kvmalloc with GPF_USER flag.
>
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  scripts/coccinelle/api/memdup_user.cocci | 49 +++++++++++++++++++++++-
>  1 file changed, 47 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/coccinelle/api/memdup_user.cocci b/scripts/coccinelle/api/memdup_user.cocci
> index 49f487e6a5c8..a50def35136e 100644
> --- a/scripts/coccinelle/api/memdup_user.cocci
> +++ b/scripts/coccinelle/api/memdup_user.cocci
> @@ -37,6 +37,28 @@ identifier l1,l2;
>  -    ...+>
>  -  }
>
> +@depends on patch@
> +expression from,to,size;
> +identifier l1,l2;
> +@@
> +
> +-  to = \(kvmalloc\|kvzalloc\)(size,\(GFP_KERNEL\|GFP_USER\));
> ++  to = vmemdup_user(from,size);
> +   if (
> +-      to==NULL
> ++      IS_ERR(to)
> +                 || ...) {
> +   <+... when != goto l1;
> +-  -ENOMEM
> ++  PTR_ERR(to)
> +   ...+>
> +   }
> +-  if (copy_from_user(to, from, size) != 0) {
> +-    <+... when != goto l2;
> +-    -EFAULT
> +-    ...+>
> +-  }
> +

This could protect against modifying vmemdup_user.  Probably the original
rule should protect against modifying memdup_user as well.

julia




>  @r depends on !patch@
>  expression from,to,size;
>  position p;
> @@ -48,14 +70,37 @@ statement S1,S2;
>     if (copy_from_user(to, from, size) != 0)
>     S2
>
> -@script:python depends on org@
> +@rv depends on !patch@
> +expression from,to,size;
> +position p;
> +statement S1,S2;
> +@@
> +
> +*  to = \(kvmalloc@p\|kvzalloc@p\)(size,\(GFP_KERNEL\|GFP_USER\));
> +   if (to==NULL || ...) S1
> +   if (copy_from_user(to, from, size) != 0)
> +   S2
> +
> +@script:python depends on org && r@
>  p << r.p;
>  @@
>
>  coccilib.org.print_todo(p[0], "WARNING opportunity for memdup_user")
>
> -@script:python depends on report@
> +@script:python depends on report && r@
>  p << r.p;
>  @@
>
>  coccilib.report.print_report(p[0], "WARNING opportunity for memdup_user")
> +
> +@script:python depends on org && rv@
> +p << rv.p;
> +@@
> +
> +coccilib.org.print_todo(p[0], "WARNING opportunity for vmemdup_user")
> +
> +@script:python depends on report && rv@
> +p << rv.p;
> +@@
> +
> +coccilib.report.print_report(p[0], "WARNING opportunity for vmemdup_user")
> --
> 2.26.2
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
