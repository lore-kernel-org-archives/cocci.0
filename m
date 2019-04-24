Return-Path: <SRS0=6WN1=S2=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032FCC282CE
	for <cocci@archiver.kernel.org>; Wed, 24 Apr 2019 06:26:23 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2127B206A3
	for <cocci@archiver.kernel.org>; Wed, 24 Apr 2019 06:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="QPJI0PG8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2127B206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3O6Q6bA026753
          ; Wed, 24 Apr 2019 08:26:06 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 6D130772D;
	Wed, 24 Apr 2019 08:26:06 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 56B3A7725
 for <cocci@systeme.lip6.fr>; Wed, 24 Apr 2019 08:26:05 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3O6Q4qj018588
 for <cocci@systeme.lip6.fr>; Wed, 24 Apr 2019 08:26:04 +0200 (CEST)
X-pt: isis.lip6.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1556087164;
 bh=yiwPKaOeOlC9FTovez27xDp3F9S/8Kw3UY9vc6mFMPE=;
 h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
 b=QPJI0PG8OzUbKMZO9Y1+aV1bHzQvLMgkOHlQDPwnHhzmMHoQTX6cF2rkgMZ4GALPl
 hwuEIL6h/NAnXw5U5PTqjhWk8KtGZ9BUXbkhR1KoAF5GzHIK0zIm4ShT4M2PEyEWQJ
 Dj5oj3LOHi2Fxys+85ispQPe9o7YJViTMf43Tr8I=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.53.77]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MQNjQ-1hDnXc01IC-00Toeg for
 <cocci@systeme.lip6.fr>; Wed, 24 Apr 2019 08:26:04 +0200
From: Markus Elfring <Markus.Elfring@web.de>
To: Coccinelle <cocci@systeme.lip6.fr>
References: <bed744fe-5c5c-cf28-f8b2-40a487709010@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <0ce0ec2b-e3df-bb0e-ee75-066f5ff71154@web.de>
Date: Wed, 24 Apr 2019 08:25:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <bed744fe-5c5c-cf28-f8b2-40a487709010@web.de>
Content-Language: en-GB
X-Provags-ID: V03:K1:r27kqL78fWKxOpVUzLk6KVfXzBgADc7rrAFwJBXr6evlaxlXT2i
 nXwSNcm90oUcn1vtI0r2aLPrSJ7iOkQN95qd8uUoSjhrLhkSoHyB8xMgHrLyrkPjPYBlyyz
 FZ2GiaR5BThIJi3FXx6zkwUeAL0pxjME1fLZX4oWHgJ5Ou72KkKCMa4SisTj49YDtxq/tUm
 0dinogGGo7UyIahfYYlXw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SbYpQLhsoss=:+Y973IihHZcp5b7zWjF4gH
 q9KUMggyp6GdeYfAnOUDbUVEL2DgJeH2KC2IfSqU51kFdNLrDuCzjA2/RraNl0ZPsbYThMLKm
 vHxktXz/ATvIfmsc77YgJjdElBgxPn2BMwPZoKYsBzXXY6qktHXnWRH0xjuswgzy/sH4Y+DkI
 7dJumAj1yYxGuzgeNGPkBVVq8Xw1kq0RkM7rPgCfJ2YjFYjCaDmxFnipDR5aQcE1MDJ2EzhRc
 AmHYejnK9Hx14ZiYW/jdI9SHUquacjMhstODSz+aJszmv6aZaA5K/mb4dUZZRwfrU6hkGnKbd
 hlUxyuJAMoVltPpgeB7kHDRVgAgoWA7Zi+gXScZAsvMYDjhRnvlbyoKLiyWXieObtBZaQUX4J
 4jzqahaGCWWmYBVaCDqdzCbwdfhVWkeaFNKZVaUvZc0Ubodo5C9jpGUHZeD2oj2yAMH5hKYWK
 o3n1JBEIRN8kTJLpnVO9Vsd0771Me0IHmdXHEJn7O66j1WCVqu7r21QbR6VOYhQRNZA+fb4Gt
 Yv9W3DUfT1JFv8sI8fKp5aIv/H6sKWSaooTc2J+Wlhps+Bh+dpqscuHxDl0Wo6lU7R0nFWF5v
 /Gb/3pAIT6Y8Kxt4Ejrs+VC7m0dgqwE8mY7Ucc9UxglJzIoSJhvnRsS9bj2kgcB4uSltk81zn
 8jCtGug2wB2rPqLGrhZmyL/xIL3uUfkELR8kKt8LI2hticZVvAykOEbct/TuvDW2ddFsGnVG9
 NIHSSKJDmmogJoo/CjGXWfYNYcqyJhCR7CNuHAl1IHTGYS3o4I99bwX7RkQWLJNUl9pMWWots
 Wcdu81HEUEqW15D8nMk+CFRjOkBnFh1jpyMJ0cbaTBN7s+s95lSjTGsl0Up5X9GUofPzvmg8h
 +meYb+yhoFcnCvhdo+y5kyMOaEbQ1Jge9uoAfmcCPhdgmujuTRJNXm7vrqHXK05AF8I0aZ215
 S9Na+U8rdYQ==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 24 Apr 2019 08:26:06 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 24 Apr 2019 08:26:04 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Rejecting parallel execution of SmPL scripts
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

