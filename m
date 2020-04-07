Return-Path: <SRS0=i6Iw=5X=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FB9C2BA80
	for <cocci@archiver.kernel.org>; Tue,  7 Apr 2020 17:23:04 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF9E320719
	for <cocci@archiver.kernel.org>; Tue,  7 Apr 2020 17:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="jIN5hjrS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF9E320719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 037HMcmE007721;
	Tue, 7 Apr 2020 19:22:39 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D8D7E7816;
	Tue,  7 Apr 2020 19:22:38 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 6D7FC7815
 for <cocci@systeme.lip6.fr>; Tue,  7 Apr 2020 18:03:53 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 037G3p8e013905
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Tue, 7 Apr 2020 18:03:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1586275414;
 bh=e3mRm5CWAZ94bLSIQgu24+nnAMT62ywXZ1pN+mDxiVA=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=jIN5hjrSASiCcNRUHqRZCzPOYwhWWdaVRg9MoG+Uq2mqNFDGhB0vSQK/n2MN3VmSy
 h92TJRIfqf5DB+Z+GEjspLoee1s236JsuuNPn/DHrq71lNusQKjsPgaa99S4s1hy8y
 QKZlRV+KDzvHwXUAI5SagxvyAhK7cwpy6HywOOaE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from lenovo-laptop ([82.19.195.159]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MvbFs-1j3d5f3HN8-00sfoC; Tue, 07
 Apr 2020 18:03:33 +0200
Date: Tue, 7 Apr 2020 17:03:30 +0100
From: Alex Dewar <alex.dewar@gmx.co.uk>
To: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <20200407160330.5m75sfkhrrx3wgrl@lenovo-laptop>
References: <beeed2c8-1b5a-66a8-ec41-f5770c04bae9@web.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <beeed2c8-1b5a-66a8-ec41-f5770c04bae9@web.de>
X-Provags-ID: V03:K1:VyTCQk3EiMwZojK0lcw8VVypr4boid8PMeIUQcoFh5hfKXppl56
 f55N+K3JBSSRb1BRquGaiX4iXL3AXghXl6kjS9BQyMfsiE7wKmAzQjMA6az0OKeLnxKig21
 0jtHzgLZDn7oelFHXALFodCvR1ijjVom5BFJsf81wct7THQwETUEq5ke8Cip0Y+QW5kyvzn
 tgfNXExVv5a25wkN2Eo4g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7YENew970fU=:3ut9H6t0BFdslC+tkJ3dnR
 4vEXMQannVKiiPvU4Ifp81a8B/GXumK0AUngL5R0LwXPAGET5HxyNp9IvUET//yuSKo1LgWJM
 zC+s4sn+xZ4ESLWwFE0oJX42w94ZdqosLisZaQqpAlkAF6Rkj/EWXNkNZ1tkmmlJOl/uzPIny
 5TTUVZMDkN4kxA9iOUGfSf9ikSxrPITG3E+urpXnOCVWM5ZgYfslrxuvyL0At4dFTTfiaYBW0
 FqxTgTSDTCUOu52A+JEfZa65NvVBB2ldi4sU/VhalGYYa6FJGp85NsHrhzj+49K1RRJaUqd5D
 2+6bT+IMpLL+uiol8SpyBVsottPF2KlkEFLAnNT9+RG4hpjq6YDfJ6pKD5mds1KoNhaLiJQiy
 6tOGt/XM+4bkUFaqXGGLqC3Je+zto3vqMW5lx1y+R60pC1oA2FEWKsPYGkjWKvVu527zi6zyj
 WRa1UT97yPy9FuKTlYoiPJ6DxehYCZ4b4rI8mfbrpwZCGJ0nySBWcrQ5yxRP0YkmOD39NYLYP
 2clVJS4sDs+vUpZY5kp882AvQyStkPuJZ5gYgzAkBsjaZd3YaKN9FXOJxhkDhKRBKRqj6T2J3
 WgmXLgxDl10l8OveZP5X7QBUBbCC3RSvfYHyPp+nCbzZPHT2IXXikUE56feY34aZkpgqI9TD4
 7gH/zKpSlp9avP9PSCfkzfsYe8JEI7SI+VOLHVRZBl9RfLoOGZghWWrha6kVKZ8gNhixV2Npz
 QeHs6xVdAgbt3RMfz1QEHOdGpHxsRyFcw/bZ1Uoo4dE2JH91/WFVeLl84J6iM+F5oF/oSXC8S
 Yn4EbLN6PzaiIt4Sf7OPCssoA0uNr41i4mlZJoKbpwA+8lw+XYzWZM5JN77FnhHQynKcllLmb
 LtamXhONciuKcqE9P0lJfLtKGrIbLlEQJmsj8fkeJGMZ0HH0rLXkIfgLMhVf9/++xVcA4/e4l
 2ZWGFPlANUS1cX6bjWcWmTnF6Kj+JMrm1ccvgCRVPgL+/I9QgG4g4RYofMrca4tSnX4bTPOHp
 qpnXzrPel7V2RzxAARtJ8zrbP42Z/br8iNMZqfVMYmGq1eprif+D5ixyt8GHCstUw8kxjpycJ
 Y9QqL2IDdi/tOtD7PgCjvKs/+cLQuvgFwDa0Fb5btAQraaJ2Px1Qu2zMg1tm0RsIDr8n2to2t
 Uzdjg7ZfJQtSQj9uhiJB3P9Ne7Gr6KVZWrFsYRlfcJohjVJOFUUaRSP4hrNoYfA6tdLPSxlNR
 iEBlZEtOjOrF1ex8v
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 07 Apr 2020 19:22:39 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 07 Apr 2020 18:03:51 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Tue, 07 Apr 2020 19:22:36 +0200
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, cocci@systeme.lip6.fr,
        Allison Randal <allison@lohutok.net>
Subject: Re: [Cocci] [PATCH] Coccinelle: zalloc-simple: Fix patch mode for
 dma_alloc_coherent()
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

T24gU2F0LCBBcHIgMDQsIDIwMjAgYXQgMDk6MDY6NDZBTSArMDIwMCwgTWFya3VzIEVsZnJpbmcg
d3JvdGU6Cj4gPiBDb21taXQgZGZkMzJjYWQxNDZlICgiZG1hLW1hcHBpbmc6IHJlbW92ZSBkbWFf
emFsbG9jX2NvaGVyZW50KCkiKSwgaW4KPiA+IHJlbW92aW5nIGRtYV96YWxsb2NfY29oZXJlbnQo
KSB0cmVld2lkZSwgaW5hZHZlcnRlbnRseSByZW1vdmVkIHRoZSBwYXRjaAo+ID4gcnVsZSBmb3Ig
ZG1hX2FsbG9jX2NvaGVyZW50KCksIGxlYXZpbmcgQ29jY2luZWxsZSB1bmFibGUgdG8gYXV0by1n
ZW5lcmF0ZQo+ID4gcGF0Y2hlcyBmb3IgdGhpcyBjYXNlLiBGaXggdGhpcy4KPgo+IEkgc3VnZ2Vz
dCB0byByZWNvbnNpZGVyIGFsc28gdGhlIGRpc3RyaWJ1dGlvbiBvZiByZWNpcGllbnRzIGZvciB5
b3VyIHBhdGNoCj4gYWNjb3JkaW5nIHRvIHRoZSBmaWVsZHMg4oCcQ2PigJ0gYW5kIOKAnFRv4oCd
LgoKR29vZCBwb2ludC4KCj4KPiBXaWxsIHRoZSBzb2Z0d2FyZSBkZXZlbG9wbWVudCBhdHRlbnRp
b24gZ3JvdyBpbiBhIHdheSBzbyB0aGF0IGZ1cnRoZXIKPiBpbXBsZW1lbnRhdGlvbiBkZXRhaWxz
IGNhbiBiZSBhZGp1c3RlZCBhbHNvIGZvciB0aGUgbWVudGlvbmVkIFNtUEwgc2NyaXB0PwoKSSdt
IG5vdCBzdXJlIEkgdW5kZXJzdGFuZCB3aGF0IHlvdSBtZWFuLiBXb3VsZCB5b3UgbWluZCBjbGFy
aWZ5aW5nPwoKQmVzdCwKQWxleAoKPgo+IFJlZ2FyZHMsCj4gTWFya3VzCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2Nj
aUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5m
by9jb2NjaQo=
