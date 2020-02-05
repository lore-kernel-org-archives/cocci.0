Return-Path: <SRS0=pTva=3Z=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC314C35247
	for <cocci@archiver.kernel.org>; Wed,  5 Feb 2020 18:36:55 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56F922072B
	for <cocci@archiver.kernel.org>; Wed,  5 Feb 2020 18:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="E8wgS5Pl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56F922072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 015Iafcb007492;
	Wed, 5 Feb 2020 19:36:41 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DAE28772B;
	Wed,  5 Feb 2020 19:36:40 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5CFAD7718
 for <cocci@systeme.lip6.fr>; Wed,  5 Feb 2020 19:36:39 +0100 (CET)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 015IacJv029153
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Wed, 5 Feb 2020 19:36:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1580927797;
 bh=DhVA8aN4iItI3OLBf5VWy6QNS0NS3e0ocm+UzO4yjJk=;
 h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
 b=E8wgS5Plrq9YM69E2Lxj5yBGZBdFXlg7hI/hDcGer8i9+S/NISNghwysdtDHvvRIU
 8Sw3ivN8869BuNSh5is1VAjAZhXP7+IXDvOzK1Y4nxAXgvR39Tn3ACFL2+UwIyb4rG
 VajG69SE5Q1/ff4JBfl5uugJFcP5vQ4ZF6iXMf68=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.89.156]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lp6xk-1jVT610AlA-00evEv; Wed, 05
 Feb 2020 19:36:37 +0100
To: Jaskaran Singh <jaskaransingh7654321@gmail.com>, cocci@systeme.lip6.fr
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
Message-ID: <6e8147b7-da54-376f-0684-aee159e23d8e@web.de>
Date: Wed, 5 Feb 2020 19:36:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:oQW4Vc7bGXRGW8fKqBMNoQmtF+aTC36H2mATPH8alJp7OZUDZVb
 A1xh+rz5hIg9ol/vAp4P3rJexHYvZePU36eC2Bh9+DZhZy7WpGYn6MxoNZXwGXDfZWsOqFu
 T3FjdQU7K2EEOJqcQjpjyhua7AoocteF1qp8EVRzR+CTF42ZiZU4xlzCSF5Xy1JBf8oUb+l
 +dhKKRGnPSDmyvA3o9VZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3D1LSAloNaI=:Lkx6/uDg2++TRF39hkbcAo
 u8xCRpYreDXpg7aL2fpTNNGL85VUqFBnCHhbGh0cieGuK9h3y73RVUQTaK5gPXwm4DjMFwFT0
 X9Xyw2nQExxvM85/3793R9fjb0KITeUkJaWLMTYkwfqVFbwdDyNeBUstJwZVX6TzU4xGU5xTl
 BhYwvsStzCHRXUIv3ob865RPpFTknqeuhQ822nP0GqkeFrwyoWUkoDL/xmfZ+ORIwDQJKgAwx
 uVax6IRfOj6dRDhU4HR1hr5WQq9ziJ929wf4Ep2IMUjzimA41gzm0DuOM4NdjqbDpUuvT4C+b
 9p+sgfU27WUgX3lNyLomDHFx8oVQexySJViz33GSfsNARI1a04D2KIKekKUANj6H9nGz3XB9v
 /K5ZetjxRu1IiR6sfDF76SWfEywThQGtptnNp/+93cCInwjkZR9xEJy0HZrEqCOFlj76u+IG+
 RRGYuY+i7jxCckuoV/GD/JUdcSqRiyKLpB2w8emMtx+EuyPhFWJcVsHyDn8hrspD1qSD+8CVp
 PEKzlEiZEU9PlFHxb9MJbTYBRdu/VOkK9mFqjdjsU+I/f5e3IMgF3JIfM1aFo7snVXx5P2sfu
 d4Kxgbv2+lqd+oO2qrTnXU+XilZmIAx+LowIH4q6P2iYkcm9l/SCSbFl+9+TdQ2TmrbGMQt05
 7DC9YbS3iZKYWJT1Ggs1woo7Ux8lfrmDohn5/xxNiS7WFnbZcekPiTyDxM/a3gXdTPVJalc8e
 SnqU73Lyayt8sm2QO13f5tiyYjmVoZwr6FPlnyUe5Y8QuENzkPl5Mr8TeCT8ov1bVOMurjTaT
 1i8dUNqhYhbPtY+N0o71622F4RadpFIi6t87rbpejot+HcMcXgVcQDeTbq7BLkANom4vfn6uQ
 dAfRGq1Ma/tRMktkKx8xzXTbEtEWBrc95Q6QMM5N4A0gjQtlZepHWe8PeLv7tFxvNGgINn1jZ
 1k+cxPfKvMr9UA2MdXNBzjDkp2spABBCVKJFkJE5o5zBBMQ0EWs8vvtKXcwcdmMiiSlflOhLB
 cTH2Vhkp4eThBOJp9VEIz1M0qyqH8JolJ9m7atSUXzzpU9phICkXE+GcO2Mq/f+XqvJBEr6Im
 vUTylOjxZJfUmJH3wvRRVAD76dBsa1EcYCLuw6MCm7sA3My+d8OyXSSuJ3w8B5ahpqgZ8PWMJ
 nf7y0vbiEOUPgQECb8yG1Lbst50YxEqJyjSaj8HxoOnhulxUx0vBOCx7dvHw2ZtWJABGI2ZaA
 ntRWnDQPYH4UmEeEU
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 05 Feb 2020 19:36:42 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 05 Feb 2020 19:36:38 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Cocci] [PATCH 1/2] parsing_c: Align C AST and Cocci AST for
 pointers
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

