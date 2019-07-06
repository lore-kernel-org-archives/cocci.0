Return-Path: <SRS0=JAIf=VD=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50FCC0650E
	for <cocci@archiver.kernel.org>; Sat,  6 Jul 2019 13:14:38 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C16C20843
	for <cocci@archiver.kernel.org>; Sat,  6 Jul 2019 13:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="n0OGt9lY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C16C20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x66DEKv7024721;
	Sat, 6 Jul 2019 15:14:20 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E446B777B;
	Sat,  6 Jul 2019 15:14:19 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 39BDE777A
 for <cocci@systeme.lip6.fr>; Sat,  6 Jul 2019 15:14:18 +0200 (CEST)
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com
 [210.131.2.91])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x66DEGMA002093
 for <cocci@systeme.lip6.fr>; Sat, 6 Jul 2019 15:14:17 +0200 (CEST)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com
 [209.85.222.46]) (authenticated)
 by conssluserg-06.nifty.com with ESMTP id x66DE1pr002764
 for <cocci@systeme.lip6.fr>; Sat, 6 Jul 2019 22:14:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x66DE1pr002764
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1562418842;
 bh=yR96820x8dCsUN7jsyb8LhZwwDE7H4JmOUSfV5/t9ow=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=n0OGt9lYpUV3X8BVIBRNfCVFkAbpM8YUX6etjGciXbbg58GpQlVo48ed8yh/e6LOw
 4XqaFs4Kancu2+A3eWAoSim/EnGZWAF4kGsGzbbMUd1q9VTOdXS6nquq4u0BFLfPit
 eS+JYR6h1An/lBqh6PUFd5bUAf3PPnVN4pPQK3kk7K3HXkAT5ktz4LrNi7GAxQ+oab
 e2aOn1wP3LvmWpWH0+4HnHB92TJl+nqRiahhIYPMoQokotxNhaNccaezg3fp5gM0IC
 Kmnh5exBPfmxex5/ktMCWk5PWIPpNrx+DG7prpd1OS4Pd0uxyLMPqHj1MUa3c1tV6p
 yqtl8/cuWBHLA==
X-Nifty-SrcIP: [209.85.222.46]
Received: by mail-ua1-f46.google.com with SMTP id j2so3180232uaq.5
 for <cocci@systeme.lip6.fr>; Sat, 06 Jul 2019 06:14:01 -0700 (PDT)
X-Gm-Message-State: APjAAAXiVXeWjPwChWA48rpbysE8ISMmtoeEkgEnTao+5R0PTp97ONbo
 PUAe22ZyZdPS9CaUjRwbOZxFqd6nVIDTW6d7B0I=
X-Google-Smtp-Source: APXvYqzJ89qUy8ATJQiEXDG2nXMrBJeh3RIwp0lned5asyXvyR9wOUeOo4ghtOWnxd9GXq6uo9GMfDtI5G9j6t8OLew=
X-Received: by 2002:a9f:25e9:: with SMTP id 96mr4960816uaf.95.1562418840867;
 Sat, 06 Jul 2019 06:14:00 -0700 (PDT)
MIME-Version: 1.0
References: <1553321671-27749-1-git-send-email-wen.yang99@zte.com.cn>
 <e34d47fe-3aac-5b01-055d-61d97cf50fe7@web.de>
 <07e17d87-09ff-311f-015c-d201df053f56@web.de>
In-Reply-To: <07e17d87-09ff-311f-015c-d201df053f56@web.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sat, 6 Jul 2019 22:13:25 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ=oVfmHWYSp2hsKTGGAkrY7faDfNYCfx88k7fTdnoKLQ@mail.gmail.com>
Message-ID: <CAK7LNAQ=oVfmHWYSp2hsKTGGAkrY7faDfNYCfx88k7fTdnoKLQ@mail.gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 06 Jul 2019 15:14:20 +0200 (CEST)
X-Greylist: Delayed for 00:57:11 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Sat, 06 Jul 2019 15:14:17 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Yi Wang <wang.yi59@zte.com.cn>, Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        cocci@systeme.lip6.fr, Wen Yang <wen.yang99@zte.com.cn>
Subject: Re: [Cocci] [PATCH 2/5] Coccinelle: put_device: Add a cast to an
 expression for an assignment
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

On Mon, May 13, 2019 at 6:02 PM Markus Elfring <Markus.Elfring@web.de> wrote:
>
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 8 May 2019 13:50:49 +0200
>
> Extend a when constraint in a SmPL rule so that an additional cast
> is optionally excluded from source code searches for an expression
> in assignments.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> Suggested-by: Julia Lawall <Julia.Lawall@lip6.fr>
> Link: https://lore.kernel.org/lkml/alpine.DEB.2.21.1902160934400.3212@hadrien/
> Link: https://systeme.lip6.fr/pipermail/cocci/2019-February/005592.html
> ---

Applied to linux-kbuild.

>  scripts/coccinelle/free/put_device.cocci | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/coccinelle/free/put_device.cocci b/scripts/coccinelle/free/put_device.cocci
> index 3ebebc064f10..120921366e84 100644
> --- a/scripts/coccinelle/free/put_device.cocci
> +++ b/scripts/coccinelle/free/put_device.cocci
> @@ -24,7 +24,7 @@ if (id == NULL || ...) { ... return ...; }
>      when != of_dev_put(id)
>      when != if (id) { ... put_device(&id->dev) ... }
>      when != e1 = (T)id
> -    when != e1 = &id->dev
> +    when != e1 = (T)(&id->dev)
>      when != e1 = get_device(&id->dev)
>      when != e1 = (T1)platform_get_drvdata(id)
>  (
> --
> 2.21.0
>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci



-- 
Best Regards
Masahiro Yamada
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
