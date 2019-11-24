Return-Path: <SRS0=dElR=ZQ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876D1C432C0
	for <cocci@archiver.kernel.org>; Sun, 24 Nov 2019 10:41:25 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84A292071A
	for <cocci@archiver.kernel.org>; Sun, 24 Nov 2019 10:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Dc5xnHut"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84A292071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAOAf6MF015924;
	Sun, 24 Nov 2019 11:41:06 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E204A77B5;
	Sun, 24 Nov 2019 11:41:05 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9B82D7708
 for <cocci@systeme.lip6.fr>; Sun, 24 Nov 2019 11:41:03 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAOAf3E1028646
 for <cocci@systeme.lip6.fr>; Sun, 24 Nov 2019 11:41:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1574592061;
 bh=7Za27cRCcliBQMEZlzyMKMcq+k7UwGUUTnxiqjjfE3U=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=Dc5xnHutLtJ8Wso0v5v08nOUvP7PR8YWQX2cXYoTcQW34cJD8kIqjPWpuqSwLPip0
 ojahT7BZNAbx5ZKWRTuF+1HFfWsTzyRc/0q5AWPplrePZioif8GnyrblmP3KIji3/a
 ZUxwgqUkA0zDnWkJO8kQ8DYpqUVpxpiDRnfI2mOE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.243.73.27]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LqDUa-1hvLll1nFo-00dosE; Sun, 24
 Nov 2019 11:41:01 +0100
