Return-Path: <SRS0=Nj+g=JC=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34976C433ED
	for <cocci@archiver.kernel.org>; Mon,  5 Apr 2021 08:55:33 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AAB5610E8
	for <cocci@archiver.kernel.org>; Mon,  5 Apr 2021 08:55:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AAB5610E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 1358tTYh012376;
	Mon, 5 Apr 2021 10:55:29 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 9BB663CA1;
	Mon,  5 Apr 2021 10:55:29 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id AD74F74DE
 for <cocci@systeme.lip6.fr>; Sun,  4 Apr 2021 14:11:56 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 134CBtjx002220
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Sun, 4 Apr 2021 14:11:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1617538315;
 bh=RipVGrlrTXlKa+J0zhZ7gE3jX6NXxI96R5xUybJxmfU=;
 h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
 b=gUkHBe7RvXgBH3loQonpquqhbNNLwNoeHwPiiXh/gat7WHMxAcmnloWwx8TwfdVW2
 xci79LpIVsX+v/K7kV/Bxn9MOWVIN5WsDXHyU0HZUc1FIIVzvlNEH5n+MCZnDDRnw+
 2E19ju0nQMIY52OqRHwxX4Lfxd/x0HsZc2mpwd5s=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.41.246]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M3xKs-1ll6kq3dHW-00rXzP; Sun, 04
 Apr 2021 14:11:54 +0200
To: Julia Lawall <julia.lawall@inria.fr>
References: <0756b630-a2d7-f300-3b11-59af33b48631@web.de>
 <alpine.DEB.2.22.394.2103281128560.2854@hadrien>
 <1b5f6d22-5b89-097f-37bd-13b3b2ab011a@web.de>
 <alpine.DEB.2.22.394.2103281244200.2854@hadrien>
 <173fa182-4127-aaba-262e-e3953a81a1e2@web.de>
 <alpine.DEB.2.22.394.2103281343310.2854@hadrien>
 <f720b262-708f-a603-3470-b374db625578@web.de>
 <alpine.DEB.2.22.394.2103281644480.2854@hadrien>
 <fa66fce2-e60e-1907-7c8b-fd9ceedb8086@web.de>
 <alpine.DEB.2.22.394.2104041357060.2958@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <addb2edb-98cb-2834-b1b9-7d44cacda965@web.de>
Date: Sun, 4 Apr 2021 14:11:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2104041357060.2958@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:Ln8TJmFQOZEzPoKLrjTB9vhkUUzpfFKzNrhITKcO+FEea+ZeyXQ
 dZlfa2qhQw6GRNAQ/31dt7B8+ldkOJr4uc1JoybcVVDcSNA4XPL0vrhoIa9K+PXd74hszBe
 IG/XZIZ11RA1nIPIco7QBO1h7SEfSBqQrLK4O7gvNICv4SgachBDphlmJMZtY82LSo7AVyM
 xFV3KDmV4oKH31C8oW4ZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PETq62lqACU=:OGOr0UhX3b4Htdqtd7Ph1p
 xcr6qTHRoup7VxA9PtaLy0BdW54OP4yOnmujvM/gZSrxHN9NvwJ8krXHdfCoR/OS1pDHBEupQ
 etmTxyoZv79lI0xG09lra9JZZdzftKSJz4oOtuPI/+Pb1oVgtIZEsSrPUBcwPnpbGfoePQndl
 woikOqu6O9UYsZ53o7RxIxG4mEymYKiTCTyxDoBu1uzGE85Qiamm66cKUGo+gVpQH3A9/qwvn
 nX7oZRt9A4UrFnWwAORZo5eziP1nEvBmfQImc8eNf19dtouBhO9PWCMXggXYEW47/4Wm1fqOh
 SovjYh+Jl20ELJC1QU1QdkxziZuPQhK929XYalzVGEa1jpoHNkSlSOH4iJf2o0Ellmmuu2S4N
 SpVZoqvgKd6HOs9Bt+LwPbiCXK+obOQhKHErKzN6OcNyRv+vy/pGwELv5TaJJVvx8oxqFCPf+
 /LPYG2aAIlHI/1Ar2tuz1hrSt4pBsdtZFKYXlZF262eOskcJcwj4/u3zYqL6dL+I1A6C4v3GR
 Hs0pEc+LbXg1G42e6xfgt/BNu2EmChRR5tSjGpOWOLuCjyu3wuTAiwnltLcy8WOWduXIZT7MT
 wr1vF/BCwvuNalX7VzXppEsTFQ8D+WvwwyTGZ+X6MOZN9i6pNSztIrkVX6+jarU0Og/a93c1f
 hKLXy/CjenOJWE6fUkpThsn1pJbC+C3d/pzwLbqyQvSZqurWfgEFtyoo1l8I4ki3GKTCJepjw
 A4Gy9HVd0A+Q9Y4zw8tzWoGd7n7gYdal2/ShncdmOHqh14at7s55UgIuMqb0hpHn0Eh/Yr1bk
 2fZNA14m1ARQB+YIXzND5dP0Iv1DRW4eZntc+h+MfeaS3qvPvj45/1n+LZSlxXC0V+ZXNQ4LK
 yFGgO0SPh83Yj7XhKFK50KmAn5gGogcFryaKFyhMviOghFMtyz1NL+8CCvNx5XDKJdGzO6c0+
 tMp2HJ5jKwJkABq5kJSvpsc6rE7mw7uCEqap1QMcOBr7GL1uJo76g26fsi48niGP1MU+z6rqX
 N5Co9EOQ0hXwWf7tBFDQ6FcmDmbSmcj7yDeqC/GzzQ8W6t6gz8oWNYXbzA3bwQPce0KG6AEE/
 ZuLzZ8uL86yd/V1VRE3D6qgK8KDZWHPQ55oyslOhb+DIQb0FkDMrWTbvtljrplHU9jOqOmBcV
 gbqpgcu7oGeCiGG/vCSCh2/AErsZI+e00L7K7SWnZmMDyjfQVZGo96eGsqL0fUMlywuVqit8z
 wja03RFSaQTM0QhW8
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 05 Apr 2021 10:55:29 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 04 Apr 2021 14:11:56 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Mon, 05 Apr 2021 10:55:28 +0200
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Excluding quotes from strings of #define directives
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

