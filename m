Return-Path: <SRS0=k96f=52=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FB1C2BA2B
	for <cocci@archiver.kernel.org>; Fri, 10 Apr 2020 13:17:38 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 743D32137B
	for <cocci@archiver.kernel.org>; Fri, 10 Apr 2020 13:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="TwoKKyvI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 743D32137B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03ADHGxm013673;
	Fri, 10 Apr 2020 15:17:16 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7089A7816;
	Fri, 10 Apr 2020 15:17:16 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 970E377F9
 for <cocci@systeme.lip6.fr>; Fri, 10 Apr 2020 15:17:14 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03ADHD4O024632
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Fri, 10 Apr 2020 15:17:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1586524619;
 bh=o06HBHnDoKl1xmaggGdpoBkDOMLl3sYuBfjKGDb++LA=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=TwoKKyvIPQmn2cinekDaExr/TVEMSnCjekVZk+wKaYR5AtriSO2im2meAPKZxmMNp
 B8RJ4l4Oeyflfcq7cmK38xrdxkAAeGbxF1eOZ5malkuLjpPDX3dNrHCCOQyFf018oW
 X6eo6FeZRBsIpQPicv5A0OSptSmtfZQeXuAIDZZ8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.48.110.107]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0McnqH-1jehMR43YP-00HvM4; Fri, 10
 Apr 2020 15:16:59 +0200
To: Alexander Popov <alex.popov@linux.com>, cocci@systeme.lip6.fr,
        kernel-hardening@lists.openwall.com
References: <f6175913-560e-d554-cc2d-080b7f6a264b@web.de>
 <9a562397-ba60-8979-1453-b88153722803@linux.com>
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
Message-ID: <840858a4-2440-3fbd-297a-db2dacbcf24c@web.de>
Date: Fri, 10 Apr 2020 15:16:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <9a562397-ba60-8979-1453-b88153722803@linux.com>
Content-Language: en-GB
X-Provags-ID: V03:K1:v+bRW4fMl2adzNyrFQR2Q8ia//d4pX5Chhj0ORHfhvdK41mMprB
 p5QDlD323/aRoJWQNUrkzQuNpTbGYbVnTgRivxAgFm0ZmZLvkxyQieZe6TMpQgFzI6YZE7k
 Q7uKqOPwBrUgRk8w+KPsKRokxaYO8mVxdAivjyQDSEBadvlUDKYnq+EYdmY2+hEefhlRuO5
 i4nxAwPVFQELrKygrx/wg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VxdYoz9Irz0=:42nacQUtp3OpcoxicXil+K
 DmHNCzkL9mHHnJ12rO6Fkt2DRHVH7xuzgnFPn3C2cF4HNZdTXOox4kbBFZdNZaio+kVcs2JIf
 XqM3kTR8CTV+oEg8cvB/fQETEa2vduYqFz79LzBh4Eks9QQunOmrOR6ltveS4iuR+ylNaCeL5
 qIZ8w7bmqanJHZ/XWC+7agvX21FSX+7K7cCXcHxlU3k1u5fFs6eUC4diQynRknU+F2VKroXG4
 3lK6r6EVISyuJQeaHr14oTb77g2DextT7d//JxznUxe7XxpuNrpqkD53P6qjl8fSmWJRcc4tS
 5VfBosLuLDeoWPQcwKJ8WqnuR7iv7lm4nIfcqy3GNImK9lg1U1NzgiG6NNwraBC8w7g9paeya
 FHZFwOzS/n0E7kTQ1sjcLiGIILKyPNkFwcNZuSKtCj7hEbYXC3KjfVoiUvjtnnVApYhIkSPUQ
 vCmUsZ4c8ZsEdpKsvDCItm+nc/mJNT5bfJQwDXQ57Wwd4/48qcz2OtjP8isQ4FDNvGr9bufRM
 OBUFHEF9PGCWLD8WhJB4Ok4pBjTehoJghthWnFejNFBOy135nmTPO0nvkrRsWqFsA29uiSFlV
 FYl39TOqto6Aw8PPA0kxhdcTQtmHEmSHzIToLEGcqTochzrBJVPJWad8OsC9xcLK8hEwTyPU8
 H9AexgZl5RPMj2qlWOZWd41fpoZAzJTSW6x7kTh3FWLyS6OwgZcX41Duh2nBpvTrrigZPyOSt
 rHaME7OhZ32vkGjVWF84eyzFJB4eQDWH5iSqVxC43iBdJibzP0qaGfC4L7pnMSv6KjmaW1a0c
 lUo2Bs3zZL1hsb+VAwxS+yDDznZ4A7He7L6wIAi3PA4jA30Wt6v/errO6l+ewumHEVbPLk4ua
 21HLF+l2dPA3+bUa47fhGO5pPrzi3BZPXX6FtsfiwL8TmzhyYpetlpOn7X7PQ7UHAoKNXirJx
 34slYrsc8N5t8L2iFrir2FrhczC9Y4XZIDrcSCJbbKMzi4uL5n/hndZS0+3+dIsNfnBttv5lF
 Xrsc74F4yVnrQc0y2JHuaLwRvfzGi7Xa5viu4YD8X4IuGEf4nkPQ56MoU+0RG86bFmhGpevDt
 pwXEuFMJGI1lf80jOahMyJwD1navrQV0tq4ltGpMQmK33Qu7XxmCg5j0B7P+QH3y3k4B8qQwD
 Nc43r1ZTuhpDKKFwP14twBqTshFnDdTJB/B4i6JbDjRBqqqOgxyA0KqwTkchpbWtVT1RGrpwb
 ch3aYjE3AhT4Zlm9v
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 10 Apr 2020 15:17:17 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 10 Apr 2020 15:17:13 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>, Kees Cook <keescook@chromium.org>,
        Gilles Muller <Gilles.Muller@lip6.fr>, Jann Horn <jannh@google.com>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Hans Verkuil <hverkuil@xs4all.nl>, Julia Lawall <Julia.Lawall@lip6.fr>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: Re: [Cocci] Coccinelle rule for CVE-2019-18683
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

