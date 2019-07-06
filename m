Return-Path: <SRS0=JAIf=VD=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F6CC0650E
	for <cocci@archiver.kernel.org>; Sat,  6 Jul 2019 12:29:06 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8D20213F2
	for <cocci@archiver.kernel.org>; Sat,  6 Jul 2019 12:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="z1qZbRql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8D20213F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x66CSpu6026247;
	Sat, 6 Jul 2019 14:28:51 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 139B5777B;
	Sat,  6 Jul 2019 14:28:51 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id DD8B4777A
 for <cocci@systeme.lip6.fr>; Sat,  6 Jul 2019 14:28:48 +0200 (CEST)
Received: from condef-03.nifty.com (condef-03.nifty.com [202.248.20.68])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x66CSkOe006472
 for <cocci@systeme.lip6.fr>; Sat, 6 Jul 2019 14:28:47 +0200 (CEST)
Received: from conssluserg-06.nifty.com ([10.126.8.85])by condef-03.nifty.com
 with ESMTP id x66CHxlj003569
 for <cocci@systeme.lip6.fr>; Sat, 6 Jul 2019 21:17:59 +0900
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com
 [209.85.217.44]) (authenticated)
 by conssluserg-06.nifty.com with ESMTP id x66CGeM0011512
 for <cocci@systeme.lip6.fr>; Sat, 6 Jul 2019 21:16:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x66CGeM0011512
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1562415401;
 bh=FfB1NqG/gE92yWOnQ6/KTKMCyYbR4uXXTkbKQtydcMY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=z1qZbRqlSOwyuHHKhQBoYCFvqKKDWmvl1D/q9ZoGTvDTc9KQbA7s2fNaiuaOrWELp
 tyXp0ubtEfPmXO106o48+YO8FKkmOeO1rCjEgGklBWeEjuoc9xcZzknaaSPs8O9nyF
 KhM+FPiZnVB0rzSMFVBC2Uy6cJGYR4B1/LeTXMm2Rhrf9w/M5TH6YylgJHRzwQ+agf
 224PGH/+TOod4n5PVDi265irVfi41Mh+iSdQ2UdjhZH3RWZNyZNFGa4LYLgkGfgWOM
 RD+OUaaF2kUM7k4OBsUKkvZ96u1Z2LrYASV9YQ45pnCtDHwXjTTVDCdTShkOMLVZyc
 gfUlhkDqodoQw==
X-Nifty-SrcIP: [209.85.217.44]
Received: by mail-vs1-f44.google.com with SMTP id u124so5369437vsu.2
 for <cocci@systeme.lip6.fr>; Sat, 06 Jul 2019 05:16:40 -0700 (PDT)
X-Gm-Message-State: APjAAAV4Eqycm50g50b7GQkroQloZaagN4O7c+NttudlTjGQev1aWxUN
 Vae4q4/7pluULeWNoRoG7JhrT7A6qqiyCfwMBBU=
X-Google-Smtp-Source: APXvYqygMpGz0NVEVvFeGd+Pele9Hueqk0n/t5IwyE+OhHb7yi3tGYRZBW3SzE6pLj+Hqa4UtocBm+uPgajacg0+6AY=
X-Received: by 2002:a67:cd1a:: with SMTP id u26mr4689375vsl.155.1562415399561; 
 Sat, 06 Jul 2019 05:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190406061112.31620-1-himanshujha199640@gmail.com>
 <alpine.DEB.2.21.1904060831120.4486@hadrien>
 <alpine.DEB.2.21.1904060833160.4486@hadrien>
In-Reply-To: <alpine.DEB.2.21.1904060833160.4486@hadrien>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sat, 6 Jul 2019 21:16:03 +0900
X-Gmail-Original-Message-ID: <CAK7LNARTJpxRmQzx+vQGfOC5YFuw8QsRQ=_9=9E=g5p62UUf6g@mail.gmail.com>
Message-ID: <CAK7LNARTJpxRmQzx+vQGfOC5YFuw8QsRQ=_9=9E=g5p62UUf6g@mail.gmail.com>
To: Julia Lawall <julia.lawall@lip6.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 06 Jul 2019 14:28:51 +0200 (CEST)
X-Greylist: Delayed for 00:08:01 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Sat, 06 Jul 2019 14:28:48 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: kernel-janitors@vger.kernel.org, Michal Marek <michal.lkml@markovi.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] coccinelle: api: add
 devm_platform_ioremap_resource script
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

On Sat, Apr 6, 2019 at 3:34 PM Julia Lawall <julia.lawall@lip6.fr> wrote:
>
>
>
> On Sat, 6 Apr 2019, Julia Lawall wrote:
>
> >
> >
> > On Sat, 6 Apr 2019, Himanshu Jha wrote:
> >
> > > Use recently introduced devm_platform_ioremap_resource
> > > helper which wraps platform_get_resource() and
> > > devm_ioremap_resource() together. This helps produce much
> > > cleaner code while removing local `struct resource` declaration.
> > >
> > > Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
> >
> > Acked-by: Julia Lawall <julia.lawall@lip6.fr>
> >
> > Thanks for taking up this issue.
>
> Maybe this should be
>
> Signed-off-by: Julia Lawall <julia.lawall@lip6.fr>
>
> since I contributed two lines to the script :)

