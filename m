Return-Path: <SRS0=q5PQ=UV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80F6C43613
	for <cocci@archiver.kernel.org>; Sat, 22 Jun 2019 13:36:02 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2674F20679
	for <cocci@archiver.kernel.org>; Sat, 22 Jun 2019 13:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="pEEERzZx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2674F20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5MDZjlL016046;
	Sat, 22 Jun 2019 15:35:45 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3A67B7779;
	Sat, 22 Jun 2019 15:35:45 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2D7C77770
 for <cocci@systeme.lip6.fr>; Sat, 22 Jun 2019 15:35:44 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5MDZhVr022589;
 Sat, 22 Jun 2019 15:35:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1561210542;
 bh=CKRCjfrgb930CYuDpoZ60VB15c7C74cQo3521Vu1BYE=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=pEEERzZxGxUfVmPt4/RPWR/5tJICd2v7d1VDF0y/SW3QL2wzdzTv6uEaFFKPwGr2C
 co3FMdw694SXARlqaiG0IZ7/rNvhXl4JWCtFC/iyVEFzXwnuwCR6hTB0Q+uh/Bw7lW
 zBoN/PHs7GqxbrE82MtN4P2jwTL1929V8YDUG/0Q=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.127.8]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LcgZv-1iLOmH1RHb-00k5zy; Sat, 22
 Jun 2019 15:35:42 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <f1bb347b-7318-f69f-ad86-bd633c72b375@web.de>
 <alpine.DEB.2.21.1906212251430.2538@hadrien>
 <9d2ef926-62b9-d182-d6d6-cd82ca13173f@web.de>
 <alpine.DEB.2.21.1906221517080.3253@hadrien>
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
Message-ID: <4dfb9359-ab09-d206-3110-0fd177ba34b3@web.de>
Date: Sat, 22 Jun 2019 15:35:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1906221517080.3253@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:NVmg47x9rKsIIG5TO9xEiXyb/o0pH1YF/UWSSx1PS0gvoIV0DzV
 IJPSK1Hn8vXvbcFUIjYHxa82L1csowA0rw00y2QGW+p6145uZIwX1UDsunDVRZliJ3OxIrc
 hpO6FiYv+ddrbF8dr7get5nuV6TxhNYamBuyzBvy0SSMqsmc418xMDqe6AiU7B3pWvEJYTq
 ZECDeG86KDzeabVHl4ejw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Xwka0PdNyDc=:Bbi38swaYK1z8Cz9SdfIAV
 KUb398kUy1fXkJnfEuVcgL/8hPAYF1c3I4fCdC8bpzRu4f8JQb858t8SFZyNGYsu86alp3xNb
 1emk8BziCdFYyPuZVJUF6m6FlB+6EbDoAF8EgfKLwDIdaP5LWRN1woiVs7Grg6tRwGJ4WuCt2
 YwzZHiCOvv2h1LYZMIn4twNDIG4Wtm+zCO4fpbjCpOlFHw6rN4l+ztgBvNuHAxp/Q1V05ui3C
 /tKzU8qdpGaZwnDKTQRnnZYaYAF+MoXD0EY1lIlVqQwLT3Wg5LrM7CjMh2x50XZ5IR1r67o1+
 /82p9r9VmNck1Jift3NmsThgRyBUCjChkmoL/TwjtzOv9XPCoeMx9KmNjTZVzrxSdQjfbOup2
 kSIwdL9pDHc0k5PLKS79gjacuORHdtsPeMdxMT/1UZ3/5tnW0v4q4WFmxxs00Q8YyFxa/Cp0h
 /iHMBxuu8WJZCLGFmpDMBDK7y7GYppOA/37gchp6Vprg9XxJ6BOjVb1m0dZe8NNujZVgXBqDm
 ZWhCwgIV+Yr/jk99SRmkVURWdxHG2K+vDuQmVCqox9uqpkPfptx9YltG8LVwwxlWzzzIF9tzH
 /bHiB0ly+OpHUpKoW+04tvNwA6m+oRNGbwqAwxh0jlenAyT4lgF+NLzJ7Adk+OYB7yRC6iIf6
 FuUhsENbihD6wDiVyhwp2EWnxmbd4Kf3B08B8Lq/3oYftLPKb+ZwNGBd7cMYsxfr18zD1/bUz
 GdrwW5kfKiyweYUQKCrMpU+IH0/Dx4jJstwxiw7dm/RqffUWnDdko5Od9ditynFVKYyRscBDo
 fLXw8nIShXTou0CqzYuYfQW+B82VJCNExwvFN09d+Cw3m71M47PBA0m1NH7tQnjLW9MXUsFi4
 Veji4pqQYOSdvEbp7qEWZRrrpK8HMVsmskF6/s4vlGfSjHCnCVRAicPVPoq+kfbti6Oul6lYi
 pYTJX5qXycQ7dzkfgHe4cG+CaNhNLExFgwEIG+7+Bo2i+sTjG0jxr
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 22 Jun 2019 15:35:45 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 22 Jun 2019 15:35:43 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking redundant variable initialisations with SmPL?
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

> It could be helpful to replace the last line by:
>
> (
>   e3 = <+...var...+>

Can this SmPL specification make sense as another when constraint?


> |
> * var = e3
> )
>
> In that case, it would also be beneficial to remove the *

I find the asterisk required here


> on the variable declaration

so that a potentially unused value is marked for the discussed
variable initialisation.


> because that will be activated regardless of which branch matches
> in the disjunction.

Will further data flow analysis influence such a view any more?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
