Return-Path: <SRS0=k1+2=YW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07197CA9EC4
	for <cocci@archiver.kernel.org>; Tue, 29 Oct 2019 08:56:12 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 609402086A
	for <cocci@archiver.kernel.org>; Tue, 29 Oct 2019 08:56:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 609402086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9T8tqcQ010906;
	Tue, 29 Oct 2019 09:55:52 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id CD40F77D3;
	Tue, 29 Oct 2019 09:55:50 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 03431454C
 for <cocci@systeme.lip6.fr>; Tue, 29 Oct 2019 09:55:05 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9T8t4sU025552
 for <cocci@systeme.lip6.fr>; Tue, 29 Oct 2019 09:55:04 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.68,243,1569276000"; d="scan'208";a="409212435"
Received: from unknown (HELO hadrien) ([91.217.168.176])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Oct 2019 09:55:03 +0100
Date: Tue, 29 Oct 2019 09:55:02 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: julia@hadrien
To: Masahiro Yamada <yamada.masahiro@socionext.com>
In-Reply-To: <CAK7LNATkXYNMbquhn=SV=Hj1kqbPke8x4_a7aZYhceRAam8MHQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1910290953060.2183@hadrien>
References: <e895d04ef5a282b5b48fcb21cbc175d2@www.loen.fr>
 <693a3b68-a0f1-81fe-40ce-2b6ba189450c@web.de> <868spgzcti.wl-maz@kernel.org>
 <c8816d85b696cb96318e17b7010b84f09bc67bf7.camel@perches.com>
 <CAK7LNAQqSThGRM_wRGR2ou3B+Oqpr0nF9Fg4rhSR4Hvnxwnj3g@mail.gmail.com>
 <20191025080843.GG32742@smile.fi.intel.com>
 <alpine.DEB.2.21.1910251028260.2787@hadrien>
 <CAK7LNATkXYNMbquhn=SV=Hj1kqbPke8x4_a7aZYhceRAam8MHQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 29 Oct 2019 09:55:52 +0100 (CET)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Tue, 29 Oct 2019 09:55:04 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Tue, 29 Oct 2019 09:55:48 +0100
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



On Tue, 29 Oct 2019, Masahiro Yamada wrote:

> Hi Julia
>
> On Fri, Oct 25, 2019 at 5:38 PM Julia Lawall <julia.lawall@lip6.fr> wrote:
> >
> >
> >
> > On Fri, 25 Oct 2019, Andy Shevchenko wrote:
> >
> > > On Fri, Oct 25, 2019 at 12:40:52AM +0900, Masahiro Yamada wrote:
> > > > On Sun, Oct 20, 2019 at 7:13 AM Joe Perches <joe@perches.com> wrote:
> > > > > On Sat, 2019-10-19 at 21:43 +0100, Marc Zyngier wrote:
> > >
> > > > Alexandre Belloni used
> > > > https://lore.kernel.org/lkml/9bbcce19c777583815c92ce3c2ff2586@www.loen.fr/
> > > > as a reference, but this is not the output from coccicheck.
> > > > The patch author just created a wrong patch by hand.
> > >
> > > Exactly. Removal of the script is a mistake. Like I said before is a healing
> > > (incorrect by the way!) by symptoms.
> > >
> > > > The deleted semantic patch supports MODE=patch,
> > > > which creates a correct patch, and is useful.
> > >
> > > Right!
> >
> > I ran it on the version of Linux that still has the script:
> >
> > fe7d2c23d748e4206f4bef9330d0dff9abed7411
> >
> > and managed to compile 341 of the generated files in the time I had
> > available, and all compiled successfully.
>
> Yeah, this semantic patch did the correct conversion
> as its header part showed the confidence.
>
> // Confidence: High
>
>
>
> >  I can let it run again, and see
> > how it goes for the rest.  Perhaps it would be acceptable if there was no
> > report, and people would be forced to use the generated patch?
>
> I do not think this is the right thing.
> MODE=report is the default, and it is fine.
>
> >
> > If someone is writing lots of patches on this issue by hand, then perhaps
> > they don't have make coccicheck to produce patches, and then would
> > overlook this case completely.
> >
> > If it would be helpful, I could group the generated patches by maintainer
> > or by subdirectory and send them out, if it would be easier to review them
> > all at once.
>
> Yes, please.
>
> Subsystem maintainers trust you,
> so I think it will make things move smoothly.
>
> After converting most of files,
> I want 283ea345934d277e30c841c577e0e2142b4bfcae reverted.

OK.  I got 477 of the files to compile directly.  I can send patches on
them, and then look into the issues on the remaining ones (probably
configuration issues).

julia

>
>
> >
> > Anyway, the rule is not in the kernel at the moment.  For it's future, I'm
> > open to whatever people find best.  Personally, I prefer when same things
> > are done in the same way - it makes the code easier to understand and
> > makes it simpler to address other issues when they arise.
>
>
> We always did the same things in the same way
> except commit 283ea345934d277e30c841c577e0e2142b4bfcae
>
>
>
>
> --
> Best Regards
> Masahiro Yamada
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
