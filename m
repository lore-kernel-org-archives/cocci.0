Return-Path: <SRS0=N+LH=YL=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B47CA9EA0
	for <cocci@archiver.kernel.org>; Fri, 18 Oct 2019 14:20:37 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36B5C222C3
	for <cocci@archiver.kernel.org>; Fri, 18 Oct 2019 14:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="McQYKiwS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B5C222C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9IEKNhs013365;
	Fri, 18 Oct 2019 16:20:23 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2499877B8;
	Fri, 18 Oct 2019 16:20:23 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9223F77B4
 for <cocci@systeme.lip6.fr>; Fri, 18 Oct 2019 16:20:21 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9IEKLLi023060;
 Fri, 18 Oct 2019 16:20:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1571408420;
 bh=SX3gtA06s0kp3DHLDE5fyjetbXilISSCv2raQMP6ILI=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=McQYKiwSpznGm/yQCC4ZDATjG4XQmYyQ/wT3CTyBq/m1VxTzDpImVKRf6rvA+YCjl
 P9tszvYt3BdXjq3aJvlqQ4/Bm5S0JeKSty/2YJWTflGOrSiYGW8R7fkyLw+aYZnnBU
 iZvGDRBEtVeFGe0XCAhIWXuGFtuAbvGcXr+9GKBU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.164.145]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MV4xx-1iXGxt2drR-00YP33; Fri, 18
 Oct 2019 16:20:20 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <24130ec6-4a20-7be4-755f-a6dfffcb6c97@web.de>
 <alpine.DEB.2.21.1910101509370.2305@hadrien>
 <45be389f-23f9-cbff-fa5f-8ad111124f94@web.de>
 <alpine.DEB.2.21.1910181530460.3697@hadrien>
 <4df6f184-fcc0-343d-2460-0b2dee55fd0a@web.de>
 <alpine.DEB.2.21.1910181548450.3697@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <28630366-9e3a-07ef-8ccd-a42c35a3a9cc@web.de>
Date: Fri, 18 Oct 2019 16:20:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910181548450.3697@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:XbBylBlnul5WBCU71vx+kRc+xnZyWzYPi3G+NWyguv3VPQtr8jC
 maUr9P/TV9eo1pgSrz8G3IAttZEXpYbJWtJ5ifzdaM2fb/Lbbv9LOS189b8TTnu68V1Ml9Y
 ER24KRp2CG7PxGnZUAGBjGhtJvl+4kvweC3rB6OMjjCQV1i/ETHwTCyJggMyZKD4qub/xu/
 L/+Z6YWff7X7BLA/kCs/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:30racHjagF0=:1xQoUXIUNgxxOR75vja8hM
 +c+mDKQq+XPwEl4cMTjGKvKCq4SVqBnDqFhGIFbHeOkEOkyHhSPRlmH3iH6UsMk76LvsdmsWr
 hn3bv3mdefPF61b3vB0vj8RudVFpbsjGaQud8XrvAS4zk8PuFsQOS9eUAS7XfJlTHAKDTNMll
 128r/JbISgcxpg8ox7jrhXz8dArQeMibTelYLv9c5PbjB+TlKIGNIu6sqTpiOJOF6/TY9FFdS
 IY6uHD0cVmaLH+FZZ0HGSdTlmMjdsgrzDx2OyawuN8teQ3ITPCks/74LF1YzcQUE8QPv5wRXs
 25kaaxjbvFVS4DtjDNt9yfQ/y4C5XLP4BtPgGwIpI3WTwqVDSSp3RB9nGMbemVThuN5IYubz4
 yM3E/8L2u0L0BQGeSsy3GE29MLCcmsfZ3plaxD/sPDZGTdXOKpQYy+8UPk1cVsIbXM2z4MBwi
 +qaMcbDqrzWNurAhgA+Gw/iylaY3gun+ZVgBmOQOgBmwpbSh9N2rOOPRqvMYkpznPv+ptrM2D
 J7caQ9yLgPe6+LYYdhzs+1wtR2pTgM2Oq9+Y5aI14mUWoXR/ErXDgMmtlrsCPsuUus3saRbc2
 IJ9k8mN0J+gx4mFbeCjW6TSlhkodUzkIt6DpBGuoHbXdRDKHxfoM1mSHitQpzo0yjqccVkJ8I
 13Kgrj7cVxiyNpjXnJxpausNM1WTtqHjUT6Gr/h/TqvCQik9ttejZKVJyVhvim2IThA1p0yY8
 6MihGUOxtdej/8YXfPGbRp1rywKmiq5kTFkmCsU5RRiK1kxycyGWtWerB02PanOiNHgj3//dz
 rSBegPLMIsbNqITXpaIrHwz4gBKs8gJMQ6gQvoK40T/GZuhoOy8vmrTxVqkScEmWA3rc0VEzn
 58yKzy8OO9KYs+gRg7jsnQQyBD8dG9FbWGr1wX+GA8owar7B9RaCoz7kAhA2oPw8KY1l7+aMR
 6rVzDPR8MzK77xWYQuSezKThtNGWDTcx/1FuFxH3VEjGxXB+BZWbCV6W5uk5ULuw7OsHwBIq4
 bFLRIK8+s9HEZmDB2tJW7dhEWC5kItulci1PhQ9Zm5K/h3y+gd1TouhVWyJv8WBVBitCyVBG0
 MOQ3Ca19Gk2mJA2IuqrCWDukLidAAXBhx5ZsUJQDvYROReUXHaPt9K8Nyrf8bG6MbOmO8umgN
 YMCRvr2bKD4ufJtfyWGTXq7kvxjvz7UOMotqrnH6uYStb/AKILXyK6hKfxuKmaNc1DFZq6Rqz
 EBqZCKZYGKfKe+ECbtB0twTOJAsv5qRAzffj0ILjAkz5n9Qqc5lydguhFOHw=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 18 Oct 2019 16:20:23 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 18 Oct 2019 16:20:21 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Software analysis with SmPL around unchecked pointer
 function calls
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

