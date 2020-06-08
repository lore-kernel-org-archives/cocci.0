Return-Path: <SRS0=02ua=7V=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D70C433E1
	for <cocci@archiver.kernel.org>; Mon,  8 Jun 2020 12:09:34 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECD2920774
	for <cocci@archiver.kernel.org>; Mon,  8 Jun 2020 12:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Oh2oX0Gk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD2920774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 058C9Hwv021261;
	Mon, 8 Jun 2020 14:09:17 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E51867783;
	Mon,  8 Jun 2020 14:09:16 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3BBFE44A7
 for <cocci@systeme.lip6.fr>; Mon,  8 Jun 2020 14:09:15 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 058C9EVO001817
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Mon, 8 Jun 2020 14:09:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1591618154;
 bh=INJ9oaTl2Tsr1Q+aUe4HD/qjrirgAUirLZYVrI59+qw=;
 h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
 b=Oh2oX0Gk/bG0ZIcxJHhBqk7FQno1wuTK7FhnG9EgbEOt6IF8w0TbKOe3p5/HRshxo
 7YYe5lU1LBgnwrosgJLyAVHizvhrQyfUC+NSJ4BlUA/Iq1Tzzui4GJzcvqfmRRVrU+
 k4daiKZXlcZTtC94ZoBb+yKKrAC7bzlBxs32s+dM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.116.236]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LZvcX-1jEwZY49Az-00lirR; Mon, 08
 Jun 2020 14:09:14 +0200
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
To: Denis Efremov <efremov@ispras.ru>
Message-ID: <06b174e5-5657-680a-08ba-6a4969058a0f@web.de>
Date: Mon, 8 Jun 2020 14:09:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:nFfJfk7h6dWIuWMdJhRHSus78aTQOCUNt3iFUcx/Efgk4Imqj3P
 200NOMeqWs02GWzNYKUcIwyt11IwdIIwzdpYO/dagwTsr0Y4qLsbSnSlzleGmJZwzvWoo2J
 XUmExNc9wTKtoWhemVUq4cD97mGcOOWvM9idkOzhYAT6GvWBaSlURZFvjVF/ynXXjxxmI0a
 FCHZzHxuuQywGhyRBAqXg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:peH8/AhKbhk=:BHhiHnN1sbu3XrqJMoSf87
 khFSN/a12zVDYyHz1M/F+4KDKD/9V9e1wyYr+CiQC55h+aw2DsmqaqQ5rS5mDo6GXQsxlwzLF
 GSpcU/CYu2Kj4pvuxk8sUq1ywTmWvHFs6fmOojmPwr7C+J1JxFYpQgqfsWdIUCGi1kZjvJpBM
 rFX+JTgsQTSdSTID8GvmIXXAVdxCru13gzx7Naq1qhS5K8NMrS9ezOOEAGUONhnrBLBbLxm32
 s/us18WrJ2YwMOhTjTeQwMiWWE+AO0TTVuo310werJA2LHKcD5dqARjJt1GaaLRd+f+/LPHKi
 z0G6DhKldaUomFttX2nm8P/4xii3m0Cm4HmjY7eI3R/qbfriR+7guBi56vNW71iJmqeFpDORN
 9TCM3mj3zing69XuJWT+IL5GI5B7l3JiKW9bDN1wM28XYrLRC+hMF72fBmeXBCg9C2v1et89g
 l+w/QK2FS0FRfn+c8YtAMZsqUzt/vmvuj3UH/GWkAiwFYBvHVAoWM7yqeBC9KUS77KXlertQV
 H7U0i5ZQdluURj4rMKxoNM8lz1PFCJw33tDZEr/Iye3Atc27Vzyxz8VrwFif/Og5fGoADxAqQ
 fqsFcg71eiJxwYRSKC2sC5XBrtqRCmYnxrizqEGu6dA55bX0ZG6dya0/5qwJSOQmAeRDhxHZr
 +3v3mYSy4+FDZ0dgL/pJA+ASTy8OeXlBzgFP+gswYDTOGrN5z66ktndVzULBczVR0+xf3Th4Y
 9lDs2alpDRCvwL2HyNGw15G37X4o/OHiNWbAuZU6uti9PHxbf3IhvKecA9tiE8pWaJ9ALvFk7
 hu2s63S8RAnPNrFOs4OABWf2RuXkYPB+FdL7QZuj14AgTMzqzHa1Nam9NE3RE3SaXg5ctiO6j
 1/Flk2BFCzvX12BjiiNpbYaSFLAk/kWtch1SRpcxILL5WTyl0NpHU9+j3ejlIrjJxeQb8cPR0
 vQA8iTRcWllsC2u8vBwCeZCf9wgX6DYkfxgBNXa5JYIWKwqjVEhM0jCpNn8PvaaZXyY8OJ2h4
 FUzHZEYn3K1XLQsFE3E2AtppowU3IxqCVLIyN9XDJx8fIwMfuR1Fhm9p6/kF0zYCu7SvpBt1F
 sy97lg7vrw0OYIKT1KnngaWOqWrZGt3npYNZV/UGi8ygaqsjvSFoFVuQ5ZLvWFG0xprlJm+Ci
 aXniESF2dVvWWSjzy4lsASo/gU1AEaAhhXWxxqEVV4+5iXiMN6QO0w9Sdqr2JGXoXgEISQX6E
 Klkn1LSagQPVjpInQ
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 08 Jun 2020 14:09:17 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 08 Jun 2020 14:09:14 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Python interface
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

