Return-Path: <SRS0=cR8/=5Q=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA87C43331
	for <cocci@archiver.kernel.org>; Tue, 31 Mar 2020 07:12:46 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E31FA206F6
	for <cocci@archiver.kernel.org>; Tue, 31 Mar 2020 07:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="oeLMi6zN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E31FA206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02V7CQrp011012;
	Tue, 31 Mar 2020 09:12:26 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 60547780F;
	Tue, 31 Mar 2020 09:12:26 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B1109780C
 for <cocci@systeme.lip6.fr>; Tue, 31 Mar 2020 09:12:24 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02V7CORB025374
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Tue, 31 Mar 2020 09:12:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1585638741;
 bh=4jeuvftduFWrzCzNb6QlemATdSO4uQHlwd27SeV18cM=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=oeLMi6zNYJpLp9lrgvarxVqviWLjo+OdqdPVD2i5PUusYQGWlfRyjqQHJ7i81tUdC
 P/VsfAbHLGxKqQgpfbR2aQdxxRnlxk9lT6M4k2oZc9UwzkxWxjiyZxUCX4rQkNw0jS
 8ByY2+bHGkj+bClK3Xp0lJ21uDTX7JGkTHVGOUlU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.19.229]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LbImQ-1iuFep2TgQ-00kubW; Tue, 31
 Mar 2020 09:12:21 +0200
To: Joe Perches <joe@perches.com>
References: <d4d9bd0a-6bbf-3557-0726-e46cde5c8e2e@web.de>
 <b3c46f05b9341d06ad9f0c04f15918102e938c96.camel@perches.com>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <fdd2ff4e-599b-55ba-d37a-1876a89f2deb@web.de>
Date: Tue, 31 Mar 2020 09:12:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <b3c46f05b9341d06ad9f0c04f15918102e938c96.camel@perches.com>
Content-Language: en-US
X-Provags-ID: V03:K1:VD8f2suEkI1tKKupfRY1lytz5KpGk0TikLxuq+nAV2nTkWjJodm
 8KkHsuU11qyV74smzS0/nANLHsdufQC//XdaknULu/R89g8tF3E74nmrkHcgxTaEDNRsuxN
 UwTzUxIR2VZuhYThPvETLCDA1pSBQLh7Y6vh7cvqXgM3lGo7+Ycu+o/19OQs9o7d/A0rxJY
 GphnoTSfUKHmYLXGA4+zQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OjSQWR1+uS8=:yA747ZxeHQU1b9B/Wg7bsc
 obrBlpQaoLaa8ciCnxRHkhgOGMciQY3MG4I90HxJDQP98gRafM7tCSYlO05Otk4mt872ZqP76
 IAkf2MnHUn2izHCIN+8mHNP2xLvClKFposYSawF1w5LZjXdLnMKb6Fc0BWBdup24SBO/iyZW6
 P3TaNGZrKa04JAFCjilAi9VAB4mTnqPqt+rfNFpCze8NW3T2spvsGOzAmS+6CjIHL3jtX1IS1
 8fTF5YZ8YtzOFu04DTUHrX3YpcCJa7AdXvuJAx6gkv2u9iBhj8oaFMGGK0I2YYRL8YtMRFxsL
 BQgWGgvYsdxHBPHqe68OW8iuCoYdRQ6Psk4yR+z83gZsDdkkacxs2M0B/gVAGbswTDbMve10E
 X2vQ+F8Wj9PdugTuuCCgZ00V5bZdNqgkO1vuGT3kfLxeAN0sk+JyGssdvOPleFXAEHlyQJVym
 /KuYmqV5u3bTIMD2gwZ/ajZXvZ23vpuyCPhkOT1cyFkD2isw94pdXOocZqInr8FSWOGnRuoCH
 47u2ONiZT66tYO8YJ4HPKOzU+2qR62/mR1p1ZthH+DmJ3NIiHzSweB5YeBhfvzduH3ijQh6Ay
 esxIWf7v6e98KCrPTG4J6BIIS/2I9YV8jOcCGwXi5O8g8tQCYrQtRL0iXIFTbBo/xH5wAbQ5P
 fjdhYY40w92ADSE+Ne67tw+6mxlv56U084DFa8z1OxPbDmrrAue8Xaz4gpb2aOGPT/+XEFoQq
 Cq5CCPQN9qMW50i6bhphvUIVULumP76q/g/XPujjZRG9dQ7g2l4oImVboJozMLdmHrMZjVhj0
 WAFTVrY7ATYEkptWZOphQmT/WzieGE6zapM+GBUzVanl6WlQzBUUMnrElYPcY3EPsUwOdgieK
 HkDqfmMOFeYJwnKTxhNa9KJf1E7iEdMI8CvpT3Djp66lBP9hk+of01LAQDv7spDC3UOL2NWsZ
 h3h/VprRvnyZbJos+gx7RTtItIFDsKTZ9dnGz7JGKScqA2BqkyQosMRy1yG/GkqY+jAZZ55/b
 TScXDVYa4cKT7Z81ICw90k+MnUA7kBbW8AHmbCw82TjVVng090pJ4/uj/iGWLjv8TMyMpt9Bg
 vCTSBo7PRin72afpGsarUbGAZjDY7jRatz8c4Zg5FllZdnhKiZHj28sNQkiMwbSpAkAeNQMs1
 lBqyuDfQYdyn7D2XAL3frfwIHashhpZD0rDrQ7+geoT/cCMBUyll8yakK3D3mOzC+qaKUU1yg
 gQ9z1YZxfVCaXUXVJ
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 31 Mar 2020 09:12:26 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 31 Mar 2020 09:12:24 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] linux: special logic in repetitive tests
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

> Wonder harder.
>
> If something is (& 3) it is also either (& 2 || & 1)
> so why have both below the first test?

I can interpret the source code example in the way that the number
of set bits are checked.
I can eventually become concerned around the preferred coding style
because of the usage of these constant values.
Would you like to check the use of bit fields?


>> * Where do you stumble on difficulties to express a corresponding source code
>>   search pattern by the means of the semantic patch language?
>
> #defines, shifts, masks

You come along the usual development challenges for the safe handling
of possible code variations.
With which approach would you like to start and perform further
source code analysis?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
