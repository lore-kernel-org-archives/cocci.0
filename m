Return-Path: <SRS0=q5PQ=UV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010DAC43613
	for <cocci@archiver.kernel.org>; Sat, 22 Jun 2019 09:12:18 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30E4C2070B
	for <cocci@archiver.kernel.org>; Sat, 22 Jun 2019 09:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Tkc6tRpC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30E4C2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5M9C1RV005472;
	Sat, 22 Jun 2019 11:12:01 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 15D867779;
	Sat, 22 Jun 2019 11:12:01 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id ECA4F7770
 for <cocci@systeme.lip6.fr>; Sat, 22 Jun 2019 11:11:58 +0200 (CEST)
Received: from mout-xforward.web.de (mout-xforward.web.de [82.165.159.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5M9BuvR024248
 for <cocci@systeme.lip6.fr>; Sat, 22 Jun 2019 11:11:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1561194715;
 bh=7+5DUD8xwfsbje3td9h8VZVqMNBAC5JimDpEtvcn7gI=;
 h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
 b=Tkc6tRpCb7Ks7cCjzRIIRBxDib75qGeBnlBkpqI3ZFZLCDDwarFOjjaRJoF7ppI4J
 C7ImpUyK3fx1YCrGeupNhRWAhA4i+nXA8CNVxfvvPzeDrtyjAZOYwqyB/OxzKS2W1A
 PgD4jytIkTfuYn7XJ97znzTJpnrPnWLl1D56yc0g=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.127.8]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MTyEL-1i4dNC1H8r-00QmjB; Sat, 22
 Jun 2019 11:11:55 +0200
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <5e66ab8c-2232-ca87-b5bf-c93b3c1a1406@web.de>
Date: Sat, 22 Jun 2019 11:11:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:wx8hd3IFCP8xBsoScWPs/cNKViV+j4baGt43BiEiRjkTlobNrKx
 vQ7pCg84XKXhjDlZzRPwfd78TEXS9GY1m4rt/RRp0DtlXqYe9NVHLpzmDE8wAUZRx8jfHPi
 tJ4g+suyEIBVrVS4sVCgiEcCayqiD6xpshG2KoLZ4HCSXbRri4g2HkybsahdrcAc7F4e9/q
 rcUlVJO9N5P+T7r69IvvA==
X-UI-Out-Filterresults: junk:10;V03:K0:meddanRHH+I=:qHZDSzYKDKiiF6PDbZFZfnZC
 jFNiXJdUYyoqPjyaTFi+bf6BCJ5qBkSGbUr0E54V+fLA2LlzY3QzJ1SH1BqiLmREDATC+mqlU
 VazvhNtyAav5FtAWEvScO+3u39Y08uLxtngOR617VL5FVDapuqECcaiRYZsZ7Nul3dRwYs/Sb
 7eTWDqjX0GOehqGznhdh2YbkN7wgq6tPl9EM1LEKfBou7fEvKvffTbIUmaroQzelP4uzrKtue
 fNV5KLKgE9Tgl87B9c7Cufm+A7Usr5dEQazlyEFWxXMZkDoUcH02KWZDyaZJZZnmZtXcQQWpe
 5bsWEMq3II8ohuDIpFawreFiA/bJEx72E7aCLnJw0oxTNM513FwyiZKrtVIbLzAeT0VkCtIX/
 UozNgQxbp1AD6mg4TYJ5BJwpyIZOaHN3KjAv7wr7q6yEmlSB/KgTjkx3oNeR2Z0q3lK5sNch1
 sWBfEIfC/4INqgw340WbE0UOgPG8mjYbjsxR6L276DbGtDy+N/Q9oSHdTeTOrdDeSO+tJa6E5
 Vgkrns7Kyz2GzURVMhpo1+AAxUFL90Tc+dD0rZrYaAfwWjrC0RXMJDwj1Mzspx+2rF+c2ohnF
 ncFAEoTFfhIGl3aylq8r71l6sErVxk4vzno09GpoEIU7K25CLmoOSxztym/TBAt4Xws2Y3Rv3
 mvM0vYXiMUNfX91iLOaKj/JQrfmWN0eEdAo1K9tz5iaVKU+BiKJUObygh9I8O+4bqvSBT2xv3
 rVkckdAnl6/hin42bvM/t6FOYoW3RlgomKOkR3rUg06AXYJ/S0LwhQ7p+m92pRQbRYKmGK7mI
 C4PS/VBGu0DVGvQyjH+Cl5srkWZhXvV8ktOZKgjVCsmY1RkxIQnvqqc29CRMaHpNpQJ67ylCo
 MRv+UIfiU9ey4Zeu7PZPAqVnE41WPegAPZLqJ74FedEkF5NRF2rSJvIP434adCxv4XasqbG3+
 0agM9/Mmk8Odecr4ZBH2ZTo2kg1mjUtQmrqmaNNkwFWqNJbfLzjOjrp5r4V1JTLuhjvRC+cCN
 EHF3lSKoJjaJe+dOrIhG7PQ2JbqekxYXTLLcuCqsjNFNevs0zq7yjXS1iCo3Kc08/0ttIEcc+
 dZARt6PZQ9JcpOGiIO1Iq4+wlFVLuJgevgGIKkwG4n2EG7/Cw3AljCg==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 22 Jun 2019 11:12:01 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 22 Jun 2019 11:11:58 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Checking dependencies for current OCaml compiler version
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

SGVsbG8sCgpJIGhhdmUgdHJpZWQgb3V0IHRvIGJ1aWxkIHRoZSBjdXJyZW50IENvY2NpbmVsbGUg
c29mdHdhcmUgYWdhaW4gYmFzZWQgb24KdGhlIE9QQU0gc3dpdGNoIOKAnDQuMDguMOKAnS4KVW5m
b3J0dW5hdGVseSwgSSBzdHVtYmxlIG9uIHRoZSBmb2xsb3dpbmcgZXJyb3IgbWVzc2FnZS4KCgri
gKYKb2NhbWxmaW5kIG9jYW1sYyAtYyAgLW5vLWFsaWFzLWRlcHMgLUkgLiBzdGRjb21wYXRfX3Bl
cnZhc2l2ZXMubWwgLW8gc3RkY29tcGF0X19wZXJ2YXNpdmVzLmNtbwpGaWxlICJzdGRjb21wYXRf
X3BlcnZhc2l2ZXMubWwiLCBsaW5lIDEsIGNoYXJhY3RlcnMgOC0xODoKMSB8IGluY2x1ZGUgUGVy
dmFzaXZlcwogICAgICAgICAgICBeXl5eXl5eXl5eCkFsZXJ0IGRlcHJlY2F0ZWQ6IG1vZHVsZSBT
dGRsaWIuUGVydmFzaXZlcwpVc2UgU3RkbGliIGluc3RlYWQuCgpJZiB5b3UgbmVlZCB0byBzdGF5
IGNvbXBhdGlibGUgd2l0aCBPQ2FtbCA8IDQuMDcsIHlvdSBjYW4gdXNlIHRoZQpzdGRsaWItc2hp
bXMgbGlicmFyeTogaHR0cHM6Ly9naXRodWIuY29tL29jYW1sL3N0ZGxpYi1zaGltcwpGaWxlICJz
dGRjb21wYXRfX3BlcnZhc2l2ZXMubWwiLCBsaW5lIDE6CkVycm9yOiBUaGUgaW1wbGVtZW50YXRp
b24gc3RkY29tcGF0X19wZXJ2YXNpdmVzLm1sCiAgICAgICBkb2VzIG5vdCBtYXRjaCB0aGUgaW50
ZXJmYWNlIHN0ZGNvbXBhdF9fcGVydmFzaXZlcy5jbWk6CiAgICAgICBUaGUgdmFsdWUgYHByb3Rl
Y3QnIGlzIHJlcXVpcmVkIGJ1dCBub3QgcHJvdmlkZWQKICAgICAgIEZpbGUgInN0ZGNvbXBhdF9f
cGVydmFzaXZlc19zLm1saSIsIGxpbmUgNTUsIGNoYXJhY3RlcnMgMi02MDoKICAgICAgICAgRXhw
ZWN0ZWQgZGVjbGFyYXRpb24KbWFrZVsyXTogKioqIFtNYWtlZmlsZToxMzcwOiBzdGRjb21wYXRf
X3BlcnZhc2l2ZXMuY21vXSBGZWhsZXIgMgptYWtlWzJdOiBWZXJ6ZWljaG5pcyDigJ4vaG9tZS9l
bGZyaW5nL1Byb2pla3RlL0NvY2NpbmVsbGUvMjAxNjAyMDUvYnVuZGxlcy9zdGRjb21wYXQvc3Rk
Y29tcGF0LTjigJwgd2lyZCB2ZXJsYXNzZW4KbWFrZVsxXTogKioqIFtNYWtlZmlsZTozOiBhbGxd
IEZlaGxlciAyCuKApgoKCkhvdyB3aWxsIHRoZSBzb2Z0d2FyZSBzaXR1YXRpb24gYmUgaW1wcm92
ZWQgdGhlbj8KClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZy
Cmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
