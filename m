Return-Path: <SRS0=wUuY=YI=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB695ECE58C
	for <cocci@archiver.kernel.org>; Tue, 15 Oct 2019 19:18:29 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2219B20854
	for <cocci@archiver.kernel.org>; Tue, 15 Oct 2019 19:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="c2vIe/d9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2219B20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9FJI7is012552;
	Tue, 15 Oct 2019 21:18:07 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id EAA0377B5;
	Tue, 15 Oct 2019 21:18:06 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B14EF77B2
 for <cocci@systeme.lip6.fr>; Tue, 15 Oct 2019 21:18:04 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9FJI3fJ026031
 for <cocci@systeme.lip6.fr>; Tue, 15 Oct 2019 21:18:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1571167083;
 bh=2Cubj713OeubWB+JxJ9a+eZVjQXwhNIx80Gu4SqWHN4=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=c2vIe/d9lmNu0OkjjMN3WpmE4kJPWJ7iCrdGEi5IRD/7w0EtChhqjEA8CHrgFbotg
 N3bLfrz/8qZdwwVJ3vRojlG+E0qsaodhLCff8c6MP8ez4ydP3pOlumoNcDmCw4dZA7
 jI5Y3yedwlJlbG0AHZS/FXUe7Yr9HJKNclgOlqEQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.79.11]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lto05-1htTcE0sCb-011BJB for
 <cocci@systeme.lip6.fr>; Tue, 15 Oct 2019 21:18:03 +0200
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
Message-ID: <150a0b3d-4f68-cf65-2fce-d78dcdbebf0a@web.de>
Date: Tue, 15 Oct 2019 21:18:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:TfejD/IknZNCjqNiQcAM6N/Z17G8C2DXaQjC66vJqiN2oVIxOig
 +gbbLNd8x7Sam4YOt307bcXsOwCHglFu7Kf9/7pJADpZG/8+AChyab2SBauZFh8CACoKvw5
 0XQNOASVRw03BmpItO0nTPbcY8aRcxPKhyj4sZXNEEAPJwL5q6yO1s/Nr9Qz3HCZIrkigZE
 5mUWGibxliKkDNSbMUELA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TTefIITfgRA=:2G68adhzvZqVhbCF8QKtLI
 x3b7P/IExQ8y15DLgAzaVNpz1l/2B2oe0yRmIRRgUwHzhZF9S2G4yxbaE348wPDIcuMrfXCXt
 XBW+0OEZ60mqFgvfHfNoSv+XCvgpPhVp8uS/I6W0+kknHssaf3HIJx45LH8ZDvPBSapuEfgRl
 3epw8tuP/tORCUO+5cYS734KVyN5taSKVEs3LVZjlT2exiIh5VhDr5C+V9Sg7yywyft1qryOb
 HzNXay4ZwePNopNKJhK0uZX1vgeTENsKTquDeH5VBGZdnQ0SX10cinlue6wRRYQsB2dVmGqyX
 YBHXRzdPRivX9/60n/J7CTrbE4IYHIC2IrW88YtAC8Zfg2y8arrVDxszPxsKtkONJNY89Dnp/
 AH5wLneoMbrzTVZguFiVUON9gjWWZnR2sRRWfDIJKnOgJOaGt0e+60Lp6hAwUut/OE3CwbTMc
 xypt+9TzqTpNXaAGpPMCKHWGcuJl59zYxpMhPMdecI5A4+5e0lDFuuF9W2MugSckB60qAL3w2
 kO6s9RIkz3M2CPhjvNwaWubMbxf1jAW4oOxw7KaPzThxfv+02k64s/R1BDom7EJ8v5Ik6ytae
 1h8Wq9JavH1x8xcXv9yKKyco7/bsNKEvp6uYDuxbGjdIUf2IN2pY8qAjz3Uf8tsgK4X48epwg
 WvysGeh12bY3WGzmQQ2/yIvx3EC0cdjKS45JYoRg0yoanBbddDEXuAChHJWMMOIDTtTRiFcXY
 BxPPEIlAA9otFxh/noxdb40TBoWQR8ncV1NByfeNX+eUYGYs4ZMfwoR57XEbaN2+tHRYNfA+F
 Ruqt/R9O/IJjhPHqkBEPAxn76L81cAq9UF6S2Mu2Ocr2WZGHsZeRSkqmAPiN0R3FCVzEUbHRX
 x26bqgp08S0Xlbir/xJ91W5ik7TKsuRlrhvk8bO0ns99uMED63cjpWOd4g1dtBZyWlECOm2he
 834vPeYN4/82MiYL380vNJfZcKKbIKS2J6rofeHLz5aXgG92r+xOWFR7xzCzNI6Ol0w0vk9N1
 ElS4M47hWAK7+U0wqA3liDc9Jn7EVhlkt0g2boZ5iSZd7BSjJTFTuMpE2ubIvTcT6DqPaDaW/
 TYFubjariW4AxRqc4FekvEC9aiyJcobW9NCLcR3syyPxguZ+7eJMacv/vXK6Tjxyp5Os9E0Zs
 G7Qf2o/981e/FZoqMTxE1Mo2EPITF+QFrfNZRlBLquZVndV8mGJSo+v3ODZCQ7o+sgzJQhlhL
 euA7zIvmd2rLOBlSxYMl2g8zvbYE/4CqXkr4agQnrCGcCrwwzLm6r9ZD9TDE=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 15 Oct 2019 21:18:07 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 15 Oct 2019 21:18:03 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Converting a function return type to void based on a SmPL
	constraint?
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

