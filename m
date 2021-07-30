Return-Path: <SRS0=v5gi=MW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81408C4338F
	for <cocci@archiver.kernel.org>; Fri, 30 Jul 2021 10:58:55 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF62C60F0F
	for <cocci@archiver.kernel.org>; Fri, 30 Jul 2021 10:58:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DF62C60F0F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 16UAwldK023178;
	Fri, 30 Jul 2021 12:58:47 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DB2827779;
	Fri, 30 Jul 2021 12:58:46 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9E7173FE7
 for <cocci@systeme.lip6.fr>; Fri, 30 Jul 2021 12:58:45 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 16UAwewb014251
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 30 Jul 2021 12:58:41 +0200 (CEST)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A2eBEUquv5/I2tx8aNsVdyL8A7skDr9V00zEX?=
 =?us-ascii?q?/kB9WHVpm62j+/xG+c5x6faaslkssQ4b9+xoVJPgfZr3z/5ICPAqTNSftVDdyQ?=
 =?us-ascii?q?mVxeJZnO7fKkPbaknDH7VmpMBdmsFFYbXN5D5B/KDHCWKDfurIruPszEhd792u?=
 =?us-ascii?q?tkuFNTsaE52JZGxCe32m+sccfng9OXKBf6Dsm/Z6mw=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.84,281,1620684000"; d="scan'208";a="389360966"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 30 Jul 2021 12:58:40 +0200
Date: Fri, 30 Jul 2021 12:58:40 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To: Daniel Thompson <daniel.thompson@linaro.org>
In-Reply-To: <20210730095856.2038286-1-daniel.thompson@linaro.org>
Message-ID: <alpine.DEB.2.22.394.2107301257470.52326@hadrien>
References: <20210730095856.2038286-1-daniel.thompson@linaro.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 30 Jul 2021 12:58:47 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 30 Jul 2021 12:58:41 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH] scripts: coccinelle: allow list_entry_is_head()
 to use pos
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



On Fri, 30 Jul 2021, Daniel Thompson wrote:

> Currently use_after_iter.cocci generates false positives for code of the
> following form:
> ~~~
> 	list_for_each_entry(d, &ddata->irq_list, node) {
> 		if (irq == d->irq)
> 			break;
> 	}
>
> 	if (list_entry_is_head(d, &ddata->irq_list, node))
> 		return IRQ_NONE;
> ~~~
> [This specific example comes from drivers/power/supply/cpcap-battery.c]
>
> Most list macros use list_entry_is_head() as loop exit condition meaning it
> is not unsafe to reuse pos (a.k.a. d) in the code above.
>
> Let's avoid reporting these cases.
>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>
> Notes:
>     I'm pretty much a complete beginner w.r.t. SmPL. This is written
>     entirely by finding previous fixes and emulating them!
>
>     However I did test it by running the checker across the current kernel
>     tree. The changes reduced the error count by four... which was small
>     enough for me to eyeball each one and check they match the pattern I
>     was targetting.

This looks fine.  Thanks for the proposal.

julia

>
>  scripts/coccinelle/iterators/use_after_iter.cocci | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/scripts/coccinelle/iterators/use_after_iter.cocci b/scripts/coccinelle/iterators/use_after_iter.cocci
> index 9be48b520879..676edd562eef 100644
> --- a/scripts/coccinelle/iterators/use_after_iter.cocci
> +++ b/scripts/coccinelle/iterators/use_after_iter.cocci
> @@ -123,6 +123,8 @@ hlist_for_each_entry_safe(c,...) S
>  |
>  list_remove_head(x,c,...)
>  |
> +list_entry_is_head(c,...)
> +|
>  sizeof(<+...c...+>)
>  |
>   &c->member
>
> base-commit: 2734d6c1b1a089fb593ef6a23d4b70903526fe0c
> --
> 2.30.2
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