Pj4gKiBUaGUgc291cmNlIGNvZGUgc2VhcmNoIHBhdHRlcm4gY2FuIGJlIHRvbyBnZW5lcmljLgo+
PiAgIEhvdyBkbyB5b3UgdGhpbmsgYWJvdXQgdG8gY29uc2lkZXIgYWRkaXRpb25hbCBjb25zdHJh
aW50cwo+PiAgIGZvciBzYWZlciBkYXRhIGNvbnRyb2wgZmxvdyBhbmFseXNpcz8KPgo+IENvdWxk
IHlvdSBwbGVhc2UgZWxhYm9yYXRlIG9uIHRoYXQ/CgpKdWxpYSBMYXdhbGwgY2hvc2UgdG8gbWVu
dGlvbiB0aGUgZGVzaWduIHBvc3NpYmlsaXR5IOKAnHB1dCB3aGVuCiE9IG11dGV4X2xvY2soRSkg
YWZ0ZXIgdGhlIC4uLuKAnS4KaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvcGlwZXJtYWlsL2NvY2Np
LzIwMjAtQXByaWwvMDA3MTA3Lmh0bWwKaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvY29jY2kvYWxw
aW5lLkRFQi4yLjIxLjIwMDQwOTEyNDgxOTAuMjQwM0BoYWRyaWVuLwoKCj4gSSB1c2VkICdleGlz
dHMnIGtleXdvcmQgdG8gZmluZCBhdCBsZWFzdCBvbmUgYnJhbmNoIHRoYXQgaGFzCj4gbXV0ZXhf
dW5sb2NrK2t0aHJlYWRfc3RvcCttdXRleF9sb2NrIGNoYWluLgoKQXJlIHlvdSBpbmZvcm1lZCBh
Ym91dCBkZXZlbG9wbWVudCBjaGFsbGVuZ2VzIGZvciBkYXRhIGZsb3cgYW5hbHlzaXMKKG9yIGV2
ZW4gZXNjYXBlIGFuYWx5c2lzIGFjY29yZGluZyB0byBjb21wdXRlciBzY2llbmNlKT8KCkhvdyBt
YW55IGV4cGVyaWVuY2VzIGNhbiBiZSByZXVzZWQgZnJvbSBvdGhlciBrbm93biBhcHByb2FjaGVz
PwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6
Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
