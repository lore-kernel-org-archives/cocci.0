Return-Path: <SRS0=ZbCT=R5=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6615FC43381
	for <cocci@archiver.kernel.org>; Tue, 26 Mar 2019 07:10:12 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F7FD20811
	for <cocci@archiver.kernel.org>; Tue, 26 Mar 2019 07:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="b2A5PWNJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F7FD20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2Q79snd029618
          ; Tue, 26 Mar 2019 08:09:54 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 449677725;
	Tue, 26 Mar 2019 08:09:54 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B629D7711
 for <cocci@systeme.lip6.fr>; Tue, 26 Mar 2019 08:09:52 +0100 (CET)
Received: from condef-02.nifty.com (condef-02.nifty.com [202.248.20.67])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2Q79obN006112
 for <cocci@systeme.lip6.fr>; Tue, 26 Mar 2019 08:09:51 +0100 (CET)
X-pt: isis.lip6.fr
Received: from conssluserg-05.nifty.com ([10.126.8.84])by condef-02.nifty.com
 with ESMTP id x2Q6uOAQ016311
 for <cocci@systeme.lip6.fr>; Tue, 26 Mar 2019 15:56:24 +0900
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com
 [209.85.217.50]) (authenticated)
 by conssluserg-05.nifty.com with ESMTP id x2Q6tFPG020848
 for <cocci@systeme.lip6.fr>; Tue, 26 Mar 2019 15:55:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x2Q6tFPG020848
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1553583316;
 bh=ZTLgSM1mO1pr23hIFYrx8hyiWl+7jjWpTd6XoqBsTAM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=b2A5PWNJb5mx62hIvCfJRb6f1wvs546TOTCDoDCASDQo71xomR3bBF8n+xEZLBNuT
 a6QG3YZ4xiaITCxMg9EU9eQO+KwoIsjv29HoBKPYPJslHRa6IcWcYky+/zxHLC2V1p
 VhhXdb8Yg7vCb5a7vFQN4lO8hfgeQGJiDhm6KSsPVsXvrmOyFKngpeSUsqH005OBHx
 an5qda5jpU2ixvs25aBW+u5ObaP7AvbWz3jqsm1b4M+8Qt+utNf33+zGd4S0SYkM8J
 315GFUdJz09MxK2d7Poqmo3fll1BZXW1Qg7K4lLFzmmjFq4boz/EXX7BRODpXbE36I
 zKTHwluzf5ouw==
X-Nifty-SrcIP: [209.85.217.50]
Received: by mail-vs1-f50.google.com with SMTP id w26so5940933vsk.13
 for <cocci@systeme.lip6.fr>; Mon, 25 Mar 2019 23:55:15 -0700 (PDT)
X-Gm-Message-State: APjAAAVfGjvBtX3LNweWFyqhWUeZ2AcARiuGNPRMa/wYWYYapjqkwIm7
 irzdZnAHren0g/hi7aVeHahMDlojUllkkVR04Bo=
X-Google-Smtp-Source: APXvYqzV9OprKdvHU63DVjLcAFetIJS3ZLs1hjqNUeM8DGDu+7OA+RlaT637zUo8SuAR/q6K0ukwOj1IIaTs1ZocwpI=
X-Received: by 2002:a67:f105:: with SMTP id n5mr17824787vsk.181.1553583314850; 
 Mon, 25 Mar 2019 23:55:14 -0700 (PDT)
MIME-Version: 1.0
References: <1550217319-40418-1-git-send-email-wen.yang99@zte.com.cn>
 <CAK7LNASzd=bL1H34w-E_UD9x6w2=ObyS+EPDZ_jrvfV+ncw-yA@mail.gmail.com>
 <1691b160-5558-d4c3-afed-5773e115c5aa@web.de>
In-Reply-To: <1691b160-5558-d4c3-afed-5773e115c5aa@web.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 26 Mar 2019 15:54:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNASVRbroW9_j1Kda3azHb6PzD3WyVAsKe0HfD1ri0RFPOQ@mail.gmail.com>
Message-ID: <CAK7LNASVRbroW9_j1Kda3azHb6PzD3WyVAsKe0HfD1ri0RFPOQ@mail.gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 26 Mar 2019 08:09:55 +0100 (CET)
X-Greylist: Delayed for 00:09:53 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Tue, 26 Mar 2019 08:09:51 +0100 (CET)
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

On Sun, Mar 24, 2019 at 1:19 AM Markus Elfring <Markus.Elfring@web.de> wrote:
>
> > Applied to linux-kbuild.
>
> A questionable development version was integrated for this SmPL script.


Sorry for my bad job.

I usually use LKML patchwork to find patches.

When I searched "Wen Yang", v6 did not show up for some reasons.
https://lore.kernel.org/patchwork/project/lkml/list/?series=&submitter=22638&state=*&q=&archive=&delegate=

So, I just thought v5 was the latest one
and I was completely missing the context.


Apology.

Masahiro



> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/scripts/coccinelle/free/put_device.cocci?id=da9cfb87a44da61f2403c4312916befcb6b6d7e8
>
> https://lore.kernel.org/cocci/201902191014156680299@zte.com.cn/
>
>
> Now I am curious on how such a source code analysis approach will be
> improved further.
> Which changes will get the desired acceptance?
>
> https://lore.kernel.org/patchwork/patch/1053979/
> https://lore.kernel.org/lkml/1553321671-27749-1-git-send-email-wen.yang99@zte.com.cn/
> https://systeme.lip6.fr/pipermail/cocci/2019-March/005679.html
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
