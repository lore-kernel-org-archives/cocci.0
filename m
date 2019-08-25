Return-Path: <SRS0=RP4p=WV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5A1C3A5A1
	for <cocci@archiver.kernel.org>; Sun, 25 Aug 2019 08:13:38 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DC00217D7
	for <cocci@archiver.kernel.org>; Sun, 25 Aug 2019 08:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="S3/8ibhJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DC00217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7P8DKgn021397;
	Sun, 25 Aug 2019 10:13:20 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 484E876C5;
	Sun, 25 Aug 2019 10:13:20 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id BD8A97694
 for <cocci@systeme.lip6.fr>; Sun, 25 Aug 2019 10:13:18 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7P8DG5l020882;
 Sun, 25 Aug 2019 10:13:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1566720796;
 bh=zzdprinCMONVX//j0J5jtE1DjFTyf/I/jQCKKudLh00=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=S3/8ibhJI7g+bImVoF07f2djMa8J0gsZNloR2OkbbAv7THWKn7NH8MVhWhzhLf1D3
 j9BPUXvuB7oZzy8CFx7kVkW5lGTSw4RCDC+jWp1nZA62aMwXF0Rhr1oiti/wE1OvFz
 hDH4WQhvDlUJuZR2Um1MdocUIzht5NNriIg0dMF0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.160.204]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MD8Fc-1i0lRw1CTE-00GZy8; Sun, 25
 Aug 2019 10:13:16 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <a7f12c28-0f96-d388-f1f4-57db4d3d880d@web.de>
 <2AE15A09-F219-43DC-81A9-73C13CFC0753@lip6.fr>
 <661aa3dc-3514-3d75-eb3a-9e46843fd02d@web.de>
 <alpine.DEB.2.21.1908251547420.2283@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <79368ad6-3594-87c7-6a52-6099d81ef51d@web.de>
Date: Sun, 25 Aug 2019 10:13:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1908251547420.2283@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:Jf2LM+RJvG99MfGW+bDRx7RHKG9xeIBg50p5hgT5BqxJ0qUkfBX
 TKlsOdKM3q4Hw72W5XLkzjgxXqRzgNpUCMqctvjjM4+kxhxbEIhnDAukToaMwHuKu3HIgeK
 Cnr/oB0LuLlbHaWU0DxxhQU4Q6m2+DVOcy8JcCh5BCSLlXY8//npL1zyZ5z199lOR5guqsA
 9/Zuq244dcdv2y6PaG3bg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NFE8EkduNgY=:0ijWhSOv85hlZncWk011PV
 TlqnEcYFKeynAzbXekubZU7w9xcm4xLu/m2QUeRsyqWZN2as12ukpICqhR7ZIWx1gFxEjKMyg
 vH6u10ANIGAqCBFYfGxS+vJvpF+0qimm4CwygqGW7P0kCOA3qe+Sr2hHBoWTD40iLM+VTTDlC
 zrI8thGaa8mE6QAqc3ZONhxaVmibc/BJVSBIr0y6Rr2S1+i3gMYa0ApGU7LYl58r5jDxehTt+
 Vhnh/Hu6p8qBiB5dRWI83uCamO8R+ieTJZGoY+/7t1dq7/dpCAE/YyyXXm6z1zoPK3lGSZV+L
 6kmF1EIMmtiS30Xj0whANo5LkF6Cj1HdgnaffKCr3jci0eOfzX8A0BOyJx3yoOz857s7f3swT
 hlw8/X1Tw7EQ3JPfcm8BAnx6DmhDGZ9liZge2zV6Mq86seQxpCifg4SnwjVd+sXc5vvTPbQfZ
 iU6LqxCdRSVMIXm+7XAV9ekxq8wD5RO05P15+O7g64zsSpXDJy+VKoSIvNIa6wTxJeG99z98S
 QBdtAm0934uD0JuB07XmRFxJtqN2uUP6KjudVxYSUo5bEumskOBKyJCnCkSWF9fiw8GHuqhCk
 7JcEeOktkgaHoDnXj95zOerfJZvfZZivBh66Oe2evnp93NHIawVu0WsTLH6D6nmojToHHVPTK
 0CayhYqmiY3cohtcr0quwP7Mpb8ZDqDdO36BcdpQt+/he0q90PhLhVcTlD10xe9J9CQFRP6oq
 D2hbINJ62LaOg+r8kQwiCUY0oFyDuD0ixxRv5TpRtewis/AEs4WX3fP7Z4qp9UV0JBFb7/kYM
 89JXma1MGmFNjQOI0/HlhaQOToH8a4SU5gXMOSrHYtRoYNsMxztxO3V1R8Mz1u6pUVOqsmvqW
 ZNrgvWvQChfmdsxOaKZneCYAZ6hljXls9S3JhVi9uHcA6x+glvwJFwh1M4D/+y1WR8xtfeEwD
 LP/6DUP4wP00QKbcyBSedOW7cN6YYbMejkL21RmvxpqOGIg8jz9DGuAg2wFDV8Y3yNTaS/8DI
 1Y0iTPst8axbB2OTZi9wdufDp6OBir81ahzO432C9KdUhufsJvG/mCLjnWEf6xkhu0SaO/ngf
 K+pl7on37EpiCdNMk4XkyJnxf9EpP1IF7C7sigx4Ueg7JFCcH/iOFAsomorjBF8IRdGGIY/3H
 m0Edc=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 25 Aug 2019 10:13:20 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 25 Aug 2019 10:13:18 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Challenges around asterisk usage in SmPL code
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

>>> You want <+...  ...+>
>>
>> Does this SmPL construct help to restrict a source code search element
>> (while using SmPL ellipses) to a single statement for the shown analysis example?
>
> Yes.

Thanks for the clarification.

Will this information become more helpful also for a better software documentation?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
