Return-Path: <SRS0=qZnA=XC=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CA1C43331
	for <cocci@archiver.kernel.org>; Sat,  7 Sep 2019 14:55:02 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DED022178F
	for <cocci@archiver.kernel.org>; Sat,  7 Sep 2019 14:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="rGc5T+mH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DED022178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x87Esief027795;
	Sat, 7 Sep 2019 16:54:44 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 48FDA7799;
	Sat,  7 Sep 2019 16:54:44 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A6D7B7797
 for <cocci@systeme.lip6.fr>; Sat,  7 Sep 2019 16:54:42 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x87EsdIR022322;
 Sat, 7 Sep 2019 16:54:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1567868069;
 bh=O1NvrfdRQCUnM2Q7XzG+b6t8dTRUl964m6dVHbGrVmU=;
 h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
 b=rGc5T+mHBtcHa/cRwW+u7h7dbf4kNuJpukTm7kElvrqQQS6bBhTNUsuH3mAyW5/Cl
 O7L7krjt0HBT7OSLT7DMsijrD1tqOWKnpnwJw3rQPJM6CoWQFuVKGKLS5gtZ/DFt3B
 k40qVmZF8Ht9AWih4Uronb0MNykIm4ABWbFpNHds=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.16.142]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MTPn1-1hgSGo1CgJ-00SL4z; Sat, 07
 Sep 2019 16:54:29 +0200
To: Coccinelle <cocci@systeme.lip6.fr>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <c8e0db8a-1f96-dac0-791c-43e2d1e1cf05@web.de>
Date: Sat, 7 Sep 2019 16:54:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:bX2yKsoKVIo/fOJuQzhjc4RVBhLXPd/Caf/UM1nCSHqh4mk3pJ8
 PXiG3As2LYW4z2CUjKeKGaeJIKlNTtyCZLiXSRaPfxnHASf+A5Au8vAzwSceHOjSWhMimgH
 yezajDoaf8bAQCnSG5QFvzlrjFGOZYoexo2RvBCYCTDBVn2sJY2P9bnCnZJsQjRnl4TbAK7
 y2US6ohqQYCyje/PzFofg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7Pf4+PS0MmU=:37ALyeMABgtJy2/tpSaSW6
 wZTWuHlhMKAvGpNUwFpAwkQfR3SGiejiUcrLtpkgPUvPbeVRWRxCCE2Ocr80kQDvO3RDxmu/A
 HSSa/kkssMpBcBQ3UY/XLaq5rWO8ftxRK4e1zrYFKO0WxEh1AcmushoXVgp96ErIG6wiijhtV
 AKdgPI1Z0gYtbhoN7hPB/5TqbCgH4Zbk0FIVeJuY2a9Q4BZv0eZBF2CQ7uai1HAeEofewoU87
 pKxcr9QOBRFhBiO28zs1g6eWP+uNIHyjqooOW6/XwOjab6WmVIH7cr3ecH2XrIj1+07qlE+2D
 cl6DLkONhAE2fwGZxHH/jAZQqjqQtdba7EFOhAsTjUz9lbBeaQXAqwNSfvghfvpq4Z7deoXKS
 bHnCZb0UwlUYxzIT7EE78/E1rSVn63C1JyCY+Ur2IqLTnnj4mdvZiLHJoKtByAHe9muRH46y1
 AwI34+hZwjNsfDwRb2F6RXon63ueEOKMBQOWDqz1kkGguSPOKwXyxh6Dgc18A9zxVC/IKidNj
 j8n5rnbxAQA0MBIvsftlS/d4l1gjsonlUvQ5FJxZWNcVV6uD19HHsn37mBDUYU1h32DTpso5d
 8sTgDzTNYS2yAQ5UkRbOsd2bLygLx012cStCbyhYWf5Asx5MAwX657MynDyhH9nagx6ZkH3uV
 b2JNV44m3WD/UuMGyA+w5yADG7FcFDFYA1wJF/Wpe6r+X91kheMywSYuBzdh9BNaiuZj6WCAM
 jGD7QCaNt9aR/s5/Y5QaO9fv3EGfFtFG/78NISqtHq9kN3jz6teqGEMLij38b/+EVUiSiPNYQ
 eMyFBTLmRa8aXGaTEBFx/bbZBDY/WeETPiVgKNyBvJkY4+kBwnzkKKsWqRhOr6bEEgPuq5z47
 IDjfXRlUCJbIHkqUhWA157XwzbaDTVxvrxBVqytX+5B95+7LyhEBdGb5CIIE/kT7UWDhWszTj
 sgPWlndJLbB13y/7U1QSfY8XAlGShFHs7kRlIRCEU71eehXfLCRzfBj9Aq3RfpR3NAYAVlF+I
 DHkxhN9TXhhFCUOXimRH+7Gt4WDItQLccr8KwAkDZ+dIbbcITrjY9K1pDibY0IHw7V1MsH9Uz
 PVTb1nc0AXMDTFu73F/vnNj1PrzljkIf9sOR6UZKDG7hodtxxmR+L1wlRz0d+ZwzDxOAdP+gw
 PW6he1dZPDAW+7B1tZ8eIusWJCmQku9Qg9kfrsh4H02IiOqpQMRu+sJEAKGdoS6a+b9SIqA5M
 r2EPhYhVnmqay143S
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 07 Sep 2019 16:54:44 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 07 Sep 2019 16:54:41 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        LKML <linux-kernel@vger.kernel.org>,
        Allison Randal <allison@lohutok.net>
