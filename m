Return-Path: <SRS0=lWmI=34=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F4CC35250
	for <cocci@archiver.kernel.org>; Sat,  8 Feb 2020 09:20:52 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45066217BA
	for <cocci@archiver.kernel.org>; Sat,  8 Feb 2020 09:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="CoM6GDh1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45066217BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0189Kbn7020378;
	Sat, 8 Feb 2020 10:20:37 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7213B77ED;
	Sat,  8 Feb 2020 10:20:37 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 63BB67718
 for <cocci@systeme.lip6.fr>; Sat,  8 Feb 2020 10:20:35 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0189KYmQ019971
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Sat, 8 Feb 2020 10:20:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1581153622;
 bh=kaPibZL12x0QlgLnuqYIpBHS36+ByMQxniPnUqpwT3c=;
 h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
 b=CoM6GDh1IZSrPmfBqaWFQk2ecCq8sedFQDTSiQT+O73Mgc0PeeMPhMIiHoaYjCZn/
 U7zdHZBl0wUUkPM85IVYi78IcXjuvX653pV1kIZeltSDAcg44ppwBf8suTo9FyWckK
 9UEdNuDzWw/8Nz3iWaAfY15a6eX1EWYQ/UoV4JhA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.138.97]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MF3iV-1ikcqD2M3v-00GHXK; Sat, 08
 Feb 2020 10:20:22 +0100
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
To: Julia Lawall <julia.lawall@inria.fr>,
        Pan Nengyuan <pannengyuan@huawei.com>,
        Coccinelle <cocci@systeme.lip6.fr>
Message-ID: <7d67f19b-e68c-6993-a211-c95b0d61a2d9@web.de>
Date: Sat, 8 Feb 2020 10:20:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:OxgE3VrFmqnd3/bBSAFIRcHrq/UGR97MMICJT1oR+6QtOUE/V99
 DUlSvMAP82bGdOOuALD3fkW4W0ULqdYa0PcAvys0TyZOz17uW7iEsKMmWwTcDYY3zC5BMT7
 tVoC5qvtZMiMjBVp/QQrJyL7DUxoaMCZ+0e/pRuzeQt+Ws7U1EXVq4U42UlNbd9P8LhHXyT
 GAsoFnklcGLffEDjRHQPw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Mx/NMg9WKVM=:WsFzPQKyh5t2vjsIatqqiN
 RzvY8X4Dtx5OW2EhrMHYWG/0+KncadiNpM4GwAckzWcjjdbtaS98u5ERwkT49uamV1R3VqJQo
 hJQi7CG1U2eFV0UUgFOjKpCaWnccSoPTCQ84N5OXTRiOFFUdELmxR5Pb6e99aWNt2/s2mGE/D
 mv6eUaLgeS0hOV1IPyrp4v/frqFGv/PMQCGuFfjRXvvM3heNSOy1mLo7iGejI49RB4as2V/qo
 Og4aRdEUlSAj3sFS+v8OZCVxlF8UIMPiJ0ZqmRvlS8pOgMEtRt4txo+zGh7rX1frJDNmba2wK
 Aq1kvkBygM3QnjPXopRhgmq11ZxUby7fpRn3tf29lvkK0wg3HZ8QJPikdCryTZDkQSDlGpGZl
 1VtNjABhNPoUQkq/egaAZR2hkXfPq6xcsbpXIveNgPk0M2LgYR57kgFAt8tCThawVBule8GOF
 vv4CWlqdrqRgqDgWJExofzB/z+qp7xoMMuCXtKEZFK2zRk+Br8BhFC1Jhhcv4oQQGlE7sxAZt
 P5rAY7TE20ZKuSjeK4QkZ9ASNMwQlXxbcMS3dc9x2ouEwuU8RoyW/GeQCeAHJglcL/b9XIi/X
 Su1iFFnJeZgTotci/9vsVrPEW3OayowopkQsQo8La6gAxiFqKYo93zGJydJXLFfIqoGlqCVlM
 Slw/fJUrT6pIIwgxGjU5JHJNKoZV0As4UzcnANDNaHNtsz+Ds1m4oNyO0ESG/CsFBLv+PQ8PX
 c31+D2LcR4IzuDLuHAswX1SusG+FTcmSKue5TM0i6LYsEt1hNiQfjgReVvg71v5Yp+AiOSaxS
 n9Vnl7lUkJgx2aysYMqViiXHsh3BCqWPcJ+XbXQ7I3r328GDCJJBv1TvltbTbNNepEWLzGE/g
 bfK4kHsyVvrwr0MrzHqz3uyDRuDtQuwg7beIxpnGi98zYoQP6bXQbJbWXcVMGebXKUycClFjM
 P9gFPtkSdOXV/gt72bYWyCUDuqJRAa0Uy4agOYQtA1KAgjT+WjcE+JtNRu62yo21Jm5zQD5Ls
 JvjOsjIc2Z9rqF4Mc2tkNCSEj6Wyr7d86DcxSvpEqH1qvklYUbCZEhaCw5QeoBb6Hl9KaPLTK
 M+rvpWlnEnS0AePGpjDcWCLZRoftgxNR/fcKqFcPYGk3T4iOn0r/ibA8XCU6aa3So8tDP6k2l
 xTruiKi8cGT30niKRa7XPJHQ7D/7NVvFcp3LJTGNVgEChURavWkBmL+k1hrYWG8oh6PbtkoKD
 E2XLzzaAp+OwwQCRG
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 08 Feb 2020 10:20:37 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 08 Feb 2020 10:20:34 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Kuhn Chenqun <kuhn.chenqun@huawei.com>
Subject: Re: [Cocci] Source code transformations around g_autoptr()
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

