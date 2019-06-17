Return-Path: <SRS0=vOk2=UQ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929D7C31E5B
	for <cocci@archiver.kernel.org>; Mon, 17 Jun 2019 20:46:04 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3A5120644
	for <cocci@archiver.kernel.org>; Mon, 17 Jun 2019 20:46:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3A5120644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5HKjnbV027425;
	Mon, 17 Jun 2019 22:45:49 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 073107779;
	Mon, 17 Jun 2019 22:45:49 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id ADB097778
 for <cocci@systeme.lip6.fr>; Mon, 17 Jun 2019 22:45:46 +0200 (CEST)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5HKjknE002518
 for <cocci@systeme.lip6.fr>; Mon, 17 Jun 2019 22:45:46 +0200 (CEST)
Received: from [192.168.1.110] ([77.2.173.233]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MekrN-1iAeRt2PkD-00ajfZ; Mon, 17 Jun 2019 22:21:08 +0200
To: Markus Elfring <Markus.Elfring@web.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20190406061112.31620-1-himanshujha199640@gmail.com>
 <f09006a3-691c-382a-23b8-8e9ff5b4a5f1@web.de>
 <alpine.DEB.2.21.1906081925090.2543@hadrien>
 <7b4fe770-dadd-80ba-2ba4-0f2bc90984ef@web.de>
 <f573b2d3-11d0-92b5-f8ab-4c4b6493e152@metux.net>
 <032e347f-e575-c89c-fa62-473d52232735@web.de>
From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <910a5806-9a08-adf4-4fba-d5ec2f5807ff@metux.net>
Date: Mon, 17 Jun 2019 22:21:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <032e347f-e575-c89c-fa62-473d52232735@web.de>
Content-Language: en-US
X-Provags-ID: V03:K1:K5hGr7aDqN0OiD+j1BM/crsHbtdWkEiMkJveIo+Dzl/CLujnQAj
 5FroUnxU9FmzU4e3pM00kbhMxXtfzw3KBr/v8HQimfFjjti/8q3/bJNqoLbLQykYnS63Ivd
 f4g8n6pSMr05CBNmmyc84n4a/lEv3TAFV+C+8Msj+qnJMG+Kxak9rQDKtkgZuPRnsisEjqS
 n9N+AfJ2kqJV3Is7dtJ2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1cbUqhatC4E=:KzKXFx2EzcB6QRECqlt05b
 RbA7YzpQWCqmFGbJLkttC3DsKOaCtPvh3Lflb5enhyR4uoWSFtXublwaLYAhKGSoPdGq41M45
 ZGUNBBY72qnr7qx/pi/LRwHq02IO5SBbEcUE0HDRgC+q50DETRkCFZxkhBa5BBNZykslfLBw1
 emIC2wUS7fLe1RzNTqyb+h/KnRTnn/ond82wL5r3lxXpOrkebXcyLaZOYI4A7J8G6qSNtdz/b
 1UXiFIgVvf8chTIQDI/1Kn1+MZfUgCpkCfyNuwqFoYcRCAaEDSBlFvzOaVahRo7GJuCequKWv
 yCxWzbwLa/scqU49xJ318TZnquajDxvB/FTvRcx0EqZ87LkEjZ36mB5RhSeiVF/K/m/epuMqJ
 nEAEzqeiBpo2t9C9mJmvxGTZHeVlQhouYhUgdyESp0yE7nv3yrv2DmWZpXv7BubIsvJFTRWpR
 +hxOgNgtAbxnZ+he8Bh42bHr+qLVlQ0Aordhbk0nvB1vD0WVL2o4tzJpBlPXE9sY4lANVe26L
 g47F8EZf7oFSbGymX82Q96K+aKBpL+8whfvBG159xik5jz59G03njGmiIUhfdHuKIfAViWHuI
 hWp2oXbpownd91MT68/tDuKqniqelw43gk3lBu5hdVvtAGqLh1uUI3f20pi8Mxi99qNAPVUuC
 g0+C/6YaMQMgodvedC09OLAmVGt0WWM3s8wGKGP4riFBLnNjZbkBy3zIbU+zfkIJO+t4cXDb4
 4Oi/Y/1XidMMyoDaRGLbVa6Nhp6rXdtRtkdZDtSHKkcohZgowPGpdF9pSB0=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 17 Jun 2019 22:45:49 +0200 (CEST)
X-Greylist: Delayed for 00:24:30 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Mon, 17 Jun 2019 22:45:46 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] drivers: Inline code in
 devm_platform_ioremap_resource() from two functions
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

On 14.06.19 11:22, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 14 Jun 2019 11:05:33 +0200
> 
> Two function calls were combined in this function implementation.
> Inline corresponding code so that extra error checks can be avoided here.

What exactly is the purpose of this ?

Looks like a notable code duplication ... I thought we usually try to
reduce this, instead of introducing new ones.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