PiBJbiBpbnQgKmk7IHRoZXJlIGlzIG5vIHBvaW50ZXIgZGVyZWZlcmVuY2UuCgpUaGFua3MgZm9y
IHRoaXMgY2xhcmlmaWNhdGlvbi4KClRoZSBzZW1hbnRpYyBwYXRjaCBsYW5ndWFnZSBzeW50YXgg
bmVlZHMgYSBkaWZmZXJlbnQgaW50ZXJwcmV0YXRpb24Kb2YgdGhlIGRlc2lyZWQgbWVhbmluZy4K
SG93IGRvIHlvdSB0aGluayBhYm91dCB0byBhZGQgdGhlIG1lbnRpb25lZCBkZXRhaWwgdG8gdGhl
IFNtUEwgbWFudWFsPwoKCj4gWSBzaG91bGQgbWF0Y2ggYSBwb2ludGVyLXR5cGVkIGV4cHJlc3Np
b24uCgpUaGlzIHZpZXcgaXMgYXBwcm9wcmlhdGUuCgpCdXQgSSB3b3VsZCBsaWtlIHRvIHBvaW50
IGFuIG90aGVyIGRhdGEgdHlwZSBkaXN0aW5jdGlvbiBvdXQKZm9yIHRoZSBjYWxsZWQgZnVuY3Rp
b24uClRodXMgSSBpbWFnaW5lIHRoYXQgdGhlIGZvbGxvd2luZyBTbVBMIHNjcmlwdCB2YXJpYW50
IHdvdWxkIGJlIGluY29tcGxldGUuCgpAZGlzcGxheUAKZXhwcmVzc2lvbiogeCwgeTsKQEAKKnkg
PSAoeCkoLi4uKTsKIC4uLiB3aGVuICE9IHkKCgpUaGUgbWV0YXZhcmlhYmxlIOKAnHjigJ0gY2Fu
IGJlIHJlc3RyaWN0ZWQgdG8gYSBwb2ludGVyIGV4cHJlc3Npb24uCkJ1dCBkb2VzIHN1Y2ggc3Bl
Y2lmaWNhdGlvbiBlbnN1cmUgYWxzbyB0aGF0IHRoZSBmdW5jdGlvbiBwb2ludGVyIGlzIGNvbm5l
Y3RlZAp3aXRoIGEgcG9pbnRlciByZXR1cm4gdHlwZT8KClJlZ2FyZHMsCk1hcmt1cwpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxp
c3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4v
bGlzdGluZm8vY29jY2kK
