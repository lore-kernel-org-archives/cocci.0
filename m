Return-Path: <SRS0=ztE1=4C=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0455C2BA83
	for <cocci@archiver.kernel.org>; Fri, 14 Feb 2020 12:23:22 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 046212067D
	for <cocci@archiver.kernel.org>; Fri, 14 Feb 2020 12:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="dQkAGokc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 046212067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 01ECNJgD016446;
	Fri, 14 Feb 2020 13:23:19 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 176397802;
	Fri, 14 Feb 2020 13:23:19 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 01C9477F4
 for <cocci@systeme.lip6.fr>; Fri, 14 Feb 2020 13:23:17 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 01ECNHxM029258
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Fri, 14 Feb 2020 13:23:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1581682997;
 bh=pqsTrH/HQJgf5AYvlzSwqO/lkK/NIC3Ki2XnbXifCR8=;
 h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
 b=dQkAGokc5DxWeVZGnb6bQyHEQnDOpp2N3wVDtA4JmC6RXLPGUEbJ0yVtugfddGlpt
 19K4sRCHfMWGK/xKnnPitKstG6/6xAH5CiKNTv8JdDimPHybPvV1JxCKPvdKiB6in9
 mBIKCbhg0n9Z22YSwUzF9v1w6v1yIjp69zz0Ncmc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.73.52]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LgYRZ-1jo2Dp4BAz-00nwqz; Fri, 14
 Feb 2020 13:23:17 +0100
To: cocci@systeme.lip6.fr,
        Michele Martone <michelemartone@users.sourceforge.net>
References: <138939dd-ff5b-2b85-946d-891d028bb3fa@web.de>
 <20200214120535.GC4691@localhost>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <2050f71a-5da1-f01b-b3ed-8efd675e36c9@web.de>
Date: Fri, 14 Feb 2020 13:23:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200214120535.GC4691@localhost>
Content-Language: en-US
X-Provags-ID: V03:K1:DNnVQzjPbjX7jFgATM0WDfkoGBupyAf4tpWOx7b16zMQcT4BQz1
 cqM5LVVrez3pUuptWgMr9D4tBPyv+PIY24WmTQvr4z7Q+4wAhDmU5USLt9yTMzeVV9A4itK
 rS47uAIN+O0SjnpixEsf4xvfcqC0djZPmQhwb8PykNJijYuthi/JOttTH2RzlMxlUcD6HuC
 zC4CAn9lmDHNQPlm4ytvA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uGuF+prYvpA=:2lWJjNYHdOVPBbnqYM1BgO
 zsqsElQLYYbMzdSiT5cK22m3tvz32bdLGZQk91HnD4GQ3kmS3P3hF5PEA2fP7qSVct4g5ikte
 JkNSzdj1dKm5Zo8q5xOQ5CCmJmuuvAYG69/4WxeJHiFQLoRGByFzAQutAUk70YMAxoWnod1Om
 amMxDKfnVPaBquSJjuo7ou/WKX/ElZe12/cZzkAjGif7awTZLQ3OnDPnpI/or/Da80vM1zHCo
 iljkXVP9mdz2IEFf6Gk5+/1QhkNudxkTpAxR/psIKqqOpP6FeIhU61/lGI4sHy4kKXugkF74k
 AHVOl3QZ5SviV3o26/fj1mqQ2Jf7Vc62dgUAuWSgQr8kcojMOfCygluivw4kphCxE3WQNeDmp
 SlpX3R3Nk9ZYSu5sBIIIMyYpfOjASrhhO3sIeXScTJPQ5AMkZsYOXb9CXuTP+0xyyFTzDo2oL
 t/txEtb3y1P2dDV0oTNPOVqTrZo2lA4wAIflIuDfhRhUiLO++6lqRCGw8lDBGKym0sDZtnhn2
 YR7HvaP06mGf3Aytp1SppzLxq5Cjf5tm4UL90QoARVGKWk8MYXJMgvNXpuOAgJL8c5L/+8AQd
 hWKfSG+nnd6yuwDVQFvIlWYg/EfI5d96pGOdAw+n1XB2JjdynsBMhD42gA+gkYryUTp13a6O2
 vFAjosbeCyrVUyqMQ88smHEHXjnQM8Zhi3PVDfvGYM3YglA5JwbTwVcrh8MFI51BVNfXgWTqf
 qY3lshQSaQsURzR8UiaDbiJ7eh/maCkIUSIK9na/Q6QiiSDb+UZoABfKRjoRwtrVPc0sgE+0Z
 Hz2EdqK/z8I/txltUSqvoDbvZzPS3lsVlMp/fX4lMo8mYG4LLQUs4igroQ36Kg/DNs+RXb1iY
 KgzNpbj9tf6uxGVqK8soLBu0Az7p+mm3RnO/DXwxrGjCTRLPVi6mRN8Qdw7mwZTsX/s59pF5n
 DNNAJUtaCIEatk0O0xWgWnHCXexTWqTrcgJeaf91TJ62RJApfVmM96QbnNgvVRzMSu3c46kmr
 h76RcMzkygwEEW7o1rKL2beorywEZlSOuK3KsO25iDeoSVqZLjo/ZvG5Q0T8gO1WcAELrC1NR
 TF0afZMmWobKYTHii6G2Usf5XXDL379RY4yqVwKenEfQqBESy0TZFFUHlQbcqWTplTsGAZo46
 o8y1dCp1OEXwIPHfp0Ic5C677rJKZiHD/0mKWMclsz0iWLLQDCnPxwvgiEPBJ01Btr6OJ0RoO
 3/1EfrwRQ9hSQ2BVT
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 14 Feb 2020 13:23:19 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 14 Feb 2020 13:23:17 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: Re: [Cocci] Supporting Coccinelle software
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

> I cloned coccinelle's GIT repository, I suggested a patch,
> and the patch has been accepted.

Will the chances increase for further contributions?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
