Return-Path: <SRS0=Jo+R=5L=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA705C43331
	for <cocci@archiver.kernel.org>; Thu, 26 Mar 2020 06:46:18 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10388206F8
	for <cocci@archiver.kernel.org>; Thu, 26 Mar 2020 06:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="OOYXh2VB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10388206F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02Q6k1ZB024680;
	Thu, 26 Mar 2020 07:46:01 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7B8F977FC;
	Thu, 26 Mar 2020 07:46:01 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 432797749
 for <cocci@systeme.lip6.fr>; Thu, 26 Mar 2020 07:45:59 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02Q6jvaf014053
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Thu, 26 Mar 2020 07:45:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1585205157;
 bh=8PlPpLyzeekwb5cOJA1oPF36dkDLPYohq9Vl5oaVuFU=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=OOYXh2VB9IiN5DT/1y06ZMj5IakQ5fIlHB3BLzLWSjSffi9hXiHuXVx/OAomnxucH
 TPw4qLgJi7qM5JDxWH/3fx+b9S8YICjnD70B1lIAS3A/8U9Tov+YkHnqaBAtf45f1T
 IqG43XUtL0YYiHUiqDTeOqCKGl77POXEowgzeR1U=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.12.165]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MKJAE-1jGnmE3WJ4-001eIY; Thu, 26
 Mar 2020 07:45:56 +0100
To: Julia Lawall <julia.lawall@inria.fr>
References: <757cdb2d-9274-4d7d-64b8-387c76254254@web.de>
 <alpine.DEB.2.21.2003251830510.2306@hadrien>
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
Message-ID: <271f609c-f998-0c1f-2d3d-92fa879fb6d6@web.de>
Date: Thu, 26 Mar 2020 07:45:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2003251830510.2306@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:lLgiOEkItDmpk+ry/X1+ca4f8gCb+odRUpUQM+DvWeNqs9dNtcV
 NwjMdB9s+4VUlD84/Vn+y546CGCfCZX7hQn8yXkuTigLGiqT++J8tv2a9oaD1Hl5POmigfo
 UNMtQKPq6OEcfI+0bf1i0QLx9wLNqKFe8Trssa/NVdRmYL9HrzfUnR6N0u+oT+XwCpODV+Z
 yoWHKhDMBNieqlE++Djkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HF890LVE6PQ=:Y80snIWD+eMLu/Vrt8kmK3
 UrXYE6ruQ3FYRiBSvYuGa5nywWVDxae+lRaHsvdAvAcEp2O8dSUzzT8qic5xB6cSzWQtPfx2M
 xF6y2L1Prbw5kMl+ccQ4yZsJZtEQ3iBZdx467I3unINkpI6YFOVWBLm/pBsFRso9H+0jwuRGo
 ULCCzgwUjxuqLVodBR4KxRv4Iw+OT8q13A436CfPGecYscJL38HIlDalWA3Ec1HG3ofQyZehN
 aDpjQRBuRokDuNndwgSfp50Jc9jRrIZHZzqFPgmoeeL1FehMmA1OK7b+8S0ZKZaDnep+2dSbw
 vIMDixgd6nKJGZC9tUSU2kRE2JTPkqEAvX1TuBVcNtBTqqKirD6BtvCbuYMXKVpmmXJZZqwcL
 lQVrQJ/c2xyrLfZaQXcXTzlYk3RCN2f3YYNKycz4BYSdWJFOZkahm8/Ovz/fbImUCIO/aUBqF
 EXkn2mSkNiXjAFPb0QuHso4a8ul6YEVdsQDafayVi/EdPkozwQrOLwsX9jX0zReswKiiSB0EQ
 hB6fCM43wVSMG5xUGVI0Qnv3JtMH9mLJ9EdG5+dFLDXynpo5dnwvzzstUVCRKR/8m/oClqloi
 XIN7lnq/LG1g8/UArgMh6fWkx6fLXvZLWVIrGS8HKBXLzL7pGRJucsRmZ+gi9IvkzTgz7qGhd
 cLNJPSFyA1i0vKh6Cz3emqXRP3rfkRkX3AeJ11wE0jBx/XDAa8jve1liU8N/jqhQcIKR+IhM7
 O9oXpBv3nOFCzeKlUKLsWbfxiWugCNY7QP8uDJQ6pdxcznxYRIh9eoQB7PcRzUQ/XgVOi9gez
 CLZ9zvb/eWiH6M7aKWWWxnuba3W3IU47wGGQwWnxVUwCLG+BXAFjcN33nnqKvKL1HFO+NJtO5
 c3KR9Ku615aaSEDkpvyCxKbLcH6hPH+tbHNfB6Si7WjJIPQhZXt0nxk7ecuvqPjL2A3uT6Uk0
 0Es1dlLZuWydibPF263kowCbQCPjMdku0m8LWlwZyEcJb9TjTk1m3yMefXQA6SrMpHHRbwz3s
 Dnid0QVnD0KkQWa5UTFyWdSxN9UitL1wPfOOT6rhnuBYIPD2taBjPxixC23OqwPrGpS0YYBFf
 oJjRZu0r8+Z0XRr4cfpetzMDPzbUMGwA9a2FTuqaan6ScbzCuaF7PDk0dHwB3XLR+gZW/WuPR
 Jsj3eEawmxcJi2gbOXyY3ia9qde5NQyrjzAxSl25/KfK5g4MfdWUfr6+6/X6rJORoGkwGTBVq
 56K7VPg0fdA54g9B2R2uHpQrA9c5tZIrwdBMs8g==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 26 Mar 2020 07:46:02 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 26 Mar 2020 07:45:58 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Determination of failure predicates for selected
 function calls with SmPL?
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

Pj4gSSBoYXZlIG5vdGljZWQgdGhlIHBhdGNoIOKAnHR0eTogc2VyaWFsOiBmc2xfbHB1YXJ0OiBm
aXggcmV0dXJuIHZhbHVlIGNoZWNraW5n4oCdLgo+PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9s
aW51eC1zZXJpYWwvMjAyMDAzMjUwOTA2NTguMjU5NjctMi1taWNoYWVsQHdhbGxlLmNjLwrigKYK
PiBJJ20gbm90IHN1cmUgd2hhdCB0aGVyZSBpcyB0byBjbGFyaWZ5LiAgT25lIGNhbiBzdXJlbHkg
d3JpdGUgcnVsZXMgdGhhdAo+IGZpbmQgdGhpcyBraW5kIG9mIHByb2JsZW0sIHdpdGggYSB2YXJ5
aW5nIHJhdGUgb2YgZmFsc2UgcG9zaXRpdmVzLgoKV2lsbCBmdXJ0aGVyIGNoYW5nZXMgYmVjb21l
IG1vcmUgaW50ZXJlc3RpbmcgYWxzbyBhY2NvcmRpbmcgdG8gb3RoZXIgZGV2ZWxvcG1lbnQKYXBw
cm9hY2hlcyB5b3UgY2FyZSBmb3I/CgoqIFByZXF1ZWwKICBodHRwOi8vcHJlcXVlbC1wcWwuZ2Zv
cmdlLmlucmlhLmZyLwoKKiBNYWNoaW5lIGxlYXJuaW5nIGZvciBzb2Z0d2FyZSBjb3JyZWN0aW9u
cwogIGh0dHBzOi8vaGFsLmlucmlhLmZyL2hhbC0wMjM3Mzk5NAogIGh0dHBzOi8vZG9pLm9yZy8x
MC4xMTA5L1RTRS4yMDE5LjI5NTI2MTQKClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lA
c3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8v
Y29jY2kK
