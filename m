Return-Path: <SRS0=5Xvi=VB=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A44C06513
	for <cocci@archiver.kernel.org>; Thu,  4 Jul 2019 11:41:21 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6741E20828
	for <cocci@archiver.kernel.org>; Thu,  4 Jul 2019 11:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="CdHRtIug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6741E20828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x64Bf1mZ004630;
	Thu, 4 Jul 2019 13:41:01 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 67300777C;
	Thu,  4 Jul 2019 13:41:01 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 341D8777A
 for <cocci@systeme.lip6.fr>; Thu,  4 Jul 2019 13:40:59 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x64Beu0j005709;
 Thu, 4 Jul 2019 13:40:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1562240456;
 bh=9p760TEAo8pcY40kIfYzIWjfyQ+5Mzs9D8XknO6CmNU=;
 h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
 b=CdHRtIugRdyJhuOlh/UVhsJ8a5+j8UxM0nvXXVYAQK9R/y2sGHWwe7NH+CDgo1B9W
 Ub41EmmdtwdWvdTOSr0+KTzBahmWa/YbwysUxpBcUTfYlPY8aITT6NOeZCLOJn4Uci
 lPEi5phg1bAtOQ1PsmYqHF5LUt0kzlobxItcjyVA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.138.50]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LbJCQ-1iPBcg0X0c-00kxva; Thu, 04
 Jul 2019 13:40:56 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <3d2a9d9a-790c-a0f0-f980-b560504babb9@web.de>
 <alpine.DEB.2.20.1907041233010.3517@hadrien>
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
Message-ID: <eb4f2434-99cf-e7d5-9f0d-d0c9cc539785@web.de>
Date: Thu, 4 Jul 2019 13:40:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1907041233010.3517@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:UoqflcHIjlbrHTBWPfknJKDOhLgsew0IDzfRQsYGTXaG4dRDRDc
 AthkzWD8+PED780jcLtR4v3BG1YmFm+DiN+iZv1ocBp/bAak/kpDmeh1E8+sL5nIj0RQQ4i
 +TAaYjPcXUc5oxD7Z1D2BNI1XpumxRjEA1rCsWIvPWoSezRuxxBZQgVAJiPM9DZIgpcjzB8
 RJJCY2Zq0utLyvRKpY58A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GNg1jsC0V6c=:+MrCF1VF1ccXZKYLNYS5tX
 dYMnivD/m36dm3oCUO9uRp+cebJEbAhvdoXhGzf+31HgqVddrDQABNjMq+8/3yxaSRdtDkjD0
 fsR1YNMgvuUQbTClYG+Z6Rlo2Az7IJtRVvt0gEI1xqUb9l4Tg2Lrxude+JOPX1dvpe34zj9rL
 dCb841Tx4jFNaK4mz0O+rcoZKvApihypF9jQYyFca/VPJFoRabe3aYNEhpbRbYo5x5bCAIxQl
 aJKOaNvvkbyw+0mKN/hkr5c7JFw0bEXhuf1ayk3BcbQTwrEb90Gj+V4tZ6ASTHBbNJmmLdCZY
 71ZXVCP57xWQC3RpC9GUGLXviXPbvOfpK/EnL8N0WXzqh/Fu/mMlEMJPxSw7Nyk0p3GVx2NcR
 plTkr3wK9eUMV8DUnIDPIIfQSlbqTRBtgAoAtL0amEH0Bm5Wf9CR3rtNW/Bvo4GqpQC2enZ3B
 Jyfft1tQ4BdWGqIN3erdBmDWZ+YsdTH2QSdgZn5xy3PDekVcBT3sLk2oXINhkmBIc+kDnP9o4
 ti9vIlMjuhnVygsFzWZhN1mSZlp+A1+cL1DzdwUoX+NSpOu3QXubgEzwq0YZHHg84Xtv9O2Uc
 UXtueAT5ZMWiS2WZGRo+VUDhNDdZT45WnVD59t74oZ8vuu9HHmA3+lSUVnbro7q4gQ8JgNG4p
 4DxuW/Izyc7op2SOnUGO6wLjx7QOlmA4d18V22aIIuJ6GuDXvC79mdnUctNZCd6wczCD49N+a
 UhXbO3QS42PikC0O4bqqc9MDy/QDnDd31j6+6bZnxoEJSvZG45YIsFhfWO5d5NzTBMw8OJPXh
 VYzS/AxoRIS3mlWmCmfPDG87Qz3BM8/Di0e5pOR3w2svJZWxoI8hLkhWZZ8AQ71oG3QMPbVD/
 GISYVguaIiPI/C5bCcBp4TiGGlLLTqWMibD6M/cM8si+SdXJnnElzHaqqjf90ASqCuAjiZwex
 6KnRtFxSRHEemuLuy97ehtEYtk+Ez6ZKV/QZ4tbyKjUKtHYPGgjMF3orJVEh0Z47C+kqE/jJB
 4KzX8z0S//V4xzr0rzp9SCHeK8XlHMHWkRVjs/0juzCD9qsVv9AEvyNHFBdtGidjaQ90XSfzj
 cl+gn7FeD+e3dfc3N863I5h5Lm6Kjupl3AW
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 04 Jul 2019 13:41:02 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 04 Jul 2019 13:40:57 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Pretty-printing of code for ternary operators?
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

