Return-Path: <SRS0=z6Nh=ZZ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CC9C432C0
	for <cocci@archiver.kernel.org>; Tue,  3 Dec 2019 13:28:56 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C67C2073B
	for <cocci@archiver.kernel.org>; Tue,  3 Dec 2019 13:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="ML/rXqLV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C67C2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xB3DSeeY016966;
	Tue, 3 Dec 2019 14:28:40 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 89BFA77D7;
	Tue,  3 Dec 2019 14:28:40 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 73E024386
 for <cocci@systeme.lip6.fr>; Tue,  3 Dec 2019 14:28:38 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xB3DSb4g026388
 for <cocci@systeme.lip6.fr>; Tue, 3 Dec 2019 14:28:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1575379716;
 bh=Gc14Ee7I7KVxCFf+qlFiITqCNLuPGCZqRDD3qMUiBvA=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=ML/rXqLV/Ng5S1dVwhC1qKczU+x8/iqFZC2t6bPOUAIplixOpgflZVFHQ2suVwOPo
 hvAxftGSXt5P91REpWM9DVBl2Fc+uEGinqN474UYUH5pTcfZKtFVlpDzTs+V1cVmlZ
 6h845NdiIAaD0De3KSPF1rg9rrCymtSVTs9Dsu0Q=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.132.47.193]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lu4uA-1havIo1NZO-011T1M; Tue, 03
 Dec 2019 14:28:36 +0100
