Return-Path: <SRS0=jkZ/=X4=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E92BC10F14
	for <cocci@archiver.kernel.org>; Thu,  3 Oct 2019 12:15:31 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4756A20700
	for <cocci@archiver.kernel.org>; Thu,  3 Oct 2019 12:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="jxSl5GBY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4756A20700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x93CFDe4021100;
	Thu, 3 Oct 2019 14:15:13 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 26DD077B4;
	Thu,  3 Oct 2019 14:15:13 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1001777A9
 for <cocci@systeme.lip6.fr>; Thu,  3 Oct 2019 14:15:10 +0200 (CEST)
Received: from condef-10.nifty.com (condef-10.nifty.com [202.248.20.75])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x93CF7WS016398
 for <cocci@systeme.lip6.fr>; Thu, 3 Oct 2019 14:15:08 +0200 (CEST)
Received: from conssluserg-01.nifty.com ([10.126.8.80])by condef-10.nifty.com
 with ESMTP id x93Bxi7G018685
 for <cocci@systeme.lip6.fr>; Thu, 3 Oct 2019 20:59:44 +0900
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com
 [209.85.221.182]) (authenticated)
 by conssluserg-01.nifty.com with ESMTP id x93BwLVA030942
 for <cocci@systeme.lip6.fr>; Thu, 3 Oct 2019 20:58:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x93BwLVA030942
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1570103902;
 bh=zCd51wQccV5gCP/s+G8hMogXPErk6qWPCtDB4gKUwAg=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=jxSl5GBYZ47LoeuI94u7/1pbamdvKCjWyxwIPVR7GQDRLs1SwBT51qQOYHt4DeCWJ
 ci4+Gvecenow8EXNQ4ZhG6rbMB0hsD2GcogNnkl3FAzeN0jG7iNVTvssEjI3oBJQKm
 lqeoq476TsoWYldR0irpAm0inuNMqJxtD9GvwcEvAlJAphYk8xAvOpde0H7F16ZKBZ
 OvXQRqFaNoQ3/vuJ7hflU+vuyeIj385S9xurGq2FKy1hHQtPa94mM7XOD1pMcLos2t
 YCrIlsmWwZMtbGt0aEN6B7DCTl2vf4eQ0F+GDDBEmufK13jkqfF/sPErKHn8XlJCwD
 qmqJ36Jw9ehCg==
X-Nifty-SrcIP: [209.85.221.182]
Received: by mail-vk1-f182.google.com with SMTP id j21so539636vki.11
 for <cocci@systeme.lip6.fr>; Thu, 03 Oct 2019 04:58:22 -0700 (PDT)
X-Gm-Message-State: APjAAAWsdr8hpgMakm5K7b/0d3w/wghzDdVFjp8VXfu067U6QPlSpj4N
 dhS+5F8drUrZC91HOxsM/ZkN+7PNyX9vNvvQD5E=
X-Google-Smtp-Source: APXvYqzZHz8CSCVCVlLQNQD0edqz1ZrjTUCeWnebM1P72kAuAJyMwfOJJKqkQ8DvnM8O25hZbWzEXqQJs7TrE0eVaGE=
X-Received: by 2002:a1f:2343:: with SMTP id j64mr4670136vkj.84.1570103901321; 
 Thu, 03 Oct 2019 04:58:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190928094245.45696-1-yuehaibing@huawei.com>
 <alpine.DEB.2.21.1909280542490.2168@hadrien>
 <2c109d6b-45ad-b3ca-1951-bde4dac91d2a@huawei.com>
 <alpine.DEB.2.21.1909291810300.3346@hadrien>
 <ac79cb42-1713-8801-37e4-edde540f101c@huawei.com>
 <alpine.DEB.2.21.1910011500470.13162@hadrien>
In-Reply-To: <alpine.DEB.2.21.1910011500470.13162@hadrien>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 3 Oct 2019 20:57:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNATAqM9QHRqotFQsmh64rww_AxNm4gdV2t5TuYxHA++zSg@mail.gmail.com>
Message-ID: <CAK7LNATAqM9QHRqotFQsmh64rww_AxNm4gdV2t5TuYxHA++zSg@mail.gmail.com>
To: Julia Lawall <julia.lawall@lip6.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 03 Oct 2019 14:15:14 +0200 (CEST)
X-Greylist: Delayed for 00:08:20 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Thu, 03 Oct 2019 14:15:08 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>, Yuehaibing <yuehaibing@huawei.com>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Matthias Maennich <maennich@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] [RFC PATCH] scripts: Fix coccicheck failed
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

On Tue, Oct 1, 2019 at 10:01 PM Julia Lawall <julia.lawall@lip6.fr> wrote:
> > diff --git a/scripts/coccinelle/misc/add_namespace.cocci b/scripts/coccinelle/misc/add_namespace.cocci
> > index c832bb6445a8..99e93a6c2e24 100644
> > --- a/scripts/coccinelle/misc/add_namespace.cocci
> > +++ b/scripts/coccinelle/misc/add_namespace.cocci
> > @@ -6,6 +6,8 @@
> >  /// add a missing namespace tag to a module source file.
> >  ///
> >
> > +virtual report
> > +
> >  @has_ns_import@
> >  declarer name MODULE_IMPORT_NS;
> >  identifier virtual.ns;
> >
> >
> >
> > Adding virtual report make the coccicheck go ahead smoothly.
>
> Acked-by: Julia Lawall <julia.lawall@lip6.fr>
>


Was this patch posted somewhere?



-- 
Best Regards
Masahiro Yamada
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
