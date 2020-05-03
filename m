Return-Path: <SRS0=XgKS=6R=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1016C28CBC
	for <cocci@archiver.kernel.org>; Sun,  3 May 2020 09:08:47 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2CA720721
	for <cocci@archiver.kernel.org>; Sun,  3 May 2020 09:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="fZTPL2c6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2CA720721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04398agS003242;
	Sun, 3 May 2020 11:08:36 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A24D07763;
	Sun,  3 May 2020 11:08:36 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 136D23C89
 for <cocci@systeme.lip6.fr>; Sun,  3 May 2020 11:08:35 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04398Y8l003169
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Sun, 3 May 2020 11:08:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1588496913;
 bh=jVTH4QBA3SQtT4or54GIdluC7LJjk8iYtT08sA2IyUA=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
 b=fZTPL2c66QayBwlQqQQecmbyE5CvMP29zjkvxzYKQWLgz6yQDr0Wx5Vhu0XH1OnPc
 WkYeiEZtk0RgcyX7tpfKltcJ+gSP9myQNbqB0C6muOjM484QXz3g/+1A4g1m1bjaZx
 dcrHzVWp/O/aueWNUiSuNT70fLjkhK4WvuYpq/1g=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.26.31]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MWirL-1jg0Ow17gx-00Xswz; Sun, 03
 May 2020 11:08:33 +0200
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@inria.fr>
References: <146360ce-9cfb-e6f5-1601-fa95460c2cd5@web.de>
 <alpine.DEB.2.21.2004101712080.3039@hadrien>
 <f0b37f45-5144-a1c5-3f52-5bfbb6f3635f@web.de>
 <alpine.DEB.2.21.2004111600560.2369@hadrien>
 <fcbca1d9-7375-b488-54b2-a3934b90c6ed@web.de>
 <alpine.DEB.2.21.2004112036270.2369@hadrien>
 <d878a25d-29fd-28b1-fa6f-2e0f44763d73@web.de>
 <alpine.DEB.2.21.2004121050210.2419@hadrien>
 <c3096ced-6ecc-b83c-57bc-f4655750fb48@web.de>
 <alpine.DEB.2.21.2004121115210.2419@hadrien>
 <2597ce78-e14a-d7eb-d4e6-eb67162e7171@web.de>
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
Message-ID: <32e16d10-0153-657a-4048-a9b2dbdcba43@web.de>
Date: Sun, 3 May 2020 11:08:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <2597ce78-e14a-d7eb-d4e6-eb67162e7171@web.de>
Content-Language: en-GB
X-Provags-ID: V03:K1:AvbXTpc2A5vUxar+3GeGQSL4fr21mV8Fi72YkCA75l/4Q+gUy+1
 bHCHyBEjwRvCcQNxRXX3fxC5CLaJxUzWUo0Tg1XBbo8mH9SEtOgCAoBgL0QUqjiRxkkMxQb
 t28M7xnrwAQ/jiNEChU5wSTGVCNF3J/yUg5yH7m54XYne9lkDApAeKleEUcKut77c+cJ7dx
 QsI7NS+SxURiEXbFL44TQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MBbXCPr1mc8=:M2LAnYPze+3Ra+kg242Pjt
 WXjOYnNuit5HwFHkUxrJ+RTRdwzzjUxV0eTTxXMXrBEU3tbRTysWm3hGZ9AuIMssBtQM+7cta
 uTZd/oDha9kOEw6be1g5qupi+ycC9gzcdpCQuLnbhHLVuIYW01MBjq3d1tEgGMR+4wcgzEsVa
 zHrSDq4qoFwpLZBRIJtrkS+Db7xH0aM/CR05i22P4tX1FDgAouN8MUubH36jLn2NQwk8iZQ7p
 6IH8ghWnbZVzQ0mw9N9FSNfZDX4yBK8aDtTwXLrVsHcw1WpaHLCXGg5sEGzVp5Ml0TIGOOeET
 h0mJoxbwtP0p6gov9DW3MzVXsOSAJ7xBz72okcgR85HzGgGIs1QeRTTn5XiKeIM807RGdTkQ6
 diG168uCv+BiMbGqeq39pwuVJ77qWF2vrtFbitSODOMRL2Oej6iuL/ZkMVgCpKX2EfiIhyzd5
 4xpr6D5eQ/gwMcQpzQZglLBomxHhc6PQtQfn5OEGXq2tbdJx6Tw7grsWRCqBaEdGQWT36622W
 vVzfe8TI2fdaPLJM382mjj6roQ2LWpHvDeVgD0KCd8L7dHK7g6BSGjQGkO2uvB+QP80UkGZVR
 agjNkFPTw5hB6B+NALnAd442Ff5MfNDany8gw6UHWCQctdkw+QAeWWO8E6+j7A4JVTpJdw737
 5nkrr1ZInH92DQGG3ly+bjJY2snRtIwGEBMuh3nyKqQYlARnXumEnxpJLL8bD1EpBiSWZtv1n
 y9zZ6V+MZ+Q/H4IMWdoLTs+swJozm6vEnenoIQd+TFHsVHrYkXT7ninRkKIzUQqXG/HT9hQkl
 Ps3F36DQ71tAnVCPhaqRD/2Fcmvv8C0/HNH5FjSSVw7ihcqUJkujGZ3mOPV062AlvqJf1jFvM
 oevXcvHnuTTw+sOKP7yutcweCYX/fzqRBz/P07dD1rLkk2NEiTm0i5kNAzj3HuEaclYs9jA6q
 PnMpEN45NUtuOSZbxPVdRZbvcowbMWOCiW4i5FfH60Q5iiYZWRmjAeaKr/LCK5MYuEYexd1x7
 4H5qW5gfMnGG8QDGDEcb1ndWRC91KAMAYHGyVKqSHAH+ENJuLL0Ld/MdO0vezrZ9+LlwZSp0D
 WUHMNqaAoFZS+7WofldlYIZFm5BfkPQkTvkABkuFnAOfBYRB5n8gYSF+BYkzCqKN8qLiISFzj
 4XEmuwZ5fIySifvi5CK9MCEuD35IhBWjCufQK/l/06AcUZ9kwW0rtN/jvnbOIvnwDtgLrLW1E
 /xNvn3vgtaCnbwBaF
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 03 May 2020 11:08:37 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 03 May 2020 11:08:34 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci]
 =?utf-8?q?Checking_the_application_of_the_SmPL_isomorphis?=
 =?utf-8?b?bSDigJxkcm9wX2Vsc2XigJ0=?=
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

