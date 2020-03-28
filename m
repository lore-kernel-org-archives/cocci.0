Return-Path: <SRS0=sy63=5N=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2E0C43331
	for <cocci@archiver.kernel.org>; Sat, 28 Mar 2020 16:47:12 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 163D5206F6
	for <cocci@archiver.kernel.org>; Sat, 28 Mar 2020 16:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Wb4dEXzc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 163D5206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02SGgIeg023952;
	Sat, 28 Mar 2020 17:42:18 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 727097812;
	Sat, 28 Mar 2020 17:42:18 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C5A9866CB
 for <cocci@systeme.lip6.fr>; Sat, 28 Mar 2020 17:42:16 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02SGgGH1028728
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Sat, 28 Mar 2020 17:42:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1585413734;
 bh=W/S130dwBZYyg30JCbkwfBtC6QwwVQEOUt79S5/BIwA=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=Wb4dEXzcGNb+OaNzO1Xbo3GJNgq4V1arecMjIviyJ0q/gGv3we6hEyfadkYF9SZev
 kkqNSGbjHsjwXnpZbcGsxB5SIcS6VwsngNJ9tgBuLxAmIV7ZXO4kEJyn03V/dBaWal
 yHliNWbJWNQEwtJ4n13omF4E2yMHR2lHEX4P9U4s=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.150.134]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M3jsn-1jZcxj1wG1-00rHpZ; Sat, 28
 Mar 2020 17:42:14 +0100
To: Julia Lawall <julia.lawall@inria.fr>,
        George McCollister <george.mccollister@gmail.com>
References: <d3ea3700-7dc2-b6d6-e284-e9620bece6dd@web.de>
 <alpine.DEB.2.21.2003281705460.3005@hadrien>
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
Message-ID: <0b726b0a-4ca2-df2d-7ae7-10bdb94b821d@web.de>
Date: Sat, 28 Mar 2020 17:42:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2003281705460.3005@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:jc3gpmthj+Q/EK/hHLORNRveRTH+pbM6AjESOZHQBiQR+4syZ9K
 U0xKqfPrXn4O58V0BmXw5KubWLrk4SmKWI3XHaF7yup/IT3W3Gb3zXDL6q/rZZcLC146Azb
 o91KeiXeYPtMLMjQii728J/cEL1+kIxaSVglIeJMzFAGMF8Aenh54oY87Li5ms6NFcFJokT
 gDBlkkEIIyIZlO9OkhrVQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1LUxCr/woNk=:r9enc+QNiy7dbU4hkMrNEp
 4mmuxadY69buH7xgtu1hBgvttBokfOJ0FpjzyKPNzIF8bOXVRLCuo5wMk4To5BUKpg565oTmd
 1LpEPMJqikJlZW7e40FEEFntE6TZoIoZGQIExjeg5LN63aIUSyn8xI0WiD6nL/BW21xC9rV6u
 QSvAFLYslKra3RFMBp5VQyyTNBFli8AzmR4uKU3tqWBWjBwhRX2Zel6U/OiLPNJgoS0R5Ix+l
 P/0PzK6Yj1J9I7g43upYwkP/L3CKzCsAsst3F5nPV2khjer39rUg04+F/9PCIW8DfaieOQON6
 7OXdL+dt0sB4INZDvCpAo3Stl0pO+/4GFxB0uEaf5KZ7t7si3m7tXRCLqrkVifxDRKkGz0KO+
 iDttCyJeLQMVOCsJqfAoJqLZ0U5tqJJarYG9glJ+Uf6Ge4a6gZIKPnzT+10mj99N3Kx9YprGG
 0BEtGYwx5pCZsjttkrtB+IVbni/x9Y1aHbKCisz7gAE07YmV9/qcPFI/2mzj7WdkszebRUNAT
 5b86jMVTZc1+EmtN+LuV4RrdNlsnCJLA/D2nq/Aw1p63llq4h6KiZsraLT7aQUIMSyCf2ypWe
 6I6mTyjVUgslfx/hq0On6pf67u4GaCpBg9QfMiKDJLW4P9QVxipXebT0TvpWSx1gKgW+K4qEY
 e4iUtBd1SzXsaG03mSTqdHnkkdwkE3NjMdjAHiELMzIWOacSpflaBWxoeuoKCIqJpUDEFwyuT
 I1gkJ/jkKmozGYWAkV48y4SYA1aOZyVIku5A2ltDuPuql/VJQ/5h81YN9c1837OK2eWuQw352
 Q/nW4H87z24nFu6EMRIaB0QKPrOMQAKAJf9MrpMsTwDVBzJIyxVLCCUem8y7BkuM62x++WI5x
 BFBCcrsyTwBkbQ9M6QP4dduVVdT7da+rR0FSKrTnABc0ZA0gv6/tcnc+T+N7m4bbBHREaR9Cv
 Jhh/BezbLviNXVRaQElkoenPxhBxXkKFRSQO5SyJSACmmkwgFX76hGJVWUx3ou3COnBrqdZl6
 vobUv5QEYLjpMvYRA+I6f0HbS99tvj+9aSGaJCJyJdEg4OuhwvpAPtBHZiRkrPBX9ldOC5wOj
 X64U2qHoKcLa8bj8KoR+yoPavs7GWkMxPi2pENiMUWYqqtFyhGtkYlMbvPi5gQ1uERyLNhD+s
 ueCPx0UaC7Wyc7NwUBAmc3Tu9ztcE80v2ESmhxqVMfmiumtYnauhkzdz2HqgdqNVscigVLncy
 V3FLOu4k+aUhpBoAS
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 28 Mar 2020 17:42:18 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 28 Mar 2020 17:42:16 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Using SmPL script to switch to formatted log/print
 function
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

> This discussion is about parsing the source code.

It seems that an acceptable solution was found according to your advice yesterday.
I could offer other ideas for another bit of software fine-tuning.

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
