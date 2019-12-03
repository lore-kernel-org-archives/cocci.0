Return-Path: <SRS0=z6Nh=ZZ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA82C432C0
	for <cocci@archiver.kernel.org>; Tue,  3 Dec 2019 10:02:16 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 027D4206DF
	for <cocci@archiver.kernel.org>; Tue,  3 Dec 2019 10:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="CnwnVpY1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 027D4206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xB3A1uUT015280;
	Tue, 3 Dec 2019 11:01:56 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B283477D7;
	Tue,  3 Dec 2019 11:01:56 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 25D7E4386
 for <cocci@systeme.lip6.fr>; Tue,  3 Dec 2019 11:01:55 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xB3A1sTQ026509
 for <cocci@systeme.lip6.fr>; Tue, 3 Dec 2019 11:01:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1575367313;
 bh=VNr7sxAWqEnw0du9HQCCaJ9JUZ/V9lVrQeNomv6m7Mc=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=CnwnVpY1FRGiEKilIevkjsLDDYOYwe0dmXHUj+8OKeHH7rXFZq+7RTe9VwuseHKOr
 OI+Bc6LjD/FwT0Brb/UCMAXznlOfmYRTi7LwtARbhiZZpYI+0VxzC2skcXwFta5Yyi
 uIolLZjlofPUannLask5tKS/rFf//uK7aDiw1Dos=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.132.47.193]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lu4qk-1hb0XH0BmQ-011VVl; Tue, 03
 Dec 2019 11:01:53 +0100
To: stracelabs@gmail.com, Julia Lawall <julia.lawall@inria.fr>
References: <CABvP5W1W=p1-n_831VaiJyNsHrepFS0CNJSDQqmfPkrC1rx=Ww@mail.gmail.com>
 <a64ca4bf-4d00-6d8f-19cf-0667d9b1ca83@web.de>
 <CY4PR1801MB200527E64CB2C5ECF218EFF4A3460@CY4PR1801MB2005.namprd18.prod.outlook.com>
 <509ffde0-ec26-a58c-d424-6910bc8e7473@web.de>
 <CABvP5W0d-MErjsS5yqfDtPu4OyiHzdurBDHrwJX4iNzzWjSgwA@mail.gmail.com>
 <02fa7455-e76e-7d7d-0d64-41b2803a8025@web.de>
 <CABvP5W0kVE+yBYa7gWLfsegb75fMyMcLSDbsnFUGRnnVoRLtDQ@mail.gmail.com>
 <alpine.DEB.2.21.1911292154450.3140@hadrien>
 <CABvP5W3hmmovw09n6gJQ5m=Cps2YAYJFFfOPmKY6Zu_SJOU=NQ@mail.gmail.com>
 <0c03f84d-a05b-2811-96aa-6f82541fb8a3@web.de>
 <CABvP5W3E3zP28kUsmrvUOqv-Tu1YT3zvi6c=mqx+ahbMTycqAQ@mail.gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <efbd9ebe-d437-d172-1c9a-96662abb3bd7@web.de>
