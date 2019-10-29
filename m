Return-Path: <SRS0=k1+2=YW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D98CA9EC3
	for <cocci@archiver.kernel.org>; Tue, 29 Oct 2019 08:56:12 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6097120873
	for <cocci@archiver.kernel.org>; Tue, 29 Oct 2019 08:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="CGuSk+Rr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6097120873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9T8to3w006706;
	Tue, 29 Oct 2019 09:55:50 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 509E677BA;
	Tue, 29 Oct 2019 09:55:50 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7DD3D454C
 for <cocci@systeme.lip6.fr>; Tue, 29 Oct 2019 04:12:40 +0100 (CET)
Received: from condef-06.nifty.com (condef-06.nifty.com [202.248.20.71])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9T3Ccji000880
 for <cocci@systeme.lip6.fr>; Tue, 29 Oct 2019 04:12:39 +0100 (CET)
Received: from conssluserg-01.nifty.com ([10.126.8.80])by condef-06.nifty.com
 with ESMTP id x9T31HZc013968
 for <cocci@systeme.lip6.fr>; Tue, 29 Oct 2019 12:01:17 +0900
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com
 [209.85.222.53]) (authenticated)
 by conssluserg-01.nifty.com with ESMTP id x9T2xT3B020758
 for <cocci@systeme.lip6.fr>; Tue, 29 Oct 2019 11:59:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x9T2xT3B020758
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1572317970;
 bh=KpON6jENOa78faqVFtQXeF/x8eRnLcnMvYpsLe7gtRw=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=CGuSk+RrGXsd6J11mq5ZrwjADHBaJZvsVn59C82fYYpR482hK2PyTRr81P3Kx7lUk
 UhJtVotXaOdjmzKK553POUJVvKly/FeFCFk+AoPDRM/hOLVEnzXe72QLrVrB4J8PTg
 YMxq21bXABz1tdXgNfVO4edowruo4yW2z0Oszld0MdolcE9ibT6vKR1ZKGLO445xw1
 7aW5GZMpMe2lyg0GtzmMadtdpJkQpudIAseGGjaJgzLGdTlshpKMLBSYrNEoC90V8d
 7lqPBFEmYLFFxdGU1bmUhQqfQ/DtY9VeZ0Kobq6nlng0hc4H7LwvezeL54tfE17KZH
 1GsgPOSFw0Pdg==
X-Nifty-SrcIP: [209.85.222.53]
Received: by mail-ua1-f53.google.com with SMTP id q16so3381235uao.1
 for <cocci@systeme.lip6.fr>; Mon, 28 Oct 2019 19:59:29 -0700 (PDT)
X-Gm-Message-State: APjAAAVXMY/iUUd1/s4BkmkwbvS0gZbwFDGqy62RPrzoo4UG3bJJzej6
 KCDmMNFUJyoZMjlYreDKTtVu2RfQbYDeHq+N/Wc=
X-Google-Smtp-Source: APXvYqwlJlglJ2Tv5HFU5kMK6Futpi8Woza9I04Q0G6tTL+3kQyGTP068uTVZlTQ4bTSvxrQbrx/KcHFxtxvU5bkaNk=
X-Received: by 2002:ab0:658d:: with SMTP id v13mr3781878uam.40.1572317968542; 
 Mon, 28 Oct 2019 19:59:28 -0700 (PDT)
MIME-Version: 1.0
References: <e895d04ef5a282b5b48fcb21cbc175d2@www.loen.fr>
 <693a3b68-a0f1-81fe-40ce-2b6ba189450c@web.de>
 <868spgzcti.wl-maz@kernel.org>
 <c8816d85b696cb96318e17b7010b84f09bc67bf7.camel@perches.com>
 <CAK7LNAQqSThGRM_wRGR2ou3B+Oqpr0nF9Fg4rhSR4Hvnxwnj3g@mail.gmail.com>
 <20191025080843.GG32742@smile.fi.intel.com>
 <alpine.DEB.2.21.1910251028260.2787@hadrien>
In-Reply-To: <alpine.DEB.2.21.1910251028260.2787@hadrien>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 29 Oct 2019 11:58:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNATkXYNMbquhn=SV=Hj1kqbPke8x4_a7aZYhceRAam8MHQ@mail.gmail.com>
Message-ID: <CAK7LNATkXYNMbquhn=SV=Hj1kqbPke8x4_a7aZYhceRAam8MHQ@mail.gmail.com>
To: Julia Lawall <julia.lawall@lip6.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 29 Oct 2019 09:55:50 +0100 (CET)
X-Greylist: Delayed for 00:07:19 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Tue, 29 Oct 2019 04:12:39 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Tue, 29 Oct 2019 09:55:48 +0100
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Michal Marek <michal.lkml@markovi.net>,
        YueHaibing <yuehaibing@huawei.com>, Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Markus Elfring <Markus.Elfring@web.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>, Thomas Gleixner <tglx@linutronix.de>,
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

Hi Julia

On Fri, Oct 25, 2019 at 5:38 PM Julia Lawall <julia.lawall@lip6.fr> wrote:
>
>
>
> On Fri, 25 Oct 2019, Andy Shevchenko wrote:
>
> > On Fri, Oct 25, 2019 at 12:40:52AM +0900, Masahiro Yamada wrote:
> > > On Sun, Oct 20, 2019 at 7:13 AM Joe Perches <joe@perches.com> wrote:
> > > > On Sat, 2019-10-19 at 21:43 +0100, Marc Zyngier wrote:
> >
> > > Alexandre Belloni used
> > > https://lore.kernel.org/lkml/9bbcce19c777583815c92ce3c2ff2586@www.loen.fr/
> > > as a reference, but this is not the output from coccicheck.
> > > The patch author just created a wrong patch by hand.
> >
> > Exactly. Removal of the script is a mistake. Like I said before is a healing
> > (incorrect by the way!) by symptoms.
> >
> > > The deleted semantic patch supports MODE=patch,
> > > which creates a correct patch, and is useful.
> >
> > Right!
>
> I ran it on the version of Linux that still has the script:
>
> fe7d2c23d748e4206f4bef9330d0dff9abed7411
>
> and managed to compile 341 of the generated files in the time I had
> available, and all compiled successfully.

Yeah, this semantic patch did the correct conversion
as its header part showed the confidence.

// Confidence: High



>  I can let it run again, and see
> how it goes for the rest.  Perhaps it would be acceptable if there was no
> report, and people would be forced to use the generated patch?

I do not think this is the right thing.
MODE=report is the default, and it is fine.

>
> If someone is writing lots of patches on this issue by hand, then perhaps
> they don't have make coccicheck to produce patches, and then would
> overlook this case completely.
>
> If it would be helpful, I could group the generated patches by maintainer
> or by subdirectory and send them out, if it would be easier to review them
> all at once.

Yes, please.

Subsystem maintainers trust you,
so I think it will make things move smoothly.

After converting most of files,
I want 283ea345934d277e30c841c577e0e2142b4bfcae reverted.


>
> Anyway, the rule is not in the kernel at the moment.  For it's future, I'm
> open to whatever people find best.  Personally, I prefer when same things
> are done in the same way - it makes the code easier to understand and
> makes it simpler to address other issues when they arise.


We always did the same things in the same way
except commit 283ea345934d277e30c841c577e0e2142b4bfcae




-- 
Best Regards
Masahiro Yamada
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
