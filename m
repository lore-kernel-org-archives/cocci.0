Return-Path: <SRS0=zMkO=7T=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0355EC433DF
	for <cocci@archiver.kernel.org>; Sat,  6 Jun 2020 07:30:51 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 461D220663
	for <cocci@archiver.kernel.org>; Sat,  6 Jun 2020 07:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="RGZAKkqO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 461D220663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0567UkoD013158;
	Sat, 6 Jun 2020 09:30:46 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A89125D47;
	Sat,  6 Jun 2020 09:30:46 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8624C3BAB
 for <cocci@systeme.lip6.fr>; Sat,  6 Jun 2020 09:30:45 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0567UiU5003115
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 6 Jun 2020 09:30:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1591428639;
 bh=l8w3MJRuKfT5a3/310Ltd3vufAdJhbojIeIwIevJwZI=;
 h=X-UI-Sender-Class:Cc:Subject:To:From:Date;
 b=RGZAKkqOGNeozTQh2gTA30oQjnqCIM7nJAoJLnz8dC3doHQHjV7snL59Tn4C0JXeZ
 tORHJjFUFs9UUKl8mCx8JTSdr7h9GA9wghTCf4TTtT9e/7jidxp3eHvsgTR1+VqY7W
 ZaAg6AMZZ5D/zimw+p5HJ0Hvx9oaC0QTkPVfwLLg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.40.239]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LvB2o-1iz1gK44Sg-010OPA; Sat, 06
 Jun 2020 09:30:39 +0200
To: Denis Efremov <efremov@linux.com>, Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <99ed463c-b7ba-0400-7cf7-5bcc1992baef@web.de>
Date: Sat, 6 Jun 2020 09:30:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:X/kkZ06rZlFudE0r7jf+z2dqyNagehQu4UReRu9kWQ93tX5M4/9
 4u6rRbi5VKMBa1w+pv3VJg0uk2VDfj4Tqpgt5ljTeKmqcwZOUp+oORk9Zb6zdkehxSq0TyN
 Q0vJIAc7CJEw6/bQRnOMP+YVLk26i9gTA0JHDy15gEWiw0CU+EkquC625Tt0k/NDsLZrhQv
 iqYKaTL93bHhweaTAbHWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8DXUGpkGegA=:rCnfwWiWh5Vd72NjfdR7m9
 R8wxZ1DAtuMVAhbYXMtXEJrsUZlAdnQUoFdnDgxFASl3Lub+FsmJsFMKqGUVvWcpjL06XaXKn
 +pbx65owYcCgGLWr5rJzuKpKcJ7rUs77FlRariSy+OYR01Uo+6Bt6ikDN+2YLL11MzQBGkCos
 q/33J1vnBs1GamfVESckUM3fSftKh8byPTJMiTAtlHHz1jUffNdRKbD8eowff8qSO7EVf27ll
 KhZBxMCMuCkZdRb7znJnEnoRhVN3QFY0Ku2mH5zPJhRNFnBYxXgba1mYVhIKRQaGteOuXsP2J
 Yj4RCBGHTJF2oG9HxQTiYeitIg7UhOoJLxMkSt3kctFK0jCUR4P6ysazNOHz91DveQcHDqXC/
 JULnsJLhEe6M1bGYmtbIw5ISIeCIaSKcl7uSJrBZjnSIZ5ZEwrU9YQkBMj2Z6d+BgnS1lbGsq
 ITGu385cPxWSVmGSHve9Diko6YEqxjX3i37bed6ZppBnnFtoN+31bKkDsAuPlKpYGxFI4R/9T
 Njr23kO8RzdodmIv4D5j6/+el/VvUN8g7FYRgsze8jj+nXfGKIdiv+/r7g95Ac+3WHl+5dMdx
 A0AKgj4WdCOamKjCrtm430DI+hl3fZVlLaU5xzixJLkO6dK7PzqCtQOdP2mnwcXwIbzXXk++8
 QgSGT+u6MZjW9zNbxRCEsBRo4xETCGbsc9Hxd7TgTXTJYartHdiWRPvNUJzmh0/jEkuvotn+N
 MPnWnbU7EXf1WQxPydyWBopTVe85j3toUCimV1/AaFpjOTlgeEEI5Idk4p57VjTbfUS7XjtCF
 XU2YZXL0e5oihQhHvEcuBTC2YKGxv2fgDv3YNyYvT+QX8aUbIjop7G676w2fzr8q9A3+k4JIX
 f7bISIvNDFiDNy7vXC8LzRydxDnqfYk6Fhd2s5AjtINpPW5hYxOO3IsqOCDHFYXshvdWavgLK
 sYbbbWLsmX2y0mix0UUYkWdvRZVwznlqk72OOsVtwDi0lVXRgvvs6X7UJW0xJPP5hc4ezlwYf
 QD4p/aG5fBKmc5XgVurx5JUnSI6Y3acg5ZD/XjgCOEyU9HKr0VPcD2Bkgr8LObN7Yg6ykgpnh
 QQxdfmqWvW0v0RDalNBG7TNE62WDc78fmefiuadc6JmZh3Y8B2ohFNVQ7wXA+ig+xVIAtnIqG
 mTEYLXptd7elkrn0lOb2pPQRxLVAutxmFaANkWDXO0A+zU7f3HA9kw/I3fd38SHfxtnk9BYVy
 dY1DJy8bRSRq8rO++
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 06 Jun 2020 09:30:47 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 06 Jun 2020 09:30:44 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH] coccinelle: api: add kvfree script
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

