Return-Path: <SRS0=UFPg=6Q=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B02C3A5A9
	for <cocci@archiver.kernel.org>; Sat,  2 May 2020 05:57:29 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06745208DB
	for <cocci@archiver.kernel.org>; Sat,  2 May 2020 05:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="JRNvlDMW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06745208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0425v2U9003567;
	Sat, 2 May 2020 07:57:03 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 9EB97757C;
	Sat,  2 May 2020 07:57:02 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 508063C89
 for <cocci@systeme.lip6.fr>; Sat,  2 May 2020 07:57:00 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0425uxNR026795
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Sat, 2 May 2020 07:56:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1588399018;
 bh=d8eIJAhPY/4Oi51KBtTmPEJdlmOsSNiORPXAlcd6hL8=;
 h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
 b=JRNvlDMWajUhCJwgcEcP7LGNk5Qb5OyEWzHFKpbJFcOS/GQi4+YHiVZRCv7wfGj3q
 oONsuqR4P9R8EIMHLd0mA3VLUJyf+reBxOH005Jsgo503UGKbTW51+25zbPejvRwWq
 gggeob+HdjQ3NIdXKLocYUQ4q7liDHS8ZeswLIPM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.93.244]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LrK0u-1j1IUI1h1A-0137Cd; Sat, 02
 May 2020 07:56:58 +0200
To: Julia Lawall <julia.lawall@inria.fr>
References: <fd0d48f1-ba0a-74d6-6eeb-7494600067f7@web.de>
 <alpine.DEB.2.21.2005011348250.2504@hadrien>
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
Message-ID: <96ecd52e-ffa6-87a3-ad45-79ad6ec6176e@web.de>
Date: Sat, 2 May 2020 07:56:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2005011348250.2504@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:Yqe5S/1UsH5LAKvSRvvNUZOSZSJjZMlBUaYGQiTZuDOiZc0mqiN
 X4rNvr1fCd4n3I0Tj37MGOeydf7pQWjYRATh65tbFO3pyai3+ODsXvjO825ikX0FkMgzy50
 zDOLrTc89FAbCJMSBr8N5mMPboJ0WVyJBd889a+MVYZe8+1pNSHA9G5rcX1QLqwcdatf8uG
 40ikjzUG8Fw+HEXK1JPjg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QZXX17iVIsg=:azW5zgd2SQFmWI7t3XFRim
 +Na3gXy+srskzhxRpEOZ9uqfpBxPV92z+dcDCTwjreT0u61/IEZzS86lLOzV0z69Vh88274aF
 xCLQmQsq468ViQOm/jmEnK1ej7tqCOMLZ3Mg6+OUn9s5HjFgbHhBgQifKU/sCBYPUE/LsPRu5
 vEUDea9Q0OCYIciGccExkqX52WUrCeeoEM2sd+PMzyWOd5XlvgRotqrmd3WAF4iVfI4agDp+d
 S09ZzyJE/P58CQIe7IjtLa3DsV1P8/Z0XC/vuaGkfVWuV4aq8lcIrIUNx4i/5XXQy7LTImyHh
 S2+DbDzVj2GsgZjLqeuzOlNIPhANAI9KkSm5E0hy61Kv7R0PYiJkOqkeKovM2hNlkH9MMR3Ia
 YXNXCKkDsj6cJo0yh5P3QlgvqNhdmyAvax61GW/v79nJXP4YyP085p45mWlvcz9qv/+xDnVTm
 9oVcnMyxmGraIacwyqw3OXFdESldRvRoVKJvQzCiEbq731cZjKt5DzQHivVVBXNJSHGVeK0up
 qv9fGlPYaLhTC6wbM2A0Jcc8WfstGF2s6i38PX3tFLLYrIncKL6827x+LZkNjLT1Dn1FZJmZQ
 QVauKc7RxsOCXeigQ3Z9ZtVW2cq77Pbf0i5qdqf4CKHzX1ZNbXuBwTlnt+Nh/cIok0rT7uPTq
 0yr7jl8NbgaAagVRG+NBatr1PFFZ3lSnsbHiAO0mXtxFmzY1Yvy60/DSj6lx+HqIVZx2r1F7U
 /9wcDGHcS36dy4gNvGZmlhAH5l7GnJ5oOp6aqdB6X5dI/sAPBgfHxyHxv8BtycbNJmmCPkJ+W
 w4891f8B/Re6nVEi7Q8CRlpv4A1Ne68LHWWFwRdIxxl+8fzvZSlcaHKpzuTCVhAOS4hOd34HL
 WXAETpLP4Y6rgCFypVydrPl1a6uKpCq9PgahAH3L9IHuA3sEB0ZsQpuALSc0a07FYRL+0imhS
 ldBZzbtoshVHLkSQqMEiNsWF0civAFK6tOKFfAOJV9ZFgz0Id0itQIDS41p5vU5tWlsOVzMyP
 yP2XMOyw2+27GqHyaPIPxwRegyTtLG3JwOaEj2qZheVzHVJKH2H4aFcZD2/V1FOqrZZoRZCU+
 6Nd9cqX6zOPOZyKSbMYD3nV8HgKeclBALwiv82e/ZtRM0Cs77BMnyhILLxs6jkMhTXNGjsGy0
 QOfYLFQXyviU6A+xmYadMeaq6pAhF3ewF/eyd7qvfB+a5fA5je7hcrmE2VLx3YsM/fr0Swt+H
 F1M9cirMgSD0ueyBA
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 02 May 2020 07:57:03 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 02 May 2020 07:56:59 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Searching for global items in the source code
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

