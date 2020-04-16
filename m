Return-Path: <SRS0=lBEj=6A=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7F7C352BE
	for <cocci@archiver.kernel.org>; Thu, 16 Apr 2020 14:30:49 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 570ED21927
	for <cocci@archiver.kernel.org>; Thu, 16 Apr 2020 14:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="S8rNi0UO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 570ED21927
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03GEUcVF000438;
	Thu, 16 Apr 2020 16:30:38 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5C3B7781F;
	Thu, 16 Apr 2020 16:30:38 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E9ACC7816
 for <cocci@systeme.lip6.fr>; Thu, 16 Apr 2020 16:30:36 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03GEUZdV004134
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Thu, 16 Apr 2020 16:30:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1587047432;
 bh=K9l0WyIqzlyL5WU4PPwQIY3OlpK3iybmVAs5PCHCuvA=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=S8rNi0UOZtwFWNQajSKk4RWbLRjqK1uk+dOmiboSo+xZGq+SoN1mtQOiLH/8f58Vd
 B1sHCLIMyJQBHiExumHhbNf9yzKE1zvZH5N17G4y5I12xI3usqm1AQAzXLHUxsvJe2
 BmZV93y67HIiFYTNtNErx6Tnn3Yzoh6v4AO6pTZM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.243.109.113]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MeBPe-1jbfwU1CgA-00PsvP; Thu, 16
 Apr 2020 16:30:32 +0200
To: Julia Lawall <julia.lawall@inria.fr>
References: <25b804fd-0d04-475d-f614-26c03c9fd544@web.de>
 <alpine.DEB.2.21.2004151949230.2381@hadrien>
 <5702b553-d054-33a4-8544-f68ed5457acc@web.de>
 <alpine.DEB.2.21.2004161052210.2447@hadrien>
 <0365dceb-3b66-48cd-c273-4bf7fceb4688@web.de>
 <alpine.DEB.2.21.2004161444300.8125@hadrien>
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
Message-ID: <015f3560-cd0e-3be2-8669-1e12f513a293@web.de>
Date: Thu, 16 Apr 2020 16:30:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2004161444300.8125@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:dRfJPsA4uGAwlgBgWdk9O19g9T/OcsmmCfsWzSUlPht8R1pINR5
 YElGFcds9AKbo+pnbtSVdpy/TEifD3YJGcp1FySsjtAFPOEAShDUKBRxoFH/LSIlAyZXRdb
 78x7FBjSvPF5kuhizb7u7yBd0H8AYL8MSpfcJzNVCt4J/pCPHLEl5eSKPKL56IF2CXDFJs6
 OQyUVJ3q++KQqD+kNbFdQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7XVaSo5kgOk=:gpQIzkK2BUglbfhbNc+43c
 0ZDggw50L1c7ITxcuhJCon0fDlHJJbmxVY8frieuK9Eo0COvrxldLDNbj2nLeI38BISGfpjZC
 kcnmKKUnei6rhfuWNB1IZLB2wXRxNOQ0WMxDAFHJjSRUO7+rlbOSMFxG98Vr2PS0jahMsXwhs
 G1yLRCljsHg87fAv+KijyM9GmVY1PMDTEXX0h+FFybQ9soFcA6rNP/q5979juobO3xOEMTyPA
 c2KnMfmev8dwXWGpPFnTsiw6VzFYeEYxbW94GwuTsfOeYfX7Jx5vESqwIZBREb34EtJLbwC22
 WihjnPZTyV0d+zdG36dJ/JpJ7bT5GtbJAoTm+Z/HoUWMcCq/goRs+eYwMwW/6BFKxXy4VGMj5
 sXOPGfEEzlVngaRakLsvjrCveXiqKQoYlUQjpfV3xvukyhG0dRfjYYX1V2YrLLvlTWn27VuVb
 IiSg322Evg1LOy8gBo0FKT1K2GOrD154tNNNs6cDai5bHHfCv3wwJ+FBN8HP4Q5E8SyiTf74c
 9ETHGAxlS0dvp0PK0wXNgPFBObHg+T845JzFRKoAFcUj4X1E35TQAF9amaSEa1Cc6qjlGxpnm
 CBwJwdJ6pwsNV6nl9O0MZCBoD3mIu1Ue6KFi7oSgVeN7cUnNudb7vHkaFHBx8gviLjBu3Z63M
 y9cXWLSNSJ0LZ1FJqKWyqAEesXYKQ6W26DAHY4Zkd4TBt7I0d24ACxCsrtDZ28VUHv7bJRX9/
 3p4pocakKJ7GfGb23W00bV7HeXKDGqWnTvl+fDFbfEReGtXG3I10kyg5njrFEwwBuMt/QNqax
 ZJz2FnfBKC7t+3B6mHwXS9gYv/TvnqwuIazqH64IHdtAWKLNGcKZMkCBfOxtDMKgzCiDx+nJm
 4dPjvkB6VptpYN9etdLD9Xs8mpPhBy2j8l/1XKJkvqSv4U1r/vLfzTlAPK1GyDJgiqMt9v4n8
 wcWtTzvb+8DXyNsNWLQINRoYvPEQ9YgddvXiG46SeoEujjRN6JGdYKaUzZOxauAR/90aPOCX1
 SiHfwOzbIqOdtiq9/nanuLFut6PdmL9gS8E8kt9/JQrIs5NbMC5MkOUCdrhyazWjK3YsCKjMS
 C3wbaqW3/dLGW3mSe26jCRxPYyPYGKVbrqapZ1IDyO40LJkBaBK6ynwch296tG2e5FJCFHZnN
 sPtnZDdTrDiNhqb/l9k7/TptUc4Xq1hjuTH/5ls39QJCB1VHRS2XVk54/PcijC2qe/e1SP7bU
 6dT/xPcguC/5twxAC
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 16 Apr 2020 16:30:38 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 16 Apr 2020 16:30:35 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Dejin Zheng <zhengdejin5@gmail.com>, Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking the replacement of two specific function calls
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

Pj4gV291bGQgSSBuZWVkIGFueSBleHRyYSBwYXJhbWV0ZXJzIGhlcmU/Cj4KPiBQZXJoYXBzIC1J
IG9wdGlvbnMgdG8gaGVscCBpdCBmaW5kIHRoZSByZWxldmFudCAuaCBmaWxlLgoKVGhlIGRlcGVu
ZGVuY2llcyBmb3IgdGhlIGRhdGEgc3RydWN0dXJlIOKAnGRldmljZeKAnSBjYW4gYmVjb21lIGFs
c28gbW9yZSBpbnRlcmVzdGluZy4KaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjUu
Ny1yYzEvc291cmNlL2luY2x1ZGUvbGludXgvZGV2aWNlLmgjTDQ1MQpodHRwczovL2dpdC5rZXJu
ZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9p
bmNsdWRlL2xpbnV4L2RldmljZS5oP2lkPTAwMDg2MzM2YThkOTZhMDRhYTk2MGY5MTIyODc2OTJh
MjU4ZjZjZjUjbjQ1MQoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxp
cDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
