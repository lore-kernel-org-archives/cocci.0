Return-Path: <SRS0=pTva=3Z=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27B8C35247
	for <cocci@archiver.kernel.org>; Wed,  5 Feb 2020 18:55:31 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FE68214AF
	for <cocci@archiver.kernel.org>; Wed,  5 Feb 2020 18:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="p79hdXxV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE68214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 015ItFWp017097;
	Wed, 5 Feb 2020 19:55:15 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C955B772B;
	Wed,  5 Feb 2020 19:55:15 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 746167718
 for <cocci@systeme.lip6.fr>; Wed,  5 Feb 2020 19:55:13 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 015ItBgi009210
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Wed, 5 Feb 2020 19:55:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1580928909;
 bh=zkj7uwLIzCEmmKaVWqf1rpDw2S3icATop8mjgnOVPXg=;
 h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
 b=p79hdXxVt/lqCCZuG6qZro57vN1wPoiT3X/H6W4pMgaMNQCGGsEirsCmNzx3Y+dbc
 T/xRyPuCuvWjkHmMh3YM6r+17sSnO1qXrv8qPQB6FoBrSfY6t11nqoCmhQ0UXtFY/n
 gtq8t6vBBUbGSuk/ylZYeQQZRjSuWXU+PidTL5RE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.89.156]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MXpV5-1j4CgE1KHH-00WjZ3; Wed, 05
 Feb 2020 19:55:09 +0100
To: Jaskaran Singh <jaskaransingh7654321@gmail.com>, cocci@systeme.lip6.fr
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
Message-ID: <132f414d-397f-fb9a-ff6e-5360df827147@web.de>
Date: Wed, 5 Feb 2020 19:55:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:HmK06apGhT//7tZ3tZhceqzUIfquKLK9sziZHoOiiwELcAvUNiL
 nt/5yYL5fAnHUTcYDUI/7iitXYnyt/aODKMjrtWfHBW1A/NXjCKsVhP1Movtxvvr4KzkS3W
 fxhZGgUeHJ/wUq6Rik3e5jj1zLb/WYI4VL5n3qQJt4fbJqEL+OIlMWkPxt/aAweYzpo3DOm
 Gb+Vuf+r65taSTyy7cXzA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:urXhkSV2FbM=:/BKAmo4ZYuvBjSrjIBRFZP
 y6YE0hrjwEy8qnBuEQBKNjPnEbNDnpm25HGfCYBOPxsHmZLiYxc9SFfi/w8gOubt+THApd/zl
 8X+iIEBmcScp1mFv7q8eG38Y4QQrKHc4GyX1z3dO1994JL0VzWQMo6TxUGPxy8X6PxBts7r5O
 2Y/TdMsEuMMd6S2lL3BTqTdt9niamL5frdNI2/HHABSxz+Ct2JIJwPT8FF4xPiTBgILD1M27n
 nwN3qGFffweVQGWdwYosSx9+1b52QsJDSaT5s5oex0oMcCjE58itZJ9az+eT92m1cLFbOw9xO
 gyq+9m8gUIJ0+S3K7Shwcppr9qJf2gscCWmJSuWA0sJuzMOZ06hB19e78dhGuQxeg9yert/2N
 y5ID9UTeWG+L9GavbAwjZqVDXU5HmPbRp6WfprXnoqwI8Z7jH3xfUJXVveLiVnlf2on7FvNzz
 SB3jZD1oHzzENFD2/KgeytYe93s6DxATs1Ubqrhf6Bdx3a7u7cCJ0jr58UmKe1iw09ESDrcxo
 xdcZp1Jh33heaoXT1SFoQzzXx65nT2ezyfhNb07bHjGQA4XVvVylD4HsbZwMMJgA2cd04hLu7
 l5SgRS1JjY4t8zlldXO/gYPgWx8w1mAFMLO5VXULobPWKInKtr1ctGtkbGEjfJzLf/2XA7cVw
 lbcwk+Td2HYboPhTsj14WWHy7A2QhkZzrvYw1mqd5dudfWbxu4xts8qMFMUV11KvXGoVdaVQx
 EECb6AJxBE5rTz2ZfDhsumErdwbee3Y2PeiUUnSh96035QG90ujKcc4Xs5jEBm9xgXrVeJZ30
 Z5m+QgyEPaBmhaqJfC8/NZ/EBhZwdGFH2WO53Wskk9p1lneCUSIvYcxTE0kiePGOYs+m1k4CJ
 X8DyrCQN5xRqHiKG9pYAkQ4vV7BqG9rJopNScFiqDtxASwUHzaM9Ak3rBBvTeYOFDWgjiWV/2
 WaMk1nYJaMllYRCxylRsBhSwIoPnoYsAif8vGvFfdxUkuYXK7UG0iUIDvyR17MCqjlDLbPp1L
 8QDcMwqbSJLv+pjR2Kqw3ZKqOttCcs4sQZc4CxPlXTIDYUtdxAYejYsmDoRyBrMl84gtJOY11
 a6LbfgLoHtEnx3xBu0lIa3IHnQpTxBugJekFrUatG91/sxydr7QATGsKpCnFDCpI/fKzKsvm7
 KyTE5gxG5PiWjVl4GMzOsKhkQVkToZSt613OFBV9TseceiLXhQujDOYd2XNA2NqQETqp9Gpkw
 4/L6pXBnKeVEe3TxM
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 05 Feb 2020 19:55:16 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 05 Feb 2020 19:55:11 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Cocci] [PATCH 2/2] tests: Add test case for matching pointers
 to const pointers (and variants)
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

Would you like to avoid any abbreviations in the patch subject?


> These types would not match previously.

I imagine that this information can be improved for a nicer patch description,
can't it?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
