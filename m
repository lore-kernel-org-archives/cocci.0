Return-Path: <SRS0=Nw/E=SK=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8F0C10F13
	for <cocci@archiver.kernel.org>; Mon,  8 Apr 2019 19:20:16 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7ADE20879
	for <cocci@archiver.kernel.org>; Mon,  8 Apr 2019 19:20:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7ADE20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x38JJjAt003145
          ; Mon, 8 Apr 2019 21:19:45 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0F70A772A;
	Mon,  8 Apr 2019 21:19:45 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9CC6F771D
 for <cocci@systeme.lip6.fr>; Mon,  8 Apr 2019 21:19:43 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x38JJgXE001198
 for <cocci@systeme.lip6.fr>; Mon, 8 Apr 2019 21:19:42 +0200 (CEST)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.60,326,1549926000"; d="scan'208";a="302216733"
Received: from abo-75-106-68.mrs.modulonet.fr (HELO hadrien) ([85.68.106.75])
 by mail3-relais-sop.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 21:19:42 +0200
Date: Mon, 8 Apr 2019 21:19:41 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Rikard Falkeborn <rikard.falkeborn@gmail.com>
In-Reply-To: <20190408191432.1269-1-rikard.falkeborn@gmail.com>
Message-ID: <alpine.DEB.2.21.1904082119190.2612@hadrien>
References: <20190408191432.1269-1-rikard.falkeborn@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 08 Apr 2019 21:19:45 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Mon, 08 Apr 2019 21:19:42 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: michal.lkml@markovi.net, nicolas.palix@imag.fr,
        linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] Coccinelle: kstrdup: Fix typo in warning
	messages
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



On Mon, 8 Apr 2019, Rikard Falkeborn wrote:

> Replace 'kstrdep' with 'kstrdup' in warning messages.
>
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Acked-by: Julia.Lawall@lip6.fr

Thanks for the patch!

julia

> ---
>  scripts/coccinelle/api/kstrdup.cocci | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/coccinelle/api/kstrdup.cocci b/scripts/coccinelle/api/kstrdup.cocci
> index 09cba54ed0cf..6d13d54a6ee6 100644
> --- a/scripts/coccinelle/api/kstrdup.cocci
> +++ b/scripts/coccinelle/api/kstrdup.cocci
> @@ -76,7 +76,7 @@ p1 << r1.p1;
>  p2 << r1.p2;
>  @@
>
> -cocci.print_main("WARNING opportunity for kstrdep",p1)
> +cocci.print_main("WARNING opportunity for kstrdup",p1)
>  cocci.print_secs("strcpy",p2)
>
>  @script:python depends on org@
> @@ -84,7 +84,7 @@ p1 << r2.p1;
>  p2 << r2.p2;
>  @@
>
> -cocci.print_main("WARNING opportunity for kstrdep",p1)
> +cocci.print_main("WARNING opportunity for kstrdup",p1)
>  cocci.print_secs("memcpy",p2)
>
>  @script:python depends on report@
> @@ -92,7 +92,7 @@ p1 << r1.p1;
>  p2 << r1.p2;
>  @@
>
> -msg = "WARNING opportunity for kstrdep (strcpy on line %s)" % (p2[0].line)
> +msg = "WARNING opportunity for kstrdup (strcpy on line %s)" % (p2[0].line)
>  coccilib.report.print_report(p1[0], msg)
>
>  @script:python depends on report@
> @@ -100,5 +100,5 @@ p1 << r2.p1;
>  p2 << r2.p2;
>  @@
>
> -msg = "WARNING opportunity for kstrdep (memcpy on line %s)" % (p2[0].line)
> +msg = "WARNING opportunity for kstrdup (memcpy on line %s)" % (p2[0].line)
>  coccilib.report.print_report(p1[0], msg)
> --
> 2.21.0
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
