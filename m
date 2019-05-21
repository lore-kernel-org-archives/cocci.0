Return-Path: <SRS0=7mCU=TV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DC2C04AAF
	for <cocci@archiver.kernel.org>; Tue, 21 May 2019 06:15:43 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9466720863
	for <cocci@archiver.kernel.org>; Tue, 21 May 2019 06:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Q0kjGPi3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9466720863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4L6FTd2029467;
	Tue, 21 May 2019 08:15:29 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2E5AF7747;
	Tue, 21 May 2019 08:15:29 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 10DBD7741
 for <cocci@systeme.lip6.fr>; Tue, 21 May 2019 08:15:26 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4L6FPC7008888;
 Tue, 21 May 2019 08:15:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1558419325;
 bh=Wj3U75MpRGUTBZ1ZKK9aPKThO6oPtJxmBWizv0mII4s=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=Q0kjGPi3Pk7LduQii9coGcR0ZvQMgdJMpIq2UCTwP9kWWDp4PcUu1/ByTNTS9Reqf
 35x99FdMVoT8mtbo19+ayuhX1x/mmHSUg8H34c9oIpVW7D2vGoJFhwLupIfv4wk3Ar
 lUqMZBbz6E7Fvt5u6756dnC8gV/T3rq5+q8c0180=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.135.93.135]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M1XDJ-1ge2E80hCr-00tWca; Tue, 21
 May 2019 08:15:25 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <a639ce38-81a1-8825-73b0-2b7ba53e6588@web.de>
 <78de5a84-1651-c5eb-4fbd-35362c93abef@web.de>
 <alpine.DEB.2.21.1905210756490.2773@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 mQINBFg2+xABEADBJW2hoUoFXVFWTeKbqqif8VjszdMkriilx90WB5c0ddWQX14h6w5bT/A8
 +v43YoGpDNyhgA0w9CEhuwfZrE91GocMtjLO67TAc2i2nxMc/FJRDI0OemO4VJ9RwID6ltwt
 mpVJgXGKkNJ1ey+QOXouzlErVvE2fRh+KXXN1Q7fSmTJlAW9XJYHS3BDHb0uRpymRSX3O+E2
 lA87C7R8qAigPDZi6Z7UmwIA83ZMKXQ5stA0lhPyYgQcM7fh7V4ZYhnR0I5/qkUoxKpqaYLp
 YHBczVP+Zx/zHOM0KQphOMbU7X3c1pmMruoe6ti9uZzqZSLsF+NKXFEPBS665tQr66HJvZvY
 GMDlntZFAZ6xQvCC1r3MGoxEC1tuEa24vPCC9RZ9wk2sY5Csbva0WwYv3WKRZZBv8eIhGMxs
 rcpeGShRFyZ/0BYO53wZAPV1pEhGLLxd8eLN/nEWjJE0ejakPC1H/mt5F+yQBJAzz9JzbToU
 5jKLu0SugNI18MspJut8AiA1M44CIWrNHXvWsQ+nnBKHDHHYZu7MoXlOmB32ndsfPthR3GSv
 jN7YD4Ad724H8fhRijmC1+RpuSce7w2JLj5cYj4MlccmNb8YUxsE8brY2WkXQYS8Ivse39MX
 BE66MQN0r5DQ6oqgoJ4gHIVBUv/ZwgcmUNS5gQkNCFA0dWXznQARAQABtCZNYXJrdXMgRWxm
 cmluZyA8TWFya3VzLkVsZnJpbmdAd2ViLmRlPokCVAQTAQgAPhYhBHDP0hzibeXjwQ/ITuU9
 Figxg9azBQJYNvsQAhsjBQkJZgGABQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEOU9Figx
 g9azcyMP/iVihZkZ4VyH3/wlV3nRiXvSreqg+pGPI3c8J6DjP9zvz7QHN35zWM++1yNek7Ar
 OVXwuKBo18ASlYzZPTFJZwQQdkZSV+atwIzG3US50ZZ4p7VyUuDuQQVVqFlaf6qZOkwHSnk+
 CeGxlDz1POSHY17VbJG2CzPuqMfgBtqIU1dODFLpFq4oIAwEOG6fxRa59qbsTLXxyw+PzRaR
 LIjVOit28raM83Efk07JKow8URb4u1n7k9RGAcnsM5/WMLRbDYjWTx0lJ2WO9zYwPgRykhn2
 sOyJVXk9xVESGTwEPbTtfHM+4x0n0gC6GzfTMvwvZ9G6xoM0S4/+lgbaaa9t5tT/PrsvJiob
 kfqDrPbmSwr2G5mHnSM9M7B+w8odjmQFOwAjfcxoVIHxC4Cl/GAAKsX3KNKTspCHR0Yag78w
 i8duH/eEd4tB8twcqCi3aCgWoIrhjNS0myusmuA89kAWFFW5z26qNCOefovCx8drdMXQfMYv
 g5lRk821ZCNBosfRUvcMXoY6lTwHLIDrEfkJQtjxfdTlWQdwr0mM5ye7vd83AManSQwutgpI
 q+wE8CNY2VN9xAlE7OhcmWXlnAw3MJLW863SXdGlnkA3N+U4BoKQSIToGuXARQ14IMNvfeKX
 NphLPpUUnUNdfxAHu/S3tPTc/E/oePbHo794dnEm57LuuQINBFg2+xABEADZg/T+4o5qj4cw
 nd0G5pFy7ACxk28mSrLuva9tyzqPgRZ2bdPiwNXJUvBg1es2u81urekeUvGvnERB/TKekp25
 4wU3I2lEhIXj5NVdLc6eU5czZQs4YEZbu1U5iqhhZmKhlLrhLlZv2whLOXRlLwi4jAzXIZAu
 76mT813jbczl2dwxFxcT8XRzk9+dwzNTdOg75683uinMgskiiul+dzd6sumdOhRZR7YBT+xC
 wzfykOgBKnzfFscMwKR0iuHNB+VdEnZw80XGZi4N1ku81DHxmo2HG3icg7CwO1ih2jx8ik0r
 riIyMhJrTXgR1hF6kQnX7p2mXe6K0s8tQFK0ZZmYpZuGYYsV05OvU8yqrRVL/GYvy4Xgplm3
 DuMuC7/A9/BfmxZVEPAS1gW6QQ8vSO4zf60zREKoSNYeiv+tURM2KOEj8tCMZN3k3sNASfoG
 fMvTvOjT0yzMbJsI1jwLwy5uA2JVdSLoWzBD8awZ2X/eCU9YDZeGuWmxzIHvkuMj8FfX8cK/
 2m437UA877eqmcgiEy/3B7XeHUipOL83gjfq4ETzVmxVswkVvZvR6j2blQVr+MhCZPq83Ota
 xNB7QptPxJuNRZ49gtT6uQkyGI+2daXqkj/Mot5tKxNKtM1Vbr/3b+AEMA7qLz7QjhgGJcie
 qp4b0gELjY1Oe9dBAXMiDwARAQABiQI8BBgBCAAmFiEEcM/SHOJt5ePBD8hO5T0WKDGD1rMF
 Alg2+xACGwwFCQlmAYAACgkQ5T0WKDGD1rOYSw/+P6fYSZjTJDAl9XNfXRjRRyJSfaw6N1pA
 Ahuu0MIa3djFRuFCrAHUaaFZf5V2iW5xhGnrhDwE1Ksf7tlstSne/G0a+Ef7vhUyeTn6U/0m
 +/BrsCsBUXhqeNuraGUtaleatQijXfuemUwgB+mE3B0SobE601XLo6MYIhPh8MG32MKO5kOY
 hB5jzyor7WoN3ETVNQoGgMzPVWIRElwpcXr+yGoTLAOpG7nkAUBBj9n9TPpSdt/npfok9ZfL
 /Q+ranrxb2Cy4tvOPxeVfR58XveX85ICrW9VHPVq9sJf/a24bMm6+qEg1V/G7u/AM3fM8U2m
 tdrTqOrfxklZ7beppGKzC1/WLrcr072vrdiN0icyOHQlfWmaPv0pUnW3AwtiMYngT96BevfA
 qlwaymjPTvH+cTXScnbydfOQW8220JQwykUe+sHRZfAF5TS2YCkQvsyf7vIpSqo/ttDk4+xc
 Z/wsLiWTgKlih2QYULvW61XU+mWsK8+ZlYUrRMpkauN4CJ5yTpvp+Orcz5KixHQmc5tbkLWf
 x0n1QFc1xxJhbzN+r9djSGGN/5IBDfUqSANC8cWzHpWaHmSuU3JSAMB/N+yQjIad2ztTckZY
 pwT6oxng29LzZspTYUEzMz3wK2jQHw+U66qBFk8whA7B2uAU1QdGyPgahLYSOa4XAEGb6wbI FEE=
