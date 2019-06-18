Return-Path: <SRS0=bRnq=UR=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2321CC31E51
	for <cocci@archiver.kernel.org>; Tue, 18 Jun 2019 11:44:58 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C47F2070B
	for <cocci@archiver.kernel.org>; Tue, 18 Jun 2019 11:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="rr5duNX2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C47F2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5IBifWX020547;
	Tue, 18 Jun 2019 13:44:41 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8603B777F;
	Tue, 18 Jun 2019 13:44:41 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 547937779
 for <cocci@systeme.lip6.fr>; Tue, 18 Jun 2019 13:44:39 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5IBicu6019934;
 Tue, 18 Jun 2019 13:44:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1560858269;
 bh=f365Vkn6sWr/poFBuZ54QTT4vy6mHZdUcafudWe19zE=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=rr5duNX2k08ma2Mlbolao+FG6mPUqmJCPgOHG59aQ6G4tx7IQIUT7t989mtUdhaFt
 cIe4NRkb5CK4ix3PdHC5hnpb7F+Ds1Pun3r9yif+RgsOG8DfeO+dwFVm4f7TOgBzci
 8y4OQ41jjz6dJet6DldDHL3/qodquNA1NRXsvKAw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.86.175]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lh6PP-1iRQnS0Vwl-00oXml; Tue, 18
 Jun 2019 13:44:29 +0200
To: Enrico Weigelt <lkml@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20190406061112.31620-1-himanshujha199640@gmail.com>
 <f09006a3-691c-382a-23b8-8e9ff5b4a5f1@web.de>
 <alpine.DEB.2.21.1906081925090.2543@hadrien>
 <7b4fe770-dadd-80ba-2ba4-0f2bc90984ef@web.de>
 <f573b2d3-11d0-92b5-f8ab-4c4b6493e152@metux.net>
 <032e347f-e575-c89c-fa62-473d52232735@web.de>
 <910a5806-9a08-adf4-4fba-d5ec2f5807ff@metux.net>
 <efc38197-f846-142d-fbaf-93327c2669c9@web.de>
 <714a38fe-a733-7264-bb06-d94bd58a245a@metux.net>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <8ae16eae-7bb9-3a82-000f-52e16aa1eee0@web.de>
Date: Tue, 18 Jun 2019 13:44:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <714a38fe-a733-7264-bb06-d94bd58a245a@metux.net>
Content-Language: en-US
X-Provags-ID: V03:K1:KkA7Ndb2dGDW6kXHq6nLkPVqT6Y4OfPLeEcJ3O3mdz/hOPHVW9l
 iipikgoSNcxDNs1f8nmsa7f2N2POZe1LhguOjIKjaCoR4AMm5+3+q/yJX92hiu2UZvRkCAj
 uehq14PLu396jeH/0ijDHXzqrS9cptHkLPiAgq5Rtw0iSFs+JPF65YvGiQD8xojiXtNzEtY
 VaAQ5EN+XAeq2yF9tgnJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:n+3DWs4yqzg=:QzABxMMMY/1KDjcOHg9SwO
 UjJTutFwwwMXcO8mD4zSz0HWUluxsN0nFCRYzK46M9mbI0T6xx2EG1Qeb/7cBI7EqeTnDD8aN
 T9sv9H11dN07LbNM+2LSGpn5Qwmh/gOe/jXqpn6uXPpEZnMNd4HF8LRWY0rL2Kd21THm0FPDr
 wRR8U5eSsf8NAShIgFkxh8Pt9DiAkGqKLIZY8wqTrwXyhmy53qvaNtAuvM2OWRpf1uRJjJajV
 7YGrJBul4mQ+dlDyuX1bo2C6yiuYJjXS700Rg0JcVVyJsaz/i0NVyUMk5kn5HQBpNwBWpz0qN
 LoReS+leNFNAOBZLz3FTbekS+0Pl/EEqMjyCf0yvapUSs4xzWWqU/DXbJ4jgX0ZzYXbVcvLO5
 bKeyCsjV4oulwgUn4AHPRcAowBW1rwhhGnCuNJpAEDu2XHI+J9e0fGDE/eaut8hfot4V9bk0Q
 HN5p3VbXoocK+pNh9Z96j+MJa3KMioCTSf/gUv9dOWVGO7Tm73o0dMEaNm2hXmNrWgux4K5+j
 +LH3XeY7USyvBVRhp3kJCPcqnbQkvDc39BXxXuCROVqX5m1HKaV+Jlwa4NIyQT2EwVWXtXP9A
 VpsYytNXxfzX7xQChbhHnG0mhi7NSuLh0JgeCudsHyrETIGb6as2EIyInqaV6NcXbBC7ODh1h
 sBNFXsoy1uEy1C4+x0jIj+JFZwUT4wyEz88OtvJvO3EBOykSd3w64+zbWdBzQhwIGLvjsGKzX
 TC3BhLrjozLNEyaqEeB2dkBv70ZFwueRZ+2ywANj7sV0wIeXS5TEy0KH2RPelNqBh1S/uf/Fb
 4bI02G+E/FXlXnp6NU8KVS3kNvQ9u6iBHVzyT9D1sOd5YUprQAAtxSidaV8ZaK484yDWbJnVB
 nCFZmcDp2KFI+eqL0RiTUypRgQLxE5YiOkHE4vgr01vXAE2BYY2cSjX8qi5YjWNYw0rtb9q39
 Isq67EO1glVgHcY1sVjrWEgqVUGUbx2e+QoUiD40FxzsQBYu25KmO
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 18 Jun 2019 13:44:42 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 18 Jun 2019 13:44:38 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci] drivers: Inline code in
 devm_platform_ioremap_resource() from two functions
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

