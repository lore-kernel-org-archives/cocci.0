Return-Path: <SRS0=EO5m=PO=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4B2C43387
	for <cocci@archiver.kernel.org>; Sun,  6 Jan 2019 02:19:34 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB18C2229F
	for <cocci@archiver.kernel.org>; Sun,  6 Jan 2019 02:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="bIR5BWhn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB18C2229F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x062JFCL000055
          ; Sun, 6 Jan 2019 03:19:15 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id EF2A476E0;
	Sun,  6 Jan 2019 03:19:14 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0BEE16251
 for <cocci@systeme.lip6.fr>; Sun,  6 Jan 2019 03:19:13 +0100 (CET)
Received: from condef-02.nifty.com (condef-02.nifty.com [202.248.20.67])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x062JBrL026993
 for <cocci@systeme.lip6.fr>; Sun, 6 Jan 2019 03:19:11 +0100 (CET)
X-pt: isis.lip6.fr
Received: from conssluserg-06.nifty.com ([10.126.8.85])by condef-02.nifty.com
 with ESMTP id x061h9s4027568
 for <cocci@systeme.lip6.fr>; Sun, 6 Jan 2019 10:43:10 +0900
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com
 [209.85.221.174]) (authenticated)
 by conssluserg-06.nifty.com with ESMTP id x061ftsw010573
 for <cocci@systeme.lip6.fr>; Sun, 6 Jan 2019 10:41:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x061ftsw010573
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1546738916;
 bh=xFudEcZwUcMHAVkTucvrEEMuZDp9b36sey9gk7TgVrk=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=bIR5BWhnrlpKxud+OqwcJ/h3RsTbrI2UKRVosLCvdwVSBbPtG28ijWb8ufoYpod6G
 6QOGDzYTei2fnljRLS1r4AW9S3pG6MI3rasyW2/vBUmSCbqrCFL2WAX2EpWO5vL8GU
 VH4JE7xnufLh+/iPBFfTOqA1YcWg4YRSkTeyt5TmoyujqawW1+n6OFG5UrlSL85KEb
 f1ltBH0Ps4/EQxv00f4hK0J4bAJDd8CO8XS/sUyaS+GRXiBUbHnUB6FNKl76VN9U71
 99uC5hW7F5Cl5L3nsyLtyuOJemVUIPw5ki7ZrBBIyM5yBUgxlFo10dccsKC9j5GFRz
 ML/Q4u0iWzCEg==
X-Nifty-SrcIP: [209.85.221.174]
Received: by mail-vk1-f174.google.com with SMTP id n126so8709527vke.12
 for <cocci@systeme.lip6.fr>; Sat, 05 Jan 2019 17:41:55 -0800 (PST)
X-Gm-Message-State: AJcUukdSKeCdOzlK9nUxq9p7/RGIltqCB1/52rIYcMKkeB1NFTrJ4XkI
 okIM9cdlKL6EUkVGOXGAZ1YmI9Fde/yYrKseNoE=
X-Google-Smtp-Source: ALg8bN79JUFfnyfEJZQbgPMj1g95RZ/VwMrq8W6vkTuGQSoNETATuNDqTCnpCJk3a4TVnZDO8zTqpMD+eYXkmiJDTQ4=
X-Received: by 2002:a1f:9350:: with SMTP id v77mr19667050vkd.64.1546738914555; 
 Sat, 05 Jan 2019 17:41:54 -0800 (PST)
MIME-Version: 1.0
References: <1546064056-15569-1-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1546064056-15569-1-git-send-email-Julia.Lawall@lip6.fr>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sun, 6 Jan 2019 10:41:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNARH8-96wcZhMmgZCzxQCMQpQPaqmDHVSYbGkHnHhjQtCw@mail.gmail.com>
Message-ID: <CAK7LNARH8-96wcZhMmgZCzxQCMQpQPaqmDHVSYbGkHnHhjQtCw@mail.gmail.com>
To: Julia Lawall <Julia.Lawall@lip6.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 06 Jan 2019 03:19:15 +0100 (CET)
X-Greylist: Delayed for 00:23:05 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Sun, 06 Jan 2019 03:19:12 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>, kernel-janitors@vger.kernel.org,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] scripts: coccinelle: boolinit: drop warnings on
	named constants
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

On Sat, Dec 29, 2018 at 10:14 PM Julia Lawall <Julia.Lawall@lip6.fr> wrote:
>
> Coccinelle doesn't always have access to the values of named
> (#define) constants, and they may likely often be bound to true
> and false values anyway, resulting in false positives.  So stop
> warning about them.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Applied to linux-kbuild. Thanks!


> ---
>  scripts/coccinelle/misc/boolinit.cocci |    5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/scripts/coccinelle/misc/boolinit.cocci b/scripts/coccinelle/misc/boolinit.cocci
> index b0584a3..aabb581 100644
> --- a/scripts/coccinelle/misc/boolinit.cocci
> +++ b/scripts/coccinelle/misc/boolinit.cocci
> @@ -136,9 +136,14 @@ position p1;
>  @r4 depends on !patch@
>  bool b;
>  position p2;
> +identifier i;
>  constant c != {0,1};
>  @@
> +(
> + b = i
> +|
>  *b@p2 = c
> +)
>
>  @script:python depends on org@
>  p << r1.p;
>


-- 
Best Regards
Masahiro Yamada
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
