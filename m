Return-Path: <SRS0=ZbCT=R5=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5910CC43381
	for <cocci@archiver.kernel.org>; Tue, 26 Mar 2019 09:57:28 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81CFF205C9
	for <cocci@archiver.kernel.org>; Tue, 26 Mar 2019 09:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="tvq7Lpiu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81CFF205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2Q9vB87016938
          ; Tue, 26 Mar 2019 10:57:11 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id AD3B37725;
	Tue, 26 Mar 2019 10:57:11 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C4CD37711
 for <cocci@systeme.lip6.fr>; Tue, 26 Mar 2019 10:57:09 +0100 (CET)
Received: from shiva.jussieu.fr (shiva.jussieu.fr [134.157.0.129])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2Q9v8Wc005316
 for <cocci@systeme.lip6.fr>; Tue, 26 Mar 2019 10:57:08 +0100 (CET)
X-pt: isis.lip6.fr
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com
 [210.131.2.91])
 by shiva.jussieu.fr (8.15.2/jtpda-5.4) with ESMTP id x2Q9rUi8075211
 for <cocci@systeme.lip6.fr>; Tue, 26 Mar 2019 10:54:47 +0100 (CET)
X-Ids: 164
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com
 [209.85.217.43]) (authenticated)
 by conssluserg-06.nifty.com with ESMTP id x2Q9qta4016559
 for <cocci@systeme.lip6.fr>; Tue, 26 Mar 2019 18:52:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x2Q9qta4016559
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1553593976;
 bh=kV/gXSw40P1r8Zz10t0raRXOXkdEnLzy9iyAhmXGUCU=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=tvq7Lpiujb9UqywGQaJO4lJhpxExRxHJTPxJYpmwIqpJbhLkT/K/KpKX1kaxUv4yR
 WPivnZxbLjpMOCctZ8m7bDOiK3LRzFBrX+N7G+m3V2SV/YWsvRD5xr8hN7iW15YDuy
 QJA7Kw6a+WV7+n0LktCqQcRJSWi3m2Q682FT5CJ+SmPczZTswhSx2E4Cg429Pv8IKw
 TBxbIIVVKqRwzut9L2CIDWHYdmDEMYsUqTZr9hi2K8ox1BmtI2nccaPTopFR/Sf1Q9
 Asi42RORHidl5meb6Yx/RnGrAua2dvdJ/ddTnLfKHhcEiATRIQcLu7TScPoLI5PJSE
 lLbpz8VgaNChw==
X-Nifty-SrcIP: [209.85.217.43]
Received: by mail-vs1-f43.google.com with SMTP id w26so6182112vsk.13
 for <cocci@systeme.lip6.fr>; Tue, 26 Mar 2019 02:52:55 -0700 (PDT)
X-Gm-Message-State: APjAAAXphGdQ0bMZx/7Huy0W9XfCMuf/sCgmn8AheqjYF+TMdJosBKrW
 pQg/SKfNO+qyS6C5dDT2kn+crxrbvDp5PkucztE=
X-Google-Smtp-Source: APXvYqxCFkSOcsL/OLLWKAVqkTGAqwBhN3d41k2YdWK+pRBBHOqPfePC49qHbkEHEjQYuhmXK4EmdP7VovAQjl4YaYg=
X-Received: by 2002:a67:7c04:: with SMTP id x4mr18180939vsc.155.1553593974610; 
 Tue, 26 Mar 2019 02:52:54 -0700 (PDT)
MIME-Version: 1.0
References: <1550217319-40418-1-git-send-email-wen.yang99@zte.com.cn>
 <CAK7LNASzd=bL1H34w-E_UD9x6w2=ObyS+EPDZ_jrvfV+ncw-yA@mail.gmail.com>
 <1691b160-5558-d4c3-afed-5773e115c5aa@web.de>
 <CAK7LNASVRbroW9_j1Kda3azHb6PzD3WyVAsKe0HfD1ri0RFPOQ@mail.gmail.com>
 <e2798cd9-1366-63a4-8638-037dc8a36618@web.de>
In-Reply-To: <e2798cd9-1366-63a4-8638-037dc8a36618@web.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 26 Mar 2019 18:52:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNATjAsiSeZoTZ57zBHse0j5ZYY_12ZQ0gaF_oCziUWheOQ@mail.gmail.com>
Message-ID: <CAK7LNATjAsiSeZoTZ57zBHse0j5ZYY_12ZQ0gaF_oCziUWheOQ@mail.gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 26 Mar 2019 10:57:12 +0100 (CET)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 26 Mar 2019 10:57:09 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Yi Wang <wang.yi59@zte.com.cn>, kernel-janitors@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Wen Yang <yellowriver2010@hotmail.com>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        cocci@systeme.lip6.fr, Cheng Shengyu <cheng.shengyu@zte.com.cn>,
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

On Tue, Mar 26, 2019 at 6:06 PM Markus Elfring <Markus.Elfring@web.de> wrote:
>
> > When I searched "Wen Yang", v6 did not show up for some reasons.
> > https://lore.kernel.org/patchwork/project/lkml/list/?series=&submitter=22638&state=*&q=&archive=&delegate=
>
> I find such a situation also interesting somehow.
> I assume that there was another temporary technical difficulty involved
> with the Linux mailing list (and related information systems).


I think v6 fell into a crack somehow.


Check the LKML archive:
https://lkml.org/lkml/2019/2/16


I see your reply:

Re: [v6] coccinelle: semantic code search for missing put_device()Markus Elfring


But, I cannot find the v6 patch itself.



>
> > So, I just thought v5 was the latest one
> > and I was completely missing the context.
>
> Did any messages for the sixth (and seventh) script version reach you?
>
> https://lore.kernel.org/cocci/201902191014156680299@zte.com.cn/


I use both my corporate email address and Gmail,
and play it by ear.


I see it in my corporate mail box now.
It reached me probably because I subscribe to cocci@systeme.lip6.fr
with my socionext email address.

However, this time I only checked my Gmail box,
which subscribes to linux-kernel ML, but not cocci ML.

I just skimmed over the thread, then
I missed the fact you were giving some comments about v6.



> https://lore.kernel.org/lkml/1553321671-27749-1-git-send-email-wen.yang99@zte.com.cn/


Yes. I see this one.

I will apply it to fixes branch
if nobody sees a problem in it.


>
> Regards,
> Markus



-- 
Best Regards
Masahiro Yamada
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
