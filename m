Return-Path: <SRS0=71lr=7A=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC5FC433E1
	for <cocci@archiver.kernel.org>; Mon, 18 May 2020 10:13:22 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EEAA2070A
	for <cocci@archiver.kernel.org>; Mon, 18 May 2020 10:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="gl97vBCi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EEAA2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04IADGkT010556;
	Mon, 18 May 2020 12:13:16 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B21DA7559;
	Mon, 18 May 2020 12:13:16 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4C9FD3D0F
 for <cocci@systeme.lip6.fr>; Mon, 18 May 2020 12:13:15 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04IADEAj011940
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Mon, 18 May 2020 12:13:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589796793;
 bh=9E/HZQu50T9Og3CJEWq5MVmZA2T7nRyK7sZMoJ4BcBo=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=gl97vBCicCAaDY5gcGlgNRvSrMQ07Y3elujqbHYwCeYUpBgSvdPBR9jPppItalqNk
 dSwO7kUne786+wNjvCiIlOjzXSW/lD5A3s/uPx4t6nU7Lu9IIGkrwfScgQiDTzMCJa
 M/T38t6DxuXTzNRr3fasWGDc73R/LNj5jOtpgabY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.105.123]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Md6tr-1j1Hkh44Ad-00aH8F; Mon, 18
 May 2020 12:13:13 +0200
To: Julia Lawall <julia.lawall@inria.fr>
References: <4a677190-b494-138c-4782-eec033a77377@web.de>
 <alpine.DEB.2.21.2005181118540.2467@hadrien>
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
Message-ID: <0a93e321-42de-3534-9c4a-d67132a1289e@web.de>
Date: Mon, 18 May 2020 12:13:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2005181118540.2467@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:Pi+zS3iImfvsPkMZYC73MoWHN3RaA5D0KALdcClSX7zZ+AYQD14
 KWv/S9Qc4G3psuE3nJ2wfsn8A3Qp6M2Pez/+8j/Si8Ef/C1HWToLJ/J2csdXvCiR6klq93g
 FikwxPGCt/2Ni+oony/dkwKMCDIx72ar30NwIhL2wE709rzWq4HNB+sp3oiXmMzFq3TnCFD
 JLFInCXKA+sq3i+L8riEg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ze74xY2CQqA=:dUwQbmbzhkFj5kRdf6sI7I
 Gc7mIE+D8mg7Ldz3NrgJmEzl65ULoEU6dcS34HOhl/4xi7oX33QzRWr8mEGZ+xna+KudzxQfl
 fuK8EBGyzxiGSaMadMO3Nu5Bhv7XigpYOlMduENZhKePbI1OnK64287DJoO4rZmoosUCc+bTk
 QcesieYYyMrQlJ9W3PaR9nqVDNU7UzVC6DKTs1WMFfab1X1FY7a6dNTixtdlVrG+kZDgiWvgO
 hdgPG9+Vug/pmYS+1yXudWdY2bQ9TqWxwMOMtcH2A4eSV19GapvR/C0fzldBWtJh2uOywmBgz
 oVkFuIIIA5F8omfQOsA3pytL5J26VRj626y7WH3OtlKAVUwjQ6GDY0H8xDwPOiYqs2PEEBFwB
 90bGA2oYBsXeNSiVoU24kWHVnjrtZaDC2HY7tzHJprx9Xkb68t5zgpdEdty+vLK3YI3yaFiEA
 pDMUQt46RZIa+zws3jlzAPqz8bLxiqi1X+p3m0y8I068SxJQk+BaP/xLU/sUmOY9l3BGLWw8h
 Jp9k4AlX9bblLmhukrX4vcU0wI9ywXKrOqUI7ljQTrtbBcidyLm2pi+GBntA85nywVH0KQqp/
 bugW/XiOy1+IC8lY0JwLQBMfld7eF+qeXPYPKl+UXz0IfF+pn/kYyDcnDVBgbVdO/JRh4f0sD
 Z44FsIcPhMbWeA5kNUPTcQVtGy3Zzb5btzw3coUaNbLranfLK+gm9aUhTjjecOgePBakelBGP
 Vbol8Y+8Lz0LfhSecyw1qFvLpQ4MYac6fmloyAYgsTc9Z+zmsS10dgPNxlk5IeEmMUf6NqqsK
 NUrdVgS9W9UCNjZ7Bznz8MkqYDV9N09bK4jMQrrpeuUOMeba2c74pJvj2fCQqVIVIJRMxglIF
 MdcPRJ8Wit6f8+ByIS+jBMC5phOfKDiKKjIQPPso2rEgjz68m+jZJGsOoCrW6eNtP1RZwSuyj
 6ap7hILYR7wgEOzJYn3QymNb7ZKPf/IDOaLbbasMUPuGWxA0QPxUKu5AvAZntQ+7Ik65ilBg2
 TIIbhQm6hg6XH6QI7ZjAg95C0mtSA6cE7EbMKTYfT1SnvwvFOsqWErjEK2dOMfH/XCnRPCkCC
 5/OB7NnFDFLjwAQPZMxEVyizlHck4ePMlMsBQ6bAmURMd+GOCRfk4gk93oqcicZy9Z4iDDti9
 zwmSo/PTN/FJ75dZ9JWX6UyGZ3RZzIpid+VY7QEKMRxvqq5yoeP4P0E/yBqTEcC4/1vzSq//M
 CWe3gEl5s7SM7DiYQ
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 18 May 2020 12:13:17 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 18 May 2020 12:13:14 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Chuhong Yuan <hslester96@gmail.com>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] How to match function calls in macros?
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

>>> @@
>>> identifier mac,f;
>>> @@
>>>
>>> *#define mac(...) <+... f(...) ...+>
>>
>> Does such an analysis approach restrict the source code search really on
>> complete definitions for function-like macros?
>
> Coccinelle knows where the macro ends.

This is good to know.


> A macro has to be on one line,

This fact is reasonable.


> perhaps extended with a \

How would (or should) the Coccinelle software handle the mentioned search pattern
if such a line continuation indication was omitted between a macro declaration
and subsequent source code?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