PiA+IG1pbnVzOiBwYXJzZSBlcnJvcjoKPiA+ICAgRmlsZSAidGVzdC5jb2NjaSIsIGxpbmUgMywg
Y29sdW1uIDE1LCBjaGFycG9zID0gMzgKPiA+ICAgYXJvdW5kID0gJ3AnLAo+ID4gICB3aG9sZSBj
b250ZW50ID0gLSBnX2F1dG9wdHIoZCkgcDsKPiA+Cj4gPgo+ID4gaXMgaXQgY29ycmVjdD8KPgo+
IE5vLCBDb2NjaW5lbGxlIGtub3dzIG5vdGhpbmcgYWJvdXQgdGhlc2UgdGhpbmdzLgoKSG93IGFy
ZSB0aGUgY2hhbmNlcyB0byBpbXByb3ZlIHRoZSBzb2Z0d2FyZSBzaXR1YXRpb24KZm9yIHRoZSBz
YWZlIGhhbmRsaW5nIG9mIG1hY3JvcyBiZXNpZGVzIHRoZSBleHRlbnNpb24Kb2YgYSBzb3VyY2Ug
ZmlsZSBsaWtlIOKAnHN0YW5kYXJkLmjigJ0/Cmh0dHBzOi8vZGV2ZWxvcGVyLmdub21lLm9yZy9n
bGliL3N0YWJsZS9nbGliLU1pc2NlbGxhbmVvdXMtTWFjcm9zLmh0bWwjZy1hdXRvcHRyCgpXaWxs
IGFuIGFkZGl0aW9uYWwgY29uZmlndXJhdGlvbiBmaWxlIGJlIG9jY2FzaW9uYWxseSBoZWxwZnVs
PwpodHRwczovL2dpdGh1Yi5jb20vY29jY2luZWxsZS9jb2NjaW5lbGxlL2Jsb2IvN2VjMzFlZDFm
YWRmNzM4YmM0ODdjY2VmZGM2M2JmZTA1OThmNDRjYy9kb2NzL21hbnVhbC9zcGF0Y2hfb3B0aW9u
cy50ZXgjTDM4NAoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYu
ZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