Pj4gV291bGQgeW91IGxpa2UgdG8gYWNoaWV2ZSBhbnkgaW1wcm92ZW1lbnRzIGZvciBhdXRvbWF0
aWMgY29kZSBiZWF1dGlmaWNhdGlvbj8KPj4gaHR0cHM6Ly9naXRodWIuY29tL2NvY2NpbmVsbGUv
Y29jY2luZWxsZS9pc3N1ZXMvMzcKPgo+IElmIHlvdSB3YW50IHRvIHJlcG9ydCBhIHByb2JsZW0s
CgpJIGJlY2FtZSBjdXJpb3VzIGFnYWluIGlmIG1vcmUgY29udHJpYnV0b3JzIHdvdWxkIGJlY29t
ZSBpbnRlcmVzdGVkCnRvIGluZmx1ZW5jZSBhIHBvc3NpYmx5IGtub3duIHNvZnR3YXJlIHNpdHVh
dGlvbiBhIGJpdCBtb3JlLgoKCj4geW91IG11c3QgaW5jbHVkZSBhIHNlbWFudGljIHBhdGNoCgpA
cmVwbGFjZW1lbnRACmV4cHJlc3Npb24gY2hlY2ssIGNvbnRleHQsIHgxLCB4MjsKaWRlbnRpZmll
ciBhY3Rpb247CkBACi1pZiAoY2hlY2spCi0gICBhY3Rpb24oY29udGV4dCwgeDEpOwotZWxzZQot
ICAgYWN0aW9uKGNvbnRleHQsIHgyKTsKK2FjdGlvbihjb250ZXh0LCAoY2hlY2spID8geDEgOiB4
Mik7CgoKPiBhbmQgQyBjb2RlIHRoYXQgZ2l2ZXMgYW4gdW5zYXRpc2ZhY3RvcnkgcmVzdWx0LgoK
U291cmNlIGZpbGUgZXhhbXBsZToKaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4
L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUvbW0va3NtLmM/aWQ9NTUwZDFmNWJk
YTMzZmEzYjIwM2Q4Y2Y4ZGYxMzk2ODI1ZGJmZDIxMyNuMjUwMApodHRwczovL2VsaXhpci5ib290
bGluLmNvbS9saW51eC92NS4yLXJjNy9zb3VyY2UvbW0va3NtLmMjTDI1MDAKCgovLyBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5CgovLyBEZWxldGVkIHBhcnQKCmludCBfX2tz
bV9lbnRlcihzdHJ1Y3QgbW1fc3RydWN0ICptbSkKewoJc3RydWN0IG1tX3Nsb3QgKm1tX3Nsb3Q7
CglpbnQgbmVlZHNfd2FrZXVwOwoKCW1tX3Nsb3QgPSBhbGxvY19tbV9zbG90KCk7CglpZiAoIW1t
X3Nsb3QpCgkJcmV0dXJuIC1FTk9NRU07CgoJLyogQ2hlY2sga3NtX3J1biB0b28/ICBXb3VsZCBu
ZWVkIHRpZ2h0ZXIgbG9ja2luZyAqLwoJbmVlZHNfd2FrZXVwID0gbGlzdF9lbXB0eSgma3NtX21t
X2hlYWQubW1fbGlzdCk7CgoJc3Bpbl9sb2NrKCZrc21fbW1saXN0X2xvY2spOwoJaW5zZXJ0X3Rv
X21tX3Nsb3RzX2hhc2gobW0sIG1tX3Nsb3QpOwoKLy8gRGVsZXRlZCBwYXJ0CgoJaWYgKGtzbV9y
dW4gJiBLU01fUlVOX1VOTUVSR0UpCgkJbGlzdF9hZGRfdGFpbCgmbW1fc2xvdC0+bW1fbGlzdCwg
JmtzbV9tbV9oZWFkLm1tX2xpc3QpOwoJZWxzZQoJCWxpc3RfYWRkX3RhaWwoJm1tX3Nsb3QtPm1t
X2xpc3QsICZrc21fc2Nhbi5tbV9zbG90LT5tbV9saXN0KTsKCXNwaW5fdW5sb2NrKCZrc21fbW1s
aXN0X2xvY2spOwoKLy8gRGVsZXRlZCBwYXJ0CgoJcmV0dXJuIDA7Cn0KCi8vIERlbGV0ZWQgcGFy
dAoKCkFub3RoZXIgdGVzdCByZXN1bHQ6CgplbGZyaW5nQFNvbm5lOn4vUHJvamVrdGUvQ29jY2lu
ZWxsZS9Qcm9iZT4gc3BhdGNoIC4uL2phbml0b3IvdXNlX2NhbGxfd2l0aF90ZXJuYXJ5X29wZXJh
dG9yMS5jb2NjaSBrc20tZXhjZXJwdDEuYwrigKYKKwlsaXN0X2FkZF90YWlsKCZtbV9zbG90LT5t
bV9saXN0LAorCQkgICAgICAoa3NtX3J1biAmIEtTTV9SVU5fVU5NRVJHRSkgPyAma3NtX21tX2hl
YWQubW1fbGlzdCA6ICZrc21fc2Nhbi5tbV9zbG90LT5tbV9saXN0KTsK4oCmCgoKCkhvdyBsaWtl
bHkgaXMgaXQgdGhhdCB0aGUgY29tYmluZWQgc291cmNlIGNvZGUgZm9yIGEgc2luZ2xlIGZ1bmN0
aW9uIHBhcmFtZXRlcgp3aWxsIGZpdCBpbnRvIGtub3duIGxpbmUgbGVuZ3RoIGxpbWl0YXRpb25z
PwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6
Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
