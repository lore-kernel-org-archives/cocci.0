Return-Path: <SRS0=zifB=ZG=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F53FC432C3
	for <cocci@archiver.kernel.org>; Thu, 14 Nov 2019 07:13:27 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0EB9206C0
	for <cocci@archiver.kernel.org>; Thu, 14 Nov 2019 07:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="SwNqmT7f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0EB9206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAE7D2hW019767;
	Thu, 14 Nov 2019 08:13:02 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 80B8777D4;
	Thu, 14 Nov 2019 08:13:02 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A641F77C2
 for <cocci@systeme.lip6.fr>; Thu, 14 Nov 2019 08:13:00 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAE7D0IZ004316
 for <cocci@systeme.lip6.fr>; Thu, 14 Nov 2019 08:13:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1573715580;
 bh=WGmXHzCSzxoDuNLtdzBqqJ/DynDg5hU7cKyqYx6NiEU=;
 h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
 b=SwNqmT7fjlpy2ihl2kZx17/6OkiizTfuK8x/f9/mPj5oA689jStf7+GcCTIIQ4H3t
 rkVHRq+j1dhkanKWkC9HKKHJVa36P5EJ0xD5OenSrX3CUXKtTan7+YHd3x02PHJPED
 UtjFpQifhGehVkNhlxU9Gv3pa06cTxhTAamRT4Bg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.120.12]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M6ml2-1hhQP13NZM-00wYFN for
 <cocci@systeme.lip6.fr>; Thu, 14 Nov 2019 08:12:59 +0100
To: Coccinelle <cocci@systeme.lip6.fr>
References: <12ee1bd3-9849-ce84-f03b-104b1c1cc86e@web.de>
 <alpine.DEB.2.21.1911120524180.2536@hadrien>
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
Message-ID: <162df2a3-b989-c244-0fa7-f26596df7722@web.de>
Date: Thu, 14 Nov 2019 08:12:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1911120524180.2536@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:9J3u4ocy8/i0st87ubLTj2kCuMYxwcbpFjGA93TIKwqPuYIbLNU
 CJcuhSarxL+iIJyrksfz2X4TH7ghCr/6zbbQhDCqpBuUv0T0jWo636/COLD8OhrggiPCt3O
 XOeljRFUhXjdAjrkyNqoFbjfitFWjfHz26BeuXnLXgkt8YkyrrC4gWGn5+H3bTK2NEFwG62
 IAzl0XO4WvkifnzSeGDsQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CgqZ2lGpVVk=:EPADX7vpkCfFZQiBBSp9Wz
 rxStEnK0+g3h4AmNpo0BSSGXMlEWfpzD1K2rwy4E1zCnLEJVSS8UNFDN1IJ02dbzPP1E8UsFi
 5ue00P2vmNEQv/a3UUsl5h7Scu3e68AGn6DaLhWTlTU5Ue4CkLNPJ8czrtz8NluX+i57CietN
 6TqHf5flVDAEU3Q08LADUBl/OdTAUovS4m6mWylOPcUsZm5BmcQm7BqI4JPkVu9MC6zHFr8p4
 Hw/tzeSt8jmt2uIPqYx6GswrUouCoVfbYf4vE2s88PirzN4gGB0q/7fxeP1aoLBspLTX1iAnj
 V3F2A3aUdMIWU7HN4z8fk+IV/rNWB0JOVkmYobdvF1DKI6pGMmLusrM2vsbGQGgv72eaxfRug
 btQ/SGEfIicdJNxV39gx66C/HxlbJpzNziP16wrpRcVhsn2/8ZiP8v6jkjCY21o46lu1XN8Kb
 /c2+IRgc0cO6Wt4SjyzqbhXBpMMZ3/BFZvifn7wzK3+uZuQsS9AGjQsh0cdj97kGa+fvjHbJv
 WT4mzL0Jr4aC1QSBJqS8ezlEnPwz3RmJsWXRDBlHJ0bH8RAUUY6DV62BjdSCZC/XCpRpgfRhZ
 o5JJxnFdN1iklMe27GcdILnjsAv/GX6IWuM4gsfuj9j3vSdNyQ+lecqknPbZ+V4N5cv1wM28e
 hwLuP3jp1zVlLnFERTU9YSDGkTcwZN+d4Dhr+Xk8QkZ7u+/QorLLsIt/F7/lCXjIqlxY04txE
 1Takg0m1aO2BPClpOtcaXtuJNT7UGG/OCM2PoBAT/4ta3J8r6O0duhiAGAPFLqRpEHE3zOcwh
 KdjSnB7YyeCTvSsfzIuGa3slrOMFqVlCg4xJdTGwkpJ62JUcd2KnahOkSixaRImndYCXi4riC
 /NUBTs3B+XDKdt0OK9Q4EEZdkeB1ER5PQz966seZsmClzvQMv6zN6OpOHqnepV+Ovmw2uVfe6
 cUrgl/fqQWTrJSG8Imj2fgVTAYXcCG9iB8IOB5HttF0jRWSVPfeweAVHLRwGPwJojjJhOLZzQ
 quXN4I6byEC5FoJ0OHHjID1A4kS7MSVS+aSN9UOP0bbFxh1b8w2encZeqhckGW2oKgpYxEtID
 Ts1DHbL2tm7XiKGrllRxb8J6kW+9SVHtpwk/BVai0E0KdwsVbis2clOSjvY50Pp0tjUORcjgt
 oFhLMZsg/X6JTRB2d/JNrPt978UWtKpXwrB6GBsTGLNmXIVIeG2aljRstUUvOiRt2nIF0ywTR
 axT96B3IMzSZrPKF5DOptAY5Jgbd1++NhoH2Kjfsfad1IT5imq36Vs+WWIRo=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 14 Nov 2019 08:13:03 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 14 Nov 2019 08:13:00 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: Re: [Cocci] Using the same replacement for different source code
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

I am looking for possibilities to reduce undesirable code duplication
also for applications of the semantic patch language.
How much common code can be put into SmPL constraints for this purpose
(when the usage of SmPL disjunctions shows limitations so far)?

Example:
@replacement@
binary operator bo = { +, * };
expression x, y;
@@
+compute(
         x
-        bo
+        ,
         y
+       )


Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
