Return-Path: <SRS0=+m3J=5B=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16457C0044D
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2020 19:20:34 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F8F020674
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2020 19:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="lSUv3YL6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F8F020674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02GJKF44012520;
	Mon, 16 Mar 2020 20:20:15 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4D017781A;
	Mon, 16 Mar 2020 20:20:15 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 565257809
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 20:20:14 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02GJKD2E001153
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 20:20:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1584386413;
 bh=bEHO66UEobFxUGWTSomwDu9jHdMx14VSK8o7Y2Y6MMs=;
 h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
 b=lSUv3YL6fPlbWVH/R7YK0ARDM6v5SOkMRTi+9n1lB/bSp0ih5SKAz9p6pd6e7YGgr
 ZD3yZqSIJ2fhwAKqmsbMU1MjgalJAOA0wOZ99oQkMprfz+TwT533dlCgYVjtpZ4iRl
 G5RoXaqGzkI42M3ctwBTFtX/WOz6PWkSAMga43LA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.93.189]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LcgVn-1jcIbD40md-00k8wj; Mon, 16
 Mar 2020 20:20:13 +0100
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
Message-ID: <4d55d76c-29d1-1c88-d8ad-606e32a938d9@web.de>
Date: Mon, 16 Mar 2020 20:20:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:BOhN6rIEgH74t21GYJqbpfP/Ra2v/Rkx+v+c/efUY5YAlrWs6n0
 qaktCxK2ULmGxWXmO5WYUDAxsUhEI898hediyi/RB6s1r8DbMhcH7y4IEvkjiPxmYlIS11P
 dJ6uAbezffv+OexYD/YruXfrbudyQPkUkj+djO9BWbxVSE/7lr+WRmugg23kMz6TY0YPZfE
 NIG/vPtSgkWRNN/Jh7o1A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kYFiP8IKKyc=:pk4/3pI4bdeQ2kcxK0uC1/
 3VrtohoeOEzweSS9e66qg2ADVV1tP+kxC0EiXqF02Le8IOI7ym71aXub+97VqfQx2eC+7QyOU
 l6YR4TA9PAqsNyNhSKFn4zGQDLxizLw/kO8yHQrPXl2zmdAJiAmFFS/SuFeRq/wtcmS0sayD8
 4G2Kc9q8/sVvfEVbU1sd2WHaWPaNcQypmkkSifB5oPQL48kP9YqOCsIqAzfH/TrV1tlbTLV0M
 9lcLzwX6SZ6ii4RHbkmIH9GDZcAK0desY3YR/jTOVKvWPZ5z0HYDFaSwRYiH8qwX6jC6t3V6p
 taPoH9VYaaOjOfZ6RvK0tr/l9Xn7AqOU/6fleQBXJ/6SJC/qbA9FmLdLTP6KRZq6dIZ79AfTF
 v0Eq/wRU7WtNzQNMHShktBkqM8atfGMnavxv4sZ3JWvIgaNAYaTp1OKt/96iFNfeXY+0KFK9j
 ZdK9xXeJXbMZEyaDkThl5qfJv+F2SuK8nyjTV//H3hWpKUckZaaxDhEO1Cmq260/KpwBTUeHp
 YEuvX8AaZLyvdBzGqU9R3qP/1gMmfF9/XdFoTOYukv7/Lv1UpUB/ROq3xBdEq80fdtDXM86DO
 hpXntnMNqoqVrWO//H9qFvJ2Cq3aQnvN9bV3WlnnowtQSnzlwywV+Ihqgoavi4F9L62Tlu+ep
 lEs/ESCpkbCMj+HYOEpX5WY+Vooxs4ZY1IXxpbmRCLC4jUmvdBm0aqa0KeLHMLjJN1BVReWMl
 g73qjnUyxJ1pxU3LcFm1ROsKM5CjOTRYIoxWmCYGFSbrD6MZKC89j5RRI+6v9yTCX+fYggrY+
 ZjDpNmc22LPUKxmhzBxOrCqvTkgGkQN4v4oAXBWsUqYDL7o2WkQIp3javAylKlhIto+RC1i4i
 exeric+lrX9XWPCnFv0KAgvU7mp3nn9uMOIixSTtMCfgkjKhppR+RkxV1xcPfJo87GxOZL0Jx
 T0JgWng+xLrB3aQPKM/aXPmHJXvZ2EWXD6tOoUbkaR+hNYgAkbVhV99xAy6ONj92bpJNOEaow
 VRCD26p2PCZtXwFesV6PdeLFM6kGY/xjqPfttf3WdhU2qNi377wpE+y/ezumVhnUZN3cclEcy
 rFrj+tJJ2xjjNYgU4flQb/lwEGt9OW0+ytlugFsLOGEiIWpibIIvKJMIQmUDq57joaCrakJ2p
 Yng3G1vZb4VbQ7H6PcTDrEhdFJ1XA7GmXIHTkYPTRBLvc5/TQlIszGbd/jTefHqpdlpjaFFXa
 p52zqvcT5A418uT34
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 16 Mar 2020 20:20:15 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 16 Mar 2020 20:20:13 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Cocci] [PATCH 06/26] parsing_cocci: arity: Add cases for
 ParenType/FunctionType
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

PiBQYXJlblR5cGUgYW5kIEZ1bmN0aW9uVHlwZSBhcmUgYWRkZWQgdG8gdGhlIFNtUEwgQVNUcy4K
PiBBZGQgY2FzZXMgZm9yIHRoZXNlIHR5cGVzIGluIOKApi5tbC4KCkEgY2hhbmdlIGRlc2NyaXB0
aW9uIHRlbXBsYXRlIHdhcyB1c2VkIHNldmVyYWwgdGltZXMuCkkgd29uZGVyIGlmIHRoZXJlIGlz
IHJlYWxseSBhIG5lZWQgdG8gbW9kaWZ5IG9ubHkgYSBzaW5nbGUgT0NhbWwgc291cmNlIGZpbGUK
aW4gdGhlc2UgdXBkYXRlIHN0ZXBzLgpIb3cgZG8geW91IHRoaW5rIGFib3V0IHRvIGNvbWJpbmUg
c3VjaCBjaGFuZ2VzIGluIGEgYmlnZ2VyIHVwZGF0ZSBzdGVwPwoKUmVnYXJkcywKTWFya3VzCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxp
bmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFp
bG1hbi9saXN0aW5mby9jb2NjaQo=
