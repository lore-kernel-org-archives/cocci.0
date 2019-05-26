Return-Path: <SRS0=ycDg=T2=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBC6C282E3
	for <cocci@archiver.kernel.org>; Sun, 26 May 2019 09:27:39 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BF012085A
	for <cocci@archiver.kernel.org>; Sun, 26 May 2019 09:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="UdIjh6BX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BF012085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4Q9RNT5015469;
	Sun, 26 May 2019 11:27:23 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 00C067747;
	Sun, 26 May 2019 11:27:23 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B484F773A
 for <cocci@systeme.lip6.fr>; Sun, 26 May 2019 11:27:21 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4Q9RLh1025123;
 Sun, 26 May 2019 11:27:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1558862841;
 bh=BVLfqQoLzARMl5h9/mbyAM5aGZ3Pso9V9Fxn/epVUqw=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=UdIjh6BXCGQp1aUJg5wKRRo4OZG10i0ISdW6fKr2J2vg99CxddWUD7ixiUn1VLZBs
 mJREcVKhshoJSaqzLVeQi1txIjE+lNrhSB/ObC6hrQR6iQlQr92vpOmfesoWERqk35
 L3Yf4qETd9iOWpKAQ1hXz/ShCbZO8QANMEUme71k=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.4] ([78.49.116.98]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LfRnJ-1gpRzd3hft-00p4eU; Sun, 26
 May 2019 11:27:20 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <alpine.DEB.2.21.1905222114490.2618@hadrien>
 <81b409c6-5986-5961-5edf-843c6737d88c@web.de>
 <alpine.DEB.2.20.1905231500230.3573@hadrien>
 <b5c322d3-3162-953f-a985-53abc5064482@web.de>
 <0782D580-3DD6-4419-B5E1-C04215FB2E3B@lip6.fr>
 <bcc5a120-dc66-7511-a401-e14c322dd67b@web.de>
 <4FE72A81-9D85-4786-898C-A84E2AC5B520@lip6.fr>
 <20bd8b39-015d-4919-d0fe-c92eff9d7cd4@web.de>
 <alpine.DEB.2.21.1905260512140.2535@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <cef0e45d-801b-af84-0958-dfdbadd47e83@web.de>
Date: Sun, 26 May 2019 11:27:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1905260512140.2535@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:adfqUHl+fqqKoCPbZ820XuPjx8fyA/aW/Qw1yRNeylUtWyZC4tE
 XMIcFX66nDEG3BTXWfHBn06S4QA+2cCpx6hD9iHQqPuwBYoKEzxy+CfDaCorYsqZtju1KbN
 y8UpvFqd050QUJFtnT9IdDqd/ZJhyXIhgXEFn0C3EwyPeM4lJsV3poePkWwAv4eoNgTR/0A
 hq7ND/LbYhma+dPzMn8Lg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BHxSIslSwWE=:DL4PCX1QRGKU8e2VTlOchO
 5m4XEKv4wnxl6gWD1Z3gfh6upzT7sNLcXRpDYGKJNzVIhX5r7+lylcwpBcAdqH8m3+MJSRj2w
 dBXvopaal/qgcFuGfHNjL7bRgXoUXlnAhRJ4i45jkNaBv3+G+orwU6d1gFMh8PSZ4TSimQzN7
 EN43sIGvWBQPNsycYxYDyUeQZ4PcapsHjh7wA83xJg/FiOkJtNyTJpEP16Nmbrp/DUk9+mEZK
 t72HL+nDhJG0SymrptSpT1zlAu+D3uLw12YjVKWRAYWTJGwf/G63D/7SQd/CW1NcIVxBBSKgb
 fgrH2APVbgLn+d3BbciBYgGar9iw0elFGPrPYgZ6yK9P2rdcNVsVir7c4Nx30YJpc1pCMavW/
 tEHiIxqy4am0UsIUeej+ccvZpttZlDEHefz7/nXYzQJ1EzQtwkEcNPLxCzVF26QfqTqxOVfcA
 6VV5R5oDQS1TDCzcwSmmmPvENk2Cqt3A4eLZSlfheLEoOgFMgsXMWvf088HnFM+LQ/lecviq0
 EN0Q29RQXWpDWPLECKKztVJLciTK8CGW0eLc23055nothB2dmvPqxfTH5YqY6tZMb7vRRrmjb
 lkiEHvUGGXSY75gxloX+9CT7MOx/xSZNhRNqsY9nvzWn1riKzsCcjvwzV5SWJuhcBj6lc5m3m
 Zc+aojWDrQYerl+A7V52+ambG7z7SeyDXsKDMisGAbwXs9rWwMxZkMyQbHVpimiEncrrRDcGJ
 0l8ozdQtA8prqjRMeAD7ZwjL/oy+CgdswK2FCaxxU6b6J2MrcCnnYXjJOtJr4nT33kY3gMcRA
 J2iSigvK5EtyB4gi+/KMHkAxzyXRzn21Zhl+7RDEkfxVP3oyfkpQ/hqmZoMjPTJgI9l7MI1v8
 TzEPuY/PhQ/XKMY+jNg0HypMx0nuNyE6LWh4DFPIPJaj0h91eCSjzV/hXBGOnaZzDtUmAz2yz
 3PYOoZhZMZsvB9lc6BhHAhsbTcc1VfCfK9JJlWoCof+MbPI5ZMjaZ
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 26 May 2019 11:27:23 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 26 May 2019 11:27:21 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] accessing comments
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

Pj4gQ2FuIGl0IGJlIHRoYXQgc3VjaCBhIGNvbW1lbnQgd291bGQgYmVsb25nIHRvIHRoZSBmdW5j
dGlvbiBjYWxsIG9wZXJhdG9yCj4+IChvcGVuIG9yIGNsb3NpbmcgcGFyZW50aGVzaXMpIGluc3Rl
YWQgb2YgdGhlIGlkZW50aWZpZXIg4oCcZm9v4oCdPwo+Cj4gWW91IHB1dCB0aGUgY29tbWVudCBt
ZXRhdmFyaWFibGUgb24gd2hhdGV2ZXIgeW91IHdhbnQuCgpUaGlzIGZ1bmN0aW9uYWxpdHkgaXMg
Z2VuZXJhbGx5IG5pY2UuCgoKPiBUaGUgcmVwb3J0IGZvciB0aGUgY29tbWVudCBpbiB0aGUgYXJn
dW1lbnQgbGlzdCBjb21lcyBmcm9tIHRoZSBjb21tZW50IG1ldGF2YXJpYWJsZQo+IG9uIHRoZSBj
b21wbGV0ZSBzdGF0ZW1lbnQsIG5vdCBvbiB0aGUgY29tbWVudCBtZXRhdmFyaWFibGUgb24gZm9v
LgoKVGhhbmtzIGZvciBzdWNoIGZlZWRiYWNrLgoKSXQgc2VlbXMgdGhhdCB0aGlzIGluZm9ybWF0
aW9uIGNhbiB0cmlnZ2VyIGV4cGVjdGF0aW9ucyBmb3IgZnVydGhlciBjbGFyaWZpY2F0aW9uCm9m
IHRoZSBkZXNpcmVkIHNvZnR3YXJlIGJlaGF2aW91ci4KClJlZ2FyZHMsCk1hcmt1cwpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxp
c3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4v
bGlzdGluZm8vY29jY2kK
