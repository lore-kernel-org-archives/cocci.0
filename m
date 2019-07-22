Return-Path: <SRS0=YvFH=VT=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC633C76188
	for <cocci@archiver.kernel.org>; Mon, 22 Jul 2019 05:04:39 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 010CD21BF6
	for <cocci@archiver.kernel.org>; Mon, 22 Jul 2019 05:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rwyp8BGw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 010CD21BF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6M54Kca023379;
	Mon, 22 Jul 2019 07:04:20 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 801B276BF;
	Mon, 22 Jul 2019 07:04:20 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 735CC420D
 for <cocci@systeme.lip6.fr>; Mon, 22 Jul 2019 07:04:18 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:22e] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6M54H9i024505
 for <cocci@systeme.lip6.fr>; Mon, 22 Jul 2019 07:04:17 +0200 (CEST)
Received: by mail-oi1-x22e.google.com with SMTP id t76so28676943oih.4
 for <cocci@systeme.lip6.fr>; Sun, 21 Jul 2019 22:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GiQ9WxCM1Qg2UYq45W+Q1mDjbI1M01f7FDfTkHzxcbQ=;
 b=rwyp8BGwHZhjnwHwzfh8S3f4YGDiOfixqX41Gd60ljcXvtLLKWCFSdaQCFMI0Ye+rH
 lfuWyR0HRV2sN0oGH6R1ewRlBDL9ktIlSRhz+uea28O9WKnoA1IUKzZEWYP7ItJaGC6v
 Cy5B8mIYYnZ98/MCXhtJrE3N9eCbxWV7r1uH7B6s8Zl99KbTrD2gd/D2haYmbcNwqLVA
 TcwDgFQV6baSk1oBBBV7eBuNIybn7b/Y5TLr/qqiJL2a+rutgm7RRcvVauOdydwn2cRf
 TMBQZUvds+lZWZx3pd0whPN4dwx8ualMk1Hdp/Ingm4/NIKkCxEzXKtpbYwLh/F2Y7Kn
 GBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GiQ9WxCM1Qg2UYq45W+Q1mDjbI1M01f7FDfTkHzxcbQ=;
 b=JeruiNRaqgIQvFItLNBUWfQ9brVdwQgrT6tNief2AQZQI81iBFiCWRZYGjoyQTUjKr
 WjBPjnT3769wpTuGM7mgWavgrNM8QfEeWKkqIpGcVCU9Hmbv0QXzBXzCLR27SY6uOKvz
 dYsw7MZ2mJ9jxcjHleOoMXL5G7nses2O5AvXMXd2JjFkO0ktLORgNqMYzc4YvcjyhGkA
 zawOT1+BiMYrekIiOjT+njHW4jVXyOqffS5QnLfZrM+DMW/NhraDNnIOoLi87BrGMKqa
 urKmDcZr9EbIlyHQBI1Lbwy4zk8cpNidOjoEOsrk10mSUdl/Vcy39HdZAf+SV4WdrVLE
 iyNw==
X-Gm-Message-State: APjAAAUKzYMeBuUf5nI9GbOJ+um81bJPvcfCf4TDeLw+3jH/gcHuXsRe
 eLbPmwI1c5TAZqbDszbgrAB/JTH4G6MT4oMKBwY=
X-Google-Smtp-Source: APXvYqxJTpqjmNkulZADMBq7w5jfKCGNucj7hPDg67RHz06DliEYyi+rQ9re/5U2yh2aMUX6H8GM964bqx0rzxtYZcc=
X-Received: by 2002:aca:f084:: with SMTP id o126mr30225148oih.37.1563771857080; 
 Sun, 21 Jul 2019 22:04:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAEgVsn4+aMn_3pXo1fex6_3oWmHbQERhmr42dO0igdFT1u67nA@mail.gmail.com>
In-Reply-To: <CAEgVsn4+aMn_3pXo1fex6_3oWmHbQERhmr42dO0igdFT1u67nA@mail.gmail.com>
From: ron minnich <rminnich@gmail.com>
Date: Sun, 21 Jul 2019 22:04:06 -0700
Message-ID: <CAP6exYLjntc0iPNOHdWSSUMw-ay3n4dFBAFfW=6Y1SOvmXT-Gg@mail.gmail.com>
To: Raghavan Raman <ragr@uber.com>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 22 Jul 2019 07:04:21 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 22 Jul 2019 07:04:18 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Coccinelle for Go
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

Given the existence of the go AST package, which is used in so many
ways to rewrite Go code (gofmt and go imports to name just two), I'm
not sure I see the
need for coccinelle. This is not in any way a criticism of coccinelle,
I use it all the time for C. But I also write tools that
use the Go AST package to rewrite Go, and have never felt the lack of
coccinelle for Go. I'm curious what you see as the use case.

ron

On Sat, Jul 20, 2019 at 2:55 AM Raghavan Raman <ragr@uber.com> wrote:
>
> Hi,
>
> I am part of the Programming Systems group at Uber. We are looking into using Coccinelle for refactoring in Go.
>
> Does Coccinelle include support for Go?
>
> If not:
>   * Is there any plan to add support for the same?
>   * What would it take to add this support? Any documentation regarding this?
>
> Thanks,
> Raghavan
>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
