Return-Path: <SRS0=0+7Q=ZO=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5C8C432C0
	for <cocci@archiver.kernel.org>; Fri, 22 Nov 2019 10:00:51 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C97AA20707
	for <cocci@archiver.kernel.org>; Fri, 22 Nov 2019 10:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="in+lepv3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C97AA20707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAMA0X76020568;
	Fri, 22 Nov 2019 11:00:33 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 436F977E3;
	Fri, 22 Nov 2019 11:00:33 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 24D8177D2
 for <cocci@systeme.lip6.fr>; Fri, 22 Nov 2019 11:00:32 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAMA0VBa013322;
 Fri, 22 Nov 2019 11:00:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1574416831;
 bh=wQDjWXoQZSInzdeZZTFkUMoUsqc9BQp3eRNa0V2Rc8I=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=in+lepv3wrX8aVNI3YVSfDlz7foWrdEyjjN6euC6UJJnZ8LaJ3iadLs8Tz+JzKcFu
 krQWwrPHGUxQsk+2SzIQGFT1QCvg0Vpv7V+HzB/d7oeyGjvC8H8y2JvkWQYMwTnx0l
 8747DC6FResIcC6daHpflC2L914TQ3UsXi91koIQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.244.174.75]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LhNmy-1i36Uh0wNs-00mZSZ; Fri, 22
 Nov 2019 11:00:31 +0100
To: Julia Lawall <julia.lawall@lip6.fr>
References: <cc561358-4d00-9f1f-eaa2-8fae400ccc8b@web.de>
 <alpine.DEB.2.21.1911221025570.2793@hadrien>
 <8a44f286-72ad-14c4-6ee9-b8aa25ccba3e@web.de>
 <alpine.DEB.2.21.1911221050320.2793@hadrien>
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
Message-ID: <46f7430f-8176-27ed-1150-af9fc69b03a7@web.de>
Date: Fri, 22 Nov 2019 11:00:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1911221050320.2793@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:Vn+YEmOJAFm0CDtIMROz0MP/hffCUI85j2jYRHU87ZPxYq0Wj5x
 9C5sXR58WFla4HmvXllMZZlCc5a7mlH2ulH1ZGyIJiJlPGDKQjpmBpG6TJednHbKz+gYLU/
 Rn1ProtvlO9DUt2OHC6cxf8P71SXTgq02MWSQTFmu7dtgocsqgdjD8YySamvb/z9vfqqjle
 VkkHeDAn/Cpc3912/45Rw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:u3fJdxr8vI0=:8uyykHlPVnkd4K/qml/3+F
 9+0JG2gJNvW8Cl6SSPF0/yoQBY5VDfjYPSSJLbLULNbwnD/E1gE33WQWHAVdQHhopXJ76gmik
 GkMOzcSstcWitCUZdJxn8aIugDc6mCgBnXDwOIh/fBG2r/se0v58R5EEu5hNo65wYMgUrE4rb
 k5k19J+cOF4yfBH+uydxClX62pXQW1byoAuBwz8hh3BmO57ouTJmhxtExfcqtDOXbJ8mOwl+x
 2RU9Yvh9ywqSZjikx44n22lQz9vLDRa8tdKPdX8sWBYNMvtuikm0SlITfFU+XwxQlVtBZS3fp
 xAxavWgul5Z40R0mxW8/BJQlC79BK+BHopmMNZuIZmLRhmd4ceyy5aTqI3xkzpVOvH82GyodI
 erVbLwwAwWTvOHPOJtWtaAVrcNtFEVDIdfliXySPXFp6ImS+JnDYR8lYOlesmoJ1a4RMnhsAU
 wkwTpEtt//f8pVTbJl1ajLmonMoSFNSr0xHV5uqFlodHbEw4KmkhQzMVuiocqFvutX0C0mUQ/
 3bRqLcc7IOegUY72LP4xc1N8orHnL0XWIzsrY69jRyQ7l/zbDKaGTGUuyK5hrja9ZPF73HmQe
 cwN1B8c9yNyfDwSra9+39COIBjU90iTgF0Xoxib0FX+cLbub8SvYfREw+GSXlH9NUUxCZsRkU
 pwSG6RCKfM+waiUnNEjCtvbHBZK2kXskibpUGayz7BodJZcNOp81/bv8yWgKGmcFmyIXEgfXe
 r4kD/EhX1MO51z0JTD8k4+JhIDAdlJFLzHX/f58pt0x4b+PHdzQFuejAT/X3Sl/d/fx1kLZni
 /10wT3LPhs/wcpVR1TzFbhLU12pzhsY/Kns8O58jrjoF2JN/ehTlRq8ojX/az+qGhTbCK2Nes
 OndenVvMoPCLadUCpi4UcivMZQOhxXr6ExTsTP4AV8+0YV1MWJRTgQPh5HOwRgZfI30uicYVu
 nwrqvZ0PqStWlfcnWAcvZXVKeqqaUaG2NfpaMYKE+pJ6TkGRzQy7bP5caFOeDTzgjgBnmfV+k
 SadIVwdiHMsCjFlXQUgxSKmFNt++yqbj3Jx6q4zlja2i7VgcO/4PVU83rvtz0bt/rk4+YscZV
 O1RW3r9iKRloofytH5jpQj8EWKpx/pNtug1AS1mOIQpqcg2U+EJxi4i0/Rt335nMeUKWHnpzJ
 28erfNf0vqJ/+QrfoRzXMzPGCwL+UMGN3z0LxYgJzS5FaT1c/VqZVsw/XmNhWOQvxKKYxy94y
 oItA62OlDtM0bulgTjU2/rEQmSL69kG6QSTq7PM6LpyXUpYpdiTnd+EG8sbk=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 22 Nov 2019 11:00:33 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 22 Nov 2019 11:00:31 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Concerns around type safety for usage of expressions
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

Pj4+IFlvdSBjYW4gc3BlY2lmeSB0aGUgdHlwZSBvZiBhbiBleHByZXNzaW9uIHJhdGhlciB0aGFu
IGp1c3QgZXhwcmVzc2lvbi4KPj4KPj4gSG93IGlzIHRoaXMgYXBwcm9hY2ggZGlmZmVyZW50IGZy
b20gdGhlIHNlYXJjaCBmb3Ig4oCcc3BlY2lmaWMgZGF0YSB0eXBlc+KAnQo+PiAod2hpY2ggSSBr
bm93IGFscmVhZHkpPwo+Cj4gSSBoYXZlIG5vIGlkZWEgd2hhdCB5b3UgYXJlIHJlZmVycmluZyB0
by4KCkRvIHlvdSBmaW5kIGl0IGVhc2llciB0byBjbGFyaWZ5IHRyYW5zZm9ybWF0aW9uIHBvc3Np
YmlsaXRpZXMgYXJvdW5kCmFwcGxpY2F0aW9ucyBvZiBhIG1hY3JvIGxpa2Ug4oCcQ09QWV9BUlJB
WeKAnT8KaHR0cHM6Ly9naXRodWIuY29tL2dpdC9naXQvYmxvYi9kOTY2MDk1ZGIwMTE5MGEyMTk2
ZTMxMTk1ZWE2ZmEwYzcyMmFhNzMyL2dpdC1jb21wYXQtdXRpbC5oI0w4ODkKClJlZ2FyZHMsCk1h
cmt1cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2Nj
aSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2
LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