SGVsbG8sCgpJIGhhdmUgbm90aWNlZCB0aGF0IGFuIHVwZGF0ZSBzdWdnZXN0aW9uIGNhbiBiZSBw
cm92aWRlZCBmb3IKYSBzb3VyY2UgZmlsZSBieSBhIGtub3duIHNjcmlwdCBmb3IgdGhlIHNlbWFu
dGljIHBhdGNoIGxhbmd1YWdlLgpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgv
a2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9zY3JpcHRzL2NvY2NpbmVsbGUvbWlz
Yy9yZXR1cm52YXIuY29jY2k/aWQ9OGUwZDBhZDIwNmYwODUwNmM4OTMzMjZjYTdjOWMzZDljYzA0
MmNlZgoKVXBkYXRlIGNhbmRpZGF0ZToKYnRyZnNfZGVzdHJveV9kZWxheWVkX3JlZnMoKQpodHRw
czovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92NS40LXJjMi9zb3VyY2UvZnMvYnRyZnMvZGlz
ay1pby5jI0w0MjUyCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwv
Z2l0L25leHQvbGludXgtbmV4dC5naXQvdHJlZS9mcy9idHJmcy9kaXNrLWlvLmM/aWQ9MGU5ZDI4
YmM2YzgxZjQ3Zjk0OTc5ZWM3ZDBhYjZhYzQyMzQ1ZmNlZSNuNDI0MwoKSSBnb3QgdGhlIHNvZnR3
YXJlIGRldmVsb3BtZW50IGlkZWEgdGhlbiB0byBjaGFuZ2UgdGhlIGZ1bmN0aW9uIHJldHVybiB0
eXBlCnRvIOKAnHZvaWTigJ0gdG9nZXRoZXIgd2l0aCB0aGUgZGVsZXRpb24gb2YgcmV0dXJuIHN0
YXRlbWVudHMgYnkgdGhlIGhlbHAgb2YKdGhlIHRvb2wg4oCcQ29jY2luZWxsZSAxLjAuOC0wMDAw
NC1nODQyMDc1ZjfigJ0gaW5zdGVhZCBvZiBhZGp1c3RpbmcgcmV0dXJuIHZhbHVlcy4KCkByZXBs
YWNlbWVudEAKY29uc3RhbnQgQzsKaWRlbnRpZmllciBhY3Rpb24sIHJjOwp0eXBlIFQ7CkBACiBz
dGF0aWMKLVQKK3ZvaWQKIGFjdGlvbiguLi4pCiB7Ci1UIHJjID0gQzsKIC4uLiB3aGVuICE9IHJj
CiAgICAgd2hlbiBzdHJpY3QKLXJldHVybiByYzsKIH0KCgpVbmZvcnR1bmF0ZWx5LCBJIGRvIG5v
dCBnZXQgdGhlIHRyYW5zZm9ybWF0aW9uIHJlc3VsdCB3aGljaCBJIHdvdWxkIGV4cGVjdApmb3Ig
dGhpcyBhcHByb2FjaC4gQnV0IEkgaGF2ZSBub3RpY2VkIGFsc28gdGhhdCBhIHNpbWlsYXIgU21Q
TCBzY3JpcHQKY2FuIHdvcmsgYXMgZXhwZWN0ZWQgKGlmIGEgZnVuY3Rpb24gbGlrZSDigJx1bnBp
bl9leHRlbnRfY2FjaGXigJ0gd2FzIG5vdCBtYXJrZWQKYXMg4oCcc3RhdGlj4oCdPykuCldvdWxk
IHlvdSBsaWtlIHRvIGFkZCBhbnkgYWR2aWNlcz8KClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QK
Q29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlz
dGluZm8vY29jY2kK
