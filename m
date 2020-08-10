Return-Path: <SRS0=13qy=BU=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3084C433DF
	for <cocci@archiver.kernel.org>; Mon, 10 Aug 2020 08:25:01 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36126206B5
	for <cocci@archiver.kernel.org>; Mon, 10 Aug 2020 08:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="LGHC5jtE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36126206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07A8OhlX006992;
	Mon, 10 Aug 2020 10:24:43 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A36BE7780;
	Mon, 10 Aug 2020 10:24:43 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1C69C5F8F
 for <cocci@systeme.lip6.fr>; Mon, 10 Aug 2020 09:30:43 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 07A7UdqA025431
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 10 Aug 2020 09:30:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1597044623;
 bh=Mrds5nFat2EZG9gj7O45TJQ3YbOf0IbVOiYoKKCvYOQ=;
 h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
 b=LGHC5jtEU78FVro67mbeAnulR/36zf0fqPXNKUL0AGTqxPz/LF4EEO7Av71x60AQn
 1Cy+2EkeER42KiltNtYSADj8s7/mT5a2TLjlyYhEW3AwDSjvZxwvJD0YPLo5/pSQxq
 tY1zHscj/sSX9Fr2U365vG9FFIeo8ZDqMq/kH/IA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.64.233]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MoecF-1kTKKt337J-00ohsK; Mon, 10
 Aug 2020 09:30:22 +0200
To: Sumera Priyadarsini <sylphrenadin@gmail.com>,
        Coccinelle <cocci@systeme.lip6.fr>, linux-doc@vger.kernel.org
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
Message-ID: <ffe8c50d-0bb5-9477-a20c-96aa7bb45067@web.de>
Date: Mon, 10 Aug 2020 09:30:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:4BcmFblahuvFfP74NgJG77pNo/6cKTsrGW6uT7d43CNwbUeitt6
 NtmQBMvqmggi+nI+1yWae/EkuEC9fhfxyHvRC18gj5r17uOjFiavQpDtEV0/jiIp9I7AapA
 ygmjxuaPixmjnVqj6FuL+MrhbymZN2ObTwykW4CorvYpvMCRDOwDNf1seAAtbDVy8tmaNNd
 uJCoFxW79///06SucDkPA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:f7srSnombO8=:Aq7scJWjAbsRb6SNSBkJqL
 yj+CfxKdxzceQ/euA2+ND9jnQndLyNMAlteg0CilVJTba2l2k1h97+GTekhQoqYu+Y4xGt38O
 8L/w7z8fh0vbrEFRpimeB4WhSV0jrDIzqIgmTJQXmSjTvyGK4v8hflH753fvqHoHzrb6sWJH8
 qnSAwMvwQ+srk+jLTXSLSTH+Uzg2rZ84J3MyRkEef6kIlWcD+X6FfT/qYKfAVVtywRhTXwiLl
 RDIes8u9vts0h6J9AzDaXlqc0/Z9hTfE9wXtBqBjx8HZ4dCylQhIqb//jwSxCi1yzrb7aPn/a
 Su4wjzGmUMTH62fNl95B4ubtEQyNLHR8lUfjVuUdmxR9lax5Y2XbkW4LBrE0dSi8ewLrFLsWZ
 T1nZbAUOvbkiVOyEPEGQkVuIyyeu4KJrlAqNPRm13pBYWDcLk0095pxjxYbWvQedbun45hDD5
 egaj6S3V8YZ+MZiyl9bWtAm9yrPtH3MJUMU+EH3H+Pmg4IAjGvP6gPHWXGRU/vbLhyU/wAstB
 HnVrHBZd5kuASZnuyjJ1+BiknXuJoBNT9U2Bat+7twESLWqKmxE0ELF9mfwKvuXh8/AEtrjj2
 u2EkWg8StyVy4F6qYMm4UrPMZkoBhT/ant5FV1h9mBUNIKDePBmir+mf5mZLIyATrSTseBGBS
 p++u1l5TS9+h//w57Q2/C1gkSdCabhikjCF6zaWP/e3IDOM5n68LB+Gatb2LIN//iT559dIvg
 hpD1UXx+CHbTFdtelWDcvdEO9jOa3z0PRKa1aSipxPk+BaWJWUF+qErkoYf7wtx6TXuoAqsCj
 WTN+Ul+rMP+qcFEocGXOqTjpAWZPF5612tAdr+lSRSQkjM7OwF8hMNxpzADQBXvoBe8BXhlAs
 OJqBvi0RFYaoajKvpl+aTO5C7rsqL0drh97OAV6ncq75KZNvZtQsaMIdONdU3t52ojJh2kKjx
 6YTPbG7mMdaswYwqqElyK0J32R95HzVIv29N9Twn/g2WSa3RBdTjpm6X60iR+lugGJIJWcnOc
 pNWsJ6uqA+vIokxceuMrVNm/iwBWbIEK8Hc+fn+TGoV/SU9sMROlh5BIs/HejSojyTwDtHtM3
 3m1N6zafUIqVa2QvyBCcSUYKPzTXfu5EDaXqT1jKgw4hk5yI4/+Wx0F3QdqNpVtOMTwNf0sWK
 Zc9pmUiJzY2/te4ckYzRqMG1DHC5h7fd8b5LU37Mbdsz7vd8QoNU3fAKV8zgTCuWpdxQ1s0V1
 KLQqWnPmzzsjZiFx9RWepX2UhJU82xX7EIn9Now==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 10 Aug 2020 10:24:44 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 10 Aug 2020 09:30:39 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Mon, 10 Aug 2020 10:24:42 +0200