To: Julia Lawall <julia.lawall@inria.fr>, stracelabs@gmail.com
References: <CABvP5W1W=p1-n_831VaiJyNsHrepFS0CNJSDQqmfPkrC1rx=Ww@mail.gmail.com>
 <CABvP5W0d-MErjsS5yqfDtPu4OyiHzdurBDHrwJX4iNzzWjSgwA@mail.gmail.com>
 <02fa7455-e76e-7d7d-0d64-41b2803a8025@web.de>
 <CABvP5W0kVE+yBYa7gWLfsegb75fMyMcLSDbsnFUGRnnVoRLtDQ@mail.gmail.com>
 <alpine.DEB.2.21.1911292154450.3140@hadrien>
 <CABvP5W3hmmovw09n6gJQ5m=Cps2YAYJFFfOPmKY6Zu_SJOU=NQ@mail.gmail.com>
 <0c03f84d-a05b-2811-96aa-6f82541fb8a3@web.de>
 <CABvP5W3E3zP28kUsmrvUOqv-Tu1YT3zvi6c=mqx+ahbMTycqAQ@mail.gmail.com>
 <1865799483.10870980.1575350298758.JavaMail.zimbra@inria.fr>
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
Message-ID: <aaf4d9fa-0ee1-8163-9244-e02cd62aaa2e@web.de>
Date: Tue, 3 Dec 2019 14:28:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1865799483.10870980.1575350298758.JavaMail.zimbra@inria.fr>
Content-Language: en-US
X-Provags-ID: V03:K1:JUvGRi398hi64tSHnWwo62ypSpxnkfHPSWvVpr8OXUBI91YWbkK
 cR27FEN0vuIJRIOml9ZWg8493fBKj/eNp2D2nJE0U6BA7y4387p3zEIUTmA2OFbKxeNPhua
 1e0XpbIzWD+N0o4ucIWs5QDx9OIuxZk0sXt4mInI6PRVFTRC7ykrfs0iW7EBwzlt0o6yLND
 NwYj4hNf99KnziFJA1Jcw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XJIoAimnGxw=:h5oEJCkBQkn1mf4/2nIP6y
 zhLt+LABb3AqANqxhtoDiOC7R+xg6o7W5OYktEyUBtYz7CbV1L2VR72iH7yHePLIHAQ2phweF
 8Isyz6yuI50JFZrkCAds8u0sCwecW7s8wXwP2bx+d+1PIAbNzT8KiqUBlffGhjFBQYhjN8K0d
 mAVOHwpEtiFEqe8vNLAiB2u1EsE0Jh1rX7NJ6HT8YXZl7KwmZ5bIefA6bt4mJKP+hkljYzMI/
 lnGlrsaDcG7VJivJiv6CU6+7t01d2adcs/cg/eCQMFW+cbi/kvRMFoGl5iwI03v0gX9RHIc5d
 dEjnCRiCfH/g2LBnZjV5qgdrci9a0dn0qYP1HLk+w2LlaWEKzNEsXjqGHHfB6d2k+5uRnuBIG
 K3T1IqWWbrQfYi73voqwF2o4P8WhAZGuD1ovk5v3YZv39D/q8sYTbcJHYcFUg9N3e85A1f4bv
 PIDTyebpfnH88I0HJHmIKTeGtgIYHIGf3LqHupdbXBtfLFXG1Ue/Xv8V/9e2Qlh7upkyKH+co
 kMR40Y4NJMFkCZFEX45c/uTz5nJg6Xzi/+eHh1IyvagQrWfl4v135gw9ZO5EYveuCKjD7uel5
 rQNRUFKdz9fofbjvmExvga4AGwx+GKDKJRjii2O6GDCQuIl7Nmfc2YuAeVzaw5T0cGnOFuQZ4
 bUzeLiqqVFKNrxJH2rV7Sa4xiBM2IvKrWbccktt0c075RkyHUqrHrUbDO7FY+OSfWqpUTZlOl
 8a0lRladSGL/Krfq9M51xdsY3V2nL0ZMeaJ+xWUnIECZD6/foOIR0+ZXgzMlERACSXZTqEd0b
 ztLFS4+rzuLo9TLkLyc5imZ+8O5SjSyg477Lxl3xbExdT6MZ5wCrqfJcVtCABxpDtJJnDm6Y0
 BbZt+jysObVtt6CEtFW5S720CTFFjaYE5VngG+XI1JABfljzbwU+6uSamR0XUbhK5816fRa0L
 uoNcYmmIWvum9UtevFwLCakkLV+fw6Wbqna5wS8NvSemKgbKbHuHBvJRLTzoWMmoO0i3s6wf/
 LQW/eelFWA4xXrVgXI2L10iyq3Ynw4aYXTKHAzc5mlWo7XF5Ju9o4mywTfx8xlpKR6tHoHx8R
 SRY08u2YMDAQkW38TLnheh+yUDnGszPjz9uCz5XRqWog2keH0xUI3oeH4K6aCNjFP3HeAvVXK
 XKeLfWkioHn5EBsGqW3OXLGZy93uGe7Fbuv3q8chAd/ghbgE8SmyLXVAB5IWUedUD+KC/LFgp
 ZJasiyfCQOh+OSNaSdiAmKsBA6VFO7bfmbz2uCpADKc/oNKGVpn2/6DvDqCc=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 03 Dec 2019 14:28:40 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 03 Dec 2019 14:28:38 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Changing format string usage with SmPL?
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
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

> OK, if you may have more than one argument to your print,
> then you can find the offset using an expression list metavariable:
>
> @r@
> expression list[n] between;
> @@
>
> print(s,between,h2->name,...)
>
> Then you can use r.n in your python rule to figure out where is the %s to=
 change.

This data processing approach sounds promising.


> Unfortunately, this will not work well if there are multiple name referen=
ces in the argument list.

I hope that the Coccinelle software can help more with the analysis
for format strings.


> Because you will be trying to change the format string in multiple ways,
> eg once where between has length 2 and once where between has length 4.

This can probably happen.


> Substantial hacks would be required to deal with this.

How can corresponding collateral evolution be better supported?


> It would be nice if you could do
>
> @r@
> expression list[bn] between;
> expression list[an] after;
> position p;
> @@
> print@p(s,between,name,after)
>
> @@
> format list[r.bn] f1;
> format list[r.an] f2;
> position r.p;
> @@
> print@p(
> -=A0=A0=A0 "%@f1@%s%@f2@"
> +=A0=A0 "%@f1@%m%@f2@"
> , l)
>
> I don't know if that would work, though.

I find this information interesting.
How will the clarification be continued for affected open issues?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
