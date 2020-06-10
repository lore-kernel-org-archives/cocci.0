Return-Path: <SRS0=+0BU=7X=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95921C433E0
	for <cocci@archiver.kernel.org>; Wed, 10 Jun 2020 16:28:53 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E252E2070B
	for <cocci@archiver.kernel.org>; Wed, 10 Jun 2020 16:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="dIsyKuAe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E252E2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05AGSowf024156;
	Wed, 10 Jun 2020 18:28:50 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id ED0B27783;
	Wed, 10 Jun 2020 18:28:49 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 596D13BAB
 for <cocci@systeme.lip6.fr>; Wed, 10 Jun 2020 18:28:48 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05AGSlSU014622
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Wed, 10 Jun 2020 18:28:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1591806526;
 bh=utsEDYVy+brC1JM1GSdDynZ/JkZdCaQkeXMd0zThhb4=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=dIsyKuAeSsAcndyQd9/dgYklBxXgFKRT1Yq4P4IeergnDuQA+g239JoUlfZt2OBM+
 /CKgeqruomCTmtOFW6NuScoMM6N76ySzjQwkB4TvZtUwnyJDrOBZzjCTS2uwiegLWv
 xDWYzUTS5Cgl9NdkEgB9jYIGLmIvvMn0Q6lB6ULQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.155.16]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M9os0-1jcU0U2eVM-00B3eg; Wed, 10
 Jun 2020 18:28:46 +0200
To: Julia Lawall <julia.lawall@inria.fr>
References: <88d56de0-0a22-3371-ebd9-0ccbbc81f76e@web.de>
 <alpine.DEB.2.21.2006091952570.2516@hadrien>
 <5156fabe-d9c0-def9-cd8c-d85b8b5c704f@web.de>
 <alpine.DEB.2.21.2006101653030.2235@hadrien>
 <4befcdd7-5c9c-ebfe-7c2b-f493c8c2cbc8@web.de>
 <alpine.DEB.2.21.2006101708580.2235@hadrien>
 <7cfacf39-224e-693e-1b7e-06914f8d0e26@web.de>
 <alpine.DEB.2.21.2006101739460.2235@hadrien>
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
Message-ID: <57514b74-7cb2-19a1-e5a3-4ef6ede0262c@web.de>
Date: Wed, 10 Jun 2020 18:28:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2006101739460.2235@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:rM7XzKxsmjEvXQ9Gj4AyJY9n7eXe8BpQA2SqXl0BFnoGMizdPzo
 g7ersF8KVsuGTugtOkO0VXeo1kPAEd30xo+tQk2/z2gwqcV9PKYdrTyF+QCufjMTFGK1MGs
 HyZ9ZA5AO6xESk2eRDIYVBCYqyDSFbAHBOK8A5ey0knaYTuF1nm36+h0WP2tvKU7E5XtA0I
 8zijgaMgqrSUkX3WD8+sA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:t3hLA8dSPhU=:4sFoD7ceg8geHoACpKNyY4
 HsPO3c3/aYnBrg81kQJJ0hWglTSM+tbmT/O4L43vwizLVr2wfpulKDssBGnCWq3QK7rbt60Mq
 3+VZAvkAhILrnf+/1OtHF7ZOoq+XFm6UOUQ396Po0/PPYWsuxiZo9ETCjSrZ+3P6mxIlTLB8v
 JD8mMNjicwhWInA0q6LqaMUwNSK59go8SqIFKhy+h+bTvCvg8A1lw5VGlppFUGM+Bktn/d8+h
 yjmRSdd1kWkeoVLoLdplY/Rw39WS/4stwTdF1ndPFWTaOEw5SmWeoTi/2KXcFEt4LZa3Yinkz
 MiARFTJ6mPv+kDS/V3Beo5Z+ETTrbK3HTFgiVRJ1+fmPcc+5IGchu6sjFFpgBJHbB/N4L/eF6
 dY5Q2Ko/D5+YKBvyz+HGpbGiHsSbUCKnndhJI5Fe8zbYpcKTDdIk01JomWe+JFFCwLYimEpG9
 mwAnEKE9ZGsgCzYByNnn7Xyz5nLMJ1U7D47Pd5znxJCUwdX38GIunklfmCEgK9d2Ue8tmrjaw
 Idkq0KdAyr0F114XkeifV8uGvFusr7wDE2Roew7/TEkcplK8R4IG/ANHtzck6uoDSjEJj8g4Q
 oEAEjF9sa3rRQ5EymXBdyDECvekmetb9csWg/7eZbzmK2tOCf5uSliUAEishMyIXC0OZSww1u
 xfOweGeQyIEogAmVuAumu3H6ZqLZTgy4vHw7+jojeQQT2ZS4uccLuWI6B4cviG6hUQ9qYUTeo
 5BJqAbYg55ZRwYAU74h1Z6Z4IZ4qT31pbhvhHyKp/o+bpf3uWH0F/RQ50Hf+d1p1QTDsKn1+X
 2Qs7hzOs6LEP8jiy8kOOSkoes8NX7DyD+KkTtx9vj2bYSBbA98iCfvOvAaQFF9yHlY5ZL0v2N
 18hZKPfZh1Ny0arRug8dcSsvbzoKmclvxrpnK9WQN3CBDmRQElsi6XfUqxWiv8E2Q7Bvatam1
 BbwBbixnQygPfNm5alLy0ihnN+i0lCpuDO1YzovniC/nIifIqGEFvbAa+CbKgtYQ/5RcmB0bO
 wd/5RLpV4+JptWCVejeeKxplN3vZ3Orv2S42RtY2J6dPg+VLHyeQ4tsGuJ74n0XinjscVhTF2
 0Mf8JOcvTznyeU6g9NSTMMwW/yyrUTtSOLraS0AnVsGZo5/V38a24nLqAONndB9Tt8bO3m013
 H/4iCUjv1L77cZaVqXLdCib0PqXIPAxsRNGote++24R/tyE037sPbdYeHZzgA/lS1XyHfzpsD
 0A9SGhxbwyfkGL/hK
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 10 Jun 2020 18:28:50 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 10 Jun 2020 18:28:47 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking software behaviour according to selected SmPL
 code variants
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

>> @display@
>> expression e;
>> @@
>> *brelse(e);
>>  <+... when != e = ...
>> (e = ...
>> |
>> *e
>> )...+>
>>
>>
>> I would find it nicer if I do not need to repeat a code exclusion specification
>> as the first element of a SmPL disjunction for this special use case.
>
> You don't.  The when you have is useless.

I am curious under which circumstances we will achieve a better common understanding
for the shown application of SmPL disjunctions eventually together with
additional code exclusion specifications.

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
