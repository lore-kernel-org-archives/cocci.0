Return-Path: <SRS0=7OsK=QW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5874C43381
	for <cocci@archiver.kernel.org>; Fri, 15 Feb 2019 06:55:54 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2467C21927
	for <cocci@archiver.kernel.org>; Fri, 15 Feb 2019 06:55:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2467C21927
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1F6tIgs028771
          ; Fri, 15 Feb 2019 07:55:18 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DFC5976F7;
	Fri, 15 Feb 2019 07:55:17 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 10CD476F3
 for <cocci@systeme.lip6.fr>; Fri, 15 Feb 2019 07:55:16 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1F6tFQc004970
 for <cocci@systeme.lip6.fr>; Fri, 15 Feb 2019 07:55:15 +0100 (CET)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.58,371,1544482800"; d="scan'208";a="369514453"
Received: from abo-58-107-68.mrs.modulonet.fr (HELO hadrien) ([85.68.107.58])
 by mail2-relais-roc.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Feb 2019 07:55:14 +0100
Date: Fri, 15 Feb 2019 07:55:14 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: wen.yang99@zte.com.cn
In-Reply-To: <201902151452197117145@zte.com.cn>
Message-ID: <alpine.DEB.2.21.1902150754380.2896@hadrien>
References: 1550126293-27839-1-git-send-email-wen.yang99@zte.com.cn,
 201902151422261425412@zte.com.cn,
 alpine.DEB.2.21.1902150723110.2896@hadrien <201902151452197117145@zte.com.cn>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 15 Feb 2019 07:55:18 +0100 (CET)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Fri, 15 Feb 2019 07:55:15 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: wang.yi59@zte.com.cn, kernel-janitors@vger.kernel.org,
        michal.lkml@markovi.net, yellowriver2010@hotmail.com,
        nicolas.palix@imag.fr, linux-kernel@vger.kernel.org,
        cheng.shengyu@zte.com.cn, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH v4] coccinelle: semantic patch for missing
	put_device()
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



On Fri, 15 Feb 2019, wen.yang99@zte.com.cn wrote:

> Hi Julia, thank you very much.
>
> > > >> In a function, for variables returned by calling of_find_device_by_node(),
> > > > Do variables really get returned?
> > > > The provided pointer should usually be stored somewhere.
> > >
> > > Thank you very much, we will consider this situation and submit a next version to fix it.
> >
> > I don't know what Markus is talking about here, so I'm not sure that a
> > change is needed.
>
> I think Markus means that we need to deal with two situations:
> 1,  The return value of of_find_device_by_node () is assigned to a variable, such as:
> pdev = of_find_device_by_node(np);
> 2,  The return value of of_find_device_by_node() is assigned to a variable in a structure, such as:
> dev->pdev = of_find_device_by_node(args.np);
>
> So I plan to modify the following to capture both cases:
> -local idexpression id;
> +expression id;

I'm not sure that this is a good idea.  There is likely no need for a put
in the latter case.

julia

> ...
> id = of_find_device_by_node@p1(x)
>
> > > >> + "ERROR: missing put_device;"
> > > >Will change confidence considerations result in another fine-tuning for this message?
> > >
> > > Thank you, we will change "ERROR" to "WARNING".
> >
> > I think ERROR is fine. If it is a real positive than it is a real
> > problem. Warning is for things that look ugly, but don't have any impact
> > on the execution.
>
> OK, I will keep it.
> Thanks.
>
> Regards,
> Wen
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
