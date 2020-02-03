Return-Path: <SRS0=ES+2=3X=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B005FC35247
	for <cocci@archiver.kernel.org>; Mon,  3 Feb 2020 21:14:18 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09C1C20721
	for <cocci@archiver.kernel.org>; Mon,  3 Feb 2020 21:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="aMC4GaQn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09C1C20721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 013LE0MA003279;
	Mon, 3 Feb 2020 22:14:00 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 83A4477E8;
	Mon,  3 Feb 2020 22:14:00 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 04364772B
 for <cocci@systeme.lip6.fr>; Mon,  3 Feb 2020 22:13:59 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 013LDwEf000613
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Mon, 3 Feb 2020 22:13:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1580764413;
 bh=Cm0oZTMy+abHYV4TGTe3P4oVkG0pqNrBbsysGdEtFtA=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=aMC4GaQnz23oeoOGZlRs3Yg151RtBSZlHybgyw+1QO4IADBU85CqqLOzGkMolYW+r
 WaHytv3qgczwxscYDGX/akD7kQdUQm5G79xLpVyQRvEh9RNkMynhBwhR3vw/AZlbCz
 JrK1m9fi1DmJVKwNVFWbADQUl9muszTNeYy/vEfA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.154.151]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LxO2c-1jaeFr1OyQ-0170kj; Mon, 03
 Feb 2020 22:13:33 +0100
To: Julia Lawall <julia.lawall@inria.fr>
References: <72729ef6-f8df-942f-57aa-4b3fac75a20d@web.de>
 <alpine.DEB.2.21.2002032151520.3356@hadrien>
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
Message-ID: <b318a372-2f31-f57f-4684-62ac2b82bff3@web.de>
Date: Mon, 3 Feb 2020 22:13:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2002032151520.3356@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:LY29r2v1rIEitAKk2Vr5FiFfjojRZ6BBOBhTRl/A2M8Y23wTGez
 Et71IVIxmYknVR04+IJdEkZAdWYP88DztBxrehXPzgrkDUU860+471/7tpVZnERnmRziQlm
 iJ6gBYDvdOv7xyFQl+HAwkhBCco5wcgS7TPa7GRime9CBWDILql8k2VO4zTlLzPKicU/c46
 waly0eYFnjxg0QuIOEc/g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zGY7G7ABNuw=:yIV2q+/uqZ2Bgnc1CR64Np
 zOHF/khN4hce52BKEEfhYgVcwqGIjnqkyp+S/DaYL7IS0ukqxmofql8GTk7hL9kNZdRp7u2iR
 9tgo8IIndSdcJETR8c89VGyWFR3blmQ6XXNmfwOEK3uhvxC6w9qFA/wb8FeV+WNPkOO0Ki+p/
 9Mfhvz+gm1OngJJ8lk1H8N+c4PbadmMKBG816jZweaMsbiH4dJ61aWI23ywBTiuAB8bLk82dF
 CM+Pp4bZEziZLAEhek2azW7nT6HoY7YMFGoGh00j/4kObt1SRqX4aeYShyyiw2aYBHLr3ghsP
 WoPXl9Boj0z2Ko0eue7XSyBXhjP386c12HsUanpxWd/oBEQWw3Is0TY42dLc4tA3+KTQqzTIR
 b8iorb35zUeLNO6AfvShAfX40shO0fZTfaAws8jy0i5uKQ9z0jzMX3YCWhQfG6bpmDWoG86pf
 tkpRlUCOZMmjAezyaLHH+fhGBsIus70JCmHNQWU8xHrhi+A/Aabl8wQcLnkgRgEr/HdMFc4wU
 05wrTH1V5Byl1rjG27a3mCb5dxN+L8Qp0vLrgy3Y4oAya+0ntlrUYbOqY7aC3cNeVYXahv/FL
 StirCXseXWGqK7ipgqhGjAcb1q+wHq5cWvoPq+PfykQWgbGByyVduqFC+omkvBqneMD19UFPh
 +DBFCSGiXXpDLusV0ALxhMLqFkgsvM7F7mdHWrZYedZodz+ZlD1fVDfBXeF5JYg/VrJjG1b+V
 UqOvSU03ef2zLfi6I+78NVOZErUmO009kTFayIJhJTswlE85KipXWwBPKjHnYUKfJbVKZvbst
 2UAMVA1z2VGMJ0OD8vL1sdkeGGXC2B7Ccfjnw2LYmwluKUZJZpzHSoTYfJksr/sTkkcSkMyXd
 OPfVFPSTGCc9gERTlTaX6wxwjdaSX5Cl4p3O7cp6fWZ6z7GuMEo1GJG3QT/oXcEK6+2sOy4jm
 gzg0naccxotRxxp+VWrfQTQHhOLHjKbF/DEnyYQmgdoFWAkNuy2nkRyFS+Fg5+alp+inzR3iH
 vmAKcjXIwLCCYVj1+CxT0DpHw2ACS5z9/5tvgRGUQV6WJzhEmT1GiH3YqoscYgDo04sNQAbI7
 9xaicsEjhLNufn91qQZyzod8XvujlA0u5woUM5IqtO6Qjl7BAqV1Td5u/BBY2mMaIU0o42EDJ
 EQjB7y3XMy2R399ie6CDSkgqeA3WAVHYW0Y1khFO6xXLXyme9z6qMqIOpNUq6ZerCTMaZyXFy
 fO9Hx95RTTSb9xCKn
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 03 Feb 2020 22:14:00 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 03 Feb 2020 22:13:58 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Wellington Wallace <wellingtonwallace@gmail.com>,
        Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Replacing a std::string check by strcmp() with SmPL
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

PiBXaGVyZSBpcyB0aGUgc3BhY2UgdGhhdCB5b3l1IGFyZSBjb25jZXJuZWQgYWJvdXQ/CgrigKYK
QEAgLTEsNyArMSw3IEBACiB2b2lkIG9uX21lc3NhZ2VfZWxlbWVudCDigKYK4oaRCgpIb3cgd2Fz
IHRoaXMgY2hhcmFjdGVyIGFkZGVkIGF0IHRoZSBmaXJzdCBjb2x1bW4gaW4gdGhpcyBsaW5lCm9m
IG15IHNvZnR3YXJlIHRlc3QgYXBwcm9hY2g/CgoKPj4gICAgaHR0cHM6Ly9naXRodWIuY29tL3d3
bW0vcHVsc2VlZmZlY3RzL2Jsb2IvYWNiNTE2MWE2YWI4ZDNiMGMzOTVlZDI4MDlkMzMxOGNjZjQ5
MzFiYy9zcmMvc291cmNlX291dHB1dF9lZmZlY3RzLmNwcCNMNgo+Cj4gSSBndWVzcyBpdCB3b3Vs
ZCBiZSBmaW5lIGlmIHlvdSBwdXQKPgo+IHR5cGVkZWYgYXV0bzsKPgo+IGFtb25nIHRoZSBtZXRh
dmFyaWFibGVzPwoKRG8geW91IGRpc3Rpbmd1aXNoIGJldHdlZW4gdGhlIHN0b3JhZ2UgY2xhc3Mg
c3BlY2lmaWVyCmFuZCBvdGhlciB1c2VzIG9mIHN1Y2ggYSBrZXkgd29yZD8KaHR0cHM6Ly9lbi5j
cHByZWZlcmVuY2UuY29tL3cvY3BwL2xhbmd1YWdlL2F1dG8KClJlZ2FyZHMsCk1hcmt1cwpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5n
IGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxt
YW4vbGlzdGluZm8vY29jY2kK
