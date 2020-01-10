Return-Path: <SRS0=VaV3=27=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A72C33CA2
	for <cocci@archiver.kernel.org>; Fri, 10 Jan 2020 10:01:23 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDBE020721
	for <cocci@archiver.kernel.org>; Fri, 10 Jan 2020 10:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="oOYBrlLh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDBE020721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00AA14w1015988;
	Fri, 10 Jan 2020 11:01:04 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7368E77E3;
	Fri, 10 Jan 2020 11:01:04 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 506C277DC
 for <cocci@systeme.lip6.fr>; Fri, 10 Jan 2020 11:01:02 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00AA0x9k010066;
 Fri, 10 Jan 2020 11:00:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1578650442;
 bh=i7u0dEdG+1HRoiQBreS19z9Ai2z+JNRMC/5uuUcDg/k=;
 h=X-UI-Sender-Class:Cc:References:Subject:From:To:Date:In-Reply-To;
 b=oOYBrlLh9LMMfmh8rAlevK4TwSELeJVUORccIP2sFmAUa5RxBfV6INVem4t4fmkCN
 47uCP7r6ILmC/4jJaPcYlUFJNvmMhGuBOmdphWb378q0cEnOv0ZykuqA3kXTy3l4jb
 PDcwMSzTSKa3n8x42sPiGJHIcfGomAZaJTq9/vHk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.170.191]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M7blv-1jeGSc3nTb-00xM8x; Fri, 10
 Jan 2020 11:00:42 +0100
References: <20200107170240.47207-1-wenyang@linux.alibaba.com>
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
To: Wen Yang <wenyang@linux.alibaba.com>, cocci@systeme.lip6.fr,
        kernel-janitors@vger.kernel.org
Message-ID: <b6e7b8ac-4de8-00a0-d12c-ebf727af3e26@web.de>
Date: Fri, 10 Jan 2020 11:00:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200107170240.47207-1-wenyang@linux.alibaba.com>
Content-Language: en-US
X-Provags-ID: V03:K1:fSGc6wyCT3FrYyBtnOzeymSNpMPTNYU48InLxdnbDmwKwrglERK
 s4rDmV76Q6ZTiiQhFkXNJ12SY+/NHnFzBGazv4D3DYFDpUuKrY0RoRC5ViBBVtmWfFprAbF
 7VfX22MspQr8I8+JtTlUfE47+oDJHyZQ8SfqzzjTraa1QDoS+pCVibgLGUVHzao9AiFP9C8
 kZ80yY22FEuhp1s9D1baQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+HZr2eRRuu0=:RnoWqOfAdgsShgcvEdRNvM
 Ds41z/5wD+zAGJMS5lBDDIq2DnwzIz0KCtoKgmP/68is01ahDZrkPPOkckhwXM1/c1zpEhMmD
 7Z2PuhkASaAqnJ9JTxmG+xJvBaGrNzMD2F0dT0HaMYF7I33hEDLEyYmpVTo89MUDgqrtHYIDH
 kPWej82t0u7hdMuVZ5jKt0eaqPhopmoSxTcnTu0Jpomyiyemr89raEyptLcDSwvLCi6blSUXi
 lr8KryIwFEaIrYYrhYIX3PXkNzdQuKL7cgCqEcyd6PUW3CpAok60V2UQKh5vA3Wq1vMEj3oIQ
 MQvufef22uJOjcf5QfuTDIZhBZv2kb+1SQ07xR01o4vcXvUhDc8uJsoVxGtUdTBXBS6bEPY2e
 ehCnKjOi3NtdeU1rhkCaUROauFooK8fxP9tETAjieLEQdESphZuvLBKeUfKzEmMDCEm9Yq+Gt
 h4Jc1J+U57LI+K//ul56vBOF8I9qUp+2tMOD63KI4w/8xttJgvG3/3IR2NTLm83jyauvt9fcW
 KgGShM4qOEackGtnLV9J4+GfnSqHmb8WP5CF0Oq7792kHm7EdEzD6/tBuZunlmaTWODLnddqu
 ooyg5ZkTwYqoGOhlK8etKP6uxZ5Wuz4tSKdrABeeBgydII0QE6LeqgWEHUn2itRd1NLc02Vb4
 3iX6mfU0SEyBkTWPoUVEWa5t/mI9UZ5nv9oMlZYAOcZpCny70bYiJ/lnqZ5jjlROdse1DSlmk
 oOoNxmqRJbdnopYtlgiLMXjMZPEBRrTWLDJCBNLhkDKbig6EugFvoC+uk7tkp/tYIFs6HX+u2
 vswZQDs35zevUF9YtgsGkFtU6iqTBC9BAh2OMkf10nEwgrlb9ujsWrR7fFrRxvS1ai5UnJM6c
 OyQcx5NeavezPZXieTdlOTiHJYcqr0Y2io/NOgC7XnPp4k4hE7TZIq3ycjtpkLAiVRUXdXLxu
 PvoGgeX876bjt4lH6bIv0eZw9YTvoBUUMuz3eMxTudEvd8Tv16rE++FnkqJDtwm/y953sHsMv
 g3EyL4AwM262P2ei4lsVOiPHrB/FATyyXdjs1fjuQf4JAZwN2LDTkpJ0oGDjzJVx+YlD0wBR6
 grglnKrsJS7HrtX0OSr5MNwiRwYDIuYBQW9l0FWwGpDksdPyP+5KTsfLNkxCYsHoU1ffFYZnf
 PkV8c8ohz4U4MXiQrAn4oo8cicGV6ZvOCF5x8dCx+vPvOqylGWEt/nz6cmAMAqLJX/dox4QwI
 GO+P+4i18gFbCx3i36l4KNh4T3jrbGQtzcBz/kccWonQZCfckYDxu9nHlb/A=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 10 Jan 2020 11:01:04 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 10 Jan 2020 11:00:59 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        =?UTF-8?Q?Matthias_M=c3=a4nnich?= <maennich@google.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Cocci] [PATCH v2] coccinelle: semantic patch to check for
 inappropriate do_div() calls
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

