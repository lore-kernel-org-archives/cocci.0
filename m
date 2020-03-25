Return-Path: <SRS0=YhuU=5K=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF51C2D0E5
	for <cocci@archiver.kernel.org>; Wed, 25 Mar 2020 18:00:37 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64D1F20774
	for <cocci@archiver.kernel.org>; Wed, 25 Mar 2020 18:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="TeIxAl6P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64D1F20774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02PI0E08027216;
	Wed, 25 Mar 2020 19:00:14 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 14B067749;
	Wed, 25 Mar 2020 19:00:14 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id EDF7F66CB
 for <cocci@systeme.lip6.fr>; Wed, 25 Mar 2020 19:00:11 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02PI0BMw024647
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Wed, 25 Mar 2020 19:00:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1585159210;
 bh=yDxntOwqbvoN6L3Mw1sOGpLEB+GZZ4i5EZ7JdoFvPfk=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=TeIxAl6PIeI1SVSZRwAD3nP+4UL9CsfcN3lHk8y5qH2R40FLEhOY3U7wRqDSCrWUJ
 ZDBuy9PZlGf7x0LF2nw243JGowbdpCx1FWKLKQe543MZb4OSawfa9HfyKw2bommtZ5
 t/pPWO/Jq+23nz/Mc3o3pVx4kGbcyG0d6BGrY0ts=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.140.118]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MVLj0-1iknDw1frC-00Ylzs; Wed, 25
 Mar 2020 19:00:10 +0100
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
Message-ID: <6658f112-0e62-498a-2947-165330d06bfe@web.de>
Date: Wed, 25 Mar 2020 19:00:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2003251830510.2306@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:eQnKS/Ld3C3cspzhc7hm0piwhnjpbD2Bur4V1l7IY864EAr70fH
 Mgeyta+ceGBhm5wBaYVahzQ+oCIldo4GtvEG2azRzqE8GwNdgDPp7bhy05eERF73KU9Snn8
 TiWf4xBIqabHiJRKxfsYyeGKIXKcanujyAFu0Mg2uXfckBLYn/SLQLxH6Q0utd726HNXNy8
 HIWSpi4u4kVlQCNY33jOw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bCga468p0UQ=:dP2x5vW80w3LiSdWJzrEw0
 pIUPgJs6tNV3pi8oDUec31kBW8wVWpXwTdlg+pfbKa+OGHXnQWy9kGziauc0v7ItcKYqHURy4
 vjykif15EO2rt3Bl67sAXR2A+Y1hJqMkjBPZmMPz2jpb2MA0buv7VbnlUCYcLuLmrUwX3dULz
 OZLMGW/db42Obi3JvOITOsz6J/CLZgrtlm8mBC2E2TGEufuQV05XmHzJ3svQjqd3S1icS2IeR
 T9RXTa5zW4iwEsTPJxNC8pK2VTxOmsThQLOyZPIttJTeQj2igUZHhOtIZ3Y3yaQYeRaB2adMY
 tjCiiAUXbqKLO1TKVcQXpox0F/rGt2XGbddMLrl3YWicHTJxzJ2RrqB4LtsEXlsMAPykwJ3v3
 /f9MtFzF2xY/0aEaPm/GCRK9DDY0nYkG2j8wbytLIgvgalgAXjUTr3I+f/0ciueinhsinrr02
 Hn4pkDMHn4fCxuqH0SAwfQGpOhuhehYcBSplX8VrQjKxOK90Bm656bo3878ChyEBD2GMKe4mf
 2f+W3IHdwhvhCL0K+8yZIue7UYtRqpBa9XrSByT97nXlNZlg+GgWvF/QKGauFIWCuEU+WJjLk
 Sfvpzjmb7bLNdvfUs3DeaDjqHJf8VZRetvSqcA7CdDN8aQe8YxoKolJCGEoa+bX4o6eynUoJS
 LhQpVBifQnuaNWcsOemdgb+yIUWcrrOuUzkywKe+JXTgEe0DcOBsUO+rE8mIvOU6HLAD9iaEe
 rSm1FQB8C+0TNxQOgOkuZLE/nCSjAHrHy7Z6CHUb7ZrtYcLqJgOY7dhZFDa7VZ4PTsoSpr636
 cZiZYcCaqpcAG2AttA50MCnBkc6J/d8lB09l1p3Dh0h/sy9sNgJFu5ovwBSOJXUciY3Hnqdiq
 +1tcboL9xJZ0XFbsLLpkw8u03jZ7sBRwWXfEY98oPFvip+ZVD+E63hZnpM1+F7Xjpao9Vyjn1
 qmE2H6Tmk2Uon7OXwoVRwD+RHh/bPj8FcbZpVATM6xZ3LT12WRollfHcZQhFBsbmGEohf+L8P
 aCO6HB1fB4sxX4w9GAmH6bU9x1KssOL56GgIK2hEWs8nKbFMUSb0RiZKq9HC3YyG26U0wXBBg
 N1aAMOcjx2oozYnyJUtED1s4SMkYpEVD2CeGuXC9DYabp+0SUCh0HRERbHMbgW9AobOemKjV+
 tbqCiJu4erHy/bXpMlRFnkSJWnDFV9mCStf3qSqcBO8Lf57UNhP/234TJ8tUvzHB8fCJ+bDdp
 c4Gq+JLVy1mUqEIJt
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 25 Mar 2020 19:00:14 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 25 Mar 2020 19:00:11 +0100 (CET)
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
PiBJJ20gbm90IHN1cmUgd2hhdCB0aGVyZSBpcyB0byBjbGFyaWZ5LgoKU3VjaCBhbiB1c2UgY2Fz
ZSBjYW4gcG9pbnQgc29tZSBzb2Z0d2FyZSBkZXZlbG9wbWVudCBjaGFsbGVuZ2VzIG91dC4KCgo+
IE9uZSBjYW4gc3VyZWx5IHdyaXRlIHJ1bGVzIHRoYXQgZmluZCB0aGlzIGtpbmQgb2YgcHJvYmxl
bSwKCkkga25vdyB0aGlzIGluIHByaW5jaXBsZS4KCgo+IHdpdGggYSB2YXJ5aW5nIHJhdGUgb2Yg
ZmFsc2UgcG9zaXRpdmVzLgoKSSBhbSB0cnlpbmcgYWdhaW4gdG8gcmVkdWNlIHRoaXMgc3BlY2lh
bCBjYXNlIGNvbnNpZGVyYWJseS4KCgo+IEEgc2ltcGxlIGFwcHJvYWNoIHdvdWxkIGJlIHRvIGNo
ZWNrIGFsbCBvY2N1cnJlbmNlcyBvZiBpZiAoIXJldCkgZm9yIGFuCj4gaW50ZWdlci10eXBlZCB2
YXJpYWJsZSwgYmVjYXVzZSB0eXBpY2FsbHkgdGhhdCBpcyB0aGUgc3VjY2VzcyBjYXNlLgoKSSB3
b3VsZCBsaWtlIHRvIGluY3JlYXNlIHRoZSBwcm9iYWJpbGl0eSBmb3IgZ2VuZXJhdGlvbiBvZiBj
b3JyZXNwb25kaW5nIGZpeGVzLgoKVGhlIHN1Y2Nlc3MgcHJlZGljYXRlIGNhbiBiZSBhbHNvIHRo
ZSBvcHBvc2l0ZSBpZiB5b3Ugd291bGQgbGlrZSB0byB0YWtlCmEgTGludXggbWFjcm8gbGlrZSBh
Y2Nlc3Nfb2soKSBvciB2YWxpZCBwb2ludGVycyAoYWZ0ZXIgbWVtb3J5IGFsbG9jYXRpb25zCmZv
ciBleGFtcGxlKSBpbnRvIGFjY291bnQuCgoKPiBCdXQgc29tZXRpbWVzIHBlb3BsZSBkbyBwdXQg
dGhlIHN1Y2Nlc3MgY2FzZSB1bmRlciBhbiBpZi4KCkkgYW0gY3VyaW91cyBob3cgb2Z0ZW4gc3Vj
aCBzb3VyY2UgY29kZSB2YXJpYXRpb25zIHNob3VsZCBiZSBjb25zaWRlcmVkLgoKUmVnYXJkcywK
TWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNv
Y2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxp
cDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
