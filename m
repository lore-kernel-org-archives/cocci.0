Return-Path: <SRS0=lElT=X5=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144DEC4360C
	for <cocci@archiver.kernel.org>; Fri,  4 Oct 2019 19:38:13 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D11A21D81
	for <cocci@archiver.kernel.org>; Fri,  4 Oct 2019 19:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=mykolab.com header.i=@mykolab.com header.b="OocEGg8l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D11A21D81
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mykolab.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x94JbsvS029757;
	Fri, 4 Oct 2019 21:37:54 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0A16E77BE;
	Fri,  4 Oct 2019 21:37:54 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 6971177B4
 for <cocci@systeme.lip6.fr>; Fri,  4 Oct 2019 21:37:52 +0200 (CEST)
Received: from mx.kolabnow.com (mx.kolabnow.com [95.128.36.40])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x94JbowX001488
 for <cocci@systeme.lip6.fr>; Fri, 4 Oct 2019 21:37:50 +0200 (CEST)
Received: from localhost (unknown [127.0.0.1])
 by ext-mx-out002.mykolab.com (Postfix) with ESMTP id 1CFFFDDE;
 Fri,  4 Oct 2019 21:37:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mykolab.com; h=
 content-transfer-encoding:content-language:content-type
 :content-type:in-reply-to:mime-version:date:date:message-id:from
 :from:references:subject:subject:received:received:received; s=
 dkim20160331; t=1570217869; x=1572032270; bh=FQbjz8bleLUTAzWzQQB
 mNSGUmIsvw0v+99XvWuTPnmY=; b=OocEGg8lxOnhhBEjtXkZQ2jfu9KxIFydosG
 H5XIOSnjQnUZGqduPvlmbERRqTTLcXSAhCKQKjeksh9dFzkA9GS66bdlLuaYoeMW
 Der71IDZ+Fp9fDDXdu6QxTgl4CUCO+GWg8mTW4eb3e06LHlUhzLDk+AmPouYMFKQ
 KJqacxp4i8B0JqEsxjxHg1J+r9Ig2umsaAClmTLMfPlu223Bt0f2HkEVb03ipjYA
 DMhDVOEbrdySwfqvNEsJPRn9CX9GQOg2I7SiNeR2QNl8nyzu4TgVaqRIZbN/qwbB
 /bn0KKixlnINtiujOPeS/Y2GqeYmspNZ8/u9K37vwp0K47h8EjySQA8Km9xsDf2q
 hsIG4p2vq4HzKlYFVRT37nCvc3mAJurT5rXsk0+2EEMhT1i1bokJ2QggCO0/qqRT
 a9VjGxnkz6DPhQgT5EjODIM4KjzcBUv6hoQHwmAPONOk08jli/b9Pcjc73oeoCh/
 SAjMInGXZxiQVQ7a7VGNezRAtAJ7axq8ehiV7Kaoj+nKaJA19TP/H8C3Y1RGRbDV
 ijXtIG/0WMceVej/bqEqkvCkw2tMZ8zWehafx79HIm/VBUNLKmrZxnNUPFjx4cxw
 UurEOtyu8qbTNT1LbGuTegnsk3PBMUtdhLS57PQ2acZfpl0waPMFCr9guOvtT1pB
 /FcoeDQU=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
 by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tN2e95pwkye6; Fri,  4 Oct 2019 21:37:49 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
 by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id E72C84F7;
 Fri,  4 Oct 2019 21:37:48 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
 by int-mx003.mykolab.com (Postfix) with ESMTPS id A02D08A5;
 Fri,  4 Oct 2019 21:37:48 +0200 (CEST)
To: Markus Elfring <Markus.Elfring@web.de>
References: <c0801ee0-c227-5d9d-50ff-3ad872621808@mykolab.com>
 <c9a64f4a-30fd-7c99-bd29-edbda0b30337@web.de>
From: Michael Stefaniuc <mstefani@mykolab.com>
Autocrypt: addr=mstefani@mykolab.com; prefer-encrypt=mutual; keydata=
 mQGiBEBzHYsRBACu8uw/xP4j/RYT/HBhw46jwNx9tJaHUADksKmmNRMVnpAX768sVFOMz+rO
 4Zfx0pGoaMrfw5yCh3v+fwh7hh8mMutZ6HmtOZho10hd/Kp+1JSpFDVP5b92ATr2Yexd+SXz
 jSbCDGLjGGpPWEEtNzu4UhdRwIIymdQqVTx6aCvscwCgvsbD+M9kmUWdToQI/H6QYsNBmukD
 /iPmBemMiw69xBzH+pLCpfdlnundj/ZXXdUO86Br6reg9q5m5Vv4ClyTHMIXcd6Dnm43S2Z9
 OvCDwtBMm+Hu5H89/B6E0NSyknn7CMciD3bLklFGQl4isyF+6Gnd5MTr1cM1Pm0EtYmCAdhK
 +h9SW2NWnPQOr2b3KRrn6rFRumTqA/0YDv8IvVRQZjv9DqK4YP7/va7GGUJHS44ksPyHuQXI
 gZVvHgE5ntSjBeUULoTk6vY55JTdgj3w2BdW9zvjUD9O7kDCf/sx74YvInw3bHsTDo4C7mr3
 QPWIVHKF63dElZwTNL+W0pzwDi6nBnu6RGpiQgI6gktIE13ySF1HjoKAjbQ1TWljaGFlbCBT
 dGVmYW5pdWMgKGVuYyBwd2Qga2V5KSA8bXN0ZWZhbmlAcmVkaGF0LmNvbT6IXwQTEQIAHwQL
 BwMCAxUCAwMWAgECHgECF4AFAlNET0gFCRw3Mz0ACgkQ0ei8kcpE1VFHMgCgtPjwlA34jJ2F
 a1TPymfo6IGo9y4Anj05IAwUKKSPJez3LojfovAYMEry
Message-ID: <05519e65-6b3e-989b-066e-8239a4539151@mykolab.com>
Date: Fri, 4 Oct 2019 21:37:37 +0200
MIME-Version: 1.0
In-Reply-To: <c9a64f4a-30fd-7c99-bd29-edbda0b30337@web.de>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 04 Oct 2019 21:37:54 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 04 Oct 2019 21:37:50 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Missing support in SmPL for wide char character
 constants and string literals
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

T24gMTAvMy8xOSAxMDoxNyBBTSwgTWFya3VzIEVsZnJpbmcgd3JvdGU6Cj4+IEEgdGVzdCBjYXNl
IGlzIGF0dGFjaGVkIGFzIGEgcGF0Y2ggZm9yIHRoZSBjb2NjaW5lbGxlIHRlc3RzLgo+IAo+ICog
Q2FuIHRoZSBzcGVjaWZpY2F0aW9uIOKAnCNpbmNsdWRlIDx3Y2hhci5oPuKAnSBiZWNvbWUgcmVs
ZXZhbnQgZm9yCj4gICB5b3VyIHNvdXJjZSBjb2RlIGV4YW1wbGU/CkRpZCB5b3UgdHJ5IGl0IG91
dCB5b3Vyc2VsZj8KCj4gICBodHRwczovL2VuLmNwcHJlZmVyZW5jZS5jb20vdy9jL3N0cmluZy9t
dWx0aWJ5dGUjVHlwZXMKWWVzLCB0aGF0IHNheXMgdGhhdCB0aGUgY2hhcjE2X3QgYW5kIGNoYXIz
Ml90IGFyZSBkZWZpbmVkIGluIHVjaGFyLmguCgoKYnllCiAgICAgbWljaGFlbApfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QK
Q29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlz
dGluZm8vY29jY2kK
