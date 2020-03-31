Return-Path: <SRS0=cR8/=5Q=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA23C43331
	for <cocci@archiver.kernel.org>; Tue, 31 Mar 2020 06:29:28 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32FFE206DB
	for <cocci@archiver.kernel.org>; Tue, 31 Mar 2020 06:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="DcvUn9hs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32FFE206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02V6TBSG006785;
	Tue, 31 Mar 2020 08:29:11 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 04D3B780F;
	Tue, 31 Mar 2020 08:29:11 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D1518780C
 for <cocci@systeme.lip6.fr>; Tue, 31 Mar 2020 08:29:08 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02V6T8uh004082
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Tue, 31 Mar 2020 08:29:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1585636145;
 bh=59JCH7rvEJAUTHzaJobi4qhfe3GG3j0Ot54u55DG2AA=;
 h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
 b=DcvUn9hsJD+FiePWYsi0KlVCcepPauvctsW9DNCdzeOi+NOP9iMNtgDXoFPmAFSq1
 F46a3oBrdf7r0QWuhOx1ZokzRq9Id/WVQAWAgOP23R8mMnVdriuK5gZpVVNWZTRtG1
 xbl/5MUWkOKWeiJN/StyEI4gn+YYPP+UA9XKyzZQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.19.229]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LZvfZ-1iwBRM20qb-00liNR; Tue, 31
 Mar 2020 08:29:05 +0200
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
To: Joe Perches <joe@perches.com>, Julia Lawall <julia.lawall@lip6.fr>
Message-ID: <d4d9bd0a-6bbf-3557-0726-e46cde5c8e2e@web.de>
Date: Tue, 31 Mar 2020 08:28:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:8rfMDRFNgAAVfZbnGdSNhxqQbvZYXROImR+hLen3yyTeP/uVt0W
 ImIVJeSvcUC9qW1E6FM4OoE4vFNE4f7wcIBnywXoAiIHf0Q0FeShZurCJaJIfEosBhmck4g
 V1liHvUD7TznkponZlvwGbgMKFpyCN7vCrRvP3onkzGA8ksW4yLRHeEA6zBPF4cstxI/URp
 aA7nHp0VJU1EBYH5O1AlA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:m/+KhFpfFzY=:kn8mQc2FBq/XRI+h+SdDk1
 gKEuhyqKkx3zEha0HTATX6XC2Qei+9oXl9+xCjKx2aWJxZT48N5ZaWpEcnb+kWFxP/LDdyL9V
 8UZtjYJSR6YVPBJC/TKkuH9MuI/CsK3JtVGZUO+Zmy88rN9w6CcCwNAIdI+EqCCDL4UkkINr2
 9pny9n6n67ZjCPQgBrPqxt4rMp/z/Ri+TB1AP6aLRo0NuWD8eS5qSHWEpSLlfZN1JdaqrDWJ7
 JpABznm7stSofSmE8ub37PlM2tK14+dsltGOLhIyOzg0MljyioCEm+n049LMFg2rW2zamkzJT
 kIgTmqcezz8pXkhQnJfSRLyy1fwX4cumbD9f8oyB2BsalS85dH1maff3YNL7uB+T6BuZwVl/w
 ntyC3l9FTA5t5YOf9AwXalHmNY4xCglsENK06FXxFllFKpcjJ2bsVqfzrQ0tuIfqC9kDcem3v
 Q1Lzb2ijdBmCj6aBc6AaSH2rlDf3iG3PEfe9qtrkvljNAZY7tzBnVCXwXzLs+eLD6TpcbXbyz
 u8TovzxvMBMU3wULrQUcUQ+AY+PKS7jiVOlheDycaehHwxKQ3lvlWtoagwXdESzXHB7/Zfn+q
 YTQdaAbddOLcro8CvcsbrG+sTH1lfcYENctQtexGqkh1eHP8QOpCHPPydxx8z7OIggVMVsex0
 XS6bJKla0461YVhkoPr2+k6r5DrpbE0fklO7Q2OP1Vmd8OYI0K2YDOVwNtFBAsil8lN5/DUyi
 ZI2udAhxEaJJhxOmKo6wpzW2auoQhUp4wv/Wu/y61UX6xAlE9JQyfrj/UQt6ojwgPM0YLnslC
 kKunsr0ENe6Z8Ds8riRs8xsty5SfpuXrIX5iPIpRaBickwZ8rCTbINciGJWdrFzdxAthTQ4OT
 DfFZzg4uKwvu0bnqt+jwrriuMtDMVTO0y/Q19zBkC/cABcUqoZ9bxDvC83P3pGW/MYv8aVqKS
 wLc2pb2Q0yb72FVuq02rFIylNydNTRKwamjKksYDKc5GUEgglP/WeCzxi90g0vN02dBVWTsec
 thtQjJsUlbdYgV2mR9uqmY+akToWqQFlwHjc1MISiBEZA9w0bq4qtzU7Uz1GlS8gjyL2MDCkl
 Cx9/vOEzyIH4HwnJmsY/8pM0Bl4Xa9tzdOjZ1voTUg6cGxwagJog9s+D91VErVSwjP3raAAxd
 dfnSOEvk6AvhbdlkJBGpGTtNnoV0oU9S5I5F99RIddY3vdiKElyA9L3jknUjHgUUhjWPsgwCB
 lT0FMKk6Fuey5k4n4
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 31 Mar 2020 08:29:11 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 31 Mar 2020 08:29:08 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] linux: special logic in repetitive tests
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

PiBUaGVyZSBpcyBhIGJsb2NrIG9mIGlmIHRlc3RzIGFnYWluc3QgdGhlIHNhbWUgdmFyaWFibGUK
PiBpbiBpbmNsdWRlL2xpbnV4L210ZC9wZm93LmggdGhhdCBsaWtlbHkgaXMgZGVmZWN0aXZlCgpJ
IHdvbmRlciBhYm91dCB0aGlzIGludGVycHJldGF0aW9uLgoKCj4gTGlrZWx5IHRoZSBmaXJzdCB0
ZXN0IHNob3VsZCBiZSBzb21ldGhpbmcgbGlrZQo+Cj4gCWlmICgocHJvZ19zdGF0dXMgJiAweDAz
KSA9PSAweDAzKQoKV2h5IHdvdWxkIHlvdSBwcmVmZXIgc3VjaCBhIGNvZGUgdmFyaWFudD8KCgo+
IElzIHRoZXJlIGEgd2F5IGZvciBjb2NjaSB0byBmaW5kIHRoaXMgc3R5bGUgb2YgYml0d2lzZSBs
b2dpYyBkZWZlY3Q/CgoqIFByb2JhYmx5LCB5ZXMuCgoqIEhvdyBvZnRlbiB3aWxsIHRoaXMgaW1w
bGVtZW50YXRpb24gZGV0YWlsIHJlYWxseSBiZSBhIOKAnGRlZmVjdOKAnT8KCiogV2hlcmUgZG8g
eW91IHN0dW1ibGUgb24gZGlmZmljdWx0aWVzIHRvIGV4cHJlc3MgYSBjb3JyZXNwb25kaW5nIHNv
dXJjZSBjb2RlCiAgc2VhcmNoIHBhdHRlcm4gYnkgdGhlIG1lYW5zIG9mIHRoZSBzZW1hbnRpYyBw
YXRjaCBsYW5ndWFnZT8KClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5s
aXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