Subject: [Cocci] =?utf-8?q?Adjusting_SmPL_script_=E2=80=9Cptr=5Fret=2Ecocc?=
	=?utf-8?b?aeKAnT8=?=
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

SGVsbG8sCgpJIGhhdmUgdGFrZW4gYW5vdGhlciBsb29rIGF0IGEga25vd24gc2NyaXB0IGZvciB0
aGUgc2VtYW50aWMgcGF0Y2ggbGFuZ3VhZ2UuCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3Nj
bS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL3NjcmlwdHMvY29jY2lu
ZWxsZS9hcGkvcHRyX3JldC5jb2NjaT9pZD0xZTM3NzhjYjIyM2U4NjE4MDhhZTBkYWNjZjM1MzUz
NmU3NTczZWVkI24zCgpJIGdvdCB0aGUgaW1wcmVzc2lvbiB0aGF0IGR1cGxpY2F0ZSBTbVBMIGNv
ZGUgY2FuIGJlIHJlZHVjZWQgaGVyZS4KU28gSSB0cmllZCB0aGUgZm9sbG93aW5nIGFwcHJvYWNo
IG91dC4KCuKApgpAZGVwZW5kcyBvbiBwYXRjaEAKZXhwcmVzc2lvbiBwdHI7CkBACigKKAotIGlm
IChJU19FUlIocHRyKSkgcmV0dXJuIFBUUl9FUlIocHRyKTsgZWxzZSByZXR1cm4gMDsKfAotIGlm
IChJU19FUlIocHRyKSkgcmV0dXJuIFBUUl9FUlIocHRyKTsgcmV0dXJuIDA7CikKKyByZXR1cm4g
UFRSX0VSUl9PUl9aRVJPKHB0cik7CnwKLSAoSVNfRVJSKHB0cikgPyBQVFJfRVJSKHB0cikgOiAw
KQorIFBUUl9FUlJfT1JfWkVSTyhwdHIpCikK4oCmCgoKVW5mb3J0dW5hdGVseSwgSSBnb3QgdGhl
IGZvbGxvd2luZyBpbmZvcm1hdGlvbiB0aGVuIGZvciBhIHRlc3QgdHJhbnNmb3JtYXRpb24uCgpl
bGZyaW5nQFNvbm5lOn4vUHJvamVrdGUvTGludXgvbmV4dC1wYXRjaGVkPiBzcGF0Y2ggLUQgcGF0
Y2ggc2NyaXB0cy9jb2NjaW5lbGxlL2FwaS9wdHJfcmV0LmNvY2NpIGRyaXZlcnMvc3BpL3NwaS1n
cGlvLmMK4oCmCjI5OiBubyBhdmFpbGFibGUgdG9rZW4gdG8gYXR0YWNoIHRvCgoKSXQgc2VlbXMg
dGhhdCB0aGUgQ29jY2luZWxsZSBzb2Z0d2FyZSDigJwxLjAuNy0wMDIxOC1nZjI4NGJmMzbigJ0g
ZG9lcyBub3QgbGlrZQp0aGUgYWRkaXRpb24gb2YgdGhlIHNob3duIHJldHVybiBzdGF0ZW1lbnQg
YWZ0ZXIgYSBuZXN0ZWQgU21QTCBkaXNqdW5jdGlvbi4KQnV0IHRoZSBmb2xsb3dpbmcgU21QTCBj
b2RlIHZhcmlhbnQgc2VlbXMgdG8gd29yayBhcyBleHBlY3RlZC4KCgrigKYKQGRlcGVuZHMgb24g
cGF0Y2hACmV4cHJlc3Npb24gcHRyOwpAQAooCi0gaWYgKElTX0VSUihwdHIpKSByZXR1cm4gUFRS
X0VSUihwdHIpOyBlbHNlIHJldHVybiAwOworIHJldHVybiBQVFJfRVJSX09SX1pFUk8ocHRyKTsK
fAotIGlmIChJU19FUlIocHRyKSkgcmV0dXJuIFBUUl9FUlIocHRyKTsgcmV0dXJuIDA7CisgcmV0
dXJuIFBUUl9FUlJfT1JfWkVSTyhwdHIpOwp8Ci0gKElTX0VSUihwdHIpID8gUFRSX0VSUihwdHIp
IDogMCkKKyBQVFJfRVJSX09SX1pFUk8ocHRyKQopCuKApgoKCkhvdyBkbyB5b3UgdGhpbmsgYWJv
dXQgdG8gcmVkdWNlIHN1YnNlcXVlbnQgU21QTCBydWxlcyBhbHNvIGFjY29yZGluZyB0bwphIHBv
c3NpYmxlIHJlY29tYmluYXRpb24gb2YgYWZmZWN0ZWQgaW1wbGVtZW50YXRpb24gZGV0YWlscz8K
ClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8v
c3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
