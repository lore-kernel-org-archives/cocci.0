Return-Path: <SRS0=RP4p=WV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6BEC3A5A1
	for <cocci@archiver.kernel.org>; Sun, 25 Aug 2019 07:40:52 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B298217F4
	for <cocci@archiver.kernel.org>; Sun, 25 Aug 2019 07:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="loyulES4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B298217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7P7ebkg004185;
	Sun, 25 Aug 2019 09:40:37 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 530F876C5;
	Sun, 25 Aug 2019 09:40:37 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 792317694
 for <cocci@systeme.lip6.fr>; Sun, 25 Aug 2019 09:40:36 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7P7eY9L004702;
 Sun, 25 Aug 2019 09:40:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1566718833;
 bh=Yhdt+xl1a0nfYIJf6oBcDGS+KV5ezPN+Kk1u/SjgtH4=;
 h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
 b=loyulES4oqMGxW4lNfptmiBQO5VdhK91qLwhQ3SYd882yVxRNwEsimezYarvRu2HK
 s+ZeeLvueRHbGJqLFBaazE9AaTCPgMbUNmCUWwdD0OfmUF7OSD+dOpzp05hsifsv7g
 uPfeaQJVH6YqtE+PhJHQPDDI2Kl3VFY3V8/vDdEA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.160.204]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LyUsk-1iFhJP27rK-015oa2; Sun, 25
 Aug 2019 09:40:33 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <a7f12c28-0f96-d388-f1f4-57db4d3d880d@web.de>
 <2AE15A09-F219-43DC-81A9-73C13CFC0753@lip6.fr>
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
Message-ID: <661aa3dc-3514-3d75-eb3a-9e46843fd02d@web.de>
Date: Sun, 25 Aug 2019 09:40:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2AE15A09-F219-43DC-81A9-73C13CFC0753@lip6.fr>
Content-Language: en-US
X-Provags-ID: V03:K1:BBaHkYIDSBDRMWdaUQvv2K2ZFsx6i5+/Ve5ZyhAohtudgp716Vh
 qsedAfNu+cLlYdUX49pc04BQG6bb2GWKUU8He+G86suLst9UwuRtzTg31rXmCpJtIttKxsM
 jC1QrQk8+cohwe8tKvn+/90jNyX42X8C5m7srSlTRGKtyi7yOhxsKopXFoRaRxqWLozn/pb
 zpKa80T2DAbX5ocelGtyw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BTLbSj0330w=:Pwet35V7FGPxfQegaSS3EP
 j7k23GdYHH3zvintJyQiqvKwZLFUQX/a4kTfI5LBmh2YxAjJHDNe1lbzyr/jBRJhr7mscAnUO
 B0gA409U/KKceJ91mQMySJ0FL2dBDQbcO8uLVU2RUlgs/8kVxUovP4XgCKz/jnC98QNrcvdYr
 vO5BgHqtPIVivev0SmuRvLC4upfMKKSsFfgcJrCsnZhF2wfBZ0xlDOFr31aqkxdnIWF218Nwb
 hkXpeiTCdtW+fKRU2SVPIHp+HFEYucf8HdYV8NTgqTxsCS9Y/0WGRYbyROzJx9/jtL23zSPbH
 Jfixom0l3tgSO1ui97khpILy+af3EZBQLxG2ZaGt0lyZgEK8AfkjtPRjCCyHqEQo5DChf59p+
 x4kqYCzYbb6V+Yh0gqCwrzJnbAOk+B1fSMsBUrJ6Z1nA47VdPtM3gd8fGE26tJAR3NFAZ5D7t
 DPljxwpebhKaayc81yXm8fuc836cjyRoBlVx40KGM+T5crEfEOKVP5qsQzwxS+Oir2K3xsu/O
 FWEZRjhXib5eQRe+9OVQaw2e59t/k8dhf8VZ/qlzYpvK5vWGO9mBDjbWpbGlUco2kJ9M1OZn3
 SloHEk8B5hS3q4FN17CZa0LmWIg1L5WrEoiZUesxp+ae8Rxx8e/yTbRnsSzNz1kcFtrvKV4kK
 AGhZqI9/AAdIUmHVWwfrNJ+yclMwXF3KWvmAxGOhjEEGz2Hj/b6sdiGLaAU7buVhef3rSeldd
 PagCxBa6S67NSR0oCwQ5vEWRFTcoEkFFQv1ZUozMHzwwJAfEyoJ4paIk8PTXOrANdYN292GI6
 uoF/Cq/3S4k++ynFroXAd1HfY0/Dj+tdNIMCrwIlGDEY7fX8/sdixOov7uThQGFDEpr2xOqTK
 qCohxtHbNEh78c6uwMtQVZBfDHih6v2QJa7jky2PWeDe1b747iw211BOE6wGN4VFkTEuU1Jt7
 hmmIeFaGK1N3+zGiTe787+cRX/0/C5eZ09V0zdfcc2LD3LRRE/biUNPbut8eq10igRB4t9GUQ
 H6x10kI5Iio9ecQA7dMQR5khExIblmurLYGcY+mdzEaka3fUJFSKR1Evn78Tr/25bgj0e9Vvi
 GPt4jAYD9YQJKLgP9dShQcCpp6BPTW1eiBDOGb4QmrlbzeR9NvwmxCv6P2WnbuICNIFeLJYvK
 ky1X4=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 25 Aug 2019 09:40:38 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 25 Aug 2019 09:40:35 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Challenges around asterisk usage in SmPL code
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

