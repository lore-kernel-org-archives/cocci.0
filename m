Return-Path: <SRS0=FPmR=23=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA2FC33C8C
	for <cocci@archiver.kernel.org>; Mon,  6 Jan 2020 12:48:35 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F08C208C4
	for <cocci@archiver.kernel.org>; Mon,  6 Jan 2020 12:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="X7N3llKJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F08C208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 006CmKhB012030;
	Mon, 6 Jan 2020 13:48:20 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7B4B077DB;
	Mon,  6 Jan 2020 13:48:20 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4C0927718
 for <cocci@systeme.lip6.fr>; Mon,  6 Jan 2020 13:48:18 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 006CmHIh007259
 for <cocci@systeme.lip6.fr>; Mon, 6 Jan 2020 13:48:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1578314896;
 bh=CpF0gMqS1fZdWrGzDszLitqV2kTVcRYzN3wXMwFLBm4=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=X7N3llKJiG5kWhp3pXoyhyN0BBy6LIA+AdHYmSPJlWREVvNhuwuiUFl47Au/y/Ptt
 zcIM0PT40piBn0NXu1I5EHv3f6MUBw+wrr2E7z8VBn0KOQSvd60dEIZRBf8tGeCUIr
 Q1gsduj9CIWziXdl63qh4OZHs0SHAI/JXO22R6SE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.154.111]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MD8VY-1iw7Jc2Dnw-00GYBn; Mon, 06
 Jan 2020 13:48:16 +0100
To: Julia Lawall <julia.lawall@inria.fr>
References: <20200103160304.GG17258@pobox.com>
 <08d3a32e-7adc-ff5b-52d0-9e67ed03ae42@web.de>
 <alpine.DEB.2.21.2001051100550.2579@hadrien>
 <7ddf003e-956c-b146-55f5-7a68f263d5c8@web.de>
 <alpine.DEB.2.21.2001061319580.2920@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <a0b024bf-47d9-2c39-6ad4-bb09160821ac@web.de>
Date: Mon, 6 Jan 2020 13:48:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2001061319580.2920@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:u2EIEUJzGCDqnwU7LwR++TW1lbO9+01FdhA50aOM/JaTYXFscCh
 HXsbpLlD2h0qaswWvqTnWbkzYhiRxxYekq/NwSBVMgckHRPf8zP352/68FobCYWkutowyXS
 HuYw94mQhm8lxtYSptTQY888wB83HgnBeKAvdTSwUz+nwgl50eztrcKIJ9O/pRlXd+AFB6p
 iGmh8Fhsiy9379c3JBYJQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WUu7TPBUUcA=:Ivxn30sG+6pcAdBCSMDoMk
 xqMeXkalNhhZg0cYhnwjRf4ugd7HhZU4O51uCmRR2/og97QXd7UaHU5tKIFNydoJKzyC/xHLb
 kpw27FlmJ29Aw+lu6qNuJo5eqpExPRsyalxj5o9/L6yxr1nh6KsniFWUEuoYzxICr6UBhpznP
 GrZggVftXmpUvso6gqK/Ow4jeLMhqCq184E2M2cleDvEbTjVCENAYHghS/+rt+Jr6AIl6WSW7
 2ePQXspZCjxhedzIwTXWlOASZ6I75T/aMao2ZWrLG/XuxbJJ+lcTBXYSf5U7GrmMCkeLoGo14
 cwVrfzgu1Dt30xYzfDbdlULrRED1uljTeurRR4p+i/qK+VWrrViKEi/nhcjMSvzdOl0E77XvJ
 MUAePpV6N6UIV8MQBt5bwf3KCGcqqUuOlFHjvMzwZqLR2YGnE0jiqPh2/d9dcRCqpzkOPPEpl
 kYof86qC8DMPExbPtathrS7+Dv4h4oISg8T4bQlDxm9uMkLSzrMt+s6nhUlmGEllcskWdAwOl
 tFRa9hX4JVDhAkUg/XaeDqK6rswwwBZwgsv7/ktuMNxwJb6HJInid97H5C43jwV58O/4Hc4A5
 s5MelTTaTRwxIA+J6Iyd9JlxzY5CRcIGSxuB2rYmi4R6CqzjVH7u1atPsVXTsOwJ1b5n/zkXD
 i+su4Sdblb+xusBmsTAXGsBSv1VOY2dIuxJ4lxmSLttVYgl9M1ceSkTPKdVElMFqeimDc+sRR
 AuhjryzqIdsBQP58s3fzuQPDYiGxE/20ckrqaWD29+UgbxvDgYsnEGn1oFBCvyAYMj2S4Grvc
 1mPkc5QK2akCLptvLsLMF8Qg2Elq4bjXjG/nXGYa5iJyzdjJbHnsbcPxKciQCyMuaRd4dWImZ
 QMuxN+A2cQcoS1S8JTtSpxuzSQhjIXYI64tpTP7ELUUI898+NvaNLBEiOCmuFytMaE9hcmn/J
 TOAFZKCtxSXC+WVQHocoi4WnPxDEWqLVibVYcpY+gqTgeCtNZLZ+bpSKXEDNX1oyHi+IkFFX3
 MBOFeMeHysAfXO+cVuIA8NVXWNupgJtmjIOucUx+lzBORMgPFTBXesbkTEifTLF592DbwtQd5
 JXdFXIjzcUuSxFqw6IKXfaL+IfxeCZu11LUPAqk8budg8DNPxpuzN37rKe0LjDG/BvWyJmw3i
 xkkX4vwtjB7hHLFNC/OIuNt1uCZRQvLNyJb4ViMx8/aHTCPqpKOWgHyhCXkdeF3mjGbi3UdKz
 HJYN6M5okAw1EW15bT8Yd9K3S428F+MoM6yqderGTSsRuR/AT4hLp4MRbKzo=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 06 Jan 2020 13:48:20 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 06 Jan 2020 13:48:17 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Improving support for data processing around macro calls
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

> The SmPL language doesn't support statements that look like function calls
> but have no following ;

A missing semicolon can trigger the source code interpretation in different ways.

* Can macro calls be treated similar to attributes?

* How challenging will it become to change the mentioned software limitation?
  https://github.com/coccinelle/coccinelle/issues/140

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
