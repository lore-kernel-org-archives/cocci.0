Return-Path: <SRS0=lElT=X5=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4FDC10F14
	for <cocci@archiver.kernel.org>; Fri,  4 Oct 2019 02:34:03 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D01DC20862
	for <cocci@archiver.kernel.org>; Fri,  4 Oct 2019 02:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="VdYXhZrc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D01DC20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x942Xm1x020186;
	Fri, 4 Oct 2019 04:33:48 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1460377AB;
	Fri,  4 Oct 2019 04:33:48 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5629677A7
 for <cocci@systeme.lip6.fr>; Fri,  4 Oct 2019 04:33:46 +0200 (CEST)
Received: from shiva.jussieu.fr (shiva.jussieu.fr [134.157.0.129])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x942XjVW023321
 for <cocci@systeme.lip6.fr>; Fri, 4 Oct 2019 04:33:45 +0200 (CEST)
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com
 [210.131.2.90])
 by shiva.jussieu.fr (8.15.2/jtpda-5.4) with ESMTP id x942XIgb052784
 for <cocci@systeme.lip6.fr>; Fri, 4 Oct 2019 04:33:44 +0200 (CEST)
X-Ids: 164
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com
 [209.85.217.53]) (authenticated)
 by conssluserg-05.nifty.com with ESMTP id x942Whuf022490
 for <cocci@systeme.lip6.fr>; Fri, 4 Oct 2019 11:32:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x942Whuf022490
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1570156363;
 bh=7YN++JqV7jyOcxkopUQJqoctW6E3dcZKj7/HVqXQvuw=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=VdYXhZrcqJtrPI/G0jK+Re7Lymhlu2McrcbMp9VM5Ff3Mv9Z/SXheONw5MnH2zCKH
 gMNUaTlGKIcHjgiYKB35c/Zal1mQbzlNcxjfKl9TKrSwD5NlmFrsTAueaBXBgxWZsm
 kscgxgSGbSZGlxT8BCLbiNj0MgEqnTqqdctpuzQXhwd9sFB+/0bUXTBn10AGSqA7xa
 O9XdpkkZzvIf+7Qe5HXQUeKPmQ1TJZtrQhTly4WTS81LFnccy2N1oXV65LTlz8NmWd
 LtPgo3dh0mm3j+SoEinzd50WRW0C/TgbRifnrF+YXcErTTe0pVDlgpsI0M4vKm+4Xr
 duwxLN3yrEJrA==
X-Nifty-SrcIP: [209.85.217.53]
Received: by mail-vs1-f53.google.com with SMTP id l2so3127801vsr.8
 for <cocci@systeme.lip6.fr>; Thu, 03 Oct 2019 19:32:43 -0700 (PDT)
X-Gm-Message-State: APjAAAX43PTe9kaR0FbQEHmHDPX+dLINY24e8RvQBdPaFqRtP+VGijMt
 wKc4XESC9Hm+YjznV+0Dv7fjKyfJq94b8riSoj4=
X-Google-Smtp-Source: APXvYqxCHsOHAoD11ZZo+llQqdvKhHrk5Nz6ASOFGNVH1oFClIKa5Ad3vrezVer68OIOVqzlzLQ/CwUbHiOfz5xghKQ=
X-Received: by 2002:a67:88c9:: with SMTP id k192mr6718255vsd.181.1570156362283; 
 Thu, 03 Oct 2019 19:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190928094245.45696-1-yuehaibing@huawei.com>
 <alpine.DEB.2.21.1909280542490.2168@hadrien>
 <2c109d6b-45ad-b3ca-1951-bde4dac91d2a@huawei.com>
 <alpine.DEB.2.21.1909291810300.3346@hadrien>
 <ac79cb42-1713-8801-37e4-edde540f101c@huawei.com>
 <alpine.DEB.2.21.1910011500470.13162@hadrien>
 <CAK7LNATAqM9QHRqotFQsmh64rww_AxNm4gdV2t5TuYxHA++zSg@mail.gmail.com>
 <alpine.DEB.2.21.1910031422240.2406@hadrien>
In-Reply-To: <alpine.DEB.2.21.1910031422240.2406@hadrien>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 4 Oct 2019 11:32:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS2K6i+s2A_xTyRq730M6_=tyjtfwHAnEHF37_nrJa4Eg@mail.gmail.com>
Message-ID: <CAK7LNAS2K6i+s2A_xTyRq730M6_=tyjtfwHAnEHF37_nrJa4Eg@mail.gmail.com>
To: Julia Lawall <julia.lawall@lip6.fr>
X-Miltered: at jchkmail2.reseau.jussieu.fr with ID 5D96AF6E.000 by Joe's
 j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-j-chkmail-Enveloppe: 5D96AF6E.000 from
 conssluserg-05.nifty.com/conssluserg-05.nifty.com/210.131.2.90/conssluserg-05.nifty.com/<yamada.masahiro@socionext.com>
X-Scores-Stats: 5D96AF6E.000 B=0.50000 L=0.23410 G=0.23410 Disagree Winner=PH
X-Label-Query: YES
X-j-chkmail-Score: MSGID : 5D96AF6E.000 on shiva.jussieu.fr : j-chkmail score
 : X : R=. U=. O=. B=0.234 -> S=0.234
X-j-chkmail-Status: Ham
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 04 Oct 2019 04:33:48 +0200 (CEST)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 04 Oct 2019 04:33:45 +0200 (CEST)
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

On Thu, Oct 3, 2019 at 9:23 PM Julia Lawall <julia.lawall@lip6.fr> wrote:
>
>
>
> On Thu, 3 Oct 2019, Masahiro Yamada wrote:
>
> > On Tue, Oct 1, 2019 at 10:01 PM Julia Lawall <julia.lawall@lip6.fr> wrote:
> > > > diff --git a/scripts/coccinelle/misc/add_namespace.cocci b/scripts/coccinelle/misc/add_namespace.cocci
> > > > index c832bb6445a8..99e93a6c2e24 100644
> > > > --- a/scripts/coccinelle/misc/add_namespace.cocci
> > > > +++ b/scripts/coccinelle/misc/add_namespace.cocci
> > > > @@ -6,6 +6,8 @@
> > > >  /// add a missing namespace tag to a module source file.
> > > >  ///
> > > >
> > > > +virtual report
> > > > +
> > > >  @has_ns_import@
> > > >  declarer name MODULE_IMPORT_NS;
> > > >  identifier virtual.ns;
> > > >
> > > >
> > > >
> > > > Adding virtual report make the coccicheck go ahead smoothly.
> > >
> > > Acked-by: Julia Lawall <julia.lawall@lip6.fr>
> > >
> >
> >
> > Was this patch posted somewhere?
>
> It was probably waiting for moderation in the cocci mailing list.  Do you
> have it now (or in a few minutes)?

No. I do not see it yet.

I want to pick the patch from LKML Patchwork
https://lore.kernel.org/patchwork/project/lkml/list/

You gave Acked-by to the one-liner fix "virtual report",
and I am happy to apply it to my tree.

YueHaibing, could you submit it as a patch?


-- 
Best Regards
Masahiro Yamada
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
