Return-Path: <SRS0=MjcO=UK=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E06C31E40
	for <cocci@archiver.kernel.org>; Tue, 11 Jun 2019 20:40:57 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C99F52184B
	for <cocci@archiver.kernel.org>; Tue, 11 Jun 2019 20:40:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C99F52184B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5BKefb4026562;
	Tue, 11 Jun 2019 22:40:42 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A9533775F;
	Tue, 11 Jun 2019 22:40:41 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4C8B6775D
 for <cocci@systeme.lip6.fr>; Tue, 11 Jun 2019 22:40:39 +0200 (CEST)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5BKec71011602;
 Tue, 11 Jun 2019 22:40:38 +0200 (CEST)
Received: from [192.168.1.110] ([95.118.191.213]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MrQ2R-1iPHOT18lz-00oVWA; Tue, 11 Jun 2019 22:40:30 +0200
To: Markus Elfring <Markus.Elfring@web.de>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Himanshu Jha <himanshujha199640@gmail.com>
References: <20190406061112.31620-1-himanshujha199640@gmail.com>
 <f09006a3-691c-382a-23b8-8e9ff5b4a5f1@web.de>
 <alpine.DEB.2.21.1906081925090.2543@hadrien>
 <7b4fe770-dadd-80ba-2ba4-0f2bc90984ef@web.de>
From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <f573b2d3-11d0-92b5-f8ab-4c4b6493e152@metux.net>
Date: Tue, 11 Jun 2019 22:40:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <7b4fe770-dadd-80ba-2ba4-0f2bc90984ef@web.de>
Content-Language: en-US
X-Provags-ID: V03:K1:f+Ht5hYFuUjeYvOKk6o2JFMqi39l5C6wxnnE8+7O0BKjk77Q6Gu
 qW9aH+F0ZT8XX2DGUe0Sjk2ayDE4lx9wopAmDNfaFfijlhzOFpqsy8LoaCD8wFHpI0IZUel
 ovAoUFC4eCcRwscNpmi84MD7qv7J/UNi3mwOZn58//9eJqryuQDpj3WsV2SpPl7aThOemU/
 BtDuGhGNhqpfa9fFMTlTQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yXeVLoxn+9I=:RwY/bgJO0YPNmR9AYAPBeS
 /+qzsjqiuP5IAgj2OapVuADyWvI6cWGzbmF3A6aE5gtJaRh2g2WierULflfOPPqEfdaplzAFA
 yo/GMjqfiPMx++tBUZMbrDF7UeX8G8tAOTnX1MPCa+ToME7XY+iIpkCw+7cvN2Fa/Pv0R1bw9
 4cFL42FCsm+z5AID2Owml/OcPwE1KZmnEQ8jfzxuoBdiuiKaV5vvw4xV5Lz+uWTRyqKIOIbo2
 yu2birfHdrv/orQpu7CQRHhAxwX0Zw5QGhWjbwIc1U7rzNsXpk7D2OmniUi46t7eIA/wHd/od
 /MfCYikLODkOX66TcDDtgAswB+J6ko+0O7zOJH6xSAD9t517IfZQ1DH8S9oXl5vxRMDzAQ2pm
 r9DkylZpbhuI0qTH7s778dPkaX0KSP2MvYf2VVfsI9ILSI8MjDiyRi31Yehmm3YPfLsKcI44o
 MalWbbQurUYeI/DJj3Xh/jxYYlbtyfXn3BPIE4Z72CHa+3Xz31NLb02XLYQlXZpvYN2oiWW4k
 aGTzHQUIvQzA7Y2nSLZkNtDaF0B74I7AlkzGshi5yCOEdjRU1R5gVruYCCif23N98W9UuB6TJ
 2IjfyxdJSIXsUtwC2oWD0Y4444cuHK+ThFlLQRj5FgW3rBhcK9lOV6wDPgD1KkpTx0R8+5znJ
 pBnkvkZo8TA9DEHzXObMdjfIAFDrUbZRPZtLpjHYUqpVBRZwN0T6E7rsOEAPPPZxwQRH1wVcW
 qbaQS5yN+aTEQmPw5QA13iLHpBYrEbWpvjePeWIqHUgX52/KeA8a1qe/NdY=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 11 Jun 2019 22:40:42 +0200 (CEST)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Tue, 11 Jun 2019 22:40:38 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci] Coccinelle: api: add devm_platform_ioremap_resource
	script
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

