Return-Path: <SRS0=ZWNV=TY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54A7C072B5
	for <cocci@archiver.kernel.org>; Fri, 24 May 2019 06:45:46 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FB0620868
	for <cocci@archiver.kernel.org>; Fri, 24 May 2019 06:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="IP4bLv/q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FB0620868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4O6jXMm016436;
	Fri, 24 May 2019 08:45:34 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 9173F7752;
	Fri, 24 May 2019 08:45:33 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0264B7747
 for <cocci@systeme.lip6.fr>; Fri, 24 May 2019 08:45:31 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4O6jVAb007426;
 Fri, 24 May 2019 08:45:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1558680330;
 bh=klTVDaFzpf+hEk6FGSrBA3nERUS+tvneqxT6yIeTjP0=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=IP4bLv/q957GAEIOlUg9SueQq1w4LxVp3FnY81lijirX3JrX59WKn8Dv/Y+zjVus3
 N1Abi3lsKX88uHIfT+hVsVkuzW/mC2OS8ZmewlkiDoBpJHwiPO61Gy6uzSTk3ED+Q4
 QtDPWE9C/9IhZRKlW3RI5Uqw9dd0MPhwUOEnv1X4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.4] ([78.48.148.166]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MQvgI-1h4KRQ02Yg-00UJck; Fri, 24
 May 2019 08:45:30 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <alpine.DEB.2.21.1905222114490.2618@hadrien>
 <81b409c6-5986-5961-5edf-843c6737d88c@web.de>
 <alpine.DEB.2.20.1905231500230.3573@hadrien>
 <3a79c8f5-9483-397a-eb98-adeb40634fe8@web.de>
 <alpine.DEB.2.20.1905231659010.3573@hadrien>
 <215d5cf7-b44c-8924-d049-e2a6e579f138@web.de>
 <alpine.DEB.2.21.1905240821260.2689@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <ef11ac29-3360-d2b9-c453-bb70dad0d43d@web.de>
Date: Fri, 24 May 2019 08:45:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1905240821260.2689@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:9MALw4W/oK0jtgrqocpWyAHReRzU48wTtc5AA543IkkuBXGw7fQ
 ktiU0un8bVQtp3Zhpr3Jkeq438w1IRsN76kjLihJd3KaxgD5HDtkYt49V19Um+gtIrUC+Pb
 Qx695moqcEXrptKnwLOB0qYFxS2Jc7MEALL82UkelEiKoFAPo/A4LuUpZry1yY5PTYBij/F
 7/8XfIr8u/p5+uDVbnQRw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Zmnqw2r6Th4=:FDO0b5LsRoSEHlWAjeeW5t
 YDmLgVXUvg9S35C64+AMDZX4UTxo2XDXeMbcuugReAhLYyfANAfXAmbDZCt/ro8YjAT/Xh6hx
 84EuBhBtUAS0HY5g2zXNqU/daTDgaezloEZz9SL0nEMJd58N1gsf/4kbj6cuhq6KApA7VIlj4
 u/VSewxWFbKpqj4hfIYxSwn8RGn+xsbcA31jgfVRnTBLynZigvCm+7Lgr5R7OxQ5Te4urMPw7
 cGx/ySgEXegkk4Y6md7Ww/w7/iWGxmvet71rxlTadMo4eN+cxa/UzVLeva4jxZQ9nwCfqOwhQ
 oCQk5cyaadQzhQJpwuE4D1dxMSib7/EAlxm19vq08JV2vpo7eMJHuUl6a3Go1AkMW/1RrvKWG
 XAc6PVne73b0ZzZR/QmTCAGiyOd2n8e/04daFGExpOmoOkoDEZ/PSpOawkWxeYUO1ZZ0i7wZc
 sxYwvIqa4YDCoypQoqa+kU8SvHrQjb8DEFNT6pGEUXhvS7ZUYqIoJ/Xy6mlOrROJ6r9wJm7lo
 +JlaZ/WjYydJhnMMMrht6JZxEI5kP6NRy+3kcPaDiIpEFUdfC77+ePTeN+X4/rwkJyEeWG3yb
 gyUmGlAYT1BRmNU/BI1BPM/2M4HtYFkRplSKhLvJLFyu7PgWqeYDV4CTMLIa2UurTS7EkT+TJ
 BEgbXvpqW7BtdNJo2zGfuLcHlDNbwgi/CHMwEbais+wxu6kcGK52BVCtNOvNYKWwICEoKHXPq
 3FN4zX5Nc7O1tzDMit/wVFV9o7cWOG/vxJqDc9+7AhC8ZbmtHRDEtTZeAd1zGEPzcLBbKtHZ0
 arjAObh0o/A75y/6DG+43YxKPBtpTGSIMPqFF2Rwd2zECJiXjH7xluMxscuDbSDcG8bCvZ+za
 HlXnEYLTdjMxqR3jQh66ETOl5Ktcvu450Nf6Pv2xpabLbqlUELDTaR7b+a7KCSKqPO6iJeWzg
 DyB5ubUMV8RWU4Wj3tpRiR32fnAG39Qar/UoVFK6UktEOnjPpqSp4
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 24 May 2019 08:45:34 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 24 May 2019 08:45:31 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Checking configuration challenges around OCaml usage
	for SmPL
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

Pj4gSG93IHdpbGwgdGhlIGZvbGxvd2luZyBzb2Z0d2FyZSBzaXR1YXRpb24gYmUgcmVzb2x2ZWQ/
Cj4KPiBtYWtlIGRpc3RjbGVhbgo+IC4vYXV0b2dlbgo+IC4vY29uZmlndXJlCj4gbWFrZQoKVGhl
c2UgY29tbWFuZHMgd2VyZSBleGVjdXRlZCBhbHNvIG9uIG15IHN5c3RlbSB5ZXN0ZXJkYXkuCgoK
PiBUaGVyZSBpcyBubyBkZXBlbmRlbmN5IG9uIGFueSBwYXJ0aWN1bGFyIHN5c3RlbSBjb21waWxl
ciB2ZXJzaW9uLgoKV2h5IGlzIHRoZSBwcm9ncmFtIOKAnG9jYW1sYy5vcHTigJ0gbG9va2luZyBm
b3IgdGhlIGZpbGUg4oCcL3Vzci9saWI2NC9vY2FtbC9saXN0LmNtaeKAnQppbnN0ZWFkIG9mIHVz
aW5nIHRoZSBzZWxlY3RlZCB2YXJpYW50IOKAnH4vLm9wYW0vNC4wNy4xL2xpYi9vY2FtbC9zdGRs
aWJfX2xpc3QuY21p4oCdPwoKCj4gWW91IGp1c3Qgc2VlbSB0byBoYXZlIGNvbXBpbGVkIHNvbWUg
b2YgeW91ciBjb2RlLCB0aGVuIHVwZ3JhZGVkIHlvdXIgb2NhbWwsCj4gdGhlbiB0cmllZCB0byBj
b21waWxlIHRoZSByZXN0LgoKSSBmaW5kIHRoaXMgdmlldyBpbmFwcHJvcHJpYXRlIHdoZW4gdGhl
IGNvbW1hbmQg4oCcb3BhbSBjb25maWcgZXhlYyAtLXN3aXRjaCA0LjA3LjHigJ0Kc2hvdWxkIGJl
IHJlbGV2YW50IGhlcmUuCgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUu
bGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
