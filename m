Return-Path: <SRS0=+34m=CQ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20041C433E2
	for <cocci@archiver.kernel.org>; Mon,  7 Sep 2020 13:09:31 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFE1521481
	for <cocci@archiver.kernel.org>; Mon,  7 Sep 2020 13:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="ee5EyKTQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFE1521481
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 087D91hD017354;
	Mon, 7 Sep 2020 15:09:01 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1EFDA7595;
	Mon,  7 Sep 2020 15:09:01 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 10C894316
 for <cocci@systeme.lip6.fr>; Mon,  7 Sep 2020 15:05:19 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 087D5H4Y013289;
 Mon, 7 Sep 2020 15:05:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1599483915;
 bh=WwuAYOvuloPiIJ6N7i2A1ffR6BaHnimfvT6MLAC12LQ=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=ee5EyKTQQ5tkqbEKaThvaSXhpbHxUzojvr+1EuWgFkqP72i11moXdYa/T2WawjZoU
 /fsO94oZkxDgixoW5tK+fJKLiTRmRMiVCnLznj2I7CCDGSh/M8i/zWYgk4GrZVAG1A
 6IvWOkGXUeKqPbCmtl6GOnfUk0M++90RJXtGpYZg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.162.183]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MTy9d-1k6mXS2IHB-00Qg2v; Mon, 07
 Sep 2020 15:05:15 +0200
To: Julia Lawall <julia.lawall@inria.fr>, Coccinelle <cocci@systeme.lip6.fr>,
        Dejin Zheng <zhengdejin5@gmail.com>
References: <25b804fd-0d04-475d-f614-26c03c9fd544@web.de>
 <5f9fdd59-4b0b-1cb5-c3a2-92efc5bb3841@web.de>
 <alpine.DEB.2.22.394.2009071357140.2476@hadrien>
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
Message-ID: <477abcea-e008-e509-d03f-f2753ebdfb20@web.de>
Date: Mon, 7 Sep 2020 15:05:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2009071357140.2476@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:PQSwaWotyH0R2wn9WKFoiF7zt6PcbxwRE3naV8teEk/st3u58rV
 ENQ9Yu8buJUjZiFbVAqetsh4h68FMS6ouIrF6Qgch3UKk4Eg7YG7LcwuSCQO470/C4zoJJG
 G1dxjwqQGGqlRg0ab9a4QoIWiYFySoCVCNd/9kzbNHveF461H8/EHxVf+zFZhawMRe7x+3T
 4Mok1I2UopyChihWkhDvQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:24j0HWy2NEg=:LbCHKMkUBuZ4yOO+Ak+ZLq
 4KCf93O5tzs4RXdlHXai7IjXUEyxRB9KWvDIQqRrJ1s3qWyMs9bA9HHd2pVzcizbKum4y434M
 11+XZ0vHgWqO0FQZX9Ige+6jXbrsms3jCG4IvrDfQkXVh4Kakzjv2ptLhkLvCnNMNZwcN15y0
 MMwz2UxX+4YVURgJ2xyuyVudEtOEkm6wPeMurn1cyfJL9l482790XO8R6cAmVoy5ydeVrj0rQ
 nttRw6eruQGvKK3wF9dHSdRARsAQQsrD3OZhUT1KID7N2UjOJ5ha8DBXVRRZbzjGm3QN4R5FK
 MooBkZgprgqUKKsIKnwkWzqUrMe+y9eUzve7Blq+qWbV1tUKM/N/iigEeWbASJhHAt7Z1B3Je
 JhbEoo6qrQLS6C2AhcCQ0k3IwBrbaY2ZUckKWwiT9+g7EM0iaqzwe+NddarnlEQq/HGe6h2ky
 IeuL1wk9lAMSvxJA3glAGoTUcw8Wbsd3ihqd14tr1TtdwCad4WXPYZCQLJIvXvF4kVxuoHXQt
 Q2mxDlLHWuCDleYChacdpqlbZ9oOm49LK4teSt+Pj9IDl+kbU4NgL71Os05ZwDd2K/T1Uhtlu
 J2IhyGFv4/Swq+RbQ0JPBgi0JZzWiUalG+lOdzcgVkzaNb/9A3qJw3LdiwDa93T/6UGp+NuQv
 a/35zJKGhr+sgAIc2NSRt7aMhnDP+TOILE3xev3Bm3DULr7RTPXpko66yIxBoVGPteYICrjGq
 TxaVxgBR8oVqTBo6xV8XZ6aY93M36cTuOHWb2PBt57ldDM58uJ8oX2QVgtgxS8klG1abQyyGh
 5KHiJvlsg114AIAyKKMMSXO3SQwCFfW9yycW7NMPnL6K8RXk/vPEo+hufkAk47wT0BpOSAi4S
 Qdl3DIcSRbri3Sr47M0NtvfvagXTwnNGiVOkcvYbK1csdtG/+T+PwbstenySkIAT9rZtAsHor
 CycAo6oi2qRFG3qAZtkdhU0yh0dZboi4hHV34skx0TtItMbTpDlcHbbB3S+Q99QW4l8gLNgJ1
 SIGj3gxorbBaN+dsYZomGqp5fBk+kCOUsy3T3qR9vnJkzw2N6l73WtVhClEfnotAX4+N1Ic6b
 shXWt8CZt2GOyp3QBr/f1FtUMDFzfUJJsHILb/vDBRPDp+pLttpwm+f+SntNxLTfb1/yzIgzA
 hDvswpHRvavzq7y7HF5tstc21Sf2E1V00EVfYOO9iuiIKT4rsRTQA4zth8Hs/lZat87J/Xkf/
 Pdu9jlMaGju1q6SagaRWzyUslQu72kvRNZdwSAQ==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 07 Sep 2020 15:09:01 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 07 Sep 2020 15:05:17 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Mon, 07 Sep 2020 15:09:00 +0200
