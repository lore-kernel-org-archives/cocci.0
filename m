Return-Path: <SRS0=eKzF=QV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A016CC43381
	for <cocci@archiver.kernel.org>; Thu, 14 Feb 2019 10:01:55 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDD5D222A1
	for <cocci@archiver.kernel.org>; Thu, 14 Feb 2019 10:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="VHrh7Drv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDD5D222A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1EA1ZdB029689
          ; Thu, 14 Feb 2019 11:01:35 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id EF28176FA;
	Thu, 14 Feb 2019 11:01:34 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8A6D976F4
 for <cocci@systeme.lip6.fr>; Thu, 14 Feb 2019 11:01:33 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1EA1VPR015755
 ; Thu, 14 Feb 2019 11:01:31 +0100 (CET)
X-pt: isis.lip6.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1550138472;
 bh=UpdSdcSNY9uqdPNT4Pb1MVMa0ay4aPEN4V3Qc6wkzwI=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=VHrh7DrvLVIwg53zZQ/3NgXBp7MTim8VPlkE+QEyck4kzlYv8eOGYFM7RXsxXlD5z
 ify//qLOucN1ccZOuu90+VkDqglEiG8vFiuLwA5EnPdmbrjdBncSTPnc96OegW3ET8
 p//j5DYXPkkJiLo6221UCu+6z/vhUTW+QGJgiqNE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.97.110]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MDgLi-1grPTK37oU-00H6Oo; Thu, 14
 Feb 2019 11:01:12 +0100
To: Wen Yang <wen.yang99@zte.com.cn>
References: <1550126293-27839-1-git-send-email-wen.yang99@zte.com.cn>
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
Message-ID: <7c4e26a4-32b9-e1f8-beeb-bfa4fc9e6128@web.de>
Date: Thu, 14 Feb 2019 11:01:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <1550126293-27839-1-git-send-email-wen.yang99@zte.com.cn>
Content-Language: en-US
X-Provags-ID: V03:K1:uPbZOw1bAXbLPKvVSU+ApZVLQKFrw9CJUVK1AqhDPtu71KLmWva
 G8RQuwOZpq/+psJaSPq2+0/JUbshr0kxKQPRwOn3hCzsP1zQ4s+BkS9oRBSAm1f7B3Wz1WC
 ib0YZno0+jrETVvi4u/7lk7nGrNrMEzOGo7BZSVdUhPOTy/DX6/dcvgv6HZsXcHTAaUQ6dA
 3Kc50QjmSJ8pIxgLekXsw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4RD1Khhb85E=:RqbvCBs6fo1ldhu0OhpeXe
 AKc7uBoZgJJSbejH/WaMxpCwysbK//4XNCzya+clHfft6hYsVNbK0JFX74aQrRhtFX+p9dNsg
 0uOXpXdqkiOYS8rzX1yyLqcqmGsoysAIlVZCc8F7PHvn214NJrB7ehWlvrEquqs3ZLPSS7IYu
 CsTST2uWBvtM3sFxJarILce7rujoRCKmtX3boh1cV2z0SZqLhZGqibF0UsAmSdByeF9mn4GwG
 VBMWO7+jIFEr8/ZcCKCz+l24bamqKBWQrcrjwjCnvVhi4QsICPBekvQrypLs+THHppzQIWiNf
 DYPl10qKmZmqDrlgeqDX9nW2Al8l/fTKTJw1SwBSSM9G6+5OvX+jRTY4nXTpeLaIczO/+Jpmy
 wE5J1hJ0p3VC6ibkG8xYIf6bojM9YCldWPSxn3ZASML4SXWshCSaZCXaRWRGYvoLwkwAvNnj8
 MH42vv9MfYxzEdcNlJVGOsSCdIGLUDi+Vz0oGhu4eofYGxtURe6zIqhUvv87KAOLz69wPNeaX
 wufzHqtnbfriA+C2U0FP/US1EfXovxD+2h8SW2khgkK3TSSNleY2cL3JiFtZZ6XHKaVUIfVaY
 2s4n1FTu20iRzxYLJDZvztKCxU/KDGjfPOxZntkDtsvJH11YdzGK9K+JIrc+sNxLmjSydRHfA
 hEsA08u6VW8i+5a4FOW5nHcOvqfuzs5hX31XBQZ9erBLnZi3qDdAv8Z1Trk+8cyQD6I6SCq9l
 H2UdWYyKYkLxT7nG1/owiaLGsElnpQElVuY8tgL0bureyp0oG2cleOJL9ursLaLRaAegBeMtI
 V16U4PXpFI3VezB8tbMFs5Um6aXNktuDFJOsAFrV98oA/gWQhLnA+FvlAgXq0oMCywJJabRDH
 o2Fmzeebh42rd6lQESa85ZunoWMR0Xih6HbwDk/0xYSEFXep0Va0dAD5K29veke4riC+6ryBq
 1FM1k/DcHeg==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 14 Feb 2019 11:01:35 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 14 Feb 2019 11:01:31 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Yi Wang <wang.yi59@zte.com.cn>, kernel-janitors@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Wen Yang <yellowriver2010@hotmail.com>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH v4] coccinelle: semantic patch for missing
	put_device()
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

