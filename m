Return-Path: <SRS0=k1+2=YW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78136CA9EAE
	for <cocci@archiver.kernel.org>; Tue, 29 Oct 2019 13:38:53 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17B272086A
	for <cocci@archiver.kernel.org>; Tue, 29 Oct 2019 13:38:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17B272086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9TDcctf014859;
	Tue, 29 Oct 2019 14:38:38 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C23B877BA;
	Tue, 29 Oct 2019 14:38:38 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9EC7A454C
 for <cocci@systeme.lip6.fr>; Tue, 29 Oct 2019 14:38:37 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9TDcbdt029075
 for <cocci@systeme.lip6.fr>; Tue, 29 Oct 2019 14:38:37 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.68,244,1569276000"; d="scan'208";a="409343048"
Received: from unknown (HELO hadrien) ([91.217.168.176])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Oct 2019 14:38:37 +0100
Date: Tue, 29 Oct 2019 14:38:36 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: julia@hadrien
To: Masahiro Yamada <yamada.masahiro@socionext.com>
In-Reply-To: <CAK7LNAQ8Wi1zED0rYJhk9tYi5-jgCoyeHNtofvgKet4ZTzKFcA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1910291437450.2179@hadrien>
References: <CAK7LNAQ8Wi1zED0rYJhk9tYi5-jgCoyeHNtofvgKet4ZTzKFcA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 29 Oct 2019 14:38:39 +0100 (CET)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Tue, 29 Oct 2019 14:38:37 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthias Maennich <maennich@google.com>,
        Coccinelle <cocci@systeme.lip6.fr>, Jessica Yu <jeyu@kernel.org>
Subject: Re: [Cocci] Warning message from 'make nsdeps' when namespace is
 lower cases
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

> Hi.
>
> When I was playing with 'make nsdeps',
> I saw a new warning.
>
> If I rename USB_STORAGE to usb_storage,
> I see 'warning: line 15: should usb_storage be a metavariable?'
> Why? I think it comes from spatch.

Yes, it would come from spatch.

> It should be technically OK to use either upper or lower cases
> for the namespace name.

What is normally wanted?  Uppercase or lowercase?

julia

>
> Just apply the following, and try 'make nsdeps'.
>
>
> diff --git a/drivers/usb/storage/Makefile b/drivers/usb/storage/Makefile
> index 46635fa4a340..6f817d65c26b 100644
> --- a/drivers/usb/storage/Makefile
> +++ b/drivers/usb/storage/Makefile
> @@ -8,7 +8,7 @@
>
>  ccflags-y := -I $(srctree)/drivers/scsi
>
> -ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=USB_STORAGE
> +ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=usb_storage
>
>  obj-$(CONFIG_USB_UAS)          += uas.o
>  obj-$(CONFIG_USB_STORAGE)      += usb-storage.o
>
>
>
>
>
>
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
