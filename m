Return-Path: <SRS0=UFPg=6Q=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9F7C3A5A9
	for <cocci@archiver.kernel.org>; Sat,  2 May 2020 07:44:01 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C27A2072E
	for <cocci@archiver.kernel.org>; Sat,  2 May 2020 07:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="VMukcoHh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C27A2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0427hn6A012305;
	Sat, 2 May 2020 09:43:49 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id ABDD5757C;
	Sat,  2 May 2020 09:43:49 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 38D333C89
 for <cocci@systeme.lip6.fr>; Sat,  2 May 2020 09:43:48 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0427hiDi010374
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Sat, 2 May 2020 09:43:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1588405423;
 bh=0IC084GGH9XoDXU3WiTZYeHWeOGRLwACe7Vc90zBX8I=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=VMukcoHh0jp529coymHIWTEkYmHyTKwu92zjhEab7SN6+BeJDF5EYHXSwGE9+vfBc
 1QsKy8tmk+7I3TFD0YzvwX4ctOfxovyEDA51uH5DDw+hySvjuHPSC7pKwrHLLPT1xu
 rGGdhsNHUAgNPh0cPwtg+Fkiu9mp1uPSfknLMjh4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.93.244]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MCZh8-1jMVKv0V2g-009QxO; Sat, 02
 May 2020 09:43:43 +0200
To: Julia Lawall <julia.lawall@inria.fr>
References: <fd0d48f1-ba0a-74d6-6eeb-7494600067f7@web.de>
 <alpine.DEB.2.21.2005011348250.2504@hadrien>
 <96ecd52e-ffa6-87a3-ad45-79ad6ec6176e@web.de>
 <alpine.DEB.2.21.2005020904160.2538@hadrien>
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
Message-ID: <eaae5c04-f177-df67-9131-cdcc920116e6@web.de>
Date: Sat, 2 May 2020 09:43:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2005020904160.2538@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:krXeqmqP7r/Sjvjni0y3hu49cQsMX1CTgQMffe9WMbtAozrsYHP
 WvzIkWd/yrLjGoPVJPsMxHsqdG6uXefyaeIx6gtSvf97BzCFIXI9QBJSfrp3/Nk8Z0iXiNg
 loRLIAxZGlk6Aj32bmRKn4+3FKSH3qSBUlFQKFGjsqSuwjr6GV7DqfS2k/NLh3SjbGeSJsH
 g5V9R/xHIyeUat/MYcDgg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:punih4fGLQY=:UVes28iiU6Pz+oKzwja9t/
 8TW+K2c8Ppcrbz5+3NVi5jnFU8LcUheWHIgNHLe1DAfPwDKO+MneforvszOGuoNbL70JT0hmM
 wy6W6VxRjmXyEwGX0lr/IBmsSXw1s79x95Rma8GTFuGhQhW0E2C7N3dDFPBGq6oxjX6tDlXPN
 7pI59arKsatEhzxoU2x5CXirZCdLyiNK8wVsiC/JefwtHOKeFuPzfDV3zNX/AFlnC32/sS3OE
 +KNo4CiAbkuw9IS/IaELE5DE18+DD0R8lRkbsOsG0lqGx/hKjrdnUn/O7LTchJypsqboeIOsC
 6Qy77C5o68KMxV4qTxG8MyONWKJAHyfHSdQr67NS+xgbTBhYlDgAttz7YmX9DwSBGXYtjCX7j
 8v5z30viV3SR+KWA5BmaCID4uAs+9mBv59FbmCYd1z+dr26zASMASUG/rTWL3M5v8rhwBn/9x
 WhZKkZPPZE8feYbw01sWyBOEj5uSTSjRpQ6dkRDhucE+jxREneW6u84oS6qD2uGCNoezG1f4U
 6NX2O+VUAt6J3oNGcawaNBnV2tqgMUsG8v7mJiB/fXnDrXICWZGVxB0Vnn6jPlM204vKrws2u
 beI5GZK3UchFOE8cU5rWqkKa4fvHBfhUR+Unum7g7F7TIFQfjbmpwxGIe6VccvVQQYL58RV/5
 rXMfUiwC5rEuSv2VmnBa03mL0QEldjeOgmEPgzD/6JFbqA/PDpNi1C4B+tb5VREAzlpAAq/aW
 ZiPuWp47TnJY8YWYRHlvvN/DZI9cQxlGvjArGFR+A0+fG/M5w3Z7DjXwwiPJSLv6QCFoIVA/8
 +WkXEu+tzBGtgzc5KNQ+kS8CsAr9VfHC5gZffI3GsKjL9mAxSutUn0WPJbmqCVzOmVyKtE59g
 ZGke189K8I/CsRkFVI/RfqAX99o4ZmuGi9oEB2Lumd+jRcJuGsBbGDyAnVAwpzbY9f2JRLJ2r
 +xW/4VHpDSwHujHbPJVczx6ZW/dnjxtTY81ETJd6Y6hq/PrxRYFYJt+fmIjeLWufBap5YLLZq
 zaEI93+9zDg/nxSMUjzvqfD1mmwM0p/dGYUMBSUEplFwUSCZcmJ9H2otfXLG5K+xavYBtPjYx
 dNVGqXlzUMJYb94VGRH0Q5wwfGJb6lnyMU0lvfaVgSt/4ja9eu8YuFLTiHLzBGdkC8sxqgGwK
 TR8OJ03PTgy29BtbzcUZR8zp9InoaD+LgRWMTyrHXz+3ZSI1M5vg4z1KCK5nFrPcbLLdDKxJS
 suABgKahXPR4raLeE
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 02 May 2020 09:43:50 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 02 May 2020 09:43:44 +0200 (CEST)
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

