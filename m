Return-Path: <SRS0=P+10=X2=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670BBC352AA
	for <cocci@archiver.kernel.org>; Tue,  1 Oct 2019 13:01:23 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1C4B205C9
	for <cocci@archiver.kernel.org>; Tue,  1 Oct 2019 13:01:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1C4B205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x91D19Dw010299;
	Tue, 1 Oct 2019 15:01:09 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4D19B77B2;
	Tue,  1 Oct 2019 15:01:09 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0F4B577A7
 for <cocci@systeme.lip6.fr>; Tue,  1 Oct 2019 15:01:08 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x91D17dV001370
 for <cocci@systeme.lip6.fr>; Tue, 1 Oct 2019 15:01:07 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.64,571,1559512800"; d="scan'208";a="404191967"
Received: from portablejulia.rsr.lip6.fr ([132.227.76.63])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 01 Oct 2019 15:01:06 +0200
Date: Tue, 1 Oct 2019 15:01:06 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: julia@hadrien
To: Yuehaibing <yuehaibing@huawei.com>
In-Reply-To: <ac79cb42-1713-8801-37e4-edde540f101c@huawei.com>
Message-ID: <alpine.DEB.2.21.1910011500470.13162@hadrien>
References: <20190928094245.45696-1-yuehaibing@huawei.com>
 <alpine.DEB.2.21.1909280542490.2168@hadrien>
 <2c109d6b-45ad-b3ca-1951-bde4dac91d2a@huawei.com>
 <alpine.DEB.2.21.1909291810300.3346@hadrien>
 <ac79cb42-1713-8801-37e4-edde540f101c@huawei.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 01 Oct 2019 15:01:09 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Tue, 01 Oct 2019 15:01:07 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: michal.lkml@markovi.net, nicolas.palix@imag.fr, maennich@google.com,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        cocci@systeme.lip6.fr
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



On Mon, 30 Sep 2019, Yuehaibing wrote:

> On 2019/9/30 0:32, Julia Lawall wrote:
> >
> >
> > On Sun, 29 Sep 2019, Yuehaibing wrote:
> >
> >> On 2019/9/28 20:43, Julia Lawall wrote:
> >>>
> >>>
> >>> On Sat, 28 Sep 2019, YueHaibing wrote:
> >>>
> >>>> Run make coccicheck, I got this:
> >>>>
> >>>> spatch -D patch --no-show-diff --very-quiet --cocci-file
> >>>>  ./scripts/coccinelle/misc/add_namespace.cocci --dir .
> >>>>  -I ./arch/x86/include -I ./arch/x86/include/generated
> >>>>  -I ./include -I ./arch/x86/include/uapi
> >>>>  -I ./arch/x86/include/generated/uapi -I ./include/uapi
> >>>>  -I ./include/generated/uapi --include ./include/linux/kconfig.h
> >>>>  --jobs 192 --chunksize 1
> >>>>
> >>>> virtual rule patch not supported
> >>>> coccicheck failed
> >>>>
> >>>> It seems add_namespace.cocci cannot be called in coccicheck.
> >>>
> >>> Could you explain the issue better?  Does the current state cause make
> >>> coccicheck to fail?  Or is it just silently not being called?
> >>
> >> Yes, it cause make coccicheck failed like this:
> >>
> >> ...
> >> ./drivers/xen/xenbus/xenbus_comms.c:290:2-8: preceding lock on line 243
> >> ./fs/fuse/dev.c:1227:2-8: preceding lock on line 1206
> >> ./fs/fuse/dev.c:1232:3-9: preceding lock on line 1206
> >> coccicheck failed
> >> make[1]: *** [coccicheck] Error 255
> >> make: *** [sub-make] Error 2
> >
> > Could you set the verbose options to see what the problem is?  Maybe the
> > problem would be solved by putting virtual report at the top of the rule.
> > But it might still fail because nothing can happen without a value for the
> > virtual metavariable ns.
>
> diff --git a/scripts/coccinelle/misc/add_namespace.cocci b/scripts/coccinelle/misc/add_namespace.cocci
> index c832bb6445a8..99e93a6c2e24 100644
> --- a/scripts/coccinelle/misc/add_namespace.cocci
> +++ b/scripts/coccinelle/misc/add_namespace.cocci
> @@ -6,6 +6,8 @@
>  /// add a missing namespace tag to a module source file.
>  ///
>
> +virtual report
> +
>  @has_ns_import@
>  declarer name MODULE_IMPORT_NS;
>  identifier virtual.ns;
>
>
>
> Adding virtual report make the coccicheck go ahead smoothly.

Acked-by: Julia Lawall <julia.lawall@lip6.fr>

Thanks.


>
> >
> > Should the coccinelle directory be only for things that work with make
> > coccicheck, or for all Coccinelle scripts?
> >
> > julia
> >
> > .
> >
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
