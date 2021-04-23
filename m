Return-Path: <SRS0=ruOc=JU=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29B3C433B4
	for <cocci@archiver.kernel.org>; Fri, 23 Apr 2021 10:05:28 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9969608FE
	for <cocci@archiver.kernel.org>; Fri, 23 Apr 2021 10:05:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9969608FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 13NA5Fsh000041;
	Fri, 23 Apr 2021 12:05:15 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1495577D8;
	Fri, 23 Apr 2021 12:05:15 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 24DBE3C26
 for <cocci@systeme.lip6.fr>; Fri, 23 Apr 2021 12:05:13 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 13NA580i007488
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 23 Apr 2021 12:05:08 +0200 (CEST)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AK3DrrKsT+mR5AvVNwaE/Hiko7skDy9V00zAX?=
 =?us-ascii?q?/kB9WHVpW+afkN2jm+le6A/shF8qKRYdsP2jGI3Fe3PT8pZp/ZIcVI3JYCDKsH?=
 =?us-ascii?q?alRbsSjrfK7CbnH0TFltJ18YdFX+xABMbrDV585Pya3CCdH8w7yNeKtICE7N2u?=
 =?us-ascii?q?rUtFdg1hZ6F+4woRMG/yeXFefhVMBpYyCfOnl696jgenEE5nCviTNz0qW6zmq8?=
 =?us-ascii?q?fQnJzrJSQaDwMqgTPjsRqYrJD9FRac0lMycRNqhY0j/2/MjhDj6syY3s2T+1vz?=
 =?us-ascii?q?0Wnc6pgTot/90594AtCWgMR9EFrRozftX4hqV72csD1dmo+S1Go=3D?=
X-IronPort-AV: E=Sophos;i="5.82,245,1613430000"; d="scan'208";a="504668035"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 23 Apr 2021 12:05:08 +0200
Date: Fri, 23 Apr 2021 12:05:08 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210423100033.78580-1-krzysztof.kozlowski@canonical.com>
Message-ID: <alpine.DEB.2.22.394.2104231204500.7983@hadrien>
References: <20210423100033.78580-1-krzysztof.kozlowski@canonical.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 23 Apr 2021 12:05:17 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 23 Apr 2021 12:05:08 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] coccinelle: irqf_oneshot: reduce the severity
 due to false positives
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



On Fri, 23 Apr 2021, Krzysztof Kozlowski wrote:

> The IRQF_ONESHOT should be present for threaded IRQ using default
> primary handler.  However intetrupt of many child devices, e.g. children
> of MFD, is nested thus the IRQF_ONESHOT is not needed.  The coccinelle
> message about error misleads submitters and reviewers about the severity
> of the issue, so make it a warning and mention possible false positive.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Applied.  Thanks for the clarification.

julia

> ---
>  scripts/coccinelle/misc/irqf_oneshot.cocci | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/coccinelle/misc/irqf_oneshot.cocci b/scripts/coccinelle/misc/irqf_oneshot.cocci
> index 7b48287b3dc1..9b6f404d07f2 100644
> --- a/scripts/coccinelle/misc/irqf_oneshot.cocci
> +++ b/scripts/coccinelle/misc/irqf_oneshot.cocci
> @@ -103,11 +103,11 @@ devm_request_threaded_irq@p(dev, irq, NULL, ...)
>  @script:python depends on org@
>  p << match.p;
>  @@
> -msg = "ERROR: Threaded IRQ with no primary handler requested without IRQF_ONESHOT"
> +msg = "WARNING: Threaded IRQ with no primary handler requested without IRQF_ONESHOT (unless it is nested IRQ)"
>  coccilib.org.print_todo(p[0],msg)
>
>  @script:python depends on report@
>  p << match.p;
>  @@
> -msg = "ERROR: Threaded IRQ with no primary handler requested without IRQF_ONESHOT"
> +msg = "WARNING: Threaded IRQ with no primary handler requested without IRQF_ONESHOT (unless it is nested IRQ)"
>  coccilib.report.print_report(p[0],msg)
> --
> 2.25.1
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
