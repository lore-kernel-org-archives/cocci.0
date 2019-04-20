Return-Path: <SRS0=4SgN=SW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD037C282DD
	for <cocci@archiver.kernel.org>; Sat, 20 Apr 2019 07:30:43 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC7D9208C0
	for <cocci@archiver.kernel.org>; Sat, 20 Apr 2019 07:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="P3jmab2a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC7D9208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3K7UPZs010859
          ; Sat, 20 Apr 2019 09:30:25 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D94167735;
	Sat, 20 Apr 2019 09:30:24 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 58DD6772E
 for <cocci@systeme.lip6.fr>; Sat, 20 Apr 2019 09:30:23 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3K7UMPH001418
 for <cocci@systeme.lip6.fr>; Sat, 20 Apr 2019 09:30:22 +0200 (CEST)
X-pt: isis.lip6.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1555745422;
 bh=ShUfx2ZrWFzaqYxXSIZQfu0eRlNvOmzl1/D6tHEDpoE=;
 h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
 b=P3jmab2afsGnzJo+40tEZ/U7tX15AgIfjem70vkztzlTVQlci5APluXf7FKD8N2b4
 hp2mF1ZuWGyvWMAob12wrRHaJ2pbamfGGliU6YMsAYStdL59C9WNLKn4Ed1mgSrLPh
 E48YujKpvfoSHy0siyIXrtDBpgd17qq6SPU1Zf1I=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.4.177]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MYw1v-1hLr5C3zpz-00ViRK for
 <cocci@systeme.lip6.fr>; Sat, 20 Apr 2019 09:30:22 +0200
From: Markus Elfring <Markus.Elfring@web.de>
To: Coccinelle <cocci@systeme.lip6.fr>
References: <8d40a536-c2fe-7d6b-58d5-840e013665f1@web.de>
 <11a0c402-265c-4bc1-9cdd-244735dbc3e1@web.de>
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
Message-ID: <8c9c537c-60b7-a9da-9787-bf28a83b72e8@web.de>
Date: Sat, 20 Apr 2019 09:30:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <11a0c402-265c-4bc1-9cdd-244735dbc3e1@web.de>
Content-Language: en-US
X-Provags-ID: V03:K1:tFJooANkI+f/cmpnP0QyZoNvISEifogIGw7YrJgc73WU0/1BNrm
 TUyCKQfp0NakNFAW/Zmt689AqADDgYoTNn9qvFt30+s2BD/OzgoyP22PYfBq4ueytpGhE/j
 AWlgwPn0EW/Tz5MxDO5SIQK1uP0q+SI+5XOjXjNytC0aUEu+mnZbqUFY4QfazxSdta0OUP5
 xieTTiUENT+aUfhAAC+xQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UaWDwG1Rcyw=:T2EUN6jHjcTUOpKy3WAfmV
 1WvRO74ZODOpEk5L2BIKR8FfE8sGZaR5TgvjR9eBvve9shFi9WzG3sg4uNOb+sCWQQn0S/ROL
 VWChTE3uZr2OvV8xft+t0YN4M2TnKvobRF85xSOkoMAdDK44R2Qsebo5HiEsTFrEgtTBbYbLJ
 giuMhWJbO8VqYALZxdtio5QJIVyWvQmQ1lZ38NPCy7/53plHilK0wbWUjuqOpKmNWZqS0nvtW
 LQP2xJlvS8hsC6Ofk2qp2BYvRptpRBrxFhnwffE/zoRgHqiFVN8a+ExDQksNj+Qf4ZctR+g7u
 lSETIo7J0YDrOQh+DlYYp1haaGFmOJtHoQHtocB5VNx49Icfx4D+3LKWFCXf66gKqwBpPgVYs
 GmnpE//QmeZLTycWpgUOTSwhWWu7xTcRxVBwPa9c15JuvMZNQkUWqLHQkO6A1DBDSOocTBbeP
 c4+eQtaZQJwrhCOAHUDOtuG8dpkq3FywpfOe+QVw9+7eaKQhVT5GPTwzL7TunczrZ2deTwSz0
 1p4xtFKjNYk+YXBR6WGCUsDSum69CQmUQ0B4xK/vy1A81lS6RFdG/AIOMItT3YE8R7KgkrfRb
 c8+XnwrUfSM4q8qcQuTG4m7x96urjpZjESBkbtl5atLbgqgFzFjPoGZVHM5qZgYBX2lmZF7Fu
 MxDwpGZGJfu/dap5dBc0XdE7DSmkpUU0kwEmSaBgyvRNtDl7NONJx3qzdtmLhxPFU4Sz+LKc1
 CubQuJW3LaEPbrEyuAp1Va3o/ZDvD6RqNMlchiVyVpOuzh/ogchSBtjYEtCYGAOmhWHQ3K3Xz
 pnuzA3BfDtKEUkCAqD9XbLjqQowLiTvYrSPZXW6xQ57AM4AHqarDGtcilAWiUQab2CnPNm8HC
 jHccQ13ghOiSi85t9TPNr+fVcHqtLngJpPYMtxCJbWtC7ATv6Lw1E6FzUfcUrCbIpvAwricqc
 Z9jJ3UTqDgg==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 20 Apr 2019 09:30:25 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 20 Apr 2019 09:30:22 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Checking execution environment for Python code in SmPL
	scripts
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