Date: Tue, 3 Dec 2019 11:01:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CABvP5W3E3zP28kUsmrvUOqv-Tu1YT3zvi6c=mqx+ahbMTycqAQ@mail.gmail.com>
Content-Language: en-US
X-Provags-ID: V03:K1:kjjzzrG3dEjCV7qrHHXTz9+g2JWHtumuIs/u5Du5Lyz/ejvMfex
 a1+qiKkRv9ix6JbifumbXmePIhz9UWsUZzlvW4cKANLHWwwgbkpmLbT/N10PhxahotB8OQZ
 J+j2DtqRxVlLJzd+Q8mUKfh88cAzJqZGj+it7jJNp8CcN4gMfNlarVR+ezZgW3dH8WfcHaE
 2z/+l+bGHiIB6CCFWSuvA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qLloq5LRMiI=:CQ482uTm4d76RaZAPZYgjR
 glT2iWem/hmqIaTxO0xfneFxsq6WV7g2LqvETno4X9bTuT9NHOBWDnxXfqmPYAspq2vpnCfd7
 f8Y9KFEaA4gSHZIvAlGjQm1KCUSoWsw1Mk0IwpKkl7qr/ItCDdsRq9ULmdRGlEc5M8O4McPkr
 zfCPlVHMyssZDyHL8YvIBX85k6h1bcj91zZux3Eduk9kn3ooUVp4yaSXRTpTaivOe16Q8L184
 ZQ1zacn3Trr45c4F7Vf5KXqb9T8ueYpGRj0mcC/Ykam1a/PRpir3QkhNWnX+BQCWy2ofrtzNZ
 blxoGI8Kc+hi8YvojvgsPlmimP52H95vnaNoCMNGwbENrVgHF2fOWFMKfXg2yGJU+mI9rfTDp
 WRO7lfslaWODkhBwp73n0d81nTmiRjfgrVilmHPQphDo2VYybI74fX7GNlcs6yrT9y/pGL0lH
 gXlq/ouL0FWSuUYp+ZodY87QZIUUMvwVENnspC//lNwkpD9vwJBY2YhvbaSocT+Whhjgq2wUV
 BEBPQDcfgVsZPULvCA1lo1Sm8IFePMwyp1cwQmCjguWMi7IeF1F5A9VwqOdg5DGKXKv+AEZqK
 h7/oCYUNzLc8yfTYNbbWHMqM1xXxadsqOVgKC+LKd/OQt+t0ERVyCMfSwL+iWngoq+EsKtEuH
 BWkcCBnX2gn4JepFmdzUntsuJw0R7sODFpf78cc/7Y0H/l7ko/WufGPds2h4kSC4dzqpnbeYs
 cEf4Uw7E0veJ4GB9N9fjS2n0+v7YD0gJgUI1JswGfIrbzc9qp2gbl6OUmuAaue48BItneF5tO
 Uzq38mMx7w56i7ek2jH1jQpDCOzsjU1KZgjKJmLzLc6np8I0w+PYTOs8adF1fd1hoclLyjdKt
 +5ADJUuYNEqsgLUCQWyPeRuYkS1QowmhIjDhpTlnTc7wnX7kF/bdKVOScSRpcKD1hStecaKSM
 ZgbrZy0FLF3pEGulGXJIR3BEALt84fbwAYYh8myQ7KCjWVGTm2BBb0W0K6Yg0b9vHA3Y71kuG
 WxBbbnUJ1Y59p2E73saqgdQALDgrZGGvZvqK+xEUnelyiN5WPZOGDYT0Lvj9x0ZAHAne88ZBD
 kU4tk1Cv++3erUn0YajnG7R0Uu66p94Wzm1LTszMqVo5DxVgdut5qaqkPhodDbptP9+WfNoGx
 cQMc/7PiylcxCDlU2wrpK0aa33a7aIZIeiMrod++j8ZzJweo/xUyred7m0ViEUAunCqKrQWG4
 6uDB/Pwb/iT553bUArgXVeRb1NyVLJEew8ENm9UIBngx4QYXFP/7CNcc8A8M=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 03 Dec 2019 11:01:57 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 03 Dec 2019 11:01:54 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Changing format string usage with SmPL?
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

> > Which algorithm will become sufficient for your data processing needs
> > around the usage of functions with variadic arguments because of format strings?
>
> Actually, I really didn't get why you're asking about that.

I suggest to take another look at affected software aspects.


> because we are talking about X and you're asking for Y.

I presented another approach to tackle your use case.


> the point is because I am studying about the Coccinelle

This is nice.


> and I am just trying to figure out if the tool could detect "%s"
> called with "mydata->name" and then replace by "%m" and remove the "->name"

It can be achieved for such format string parameters.
But I hope that the software development attention will grow
for the handling of multiple data conversions for several arguments.


> But, I've read again the other samples and the documentation.
> therefore, I didn't figure out how it should be.

Would you like to help to improve this area also for your needs?


> btw, thank you Julia for the suggestion performing the /Ocalm/make_expr/replace/.
> (Due to something wrong with the Coccinelle distributed by Brew/Osx.
> I just rewrote your sample using Python and the result was the same.

Both programming languages can perform string replacements as usual.


> But, I can't just replace all "%s" by "%m".

Will you become aware of more temporary software limitations
because mentioned implementation details can refer also to work in progress?


> As I said, it should be only if the "%s" was declared to use "mydata->name".

Such a requirement seems to be clear.


> so, I still fighting yet.

Can it be that your design imaginations are too limited
for the discussed use case so far?

How do you think about to develop a few corresponding SmPL script variants
which can handle more concrete function calls besides searching for a solution
according to the desired general source code transformation?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
