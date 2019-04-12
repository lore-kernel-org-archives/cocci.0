Return-Path: <SRS0=tjLV=SO=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B89C10F0E
	for <cocci@archiver.kernel.org>; Fri, 12 Apr 2019 09:42:47 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58D9A20850
	for <cocci@archiver.kernel.org>; Fri, 12 Apr 2019 09:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="iOkmELqy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58D9A20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3C9gVxj021852
          ; Fri, 12 Apr 2019 11:42:31 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DC21F7727;
	Fri, 12 Apr 2019 11:42:30 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8F9E1771D
 for <cocci@systeme.lip6.fr>; Fri, 12 Apr 2019 11:42:28 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3C9gRXK014524
 for <cocci@systeme.lip6.fr>; Fri, 12 Apr 2019 11:42:27 +0200 (CEST)
X-pt: isis.lip6.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1555062147;
 bh=AxaSycK2SX0eItcLCLWNGWXwFRVkQ+LSRJu646pFenc=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=iOkmELqyxWaTOp/g10u5+WdIhij2LZVxjR6vLHe9ab+Yj9I4qIfZslER4NnodXYWI
 yRKJHKJ/3Ul7TQfj4p0rT9t3iG25NzoljtbW8TXjmpEkPNhRHbt9Fl9msAcxD2s0WP
 UvNQQi38PrNezSmqnEMmPkGUVJd7mrVVKzDPD8lA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.147.79]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MJlGW-1hFydD1ASS-001DeY for
 <cocci@systeme.lip6.fr>; Fri, 12 Apr 2019 11:42:27 +0200
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <8d40a536-c2fe-7d6b-58d5-840e013665f1@web.de>
Date: Fri, 12 Apr 2019 11:42:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:vWEssxX9MAeRdlHqxPYlTeSlRmiVAXTiGcop5a+/wCg1GbFNT3n
 +whi5KgGgTI5/T/p9XBhHUAridBocr8NTM5rWb4Ml+eTz0U86wtkneSDsdE7h1balUhG6Ib
 sApFtR324+FNBKWXPwaHYiV3hOaeyiTaDU1DIxZCVCTXSXyF9pskRK5HG1UL9MO7uqgs+Tr
 kS5gmiqMEXciCXEuEV4MA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JWQUOaSVFBg=:UosHkRAuPmVEtyev4NXZhl
 yRmSVyZocroLOqc9qcbVClipcJOYxC3azD0zrLhCTQwztVYihV4e/75HqaVCcTUAf781fAjvg
 ySrwY5VI1lTdeM/RpMIhjPfRlvwbu1ZqmIfAN3xNhc1dBUKvcTGVlU3saaMzSAmLD+lPp4yOa
 zxvTr2/f89FJPDcabLsfGBvWnDzls+GnIKaOkYNzNn7LDhCgq0szK0UnVi0O+ke4S2f0S8D7P
 OdA4ECo1toFKRmasz2iBfACf3q+sNFOPg3LtNrTy0TxSIwLL0UHL5PPiF2CANRJQMtokB1Xck
 SY1cQnRgiYQrAMb09tjJ650p79V1bGb0lNCfbpwVus/TX/qbhCAoemOYHjMuu53wYv0WNAZbl
 QT6MnpJXYXRMVro7JBwh+DLEnW7Q4fMBbMzsaIW4ZS141RVudUG48j7xr5ZkoJupbPyrO2XtU
 XhESv9hwaDA3LUI9M61mZwokPn6JTkJLveivzKB+mfBElJvC3/nX23lgncl+dM8CUPGqf6AFz
 6uNHwAEviOY6AWey1+SDI5fRWCsjUBrq0NjNO+JC6X5K0bi71SEu+leQZP7G/hOsPmyeTMxcQ
 4miK++aW+XQfKimzm27WnYcpJGAbXcSuWu80xpHePWDWY22tk9J4svh8JlbdZ5aHC6dBcgoS3
 6Zc935X+7sGKXPTAn7lKa2JBtAiz56DdnKEn7HgsREZVEFP25LinjL9XGGRTEW5tlVr+jnHm1
 6WnDC5+6fkS5muJqNf5zUzdoVKkcNz/jpg2S9lUTX1/Pnx/tXJuIqqRPh5g82mQt8vJn4Re61
 fTa3igdcrfM6zt1DwzAeJk0z94aj/X74feFHJmyv67tLOUlL7jw8cuk0cqAD8a4eyTKfnvE3g
 mmwjbhTpKbfMbHPA7+I8VDfwYCgLKoX3c8P8U+KBi7P03WQ04sF7N4wdsiw4PAp+DHEc5I01U
 Cd17wunqWIg==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 12 Apr 2019 11:42:31 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 12 Apr 2019 11:42:27 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] =?utf-8?q?Checking_the_=E2=80=9Cdisplay=E2=80=9D_of_last_?=
 =?utf-8?q?two_statements_in_code_blocks?=
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