PiBUaGUgaW1wbGVtZW50YXRpb24gb2YgdGhpcyBzZW1hbnRpYyBwYXRjaCBpczoKClRoYW5rcyBm
b3IgeW91ciBleHRlbnNpb24gb2Ygc3VjaCBhIGNvbW1pdCBtZXNzYWdlLgoKCkkgd291bGQgaW50
ZXJwcmV0IHRoZSBwcm92aWRlZCBTbVBMIGNvZGUgaW4gdGhlIHdheSB0aGF0IGl0IHdpbGwgbm90
IGdlbmVyYXRlCmFkanVzdGVkIChwYXRjaGVkKSBDIGNvZGUgc28gZmFyLgpTb3VyY2UgY29kZSBz
ZWFyY2ggcmVzdWx0cyB3aWxsIGJlIHByZXNlbnRlZCBieSB0aGUgb3BlcmF0aW9uIG1vZGUg4oCc
cmVwb3J04oCdIG9yIOKAnG9yZ+KAnS4KCkhvdyBkbyB5b3UgdGhpbmsgYWJvdXQgdG8gZXhjaGFu
Z2UgdGhlIHdvcmQg4oCccGF0Y2jigJ0gYnkg4oCcY29kZSBzZWFyY2jigJ0KYXQgYWZmZWN0ZWQg
cGxhY2VzIChhbmQgaW4gdGhlIHN1YmplY3QpIHRoZW4/CgoKPiBJbiBhIGZ1bmN0aW9uLCBmb3Ig
dmFyaWFibGVzIHJldHVybmVkIGJ5IGNhbGxpbmcgb2ZfZmluZF9kZXZpY2VfYnlfbm9kZSgpLAoK
RG8gdmFyaWFibGVzIHJlYWxseSBnZXQgcmV0dXJuZWQ/CgpUaGUgcHJvdmlkZWQgcG9pbnRlciBz
aG91bGQgdXN1YWxseSBiZSBzdG9yZWQgc29tZXdoZXJlLgoKCj4gYywgZm9yIHRoZSByZXN0IG9m
IHRoZSBzaXR1YXRpb24sIHRoZSBjdXJyZW50IGZ1bmN0aW9uIHNob3VsZCByZWxlYXNlIHRoZQo+
ICAgIHJlZmVyZW5jZSBieSBjYWxsaW5nIHB1dF9kZXZpY2UsIHRoaXMgcGF0Y2ggd2lsbCByZXBv
cnQgdGhlCj4gICAgY29ycmVzcG9uZGluZyBlcnJvciBtZXNzYWdlLgoKKiBEbyB5b3UgZXhwZWN0
IHRoYXQgdGhlIGRlc2lyZWQgb2JqZWN0IHJlbGVhc2Ugc2hvdWxkIGJlIHBlcmZvcm1lZCBvbmx5
IGluCiAgdGhlIHNhbWUgZnVuY3Rpb24gaW1wbGVtZW50YXRpb24/CgoqIFdvdWxkIHlvdSBsaWtl
IHRvIHBpY2sgYW55IHNvZnR3YXJlIGRldmVsb3BtZW50IGNoYWxsZW5nZXMgdXAgYXJvdW5kCiAg
aW50ZXItcHJvY2VkdXJhbCBkYXRhIGZsb3cgKG9yIGV2ZW4gZXNjYXBlKSBhbmFseXNpcyBmb3Ig
dGhlIHNob3duIHVzZSBjYXNlPwoKCj4gRnVydGhlciwgZm9yIHRoZSBjYXNlIG9mIGIsIHRoZSBv
YmplY3QgcmV0dXJuZWQgdG8gb3RoZXIgZnVuY3Rpb25zIG1heSBhbHNvCj4gaGF2ZSBhIHJlZmVy
ZW5jZSBsZWFrLCB3ZSB3aWxsIGNvbnRpbnVlIHRvIGRldmVsb3Agb3RoZXIgY29jY2kgc2NyaXB0
cyB0bwo+IGZ1cnRoZXIgY2hlY2sgdGhlIHJlZmVyZW5jZSBsZWFrLgoKSSBhbSBjdXJpb3VzIG9u
IGhvdyB0aGVzZSBhcHByb2FjaGVzIHdpbGwgZXZvbHZlIGZ1cnRoZXIuCgoKPiArLy8gQ29weXJp
Z2h0OiAoQykgMjAxOC0yMDE5IFdlbiBZYW5nLCBaVEUuICBHUEx2Mi4KCldvdWxkIHlvdSBsaWtl
IHRvIGFkZCBhIFNQRFggaWRlbnRpZmllcj8KCgo+ICtjb2NjaWxpYi5yZXBvcnQucHJpbnRfcmVw
b3J0KHAyWzBdLAoKVGhhbmtzIGZvciBhIG5pY2VyIGluZGVudGF0aW9uIGhlcmUuCgoKPiArCQkJ
ICAgICAiRVJST1I6IG1pc3NpbmcgcHV0X2RldmljZTsiCgpXaWxsIGNoYW5nZSBjb25maWRlbmNl
IGNvbnNpZGVyYXRpb25zIHJlc3VsdCBpbiBhbm90aGVyIGZpbmUtdHVuaW5nIGZvciB0aGlzIG1l
c3NhZ2U/CgoKPiArCQkJICAgICAgKyAiIGNhbGwgb2ZfZmluZF9kZXZpY2VfYnlfbm9kZSBvbiBs
aW5lICIKCkkgZmluZCB0aGF0IHN1Y2ggYSBzcGxpdCBzdHJpbmcgbGl0ZXJhbCBjYW4gYmUgdW53
YW50ZWQuCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3Rv
cnZhbGRzL2xpbnV4LmdpdC90cmVlL0RvY3VtZW50YXRpb24vcHJvY2Vzcy9jb2Rpbmctc3R5bGUu
cnN0P2lkPTFmOTQ3YTdhMDExZmNjZWIxNGNiOTEyZjU0ODFhNTNiMThmMTg3OWEjbjk0CgoKPiAr
CQkJICAgICAgKyAiIGFuZCByZXR1cm4gd2l0aG91dCByZWxlYXNpbmcuIikKClBvc3NpYmxlIHJl
d29yZGluZz8KCisJCQkgICAgICArICIgYnV0IHdpdGhvdXQgYSBjb3JyZXNwb25kaW5nIG9iamVj
dCByZWxlYXNlIHdpdGhpbiB0aGlzIGZ1bmN0aW9uLiIpCgoKUmVnYXJkcywKTWFya3VzCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcg
bGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1h
bi9saXN0aW5mby9jb2NjaQo=
