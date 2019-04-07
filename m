Return-Path: <SRS0=K+oe=SJ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455CAC10F0E
	for <cocci@archiver.kernel.org>; Sun,  7 Apr 2019 20:06:03 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3F1F20879
	for <cocci@archiver.kernel.org>; Sun,  7 Apr 2019 20:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F1F20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x37K5oR2012377
          ; Sun, 7 Apr 2019 22:05:51 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D15E27704;
	Sun,  7 Apr 2019 22:05:50 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A85477631
 for <cocci@systeme.lip6.fr>; Sun,  7 Apr 2019 22:05:48 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x37K5mcD022059
 for <cocci@systeme.lip6.fr>; Sun, 7 Apr 2019 22:05:48 +0200 (CEST)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.60,322,1549926000"; d="scan'208";a="377570993"
Received: from abo-75-106-68.mrs.modulonet.fr (HELO hadrien) ([85.68.106.75])
 by mail2-relais-roc.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Apr 2019 22:05:47 +0200
Date: Sun, 7 Apr 2019 22:05:47 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <769208bc-8298-314a-4ec4-0a2cb61ae1ae@roeck-us.net>
Message-ID: <alpine.DEB.2.21.1904072205310.18180@hadrien>
References: <4a22aba7-4983-3f17-a51e-7ad6d4f3eac2@roeck-us.net>
 <alpine.DEB.2.21.1904072108260.18180@hadrien>
 <769208bc-8298-314a-4ec4-0a2cb61ae1ae@roeck-us.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 07 Apr 2019 22:05:51 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Sun, 07 Apr 2019 22:05:48 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] ormatting problems when introducing a function with
 coccinelle
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



On Sun, 7 Apr 2019, Guenter Roeck wrote:

> Hi Julia,
>
> On 4/7/19 12:09 PM, Julia Lawall wrote:
> >
> >
> > On Sun, 7 Apr 2019, Guenter Roeck wrote:
> >
> > > Hi Coccinelle experts,
> > >
> > > I am trying to introduce a new function with coccinelle.
> > >
> > > The semantic patch is something like
> > >
> > > @devm depends on prb@
> > > identifier r.initfn;
> > > identifier fname.clkfunc;
> > > @@
> > > + static void clkfunc(void *data) { clk_disable_unprepare(data); }
> > >    initfn(...) { ... }
> >
> > You can do:
> >
> > + static void clkfunc(void *data)
> > +{ clk_disable_unprepare(data); }
> >    initfn(...) { ... }
> >
> > and then use the command line argument --smpl-spacing.
> >
>
> That kind of works,
>
> +static void armada_clk_disable_unprepare(void *data)
> +{
> +       clk_disable_unprepare(data);
> +}
> +
>  static int armada_37xx_wdt_probe(struct platform_device *pdev)
>
> but it doesn't line wrap the calling code.
>
> +       ret = devm_add_action_or_reset(&pdev->dev,
> armada_clk_disable_unprepare, dev->clk);
> +       if (ret)
> +               return ret;
>
> This isn't really much better.
>
> I tried --max-width, but it looks like that doesn't work with --smpl-spacing.

Did you try the new version?

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
