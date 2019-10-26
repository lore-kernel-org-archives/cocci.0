Return-Path: <SRS0=j8Co=YT=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A09CA9EBC
	for <cocci@archiver.kernel.org>; Sat, 26 Oct 2019 13:18:36 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACFD62070B
	for <cocci@archiver.kernel.org>; Sat, 26 Oct 2019 13:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="agfLHx9X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACFD62070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9QDIIXF008120;
	Sat, 26 Oct 2019 15:18:18 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 051D277BB;
	Sat, 26 Oct 2019 15:18:18 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id BAF6F77B4
 for <cocci@systeme.lip6.fr>; Sat, 26 Oct 2019 15:18:16 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9QDIGEK008090;
 Sat, 26 Oct 2019 15:18:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1572095895;
 bh=E3iOcUkdObyZnG6eZgxSQjI6HfxbYYh03Eq8U9McU5I=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=agfLHx9XjwYOzGfUj/d2xwGhytcCpP21IaGjnmtv/v+erwMWoHVrZV+fpfpXj0hBP
 VuNQaPz8IjEwgSS2PKnvZb3j/TpiJiLiD/+F5tVYBmGX7pXgHhPM/RjzYy/85nZcUl
 +JCXs4wUM+A7cXEgEqrmW45FuPktY7v36oIZqjKs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.128.16]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MGRdk-1iBCoJ2CCe-00DJly; Sat, 26
 Oct 2019 15:18:15 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <384c6657-5ddc-ff47-14e2-2ffad31295d2@web.de>
 <d7b9c6d8-8b67-2a05-188b-0b1b6b7ebc2a@web.de>
 <alpine.DEB.2.21.1910261444480.2764@hadrien>
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
Message-ID: <962ec920-eaec-3461-e400-95eb67623749@web.de>
Date: Sat, 26 Oct 2019 15:18:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910261444480.2764@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:0uotA+d5FfWlFA9SusiS74P/BiM4q19aZ+AbQtsqy6mkp3mU7qz
 /rUdPsRcM+eIaoSSHLpgcjuVwWpBlnPlRAqx4kONS1wLMct+qEMiBohoQgIRrwKVo02oc0F
 VUPbedVj64NWxLt6tRWVeuT46iPMvNFG8fdx2iXoWuv0i+L2hVh14ETFqH+PR9aX+Xhtzo7
 QxT1/ck/qn7c80zkB5P5w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:O6Dgq2MuH9o=:NpY4Ow9H0ajz9IvK7YhKc4
 9a8UYDflrdk/0oIxVYek141jiuohYPcIzGCRESh0V823ialEv9IFq1zcZHKinOj1tMXbAApZ9
 30O74XcRkz7ua9LkTqkmiwMJKb8R06DQxARNmphkB/2MSZHL4c60jkwdGQGPTFhmh5FWzGncG
 K1+Or8BT8YUMMAyAPenevCxwNel42CG7WIlF184yWLc+/pFjUq49NxyWBgD6PawlIGVJNghrA
 B0ZJp3aXf2tO/9mF9vYbtqAbST83efJy84SR1lZdaDYkUQhbHGmcdCl8OXql119JDYHg2yOYk
 Y8I0Q7S6RFNukizggv6mk+5nX7iRkZShL3NURXWOgn0PUhwP9kZv1N11jBzv6Q2DNp9Hy/ryD
 /XaYMUD/Y9hXjQzABIdbQFbx9rdd44KYlgbpon+QPWdAaQyBB47n+EX54xg7t+nj2JhJvNsRY
 F6eaWbAQJMndtORyUCu9dBOlqXWRiswf7RDrpEHc2V96cae8cfUDFPBeBvdMSZ88u0Vue00uj
 6Q7EL7Q4bTfR+lJwt6PNL8trKAfXxu1xG5QefcI7otzddgixnbVBBnzGXwFpKbTBahg4P0Pyo
 kskma1wFXSsl1NGwmaU9I6TOqrjAp85VZOhbTbbK7BDcP9JdhLFB91b4eTqxmIfwSF2kKDdLM
 J+tdUbv2rNtrp9MF7I64CbJZldbguG2FCT/TjBaQ4xh11l3nbBmu1wabD+mNQ7D2ynVakuDtE
 e8VDJ+bkAIk2bdx0GSkrlxduRome5XaKAHuVM/XoUxP1vaH8xNhXmZ7v4FiJPEN8Ysai5o1Ji
 No6jXcH+l6p2IOoqEDxxShW+4R5oNu8xnNX38xQzAygnszZ0rpnVHJYtc9hoAUinLgSjLvgzP
 x/V66jilrLpmWkcqmAjv4wdwhGnZKXntNvYRwJ2kl+ZKRCHZnjf/w1IZK6Hy17v0P3o8VLGF7
 E0ID2coAbChmK9H2hi2cHpym2VIrppuDvtXDlRNmTIlMtOrE/oQHH/7mBS1qHR4cEcWHezfaY
 iNY20QjmZpfTxwX6giEi6AoVcVoUaXOAptZpCZBqWROFomxemPtqEHri71JIemO0vqsIP3wsp
 5JEwQA8d1JPVpmSMkkKuQpUYyHHo1W8n0RvBbNvuJ+yoGXN10t2dauvSuA7coGpz5GzAnxJWD
 LyazX13zOEsZd4JrS8/qjH/W1utZCRnmjK3/GLQf/aynIYGGMhXPlHdMxgagQnqES/4v6AEeQ
 EQn4OJJjuyi7X08sx56EOVayNuY+DHFFSeYfaBx/ws/FZinyzgTaSzLjToyY=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 26 Oct 2019 15:18:18 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 26 Oct 2019 15:18:16 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking placement of spaces for code changes with SmPL
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

PiBJIHdvdWxkIG5lZWQgdGhlIHNlbWFudGljIHBhdGNoIHRvIHVuZGVyc3RhbmQgdGhlIHByb2Js
ZW0uCgpQbGVhc2UgdGFrZSBhbm90aGVyIGxvb2sgYXQgdGhlIGNvcnJlc3BvbmRpbmcgY2xhcmlm
aWNhdGlvbiByZXF1ZXN0CndpdGggdGhlIHRvcGljIOKAnENoZWNraW5nIHByZXR0eS1wcmludGlu
ZyBhcm91bmQgYSB0cmFuc2Zvcm1hdGlvbiBmb3IgYXJyYXlfc2l6ZSgp4oCdLgpodHRwczovL2xv
cmUua2VybmVsLm9yZy9jb2NjaS8zODRjNjY1Ny01ZGRjLWZmNDctMTRlMi0yZmZhZDMxMjk1ZDJA
d2ViLmRlLwpodHRwczovL3N5c3RlbWUubGlwNi5mci9waXBlcm1haWwvY29jY2kvMjAxOS1PY3Rv
YmVyLzAwNjQ0MS5odG1sCgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUu
bGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