T24gMDkuMDYuMTkgMTA6NTUsIE1hcmt1cyBFbGZyaW5nIHdyb3RlOgoKPHNuaXA+Cgo+PiBCdXQg
dGhlcmUgaXMgbm90IHVzdWFsbHkgYW55IGludGVyZXN0aW5nIGZvcm1hdHRpbmcgb24gdGhlIGxl
ZnQgc2lkZSBvZiBhbgo+PiBhc3NpZ25tZW50IChpZSB0eXBpY2FsbHkgbm8gbmV3bGluZXMgb3Ig
Y29tbWVudHMpLgo+IAo+IElzIHRoZXJlIGFueSBuZWVkIHRvIHRyaWdnZXIgYWRkaXRpb25hbCBz
b3VyY2UgY29kZSByZWZvcm1hdHRpbmc/Cj4gCj4+IEkgY2FuIHNlZSBubyBwdXJwb3NlIHRvIGZh
Y3Rvcml6aW5nIHRoZSByaWdodCBwYXJlbnRoZXNpcy4KPiAKPiBUaGVzZSBjaGFyYWN0ZXJzIGF0
IHRoZSBlbmQgb2Ygc3VjaCBhIGZ1bmN0aW9uIGNhbGwgc2hvdWxkIGJlIGtlcHQgdW5jaGFuZ2Vk
LgoKQWdyZWVkLiBPVE9ILCB3ZSBhbGwga25vdyB0aGF0IHNwYXRjaCByZXN1bHRzIHN0aWxsIG5l
ZWQgdG8gYmUgY2FyZWZ1bGx5CmNoZWNrZWQuIEkgc3VzcGVjdCB0cnlpbmcgdG8gdGVhY2ggaXQg
YWxsIHRoZSBmb3JtYXR0aW5nIHJ1bGVzIG9mIHRoZQprZXJuZWwgaXNuJ3QgYW4gZWFzeSB0YXNr
LgoKPiBUaGUgZmxhZyDigJxJT1JFU09VUkNFX01FTeKAnSBpcyBwYXNzZWQgYXMgdGhlIHNlY29u
ZCBwYXJhbWV0ZXIgZm9yIHRoZSBjYWxsCj4gb2YgdGhlIGZ1bmN0aW9uIOKAnHBsYXRmb3JtX2dl
dF9yZXNvdXJjZeKAnSBpbiB0aGlzIHJlZmFjdG9yaW5nLgoKSW4gdGhhdCBwYXJ0aWN1bGFyIGNh
c2UsIHdlIG1heWJlIHNob3VsZCBjb25zaWRlciBzZXBhcmF0ZSBpbmxpbmUKaGVscGVycyBpbnN0
ZWFkIG9mIHBhc3NpbmcgdGhpcyBpcyBhIHBhcmFtZXRlci4KCk1heWJlIGl0IHdvdWxkIGV2ZW4g
YmUgbW9yZSBlZmZpY2llbnQgdG8gaGF2ZSBjb21wbGV0ZWx5IHNlcGFyYXRlCnZlcnNpb25zIG9m
IGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJjZSgpLCBzbyB3ZSBkb24ndCBldmVuIGhhdmUK
dG8gcGFzcyB0aGF0IHBhcmFtZXRlciBvbiBzdGFjay4KCgotLW10eAoKLS0gCkVucmljbyBXZWln
ZWx0LCBtZXR1eCBJVCBjb25zdWx0CkZyZWUgc29mdHdhcmUgYW5kIExpbnV4IGVtYmVkZGVkIGVu
Z2luZWVyaW5nCmluZm9AbWV0dXgubmV0IC0tICs0OS0xNTEtMjc1NjUyODcKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNv
Y2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3Rp
bmZvL2NvY2NpCg==