I will apply with Julia's Signed-off-by instead of Acked-by.
I will also add SPDX tag.

Is this OK?



> julia
>
> >
> > julia
> >
> > > ---
> > >
> > > Tree wide changes has been tested through 0-day test service
> > > with build success.
> > >
> > > BUILD SUCCESS 74ebaaca5d14d3d9b03e911f0b4995b78a4d60f0
> > > tree/branch: https://github.com/himanshujha199640/linux-next  20190401-devm_platform_ioremap_resource-final
> > > branch HEAD: 74ebaaca5d14d3d9b03e911f0b4995b78a4d60f0  Coccinelle: api: Add devm_platform_ioremap_resource.cocci
> > >
> > > elapsed time: 385m
> > > configs tested: 162
> > >
> > >
> > > Stats:
> > > 916 files changed, 1028 insertions(+), 2921 deletions(-)
> > >
> > > Note: cases where the `struct resource *res` variable is
> > > used subsequently in the function have been ignored out because
> > > those cases produce:
> > >
> > > eg., drivers/bus/da8xx-mstpri.c
> > >
> > > warning: 'res' may be used uninitialized in this function [-Wmaybe-uninitialized]
> > >
> > > due to:
> > >     if (prio_descr->reg + sizeof(u32) > resource_size(res)) {
> > >
> > > which seems correct as `res` isn't initialized in the scope of
> > > the function(da8xx_mstpri_probe) and instead initialized inside:
> > >
> > >    void __iomem *devm_platform_ioremap_resource(struct platform_device *pdev,
> > >                                                 unsigned int index)
> > >    {
> > >            struct resource *res;
> > >
> > >            res = platform_get_resource(pdev, IORESOURCE_MEM, index);
> > >            return devm_ioremap_resource(&pdev->dev, res);
> > >    }
> > >    EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource);
> > >
> > >
> > >  .../api/devm_platform_ioremap_resource.cocci  | 63 +++++++++++++++++++
> > >  1 file changed, 63 insertions(+)
> > >  create mode 100644 scripts/coccinelle/api/devm_platform_ioremap_resource.cocci
> > >
> > > diff --git a/scripts/coccinelle/api/devm_platform_ioremap_resource.cocci b/scripts/coccinelle/api/devm_platform_ioremap_resource.cocci
> > > new file mode 100644
> > > index 000000000000..a28274af14df
> > > --- /dev/null
> > > +++ b/scripts/coccinelle/api/devm_platform_ioremap_resource.cocci
> > > @@ -0,0 +1,63 @@
> > > +/// Use devm_platform_ioremap_resource helper which wraps
> > > +/// platform_get_resource() and devm_ioremap_resource() together.
> > > +///
> > > +// Confidence: High
> > > +// Copyright: (C) 2019 Himanshu Jha GPLv2.
> > > +// Copyright: (C) 2019 Julia Lawall, Inria/LIP6. GPLv2.
> > > +// Keywords: platform_get_resource, devm_ioremap_resource,
> > > +// Keywords: devm_platform_ioremap_resource
> > > +
> > > +virtual patch
> > > +virtual report
> > > +
> > > +@r depends on patch && !report@
> > > +expression e1, e2, arg1, arg2, arg3, arg4;
> > > +identifier id;
> > > +@@
> > > +
> > > +(
> > > +- id = platform_get_resource(arg1, arg2, arg3);
> > > +|
> > > +- struct resource *id = platform_get_resource(arg1, arg2, arg3);
> > > +)
> > > +  ... when != id
> > > +- e1 = devm_ioremap_resource(arg4, id);
> > > ++ e1 = devm_platform_ioremap_resource(arg1, arg3);
> > > +  ... when != id
> > > +? id = e2
> > > +
> > > +@r1 depends on patch && !report@
> > > +identifier r.id;
> > > +type T;
> > > +@@
> > > +
> > > +- T *id;
> > > +  ...when != id
> > > +
> > > +// ----------------------------------------------------------------------------
> > > +
> > > +@r2 depends on report && !patch@
> > > +identifier id;
> > > +expression e1, e2, arg1, arg2, arg3, arg4;
> > > +position j0;
> > > +@@
> > > +
> > > +(
> > > +  id = platform_get_resource(arg1, arg2, arg3);
> > > +|
> > > +  struct resource *id = platform_get_resource(arg1, arg2, arg3);
> > > +)
> > > +  ... when != id
> > > +  e1@j0 = devm_ioremap_resource(arg4, id);
> > > +  ... when != id
> > > +? id = e2
> > > +
> > > +// ----------------------------------------------------------------------------
> > > +
> > > +@script:python depends on report && !patch@
> > > +e1 << r2.e1;
> > > +j0 << r2.j0;
> > > +@@
> > > +
> > > +msg = "WARNING: Use devm_platform_ioremap_resource for %s" % (e1)
> > > +coccilib.report.print_report(j0[0], msg)
> > > --
> > > 2.17.1
> > >
> > >
> >
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