To: Julia Lawall <julia.lawall@inria.fr>
References: <cc561358-4d00-9f1f-eaa2-8fae400ccc8b@web.de>
 <alpine.DEB.2.21.1911221025570.2793@hadrien>
 <8a44f286-72ad-14c4-6ee9-b8aa25ccba3e@web.de>
 <alpine.DEB.2.21.1911221050320.2793@hadrien>
 <46f7430f-8176-27ed-1150-af9fc69b03a7@web.de>
 <alpine.DEB.2.21.1911221134210.2793@hadrien>
 <da29f2ea-7037-3237-8ec5-4464379e7a54@web.de>
 <alpine.DEB.2.21.1911221155320.2793@hadrien>
 <599a5c47-75c5-f0a8-afe9-3563a20b70d3@web.de>
 <alpine.DEB.2.21.1911221351470.2793@hadrien>
 <87ef6d2d-a66c-5566-ee27-db360235c332@web.de>
 <alpine.DEB.2.21.1911221609420.2793@hadrien>
 <af01dfa7-3fce-732c-6f62-279a1d39c7a7@web.de>
 <alpine.DEB.2.21.1911232032490.5464@hadrien>
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
Message-ID: <ebe92531-f79c-941a-b7ba-767403ffcbd1@web.de>
Date: Sun, 24 Nov 2019 11:40:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1911232032490.5464@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:aof4E8w6B0/+4ZX0ZctdszZKPWgk+Tz404tnsddmhoVDtaCkdSH
 EPzGS7evhxXcQVp2y4yXGhzMlfgc/j+PbDHMc3W1CR+R1LfxlCPB+PFwBlWjcX/j1QZe8A/
 KYUOkOA1c90O4Ad4UQWdG6H8RTAFOK+At920VH9K1kTn6m7aKwvnjHxCwWvMWedusKo5iq2
 4V80jp74fT7ciJNxXRFlw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dWMBVsP5r8A=:T1DlUtHma/6LLPzxbxaPl/
 FUxzOa7rj3zt4SW6c9/KL92O8UsxXIQU9SHUhEKJXu2Ukas51dIwkUlN7crVaCosWMta1FOsA
 AmTridYjPvyt5Ig8yzgK+O16W+S/RX7peaWpH0x1I2hxgKh37i5yrXPsmt9QKZrAXWtF1EsHc
 Rbl7bbQXsZSseaSkY7yzYfR29iVeDmVMzBULtuZuFXcOBeuCYvRnmi0USypO8//VXcApZVRjH
 KJdzlxFXUyf3hx52Y4NkRzhJL5etrK/wn8Wycwv6SnFEYpoMEq6JvpTBYzSfyG09nGNAplzGo
 1ydw46fcUewfp8Lho92Ioo7A4GR7g+3IuFlymxjj2oxIhCn1c5PFAox9n9bDThhvzZ1Ps2gAt
 Af5DDyDAKijo/hFzUFPjn6C5OXvVYIokysfC/U7H8TGkr4p5XQCBdtvDdmOlDlM+nLFKztj25
 jAtZgkf1mWGT24OwB6xaSDWT+KA8lpwoWD5co3ZfGn90npGuzGrbXYiF9ble1m9NAmDCAcRwE
 ZUwUnWOlvSlFbIVVtsproGTQTcBASoyulgOQnqDoBRjJQHD31fe/Wss/8xsQeHnMqhp6rBORB
 dqbN/PDJWPhwIIhLlBS0pB45IPeOSEGO+T2kSseU4kNJ+31Ihz0hAMNf5RYuT84keSfj63RHN
 yAA2iJMPdd+JkLnlL5b0YlZH9e/9JPegIdeNeSWkPrDEuc3n8fgQUG/nTTIuziSRCvFbagCbZ
 mzs0JLL+d/UVi1MlBF8HfKkyUoi6OewSEGUkMoRCh7X/C/r6KrpQ4JxL/BJsW1oNTHrvC40yu
 GpHOHwvI4PQIl+ATaK3YLPe69fEe50lRyXkm+JphGrnsPd0NNK6a6ZaBWrCPpYa67IPnEVhWg
 VZjlsq6GIwCdmPS+xyFLMMGFJC+IcHGFGTW+p5bSu9zgwbfaiHJXzwGaKM7mQI8jlPgWmU++c
 Xo6ErL52znHoOPpcKu6LoB7FnNkUfrHSMGIAAqtQ9oG0MPne5vgYQOlpKkdWrpRl+2Qo9hTxT
 NP2M5oxVMQGTHusZ9zqCl3YZESeiPQHvZqpWkf4Cw7edu8pq0CvuVEOUwrrkk4vWcfgK5NPuw
 rdNgBybtKD9AkRLkw6vuVaHMPcPU7lzrnPYeVZF1/7F40sTXplNKTMhWiqqB9gJq0x4Q+c6DI
 TUAHnuxIerAllZpC7FgnS+R2CQTQbrxx3wYxNqzk0UY8lvfE6Q6gwcupjD5os6X7AG4p2G2+j
 jiwpJFPsMTGuZdZRbEAkKFfW1TecW0lDaba30kytccNmTEkCFAwUrNPId9ZE=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 24 Nov 2019 11:41:06 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 24 Nov 2019 11:41:03 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking influence of variability with SmPL
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

> An expression metavariable matches an expression of any type.

Thanks for such an acknowledgement.

* Can this fact trigger corresponding challenges for safe transformations
  by the semantic patch language?

* Would you occasionally like to determine the corresponding data type then?


> A struct metavariable matches an expression that has struct type (for any
> struct type).  A char metavariable matches an expression that has char type.

I find this information very interesting for further clarification.

* Is a data type conversion performed by the Coccinelle software?

* Where should the explanation be found in the documentation for such
  software behaviour?


> identifier doesn't fit in this discussion.  It only matches identifiers,
> not arbitrary expressions.

I find that this metavariable will handle more variations for an item
by itself than the specification of a single C data type according to
this attempt for a property comparison.


>> We would like to achieve source code transformations which can be compiled
>> (or not).
>
> No idea what you mean by compiled.

I wonder about such a feedback.


> Compiled by what compiler?

You can choose an appropriate program, can't you?


>> How often will it matter then how these selections will be applied?
>
> What selections?

The source code will be filtered according to the specified metavariables.

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
