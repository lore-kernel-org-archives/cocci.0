Return-Path: <SRS0=bkjO=YR=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360F3CA9EBE
	for <cocci@archiver.kernel.org>; Thu, 24 Oct 2019 18:59:04 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10DB421925
	for <cocci@archiver.kernel.org>; Thu, 24 Oct 2019 18:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="J7JzzEq9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10DB421925
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9OIwjb8009348;
	Thu, 24 Oct 2019 20:58:45 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B589A77C7;
	Thu, 24 Oct 2019 20:58:45 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0FE3E77BB
 for <cocci@systeme.lip6.fr>; Thu, 24 Oct 2019 18:09:46 +0200 (CEST)
Received: from condef-08.nifty.com (condef-08.nifty.com [202.248.20.73])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9OG9iHv029617
 for <cocci@systeme.lip6.fr>; Thu, 24 Oct 2019 18:09:45 +0200 (CEST)
Received: from conssluserg-02.nifty.com ([10.126.8.81])by condef-08.nifty.com
 with ESMTP id x9OFh1fB001858
 for <cocci@systeme.lip6.fr>; Fri, 25 Oct 2019 00:43:02 +0900
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com
 [209.85.221.175]) (authenticated)
 by conssluserg-02.nifty.com with ESMTP id x9OFfT8a027873
 for <cocci@systeme.lip6.fr>; Fri, 25 Oct 2019 00:41:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x9OFfT8a027873
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1571931690;
 bh=l4I3j33otfIQZSfw7zL4nNKREYId00X6FYw//AMabaE=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=J7JzzEq9jjLw/A4o0vktjGoZM/o7nOPyZ8FJ0n8aolcVy3rE56fx7QD8thRLNPdul
 mnDh+esLCS0XIygkfjxyVUEmrfI67Ks/JVCIIjjR9J9dhTRAAIdAWj7a0m5mWJ255Y
 W76ZVDt21NQ5YpFO9usnpk7YY/YERETFjeDQ8DWSpGQbROFdWil1E1vKtBCrh+JLQU
 E4GkkVdSdsoaCkWHzMWamdBpvGD2t65EVEaeiJdH+oRM/Zf7rgSUAgE9ZzpniLbdn3
 Aby5i/iYIdpGmZEbLsmF0l5JBAGizqtLGrTlzsgvNSsWaOatg/Kmb0a24xTyXnDE1a
 Cox9VvptnGKUg==
X-Nifty-SrcIP: [209.85.221.175]
Received: by mail-vk1-f175.google.com with SMTP id r85so1803670vke.3
 for <cocci@systeme.lip6.fr>; Thu, 24 Oct 2019 08:41:30 -0700 (PDT)
X-Gm-Message-State: APjAAAUTHmfG5YdPs0n9i/NaRyO3EfyifLxpNp3r2MT65xgSrqz84dWc
 rpbov0VJqjkf/0NVPFm/UFvoWgY2Hn6BMyrCKfQ=
X-Google-Smtp-Source: APXvYqzECnMU+WoRoqmpGp2qCaUvuGA+5Jc8kg37Z+KgqZpCHvCQICZwcWI/5OzGByPm5gI//L5m5unfHNDIvbYQnaM=
X-Received: by 2002:a1f:a349:: with SMTP id m70mr9104948vke.26.1571931688982; 
 Thu, 24 Oct 2019 08:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <e895d04ef5a282b5b48fcb21cbc175d2@www.loen.fr>
 <693a3b68-a0f1-81fe-40ce-2b6ba189450c@web.de>
 <868spgzcti.wl-maz@kernel.org>
 <c8816d85b696cb96318e17b7010b84f09bc67bf7.camel@perches.com>
In-Reply-To: <c8816d85b696cb96318e17b7010b84f09bc67bf7.camel@perches.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 25 Oct 2019 00:40:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQqSThGRM_wRGR2ou3B+Oqpr0nF9Fg4rhSR4Hvnxwnj3g@mail.gmail.com>
Message-ID: <CAK7LNAQqSThGRM_wRGR2ou3B+Oqpr0nF9Fg4rhSR4Hvnxwnj3g@mail.gmail.com>
To: Joe Perches <joe@perches.com>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 24 Oct 2019 20:58:46 +0200 (CEST)
X-Greylist: Delayed for 00:17:35 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Thu, 24 Oct 2019 18:09:45 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Thu, 24 Oct 2019 20:58:44 +0200
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Michal Marek <michal.lkml@markovi.net>,
        YueHaibing <yuehaibing@huawei.com>, Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Markus Elfring <Markus.Elfring@web.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] coccinelle: api/devm_platform_ioremap_resource: remove
	useless script
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

On Sun, Oct 20, 2019 at 7:13 AM Joe Perches <joe@perches.com> wrote:
>
> On Sat, 2019-10-19 at 21:43 +0100, Marc Zyngier wrote:
> > Providing Coccinelle scripts that scream about perfectly valid code is
> > pointless, and the result is actively harmful.
>
> Doubtful.
>
> If the new code is smaller object code and correct
> than the conversion is worthwhile.

I agree.

We use multi-platform defconfig.
I always appreciate the code refactoring
that reduces the object size.



> fyi:
>
> There are already ~450 uses of this function and maybe
> ~800 possible additional conversions.
>
> > If said script was providing a correct semantic patch instead of being
> > an incentive for people to churn untested patches that span the whole
> > tree, that'd be a different story.
>
> Right.
>
>


Alexandre Belloni used
https://lore.kernel.org/lkml/9bbcce19c777583815c92ce3c2ff2586@www.loen.fr/
as a reference, but this is not the output from coccicheck.
The patch author just created a wrong patch by hand.

The deleted semantic patch supports MODE=patch,
which creates a correct patch, and is useful.


-- 
Best Regards
Masahiro Yamada
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
