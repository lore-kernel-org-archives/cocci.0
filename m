Return-Path: <SRS0=cEHO=6O=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29BAC47247
	for <cocci@archiver.kernel.org>; Thu, 30 Apr 2020 17:06:35 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C6AD206C0
	for <cocci@archiver.kernel.org>; Thu, 30 Apr 2020 17:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="FBy2tgql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C6AD206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03UH6HUm022945;
	Thu, 30 Apr 2020 19:06:17 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8C9437816;
	Thu, 30 Apr 2020 19:06:17 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E48507769
 for <cocci@systeme.lip6.fr>; Thu, 30 Apr 2020 19:06:15 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03UH6DUf019217
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Thu, 30 Apr 2020 19:06:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1588266373;
 bh=NHVap7yNtKX3cH5kx1Z/LdvaMBhvZCBrTif7BVJKOzg=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=FBy2tgql6NuvE61YYpYl8ec40mfKL7ZN0puYa1TMzA7EUaRiraAdj176PmTNcTdnp
 FoIvSI27+Vfce9TkHRQQlA6s89HSGLCkhufV2gRZQMPUH3sb19Lo/4coVmqZVAzDFY
 dt3GLvD3jLcJkXCDvLVgnBbimtHx6L2uazC6xMsA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.175.216]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LdVty-1ilpTj1viU-00inAK for
 <cocci@systeme.lip6.fr>; Thu, 30 Apr 2020 19:06:13 +0200
To: Coccinelle <cocci@systeme.lip6.fr>
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
Message-ID: <3069d2ed-475d-d36f-526e-4b7a685577cb@web.de>
Date: Thu, 30 Apr 2020 19:06:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:V2fUR2uPV3ImAZYU7jqRX+VG4h24ZU+zT8dpoSs8ZY8t+YFQ6u5
 vYZrV1m/32tQ0emYc3Y1D7cu5C8Pg6io6qKaBi7eyJgu+g5sFGzr3qXxcMEhmp4GfSwxrh2
 Y0x/g3jr2S4FNVGGK0tPQAzw3iP4inuXu3DiXomu/Szmz6DtdgEepzBUNJs1X8CFiLbtw83
 yFr0zsrFBQwOMJMzyG7iA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cEzFX1Mg6Vk=:T1t2xsxGayO6MRvMmwEQjN
 U208KuFQCWH2O+xqHa3lVUbtxI4M9ya5rLuWGItBxOlqgo/nan4LAY/N4PCIt/E03G1hWpJN1
 Sdqq3X18RldhjgxuWmGY/2O+5Zb/tXrHPkol0BzVd7IWqZ6YRgDHkm+pByMIaxJuGPIYDcQfU
 AiPJCiUXjNY2UKpBF+ChgjJYUeA5Vv2mcwxxL3+bLwJjJKOVojOSTPJZeloto/jgb1mXfE5w7
 u1MREqab9AKwQwtqRxI+767ItJ5/YMiVjhvDsJW7zWPiZX9H2lyNRk7GL/HOUHdcpOpdzdy4F
 9WCziTPuJ9c2RtGKnFmDT9fhRP8iLSjaebUGHnG36wWkLoVNGJpfrZF16+KXkeQr7ewQje7Hv
 ZdWcGzFFLWSxwSBdL4LYkbh4doZqIex3QYC2W5hiVkCwrGf4F0GoxrjF+OIrOb0bJpJMP4bkY
 kqeRic7FUpSmGLmjNOF02Z1Ad26H6XxoGO99dTHSvwaZDiTTi9A3IgHzmaLgD5KU1uMksPDML
 TNpd05o/TdFxyX6mBaBBDIwQPLvhiCeVtSN0IEaKAPw+lb8N/iPByu2gxAyo9VlTZnoVYZWG6
 DlMNzMKjhrR106ia9Fiq2KUUMXkG8P+rTG3b4dXQHUb4R4zYSrWGPD85nxg1I5h7Et74ASxXC
 iwyfZF57uaXrFZvntfelpR4wt4luqJoEPPnM7KSHXHXDVUxRJe9UutfNeKTGO9kb4Q2BQgxZW
 j+LKXvU/mIR2mTWe8IWCcnFMYBJkbkBmbhfuzjmJJNZJDEFeE7rti5NZeMTyd3bRvs5x2D2I3
 1m0Nz+vumXjzzGEAozL9RScB1b8IP/nkXgqrHZmjFdJxUWocvSzbA152Dx13FUHqqGfGPW46U
 Y3oC8AVcmRtg7xanAkLgL6MdzCIWXQmNKSb6Pg6CtJcmOtdrgKWWbnPMPv3N3GJfIhWRt0+qc
 dlchhM5jH6tQaqXeL2c0SYDxOEbJlSHCsM9lxekn/jlUJWGn3SpLCWt2fHnbdUMQ2OgKP9T1l
 cy/9i9WY9uu6MZ0KLrmrWrXY0WxuKShgii4JyioxznzrsvunI9HWJW/BTi/0JNW19YZx2Qfkf
 CdfCyIAm93dKviqexO1OkRNEN2qTZvzqs39EPlwVU39xP1Um29EPKGF5RDsFgzrt2mceS53pe
 IwPUFJ8JdDilYveiCBawTwYV6Z9U2HLnbKOFNuYc3BuUQlvVrDtV0dXZpeGJsh47V+iAVKIbp
 lbTamU9YFrvv7mRO1
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 30 Apr 2020 19:06:17 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 30 Apr 2020 19:06:13 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Checking search results for two enumerations
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

