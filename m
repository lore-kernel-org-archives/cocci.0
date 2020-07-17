Return-Path: <SRS0=I1ac=A4=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8222C433E0
	for <cocci@archiver.kernel.org>; Fri, 17 Jul 2020 20:56:28 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41A312074B
	for <cocci@archiver.kernel.org>; Fri, 17 Jul 2020 20:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A312074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 06HKu8bD013047;
	Fri, 17 Jul 2020 22:56:08 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0DFAD3F5B;
	Fri, 17 Jul 2020 22:56:08 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7F69E3D0F
 for <cocci@systeme.lip6.fr>; Fri, 17 Jul 2020 22:56:06 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 06HKu5rW024333
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 17 Jul 2020 22:56:06 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.75,364,1589234400"; d="scan'208";a="354705512"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 17 Jul 2020 22:56:05 +0200
Date: Fri, 17 Jul 2020 22:56:05 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Denis Efremov <efremov@linux.com>
In-Reply-To: <20200608150038.223747-2-efremov@linux.com>
Message-ID: <alpine.DEB.2.22.394.2007172255560.2837@hadrien>
References: <20200608150038.223747-1-efremov@linux.com>
 <20200608150038.223747-2-efremov@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 17 Jul 2020 22:56:08 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 17 Jul 2020 22:56:06 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH v2 1/4] coccinelle: api: extend memdup_user
 transformation with GFP_USER
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



On Mon, 8 Jun 2020, Denis Efremov wrote:

> Match GFP_USER and optional __GFP_NOWARN allocations with
> memdup_user.cocci rule.
> Commit 6c2c97a24f09 ("memdup_user(): switch to GFP_USER") switched
> memdup_user() from GFP_KERNEL to GFP_USER. In almost all cases it
> is still a good idea to recommend memdup_user() for GFP_KERNEL
> allocations. The motivation behind altering memdup_user() to GFP_USER:
> https://lkml.org/lkml/2018/1/6/333
>
> Signed-off-by: Denis Efremov <efremov@linux.com>

Applied.

> ---
>  scripts/coccinelle/api/memdup_user.cocci | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/coccinelle/api/memdup_user.cocci b/scripts/coccinelle/api/memdup_user.cocci
> index c809ab10bbce..cadcc2e87881 100644
> --- a/scripts/coccinelle/api/memdup_user.cocci
> +++ b/scripts/coccinelle/api/memdup_user.cocci
> @@ -20,7 +20,9 @@ expression from,to,size;
>  identifier l1,l2;
>  @@
>
> --  to = \(kmalloc\|kzalloc\)(size,GFP_KERNEL);
> +-  to = \(kmalloc\|kzalloc\)
> +		(size,\(GFP_KERNEL\|GFP_USER\|
> +		      \(GFP_KERNEL\|GFP_USER\)|__GFP_NOWARN\));
>  +  to = memdup_user(from,size);
>     if (
>  -      to==NULL
> @@ -43,7 +45,9 @@ position p;
>  statement S1,S2;
>  @@
>
> -*  to = \(kmalloc@p\|kzalloc@p\)(size,GFP_KERNEL);
> +*  to = \(kmalloc@p\|kzalloc@p\)
> +		(size,\(GFP_KERNEL\|GFP_USER\|
> +		      \(GFP_KERNEL\|GFP_USER\)|__GFP_NOWARN\));
>     if (to==NULL || ...) S1
>     if (copy_from_user(to, from, size) != 0)
>     S2
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