PiBJIGhvcGVkIGZvciBhbm90aGVyIGNsYXJpZmljYXRpb24gYWxzbyBmb3IgdGhlIG1lc3NhZ2Ug
4oCcd2FybmluZzogaXNvIGRyb3BfZWxzZQo+IGRvZXMgbm90IG1hdGNoIHRoZSBjb2RlIGJlbG93
IG9uIGxpbmUgNTXigJ0gKGFuZCB0aGUgY29ycmVzcG9uZGluZyBkZWJ1ZyBkaXNwbGF5KS4KCkkg
aW1hZ2luZSB0aGF0IHRoZXJlIGlzIGFub3RoZXIgYml0IG9mIGZpbmUtdHVuaW5nIHBvc3NpYmxl
LgoKCj4+IFRoZXJlIGlzIGFuIGlzb21vcnBoaXNtIHRoYXQgZHJvcHMgZWxzZSdzIGluIGlmcywg
YnV0IHRoYXQgb25seSBhcHBsaWVzIGlmCj4+IHRoZSBlbHNlIGlzIGEgbWV0YXZhcmlhYmxlIHRo
YXQgaXMgbm90IHVzZWQgZWxzZXdoZXJlLgo+Cj4gSSBhbSBsb29raW5nIGZvciBmdXJ0aGVyIGlt
cHJvdmVtZW50cyBpbiB0aGlzIHNvZnR3YXJlIGFyZWEuCgpodHRwczovL2dpdGh1Yi5jb20vY29j
Y2luZWxsZS9jb2NjaW5lbGxlL2Jsb2IvNmI0YmI2OTJmMjA4YmZlODZlNjJhNjE2NzI0NTcwZDkz
MTBjNzE1MC9zdGFuZGFyZC5pc28jTDQyMQoKSXQgc2VlbXMgdGhhdCB0aGUgY29kZSB0cmFuc2Zv
cm1hdGlvbnMg4oCcbmVnX2lm4oCdIGFuZCDigJxuZV9pZuKAnSBhcmUgYXBwbGllZApiZWZvcmUg
4oCcZHJvcF9lbHNl4oCdLgpTaG91bGQgdGhlIHdhcm5pbmcgYmUgYXZvaWRlZCB0aGVuIGlmIHRo
ZSBlbHNlIGJyYW5jaCBiZWNhbWUgbm9uLWVtcHR5CmJlY2F1c2Ugb2YgdGhlIGNvbnZlcnNpb24/
CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczov
L3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
