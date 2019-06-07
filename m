Return-Path: <SRS0=qtAw=UG=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E230C2BCA1
	for <cocci@archiver.kernel.org>; Fri,  7 Jun 2019 13:41:17 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A2E020840
	for <cocci@archiver.kernel.org>; Fri,  7 Jun 2019 13:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="kPG+hXw2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A2E020840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x57DeoWG002397;
	Fri, 7 Jun 2019 15:40:50 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0D8FE7770;
	Fri,  7 Jun 2019 15:40:50 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A9E5A776C
 for <cocci@systeme.lip6.fr>; Fri,  7 Jun 2019 15:40:47 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x57Dejsk010544;
 Fri, 7 Jun 2019 15:40:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1559914845;
 bh=bQrN9KKABz15YooMJnWtZzcIxDgH+kIluNJG5KN2LKk=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=kPG+hXw2xbBcDgNtmaTaSZSyA4AZz+htdXzfBSkncn+zbCC9YiMr55ZaIviGaIoOn
 olPaElN8Ma/wSLFKhe/XMHhSPynVbaBtLfIXfDjxeTRUtXDGWLsGqqwaxGxtUrCppd
 BwU8WjBj06w7uKRCb30pTl7oCP5ftHm/QVuWastE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.4] ([93.133.66.13]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MZDKy-1hGTEf13YC-00Kzkp; Fri, 07
 Jun 2019 15:40:45 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <69c34970-8b6d-a2a3-2e8b-0b6560f78505@metux.net>
 <6ebd6ec8-bcd0-3dac-8992-a6c8d9a14939@web.de>
 <alpine.DEB.2.20.1906061137570.7612@hadrien>
 <9745086a-cb39-b751-9cb4-faea0308e3a6@metux.net>
 <alpine.DEB.2.20.1906071430450.3692@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <c2cf2b61-990d-af7b-2228-0e79e0daa0ce@web.de>
Date: Fri, 7 Jun 2019 15:40:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1906071430450.3692@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:Y2aD7QpzUr+ReGSZ6oOPm3Ms5Uad+qYX3fr9jVSQvktn+LvizX7
 wNsvKc3LHeQ2GVvsRZGibW7cRTixsSRFTKI1N3rKDVNDovn43enp4VMve3+3jKoSZozjBZu
 OFXqFDFiYi9hRrhenTmjPkXCRqedR4JbFaeXlC2N+0+c0qSWJp9DPRRJHsMl2XJj3497CM4
 2ZqmvM09QjtzZSX3BlhFQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ut5NoJTuw8E=:Fux3DrnCQc7HpL69gGKbpt
 clpCx2UmXdF/Tzj8gOrcwXF5V0sUOjbETSmxL8kqdFj23445BJ0LgbUM0nA+OHw8eDyFHtE21
 ZL7+osBqaLP3q2cCE7HK1cK5hr6wEHp1H83sjUXJa+XBQYmbRjpoV/PmNRbPpDfvKi7T+rlrQ
 tcZL1m1oEdeHEl3nym0Rg8tDZdPXPrIBNXCDukN+8BEHN77uBnmO64P80iP60Ii+DJMWDcX2O
 DuJcLKvSw6t32C1zUQLTTesMaXjHka6cgp0fCzX1gCOq2LwfTOxwk2QbX+gvxKcbUhVNFKVzy
 HmAVn/Kv6R1DdlQTKzNEmjoVPP6Yc8qGE3oE8aepRCz3Mip3a3H6+PQAF8oQG8jplmPESrVBm
 Y8s+iwXcOjeDbDdsYxmKuEvavtB+yrHu1BkYGXLSiakmlylCMzsRqbF1ecS5d1Y+HDpXjx5Bn
 b64g/XhQ4+9WaA5AJcBBJw4YY+taR/Utg8Cs0E9moD2M5/+YnglhzKSgWZfcKUBs8margooQH
 H/i+Vj6eOkL4y9oCwVa2AuTrKCatU8CfAI+SwiVTcitdz6vwRzKeTuFZQjbJgb7xfXxMBlMCL
 2YlikPAjPlUOrtLmwiJVzSXG/WHjNfhblLZ01/VoCP3kp32F9QFvcwTHp2PvI/yXwm8Ipu9oP
 DtAhsqhVwzSAtgvuakkdxQWV9cgL88ymbrHI1FKSM1YzofgoxU10/U62xrVojyojntLjyWHax
 r/7zuvMqcVGUTaaSli8eNwC3xSznr/P+IDo0qFAV74CWE/9TdPPR0Yp1yQEchR0lXWv51m5Ot
 Zas4HigfK+Mn889g0JTdB9fyZpv3cCLWJzF7W9V3OjnxOQJ8l7tbEZM7L8z05diZ5wDm8Z7j3
 fvfFg6AR6JCZMK4QDhpPmVFKKJq/+2zgxc6ukUkTTtJCSi7V6ip6rkRk9ZVI+aIhfXVhHCJ13
 6eo897H+vk3SicsKVuSXVwYSZCka+Y86qjWvYNSUat6wJdEG8i4ck
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 07 Jun 2019 15:40:50 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 07 Jun 2019 15:40:45 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] How to replace obsolete #ifdef's?
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

