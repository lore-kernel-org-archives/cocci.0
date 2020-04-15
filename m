Return-Path: <SRS0=DmmV=57=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DD8C2BA19
	for <cocci@archiver.kernel.org>; Wed, 15 Apr 2020 15:22:16 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09C262076A
	for <cocci@archiver.kernel.org>; Wed, 15 Apr 2020 15:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="BRvCqWZq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09C262076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03FFLuk0015756;
	Wed, 15 Apr 2020 17:21:56 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A795E7755;
	Wed, 15 Apr 2020 17:21:56 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4EB513DC8
 for <cocci@systeme.lip6.fr>; Wed, 15 Apr 2020 17:21:55 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03FFLsZ2025700
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Wed, 15 Apr 2020 17:21:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1586964113;
 bh=3qGwHl4kbapWbqYJOyV65IazTJvZHxGWdx0DwpQXRwI=;
 h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
 b=BRvCqWZq/nIhKB6fILB68joqeYF2F/mBX/rTwA3i4fqXvpjduF/TP+81NCBbXSjSr
 0EPL5avLWvh8T0vlkGoRa58HJz4Ifw4GvX050Kftx8u3aNv/1RpuX7nV0FsQ+2ayEk
 YZ7ID5RjhGAEvzp3IxcRdL55bzr4bvvBXrLKc9zY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.48.133.192]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M7sw0-1j2xmL157I-00vOuF; Wed, 15
 Apr 2020 17:21:53 +0200
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <25b804fd-0d04-475d-f614-26c03c9fd544@web.de>
Date: Wed, 15 Apr 2020 17:21:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:hmJate4wlcahR3dO07R8eSgeTt77z3AVLetUFh+ivTICWaBIzHn
 4Y2/s8J7/DGbHEX3HAamT8Q53p6sx2DKiakugyuJWrDBl6yEC2mNzLG2Zd16x1ag+0IUklF
 LNuBuye12lb6smCOcqoDTRM8Gn5UC4/CKD4l6Wo0pg6rpz5tLCsrQJSuxQoie1xp1KbPnID
 Bu8fDNABZA4wssg7CjTDg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8NdG4r4Ixnc=:VVzxVu7xUsSVgEy0E0VAI2
 btyyIrnj1OXSSI4OyCBd7C38OvwSlNihQkfOfy7PhUoauAdV12I/Kh4vfKXhwmt0UrqR5ESn2
 RlNjIsrxl+Zc2Tam9PILHRUbKZg9m+LRtdz+uQxHcUD+ah7MsItWadN3Hb7QUrzbnQh+oT2Ng
 M0QLNNAc9hrC7+YYYQJbfrdGnymSC8yKi/msuPv16HuhdzU6upwYsNpYN5mCEBevKFvEFsgUm
 udy+qiKSR8us8L76VrQKs+nJ1B2hameroZiky0wNLO4T696i4Yr6qhX/JXrfD5HcQRyHMjADJ
 PmWHE+mo441h+BEFuPb9oQAhnjHAh4MWaZfkC+WtYXBCywzbO/vTJztdnLKtB+Ga8pHhoS6Z7
 0JdjCm3dK2w/9IpnBZVcnIJAw6dkVJ1jnjeft/Cx0qMHlp+pfNOOQRwxWVj96cM3LLh/0MYa3
 fsB36UjRQmjwdj9y7BKd9geWkFtiSPvsYTPWI53LdejeW+6as62A3spBYJpMNJ2AAmaH6g2RH
 TNqx3Y4Hwwzzc/oRYnRcBFRS8voDf3NtViLxy9z/yFcetYBcD0Fo0aEhbAFi8UvmjAX6oK5aF
 BkqKa4dfYupEYzR0G6ATgtL97Sx5sqtUe2nVhIkw6CooDs4R5B2VYzf6oVf2C4u0Zotn18H+7
 HGlL3sLrR2w5nDFjP00jeBfZVva0fSHvG9oZ4dxW3oFdQoq1WpguBpJ9FBPwbZBhufjMNnUnx
 +PRPH7QVFRgxZCaWDOhLS2iK22fnE1tGFBlU6rB0nRN9xXqhJRkBZ1/UiphncMK30IZnleFrr
 f57exTJ1jL8QgHM9kx1z62aH7V5mteC7Bdi0HriKzggMEICRsfRdwO5BWsknYz+tJyzqSQyKb
 f09xewwX3UF2nYeDRXl5leO0o4+dBevdE4ZLW7jn5LBjzAHmYBijgOYhbQYGUWUNpfxIBZELi
 QEEZtvsFowbXdVutxj4HO+j95//TVnRsWFfWVDgeK98vS5Cd8ay1q+yB4/vmwrv9BA+aTG+r7
 bU9m5S+iBVy7AGTrKxArjaSz+SH2CsJPL8H+ZhKDa+Q4iP6itxOOc7zKeLrzz5Kldh8AGI9Bd
 dx8nvs+yRXDrs1qp75iZ3IDWDLowhEAMa4YOS7SbaDy+tGEW8WVhtU512k+9nPPjmSOilqChO
 3eMt5F9m8s7sXJ9Tl//bO300lXLHwPAQwVUtZD6k1FWOFbKVCg9elpB1ozwd7SWBwIBEoDGTb
 5KVFWGDorxdQaoUVK
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 15 Apr 2020 17:21:57 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 15 Apr 2020 17:21:54 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Dejin Zheng <zhengdejin5@gmail.com>
Subject: [Cocci] Checking the replacement of two specific function calls
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

