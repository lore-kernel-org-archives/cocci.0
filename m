Return-Path: <SRS0=jkZ/=X4=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C72C32792
	for <cocci@archiver.kernel.org>; Thu,  3 Oct 2019 12:23:15 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F77B20830
	for <cocci@archiver.kernel.org>; Thu,  3 Oct 2019 12:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F77B20830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x93CN1e0019097;
	Thu, 3 Oct 2019 14:23:01 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 25E2777B4;
	Thu,  3 Oct 2019 14:23:01 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 35C5477A9
 for <cocci@systeme.lip6.fr>; Thu,  3 Oct 2019 14:23:00 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x93CMxnq007445
 for <cocci@systeme.lip6.fr>; Thu, 3 Oct 2019 14:22:59 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.67,252,1566856800"; d="scan'208";a="404566184"
Received: from portablejulia.rsr.lip6.fr ([132.227.76.63])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 03 Oct 2019 14:22:58 +0200
Date: Thu, 3 Oct 2019 14:22:58 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: julia@hadrien
To: Masahiro Yamada <yamada.masahiro@socionext.com>
In-Reply-To: <CAK7LNATAqM9QHRqotFQsmh64rww_AxNm4gdV2t5TuYxHA++zSg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1910031422240.2406@hadrien>
References: <20190928094245.45696-1-yuehaibing@huawei.com>
 <alpine.DEB.2.21.1909280542490.2168@hadrien>
 <2c109d6b-45ad-b3ca-1951-bde4dac91d2a@huawei.com>
 <alpine.DEB.2.21.1909291810300.3346@hadrien>
 <ac79cb42-1713-8801-37e4-edde540f101c@huawei.com>
 <alpine.DEB.2.21.1910011500470.13162@hadrien>
 <CAK7LNATAqM9QHRqotFQsmh64rww_AxNm4gdV2t5TuYxHA++zSg@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 03 Oct 2019 14:23:01 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Thu, 03 Oct 2019 14:22:59 +0200 (CEST)
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



On Thu, 3 Oct 2019, Masahiro Yamada wrote:

> On Tue, Oct 1, 2019 at 10:01 PM Julia Lawall <julia.lawall@lip6.fr> wrote:
> > > diff --git a/scripts/coccinelle/misc/add_namespace.cocci b/scripts/coccinelle/misc/add_namespace.cocci
> > > index c832bb6445a8..99e93a6c2e24 100644
> > > --- a/scripts/coccinelle/misc/add_namespace.cocci
> > > +++ b/scripts/coccinelle/misc/add_namespace.cocci
> > > @@ -6,6 +6,8 @@
> > >  /// add a missing namespace tag to a module source file.
> > >  ///
> > >
> > > +virtual report
> > > +
> > >  @has_ns_import@
> > >  declarer name MODULE_IMPORT_NS;
> > >  identifier virtual.ns;
> > >
> > >
> > >
> > > Adding virtual report make the coccicheck go ahead smoothly.
> >
> > Acked-by: Julia Lawall <julia.lawall@lip6.fr>
> >
>
>
> Was this patch posted somewhere?

It was probably waiting for moderation in the cocci mailing list.  Do you
have it now (or in a few minutes)?

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
