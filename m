Return-Path: <SRS0=OH0s=7R=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E20C433DF
	for <cocci@archiver.kernel.org>; Thu,  4 Jun 2020 15:21:22 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E944206E6
	for <cocci@archiver.kernel.org>; Thu,  4 Jun 2020 15:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="dyrZOWNU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E944206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 054FLJU9023031;
	Thu, 4 Jun 2020 17:21:19 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5BA9E7567;
	Thu,  4 Jun 2020 17:21:19 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7B28D5D47
 for <cocci@systeme.lip6.fr>; Thu,  4 Jun 2020 17:21:17 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 054FLFul024839
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 4 Jun 2020 17:21:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1591284072;
 bh=caLG19BmdI2/AnMcBvEukST94msU8DtaCn+EwD7K1C0=;
 h=X-UI-Sender-Class:From:Subject:To:Cc:Date;
 b=dyrZOWNUombdPmNyvpkL3QYQlIRpqZQZ0+oGqCWI6EaJziJo6Res9i1ivnuPKp9RW
 J1u8vLJ6AASKvy0cQspoRAOKqFqBpIYBgvh9Hq+0TB557t+r1uhJFHDdDlEtKwaPSi
 nLYj7ocYEYDwGnoQQRKpsQBUWM1A9dqkP7XqCeAQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.94.220]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MFt8s-1jmwDJ38PW-00EsCG; Thu, 04
 Jun 2020 17:21:11 +0200
From: Markus Elfring <Markus.Elfring@web.de>
To: Denis Efremov <efremov@linux.com>, Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix
 <nicolas.palix@imag.fr>,
        Coccinelle <cocci@systeme.lip6.fr>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <96653281-3812-8b44-0dd8-6e7540a26a89@web.de>
Date: Thu, 4 Jun 2020 17:20:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:ZMf8O4Xn5rAtQq3P9sIxoHJO1CdlQUWpYmMtF2VojZeExe/gcSR
 WXf6FseHTRO7D4dJ8Ox3yun/OhGjd5WqaBRiKHFARIDxTdYxnSMxkoz1ocB2bXPoaSS6TB0
 HSHKpyYQ5olhNADcQ06q6MWpYFIXJ1B4CqEvLfg0AwakyfG6njmKMyq63V59i6lu6UnVzvI
 2040+SX9/Fw/0ekxJZ3Yg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:j1xbuqnI6g4=:h9RSSV0n/H8v9/uG40pu9M
 jem+883AQumTBd27fpL68Wue7KPKEQiu3tyMjBikoUbWza1jlZrxPcbjZnV85LsuLxJ27zh7t
 EjmsWNR/ezbNFDnhLtORkja41VGvqW9f/cVrVh5u1lPbxt1Vzw3HeuA9M9BIKlm0GKfSFteqG
 HSycIoZ1t+GpB5bgDzAq+L+8Nq2clVomj0E7gQrOu50JvLoBTCuzzIazbcYhbINH4rTzFOx5l
 LO6x0zVkZ629nvVNAVRNBFZUlKHUfnYRPzcPSCctkB1KecK+QQnoqCFLjbD5ngMW+t0psmadg
 PRdqIxFgu1IhTL8qUutiWYvbjprzZAqHKRk8Cbq3xZMPxt5fTi5HUpyoCwTTShp62xov2vzPv
 j7J8axc6gZTgwX2WXX21NqZagcSDL9pE154QmPdSC743UQ2lgaI3p5JE/Mhl8AhxAISPy4hp6
 00aL1Va+3GIM5qxF/0OHlZVqyTyU/omRIrMzrAdOI3IBaEa2cxryxFvbGbxQMhyJCP12y8TMY
 Abr9RWjn1qVw74/S6QvQD/pNjOqYTtw+xNtBW+PSqdJXG5CoXXlmmlmfWcAaysT09BXhhmKcb
 sOmizOAlCB/raTwDPKrdsm8vEvYs9ChYCxPthUpggJIcaXRW7kDjE1rueppzcJOWXGgatbJZq
 Jxf4ndX3JYBOpsWIHO/kgI9sPYWUVavLsQocyXqPjC00KugjbJ2NqCztkP+bXM7RW+Ghq/NSI
 im0Ys1VaWug6kEUSmQ3fHJdBwlPzKiMuvSCHWwBgWknWltDdInXjj9YmNKj4zNYt8vxXFBMU3
 HVy/NP9HdaAP3mlw0WbmqxVZpuMjrIVjKi9J1QoNYY4MXyDpZ35vSDTOyfVXyRIIkv5eCFmXv
 OZLNDvXxNMkKhG0qnLrQ6cPcIAe+iFFH0aKi9BqMkFThRm/QUbK9NxR4GZ7rYYGKrSuvsjz1j
 sMrZqM2v06fntSze+xMxepPbvDgFh4DZltikJHsScuzYpRj8yABbR6HvXI7S5z6KNnGPEO4MD
 tDuaaIXJyFBg3xDVw0qY/RznmrHSraSrHiBA/+kevX7lbWt/GjJgVazuhJhP1QTPpC+ucCFnM
 hm7JCj5gCo6y14IOeiGAIHJpxSJGCH1F328Jp6gSRz2q490qeZxZ5UZE9o/woBHp5ysxeAGrt
 1TEzVy6zKzP+sfYmfbSm+1QkETIH+KgcsFE2bDF7PHKrnbFGCsBYuz4b763WNM9a8AsQm5Sa5
 5A0UDBqCclTlYDYmZ
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 04 Jun 2020 17:21:19 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 04 Jun 2020 17:21:16 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH] coccinelle: api: add kzfree script
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