Pj4gQGRpc3BsYXlACj4+IGlkZW50aWZpZXIgYWN0aW9uOwo+PiB0eXBlIHJldHVybl90eXBlOwo+
PiBAQAo+PiAqcmV0dXJuX3R5cGUgYWN0aW9uKC4uLikKPj4gIHsKPj4gIC4uLgo+PiAgfQo+PiAg
RVhQT1JUX1NZTUJPTChhY3Rpb24pOwrigKYKPiBJbiB0aGlzIGNhc2UsIHRoZSBwcm9ibGVtIGVu
dGlyZWx5IG9uIHlvdXIgc2lkZS4gIFlvdSBzaG91bGQgc2VwYXJhdGUgdGhlCj4gdHdvIHRvcC1s
ZXZlbCBkZWNsYXJhdGlvbnMgaW50byB0d28gc2VwYXJhdGUgcnVsZXMsIGp1c3QgbGlrZSBhbnkg
b3RoZXIKPiB0d28gdG9wLWxldmVsIGRlY2xhcmF0aW9ucyB5b3Ugd291bGQgbGlrZSB0byBtYXRj
aC4KCk15IFNtUEwgc2NyaXB0IGV4YW1wbGUgYWZmZWN0cyB0aGUgdW5kZXJzdGFuZGluZyBvZiB0
aGUgc29mdHdhcmUgYmVoYXZpb3VyCmFsc28gYXJvdW5kIHRoZSBmb2xsb3dpbmcgaW5mb3JtYXRp
b24uCmh0dHBzOi8vZ2l0aHViLmNvbS9jb2NjaW5lbGxlL2NvY2NpbmVsbGUvYmxvYi9hNTQ5Yjlm
MGEyMGUxNGZlOWMzNmY0NTk5MGI0MGRjNTcwOGVmOGYyL2RvY3MvbWFudWFsL2NvY2NpX3N5bnRh
eC50ZXgjTDE2NDkKCuKAnOKApgpBbGwgbWF0Y2hpbmcgZG9uZSBieSBhIFNtUEwgcnVsZSBpcyBk
b25lIGludHJhcHJvY2VkdXJhbGx5LgrigKbigJ0KCgoqIEhvdyBhcmUgaXRlbXMgcmVwcmVzZW50
ZWQgZnJvbSB0aGUgZ2xvYmFsIG5hbWUgc3BhY2U/CgoqIFdvdWxkIHRoZSBpbnRlcnByZXRhdGlv
biBvZiB0aGUgc2l0dWF0aW9uIGJlIGFkanVzdGVkIGlmIGEgbWFjcm8gY2FsbAogIGFuZCBhIGZ1
bmN0aW9uIGltcGxlbWVudGF0aW9uIHdvdWxkIGJlIG1vdmVkIGludG8gYW4gb3RoZXIgdXNhZ2Ug
Y29udGV4dAogIGxpa2UgYSBDKysgY2xhc3MgKG9yIGFuIGVuY2xvc2luZyBmdW5jdGlvbiBpbXBs
ZW1lbnRhdGlvbik/CgoKPiBZb3UgYWxzbyBuZWVkIGEKPgo+IGRlY2xhcmVyIG5hbWUgRVhQT1JU
X1NZTUJPTDsKPgo+IGluIHRoZSBydWxlIHRoYXQgeW91IG5lZWQgdG8gY3JlYXRlIGZvciBtYXRj
aGluZyB0aGF0IHBhcnQgb2YgdGhlIGNvZGUuCgpDYW4gaXQgYmVjb21lIGludGVyZXN0aW5nIHRv
IG1hdGNoIGEgbWFjcm8gY2FsbCAob3IgYSBzaW1pbGFyIGFubm90YXRpb24vYXR0cmlidXRlKQph
bHNvIHdpdGhvdXQgdGhlIGRlY2xhcmF0aW9uIG9mIHN1Y2ggYSBtZXRhdmFyaWFibGU/Cmh0dHBz
Oi8vZ2l0aHViLmNvbS9jb2NjaW5lbGxlL2NvY2NpbmVsbGUvYmxvYi9hNTQ5YjlmMGEyMGUxNGZl
OWMzNmY0NTk5MGI0MGRjNTcwOGVmOGYyL2RvY3MvbWFudWFsL2NvY2NpX3N5bnRheC50ZXgjTDMx
MAoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6
Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