Pj4+IEluIHRoaXMgY2FzZSwgdGhlIHByb2JsZW0gZW50aXJlbHkgb24geW91ciBzaWRlLiAgWW91
IHNob3VsZCBzZXBhcmF0ZSB0aGUKPj4+IHR3byB0b3AtbGV2ZWwgZGVjbGFyYXRpb25zIGludG8g
dHdvIHNlcGFyYXRlIHJ1bGVzLCBqdXN0IGxpa2UgYW55IG90aGVyCj4+PiB0d28gdG9wLWxldmVs
IGRlY2xhcmF0aW9ucyB5b3Ugd291bGQgbGlrZSB0byBtYXRjaC4KPj4KPj4gTXkgU21QTCBzY3Jp
cHQgZXhhbXBsZSBhZmZlY3RzIHRoZSB1bmRlcnN0YW5kaW5nIG9mIHRoZSBzb2Z0d2FyZSBiZWhh
dmlvdXIKPj4gYWxzbyBhcm91bmQgdGhlIGZvbGxvd2luZyBpbmZvcm1hdGlvbi4KPj4gaHR0cHM6
Ly9naXRodWIuY29tL2NvY2NpbmVsbGUvY29jY2luZWxsZS9ibG9iL2E1NDliOWYwYTIwZTE0ZmU5
YzM2ZjQ1OTkwYjQwZGM1NzA4ZWY4ZjIvZG9jcy9tYW51YWwvY29jY2lfc3ludGF4LnRleCNMMTY0
OQo+Pgo+PiDigJzigKYKPj4gQWxsIG1hdGNoaW5nIGRvbmUgYnkgYSBTbVBMIHJ1bGUgaXMgZG9u
ZSBpbnRyYXByb2NlZHVyYWxseS4KPj4g4oCm4oCdCj4+Cj4+Cj4+ICogSG93IGFyZSBpdGVtcyBy
ZXByZXNlbnRlZCBmcm9tIHRoZSBnbG9iYWwgbmFtZSBzcGFjZT8KPj4KPj4gKiBXb3VsZCB0aGUg
aW50ZXJwcmV0YXRpb24gb2YgdGhlIHNpdHVhdGlvbiBiZSBhZGp1c3RlZCBpZiBhIG1hY3JvIGNh
bGwKPj4gICBhbmQgYSBmdW5jdGlvbiBpbXBsZW1lbnRhdGlvbiB3b3VsZCBiZSBtb3ZlZCBpbnRv
IGFuIG90aGVyIHVzYWdlIGNvbnRleHQKPj4gICBsaWtlIGEgQysrIGNsYXNzIChvciBhbiBlbmNs
b3NpbmcgZnVuY3Rpb24gaW1wbGVtZW50YXRpb24pPwo+Cj4gSSBkb24ndCB1bmRlcnN0YW5kIGFu
eSBvZiB0aGUgYWJvdmUuCgpJIGZpbmQgc3VjaCBmZWVkYmFjayBhbHNvIGludGVyZXN0aW5nIHNv
bWVob3cuCgoxLiBIb3cgd2lsbCB3ZSBhY2hpZXZlIGEgYmV0dGVyIGNvbW1vbiB1bmRlcnN0YW5k
aW5nIG9uY2UgbW9yZSBpbiB0aGlzIGFyZWE/CgoyLiBJdCBzZWVtcyB0aGF0IHlvdSBwcmVmZXIg
c28gZmFyIHRvIHJlZmVyIHRvIOKAnHRvcC1sZXZlbOKAnSBpdGVtcyBpbnN0ZWFkIG9mCiAgIHRo
aW5raW5nIHdpdGggcmVsYXRpb25zaGlwcyB0byBuYW1lIHNwYWNlcy4KCjMuIENhbiB5b3UgaW1h
Z2luZSBjb25zZXF1ZW5jZXMgYWNjb3JkaW5nIHRvIG5lc3RlZCBmdW5jdGlvbiBpbXBsZW1lbnRh
dGlvbnM/Cgo0LiBUaGUgQ29jY2luZWxsZSBzb2Z0d2FyZSBjb250YWlucyBsaW1pdGF0aW9ucyBh
Y2NvcmRpbmcgdG8gaW50cmFwcm9jZWR1cmFsCiAgIGRhdGEgcHJvY2Vzc2luZy4KICAgVW5kZXIg
d2hpY2ggY2lyY3Vtc3RhbmNlcyB3aWxsIHRoZSBhcHBsaWNhdGlvbiBvZiBpbnRlcnByb2NlZHVy
YWwgc291cmNlCiAgIGNvZGUgYW5hbHlzaXMgaW5jcmVhc2U/CgoKPj4+IFlvdSBhbHNvIG5lZWQg
YQo+Pj4KPj4+IGRlY2xhcmVyIG5hbWUgRVhQT1JUX1NZTUJPTDsKPj4+Cj4+PiBpbiB0aGUgcnVs
ZSB0aGF0IHlvdSBuZWVkIHRvIGNyZWF0ZSBmb3IgbWF0Y2hpbmcgdGhhdCBwYXJ0IG9mIHRoZSBj
b2RlLgo+Pgo+PiBDYW4gaXQgYmVjb21lIGludGVyZXN0aW5nIHRvIG1hdGNoIGEgbWFjcm8gY2Fs
bCAob3IgYSBzaW1pbGFyIGFubm90YXRpb24vYXR0cmlidXRlKQo+PiBhbHNvIHdpdGhvdXQgdGhl
IGRlY2xhcmF0aW9uIG9mIHN1Y2ggYSBtZXRhdmFyaWFibGU/Cj4+IGh0dHBzOi8vZ2l0aHViLmNv
bS9jb2NjaW5lbGxlL2NvY2NpbmVsbGUvYmxvYi9hNTQ5YjlmMGEyMGUxNGZlOWMzNmY0NTk5MGI0
MGRjNTcwOGVmOGYyL2RvY3MvbWFudWFsL2NvY2NpX3N5bnRheC50ZXgjTDMxMAo+Cj4gSXQgaGFz
IG5vdGhpbmcgdG8gZG8gd2l0aCBFWFBPUlRfU1lNQk9MIGJlaW5nIGEgbWFjcm8uICBUaGUgZGVj
bGFyYXRpb24gaXMKPiBuZWVkZWQgdG8gdGVsbCBDb2NjaW5lbGxlIHRvIGxvb2sgZm9yIHRoZSB0
aGluZyBhdCB0b3AgbGV2ZWwuCgpXaWxsIGl0IGJlY29tZSBoZWxwZnVsIHRvIGFkZCBzdWNoIGFu
IGluZm9ybWF0aW9uIGFsc28gdG8gdGhlIFNtUEwgbWFudWFsPwpDYW4gdGhlIHNvZnR3YXJlIGRv
Y3VtZW50YXRpb24gYmVjb21lIGNsZWFyZXIgYW5vdGhlciBiaXQKYWxzbyBhdCB0aGlzIHBsYWNl
PwoKCj4gT3RoZXJ3aXNlIEVYUE9SVF9TWU1CT0woLi4uKTsgbG9va3MgbGlrZSBhIGZ1bmN0aW9u
IGNhbGwuCgpGdW5jdGlvbi1saWtlIG1hY3JvcyBhcmUganVzdCBsb29raW5nIHNvIHNpbWlsYXIu
CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczov
L3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