PiBDaGVjayBmb3IgbWVtc2V0KCkgd2l0aCAwIGZvbGxvd2VkIGJ5IGtmcmVlKCkuCgpJIHN1Z2dl
c3QgdG8gc2ltcGxpZnkgdGhlIFNtUEwgY29kZSBhIGJpdCBsaWtlIHRoZSBmb2xsb3dpbmcuCgoK
PiArdmlydHVhbCBjb250ZXh0Cj4gK3ZpcnR1YWwgb3JnCj4gK3ZpcnR1YWwgcmVwb3J0Cj4gK3Zp
cnR1YWwgcGF0Y2gKCit2aXJ0dWFsIGNvbnRleHQsIG9yZywgcmVwb3J0LCBwYXRjaAoKCuKApgo+
ICtAQAo+ICsKPiArKAo+ICsqIG1lbXNldChFLCAwLCAuLi4pOwo+ICt8Cj4gKyogbWVtc2V0KEUs
ICdcMCcsIC4uLik7Cj4gKykKPiArKiBrZnJlZShFKUBwOwoKK0BACisqbWVtc2V0KEUsIDAsIC4u
Lik7Cisqa2ZyZWUoRSlAcDsKCgpIb3cgZG9lcyB0aGUgU21QTCBhc3RlcmlzayBmdW5jdGlvbmFs
aXR5IGZpdCB0byB0aGUgb3BlcmF0aW9uCm1vZGVzIOKAnG9yZ+KAnSBhbmQg4oCccmVwb3J04oCd
PwoKCj4gK0BACj4gKwo+ICsoCj4gKy0gbWVtc2V0KEUsIDAsIC4uLik7Cj4gK3wKPiArLSBtZW1z
ZXQoRSwgJ1wwJywgLi4uKTsKPiArKQo+ICstIGtmcmVlKEUpOwo+ICsrIGt6ZnJlZShFKTsKCitA
QAorLW1lbXNldChFLCAwLCAuLi4pOworLWtmcmVlCisra3pmcmVlCisgICAgICAgKEUpOwoKSSBn
b3QgdGhlIGltcHJlc3Npb24gdGhhdCB0aGUgc3BlY2lmaWNhdGlvbiBvZiBhIFNtUEwgZGlzanVu
Y3Rpb24KY291bGQgYmUgb21pdHRlZCBiZWNhdXNlIG9mIHRoZSB0ZWNobmljYWwgZGV0YWlsIHRo
YXQgdGhlIGlzb21vcnBoaXNtCuKAnHplcm9fbXVsdGlwbGVfZm9ybWF04oCdIHNob3VsZCBoYW5k
bGUgc3VjaCBhbiB1c2UgY2FzZSBhbHJlYWR5LgoKV291bGQgeW91IGxpa2UgdG8gdG9sZXJhdGUg
YW55IGV4dHJhIHNvdXJjZSBjb2RlIGJldHdlZW4gdGhlc2UgZnVuY3Rpb24gY2FsbHM/CgpSZWdh
cmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3Rl
bWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
