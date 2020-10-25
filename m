Return-Path: <SRS0=peAA=EA=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D17DC388F7
	for <cocci@archiver.kernel.org>; Sun, 25 Oct 2020 18:28:35 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81AF622269
	for <cocci@archiver.kernel.org>; Sun, 25 Oct 2020 18:28:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81AF622269
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09PIS57K018606;
	Sun, 25 Oct 2020 19:28:05 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id AD2EC5C18;
	Sun, 25 Oct 2020 19:28:05 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B094B5C16
 for <cocci@systeme.lip6.fr>; Sun, 25 Oct 2020 19:28:04 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09PIS2Oh027272
 for <cocci@systeme.lip6.fr>; Sun, 25 Oct 2020 19:28:02 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.77,416,1596492000"; d="scan'208";a="362719074"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Oct 2020 19:28:02 +0100
Date: Sun, 25 Oct 2020 19:28:01 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <0d1575b0-ab37-663e-2464-278fd76280b5@web.de>
Message-ID: <alpine.DEB.2.22.394.2010251924290.2714@hadrien>
References: <0d1575b0-ab37-663e-2464-278fd76280b5@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-685740588-1603650482=:2714"
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 25 Oct 2020 19:28:05 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 25 Oct 2020 19:28:02 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci]
 =?utf-8?q?=5BPATCH=5D_Coccinelle=3A_null=3A_Optimise_disj?=
 =?utf-8?b?dW5jdGlvbnMgaW4gU21QTCBzY3JpcHQg4oCcZW5vLmNvY2Np4oCd?=
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

--8323329-685740588-1603650482=:2714
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sun, 25 Oct 2020, Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 25 Oct 2020 18:54:36 +0100
>
> A disjunction is applied by this script for the semantic patch language.
> This construct uses short-circuit evaluation. It has got the consequence
> that the last element of the specified condition will only be checked
> if all previous parts did not match. Such a technical detail leads to
> a recommended ordering of condition parts if you would like to care for
> optimal run time characteristics of SmPL code.
>
> An usage incidence was determined for the specified identifiers in source
> files from the software “Linux next-20201023” by another SmPL script.
>
> See also:
> Determination of an usage statistic for memory allocation calls
> https://lore.kernel.org/cocci/2774601.u91sIFNy1E@sonne/
>
> This analysis result indicates a clear ranking for such function calls.
> Thus reorder the SmPL disjunction items according to their usage incidence.

Did you actually test this before and after the change and see a
difference in performance?  On my laptop, I see absolutely no difference,
for the patch mode and for the context mode.  I didn't try the other
cases.

Before the change:

patch: 440.182u 2.049s 1:53.12 390.9%	0+0k 0+232io 4pf+0w
context: 392.931u 2.164s 1:41.53 389.1%	0+0k 432+360io 5pf+0w

After the change:

patch: 442.182u 2.090s 1:54.13 389.2%	0+0k 0+240io 4pf+0w
context: 392.742u 2.035s 1:41.37 389.4%	0+0k 0+360io 4pf+0w

julia

>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  scripts/coccinelle/null/eno.cocci | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/coccinelle/null/eno.cocci b/scripts/coccinelle/null/eno.cocci
> index 81584ff87956..969cab5116a9 100644
> --- a/scripts/coccinelle/null/eno.cocci
> +++ b/scripts/coccinelle/null/eno.cocci
> @@ -17,8 +17,16 @@ virtual report
>  @depends on patch@
>  expression x,E;
>  @@
> -
> -x = \(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|kmem_cache_alloc_node\|kmalloc_node\|kzalloc_node\)(...)
> + x =
> +(kzalloc
> +|kmalloc
> +|kcalloc
> +|kmem_cache_alloc
> +|kmem_cache_zalloc
> +|kzalloc_node
> +|kmalloc_node
> +|kmem_cache_alloc_node
> +)(...)
>  ... when != x = E
>  - IS_ERR(x)
>  + !x
> @@ -27,8 +35,7 @@ x = \(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|kmem_cache
>  expression x,E;
>  position p1,p2;
>  @@
> -
> -*x = \(kmalloc@p1\|kzalloc@p1\|kcalloc@p1\|kmem_cache_alloc@p1\|kmem_cache_zalloc@p1\|kmem_cache_alloc_node@p1\|kmalloc_node@p1\|kzalloc_node@p1\)(...)
> +*x = \(kzalloc@p1\|kmalloc@p1\|kcalloc@p1\|kmem_cache_alloc@p1\|kmem_cache_zalloc@p1\|kzalloc_node@p1\|kmalloc_node@p1\|kmem_cache_alloc_node@p1\)(...)
>  ... when != x = E
>  * IS_ERR@p2(x)
>
> --
> 2.29.1
>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
--8323329-685740588-1603650482=:2714
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--8323329-685740588-1603650482=:2714--
