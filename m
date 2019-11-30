Return-Path: <SRS0=GrYw=ZW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33228C432C0
	for <cocci@archiver.kernel.org>; Sat, 30 Nov 2019 08:46:47 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B84A20732
	for <cocci@archiver.kernel.org>; Sat, 30 Nov 2019 08:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="CI7aJb03"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B84A20732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAU8kRZ8019757;
	Sat, 30 Nov 2019 09:46:27 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5397477D3;
	Sat, 30 Nov 2019 09:46:27 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0596377CC
 for <cocci@systeme.lip6.fr>; Sat, 30 Nov 2019 09:46:26 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAU8kPua005947
 for <cocci@systeme.lip6.fr>; Sat, 30 Nov 2019 09:46:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1575103583;
 bh=YnPvIHisfQhss/SmPQEbr1vbUvIw79kv650gdPO2VjY=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=CI7aJb03UYBF8FCWCIJFbXiBRvhW7ybLLabFRNLBsPu+tIRX3lo1pbclv7jN05INf
 ZOpVjM05aIl6yTMokP8ZNHsKQk4GYydlChMUFFk6062t/DBfRgLvhfj7QpR3SQVmzR
 /nHr4+91bMOwTk+6DBlNB+ftYkzzMTG5sgGRlIQk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.18.41]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lvk56-1hjFkR2LBE-017Th8; Sat, 30
 Nov 2019 09:46:23 +0100
To: stracelabs@gmail.com, Julia Lawall <julia.lawall@inria.fr>
References: <CABvP5W1W=p1-n_831VaiJyNsHrepFS0CNJSDQqmfPkrC1rx=Ww@mail.gmail.com>
 <a64ca4bf-4d00-6d8f-19cf-0667d9b1ca83@web.de>
 <CY4PR1801MB200527E64CB2C5ECF218EFF4A3460@CY4PR1801MB2005.namprd18.prod.outlook.com>
 <509ffde0-ec26-a58c-d424-6910bc8e7473@web.de>
 <CABvP5W0d-MErjsS5yqfDtPu4OyiHzdurBDHrwJX4iNzzWjSgwA@mail.gmail.com>
 <02fa7455-e76e-7d7d-0d64-41b2803a8025@web.de>
 <CABvP5W0kVE+yBYa7gWLfsegb75fMyMcLSDbsnFUGRnnVoRLtDQ@mail.gmail.com>
 <alpine.DEB.2.21.1911292154450.3140@hadrien>
 <CABvP5W3hmmovw09n6gJQ5m=Cps2YAYJFFfOPmKY6Zu_SJOU=NQ@mail.gmail.com>
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
Message-ID: <7f588b8e-8a0f-e7f1-3025-3acf82d755a0@web.de>
Date: Sat, 30 Nov 2019 09:46:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CABvP5W3hmmovw09n6gJQ5m=Cps2YAYJFFfOPmKY6Zu_SJOU=NQ@mail.gmail.com>
Content-Language: en-US
X-Provags-ID: V03:K1:zPUzJT6gfDBkdsujeGqGvLVIUFBBIJvEiEERykM0wQPcwX4/5j/
 EhgYzo5nekzky7ygsppuuZw8hrdXxTtVFC7yiYoas+bOscrQ6kmowqB6Ejlx5p414xmZbeh
 /75EVAYnUNnqwFbyrO1v0AIAl6iUiqfoT5AqocAAsP7y2TVDYewgTl1K1x1v/qJn1vmXD4n
 ZEy8PKIrfyeEuzNDZvrRQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sAcs71akaDo=:0N8FxxXGV4IkMwkS+TXlT7
 KcQBs3SrKCKfZjrBGj+DZruFL/2YbPw3ALkjzWo6xu+u4NOXC7/nxrSGE0DNq8Oqcdt2dcLN7
 MyLdvACnO1oZdvSzmlOQO1ovPn7+ZLSjbaIS30ljRUspnDh+clXKaDK3B6Xl9PzeMWbogUrWK
 RaXF6tY3rNXckkd4+szsekqXRlW4YtGnrcQefR2NoZqYd88iihsNN5gMChjmr5E7F/mCAJoyS
 PxQQeddDxWCfiFOjaGeLfMXbF7ujjKSyHHyHhDFcxsl3A+hvvZi+6j0bLbXXgPfDkSfq2Kffh
 BxJ+Jcds1wLweJloOBBn9xVod9yKvfzFlvj2nsum63dmEb+aIizzw0m3VhLNGEYlrHUaCIIkE
 P5DxurI3/GtCCckpTrhkkTlgYStaq75zdwXqFBPhxL2JwoTmSvC06Two7J1lmA785K6fISSyQ
 YJbNp7olYBY/8t+4EjkQ949xpSFuO4IQvcCPQYQ3RUT7FbjmfNhc/GlllJdJ6b02hJi4NZrAJ
 G/QmxI2JkLO8gt8f6yX4UIEJwGx5L0WJn6dm52yzVuNMO8X5RbYYnjvthX1L2SUzZ/lEmhBa3
 CNnZto+NV25EQgqpKlWlkWt1sX7V3C2vpMLJGOgrf9m/rDThF5r4Hbly02Bq0zglH5mK9eTFC
 B0eql8Eb543pYQp5nXHvIpDyenCaGjQT/gaQl55VgCRYMYDXRPqjfjO66yA4ioJ8t637HgcUt
 edckec662jZyxXaFmtP19aGmx+ljuVRLbx5/vL0GzcfeYClNjSIeZu84KMki+YvFAaWd3G9Rr
 EiXH7x26vrCcvnrCOskGmlRD2wVdsH0mCG2bQ0Y51Ge5t6CmwMtjY36CPbF316wl/Vpj2IwXa
 JnzMJUeTZZiACGed5zoOLA+hNujJe/ro1T/EXDsnLxDgsoQDvvQdp/cjUGc/GNwwz5UFLFsNR
 W7ic3EKqV92NqodZnlLBaO8WuKBa31JslBC5hAdDdogaD5cy8NkjtAUbzKjKV4C1FKH8JgNYq
 KJ3JIriprATL83bCL3wZObgWWAl7tNOnq8s4UoWi9fKmfNo1FpCF2RDbJ9xTPRLx0VJVoIYbD
 EZp02MnHhA/FlSkr0Di7idUuo3YtsePaN0fcxfg4htTeiBD5wqx34HoS2BOAWp5xiS8hRmORI
 r/Brlw7GerUYUNrlbGDV3t6uN5XLlBNa9YQH6jqCDimSq3ny6+by1oD42Ex9D/rjg53W4ku9F
 uXscW+mMKykBTfDRFPOTIfFsDr2PmNR1KbxAMjOe3ls/sb0oxR3Pd12QtoQo=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 30 Nov 2019 09:46:28 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 30 Nov 2019 09:46:25 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Replacing printf() parameters according to used data
 types
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

> I am not sure if Coccinelle is able to filter the %fmt e.g: %s only called with
> a parameter of specific data-type.

I would expect general support for such a task by the semantic patch language.


> Basically, I intend to replace alls "%s" called with "mydata->name" by "%m" with "mydata" or "&mydata"

I find that this is a succinct description for your source code transformation goal.


The usage of the other SmPL code seems to indicate that your understanding
grew for the application of previously mentioned syntax elements in significant ways.
We will probably be more curious then how the data processing for SmPL ellipses
(triple dots) within format strings can become better together with a different
selection of metavariables for possible SmPL disjunctions.

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