SGVsbG8sCgpJIGhhdmUgdHJpZWQgYW5vdGhlciBzbWFsbCBTbVBMIHNjcmlwdCBvdXQuCgoKQGRp
c3BsYXlACmlkZW50aWZpZXIgd29yazsKc3RhdGVtZW50IHMxLCBzMjsKdHlwZSBUOwpAQAogVCB3
b3JrKC4uLikKIHsKIC4uLiB3aGVuIGFueQoqewogICAgLi4uIHdoZW4gYW55CiogICBzMQoqICAg
czIKKn0KIC4uLiB3aGVuIGFueQogfQoKCkkgaGF2ZSBvYnNlcnZlZCB0aGVuIHRoYXQgdGhlIGZv
bGxvd2luZyBkaWZmIGh1bmsgd2FzIGdlbmVyYXRlZC4KCgplbGZyaW5nQFNvbm5lOn4vUHJvamVr
dGUvTGludXgvbmV4dC1wYXRjaGVkPiBzcGF0Y2ggfi9Qcm9qZWt0ZS9Db2NjaW5lbGxlL2phbml0
b3Ivc2hvd19sYXN0X3R3b19zdGF0ZW1lbnRzX2luX2FfYmxvY2suY29jY2kgZHJpdmVycy9uZXQv
ZXRoZXJuZXQvdGkvbmV0Y3BfZXRoc3MuY3xsZXNzCuKApgpAQCAtMzAxNSwxMSArMjg1OSw2IEBA
IHN0YXRpYyBpbnQgaW5pdF9zbGF2ZShzdHJ1Y3QgZ2JlX3ByaXYgKmcKICAgICAgICB9CgogICAg
ICAgIGlmIChvZl9wcm9wZXJ0eV9yZWFkX3UzMihub2RlLCAibGluay1pbnRlcmZhY2UiLAotICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmc2xhdmUtPmxpbmtfaW50ZXJmYWNlKSkgewot
ICAgICAgICAgICAgICAgZGV2X3dhcm4oZ2JlX2Rldi0+ZGV2LAotICAgICAgICAgICAgICAgICAg
ICAgICAgIm1pc3NpbmcgbGluay1pbnRlcmZhY2UgdmFsdWUgZGVmYXVsdGluZyB0byAxRyBtYWMt
cGh5IGxpbmtcbiIpOwotICAgICAgICAgICAgICAgc2xhdmUtPmxpbmtfaW50ZXJmYWNlID0gU0dN
SUlfTElOS19NQUNfUEhZOwotICAgICAgIH0KCiAgICAgICAgc2xhdmUtPm5vZGUgPSBub2RlOwog
ICAgICAgIHNsYXZlLT5vcGVuID0gZmFsc2U7CuKApgoKCk5vdyBJIHdvbmRlciBhYm91dCB0aGUg
c3VnZ2VzdGVkIGNoYW5nZSBmb3IgdGhlIGlmIHN0YXRlbWVudCBoZXJlLgpTaG91bGQgYW55IG1v
cmUgc29mdHdhcmUgYWRqdXN0bWVudHMgYmUgY29uc2lkZXJlZCBzbyB0aGF0IGl0IHdpbGwgYmUg
YXZvaWRlZAp0byBkZWxldGUgb25seSBhIHF1ZXN0aW9uYWJsZSBwYXJ0IGZyb20gYSBmdW5jdGlv
biBjYWxsIHdpdGhpbiBhIGNvbmRpdGlvbiBjaGVjaz8KClJlZ2FyZHMsCk1hcmt1cwpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxp
c3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4v
bGlzdGluZm8vY29jY2kK