PiA+IOKApiBCdXQgSSB3b25kZXIgaWYgdGhlIGRpZmZlcmVuY2UKPiA+IGJldHdlZW4gInRoZSBm
aWxlIGlzIG5vdCBpbiB0aGUgaW5pdGlhbCBsaXN0IiBhbmQgInRoZSBmaWxlIGlzIGluIHRoZQo+
ID4gaW5pdGlhbCBsaXN0IGJ1dCBpdCBpcyBpZ25vcmVkIiBpcyBpbXBvcnRhbnQgZm9yIHlvdT8K
Pgo+ICJ0aGUgZmlsZSBpcyBpbiB0aGUgaW5pdGlhbCBsaXN0IGJ1dCBpdCBpcyBpZ25vcmVkIiBp
cyBvayB0byBtZS4gSSBkb24ndCBrbm93Cj4gaG93IHRvIGdldCBpdC4KCldoaWNoIGluZm9ybWF0
aW9uIGFyZSB5b3UgcmVhbGx5IG1pc3Npbmcgc28gZmFyIGZvciB5b3VyIGRhdGEgcHJvY2Vzc2lu
Zz8KCgo+IFRoZSBwcm9ibGVtIGlzIHRoYXQgSSBuZWVkIHRvIGtub3cgdGhhdCB0aGUgIm1tL3V0
aWwuYyIgZmlsZSBpcyBpbiB0aGUgc2NvcGUuCgpXaHkgZG9lcyB0aGlzIHNvdXJjZSBmaWxlIG1h
dHRlciBmb3IgeW91IGhlcmU/CgoKPiBXZSBrbm93IHRoYXQgYSBwYXR0ZXJuIHNob3VsZCBtYXRj
aCBhIGZ1bmN0aW9uIGluIHRoZSAibW0vdXRpbC5jIiBmaWxlCj4gYW5kIHJlcG9ydCBvbmx5IGlu
IGNhc2UgaXQgZG9lc24ndC4KCkRvIHlvdSBjaGVjayBhIHN5c3RlbSBwcm9wZXJ0eSBoZXJlPwoK
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgV2UgZG9uJ3QgbmVlZCB0byBy
ZXBvcnQgaWYgdGhlIHRvb2wKPiBpcyBub3QgcHJvY2Vzc2luZyB0aGUgZmlsZSAibW0vdXRpbC5j
IiBhdCBhbGwuIFRoYXQgaXMgd2h5IHdlIG5lZWQgdGhlIGZ1bGwKPiBsaXN0IG9mIGZpbGVzLgoK
SSBzdWdnZXN0IHRvIHJlY29uc2lkZXIgeW91ciBleHBlY3RhdGlvbnMuCldpbGwgc29sdXRpb24g
YWx0ZXJuYXRpdmVzIGJlY29tZSBpbnRlcmVzdGluZz8KClJlZ2FyZHMsCk1hcmt1cwpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxp
c3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4v
bGlzdGluZm8vY29jY2kK