Pj4gV291bGQgeW91IGxpa2UgdG8gY2hlY2sgdGhlIHNvZnR3YXJlIGNpcmN1bXN0YW5jZXMgb25j
ZSBtb3JlCj4+IGZvciB0aGUgZ2VuZXJhdGlvbiBvZiBhIHNpbWlsYXIgY29kZSBzdHJ1Y3R1cmUg
YnkgYSBDIGNvbXBpbGVyCj4+IChvciBvcHRpbWlzZXIpPwo+Cj4gQXMgc2FpZDogdW5mb3J0dW5h
dGVseSwgSSBkb24ndCBoYXZlIHRoZSB0aW1lIHRvIGRvIHRoYXQKCkkgYmVjYW1lIGN1cmlvdXMg
aWYgeW91IHdvdWxkIGxpa2UgdG8gYWRqdXN0IHlvdXIgc29mdHdhcmUgZGV2ZWxvcG1lbnQKYXR0
ZW50aW9uIGEgYml0IG1vcmUgYWxzbyBpbiB0aGlzIGFyZWEuCgoKPiAtIHlvdSdkIGhhdmUgdG8g
dGVsbCB1cywgd2hhdCBleGFjdGx5IHlvdSd2ZSBnb3QgaW4gbWluZC4KCkkgdHJ5IHRvIHBvaW50
IHBvc3NpYmlsaXRpZXMgb3V0IHRvIGltcHJvdmUgdGhlIGNvbWJpbmF0aW9uIG9mCnR3byBmdW5j
dGlvbnMuCgoKPiBJZiBpdCdzIGp1c3QgYWJvdXQgc29tZSBlcnJvciBjaGVja3Mgd2hpY2ggaGFw
cGVuIHRvIGJlIHJlZHVuZGFudCBpbiBhCj4gcGFydGljdWxhciBjYXNlLCB5b3UnbGwgaGF2ZSB0
byBzaG93IHRoYXQgdGhpcyBjYXNlIGlzIGEgKnJlYWxseSogaG90Cj4gcGF0aCAoZWcuIGlycSwg
c3lzY2FsbCwgc2NoZWR1bGluZywgZXRjKSAtIGJ1dCBJIGRvbid0IHNlZSB0aGF0IGhlcmUuCgox
LiBNYXkgdGhlIGNoZWNrIOKAnHJlc291cmNlX3R5cGUocmVzKSA9PSBJT1JFU09VUkNFX01FTeKA
nSBiZSBwZXJmb3JtZWQKICAgaW4gYSBsb2NhbCBsb29wPwoKMi4gSG93IGhvdCBkbyB5b3UgZmlu
ZCB0aGUgbnVsbCBwb2ludGVyIGNoZWNrIGZvciB0aGUgZGV2aWNlCiAgIGlucHV0IHBhcmFtZXRl
ciBvZiB0aGUgZnVuY3Rpb24g4oCcZGV2bV9pb3JlbWFwX3Jlc291cmNl4oCdPwoKCj4gQW55IGFj
dHVhbCBtZWFzdXJlbWVudHMgb24gaG93IHlvdXIgcGF0Y2ggaW1wcm92ZXMgdGhhdCA/CgpOb3Qg
eWV0LiAtIFdoaWNoIGJlbmNobWFya3Mgd291bGQgeW91IHRydXN0IGhlcmU/CgoKPiBMb29rLCBJ
IHVuZGVyc3RhbmQgdGhhdCB5b3UnZCBsaWtlIHRvIHNxdWVlemUgb3V0IG1heGltdW0gcGVyZm9y
bWFuY2UsCgpJIGhvcGUgc28uCgoKPiBidXQgdGhpcyBoYXMgdG8gYmUgcHJhY3RpY2FsbHkgbWFp
bnRhaW5hYmxlLgoKVGhpcyBjYW4gYmUgYWNoaWV2ZWQgaWYgbW9yZSBjb250cmlidXRvcnMgd291
bGQgZmluZCBwcm9wb3NlZAphZGp1c3RtZW50cyBoZWxwZnVsIGZvciBhbm90aGVyIHNvZnR3YXJl
IHRyYW5zZm9ybWF0aW9uLgoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1l
LmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