SGVsbG8sCgpJIGhhdmUgdHJpZWQgYW5vdGhlciB0aW55IHNjcmlwdCBvdXQgZm9yIHRoZSBzZW1h
bnRpYyBwYXRjaCBsYW5ndWFnZQooYWNjb3JkaW5nIHRvIHRoZSBzb2Z0d2FyZSBjb21iaW5hdGlv
biDigJxDb2NjaW5lbGxlIDEuMC44LTAwMDI5LWdhNTQ5YjlmMOKAnSkuCgoKQGRpc3BsYXlACmlu
dCBpOwpAQAogcmV0dXJuCiogICAgICAgLWkKIDsKCgpBcmUgdGhlIGZvbGxvd2luZyBzZWFyY2gg
cmVzdWx0cyB3b3J0aCBmb3IgZnVydGhlciBzb2Z0d2FyZSBkZXZlbG9wbWVudCBjb25zaWRlcmF0
aW9ucz8KCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3Rv
cnZhbGRzL2xpbnV4LmdpdC9sb2cvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZXJzaWwvaG9zdGFw
L2hvc3RhcF9tYWluLmMKCmVsZnJpbmdAU29ubmU6fi9Qcm9qZWt0ZS9MaW51eC9uZXh0LXBhdGNo
ZWQ+IHNwYXRjaCB+L1Byb2pla3RlL0NvY2NpbmVsbGUvamFuaXRvci9zaG93X3JldHVybnNfb2Zf
bmVnYXRpdmVfaW50ZWdlcnMyLmNvY2NpIGRyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVyc2lsL2hv
c3RhcC9ob3N0YXBfbWFpbi5jCuKApgpAQCAtMzI4LDcgKzMyNyw2IEBAIGludCBob3N0YXBfc2V0
X2VuY3J5cHRpb24obG9jYWxfaW5mb190ICoKIAl1MTYgdmFsLCBvbGRfdmFsOwogCWludCBpLCBr
ZXlsZW4sIGxlbiwgaWR4OwogCWNoYXIga2V5YnVmW1dFUF9LRVlfTEVOICsgMV07Ci0JZW51bSB7
IE5PTkUsIFdFUCwgT1RIRVIgfSBlbmNyeXB0X3R5cGU7CgogCWlkeCA9IGxvY2FsLT5jcnlwdF9p
bmZvLnR4X2tleWlkeDsKIAlpZiAobG9jYWwtPmNyeXB0X2luZm8uY3J5cHRbaWR4XSA9PSBOVUxM
IHx8CuKApgoKCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0
L3RvcnZhbGRzL2xpbnV4LmdpdC9sb2cvc291bmQvZHJpdmVycy9vcGwzL29wbDNfbWlkaS5jCgpl
bGZyaW5nQFNvbm5lOn4vUHJvamVrdGUvTGludXgvbmV4dC1wYXRjaGVkPiBzcGF0Y2ggfi9Qcm9q
ZWt0ZS9Db2NjaW5lbGxlL2phbml0b3Ivc2hvd19yZXR1cm5zX29mX25lZ2F0aXZlX2ludGVnZXJz
Mi5jb2NjaSBzb3VuZC9kcml2ZXJzL29wbDMvb3BsM19taWRpLmMK4oCmCkBAIC0xMzYsNyArMTM2
LDYgQEAgc3RhdGljIGludCBvcGwzX2dldF92b2ljZShzdHJ1Y3Qgc25kX29wbAoKIAkvKiBUaGlz
IGlzIG91ciAiYWxsb2NhdGlvbiBjb3N0IiB0YWJsZSAqLwogCWVudW0gewotCQlGUkVFID0gMCwg
Q0hFQVAsIEVYUEVOU0lWRSwgRU5ECiAJfTsKCiAJLyogS2VlcHMgdHJhY2sgb2Ygd2hhdCB3ZSBh
cmUgZmluZGluZyAqLwrigKYKCgpXaHkgYXJlIHNvdXJjZSBjb2RlIHBsYWNlcyBwcmVzZW50ZWQg
d2hpY2ggZG8gbm90IGNvbnRhaW4gYSBrZXkgd29yZApJIHdhcyBsb29raW5nIGZvciB0aGlzIHRl
c3QgYXBwcm9hY2g/CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlw
Ni5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
