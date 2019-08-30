Return-Path: <SRS0=vn2d=W2=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810FFC3A5A4
	for <cocci@archiver.kernel.org>; Fri, 30 Aug 2019 07:56:20 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E619D2077B
	for <cocci@archiver.kernel.org>; Fri, 30 Aug 2019 07:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="r1EVH4n/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E619D2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7U7u7Mq008153;
	Fri, 30 Aug 2019 09:56:07 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A48E47790;
	Fri, 30 Aug 2019 09:56:07 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id BA10374B3
 for <cocci@systeme.lip6.fr>; Fri, 30 Aug 2019 09:56:05 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7U7u3QO001239;
 Fri, 30 Aug 2019 09:56:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1567151754;
 bh=s9u2EPUofVqx27UxSHzIUsLPo1MD9gpODPwaSZ/jh4M=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=r1EVH4n/cMNNMpvUjltkWaTULHeSzNg8A8DAU45rquHPJ1W5axb6TIStP3UOlYQ00
 /i+etfRaqt1eNNus8KRnYI8jBx9VBOVKxb5Xu4iZ89K1uCtKGkL17z1uojB2bw/U0r
 k0+1IJSL9IlIK8XwvB06ZTlgFNwj22hziunpxVrc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.166.132]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MLxrY-1i6tYD3Bvw-007jid; Fri, 30
 Aug 2019 09:55:53 +0200
To: Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        kernel-janitors@vger.kernel.org, Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>, Joe Perches <joe@perches.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix
 <nicolas.palix@imag.fr>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
References: <20190825130536.14683-1-efremov@linux.com>
 <20190829171013.22956-1-efremov@linux.com>
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
Message-ID: <3c0f82d5-369a-1493-799e-b201a28aa671@web.de>
Date: Fri, 30 Aug 2019 09:55:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190829171013.22956-1-efremov@linux.com>
Content-Language: en-GB
X-Provags-ID: V03:K1:DI3FpTUC8uJKXTMgrKvcNpG+f2zb74VA2THgSRGNXEWfvqqjlpV
 3MP6lIEhbsI0D+uSpOA9yq3bRWLbdpsf7j0V+g7g7FD2IpYpHipDeVp4LflL6Q35nwydVVp
 9jFWeXRTWCVQFzfQbb7+3nrAOo40BW/eYFHfXh06acL7QnVpt4m7iTGhOwdQyEB9g0ogZew
 rbbO7ksMLFfPWIGR9UINA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cl/38dEW/ng=:CONj7+j6AjsRnOcfIyG0DU
 tLQVIlnKm0uPp2KMO5pkkXhszmdn6r1sH+0gAstjJzckszhlqEcyFdri/XF1A7IjxsURXamj/
 xmmE0Q4bbkA3LVj9Yj0CVoq7SuPZPtMA44ZSb+MyIzCEZ8BykMPV4LoMfgZ4X+Ev7VBSzDVKh
 gSFZ80OPmWW+Db7lZwhw8kLA06BcaOUSQer1dtdspdX9poWWItKJTfP0IJQdtFw6FYC1yfK5l
 nImEhXNWD+BibarsTkmAM//fQjeoiTu2TrHOVNo7bArWSuoVVriMeVfmocVVFuBVVW8JI19xa
 cfd8WnCXUd1JbnZeZWWTzLRGYSjRTAh4yRhzDyd8vvD4H893kuGlmrxRPCdScH2Ek6HWFpbbZ
 o2jNKgyc3qlVYiTRAooDy+PZiomw+XPx3GSNXywkfzOhjISfF/mRCdzLaH42pHA1xHO42oYMl
 UZpSVKIJKXVLnbp7ghSZy6xM2dR19ROo80CNjSxYN/ELjv4PvNd/q6Vfrosf5AHTp2S3EhXh0
 ybe7NsWCZXwQ2hhkA8x+8/Gs6zeSM2H8Dws9p5gf3IJF4mmtVo+zVuOQH+Ex6zA7Ipk2KctW9
 bMCWB91LdJDbFZNTi40EADSLsLCCXyRaXPz3zJbqEWH1lVPOi3kRzDccos/jCmLD0Rns2TpV3
 eoAaif9bp7D34V4qdPv3rmH6gw4pS2q2lMOASvDsmMd5G/BpeksQfibgi4kVsDglaFV7s8ns7
 1xrHzegFBaQgNIcnFIS3OvMc7VY/0FCQjw55zPQg3cFVzX/96fn6LQTIGgjBUFusAsoIIh8Lf
 in0CG29doHtIWCIngyPllt+1vxsGBrLUF/6jWhdDdkbzKnw4rG1V3VIOVYiQ3nIGonxZWTBNI
 T3R/XwCf6bTVVJez/eClRMTrmFNuuEyC9HGqKYnpg//Msv+OkQbMkZpnevQzfTJ9UekXvsVaj
 +XhiMTUUd3q+g8WEQKG63U4Q2+W9PQKDMwwTwnFsaJl4J1alTwzW9Ml5G1HCSlc/yXyQ01dwv
 jAMTuyHxhRUMHQ39tO2uS5dTiaCe8PeZLOzkrRmrQa7SJ5yRjG1IX98LCy5LM92qLnbd4+b1J
 PzNB4gak8em/ky6lAd57IZRZuqLNq4Ct3xVOAGSa7UiYHFUWCQdDSQVPGY7Oxb+9KYLkLQtyP
 srQpXZ0yycVhQmasY2To7pblCCk3SL/7UlgPxW85eY2mZTrA==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 30 Aug 2019 09:56:08 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 30 Aug 2019 09:56:04 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH v2] scripts: coccinelle: check for !(un)?likely
	usage
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

> +/// Notations !unlikely(x) and !likely(x) are confusing.

I am curious if more software developers will share their views around
these likeliness annotations.

* How much does the scope matter for expressions?

* Are different coding style preferences involved?


> +//----------------------------------------------------------
> +//  For context mode
> +//----------------------------------------------------------
> +
> +@depends on context disable unlikely@

I wonder about the need for such a comment when the specification
of SmPL rule dependencies should be sufficient.


> +@depends on patch disable unlikely@
> +expression E;
> +@@
> +
> +(
> +-!likely(!E)
> ++unlikely(E)
> +|
> +-!likely(E)
> ++unlikely(!E)
> +|
> +-!unlikely(!E)
> ++likely(E)
> +|
> +-!unlikely(E)
> ++likely(!E)
> +)

Will another variant for the change specification with the semantic
patch language influence corresponding readability concerns?

+@replacement depends on patch disable unlikely@
+expression x;
+@@
+-!
+(
+(
+-unlikely
++likely
+|
+-likely
++unlikely
+)
+       (
+-       !
+        x
+       )
+|
+(
+-unlikely
++likely
+|
+-likely
++unlikely
+)
+       (
++       !
+        x
+       )
+)


Can the use of nested SmPL disjunctions help here together with
an other SmPL code formatting?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