SGVsbG8sCgpJIG5vdGljZWQgdGhlIHN1Z2dlc3Rpb24g4oCcaTJjOiBidXNzZXM6IGNvbnZlcnQg
dG8gZGV2bV9wbGF0Zm9ybV9nZXRfYW5kX2lvcmVtYXBfcmVzb3VyY2XigJ0uCmh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2xpbnV4LWkyYy8yMDIwMDQxNDEzNDgyNy4xODY3NC0xLXpoZW5nZGVqaW41
QGdtYWlsLmNvbS8KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcGF0Y2h3b3JrL3BhdGNoLzEyMjM3
MzQvCgpJIGdvdCBpbnRvIHRoZSBtb29kIHRvIHRyeSBhbm90aGVyIHNjcmlwdCBvdXQgZm9yIHRo
ZSBzZW1hbnRpYyBwYXRjaCBsYW5ndWFnZS4KCgpAcmVwbGFjZW1lbnRACmV4cHJlc3Npb24qIGJh
c2UsIGRldmljZSwgcmVzb3VyY2U7CkBACi1yZXNvdXJjZSA9IHBsYXRmb3JtX2dldF9yZXNvdXJj
ZShkZXZpY2UsIElPUkVTT1VSQ0VfTUVNLCAwKTsKIGJhc2UgPQotICAgICAgIGRldm1faW9yZW1h
cF9yZXNvdXJjZSgmZGV2aWNlLT5kZXYsIHJlc291cmNlKQorICAgICAgIGRldm1fcGxhdGZvcm1f
Z2V0X2FuZF9pb3JlbWFwX3Jlc291cmNlKGRldmljZSwgMCwgJnJlc291cmNlKQogOwoKClNvdXJj
ZSBmaWxlIGV4YW1wbGU6Cmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJu
ZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL2RyaXZlcnMvaTJjL2J1c3Nlcy9pMmMtcmNh
ci5jP2lkPTg2MzJlOWI1NjQ1YmJjMjMzMWQyMWQ4OTJiMGQ2OTYxYzFhMDg0MjkjbjkyMQpodHRw
czovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92NS43LXJjMS9zb3VyY2UvZHJpdmVycy9pMmMv
YnVzc2VzL2kyYy1yY2FyLmMjTDkyMQoKLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0y
LjAKLy8gZGVsZXRlZCBwYXJ0CnN0YXRpYyBpbnQgcmNhcl9pMmNfcHJvYmUoc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqcGRldikKewoJc3RydWN0IHJjYXJfaTJjX3ByaXYgKnByaXY7CglzdHJ1Y3Qg
aTJjX2FkYXB0ZXIgKmFkYXA7CglzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2OwovLyBk
ZWxldGVkIHBhcnQKCXByaXYtPnJlcyA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZShwZGV2LCBJT1JF
U09VUkNFX01FTSwgMCk7CgoJcHJpdi0+aW8gPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoZGV2LCBw
cml2LT5yZXMpOwoJaWYgKElTX0VSUihwcml2LT5pbykpCgkJcmV0dXJuIFBUUl9FUlIocHJpdi0+
aW8pOwovLyBkZWxldGVkIHBhcnQKfQovLyBkZWxldGVkIHBhcnQKCgpOb3cgSSB3b25kZXIgd2h5
IHRoZSBleHBlY3RlZCBwYXRjaCBpcyBub3QgZ2VuZXJhdGVkIGJ5IHRoZSBzb2Z0d2FyZQrigJxD
b2NjaW5lbGxlIDEuMC44LTAwMDI5LWdhNTQ5YjlmMOKAnSBhdCB0aGUgbW9tZW50LgpIb3cgc2hv
dWxkIHRoaXMgc2l0dWF0aW9uIGJlIGltcHJvdmVkPwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlz
dApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9s
aXN0aW5mby9jb2NjaQo=
