Return-Path: <SRS0=VTVD=WE=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280FFC0650F
	for <cocci@archiver.kernel.org>; Thu,  8 Aug 2019 08:04:06 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93430218B8
	for <cocci@archiver.kernel.org>; Thu,  8 Aug 2019 08:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dehlSFC+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93430218B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7883hMd025797;
	Thu, 8 Aug 2019 10:03:43 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1E9E07787;
	Thu,  8 Aug 2019 10:03:43 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3D6417781
 for <cocci@systeme.lip6.fr>; Wed, 31 Jul 2019 17:01:31 +0200 (CEST)
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:a43] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6VF1UnV014274
 for <cocci@systeme.lip6.fr>; Wed, 31 Jul 2019 17:01:30 +0200 (CEST)
Received: by mail-vk1-xa43.google.com with SMTP id y130so13719527vkc.0
 for <cocci@systeme.lip6.fr>; Wed, 31 Jul 2019 08:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=message-id:mime-version:content-transfer-encoding:in-reply-to
 :references:cc:from:to:subject:user-agent:date;
 bh=+/qoGVl+L8+8r/LaPr/8YaHHYTkLEsuwwMR94e7XMnc=;
 b=dehlSFC+8ixLpBQZj/OSHzPFmNLuT+cEmypAz8kqyJWUEHq9j41URTM6XYpsRIAauW
 zm3wzV/VrEouwauN0UqBPNd/VCXVgHYJ+R66S/VB54L+K3jJSM7Xn9HOoW6Htu+iiT+F
 fnkz8Mb1jtTD/OWugr0oH2Tt+gIUU4Ux2V+hY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:mime-version
 :content-transfer-encoding:in-reply-to:references:cc:from:to:subject
 :user-agent:date;
 bh=+/qoGVl+L8+8r/LaPr/8YaHHYTkLEsuwwMR94e7XMnc=;
 b=RXiq8Z/cYJUe3RtUYNjTiT2gOz+sCfSiV1Gy1++nDFGYKTYU0NzSsjRfaoVT/J3Tvv
 LDGe5OYsEvqyYOw8lqLU+OYC6grmrvApP2MSdl1yOj2EjAxgrMT75fFvDtGLHuF3VzXb
 r61P32yBr2LOKjLYl0CNXyaoXMBR1AIKJgzgfMpV9hOMWjnvgdtj+Cr8qySyhfRJVDLv
 oLlZ9w6Mwx0SOBJ4Kn1p4Rg+/sLA53HIqQjuwbNuPehgh+XQyI44lK+mIkDoWPg/Izi0
 2YInmZfdg24svUaDRdNrz+EwI+O9K8qFA9/WoF7+0I6591N+a7Q+11oG4sdXtMqDK0lQ
 AJMw==
X-Gm-Message-State: APjAAAUf/ZJ5mVMu3rIrS553unQ1DXoruN/gyqR+Whkam9uL2Gcv6YhP
 Q+4or/2D2yb6nikV9DQLL3qBg5sywn4uNA==
X-Google-Smtp-Source: APXvYqzCsh7/ZcPFRY6pZ2tJDtKM4I8pTwsiBWYKyBAO2azCW8VnYZIap/SQLPxETfTfJlIqon26aw==
X-Received: by 2002:a63:c013:: with SMTP id h19mr84283959pgg.108.1564584749553; 
 Wed, 31 Jul 2019 07:52:29 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
 by smtp.gmail.com with ESMTPSA id b14sm2948137pga.20.2019.07.31.07.52.28
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 07:52:28 -0700 (PDT)
Message-ID: <5d41ab2c.1c69fb81.6129.661f@mx.google.com>
MIME-Version: 1.0
In-Reply-To: <20190731142645.GA1680@kunai>
References: <20190730053845.126834-1-swboyd@chromium.org>
 <20190731142645.GA1680@kunai>
From: Stephen Boyd <swboyd@chromium.org>
To: Wolfram Sang <wsa@the-dreams.de>
User-Agent: alot/0.8.1
Date: Wed, 31 Jul 2019 07:52:27 -0700
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 08 Aug 2019 10:03:43 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 31 Jul 2019 17:01:30 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Thu, 08 Aug 2019 10:03:41 +0200
Cc: Rob Herring <robh@kernel.org>, Michal Marek <michal.lkml@markovi.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        cocci@systeme.lip6.fr, Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [Cocci] [PATCH v5 0/3] Add error message to platform_get_irq*()
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

Quoting Wolfram Sang (2019-07-31 07:26:46)
> Hi Stephen,
> 
> > There were some comments about adding an 'optional' platform_get_irq()
> > API in v4. This series doesn't include that, but I can add such an API
> > if it's required. I started to look into how it might work and got hung
> > up on what an optional IRQ means. I suppose it means that in DT there
> > isn't an 'interrupts' property in the device node, but in ACPI based
> > firmware I'm not sure what that would correspond to. Furthermore, the
> > return value is hard to comprehend. Do we return an error when an
> > optional irq can't be found? It doesn't seem safe to return 0 because
> > sometimes 0 is a valid IRQ. Do other errors in parsing the IRQ
> > constitute a failure when the IRQ is optional?
> 
> Some time ago, I tried a series like yours and got stuck at this very
> point. I found drivers where using an interrupt was optional and
> platform_get_irq() returning a failure wasn't fatal. The drivers used
> PIO then or dropped some additional functionality. Some of them were
> very old.
> 
> I didn't like the idea that platform_get_irq() will spit out errors for
> those drivers, yet I couldn't create a suitable cocci-script to convert
> drivers to use the *_optional callback where possible. So, I neither
> created the optional callback.
> 
> I still have doubts of unneeded error messages popping up. Has this been
> discussed already? (Sorry, I missed the first iterations of this series)

Not heavily discussed, but it was mentioned in an earlier round. If
these drivers pop up, I think we can have another function like
platform_get_irq_probe() or platform_get_irq_nowarn() that doesn't print
an error message. Then we can convert the drivers that are poking around
for interrupts to use this new function instead. It isn't the same as a
platform_get_optional_irq() API because it returns an error when the irq
isn't there or we fail to parse something, but at least the error
message is gone.

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