PiBidXQgbm90Ogo+Cj4gQEAKPiBAQAo+Cj4gLSAjaWZkZWYgRk9PCj4gICBiYXIoKTsKPiAtICNl
bmRpZgoKVGhlIGRlbGV0aW9uIG9mIHRoZXNlIHByZXByb2Nlc3NvciBzdGF0ZW1lbnRzIGlzIG5v
dCBkaXJlY3RseSBzdXBwb3J0ZWQKaW4gdGhlIHNob3duIHdheSBieSB0aGUgQ29jY2luZWxsZSBz
b2Z0d2FyZSBhdCB0aGUgbW9tZW50LgpCdXQgSSBnb3QgYW5vdGhlciBjb2RlIHRyYW5zZm9ybWF0
aW9uIGlkZWEgd2hpY2ggd291bGQgbm90IGJlIHNvIGNvbnZlbmllbnQuCgpUaGUgc2VtYW50aWMg
cGF0Y2ggbGFuZ3VhZ2Ugc3VwcG9ydHMgdGhlIG1ldGF2YXJpYWJsZSB0eXBlIOKAnHN0YXRlbWVu
dCBsaXN04oCdCmZvciBhIHdoaWxlLgpodHRwczovL2dpdGh1Yi5jb20vY29jY2luZWxsZS9jb2Nj
aW5lbGxlL2Jsb2IvY2FkNGMwNzA1ZjllMzdmNTAxNTMxZTEzM2QzYTQ3YmM1NmVkMGNlMi9kb2Nz
L21hbnVhbC9jb2NjaV9zeW50YXgudGV4I0wyMDkKCkkgaW1hZ2luZSB0aGVuIHRoYXQgdGhlIGZ1
bmN0aW9uIGNhbGwgY2FuIGJlIOKAnGludGVudGlvbmFsbHnigJ0gZGVsZXRlZAphbmQgYWRkZWQg
YmFjayBpbiBzdWNoIGEgc2ltcGxlIFNtUEwgc2NyaXB0IGV4YW1wbGUuCgoqIFNob3VsZCBhbnkg
ZXh0cmEgQyBjb2RlIHZhbmlzaCBhZnRlciBzdWNoIGEgc3BlY2lhbCBhZGp1c3RtZW50CiAgYmVj
YXVzZSBzcGVjaWZpYyBwYXJ0cyB3ZXJlIG5vdCByZXN0b3JlZD8KCiogQ2FuIGl0IG1ha2Ugc2Vu
c2UgaGVyZSB0byBjaGFuZ2UgYSBiaXQgb2YgY29kZSBldmVuIGlmIGl0IHdhcyBvcmlnaW5hbGx5
CiAgaW50ZW5kZWQgdG8ga2VlcCBpdCB1bnRvdWNoZWQ/CgoKV2lsbCBzaW1pbGFyIHNvZnR3YXJl
IHVwZGF0ZXMgYmVjb21lIG1vcmUgY2hhbGxlbmdpbmcgZm9yIHRoZSBpbml0aWFsbHkKZGVzY3Jp
YmVkIGhhbmRsaW5nIG9mIGRlc2lnbmF0ZWQgaW5pdGlhbGlzZXJzIGZvciBrbm93biBkYXRhIHN0
cnVjdHVyZXM/CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5m
cgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
