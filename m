Return-Path: <SRS0=21EQ=7Q=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24670C433DF
	for <cocci@archiver.kernel.org>; Wed,  3 Jun 2020 11:04:44 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FDCA20772
	for <cocci@archiver.kernel.org>; Wed,  3 Jun 2020 11:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="PnKSuZFU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FDCA20772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 053B4eGb012381;
	Wed, 3 Jun 2020 13:04:40 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 470C57567;
	Wed,  3 Jun 2020 13:04:40 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4E6343BAB
 for <cocci@systeme.lip6.fr>; Wed,  3 Jun 2020 13:04:38 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 053B4bQ3027177
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Wed, 3 Jun 2020 13:04:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1591182276;
 bh=/IWKc8X6aV71yiGoiCQcgyWK6bYiwTvG+FmhuJn1hJo=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=PnKSuZFUpcSuCR3n9KogoZubNa4uGcOxQl13XA8MWAtUmDFh5dJ42Exf6L1zWsmxM
 drTVRNZQmeh/Fk0bnm7AuXCTHgbOIP9oWyy7sO2E84h5tpEs9lZVtWceFRzrs7Nldl
 A1fPZBpJeRmE3EXSsjSk2Z7EiknLsVqMbfqD+C0w=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.82.231]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LbwKy-1jEq9Y2Yk8-00jHZ2; Wed, 03
 Jun 2020 13:04:36 +0200
To: Paul Chaignon <paul@cilium.io>
References: <1a1600a7-faf3-00bc-d616-25281bf5039b@web.de>
 <20200603090938.GA25007@Mem>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <6bf7c198-4179-8bd6-518d-47fbea561f9f@web.de>
Date: Wed, 3 Jun 2020 13:04:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200603090938.GA25007@Mem>
Content-Language: en-GB
X-Provags-ID: V03:K1:mTc0c5tFcM0XJdp27kUZHtupN37FX2IB0L914+4VQ0bRP0tMcSz
 YLB/jKnhksNQ6h2JP32DNOtONDOgVfkFu/OfHxIxCX3dvcXC1EdejD9Q/OH924czKMr4jy4
 MjQ7DcTL4IWQIozS6iTcD9E+5wAprANLF+Ukj5jl41HRqTJryxQUaoa4bIpfOT9+jYaj2rB
 hQ6IreJ6yDLPQHB/YZwfA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dOHsAARpeqY=:mGjRwUb3LPxIDDxRN99iF8
 VfBY9DS3u4YIxg9GMiLAen7yR21T5jUb/W6pzIw1VqlpaHMQcZgmOOP2VKiVcys0ClFgBxorA
 RM6CkuMtMcZ5DZpBXVNVNDF5hUvjl7K0rt9puV4Rf1YNGsxZvGaZGStLDeKhjggfabDH7ivVJ
 cL81hIdmFVh5B+a+os/omTAddphUG3jaCsegvd0q7s+HYaGbewAz9C09zH9FW2xF6gi8uXKYL
 kK0VKlwrJqDuJu6JLYmFI7gLWFbZS7nCWu970tA+QiZ7zP1csIEMqmiXleuCJfyOPXgfeyJXn
 ZUfLPRiMrWBDBJYfKl6HEvRTBmzu7tLOUIkp6SBmhzP3ZeNwC0AJwhIL5kszXsSh9BkOzFp8Y
 FA4R3f9hCNhaQf7Hz8Cr156c1vcHDjbWzgCS1JQ7PenkPBRKAndCekzvqw0kNnLh8+nuBrAMb
 tBJJWXSecOyBlG2EihxB1N3OUJd/HnvNJwU2jcBT/qURsyTecH9pwmkwWIIM8Hub5cO2vgtnK
 aYIu2nguA53H6ppqR8i844xHxpYu1XxuKezeYJpNVB+OX20cg3Qak9IyUtLYDCTQ0SUE0xJH5
 JMVPK3+THREwhQxrdz2a7PcFQvK0rKBS7VbJ7G886t/0hCEWeBTLXW3vQNQiN+3GT81qsCeUy
 69Cv8hWHVtAcMFXbOkwhFzOLBaENe78Cd8c315EbdPaPfauwqXCfAoH/56PFOkd9ev4NM1wVO
 5hN5N/9Xiye1xn5HRqFL3Ifzixw++LYiqQxw4HOzyy75EkVvElmmWBMxvh/HaifLGFxZCL4Px
 Bda5iNTGPQAbDdHb1XN0imbRLcksBMF2M2e522DeDBMH4GavqXwpYrWsprNyvJ5Ydw/TgEy2/
 eopvIwvaOHPtG8nPaDNPlLf5z4Dh4+7WhuEYlAhbWkr12z9NkQrjGk9PSVKjIN7BZsBGaCTqJ
 ANCaqpSrRoYBHS8xZrVnmRDrwug/KYHOAmsx4UrXydvMv7iatOJPQoGCVPt42z9fGmsXkETDB
 PNntuplOHYcH4S24jhrR84MT0dtW0eSMSzM5vsANnc7topJvgf1hMwlGPq/R3uULjyGDXZYB8
 GTIAaf3YHegkbeYMMy4NoKvoq2clpP8r2s3XJboNs3L8wphettx810s1MIp6phkq0TAsBTeSl
 3j/B4xCqY1jBmr7BM1/h58VP2VhFVoMR8RgYHP1WMEMj8zYhwc8GyI2gAdko9MwTK412+Rs+b
 UAAeWouzDn6dV1/jZ
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 03 Jun 2020 13:04:41 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 03 Jun 2020 13:04:37 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Excluding function names in SmPL rules
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

>> Do you find the following source code search approach helpful for
>> your software development needs?
>
> No.

It is a pity that this SmPL example does still not work in the way
which you expect so far.


> It's the first approach I tried and it didn't match anything anymore;
> I couldn't figure out why.

How many efforts would you like to invest in further clarification?

I hope otherwise that other known developers will share additional
solution ideas (besides the application of script rules with OCaml
or Python).


> It's the approach I was referring to by 'When I tried using rule1
> as the body of the function in rule2, it just didn't match anything anymore'.

I assumed that this test variant was eventually incomplete.
Would you like to point any source files out for another test
around evolving software transformation patterns?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