Pj4gQGFzc2lnbm1lbnRACj4+IGV4cHJlc3Npb24geCwgeTsKPj4gQEAKPj4gKiB5ID0gLi4uICoo
eCkgLi4uOwo+Cj4gVGhpcyBkb2VzbuKAmXQgZG8gd2hhdCB5b3UgdGhpbmsuCgpUaGlzIG1pZ2h0
IGJlLgoKCj4gSXQgbWF0Y2hlcyBhIHNlcmllcyBvZiBzdGF0ZW1lbnRzLCBJ4oCZbSBub3QgZXZl
biBjb21wbGV0ZWx5IHN1cmUgaG93LgoKU3VjaCBhIGZlZWRiYWNrIGlzIGFsc28gaW50ZXJlc3Rp
bmcuCk15IGltYWdpbmF0aW9ucyBldm9sdmVkIGluIG90aGVyIGRpcmVjdGlvbnMuCgoKPiBUaGVy
ZSBjYW7igJl0IGJlIGEgc2VyaWVzIG9mIHN0YXRlbWVudHMgYmVmb3JlIGFuIGVsc2UuCgpUaGlz
IHZpZXcgY2FuIGRlcGVuZCBvbiB0aGUgaW50ZXJwcmV0YXRpb24gYXJvdW5kIHRoZSBoYW5kbGlu
ZyBvZiBjb21wb3VuZCBzdGF0ZW1lbnRzLApjYW4ndCBpdD8KCgo+IFlvdSB3YW50IDwrLi4uICAu
Li4rPgoKRG9lcyB0aGlzIFNtUEwgY29uc3RydWN0IGhlbHAgdG8gcmVzdHJpY3QgYSBzb3VyY2Ug
Y29kZSBzZWFyY2ggZWxlbWVudAood2hpbGUgdXNpbmcgU21QTCBlbGxpcHNlcykgdG8gYSBzaW5n
bGUgc3RhdGVtZW50IGZvciB0aGUgc2hvd24gYW5hbHlzaXMgZXhhbXBsZT8KCldpbGwgdGhlIHN1
cHBvcnQgZm9yIHVuYXJ5IG9wZXJhdGlvbnMgbmVlZCBhbnkgZnVydGhlciBkZXZlbG9wbWVudCBj
b25zaWRlcmF0aW9ucz8KClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5s
aXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