SGVsbG8sCgpUaGUgQ29jY2luZWxsZSBzb2Z0d2FyZSBzdXBwb3J0cyBtdWx0aS1wcm9jZXNzaW5n
IChwYXJhbWV0ZXIg4oCcLS1qb2Jz4oCdKQpmb3IgYSB3aGlsZS4gSXQgd291bGQgYmUgb2NjYXNp
b25hbGx5IHVzZWZ1bCB0byBzaGFyZSBkYXRhIGJldHdlZW4gc3RhcnRlZAooYmFja2dyb3VuZCkg
cHJvY2Vzc2VzIGZvciBzcGVjaWZpYyBhbmFseXNpcyB0YXNrcy4KU3VjaCBwYXJhbGxlbCBkYXRh
IGNvbGxlY3Rpb24gd291bGQgcmVxdWlyZSBhIHNvZnR3YXJlIGRlc2lnbiB3aGljaCBpcyBzYWZl
CmZvciBkYXRhIHN5bmNocm9uaXNhdGlvbi4KClRoZSBpbmZvcm1hdGlvbiDigJxEYXRhYmFzZSBj
b25uZWN0aW9ucyBnZW5lcmFsbHkgZG8gbm90IHRyYXZlbCBhY3Jvc3MKcHJvY2VzcyBib3VuZGFy
aWVzLuKAnSBpcyBwcm92aWRlZCBieSBhIGtub3duIHNvZnR3YXJlIGRvY3VtZW50YXRpb24uCmh0
dHBzOi8vZG9jcy5zcWxhbGNoZW15Lm9yZy9lbi8xMy9jb3JlL2Nvbm5lY3Rpb25zLmh0bWwjZW5n
aW5lLWRpc3Bvc2FsCgpJdCB3YXMgZGV0ZXJtaW5lZCBvbmNlIG1vcmUgdGhlbiB0aGF0IHRyYW5z
YWN0aW9uIG1hbmFnZW1lbnQgZG9lcyBvbmx5IHdvcmsKd2l0aGluIGEgc2luZ2xlIHByb2Nlc3Mg
YnkgdGhpcyBwcm9ncmFtbWluZyBpbnRlcmZhY2Ugc28gZmFyLgpodHRwczovL2dyb3Vwcy5nb29n
bGUuY29tL2QvbXNnL3NxbGFsY2hlbXkvNS02Ty1Qd3poNEEvNXhTbnhFX3BEQUFKCgoKSSBnb3Qg
aW5mb3JtYXRpb24gbGlrZSB0aGUgZm9sbG93aW5nIChvbiAyMDE4LTA1LTEyKS4KCkBpbml0aWFs
aXplOm9jYW1sQApAQApsZXQgXyA9CiAgaWYgbm90ICghRmxhZy5wYXJtYXBfY29yZXMgPSBOb25l
KSB0aGVuIGZhaWx3aXRoICJiYWQiCgoKSXQgc2VlbXMgdGhhdCBJIGRpZCBub3QgYmVjb21lIGZh
bWlsaWFyIGVub3VnaCB3aXRoIHRoZSBwcm9ncmFtbWluZwpsYW5ndWFnZSDigJxPQ2FtbOKAnSB0
byBpbnRlZ3JhdGUgYW5vdGhlciBjaGVjayAoaW4gYSBjb252ZW5pZW50IHdheSkgZm9yCnRoZSBz
cGVjaWFsIGNhc2UgdGhhdCB0aGUgcGFyYW1ldGVyIOKAnC1qIDHigJ0gY291bGQgYmUgcGFzc2Vk
LgooUmVsYXRlZCBzeXN0ZW0gY29uc3RyYWludHMgY2FuIGJlIGFsc28gaW50ZXJlc3RpbmcuKQoK
V291bGQgeW91IGxpa2UgdG8gaGVscCBhIGJpdCBtb3JlIHRvIGFjaGlldmUgdGhlIHJlc3RyaWN0
aW9uIGZvcgpzZXJpYWwgZXhlY3V0aW9uIG9mIHNlbGVjdGVkIFNtUEwgc2NyaXB0cz8KClJlZ2Fy
ZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVt
ZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