Cc: Michal Marek <michal.lkml@markovi.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Nicolas Palix <nicolas.palix@imag.fr>, Sam Ravnborg <sam@ravnborg.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [Cocci] [PATCH v2] documentation: coccinelle: Improve command
 example for make C={1, 2}
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

PiBNb2RpZnkgY29jY2luZWxsZSBkb2N1bWVudGF0aW9uIHRvIGZ1cnRoZXIgY2xhcmlmeQo+IHRo
ZSB1c2FnZSBvZiB0aGUgbWFrZWZpbGUgQyB2YXJpYWJsZSBmbGFnIGJ5IGNvY2NpY2hlY2suCgpI
b3cgZG8geW91IHRoaW5rIGFib3V0IGEgd29yZGluZyB2YXJpYW50IGxpa2UgdGhlIGZvbGxvd2lu
Zwpmb3IgdGhlIGNoYW5nZSBkZXNjcmlwdGlvbj8KCiAgIENsYXJpZnkgdGhlIHVzYWdlIG9mIHRo
ZSBtYWtlIHZhcmlhYmxlIOKAnEPigJ0gZm9yIGNvY2NpY2hlY2suCgoKPiArQyBmbGFnIGlzIHVz
ZWQuIFRoZSBDIGZsYWcgaXMgYSB2YXJpYWJsZSB1c2VkIGJ5IHRoZSBtYWtlZmlsZQoKQ2FuIHN1
Y2ggYSB3b3JkaW5nIGFwcHJvYWNoIHRyaWdnZXIgdW5kZXJzdGFuZGluZyBkaWZmaWN1bHRpZXM/
CgoKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVGhpcyBmbGFnIGNhbiBi
ZSB1c2VkIHRvCj4gK3J1biBzY3JpcHRzIGZvciDigKYKCkkgZmluZCB0aGlzIGRlc2NyaXB0aW9u
IGltcHJvdmFibGUuCgoKPiArVGhlIHZhbHVlIDEgaXMgcGFzc2VkIHRvIHRoZSBDIGZsYWcgdG8g
Y2hlY2sgZm9yIGZpbGVzIHRoYXQgbWFrZSBjb25zaWRlcnMKPiArbmVlZCB0byBiZSByZWNvbXBp
bGVkLjo6CgpXb3VsZCB5b3UgbGlrZSB0byBkaXN0aW5ndWlzaCBjb25zZXF1ZW5jZXMgYmV0d2Vl
biDigJxjb21waWxhdGlvbuKAnSBhbmQg4oCccmVjb21waWxhdGlvbuKAnT8KClRoZSBtZW50aW9u
ZWQgcGFyYW1ldGVyIGlzIGFzc2lnbmVkIHRvIHRoZSBtYWNybyDigJxLQlVJTERfQ0hFQ0tTUkPi
gJ0uCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZh
bGRzL2xpbnV4LmdpdC90cmVlL01ha2VmaWxlP2lkPWZjODBjNTFmZDRiMjNlYzAwN2U4OGQ0YzY4
OGYyY2FjMWI4NjQ4ZTcjbjE5OAoKVGhlIG1hY3JvIOKAnEtCVUlMRF9DSEVDS1NSQ+KAnSBpcyBl
dmVudHVhbGx5IGNoZWNrZWQgZm9yIHRoZSBzZXR0aW5nIG9mIGEgZmV3IGFkZGl0aW9uYWwgbWFj
cm9zLgpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2
YWxkcy9saW51eC5naXQvdHJlZS9zY3JpcHRzL01ha2VmaWxlLmJ1aWxkP2lkPWZjODBjNTFmZDRi
MjNlYzAwN2U4OGQ0YzY4OGYyY2FjMWI4NjQ4ZTcjbjk3CgpXb3VsZCB5b3UgbGlrZSB0byBkZXRl
cm1pbmUgd2hlcmUgdGhlc2UgbWFjcm9zIGFyZSBhY3R1YWxseSBhcHBsaWVkPwoKRG8geW91IGZp
bmQgdGhlIGNvbW1pdCAwYzMzZjEyNTczMmQwZDMzMzkyYmE2Nzc0ZDg1NDY5ZDU2NWQzNDk2ICgi
a2J1aWxkOgpydW4gdGhlIGNoZWNrZXIgYWZ0ZXIgdGhlIGNvbXBpbGVyIikgZnJvbSAyMDIwLTA3
LTA3IGludGVyZXN0aW5nIGZvcgp0aGUgZGlzY3Vzc2VkIGRvY3VtZW50YXRpb24gYWRqdXN0bWVu
dD8KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcGF0Y2h3b3JrL3BhdGNoLzEyNjA4MzIvCmh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMDA2MjIxNTQ1MTIuODI3NTgtMS1sdWMudmFub29z
dGVucnlja0BnbWFpbC5jb20vCgoKPiArICAgIG1ha2UgQz0xIENIRUNLPSJzY3JpcHRzL2NvY2Np
Y2hlY2siICJkcml2ZXJzL2JsdWV0b290aC9iZnVzYi5vIgoKKiBDYW4gZG91YmxlIHF1b3RlcyBi
ZSBvbWl0dGVkIGhlcmU/CgoqIEhvdyBkbyB5b3UgdGhpbmsgYWJvdXQgdG8gZW5jbG9zZSBhbnkg
ZGF0YSBieSBhcG9zdHJvcGhlcz8KClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lz
dGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29j
Y2kK