Message-ID: <9d27cabf-5a75-247b-3469-6280779687fe@web.de>
Date: Tue, 21 May 2019 08:15:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1905210756490.2773@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:Yxdzi2H2xnzqMN8cbX0d+Urvd8dHENsrkHqdrylnaps4XREdc8c
 RS2IOG/iBJqsoaQ2pPZuSLTWkjV8tS8rOZWebi6LEMlucTtDm29nHjOCnx98XMXUPLPPXzc
 1oghJ1v6IwWh8FzeQeV8u1Q53CgNtWcKJrBbFV3IJRqTResl4aRPk3pVkbxMNPB7XjJ+wgq
 xhAeiXx69M2sZBVpmMDXA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cF1rlImpERw=:Dd1ACIrPe+y9qHDJJSnsiS
 zwp75eVqQcGuxbG52LpJ53cQJ4ptfl6hi1qTGrXn9MglWryQUPTO9o2bNn/+qsOV1hta480MR
 uiJJYWf9bziteDatkvpBHBHuX49J616XoFqwxMXAXpMd5ORuZLlDtnOlkp+4zGcZ3cWoVjAMz
 PUl3RA4eJRUdsejOyVxgw/IoETVDAWkaTlgUDLwZrXfP676U4PZj7G4IeZcn3wouqRxo88v0s
 /o8yIVC5jyb70A9cGbM/XmLs8clsC8K+8TZZvTqAfkQLUKeQ/QY54niuXsbKYBs9QgFEBYMJi
 4HvCrSjRYh8QE6DT8w8ONiIHB3DE/l7Y61gWuenEIEaGFgDVCUNNVOoSjPuy48QQ1Z09byUDk
 nODPPdSNUKFjtzL9DwhUIzabgh01eVb+fguh3nsx9/mgBfL+c+uFRrhZmmvYckUWCv1yFRGHL
 6Fs51khvD9f/U05X6Enzm7Z1iztJgwzP+FX6lAyjY3+0qmaWao6v+h22ScIAanebEdoLAPRot
 FP2LeWPf7ca5kwdW5+pYHlkPmlp/kHYi5X2QqpRT6b5vNoYHFhLvzLK2ZiZClXWFqoWzIU9Rx
 t422Lvn3PYoAlPtXbebu9Q29awgKKGVX8PlwYjfBslB8UjKuu6D0IdrQksM39SjMvEEyIpJqf
 df+llOs+tCqVuUmh2OBGU2BHND2XD7c241K6mRdfUabesj5VeSait+yZbTdOKnj6xxmuylkW0
 T/qaDosewADlceeaCQ4b78ZDZ1uMgI2mee0hmpwkdaNQgNxU71oXE5JuKOGiUXUdXIcj5EjWc
 hwS29iIFYzpwqIu39tHyUyE5TJqVkDtTVyMaOKndYoNZkrh+IyhVH12ZQVXA79jS3W+fAq7N9
 YgHKtZe8LOroZ1fuq8au+0FjSa31DIV4voqyxuXEDbHLWX7Bm4wuOJSveZzH/HXel9AOEorbl
 WhRtslhyAOKKpn4yquGYw//1Z5oHUZvXEJACpNUD38VfiSxvPV1h8
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 21 May 2019 08:15:29 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 21 May 2019 08:15:25 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Continuation for a code search after a common SmPL rule?
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

>> Can the splitting and recombination of such rules become more convenient
>> with extensions for the Coccinelle software?
>
> In general it can't.

This feedback seems to fit to the current software situation.


> Coccinelle doesn't have the goal of minimizing the number of characters
> in te semantic patch.

Such a view has got consequences.

* We tolerate additional characters in source files according to
  coding style variations.

* Some source code duplication can become questionable (also in SmPL
  search specifications).


> It has the goal of making readable specifications that follow the structure
> of the matched code.

I hope that this approach can become easier and more convenient.
I got another idea for this purpose.
How do you think about development possibilities around the following
software extension?

Additional key words would help in rule headers of the semantic patch language,
wouldn't they?
* prepend to
* append to
* enclose

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
