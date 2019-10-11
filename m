Return-Path: <SRS0=jS6P=YE=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54962C47404
	for <cocci@archiver.kernel.org>; Fri, 11 Oct 2019 07:31:18 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB73E2064A
	for <cocci@archiver.kernel.org>; Fri, 11 Oct 2019 07:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="ML+sf0ZW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB73E2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9B7V1Lj026371;
	Fri, 11 Oct 2019 09:31:01 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A1CD877B1;
	Fri, 11 Oct 2019 09:31:01 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7852977AE
 for <cocci@systeme.lip6.fr>; Fri, 11 Oct 2019 09:31:00 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9B7Uxr1017815;
 Fri, 11 Oct 2019 09:30:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1570779059;
 bh=96P882mMzWsLaon8WoWXQnZZHE45+G5fm2NN7LGrTfc=;
 h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
 b=ML+sf0ZWBGPYV4HhMZckNaejjrPxQuy6dj4ndkcBrUFGngrdbgBuliOJNX+o6Rflj
 CAul1huvk7CxWPA6bmf+btfWMCEmCBztDk+bEbw+d2O4YzZWD+Bpf/Zsdz3xLyMaWb
 JHndAMwxxqmfbA7mykbtIYO/LHg4yWhssNBQEXww=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.164.92]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LlF9O-1hlPVt1oqk-00b2GZ; Fri, 11
 Oct 2019 09:30:59 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <24130ec6-4a20-7be4-755f-a6dfffcb6c97@web.de>
 <alpine.DEB.2.21.1910101509370.2305@hadrien>
 <8df6513d-36d3-2049-8fb0-28d84c8f9c85@web.de>
 <alpine.DEB.2.21.1910101537280.2305@hadrien>
 <293c83c3-d7b9-8c55-59e0-eaf7fd2fcc84@web.de>
 <alpine.DEB.2.21.1910101606420.2305@hadrien>
 <678d756b-a8ac-12c0-cdbe-96b49fc4eb2c@web.de>
 <alpine.DEB.2.21.1910102053440.2500@hadrien>
 <b76c96ca-4312-550a-3f56-a509c63faa0f@web.de>
 <alpine.DEB.2.21.1910110806250.2662@hadrien>
 <c9b2c5be-455a-ad69-ad65-6efb910055b6@web.de>
 <alpine.DEB.2.21.1910110906390.2662@hadrien>
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
Message-ID: <cd41e7ef-27b0-7491-9c3f-a66b2a722cc0@web.de>
Date: Fri, 11 Oct 2019 09:30:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910110906390.2662@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:He98Ky0WGJg5erFkvVfaEUHpx/aKh0llHr6f8tHo3DbKs7BAEmj
 JOPxqlDQ8nJFkXkQEBFFeK0fdyA5bm9Ssr4VTgH+M+vkttvZzk1828ejjkuzXt+E6mQVRE3
 BHwTeG8bFPBXdxlQskTvtMSkGV0TI9LfoFJ5rXHZI5V7SqiwedVkOKYxRoaD3PgsYWJRp1A
 qDb5j70IUIof3o60JOvDQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HgIBkF/juh8=:7MoTV1WWFjuILX11/6WKe7
 jqfqNYi6U3f9DLox2iIU9mEIJ7zV913RpOnszc7hgKtCP8fdsd9DwTmT9YVdIdn1j+1pTZHaZ
 rulFgv40MDQCUIBDR+v/O5phOV6bDZuC6TUmgvOSr0a/sIrYXjwMhGxY5waO/Y8odKKBXClbj
 CbYSVZP58KX+QIZlibG8hXap+BpWMpL47vfxht/DxjSBMCf+AhEkCum/6eJ/FmLT4Dp5lIGNZ
 HR1U9/jn5qFeTCv4MjSh9ZvXLkCl6bSzJdsYdTdt3cZXrvo+8wgxBqh0O7o2pt/0v+I8/FWWT
 69ibjV9ZqQDrrP7akPivSg9Lndie5EZlK3BfiidnHTxYMywc0LcNfC+VBpOyV9azHBpP47QfS
 cDhPBLDHH9Qh8AhbdGQEGnChKNv92n/OVT2WUwcrY4ReTlhLPcQfYGhqXCItYtfm399zBasSJ
 hKLVSaxIHbSqU3PLoY4HhtJ/3I2Dvos7s1nocB77VRXNX02a/XZ6AOdkca9tMGjWFYTQ8lTEl
 ICllfKXekpalG+TMANfumFxynGX/bi6k67+FkQuHq8s50weNo0nkZ+RsKQM3C1BTyyieZhmeb
 hJypMw7N0We1mqrjcKNZ+Fp86uWoIdscCRF0o+FIg+svGyMxfZQ4v9Ebri62Tclx6QXDAddro
 UpbtpFNlmFN9CLDY/hTpvsJNrUd84Xwy093Wbi/9ndBr4wh9vU6EooPv+Lz4QsMjlNo5WULJq
 jvem3kHQjbi1JDmnD6e+JzgRMAFpjkoG4A8UN+ebJYaxVgqHu/bzyFdUvE53rxYvauz/CLRd1
 RiLY8y4Lx0/t2ChcOl8Yk3Jus4Br2h0gibe3XPVyozQ1JZbv/ZD9EBKQJ/vWhNUT35V0FS2PH
 ExgzYH4dCE6jkALfZI5gTNI9WXF06w3FKuB7AyBv/rNw9Kb92rpVFOeHlEo+XYSVoMnLMSOCG
 hDN26emmygj0CffJMq/w4g2Xo4pHtbHdUAR78jMCk9Hl2W+A8ecEQ45333r6uAE5GmKEJ+ZPr
 NETcT98Y5ikWVmPD2L77zomuvtop5V/4jyZ5PXFRUeftXbmUQT06jppU3oGdSXTBW2Ngy9941
 gpZhfp55Yqqnh0RxjjESP00nbB8iofzT0rJRSK41AO24KtQfJUJs5CGJJHvBBNpxhPfT1J12e
 M3jeyfA2vVWToY1m/9sq7wkmtgauyAGYTK/277MDGnDmgO7m1DXkiOCD+f46+Eiij/qRpmjgQ
 s8MhAjYQSCC0IpyNiXieNebH3ziqH2I3HNHR+M55HU/5Rd97g01egSjDT9wE=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 11 Oct 2019 09:31:02 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 11 Oct 2019 09:30:59 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Software analysis with SmPL around unchecked function
 calls
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
>> expression x;
>> identifier f;
>
> You can put f != {likely,unlikely} here.

I would appreciate to achieve a better understanding how these likeliness
annotations can influence the shown source code search approach.


> Maybe there will be some false positives when x->f is in a condition
> that previously checked that x is not NULL.

Such information can become more interesting.


> Does this happen a lot?

My view is incomplete.


> If the answer to either question is no, does the problem really matter?
> If it does really matter,

I hope that the probability for false positives (because of evolving
source code searches) can be considerably reduced.


> then it is possible to solve it, by adding a previous rule that
> marks such safe dereferences with a position variable.  But I don't know
> whether it is worth it.

I am curious how corresponding software development efforts will evolve.

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
