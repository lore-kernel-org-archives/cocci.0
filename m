Return-Path: <SRS0=vsaO=SN=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F78C10F13
	for <cocci@archiver.kernel.org>; Thu, 11 Apr 2019 15:24:07 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A484A20449
	for <cocci@archiver.kernel.org>; Thu, 11 Apr 2019 15:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Vw0dXLqk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A484A20449
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3BFNmCD006627
          ; Thu, 11 Apr 2019 17:23:48 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 13E977730;
	Thu, 11 Apr 2019 17:23:48 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2B1557724
 for <cocci@systeme.lip6.fr>; Thu, 11 Apr 2019 17:23:46 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3BFNiWt002940
 for <cocci@systeme.lip6.fr>; Thu, 11 Apr 2019 17:23:44 +0200 (CEST)
X-pt: isis.lip6.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1554996224;
 bh=qId9/BR2LLP/ZuC+O+9kOGY7o4vWjINtkUQpgLn5+Vo=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=Vw0dXLqkN9Rd9LqW48v2X01Mw9KdVS/NLblbM5NVpNzrexG4aIIf4Yv3ywnnH1Qf5
 Lt/t2D3+2rcsa6KLUOHDXqhNvzK2F1KnvboJ5hpw8ig3b5CAYZZIw1mrQUVNSyLf1t
 WiCeBve+EEIbgwgGwR56n1HK/ezSoaCyKyJSWcgY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.114.70]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M7bQ3-1gzX310w7z-00xNPd for
 <cocci@systeme.lip6.fr>; Thu, 11 Apr 2019 17:23:44 +0200
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <ce2b0c4c-bc85-0341-ca0a-9b158804943a@web.de>
Date: Thu, 11 Apr 2019 17:23:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:hM4aXYgHXKyAw5+yoelo9nN+TSo/R87P/XMAqIHY1pk9t7AeyZJ
 4MJnpyyxKBRkRMMNRRnsrOlzTCAI83TQqCUUEWOnn6txFcAEiCCfyF7breEIeevURQh/Ezs
 gO6cLmMWbU9IOLP2Z+1hhCpk/R0ibgMuKpCPMTsPTL3fH+E5xHHNNc6KvdWG7LMgJ2RnVxg
 BsG01bLevbvTa4ms4Ic8A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:inlFgNC0vLE=:0CaiEzd3O16BlazmbFXHlq
 qpFdF9LhD9ZnuW31S3HixHmRVIrOu9RhQ6QUhS3iDA39Apd5Iq6oy+qFZFNoMgtfT2TSYWlNi
 kVa9D3LL7uqoV4kIw7A5vge51xfsqvQkWNNXy95/Wp/2Qcn6JKF0HCh2bdWvlI8byKRA64ODQ
 YUIYwLvw3WdD+DDmcvi5Tf4wvfVecaSQLIoxOWwm44+oUDqokgZ9e5+hsJnYjuMT2j4uj5n/a
 4trH9DfBpt7stSgrY57yTPhRt6QnOdgXJx3yWae8pL/NBCws8iMD8BFaa9Lq1r2DBsRXiyUvO
 f9d1R6onCRAToM9MqQmcedpwBZ33Mad9dnpTQGR6giNk67kJWxVvsOgMX1HhD6jlrwjS1/QQC
 luRBUjTPfk+Pc0R7lGfZqyuACBNKAPNfuTpLooFrG2G1cFL781vXbwJ9mJHTr+gsvhwt+n+nN
 JLanFgddTfwogQKNtbQeGF6KyG8Wd8Y9RpCGqQa4270JzS6Oy7aKRW4bjUXVP2Z6+fjN90bGd
 ncmN5ehKIK/qa+jF5gt/9vpf1BVkIHKg/mLnG9uKWEU6ca4yRLCoGY3v3ZuYY1lyr9TmdXKxg
 EIp8HjfEJQQlOCfOwJDeFbRLqf1mvAe/ZAO38L/tEZ+FuxvWIMDdKZYkU5S5Bkktnw8JSejA2
 KGgsbT/v+P9dwx6myjjMicyB7OOXWvmysJaT/mN0cMgruMHnDHiJt1tPn+we7zXhN5HZcnecY
 5Ycl9PlEte/bk/9Pl0RXjLAxBOkUjhVpdzsL8dw4cm9JxZ8Vk2lrFwDHYmrqV8LXRtHqibl3S
 NUOz4g/2FMoQwo34scwf1Tkel4gxzWOhVDdnyaPd7ALlFVSYNIggmHqrPyinNS67GdpagGqTe
 2ls13hs0Xw5BqCDwmVASQOKLdlnrv2+rmQ96rO/BhKEVAZ1m0arWgcoNvC4niMZrqZ5YweF9m
 Ng3da59QsIw==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 11 Apr 2019 17:23:48 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 11 Apr 2019 17:23:44 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Searching for duplicate statements in if branches (with
	SmPL)?
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