SGVsbG8sCgpJIGNvbnN0cnVjdGVkIGEgU21QTCBzY3JpcHQgd2hpY2ggY2FuIHdvcmsgYXMgZGVz
aXJlZC4KCgplbGZyaW5nQFNvbm5lOn4vUHJvamVrdGUvTGludXgvbmV4dC1wYXRjaGVkPiBzcGF0
Y2ggZHJpdmVycy9tZWRpYS9kdmItZnJvbnRlbmRzL3RkYTEwMDR4LmMgfi9Qcm9qZWt0ZS9Db2Nj
aW5lbGxlL2phbml0b3IvbGlzdF9kdXBsaWNhdGVfc3RhdGVtZW50X3BhaXJzX2Zyb21faWZfYnJh
bmNoZXMzLmNvY2NpCuKApgpVc2luZyBTUUxBbGNoZW15IHZlcnNpb246CjEuMy4yCuKApgpzdGF0
ZW1lbnQxfHN0YXRlbWVudDJ8ImZ1bmN0aW9uIG5hbWUifCJzb3VyY2UgZmlsZSJ8aW5jaWRlbmNl
CmtmcmVlICggc3RhdGUgKSA7fHJldHVybiBOVUxMIDt8dGRhMTAwNDVfYXR0YWNofGRyaXZlcnMv
bWVkaWEvZHZiLWZyb250ZW5kcy90ZGExMDA0eC5jfDIKa2ZyZWUgKCBzdGF0ZSApIDt8cmV0dXJu
IE5VTEwgO3x0ZGExMDA0Nl9hdHRhY2h8ZHJpdmVycy9tZWRpYS9kdmItZnJvbnRlbmRzL3RkYTEw
MDR4LmN8MgoKClVuZm9ydHVuYXRlbHksIEkgZ2V0IGFub3RoZXIgdW5leHBlY3RlZCB0ZXN0IHJl
c3VsdCBieSB0aGUgZm9sbG93aW5nIGNvbW1hbmQuCgoKZWxmcmluZ0BTb25uZTp+L1Byb2pla3Rl
L0xpbnV4L25leHQtcGF0Y2hlZD4gc3BhdGNoIC1EIFVSTD1wb3N0Z3Jlc3FsK3BzeWNvcGcyOi8v
L21lZGlhX2R1cGxpY2F0ZXMxIGRyaXZlcnMvbWVkaWEvZHZiLWZyb250ZW5kcy90ZGExMDA0eC5j
IH4vUHJvamVrdGUvQ29jY2luZWxsZS9qYW5pdG9yL2xpc3RfZHVwbGljYXRlX3N0YXRlbWVudF9w
YWlyc19mcm9tX2lmX2JyYW5jaGVzNC5jb2NjaQrigKYKVHJhY2ViYWNrIChtb3N0IHJlY2VudCBj
YWxsIGxhc3QpOgogIEZpbGUgIjxzdHJpbmc+IiwgbGluZSA0LCBpbiA8bW9kdWxlPgpOYW1lRXJy
b3I6IG5hbWUgJ3N0b3JlX3N0YXRlbWVudHMnIGlzIG5vdCBkZWZpbmVkCmV4biB3aGlsZSBpbiB0
aW1lb3V0X2Z1bmN0aW9uCuKApgoKClRoZSBmb2xsb3dpbmcgZGlzcGxheSBzaG93cyBpbnRlbmRl
ZCBkaWZmZXJlbmNlcyBiZXR3ZWVuIHRoZXNlIFNtUEwgc2NyaXB0cy4KCgogQGluaXRpYWxpemU6
cHl0aG9uQAorVVJMIDw8IHZpcnR1YWwuZGF0YWJhc2VfVVJMOwogQEAKIGltcG9ydCBzcWxhbGNo
ZW15LCBzeXMK4oCmCi1lbmdpbmUgPSBjcmVhdGVfZW5naW5lKCJzcWxpdGU6Ly8vOm1lbW9yeToi
LCBlY2hvPUZhbHNlKQorCitpZiBVUkwgPT0gRmFsc2Ugb3IgVVJMID09ICJkZWZhdWx0IjoKKyAg
IFVSTCA9ICJzcWxpdGU6Ly8vcmVzdWx0LWR1cGxpY2F0ZXMuZGIiCisKK2VuZ2luZSA9IGNyZWF0
ZV9lbmdpbmUoVVJMLCBlY2hvID0gRmFsc2UpCgoKVGhlIGN1c3RvbSBmdW5jdGlvbiDigJxzdG9y
ZV9zdGF0ZW1lbnRz4oCdIHNob3VsZCBiZSB1c2FibGUgaW4gYm90aCBzY3JpcHQgdmFyaWFudHMu
Ck5vdyBJIHdvbmRlciBhYm91dCB0aGUgc2hvd24gc29mdHdhcmUgYmVoYXZpb3VyIGFnYWluLiBI
b3cgY2FuIGl0IGJlIGZpeGVkPwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0
ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2Nj
aQo=
