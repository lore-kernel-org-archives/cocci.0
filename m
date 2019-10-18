Return-Path: <SRS0=N+LH=YL=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D7ECA9EA9
	for <cocci@archiver.kernel.org>; Fri, 18 Oct 2019 16:00:51 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E100621897
	for <cocci@archiver.kernel.org>; Fri, 18 Oct 2019 16:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="QBCHsCPD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E100621897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9IG0bHb013149;
	Fri, 18 Oct 2019 18:00:38 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D3C3C77B8;
	Fri, 18 Oct 2019 18:00:37 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D0ACF77B4
 for <cocci@systeme.lip6.fr>; Fri, 18 Oct 2019 18:00:35 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9IG0Z4F017117;
 Fri, 18 Oct 2019 18:00:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1571414435;
 bh=e74+4sbW/bmPrxe5ejqKueFFZgJGta6lNhBrylr5c2c=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=QBCHsCPDvJ38oebrVF87hlbrGZxMp2BXofZBHKprIOw5/O3C2CAV/dKErWXwRLvTR
 Q6LpFim7w9wcMZ9Ijvqc9s2tRA1yE4rF5okIfJrJyD4vlphOwlBLRZ7iN/TLeKBpA5
 jqU8+xySInHUJc9XEs9f/n3vLs5Q+z6nkmjnNrfY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.164.145]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MRRay-1iS00A471k-00Sh61; Fri, 18
 Oct 2019 18:00:35 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <24130ec6-4a20-7be4-755f-a6dfffcb6c97@web.de>
 <alpine.DEB.2.21.1910101509370.2305@hadrien>
 <45be389f-23f9-cbff-fa5f-8ad111124f94@web.de>
 <alpine.DEB.2.21.1910181530460.3697@hadrien>
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
Message-ID: <1a3776fe-7f18-e072-9bda-30d10ffd1c07@web.de>
Date: Fri, 18 Oct 2019 18:00:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910181530460.3697@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:Y7vCCea4zLmkglFTT2dWUhpiU8ZVeotvd673GT5nkyT0+pdx23B
 fWh3Q9+FLPi/fONsdw+wpf0SYTeQFgQ0lZQnh0N+bFjybli18xWXlZmrImvKvRjyu3XuxCh
 Lo455sQh9q2WSYsObJGqBNP8L5IlRu9yHKKziYYkQkX/chmKTJyHCX2yMT1jR0qrs1qw3+S
 mioAGlQ1QzdCB2MAdQwRQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HMXzxbD0ULY=:V2PbPyBDBdn3Ym2XMcs2/7
 ehZ+U4R9mFxA8lLQgkUNcyZ8JbXBDlypSZ6MFH94k95qiDdSj7zIU89TDVjBTiYnsrxUFbQNd
 S5ONhM+9tKt4qkbkQkpPZ0+pmGD+HO6iF1l0LhFWBz2u6zVoPi3c2L44gt0m40CLdn7HKRsy5
 /8Cq6WvvwNVqkNpG0A3y1VANo9H6wxsZLqf0WKpwYF706wyOP2+gH1dYZVwfLfrrqFUmyM2zm
 PJV7Q6n7q4egVC4anqvZZ6jlqQqTEQLIpu04MpWL1qUvMy7rNRrlX6wCdZOXXlG7wL1bjItyL
 V8jxIuZOwzzRnyiNav/ZWW7+J/JahAD7JXqXTKAFG1d6ZeyfrpgZUAg+0WlGbO8Jd48ypPggu
 slATFWmXxzEO22qc855q65UWtieOeHWH0t2AVzrTW2iGfa4tZCGdk9FXaTcvBu4QCVsOvsxzv
 V6fC4YjOOS1FSR4t7d0lKBdXaCZRNRzrWpo/PVwQuRM8Jb0ffQxcI3TgbCxdmEsGipK/A0fWs
 iOmJmGTi3JFyujY/mxAX7mhVm2o8HI7YYseayDlIp6XekfFjUTBa6QWYnQNkwSSz42yczZYKt
 rTadiN/Pc+rmGrvT6pbwI3+0aiYs8fsUIcHnbAwLQwd+mklYr51hUFJJ4Uqef1tOcK4SDdjpL
 bPzk6UJZ0B4dvhQVO11am+Ei7mpFLTG+y2M96EsJc2a9vsxMtfVi7EVtnnaI14AI/5c0LhR/e
 HaHJbKN631ByTg0d3GbW8vjhSOgM90p6XwfbMJ2PyaSKpmYdV6NOmLiI9oYSaUFv09P1Tx3xq
 RQIHxH0k6EKtdnzH2MRvqUxAvMg4UjDlozRHFcL7u9+/a4UllpZntPcOQPy0VEkz3L9qiVmz7
 1KC25pDOYqIjn5hSz+gZys7CWrPJ6SbWuPXn4XbE8B9RlJS2U2Pl8mEufiO6TsUJ2H8Po1Xbh
 +z6Op0atsPrjyw8IqX6XJEJqHDXK5vrhm+iG1nkoCdbkbLtDRm5eLJnAEZI8tglbEvRAMxjxS
 a39bKWmkOMgBvULYqJNr/8qHn6oHIewgSOqRSwA4nvmNcLHd41k4LUMFxQa/Gfft7BTSIviRB
 wMsfFU33Z1AVhjtSeVfQXepzlBbcUZUhKuN0lDvHc7W1zqH4hNeBqufa18/c64ngQmhts86zF
 qXHT6B4cZgrCxzFVDZp3GAXpEZjPxPEb8a81pNEQL3wuCVuoIF+EH1cEtqF8RUeKTmeXivsgY
 qk7M7ySnsWx8oCJ8/GQVx8FeYP6xqCGRRKypSK3fs9+/BQvBmPafvvs4svrs=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 18 Oct 2019 18:00:38 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 18 Oct 2019 18:00:35 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Software analysis with SmPL around unchecked pointer
 function calls
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