4oCmCj4gKysrIGIvcGFyc2luZ19jL3ByZXR0eV9wcmludF9jLm1sCj4gQEAgLTgwNCwxMSArODA0
LDEyIEBAIGFuZCBwcF9zdHJpbmdfZm9ybWF0IChlLGlpKSA9Cj4gICAgICAgICAgICAgICAoRnVu
Y3Rpb25UeXBlIChyZXR1cm49dm9pZCwgcGFyYW1zPWludCBpKSAqKQo+ICAgICAgICAgICAgKCpX
Uk9ORyBJIFRISU5LLCB1c2UgbGVmdCAmIHJpZ2h0IGZ1bmN0aW9uICopCj4gICAgICAgICAgICAo
KiBidWc6IHBwX3R5cGVfd2l0aF9pZGVudF9yZXN0IE5vbmUgdDsgICAgICBwcmludF9pZGVudCBp
ZGVudCAqKQo+ICsgICAgICAgICAgcHBfdHlwZV9sZWZ0IHQ7Cj4gICAgICAgICAgICBwcl9lbGVt
IGk7Cj4gICAgICAgICAgICBpaXF1ICs+IExpc3QuaXRlciBwcl9lbGVtOyAoKiBsZSBjb25zdCBl
c3QgZm9yY2VtZW50IGFwcmVzIGxlICcqJyAqKQo+ICAgICAgICAgICAgaWYgaWlxdSA8PiBbXSB8
fCBnZXRfY29tbWVudHNfYWZ0ZXIgaSA8PiBbXQo+ICAgICAgICAgICAgdGhlbiBwcl9zcGFjZSgp
Owo+IC0gICAgICAgICAgcHBfdHlwZV93aXRoX2lkZW50X3Jlc3QgaWRlbnQgdCBhdHRycyBBc3Rf
Yy5ub2F0dHI7Cj4gKyAgICAgICAgICBwcmludF9pZGVudCBpZGVudAo+Cj4gICAgICAgICgqIHVn
bHkgc3BlY2lhbCBjYXNlIC4uLiB0b2RvPyBtYXliZSBzdWZmaWNpZW50IGluIHByYWN0aWNlICop
Cj4gICAgICAgIHwgKFBhcmVuVHlwZSB0dG9wLCBbaTE7aTJdKSAtPgoKQXJlIHRoZSBzb3VyY2Ug
Y29kZSBjb21tZW50cyBzdGlsbCBhcHByb3ByaWF0ZSBmb3IgdGhpcyBwYXRjaCBodW5rPwoKUmVn
YXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0
ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
