Return-Path: <SRS0=ZbCT=R5=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436D8C43381
	for <cocci@archiver.kernel.org>; Tue, 26 Mar 2019 09:58:26 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B21D1205C9
	for <cocci@archiver.kernel.org>; Tue, 26 Mar 2019 09:58:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B21D1205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2Q9wBUS009031
          ; Tue, 26 Mar 2019 10:58:11 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 426997725;
	Tue, 26 Mar 2019 10:58:11 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 97DCB7711
 for <cocci@systeme.lip6.fr>; Tue, 26 Mar 2019 10:58:09 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2Q9w89v003389
 for <cocci@systeme.lip6.fr>; Tue, 26 Mar 2019 10:58:08 +0100 (CET)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.60,271,1549926000"; d="scan'208";a="375778464"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 Mar 2019 10:58:08 +0100
Date: Tue, 26 Mar 2019 10:58:06 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Masahiro Yamada <yamada.masahiro@socionext.com>
In-Reply-To: <CAK7LNATjAsiSeZoTZ57zBHse0j5ZYY_12ZQ0gaF_oCziUWheOQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1903261057380.5021@hadrien>
References: <1550217319-40418-1-git-send-email-wen.yang99@zte.com.cn>
 <CAK7LNASzd=bL1H34w-E_UD9x6w2=ObyS+EPDZ_jrvfV+ncw-yA@mail.gmail.com>
 <1691b160-5558-d4c3-afed-5773e115c5aa@web.de>
 <CAK7LNASVRbroW9_j1Kda3azHb6PzD3WyVAsKe0HfD1ri0RFPOQ@mail.gmail.com>
 <e2798cd9-1366-63a4-8638-037dc8a36618@web.de>
 <CAK7LNATjAsiSeZoTZ57zBHse0j5ZYY_12ZQ0gaF_oCziUWheOQ@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 26 Mar 2019 10:58:11 +0100 (CET)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Tue, 26 Mar 2019 10:58:08 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Yi Wang <wang.yi59@zte.com.cn>, kernel-janitors@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Wen Yang <yellowriver2010@hotmail.com>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        cocci@systeme.lip6.fr, Markus Elfring <Markus.Elfring@web.de>,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        Wen Yang <wen.yang99@zte.com.cn>
Subject: Re: [Cocci] [v5] coccinelle: semantic code search for missing
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



On Tue, 26 Mar 2019, Masahiro Yamada wrote:

> On Tue, Mar 26, 2019 at 6:06 PM Markus Elfring <Markus.Elfring@web.de> wrote:
> >
> > > When I searched "Wen Yang", v6 did not show up for some reasons.
> > > https://lore.kernel.org/patchwork/project/lkml/list/?series=&submitter=22638&state=*&q=&archive=&delegate=
> >
> > I find such a situation also interesting somehow.
> > I assume that there was another temporary technical difficulty involved
> > with the Linux mailing list (and related information systems).
>
>
> I think v6 fell into a crack somehow.
>
>
> Check the LKML archive:
> https://lkml.org/lkml/2019/2/16
>
>
> I see your reply:
>
> Re: [v6] coccinelle: semantic code search for missing put_device()Markus Elfring
>
>
> But, I cannot find the v6 patch itself.
>
>
>
> >
> > > So, I just thought v5 was the latest one
> > > and I was completely missing the context.
> >
> > Did any messages for the sixth (and seventh) script version reach you?
> >
> > https://lore.kernel.org/cocci/201902191014156680299@zte.com.cn/
>
>
> I use both my corporate email address and Gmail,
> and play it by ear.
>
>
> I see it in my corporate mail box now.
> It reached me probably because I subscribe to cocci@systeme.lip6.fr
> with my socionext email address.
>
> However, this time I only checked my Gmail box,
> which subscribes to linux-kernel ML, but not cocci ML.
>
> I just skimmed over the thread, then
> I missed the fact you were giving some comments about v6.
>
>
>
> > https://lore.kernel.org/lkml/1553321671-27749-1-git-send-email-wen.yang99@zte.com.cn/
>
>
> Yes. I see this one.
>
> I will apply it to fixes branch
> if nobody sees a problem in it.

This one is fine independent of anything else.

thanks,
julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
