Return-Path: <SRS0=UZdp=UI=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDFEC28EBD
	for <cocci@archiver.kernel.org>; Sun,  9 Jun 2019 08:56:15 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2D0E2089E
	for <cocci@archiver.kernel.org>; Sun,  9 Jun 2019 08:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="TpcOjKwf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2D0E2089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x598u0w4009765;
	Sun, 9 Jun 2019 10:56:00 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 90B3E775D;
	Sun,  9 Jun 2019 10:56:00 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id AE5E5774C
 for <cocci@systeme.lip6.fr>; Sun,  9 Jun 2019 10:55:59 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x598twDJ006869;
 Sun, 9 Jun 2019 10:55:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1560070546;
 bh=yWKywYw0sHaVLOotH7c9LtTSfYfsAFBvYCxGv700zxE=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=TpcOjKwfhXcdS7UV9guaO26+AUkea3jN+H4iVnWEdsnhHObPt2QM8xa6QrGkjfshs
 XZhuC28QpdhPHGB1lIGnDuNvyBB9Eyrrqpl0aEZNqoDuJ7UGcpKMf4Fx1+7ZKx1PpD
 TUMW332K9BBRRYu4Y9T+LGmfCCbSM79h0sHbf+rE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.4] ([2.244.77.74]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LnSOM-1gtQSN30BC-00heRC; Sun, 09
 Jun 2019 10:55:45 +0200
To: Julia Lawall <julia.lawall@lip6.fr>,
        Himanshu Jha <himanshujha199640@gmail.com>
References: <20190406061112.31620-1-himanshujha199640@gmail.com>
 <f09006a3-691c-382a-23b8-8e9ff5b4a5f1@web.de>
 <alpine.DEB.2.21.1906081925090.2543@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <7b4fe770-dadd-80ba-2ba4-0f2bc90984ef@web.de>
Date: Sun, 9 Jun 2019 10:55:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1906081925090.2543@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:JDSlyCoTpTsPKOQ677p0YWGseBYr8HGllMkZiK9aphYVpDna+in
 SzvU0jbR4UgnupEymNoBCKfwYyLZIL1KNSYbBGWtPsBh89e8xArdCCGIeNLhpf6HxiKY1ov
 EFOUbueuJxDe5LICmL89fJp7dliVfz4IqkOM0ZDAxQut8KLmAYSDaeh/EOy8hmAjqv5kJIj
 uiFASifQqioungX2KrFgQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bJPEe4L2Q5A=:s4pRhCV8TjuiB4jQ5yEW1X
 eyENHdN3LzPOMV+OL/UF2bzVHKvIIIFpbDsb2KoCptDRcjcmgtk2CtyB4wE7hYjC5aOzlLbYE
 LbziWYLh6iEdKoXb3GFSqhkCnyR8FK1EgHnMASPwa+uOCZ4McLCmNgbt0+htfKH8o09egGTMA
 xzny9F5mfaAF7ifljXj0Q2dtTkpyKCn1qq0lDk92r1Y22s0mX2ecL2PEqE+Br+2WuKBUh8uaC
 3Ww4cyd3bkNpWZ6dmcSTtslwT623ejZSmjQRpED8HHQxSXvYKK5oENS2PAMhic1K2rX+3+Eg1
 Y3O0qGK4gbVR17IRTOCkxWhet1BODXXKXAsbfEvF4f9M5MSUvoxUIsApijuPtVWhoEmVoB0WF
 MR5NsI02LW1pV3rHvPsNk7k3jd2Ofwq1CFk34BGLGWgMPmpEBHeqGFp2xPWyY3m4a3OvedgQC
 3WBxBnOKGmYqJSd5w7CWblETQma4aPnBN2u+3vsDAi0Kc+/R5IQFbHqV8QN7lgcsMt86eq3hv
 NArqTXrRoWT6IObaS+a+OP1FkgB9CmCWCSSPiPTd7hUqxcnYSM6PsoN+LPfQEmADlKmdoyiyt
 OPKSNJYc6/08AY46oyeVxSj4cxd/o2zPxJgtzBhZ1R2WK8LcKaLqTD74QL1dlCWEqs6TOr/90
 U8iFIWoUkXA7nngFLSWtXm7j3oESPsIoSSSuUO4bZahhigAweKyilKTvryf1ypBq5GK/iUDiE
 19b9ZDlTLn4xYYww4qy2NTmu+jrEPR6fF6G1SZ2RWaqeW3L8UmQ2PdAX4Gv5Oxguicm2bK2XS
 GE2dSYS0c8XE6BSQtmT1QhgR/qkrZFbEI+WXtB5y7MrFd9arLMTB+uxSLNs1zu/t11UZufiyh
 6EyBJY0jLGEAKDQyfRU0N2emiMiZf4BzXLe/JlNi8c+YSSjLQjWoiW8fQGWPBYsa5npBP5bY+
 ijt0EVXuW7bJYBWL0iMstJpLhM+u2bSHdV7BNL3qoskrmSgLRXzyf
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 09 Jun 2019 10:56:01 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 09 Jun 2019 10:55:58 +0200 (CEST)
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

Pj4+ICstIGUxID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKGFyZzQsIGlkKTsKPj4+ICsrIGUxID0g
ZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlKGFyZzEsIGFyZzMpOwo+Pgo+PiBDYW4gdGhl
IGZvbGxvd2luZyBzcGVjaWZpY2F0aW9uIHZhcmlhbnQgbWF0dGVyIGZvciB0aGUgc2hvd24gU21Q
TAo+PiBjaGFuZ2UgYXBwcm9hY2g/Cj4+Cj4+ICsgZTEgPQo+PiArLSAgICAgZGV2bV9pb3JlbWFw
X3Jlc291cmNlKGFyZzQsIGlkCj4+ICsrICAgICBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3Vy
Y2UoYXJnMSwgYXJnMwo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgKTsKPgo+IEluIHRo
ZSBsYXR0ZXIgY2FzZSwgdGhlIG9yaWdpbmFsIGZvcm1hdHRpbmcgb2YgZTEgd2lsbCBiZSBwcmVz
ZXJ2ZWQuCgpJIHdvdWxkIGxpa2UgdG8gcG9pbnQgdGhlIHBvc3NpYmlsaXR5IG91dCB0byBleHBy
ZXNzIG9ubHkgcmVxdWlyZWQgY2hhbmdlcwphbHNvIGJ5IFNtUEwgc3BlY2lmaWNhdGlvbnMuCgoK
PiBCdXQgdGhlcmUgaXMgbm90IHVzdWFsbHkgYW55IGludGVyZXN0aW5nIGZvcm1hdHRpbmcgb24g
dGhlIGxlZnQgc2lkZSBvZiBhbgo+IGFzc2lnbm1lbnQgKGllIHR5cGljYWxseSBubyBuZXdsaW5l
cyBvciBjb21tZW50cykuCgpJcyB0aGVyZSBhbnkgbmVlZCB0byB0cmlnZ2VyIGFkZGl0aW9uYWwg
c291cmNlIGNvZGUgcmVmb3JtYXR0aW5nPwoKCj4gSSBjYW4gc2VlIG5vIHB1cnBvc2UgdG8gZmFj
dG9yaXppbmcgdGhlIHJpZ2h0IHBhcmVudGhlc2lzLgoKVGhlc2UgY2hhcmFjdGVycyBhdCB0aGUg
ZW5kIG9mIHN1Y2ggYSBmdW5jdGlvbiBjYWxsIHNob3VsZCBiZSBrZXB0IHVuY2hhbmdlZC4KCgpJ
IGdvdCBhbm90aGVyIHNvZnR3YXJlIGRldmVsb3BtZW50IGNvbmNlcm4gYWNjb3JkaW5nIHRvIHRo
ZSBkaXNjdXNzZWQKc29mdHdhcmUgdXBkYXRlIOKAnGRyaXZlcnM6IHByb3ZpZGUgZGV2bV9wbGF0
Zm9ybV9pb3JlbWFwX3Jlc291cmNlKCnigJ0KKGZyb20gMjAxOS0wMi0yMSkuCmh0dHBzOi8vZ2l0
Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9j
b21taXQvZHJpdmVycy9iYXNlL3BsYXRmb3JtLmM/aWQ9Nzk0NWY5MjlmMWE3N2ExYzg4ODdhOTdj
YTA3Zjg3NjI2ODU4ZmY0MgoKVGhlIGZsYWcg4oCcSU9SRVNPVVJDRV9NRU3igJ0gaXMgcGFzc2Vk
IGFzIHRoZSBzZWNvbmQgcGFyYW1ldGVyIGZvciB0aGUgY2FsbApvZiB0aGUgZnVuY3Rpb24g4oCc
cGxhdGZvcm1fZ2V0X3Jlc291cmNl4oCdIGluIHRoaXMgcmVmYWN0b3JpbmcuClNob3VsZCB0aGlz
IGRldGFpbCBiZSBzcGVjaWZpZWQgYWxzbyBpbiB0aGUgcHJvcG9zZWQgc2NyaXB0IGZvciB0aGUK
c2VtYW50aWMgcGF0Y2ggbGFuZ3VhZ2UgaW5zdGVhZCBvZiB1c2luZyB0aGUgbWV0YXZhcmlhYmxl
IOKAnGFyZzLigJ0KaW4gU21QTCBkaXNqdW5jdGlvbnM/CgpIb3cgZG8geW91IHRoaW5rIGFib3V0
IHRvIGRlbGV0ZSBlcnJvciBkZXRlY3Rpb24gYW5kIGNvcnJlc3BvbmRpbmcKZXhjZXB0aW9uIGhh
bmRsaW5nIGNvZGUgZm9yIHRoZSBwcmV2aW91cyBmdW5jdGlvbiBjYWxsPwoKCklzIHRoZSBTbVBM
IGNvZGUgc3BlY2lmaWNhdGlvbiDigJx3aGVuICE9IGlk4oCdIHJlYWxseSBzdWZmaWNpZW50IGZv
cgp0aGUgZXhjbHVzaW9uIG9mIHZhcmlhYmxlIHJlYXNzaWdubWVudHMgaGVyZT8KClJlZ2FyZHMs
Ck1hcmt1cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpD
b2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5s
aXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