PiBDaGVjayB0aGF0IGFsbG9jIGFuZCBmcmVlIHR5cGVzIG9mIGZ1bmN0aW9ucyBtYXRjaCBlYWNo
IG90aGVyLgoKRnVydGhlciBzb2Z0d2FyZSBkZXZlbG9wbWVudCBjaGFsbGVuZ2VzIGFyZSBpbnRl
cmVzdGluZyBhbHNvIGZvciBzdWNoIGFuIHVzZSBjYXNlLgoKCj4gKy8vLyBDaGVjayB0aGF0IGt2
bWFsbG9jJ2VkIG1lbW9yeSBpcyBmcmVlZCBieSBrZnJlZSBmdW5jdGlvbnMsCj4gKy8vLyB2bWFs
bG9jJ2VkIGJ5IHZmcmVlIGZ1bmN0aW9ucyBhbmQga3ZtYWxsb2MnZWQgYnkga3ZmcmVlCj4gKy8v
LyBmdW5jdGlvbnMuCgoqIEhvdyBkbyB5b3UgdGhpbmsgYWJvdXQgdG8gb2ZmZXIgYSB3b3JkaW5n
IHN1Z2dlc3Rpb24gZm9yIHN1YmplY3RzIG9mCiAgZ2VuZXJhdGVkIHBhdGNoZXM/CgoqIFdpbGwg
dGhlIHByZXNlbnRlZCBjYXNlIGRpc3RpbmN0aW9uIHRyaWdnZXIgZnVydGhlciBpbXByb3ZlbWVu
dHMgZm9yCiAgdGhlIGRlc2lyZWQgbWF0Y2hpbmc/CgoqIFdvdWxkIHlvdSBsaWtlIHRvIGdlbmVy
YWxpc2UgdGhlIHNhZmUgaGFuZGxpbmcgb2YgYWxsb2NhdGlvbnMKICBhbmQgY29ycmVzcG9uZGlu
ZyByZWxlYXNlIG9mIHN5c3RlbSByZXNvdXJjZXM/CgoKPiArLy8gQ29uZmlkZW5jZTogSGlnaAoK
SSBzdWdnZXN0IHRvIHJlY29uc2lkZXIgdGhpcyBpbmZvcm1hdGlvbiBvbmNlIG1vcmUuCgoKPiAr
dmlydHVhbCBwYXRjaAo+ICt2aXJ0dWFsIHJlcG9ydAo+ICt2aXJ0dWFsIG9yZwo+ICt2aXJ0dWFs
IGNvbnRleHQKCit2aXJ0dWFsIHBhdGNoLCByZXBvcnQsIG9yZywgY29udGV4dAoKSXMgc3VjaCBh
IFNtUEwgY29kZSB2YXJpYW50IG1vcmUgc3VjY2luY3Q/CgoKPiArQGNob2ljZUAKCiogQ2FuIGl0
IGJlIHRoYXQgdGhpcyBTbVBMIHJ1bGUgaXMgbm90IHJlbGV2YW50IGZvciBhbGwgb3BlcmF0aW9u
IG1vZGVzPwoKKiBXaWxsIGFkZGl0aW9uYWwgZGVwZW5kZW5jaWVzIG1hdHRlcj8KCgo+ICsgICAg
RSA9IFwoa21hbGxvY0Brb2tcfGt6YWxsb2NAa29rXHxrcmVhbGxvY0Brb2tcfGtjYWxsb2NAa29r
XHxrbWFsbG9jX25vZGVAa29rXHxremFsbG9jX25vZGVAa29rXHxrbWFsbG9jX2FycmF5QGtva1x8
a21hbGxvY19hcnJheV9ub2RlQGtva1x8a2NhbGxvY19ub2RlQGtva1wpKC4uLikKCkkgd291bGQg
cHJlZmVyIGFuIG90aGVyIGNvZGluZyBzdHlsZSBoZXJlLgoKKiBJdGVtcyBmb3Igc3VjaCBTbVBM
IGRpc2p1bmN0aW9ucyBjYW4gYmUgc3BlY2lmaWVkIGFsc28gb24gbXVsdGlwbGUgbGluZXMuCgoq
IFRoZSBzZW1hbnRpYyBwYXRjaCBsYW5ndWFnZSBzdXBwb3J0cyBmdXJ0aGVyIG1lYW5zIHRvIGhh
bmRsZSBmdW5jdGlvbiBuYW1lIGxpc3RzCiAgaW4gbW9yZSBjb252ZW5pZW50IHdheXMuCiAgV291
bGQgeW91IGxpa2UgdG8gd29yayB3aXRoIGN1c3RvbWlzZWQgY29uc3RyYWludHM/CgoKPiArbXNn
ID0gIldBUk5JTkc6IGttYWxsb2MgaXMgdXNlZCB0byBhbGxvY2F0ZSB0aGlzIG1lbW9yeSBhdCBs
aW5lICVzIiAlIChrWzBdLmxpbmUpCj4gK2NvY2NpbGliLnJlcG9ydC5wcmludF9yZXBvcnQocFsw
XSwgbXNnKQoKKiBJIHByb3Bvc2Ugb25jZSBtb3JlIG9taXQgdGhlIGV4dHJhIHZhcmlhYmxlIOKA
nG1zZ+KAnSBhdCBzaW1pbGFyIHBsYWNlcy4KICBUaGUgZGVzaXJlZCBtZXNzYWdlIG9iamVjdCBj
YW4gYmUgZGlyZWN0bHkgcGFzc2VkIGFzIGEgZnVuY3Rpb24gcGFyYW1ldGVyLgoKKiBJIGZpbmQg
dGhlIGRpYWdub3N0aWMgdGV4dCBpbnN1ZmZpY2llbnQuCgoqIENhbiB0aGUgY29ycmVzcG9uZGlu
ZyBmdW5jdGlvbiBjYXRlZ29yeSBiZSBkeW5hbWljYWxseSBkZXRlcm1pbmVkPwoKCkFyZSB5b3Ug
bG9va2luZyBmb3Igb3Bwb3J0dW5pdGllcyB0byBhdm9pZCB1bndhbnRlZCBjb2RlIGR1cGxpY2F0
aW9uPwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0
cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