SGVsbG8sCgpJIGhhdmUgY29uc3RydWN0ZWQgdGhlIGZvbGxvd2luZyBzbWFsbCBTbVBMIHNjcmlw
dC4KCgpAZHVwbGljYXRlZF9jb2RlQAppZGVudGlmaWVyIHdvcms7CnN0YXRlbWVudCBzMSwgczI7
CnR5cGUgVDsKQEAKIFQgd29yayguLi4pCiB7CiAuLi4gd2hlbiBhbnkKKmlmICguLi4pCip7CiAg
ICAuLi4gd2hlbiBhbnkKKiAgIHMxCiogICBzMgoqfQogLi4uIHdoZW4gYW55CippZiAoLi4uKQoq
ewogICAgLi4uIHdoZW4gYW55CiogICBzMQoqICAgczIKKn0KIC4uLiB3aGVuIGFueQogfQoKClRl
c3QgcmVzdWx0OgpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dp
dC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9kcml2ZXJzL25ldC9ldGhlcm5ldC90aS9uZXRjcF9l
dGhzcy5jP2lkPTc1ZWFjN2I1ZjY4YjBhMDY3MWU3OTVhYzYzNjQ1N2VlMjdjYzExZDgjbjM1NjIK
aHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjUuMS1yYzQvc291cmNlL2RyaXZlcnMv
bmV0L2V0aGVybmV0L3RpL25ldGNwX2V0aHNzLmMjTDM1NjIKCkBAIC0xODI5LDExICsxODI5LDcg
QEAgc3RhdGljIHZvaWQgZ2JlX3Jlc2V0X21vZF9zdGF0cyhzdHJ1Y3QgZwogCWludCBpOwoKIAlm
b3IgKGkgPSAwOyBpIDwgZ2JlX2Rldi0+bnVtX2V0X3N0YXRzOyBpKyspIHsKLQkJaWYgKGdiZV9k
ZXYtPmV0X3N0YXRzW2ldLnR5cGUgPT0gc3RhdHNfbW9kKSB7CiAJCQlwX3N0YXRzX2VudHJ5ID0g
YmFzZSArIGdiZV9kZXYtPmV0X3N0YXRzW2ldLm9mZnNldDsKLQkJCWdiZV9kZXYtPmh3X3N0YXRz
W2ldID0gMDsKLQkJCWdiZV9kZXYtPmh3X3N0YXRzX3ByZXZbaV0gPSByZWFkbChwX3N0YXRzX2Vu
dHJ5KTsKLQkJfQogCX0KIH0KCkBAIC0yODA4LDEwICsyODA0LDYgQEAgc3RhdGljIGludCBnYmVf
c2V0X3J4X21vZGUodm9pZCAqaW50Zl9wcgogCWNwc3dfYWxlX2NvbnRyb2xfc2V0KGFsZSwgMCwg
QUxFX0FHRU9VVCwgMSk7CiAJZG8gewogCQljcHVfcmVsYXgoKTsKLQkJaWYgKGNwc3dfYWxlX2Nv
bnRyb2xfZ2V0KGFsZSwgMCwgQUxFX0FHRU9VVCkpIHsKLQkJCXJldCA9IDA7Ci0JCQlicmVhazsK
LQkJfQoKIAl9IHdoaWxlICh0aW1lX2FmdGVyKHRpbWVvdXQsIGppZmZpZXMpKTsKCuKApgpAQCAt
MzY1NywzMSArMzYzNiwxNCBAQCBzdGF0aWMgaW50IGdiZV9wcm9iZShzdHJ1Y3QgbmV0Y3BfZGV2
aWNlCgogCXJldCA9IG5ldGNwX3R4cGlwZV9pbml0KCZnYmVfZGV2LT50eF9waXBlLCBuZXRjcF9k
ZXZpY2UsCiAJCQkJZ2JlX2Rldi0+ZG1hX2NoYW5fbmFtZSwgZ2JlX2Rldi0+dHhfcXVldWVfaWQp
OwotCWlmIChyZXQpIHsKLQkJb2Zfbm9kZV9wdXQoaW50ZXJmYWNlcyk7Ci0JCXJldHVybiByZXQ7
Ci0JfQoKIAlyZXQgPSBuZXRjcF90eHBpcGVfb3BlbigmZ2JlX2Rldi0+dHhfcGlwZSk7Ci0JaWYg
KHJldCkgewotCQlvZl9ub2RlX3B1dChpbnRlcmZhY2VzKTsKLQkJcmV0dXJuIHJldDsKLQl9Cgog
CS8qIENyZWF0ZSBuZXR3b3JrIGludGVyZmFjZXMgKi8KIAlJTklUX0xJU1RfSEVBRCgmZ2JlX2Rl
di0+Z2JlX2ludGZfaGVhZCk7CiAJZm9yX2VhY2hfY2hpbGRfb2Zfbm9kZShpbnRlcmZhY2VzLCBp
bnRlcmZhY2UpIHsKIAkJcmV0ID0gb2ZfcHJvcGVydHlfcmVhZF91MzIoaW50ZXJmYWNlLCAic2xh
dmUtcG9ydCIsICZzbGF2ZV9udW0pOwotCQlpZiAocmV0KSB7Ci0JCQlkZXZfZXJyKGRldiwgIm1p
c3Npbmcgc2xhdmUtcG9ydCBwYXJhbWV0ZXIsIHNraXBwaW5nIGludGVyZmFjZSBjb25maWd1cmF0
aW9uIGZvciAlcE9GblxuIiwKLQkJCQlpbnRlcmZhY2UpOwotCQkJY29udGludWU7Ci0JCX0KIAkJ
Z2JlX2Rldi0+bnVtX3NsYXZlcysrOwotCQlpZiAoZ2JlX2Rldi0+bnVtX3NsYXZlcyA+PSBnYmVf
ZGV2LT5tYXhfbnVtX3NsYXZlcykgewotCQkJb2Zfbm9kZV9wdXQoaW50ZXJmYWNlKTsKLQkJCWJy
ZWFrOwotCQl9CiAJfQogCW9mX25vZGVfcHV0KGludGVyZmFjZXMpOwoKCgpOb3cgSSB3b25kZXIg
YWdhaW4gd2h5IHRoZSBmaXJzdCB0d28gZGlmZiBodW5rcyBhcmUgcHJlc2VudGVkIGJ5IHRoaXMK
c291cmNlIGNvZGUgc2VhcmNoIGFwcHJvYWNoLiBJdCBzZWVtcyB0aGF0IHRoZSBoaXRzIGZvciB0
aGUgZnVuY3Rpb25zCuKAnGdiZV9yZXNldF9tb2Rfc3RhdHPigJ0gYW5kIOKAnGdiZV9zZXRfcnhf
bW9kZeKAnSBhcmUgZmFsc2UgcG9zaXRpdmVzCihiZWNhdXNlIG9ubHkgb25lIGlmIHN0YXRlbWVu
dCBpcyBtYXJrZWQgdGhlcmUpLgoKVGhlIGxhc3QgZGlmZiBodW5rIHBvaW50cyBhbiBpbXBsZW1l
bnRhdGlvbiBkZXRhaWwgb3V0IHdoaWNoIGlzIGRpc2N1c3NlZApmb3IgdGhlIHVwZGF0ZSBzdWdn
ZXN0aW9uIOKAnGV0aGVybmV0OiB0aTogZWxpbWluYXRlIGEgYml0IG9mIGR1cGxpY2F0ZSBjb2Rl
CmluIGdiZV9wcm9iZSgp4oCdLgpodHRwczovL2xrbWwub3JnL2xrbWwvMjAxOS80LzkvOTc5Cmh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL3BhdGNod29yay9wYXRjaC8xMDU5ODg4LwpodHRwczovL2xv
cmUua2VybmVsLm9yZy9sa21sLzE1NTQ4NjQ5MzUtODI5OS0xLWdpdC1zZW5kLWVtYWlsLXdlbi55
YW5nOTlAenRlLmNvbS5jbi8KCkJ1dCBpdCBzaG93cyBhbHNvIHNvdXJjZSBjb2RlIHBsYWNlcyB3
aGVyZSB0aGUgU21QTCBzcGVjaWZpY2F0aW9uIGlzCnRvbyBnZW5lcmljIHNvIGZhci4KCgpBbm90
aGVyIFNtUEwgc2NyaXB0IHZhcmlhbnQgcHJlc2VudHMgYWxzbyBhIHJlc3VsdCBmb3IgYWRkaXRp
b25hbCBjb25zaWRlcmF0aW9ucy4KCgpAZHVwbGljYXRlZF9jb2RlQAppZGVudGlmaWVyIHdvcms7
CnN0YXRlbWVudCBzMSwgczIsIGVzOwp0eXBlIFQ7CkBACiBUIHdvcmsoLi4uKQogewogLi4uIHdo
ZW4gYW55CippZiAoLi4uKQoqewogICAgLi4uIHdoZW4gYW55CiogICBzMQoqICAgczIKKn0KIGVs
c2UKIGVzCiAuLi4gd2hlbiBhbnkKKmlmICguLi4pCip7CiAgICAuLi4gd2hlbiBhbnkKKiAgIHMx
CiogICBzMgoqfQogZWxzZQogZXMKIC4uLiB3aGVuIGFueQogfQoKCkBAIC0zMjA1LDE0ICszMjA1
LDggQEAgc3RhdGljIHZvaWQgaW5pdF9zZWNvbmRhcnlfcG9ydHMoc3RydWN0CiAJCQkJICAgICAg
IHNsYXZlLT5waHlfbm9kZSwKIAkJCQkgICAgICAgZ2JlX2FkanVzdF9saW5rX3NlY19zbGF2ZXMs
CiAJCQkJICAgICAgIDAsIHBoeV9tb2RlKTsKLQkJaWYgKCFzbGF2ZS0+cGh5KSB7CiAJCQlkZXZf
ZXJyKGRldiwgInBoeSBub3QgZm91bmQgZm9yIHNsYXZlICVkXG4iLAogCQkJCXNsYXZlLT5zbGF2
ZV9udW0pOwotCQl9IGVsc2UgewotCQkJZGV2X2RiZyhkZXYsICJwaHkgZm91bmQ6IGlkIGlzOiAw
eCVzXG4iLAotCQkJCXBoeWRldl9uYW1lKHNsYXZlLT5waHkpKTsKLQkJCXBoeV9zdGFydChzbGF2
ZS0+cGh5KTsKLQkJfQogCX0KIH0KCgpJIGFtIGN1cmlvdXMgaWYgYmV0dGVyIHNvbHV0aW9ucyBj
YW4gYmUgZm91bmQgZm9yIHN1Y2ggc29mdHdhcmUuCgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0
CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xp
c3RpbmZvL2NvY2NpCg==
