Return-Path: <SRS0=JAIf=VD=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359EEC0650E
	for <cocci@archiver.kernel.org>; Sat,  6 Jul 2019 13:18:34 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74BEE20843
	for <cocci@archiver.kernel.org>; Sat,  6 Jul 2019 13:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="MyY4GQM5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74BEE20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x66DIHqJ002368;
	Sat, 6 Jul 2019 15:18:17 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 24D87777B;
	Sat,  6 Jul 2019 15:18:17 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id EFC5D777A
 for <cocci@systeme.lip6.fr>; Sat,  6 Jul 2019 15:18:14 +0200 (CEST)
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com
 [210.131.2.81])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x66DIDrN016371
 for <cocci@systeme.lip6.fr>; Sat, 6 Jul 2019 15:18:13 +0200 (CEST)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com
 [209.85.222.49]) (authenticated)
 by conssluserg-02.nifty.com with ESMTP id x66DHt8H011689
 for <cocci@systeme.lip6.fr>; Sat, 6 Jul 2019 22:17:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x66DHt8H011689
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1562419076;
 bh=lkt34pKxsLaqteqRnzNAHUoXLSqpNK8tuJBHhve1u6k=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=MyY4GQM5U+waAw/qOsyaOyYkcwODHnlxFShswOqRKR0z44ld3On+auS3zxi2CDTQB
 GUdCEHZLU/ca6BSMogpLYFGVQlaAByl0rzLRbukxeVo8LbLYU5vniKeodIexx8VrNo
 RbHUzb1M550rQgYegVaHtiG6zLBqEA4lrkbFNg00Y1Kr80uJmxMk47DEdo7GH3xT3e
 yDz/wQQoqPK8v86pD5QGB+H/gWexV/ErNw6DJH8Uvl+99EhteWvKrXnajCWiGJz32w
 u4p+tc/B5i9Mruzdeoq1khaTT0BPdoFwlDrU8OX7q+C7TBWst5wqGahxmGK/Y60vvf
 qJZGWpvgGQ12g==
X-Nifty-SrcIP: [209.85.222.49]
Received: by mail-ua1-f49.google.com with SMTP id v18so3178873uad.12
 for <cocci@systeme.lip6.fr>; Sat, 06 Jul 2019 06:17:55 -0700 (PDT)
X-Gm-Message-State: APjAAAXefwX05A9StLqo5qFvAIt58M6S4ye67DkeHjdXIP/A7V/5EzTG
 SroPSiILTAqGjM3NwxGZdfWlTpG7AjxjoKC+HY8=
X-Google-Smtp-Source: APXvYqzQZ4eOtd5x95ZKMUQ/9lCpzBAvI2GlNaD5CsdRO8+OU8zEPPF96/7ZpZ/ZQ5xa0EdEP2X7DRb9nRyg5wps5io=
X-Received: by 2002:ab0:70d9:: with SMTP id r25mr4487674ual.109.1562419074733; 
 Sat, 06 Jul 2019 06:17:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190623072838.31234-1-kirr@nexedi.com>
In-Reply-To: <20190623072838.31234-1-kirr@nexedi.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sat, 6 Jul 2019 22:17:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT2tt+pCX54=L9qN9pzZ+rCOQ5-9p-o1jMLa3GD9jhG8A@mail.gmail.com>
Message-ID: <CAK7LNAT2tt+pCX54=L9qN9pzZ+rCOQ5-9p-o1jMLa3GD9jhG8A@mail.gmail.com>
To: Kirill Smelkov <kirr@nexedi.com>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 06 Jul 2019 15:18:17 +0200 (CEST)
X-Greylist: Delayed for 00:58:40 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Sat, 06 Jul 2019 15:18:14 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Logan Gunthorpe <logang@deltatee.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Bjorn Helgaas <helgaas@kernel.org>, cocci@systeme.lip6.fr,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Cocci] [PATCH 1/2] coccinelle: api/stream_open: treat all
 wait_.*() calls as blocking
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

On Sun, Jun 23, 2019 at 4:29 PM Kirill Smelkov <kirr@nexedi.com> wrote:
>
> Previously steam_open.cocci was treating only wait_event_.* - e.g.
> wait_event_interruptible - as a blocking operation. However e.g.
> wait_for_completion_interruptible is also blocking, and so from this
> point of view it would be more logical to treat all wait_.* as a
> blocking point.
>
> The logic of this change actually came up for real when
> drivers/pci/switch/switchtec.c changed from using
> wait_event_interruptible to wait_for_completion_interruptible:
>
>         https://lore.kernel.org/linux-pci/20190413170056.GA11293@deco.navytux.spb.ru/
>         https://lore.kernel.org/linux-pci/20190415145456.GA15280@deco.navytux.spb.ru/
>         https://lore.kernel.org/linux-pci/20190415154102.GB17661@deco.navytux.spb.ru/
>
> For a driver that uses nonseekable_open with read/write having stream
> semantic and read also calling e.g. wait_for_completion_interruptible,
> running stream_open.cocci before this patch would produce:
>
>         WARNING: <driver>_fops: .read() and .write() have stream semantic; safe to change nonseekable_open -> stream_open.
>
> while after this patch it will report:
>
>         ERROR: <driver>_fops: .read() can deadlock .write(); change nonseekable_open -> stream_open to fix.
>
> Cc: Julia Lawall <Julia.Lawall@lip6.fr>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
> ---

Applied to linux-kbuild. Thanks.

>  scripts/coccinelle/api/stream_open.cocci | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/coccinelle/api/stream_open.cocci b/scripts/coccinelle/api/stream_open.cocci
> index 350145da7669..12ce18fa6b74 100644
> --- a/scripts/coccinelle/api/stream_open.cocci
> +++ b/scripts/coccinelle/api/stream_open.cocci
> @@ -35,11 +35,11 @@ type loff_t;
>  // a function that blocks
>  @ blocks @
>  identifier block_f;
> -identifier wait_event =~ "^wait_event_.*";
> +identifier wait =~ "^wait_.*";
>  @@
>    block_f(...) {
>      ... when exists
> -    wait_event(...)
> +    wait(...)
>      ... when exists
>    }
>
> @@ -49,12 +49,12 @@ identifier wait_event =~ "^wait_event_.*";
>  // XXX currently reader_blocks supports only direct and 1-level indirect cases.
>  @ reader_blocks_direct @
>  identifier stream_reader.readstream;
> -identifier wait_event =~ "^wait_event_.*";
> +identifier wait =~ "^wait_.*";
>  @@
>    readstream(...)
>    {
>      ... when exists
> -    wait_event(...)
> +    wait(...)
>      ... when exists
>    }
>
> --
> 2.20.1
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
