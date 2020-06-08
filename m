Return-Path: <SRS0=02ua=7V=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC45C433DF
	for <cocci@archiver.kernel.org>; Mon,  8 Jun 2020 19:07:35 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E22902068D
	for <cocci@archiver.kernel.org>; Mon,  8 Jun 2020 19:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Qd5wYHEI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E22902068D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 058J7WOq025829;
	Mon, 8 Jun 2020 21:07:32 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 565337783;
	Mon,  8 Jun 2020 21:07:32 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id EF29F44A7
 for <cocci@systeme.lip6.fr>; Mon,  8 Jun 2020 21:07:30 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 058J7Tu8008189
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 8 Jun 2020 21:07:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1591643245;
 bh=yMNv55R3ChhvuiGrHJWXjRVpsTrkBrcBvJI/cFCTIfs=;
 h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
 b=Qd5wYHEIMgkqs4AOs7bw2L2sm8lJcR2zITY7JMQJHfkUDYyHxJsrUTjenII7La3Gs
 eBY1EWdhmCrODnA18mfmI1JYcalL5+GweWfL16g0yILv7ENTH2LcBP7Y0AzHvj6yIQ
 Dy1ZDGNFjNbQYfrStr1XnSqtwoFu9py4kbNRfg60=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.116.236]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MYNzx-1jVZK023pR-00VA4y; Mon, 08
 Jun 2020 21:07:25 +0200
From: Markus Elfring <Markus.Elfring@web.de>
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
To: Denis Efremov <efremov@linux.com>, Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
Message-ID: <d1034b7b-12f9-a4c7-868e-1579668eb73e@web.de>
Date: Mon, 8 Jun 2020 21:07:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:cYnxsQkO1aXo3y9ZNjHHHVU0j+HeI/Vjd3e/5gOAzprRmy1Z02p
 pMCBTuq1jvaNK2jp7jDP8FceAhG36YDcIXTSk6wtr+4vY1Amf/VY2VNjKTiQqJC7Df3F1t0
 mbE29Nkvtv3ccmdnMnAgWpLLlciX76Sd6x2hVaifTElJOyO8P1Di8ijFkIFgd9COGHXiVnD
 66jXpovAn0VQRl6oNqyaQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:a1cZYUEt17w=:5/h375XFg2dE5T9Qql4Usy
 53DVRF2UaOZGcVSPqFjsntwuWwwkw08JEekcRBxaIcevDknV0DQPKkTUlKVbzMYIXXlKpZOp+
 OFAspUdbqST2DGuV4FOiA7XXufJ1sGUOhRYzZLUBrE4Vb8E6HQFSyYmU7d1xPV75y1LCw7oek
 qjOFo8W/XEPYPnauj/1w9EFmhMrHwWCDlaCMXYpaaMW6pVBq4em0Fguv7HyDcLPS9j0fRo+B2
 1aFpUJ57W9otaByWKe6PmzAH6jPcb7iofP1BeXUxmKiLzNafnn6UGCUtnUsP26BO2v/YgPtP1
 /SkiOeVJZHcA5TLpvOFyzC3HXlyvE1RHNLeopJ+8xpgux066HvEGXBMlYx6ASAodzij+2/XS2
 tv/8JFynujFtFQ6lBzIFzt9v43cnOk0Z7QGTjDKq1RPyGQJrXlysdhzW+Qq/anc2a6n75HQ56
 6edXc3WIAroSTurHqaMTTOvIGl3euGpQ4Doc1ZaIOfUzWp7jHG5Ov3h371TLWcV/qc7QeqCYv
 qPWshpzAMnWjALnemTl5Ca+SsBevZxauwk8ps+pUdjgc0+x+7f6A8UVJ5yHoe4T1MtpbcOyyI
 z/c8CZxGhai+9zPE6nTAcP2IYtzITdsQCcnbXPAS80evUsDAo+Zx3+AQatv+Ucj5MuDmMccf4
 0ME1xO5R9O5tBgKmU6Ia05AztB8aDF02LcWCMl/JrDW+Z6mRDJdYWz0uLeYfdo7hPdEHO/Dtb
 76gK1XA3+0uLyrCWoFdA7/HWAFtvzhB+0esnxoj7QaGxUlPxgYqasdV89EH9h1pP5+FgpQJi2
 MxipkgFs8d6Ym0Jf8y/Atmf2QQzvWXBQeucUun6wWj55EuhlhcSBbsN3MaxF1okhz4qGkCVP3
 R8nYvKDR0jgvrYXCCSrhpvDeryukiVZ2M2VtcfjAzE2C2QXKQhPhzjSuSVy9jhZyJZCIVMhHj
 OTsUEYKsp65ZhsKEtJE2RzFUMwpgHfjha3FM0E0RKlG2yXhue7VswxyP+YNj5d7dkXcwRy0Nd
 tisnJJ0U4XirTU1EdI+hVuBsUn4rhqWvbniKqHbg39Zq0+Q278vYsLTQtkFgnZwaVDtyWoXYs
 Jwe7x8mTHFG5bTOEbNQf8s4NYHKKTfVKwO099CphmuUMIxbd6WiTaZSamSeaLwQ1bPJkqE/HN
 njIXzgiMt2LPBrVVcVTbRqTKAYk79Y+y6JC2yg/axxxoJszeACVO1oEMR3Ne/kkytgjVQ3Pgk
 F6Wl7Cr4FKFrRiEwY
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 08 Jun 2020 21:07:32 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 08 Jun 2020 21:07:29 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH v2 4/4] coccinelle: api: add selfcheck for
 memdup_user rule
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

> Check that the rule matches vmemdup_user implementation.
> memdup_user is out of scope because we are not matching
> kmalloc_track_caller() function.

I find this change description improvable.
Will it become helpful (for example) to mention that you would like to
add another operation mode?


> +@finalize:python depends on selfcheck@
> +filtered << merge.filtered;
> +checked_files << merge.checked_files;
> +@@

Are we looking for better software documentation for such functionality?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
