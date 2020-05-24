Return-Path: <SRS0=Qcbb=7G=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E4BC433E0
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 15:56:44 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D7AD20776
	for <cocci@archiver.kernel.org>; Sun, 24 May 2020 15:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="VrIjDRWU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D7AD20776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04OFufwD026000;
	Sun, 24 May 2020 17:56:41 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 60AA03DC8;
	Sun, 24 May 2020 17:56:41 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 93A0B3D0F
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 17:56:40 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04OFucFQ029577
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Sun, 24 May 2020 17:56:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1590335795;
 bh=J7dbNbiKoGze//bdCPmRarmu8Rr3KKJ5HIvkM8tQ3XI=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=VrIjDRWUfT6H4GD4Yla6VwIwknL4M0uvcsMEASvoFVxhYYFMx41jUvt2KVF9S68bF
 9QN7WX/MxZBVq8eZM/T1RzZk08ene+UIgL2Dk6jhv6bvoV0o+o2zYKKssTGM3rEi54
 y4X4LOiVTEjNa44n4zdS5PLYWPx3WSm6+V0PkcG8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.187.46]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MI5yY-1jbEZ30x8o-003vRX; Sun, 24
 May 2020 17:56:35 +0200
To: Julia Lawall <julia.lawall@inria.fr>
References: <1d595042-0940-3056-5460-bffd58782fe2@web.de>
 <alpine.DEB.2.21.2005241405010.2429@hadrien>
 <a29f1f11-c12c-6b96-0ddc-09b9790fe9af@web.de>
 <alpine.DEB.2.21.2005241501560.2429@hadrien>
 <c2f904cb-8fa0-49c7-f859-833e29ad89f9@web.de>
 <alpine.DEB.2.21.2005241710570.2429@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <2576cb45-2ca0-a369-fc24-6bcf0238e586@web.de>
Date: Sun, 24 May 2020 17:56:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2005241710570.2429@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:NB9tcQ5da3Jz/EeBxreL8bBaJizrg7Ros3yQ2JXMLgeXJtOtykS
 c7KqyVVU1K5PYOcr3lGXqB5qUzmwmr3W0y1/gVaGVgShN8WLlC4eFWJHd/IP9ijICY1aN4u
 kskve0A2ay2C3pzXH8ptqS4UVbN8b2aRY0dTDeUFXg00SWKXiKlwj0qWNHI4dfTA/8ngthm
 Dvncz/eSG6VyBKJvorAWQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8bXXP0Rz2zA=:5B9DWY0Cnxbzsa5fSC1C73
 phIuxO5KlmwG6Pj0gqDdR0WWU7chDZbwnD6WtGiYl2+n+Dv6uvleUAxNCOjfSTumnBEh4lqrx
 ToeABhtJ2HB4FNjlpgf1JFtOeZtbEsooiWxjyMfZG9ogfRKKA3N4HxH4237qZFc1r4xBaRP2K
 0X+z2drjM8usW3bEkNboZxTfF3r+Sk5sqRfwt069IbRrTPAv7yWuia2A/Fwu5jOWKV/rFgptV
 IxspB0BczPvql4oWUcmBFbFc1w+gw8e0PKkJcOmqB2ETImkigbqcND00ItMS0NHtE1i0g68Xq
 OUdabkIR2z3dRZSzLs65mZkX5JsWgl2nmx9OOMy9MWOJ7D5XGmiq/UbNPwT4Yn6DNF+kIedz7
 JlruHBcU5HHhQ6CA1PPTgf2N0+mffCfvvmXEmERqvHbDrdxVFwpHDvvIxbuSsndw5kewns3Ep
 9fIg+8KY1n2PScE19vTDZxqpuj7NWRyvkIzYhWEkEIid/aLsSzXnqyMu6GKPVBoliBsT0i2Ck
 +JTITnKsoRhsyZBu9NLoJLu1/v5/zcFjRHVEn5DKKu61HUmm4yblZjpfLQBkcrrknMJH+PbKR
 qdxN5F8xPX5+HjICep10uFsvNYpH3j279j38SeAS9iihAhMJqcxRkNehSfOF7J117KevSbcC3
 GeJqm81FBgCQOiMbHaZKB8pHNcj2YjfAaqnqYfYr3MPa1P6JaqnR5GlMe0WgVL0p2X5S2rrUP
 qTNSm0pFx8CTRZFbynQK84TGvvvivF4DBErVHHfYTOlJWGaOq3XcX7rCt5mV6NFgBIk9fEv9Q
 HdJybkXGVAnLaDVdNtajm6q/9ak0Qem3BSCmk0jVqrAL2Hz46FVCq7WQM8J4Q48GjE0mgrZ4H
 sBZVB3jyS6KV5ouEq9W38xfYSFjG6uRSYQyuxYhJzH+xSiC6azHMDPAJ9D3C2IZAPHnoPD/U9
 7s2E+KA1+PmMuwym7esztA58dLf+GCwRzgfaCIjPrhWc2s25jHKVZwIpqXfDVMNMs+WMu3wPB
 xLYYXN4D0QJfJ0s78MX5Bh5H9xhSLOqNTw3O1mnOfpOs+DCeuy0vk6+CPMMpFIgVhUcOvKCdt
 vopygkij5NiOVcjZbCJymTz/cLEX3fMaTa1gn0PtCFwi3VUXPv5DbJqJYKoLRUmHtxWjrBIT/
 ZGz3LLJCD4AhcOkdGFtGPdqj60TVt+C+aidyMEqe0yAnRYTJrGsVvsHfGe5mUQV7SsogqlI/Y
 HyvLs7hiFz+0pNQmJ
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 24 May 2020 17:56:41 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 24 May 2020 17:56:38 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Converting variable initialisations to later assignments
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

Pj4+Pj4+ICA7Cj4+Pj4+PiAgLi4uIHdoZW4gYW55Cj4+Pj4+PiAgICAgIHdoZW4gIT0gUwo+Pj4+
Pj4gKysgVjIgPSBFOwo+PiDigKYKPj4+IEkgYWxyZWFkeSBhc2tlZCBhYm92ZSB3aGF0IHlvdSBl
eHBlY3RlZCB0aGUgKysgY29kZSB0byBiZSBhdHRhY2hlZCB0by4KPj4+IEFsbCBhZGRlZCBjb2Rl
IGhhcyB0byBiZSBhdHRhY2hlZCB0byBzb21ldGhpbmcuCj4+Cj4+IENhbiB0aGUgY29ubmVjdGlv
biB0byB0aGUgZGVzaXJlZCBzb3VyY2UgY29kZSBwb3NpdGlvbiBiZSBhY2hpZXZlZCBhbHNvCj4+
IGJ5IHRoZSBhcHBsaWNhdGlvbiBvZiB0aGUgU21QTCBlbGxpcHNpcyB0b2dldGhlciB3aXRoIGNv
ZGUgZXhjbHVzaW9ucz8KPgo+IE5vLgo+Cj4+IERvZXMgdGhlIENvY2NpbmVsbGUgc29mdHdhcmUg
ZXhwZWN0IGEgbW9yZSBleHBsaWNpdCBwbGFjZSBzZWxlY3Rpb24KPj4gc28gZmFyPwo+Cj4gWWVz
LgoKQ2FuIHRoZSBjaGFuY2VzIGdyb3cgdG8gYWRqdXN0IHN1Y2ggYSBzb2Z0d2FyZSBsaW1pdGF0
aW9uIGFueWhvdz8KClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2
LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