Cc: Michal Marek <michal.lkml@markovi.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Cocci]
 =?utf-8?q?=5BPATCH=5D_Coccinelle=3A_api=3A_Add_SmPL_scrip?=
 =?utf-8?b?dCDigJx1c2VfZGV2bV9wbGF0Zm9ybV9nZXRfYW5kX2lvcmVtYXBfcmVzb3Vy?=
 =?utf-8?b?Y2UuY29jY2nigJ0=?=
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

Pj4gK0BkaXNwbGF5IGRlcGVuZHMgb24gY29udGV4dEAKPj4gK2V4cHJlc3Npb24gYmFzZSwgZGV2
aWNlMSwgZGV2aWNlMiwgaW5kZXgsIHByaXZhdGUsIHJlc291cmNlOwo+PiArQEAKPj4gKygKPj4g
KypyZXNvdXJjZSA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZShkZXZpY2UxLCBJT1JFU09VUkNFX01F
TSwgaW5kZXgpOwo+PiArIGJhc2UgPQo+PiArKiAgICAgICBkZXZtX2lvcmVtYXBfcmVzb3VyY2UK
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKCZkZXZpY2UxLT5kZXYsIHJlc291cmNl
KTsKPgo+IFdoeSBkbyB5b3UgcmVxdWlyZSB0aGVzZSBzdGF0ZW1lbnRzIHRvIGJlIG5leHQgdG8g
ZWFjaCBvdGhlcj8KCkkgd291bGQgYXBwcmVjaWF0ZSBpbmRpY2F0aW9ucyBmb3IgYSBnZW5lcmFs
IGNoYW5nZSBhY2NlcHRhbmNlCmFsc28gYWNjb3JkaW5nIHRvIHN1Y2ggYSBzaW1wbGUgdHJhbnNm
b3JtYXRpb24gYXBwcm9hY2guCkkgaW1hZ2luZSB0aGF0IGl0IHdpbGwgYmVjb21lIG1vcmUgY2hh
bGxlbmdpbmcgdG8gdG9sZXJhdGUgZXh0cmEKc291cmNlIGNvZGUgYmV0d2VlbiB0aGVzZSBmdW5j
dGlvbiBjYWxscyAoYnkgdGhlIHNwZWNpZmljYXRpb24Kb2Ygc3BlY2lhbCBTbVBMIGZpbHRlcnMp
LgoKCj4+ICt8Cj4+ICsqcHJpdmF0ZS0+cmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlKGRldmlj
ZTEsIElPUkVTT1VSQ0VfTUVNLCBpbmRleCk7Cj4+ICsgYmFzZSA9Cj4+ICsqICAgICAgIGRldm1f
aW9yZW1hcF9yZXNvdXJjZQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAoZGV2aWNl
MiwgcHJpdmF0ZS0+cmVzKTsKPgo+IFdoeSBkbyB5b3UgaGF2ZSB0aGlzIHNwZWNpYWwgY2FzZT8K
ClRoZSB1c2FnZSBvZiB0aGUgZGF0YSBzdHJ1Y3R1cmUgbWVtYmVyIOKAnHJlc+KAnSB0cmlnZ2Vy
cyBjb3JyZXNwb25kaW5nCnNvZnR3YXJlIGRlc2lnbiBjb25zZXF1ZW5jZXMuClRoZSBleHByZXNz
aW9ucyB3aGljaCBhcmUgcGFzc2VkIGFzIHRoZSBmaXJzdCBmdW5jdGlvbiBjYWxsIHBhcmFtZXRl
cnMKY2FuIGJlIGRpZmZlcmVudC4KCgo+PiArQHJlcGxhY2VtZW50IGRlcGVuZHMgb24gcGF0Y2hA
Cj4+ICtleHByZXNzaW9uIGJhc2UsIGRldmljZTEsIGRldmljZTIsIGluZGV4LCBwcml2YXRlLCBy
ZXNvdXJjZTsKPj4gK0BACj4+ICsoCj4+ICstcmVzb3VyY2UgPSBwbGF0Zm9ybV9nZXRfcmVzb3Vy
Y2UoZGV2aWNlMSwgSU9SRVNPVVJDRV9NRU0sIGluZGV4KTsKPj4gKyBiYXNlID0KPj4gKy0gICAg
ICAgZGV2bV9pb3JlbWFwX3Jlc291cmNlCj4+ICsrICAgICAgIGRldm1fcGxhdGZvcm1fZ2V0X2Fu
ZF9pb3JlbWFwX3Jlc291cmNlCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICgKPj4g
Ky0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICYKPj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBkZXZpY2UxCj4+ICstICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIC0+ZGV2Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAsCj4+ICstICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICByZXNvdXJjZQo+PiArKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgaW5kZXgsICZyZXNvdXJjZQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICApOwo+PiArfAo+PiArLXByaXZhdGUtPnJlcyA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZShkZXZp
Y2UxLCBJT1JFU09VUkNFX01FTSwgaW5kZXgpOwo+PiArIGJhc2UgPQo+PiArLSAgICAgICBkZXZt
X2lvcmVtYXBfcmVzb3VyY2UKPj4gKysgICAgICAgZGV2bV9wbGF0Zm9ybV9nZXRfYW5kX2lvcmVt
YXBfcmVzb3VyY2UKPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKGRldmljZTIsCj4K
PiBJdCBpcyB2ZXJ5IHN1c3BpY2lvdXMgdGhhdCBpbiBvbmUgY2FzZSB5b3UgY2hhbmdlIHRoZSBm
aXJzdCBhcmd1bWVudCBvZgo+IGRldm1fcGxhdGZvcm1fZ2V0X2FuZF9pb3JlbWFwX3Jlc291cmNl
IGFuZCBpbiBvbmUgY2FzZSB5b3UgZG9uJ3QuCgpJIG5vdGljZWQgYSBmZXcgc3BlY2lhbCBjYXNl
cyBkdXJpbmcgbXkgc291cmNlIGNvZGUgYW5hbHlzaXMgYXBwcm9hY2guCgoKPiBJZiB5b3UgZG9u
J3Qga25vdyBob3cgdG8gbWFrZSB0aGUgY2hhbmdlIGluIHNvbWUgY2FzZXMsIGl0IHdvdWxkIGJl
IGJldHRlcgo+IHRvIGRvIG5vdGhpbmcgYXQgYWxsLgoKSG93IGRvIHlvdSB0aGluayBhYm91dCB0
byB0YWtlIGFub3RoZXIgbG9vayBhdCBhbnkgdXBkYXRlIGNhbmRpZGF0ZXM/CgpFeGFtcGxlczoK
KiBtdmVidV9zZWlfcHJvYmUKICBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92NS45
LXJjNC9zb3VyY2UvZHJpdmVycy9pcnFjaGlwL2lycS1tdmVidS1zZWkuYyNMMzY4CiAgaHR0cHM6
Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXgu
Z2l0L3RyZWUvZHJpdmVycy9pcnFjaGlwL2lycS1tdmVidS1zZWkuYz9pZD1mNGQ1MWRmZmM2YzAx
YTllOTQ2NTBkOTVjZTAxMDQ5NjRmOGFlODIyI24zNjgKCiogaGk2NTV4X3BtaWNfcHJvYmUKICBo
dHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92NS45LXJjNC9zb3VyY2UvZHJpdmVycy9t
ZmQvaGk2NTV4LXBtaWMuYyNMOTIKICBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGlu
dXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9kcml2ZXJzL21mZC9oaTY1NXgt
cG1pYy5jP2lkPWY0ZDUxZGZmYzZjMDFhOWU5NDY1MGQ5NWNlMDEwNDk2NGY4YWU4MjIjbjkyCgpS
ZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5
c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