PiArQGluaXRpYWxpemU6cHl0aG9uQArigKYKPiArZGVmIGNvbnN0cnVjdF93YXJuaW5ncyhzdHIs
IHN1Z2dlc3RlZF9mdW4pOgoKVGhpcyBmdW5jdGlvbiB3aWxsIGJlIHVzZWQgb25seSBmb3IgdGhl
IG9wZXJhdGlvbiBtb2RlcyDigJxvcmfigJ0gYW5kIOKAnHJlcG9ydOKAnS4KVGh1cyBJIHN1Z2dl
c3QgdG8gcmVwbGFjZSB0aGUgc3BlY2lmaWNhdGlvbiDigJxpbml0aWFsaXpl4oCdIGJ5IGEgY29y
cmVzcG9uZGluZyBkZXBlbmRlbmN5CndoaWNoIGlzIGFscmVhZHkgYXBwbGllZCBmb3IgdGhlIFNt
UEwgcnVsZSDigJxy4oCdLgoKCkNhbiBzdWJzZXF1ZW50IFNtUEwgZGlzanVuY3Rpb25zIGJlY29t
ZSBtb3JlIHN1Y2NpbmN0PwoKClRoZSBwYXNzaW5nIG9mIGZ1bmN0aW9uIG5hbWUgdmFyaWFudHMg
Y29udGFpbnMgYSBiaXQgb2YgZHVwbGljYXRlIFB5dGhvbiBjb2RlLgpXaWxsIGEgZmVhdHVyZSBy
ZXF1ZXN0IGxpa2Ug4oCcU3VwcG9ydCBmb3IgU21QTCBydWxlIGdyb3Vwc+KAnSBiZWNvbWUgbW9y
ZSBpbnRlcmVzdGluZwpmb3IgdGhlIHNob3duIHVzZSBjYXNlPwpodHRwczovL2dpdGh1Yi5jb20v
Y29jY2luZWxsZS9jb2NjaW5lbGxlL2lzc3Vlcy8xNjQKClJlZ2FyZHMsCk1hcmt1cwpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxp
c3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4v
bGlzdGluZm8vY29jY2kK