PiBleHByZXNzaW9uICp5OwoKVGhpcyBzcGVjaWZpYyBpbmZvcm1hdGlvbiBpcyBpbnRlcmVzdGlu
Zy4KCkl0IHdhcyBtZW50aW9uZWQgdGhhdCBmdXJ0aGVyIHNvZnR3YXJlIGRldmVsb3BtZW50IGNv
bmNlcm5zCmNhbiBvY2N1ciBhcm91bmQgdGhlIHBvc3NpYmxlIGFwcGxpY2F0aW9uIG9mIGZ1bmN0
aW9uIHBvaW50ZXJzLgpOb3cgSSB3b3VsZCBsaWtlIHRvIHBvaW50IGFub3RoZXIgYW5hbHlzaXMg
Y29uY2VybiBvdXQuCgpUaGUgZm9sbG93aW5nIFNtUEwgc2VhcmNoIGFwcHJvYWNoIGRvZXMgbm90
IHByZXNlbnQgdGhlIHNvdXJjZSBjb2RlIHBsYWNlCgpAZGlzcGxheUAKZXhwcmVzc2lvbiogeCwg
eTsKQEAKKnkgPSAoeCkoLi4uKTsKIC4uLiB3aGVuICE9IHkKCgp3aGljaCBjYW4gZm91bmQgYnkg
YW4gb3RoZXIgc2NyaXB0IHZhcmlhbnQgZm9yIGZ1cnRoZXIgY29uc2lkZXJhdGlvbnMuCgpAZGlz
cGxheUAKZXhwcmVzc2lvbiB4OwpAQAoqeCA9IGRldmljZV9saW5rX2FkZCguLi4pOwogLi4uIHdo
ZW4gIT0geAoKCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0
L25leHQvbGludXgtbmV4dC5naXQvdHJlZS9kcml2ZXJzL2lvbW11L3JvY2tjaGlwLWlvbW11LmM/
aWQ9YzRiOTg1MGIzNjc2ODY5YWMwZGVmNTg4NWQ3ODFkMTdmNjRiM2E4NiNuMTA1NwoKZWxmcmlu
Z0BTb25uZTp+L1Byb2pla3RlL0xpbnV4L25leHQtcGF0Y2hlZD4gc3BhdGNoIGRyaXZlcnMvaW9t
bXUvcm9ja2NoaXAtaW9tbXUuYyB+L1Byb2pla3RlL0NvY2NpbmVsbGUvamFuaXRvci9zaG93X3Vu
Y2hlY2tlZF9kZXZpY2VfbGlua19hZGQxLmNvY2NpCuKApgpAQCAtMTA3Miw4ICsxMDcyLDYgQEAg
c3RhdGljIGludCBya19pb21tdV9hZGRfZGV2aWNlKHN0cnVjdCBkZQogCWlvbW11X2dyb3VwX3B1
dChncm91cCk7CgogCWlvbW11X2RldmljZV9saW5rKCZpb21tdS0+aW9tbXUsIGRldik7Ci0JZGF0
YS0+bGluayA9IGRldmljZV9saW5rX2FkZChkZXYsIGlvbW11LT5kZXYsCi0JCQkJICAgICBETF9G
TEFHX1NUQVRFTEVTUyB8IERMX0ZMQUdfUE1fUlVOVElNRSk7CgogCXJldHVybiAwOwogfQoKCldv
dWxkIHlvdSBsaWtlIHRvIGNoZWNrIHRoZSBkZXNpcmVkIGRhdGEgcHJvY2Vzc2luZyBpbiBtb3Jl
IGRldGFpbCB0aGVuPwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxp
cDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
