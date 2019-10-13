Return-Path: <SRS0=gEjp=YG=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23338C4360C
	for <cocci@archiver.kernel.org>; Sun, 13 Oct 2019 14:22:35 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7222B206A3
	for <cocci@archiver.kernel.org>; Sun, 13 Oct 2019 14:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="TnhrT2rw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7222B206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9DEMJdB015222;
	Sun, 13 Oct 2019 16:22:19 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 91A0E7784;
	Sun, 13 Oct 2019 16:22:19 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id EDA5B7415
 for <cocci@systeme.lip6.fr>; Sun, 13 Oct 2019 16:22:17 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9DEMHRP021776;
 Sun, 13 Oct 2019 16:22:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1570976531;
 bh=J9JW/QfMun7X3mux5PQyVzRKNXdXUFaqoPtXg1xkCT0=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=TnhrT2rwe3NqNe3Bu9wR1tSRR01HKgArMF0b1wdzxuK3IVzxlZ1AcpkTZj+pZINzn
 /o4viBcpJRIQRj1HUEcxXwdtFLBYOQ49YgIj7LyWEJhpyUA2jyFvX3MqOm6T6VSt4K
 v1nAAGACddMJVECjMuoFzc0gxIBr6ZsATcD8lGw8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.141.172]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LfRvZ-1hi4tO1mzx-00p2yD; Sun, 13
 Oct 2019 16:22:11 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <56e7bd73-5b50-ddeb-9a56-62daf93eb015@suse.com>
 <a9ba6674-92cc-d8b6-f60c-1cf0162fba75@web.de>
 <alpine.DEB.2.21.1910131536290.3260@hadrien>
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
Message-ID: <5bab8a17-168f-6bb7-da1e-e3d3b92ca260@web.de>
Date: Sun, 13 Oct 2019 16:22:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910131536290.3260@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:L4cGY+2nZnulJt8/VgHmgwLsf9GN0wc0YhNaZT5D0m1s6i+j8O7
 urKznct81UFTshiDnLAkTtydBRdaq0tHu0KJbIxZoAMZx90ui5WoQTWDq3yFP/kx1CBCkyG
 eMJFxVOBYRqqMQgTdVrgQ0oejZgVmCkp9KU1a5YewgwF1nZ9aQGfnA//GZeaphcx3YMEDIg
 X3dl1+CyRu/d5l/ig97EQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tBfXqlzKufc=:v/ySXgr7Qvfw5Kiel5vtF4
 AlcRtVON6W990wakTKOLCjZQVYg4WT5jca/+RTX12SK39CB7fx6pXDUgmMK/c4Xzk5oQw1tI5
 gOVSIjX2MUrqRUri3tlUL5quyOZWktYoIuweWYyRo0S9DdQRPqBliPikjYl2WAAh2csvmxJRE
 CaClTvyPZRINZR1Mbe25Kg8kMc9gVRdglJPbWQCYdmWpNLuQyc6YhyS5gRq02vpVC8HHjbX4N
 bBLnqMSLCE69uH9vnR9JcRQ1IRtrCtseAaqiv0r1lf+wYua1xxgCM0083gM1WiArXnU8nhm+X
 u7wUHy1+AM3mPsqKrxV5Nj7zMAPimpOEC0RtAvqnn29R22kX/asOjdmwPv8KtHoshL9exLKVm
 o4nwluRECJQQNyGu/1ENsyi8dNjDDfTNYzhiBEK9KFXJbxsFUbUZeKsg6v2tWW4JAMx8dZ+8w
 itvAo98P6ZWnLyUrTAH5qkOylEcdDsGfAI3EEAz35E4D2WjzKiCUG2kDYQWptQIUqhMtnVtAv
 lXvsSht0GoWGUEV8mpRHA4z5HUlEfWMDlsTFkIwli0nrdv4iZ+qpqSKChdvf9gEhsJGQ7ATUh
 Oej9O4MiBHE3o8Qs3ImL9BUArpzYSQIC9s1J5M/QfoBsyGAdkwps+ALxmhno8phEIYkSWecbU
 zNDViutmXt33AZPKdqiNhRwrorsSANqA83m8/CKmE/BaSI9WDlsWwTk0G0HjXDOUvn2Jt0XNg
 3mwEqDdeosFNuPQsSaWrBVTRpX7sBjY2w1xFXwRGlekSvw/cARLxaNEUdMQdQzN0m7wUQyCH/
 CeOcGJ4Xbfq4S7UlvypVlDntizAYnaUh+70eHRyVGi2frwZPxpGw7aQ1m6Mxtqw+iFGYnTu78
 Ggs+5JIq+RGichISeSEJo4LqmbWyVPymeZeBRWl7+3TAqZDqurzHhOUYB4TDi42qAMrL+7msf
 F1EDsTFdhNvWjfhwtrAjEf5xETZUZqTdECKstCTBV7zU6iyMMU6I2mRyTCMHDA8NBkAOquRmg
 PnDEO7w7GlL+w4foqI974EjCgRU2qa/PsnW5SqmOyA8sYFZC10Lu+XCqN4UPN5XVKg4UhQVPc
 D0pShciZnbQbwKOucOy/Lxf0RwQKtD0Ma12bgew5CWQNwTHwtDxjVJeI3AIrtIrCZHgWczGrD
 q31qli8bMll2/kXt/9p8DozUIZpRF4AN6olb917ppC87CVRWmhF4BPOaByJXoPFH9A4QbDF7e
 +0KG85nChJk2IVRXSj2vKNXuFMS6Du/t/VCc2qkUMld1hOprei+3ysPomjx8=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 13 Oct 2019 16:22:20 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 13 Oct 2019 16:22:17 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] =?utf-8?q?Checking_the_influence_of_=E2=80=9Cvirtual?=
 =?utf-8?q?=E2=80=9D_SmPL_variables?=
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

Pj4+ICAgIHZpcnR1YWwgcGF0Y2gKPj4KPj4gVGhpcyB2YXJpYWJsZSBzaG91bGQgYmUgb21pdHRl
ZCBpZiBpdCB3aWxsIG5vdCBiZSB1c2VkIGluIHN1YnNlcXVlbnQgU21QTCBydWxlcy4KPgo+IFRo
ZXJlIGlzIG5vIGhhcm0gdG8gaGF2ZSBpdC4KCkNhbiB5b3UgZ2V0IGFkZGl0aW9uYWwgc29mdHdh
cmUgZGV2ZWxvcG1lbnQgY29uY2VybnMgaWYgeW91IHdvdWxkIGxvb2sgYXQKYSBidWcgcmVwb3J0
IG9uIGEgdG9waWMgbGlrZSDigJxNZXRhdmFyaWFibGVzIHdpdGggdGhlIHR5cGUgInZpcnR1YWwi
IHByZXZlbnQKcHJvcGVyIGluaXRpYWxpc2F0aW9uIGZvciBQeXRob24gc2NyaXB0cy7igJ0gb25j
ZSBtb3JlPwpodHRwczovL2dpdGh1Yi5jb20vY29jY2luZWxsZS9jb2NjaW5lbGxlL2lzc3Vlcy8z
NQoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6
Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