Pj4gSSBob3BlZCB0aGF0IHRoZSBzcGVjaWZpZWQgY29uc3RyYWludCBmb3IgdGhlIG1ldGF2YXJp
YWJsZSDigJxl4oCdIHdvdWxkIG1lYW4KPj4gdGhhdCBleHByZXNzaW9ucyB3aGljaCBjb250YWlu
IGEgZG91YmxlIHF1b3RhdGlvbiBjaGFyYWN0ZXIgc2hvdWxkIGJlIGV4Y2x1ZGVkCj4+IGZvciBt
eSBzb3VyY2UgY29kZSBhbmFseXNpcyBhcHByb2FjaC4KPj4gV291bGQgeW91IGxpa2UgdG8gY2hl
Y2sgdGhlIG9ic2VydmVkIHNvZnR3YXJlIGZ1bmN0aW9uYWxpdHkgb25jZSBtb3JlPwo+Cj4gVGhl
cmUgaXMgcGVyaGFwcyBhIHByb2JsZW0sIGJ1dCBpdCBpcyBzdXJlbHkgbm90IG5lY2Vzc2FyeSB0
byBoYXZlIGFsbCBvZgo+IHRoaXMgcHl0aG9uIGNvZGUgYXJvdW5kIGl0IHRvIHNlZSB0aGUgcHJv
YmxlbS4KCkkgY2hvc2UgdGhpcyB0ZXN0IGRpc3BsYXkgc28gdGhhdCBpdCBjYW4gYmUgY2xlYXJs
eSBzZWVuIHdoaWNoIGRhdGEgd2VyZSBwcm9jZXNzZXMKZm9yIHRoZSBtZXRhdmFyaWFibGUg4oCc
ZeKAnS4KCgo+IFBsZWFzZSBtYWtlIGEgbWluaW1hbCBleGFtcGxlLiAgQSBydWxlIHdpdGggYSBt
YXRjaCBhbmQgYSAqIGluIGZyb250IG9mIGl0IHNob3VsZCBiZSBzdWZmaWNpZW50LgoKRG8geW91
IGZpbmQgY29uc3RyYWludHMgb2YgdGhlIGZvbGxvd2luZyBTbVBMIHNjcmlwdCB2YXJpYW50IGVh
c2llciB0byBjbGFyaWZ5PwoKQGRpc3BsYXlACmlkZW50aWZpZXIgaSA9fiAiXig/OltBLVpdK18p
ezMsM31bQS1aXSsiOwpleHByZXNzaW9uIGUgIX4gIlwiIjsKQEAKKiNkZWZpbmUgaSBlCgpUZXN0
IHJlc3VsdDoKaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL3BpcGV3aXJlL3BpcGV3aXJl
Ly0vYmxvYi85N2IwMWVkOWIwMWJhYzdjYmE2OGZmMTFjNmJmN2NlYWJjYWU3ZjUyL3NwYS9pbmNs
dWRlL3NwYS9ub2RlL3R5cGUtaW5mby5oI0wzOAoKZWxmcmluZ0BTb25uZTp+L1Byb2pla3RlL1Bp
cGVXaXJlL2xva2FsPiBzcGF0Y2ggfi9Qcm9qZWt0ZS9Db2NjaW5lbGxlL2phbml0b3Ivc2hvd19k
ZWZpbmVfdXNhZ2U0LmNvY2NpIHNwYS9pbmNsdWRlL3NwYS9ub2RlL3R5cGUtaW5mby5oCuKApgpA
QCAtMzUsOCArMzUsNiBAQCBleHRlcm4gIkMiIHsKICNpbmNsdWRlIDxzcGEvbm9kZS9ldmVudC5o
PgogI2luY2x1ZGUgPHNwYS9ub2RlL2lvLmg+CgotI2RlZmluZSBTUEFfVFlQRV9JTkZPX0lPICAg
ICAgICAgICAgICAgICAgICAgICBTUEFfVFlQRV9JTkZPX0VOVU1fQkFTRSAiSU8iCi0jZGVmaW5l
IFNQQV9UWVBFX0lORk9fSU9fQkFTRSAgICAgICAgICBTUEFfVFlQRV9JTkZPX0lPICI6IgoKIHN0
YXRpYyBjb25zdCBzdHJ1Y3Qgc3BhX3R5cGVfaW5mbyBzcGFfdHlwZV9pb1tdID0gewogICAgICAg
IHsgU1BBX0lPX0ludmFsaWQsIFNQQV9UWVBFX0ludCwgU1BBX1RZUEVfSU5GT19JT19CQVNFICJJ
bnZhbGlkIiwgTlVMTCB9LArigKYKCgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5
c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2Nv
Y2NpCg==
