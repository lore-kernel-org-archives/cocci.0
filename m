Return-Path: <SRS0=lD/F=7O=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5099BC433DF
	for <cocci@archiver.kernel.org>; Mon,  1 Jun 2020 06:24:56 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A83BC2074B
	for <cocci@archiver.kernel.org>; Mon,  1 Jun 2020 06:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="ns58LOtM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A83BC2074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0516OoVM016982;
	Mon, 1 Jun 2020 08:24:51 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DC3A67567;
	Mon,  1 Jun 2020 08:24:50 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9380C5D47
 for <cocci@systeme.lip6.fr>; Mon,  1 Jun 2020 08:24:49 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0516OmW6004213
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 1 Jun 2020 08:24:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1590992682;
 bh=Ak+Px/5HEJXfJ/lE5xEC2iR5TdWHacf3Il39+e8DwxA=;
 h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
 b=ns58LOtMMf0kPD+Z0uPPvOG377CXZoE2ECVLxXzPY/dezZdiCxglPto/yMWV/YtYK
 eh9AZdu0mFnvr9aMneoo28E1/RfCbAYInZ2ig/I6n8QMrcz8nXK9h5GRyV/XzqrMFM
 oGLiGnK/4acFmImCR9qFsQjKKgxFgBoBbetZ4bHo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.133.32]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M5Qq9-1jeoOd2m9d-001SDi; Mon, 01
 Jun 2020 08:24:42 +0200
To: Denis Efremov <efremov@linux.com>, Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix
 <nicolas.palix@imag.fr>,
        Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <273990e2-f289-905f-2930-725540857c67@web.de>
Date: Mon, 1 Jun 2020 08:24:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:uJXpoaBZnAHhSbVc2pcAmpLqH94Icrl3JMRWVPulxEGURZA7JvP
 ARk6ALy5ZHu6wHdmgdEAC1YTSVGzMocVJxzZoZui6sP1JM3XL4FJ4tAxA7kbF4F+SvqZ1CB
 xZQWzt7aOjvtEZmEVeoW54vPdt7dWUb1KwWduKJ2tQG3UcV8pddy4/w0B+NFI181wDbEfRm
 JNJ/KWzi1DsQTugX67W5Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oNIbB36nRgg=:XyUYnNoD3lg09w5Q75R3MQ
 TjlvNz/l+/FzGe9ZSjAqp6BdBFJ23RCMgsXDuDEZqwwIaYQRYGzijR+BjYMLFgFoI7982Lpa8
 DWV0wH9EQAvPDxgZdaPGbYdhYjXenbavnVy3KpXDFasVTfM9Fm92XnPJxqxu18Gyn/5hzhGqD
 lTC/pmaItVaMBCUZBuFqXKoQtRXnTfSr+kMvTTNVHmZg++PoUGw6aL35oYRGP3vLKyLi8HXLV
 Fot4XGvjf2HPJ/Sh/cLUvjuD7yJIXUsva57+BvG1Dx+esNHu/Sf8gpYbg1NhdQxBLWgDt/T4c
 61+13amjCTsEpDOoU3OxRlAWzHbpJniopoh8T4EFiMVQBCAwFH+ouOKBYYujYTnvemVpzKLVH
 M/Rea+MSIC5yWlvj05Jzfd2u75Q2xQpC9lM/WmC7Js7D48pg0i79RXRl1k0KtPQKXM8S8WtYU
 cpbm6EXU9Tij6I34E3fHRRZW/P1N2fLY7QjGDP7ELQM9Uz8ETuqV8TxnVTPw6yhSQd3cvs9VK
 eGRuvH6B9tpBZYQ4ASN/j+00T6/lrr+o2Ki6n2pBqhKPFwvqOZAHLMQqOzYTHyxIi2lMCPz5h
 QBR+7TDAjDXbZCpCbPl2qcj3XpmPCf0rUudj6FDtd6IAldyjrvSIZZs2kPnvy2b6IdqDA22NX
 CEMsV2u3rA5tX2pOyk9CrEKUdeHbrnkNVqpmyks/SNstFtBTSBW1RsN8gEMDCPnLfKDoDPvYv
 VbE+D8DWvdt0qHtGkzmB0YVSvOnFMUZuswbxYHEFU8l9DXJhzp80Za+YwMgWcoe0NzBQ4ykIj
 ZSeA7Fxm5qn7rG0rETdtePuFCBxp7HtoAN1LYWMupU5u0p4lCnBUj2j8IHPwhSjxcAUJrKzg/
 Z1Kc28brs5JY4HL9eo0TJZEYZXZlSOKplTxQ60NliENEF9n5CnSH6Lo9H9D+gqMhhmz2X9HSY
 0fO5DMsK8tuyT4fxNo67vYMKUpghWXCiLbZ7pAohHwLU2YGueJMmUCDOpCDIg5abOW/HC0/29
 OsgyJfGmDa452K5Ih3qandj497eWr6Y8tWd+hz6sLV47rK+H0hp4K4POcKophHP43XBOUkO0J
 rR502pop9wagnB48Kv8/E99kuFzhTwBEU6oRMx8YzDYPVeCe8azReHGGRP5On9s8tFnyCoA2u
 U7m0LiAK+Hqy8ub56xfo509HQL65HwaZ+HBYcdByY2hjPUtxJBXXr5rgCQUrBGaiVV04i0zwQ
 c+vJNlo9SbSxahxc5
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 01 Jun 2020 08:24:52 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 01 Jun 2020 08:24:48 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH 2/2] Coccinelle: extend memdup_user rule with
 vmemdup_user()
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

PiArQHJ2IGRlcGVuZHMgb24gIXBhdGNoQAo+ICtleHByZXNzaW9uIGZyb20sdG8sc2l6ZTsKPiAr
cG9zaXRpb24gcDsKPiArc3RhdGVtZW50IFMxLFMyOwo+ICtAQAo+ICsKPiArKiAgdG8gPSBcKGt2
bWFsbG9jQHBcfGt2emFsbG9jQHBcKShzaXplLFwoR0ZQX0tFUk5FTFx8R0ZQX1VTRVJcKSk7Cj4g
KyAgIGlmICh0bz09TlVMTCB8fCAuLi4pIFMxCj4gKyAgIGlmIChjb3B5X2Zyb21fdXNlcih0bywg
ZnJvbSwgc2l6ZSkgIT0gMCkKPiArICAgUzIKCkhvdyBkb2VzIHRoZSBTbVBMIGFzdGVyaXNrIGZ1
bmN0aW9uYWxpdHkgZml0IHRvIHRoZSBvcGVyYXRpb24KbW9kZXMg4oCcb3Jn4oCdIGFuZCDigJxy
ZXBvcnTigJ0/CgoKPiArQHNjcmlwdDpweXRob24gZGVwZW5kcyBvbiBvcmcgJiYgckAKCkkgZmlu
ZCB0aGUgbW9kaWZpY2F0aW9uIG9mIFNtUEwgcnVsZSBkZXBlbmRlbmNpZXMgYWxzbyBpbnRlcmVz
dGluZy4KQXJlIHRoZXNlIHNwZWNpZmljYXRpb25zIHJlYWxseSByZXF1aXJlZD8KClJlZ2FyZHMs
Ck1hcmt1cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpD
b2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5s
aXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
