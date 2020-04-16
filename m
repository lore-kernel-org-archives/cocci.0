Return-Path: <SRS0=lBEj=6A=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8442CC2BB85
	for <cocci@archiver.kernel.org>; Thu, 16 Apr 2020 09:11:49 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1E3020771
	for <cocci@archiver.kernel.org>; Thu, 16 Apr 2020 09:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="WneNticD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1E3020771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03G9BVGA006183;
	Thu, 16 Apr 2020 11:11:31 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 35C3C781F;
	Thu, 16 Apr 2020 11:11:31 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id F29F87816
 for <cocci@systeme.lip6.fr>; Thu, 16 Apr 2020 11:11:29 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03G9BThs011407
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Thu, 16 Apr 2020 11:11:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1587028288;
 bh=fpb0gUkB0zwsjByDCYttO8XM8CJ/gDzZNcf5YfHXyMg=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=WneNticDyhrffdKkGH88mT5VQshzXx6fuvf6cfhe464ylNaJ2m7Rmy6BqYBlxzx0m
 EMIctEFbDbVlxENFLIRwgfXIa0e3YWH8ZqsHWckwbKtO1TQk6GBA6ENggQofGzLrVq
 cB1IWyLl+3Awhvk3VsJkBrbqUhA7MYg9gvhCiH9M=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.243.109.113]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Ma2YF-1jgPmC2uxr-00LmVx; Thu, 16
 Apr 2020 11:11:27 +0200
To: Julia Lawall <julia.lawall@inria.fr>
References: <25b804fd-0d04-475d-f614-26c03c9fd544@web.de>
 <alpine.DEB.2.21.2004151949230.2381@hadrien>
 <5702b553-d054-33a4-8544-f68ed5457acc@web.de>
 <alpine.DEB.2.21.2004161052210.2447@hadrien>
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
Message-ID: <0365dceb-3b66-48cd-c273-4bf7fceb4688@web.de>
Date: Thu, 16 Apr 2020 11:11:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2004161052210.2447@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:+AsUmeEt3DrbbqmbPhldtxl48BfVnAOaDJukfn7OW0G4dRBcY6h
 Ud16eH8M0RdZZIGKd4OMy9kOgyidNKaZVVRsoOVHQLHmN0nxqtPniFlCspaKU9y00YSb0vc
 vduYHoQmUNLtaCSVkqURhPcMo3oPT0ybGkPfaQtY8MVbOSZv4Carcmv55ReG+YPDwqHkbIE
 +9r0LmseWVoEVa20fsQpQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4nkn1cCAE/U=:yZTCy4LlOYYBYd4QfAz6CX
 HACf8Y0OFrgXxpa8LXES5K0/Qb7yfAqUQXef3QCStDjdc/tYr2bXe6d/MNvPibmr+wqf53fwO
 4Q7RZxjJg5NEoVVQSQ54t3nQkzcPv4e3tgABSXJqA7HP/nDOxKU7t/9PLeojg+NGPwMMLCs3m
 Xi21t3C7AaCa6JcP2Lk3T37Yjh3tOx+mTZyXqS5WzqWqt9m1npxTGEt1LWloKHMt18MkY/xLv
 tR/wgsRoZMkUR2uoWAUJE+WT8mzQz4dbyhci1iKhzm8KOBeCyfBoKwI9F0B+3ckdt6AkyWq6O
 G+/jhLzp4FlMZBseolC4XKMkbmHpFVVn8rMvv8P8Q3BC0gHMNC/ISERS1j096lgxJlJn/rc2N
 fOdUHxYOzeXYmodfKIPwyvFrPRFfvdd+qMPmmgYMaCfO8xBoCLw2xIGGLW+S/MiINbNyY12hB
 SYrwqi7KEUZyNtn/VAbAOzFwb8a7oYntDeJWb9UMFaxwYHkuq4om70KN/37bmpxuK+sbAdLI1
 NLED6EYpdJeZva0rTPbS11qu6oCTvIG86/02Su1uSA1kb5xjZPuZbpr/iY6c1oRLMDEWv1zPm
 L2AFCHREwqK0B3jmQ/C+Tq5+0yda267/aX0euZBWjZlIpJoNf5xz6u0MmYYbj9TTidX5Wii+E
 WRSEzdSx2+Ug6eXYGtVhQFEHBgtX1N6iUBxZwwSqBxMV0ZxZKymExOM4Mitq9DJzPcI0xq5QU
 livgNuYtU6M6IJ48jN60sUKM8fJSC63CjXw2beIBxmkP6AVWpjePczentJth57mI5Jp4UGZ03
 rD7+LROW1syx9c89bYG6S4sz78EsB1Wr4py43cPmWayfZvWi1+WCkkoniSQ0WsRUA8DW1m6ck
 QvbS05SI7ikvPRqfsVel3otSyYE7qvZZwa4FGsx27+b+2HISF56piFGO+nRKX+jy74ojzRnCl
 B16XkbiVtQcUTMEJMubu9qGlXNoziZaq9SayEGbz9CIjoMyYeO914ReY7+pr3JiktWfz8hVuU
 Z1O21E9XfisIKakbr9pJT3dcw7hs5iwVrwYjPSXpMnsf0+19bSXgVdbXff7UcwKH0lDi8joZ6
 bSfJmwCR1bzLtaqi8COLxkQlEWyOEy8XAg3qViuN2SsqbXG2DOmWzoh4XnzNlMCJxmuc5MOz8
 c6Pv3abMatFv2uSX82lMPjiW/zQvYVYP/63ZyBAdEbPU3/rtsC7eHBcdZ6dG9PJtXicDpjxdU
 WIbyO62OqvCiZhOYe
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 16 Apr 2020 11:11:31 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 16 Apr 2020 11:11:29 +0200 (CEST)
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

>> elfring@Sonne:~/Projekte/Linux/next-patched> spatch --include-headers-for-types ~/Projekte/Coccinelle/janitor/use_devm_platform_get_and_ioremap_resource3.cocci drivers/i2c/busses/i2c-rcar.c
>
> No, include headers for types doesn't have any impact on how many header
> files are included.  You need options like --all-includes or
> --recursive-includes.

I still observe that the known patch hunk is not generated even with the addition
of one of these command options.
https://lore.kernel.org/patchwork/patch/1223734/
https://lore.kernel.org/linux-i2c/20200414134827.18674-1-zhengdejin5@gmail.com/

Would I need any extra parameters here?


Will the Coccinelle software need any further improvements also around the
desired processing for pointers and corresponding data structures?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
