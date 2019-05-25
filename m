Return-Path: <SRS0=mKsa=TZ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F41C07542
	for <cocci@archiver.kernel.org>; Sat, 25 May 2019 13:46:06 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08BE12133D
	for <cocci@archiver.kernel.org>; Sat, 25 May 2019 13:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="ScuVy6H6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08BE12133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4PDjq5l007945;
	Sat, 25 May 2019 15:45:52 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 66ABE7752;
	Sat, 25 May 2019 15:45:52 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3B69B774C
 for <cocci@systeme.lip6.fr>; Sat, 25 May 2019 15:45:51 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4PDjo4G001258;
 Sat, 25 May 2019 15:45:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1558791950;
 bh=oRpQvkD1rpd2D665vW8/UBZky42su7vDYQUrt+dZbAY=;
 h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
 b=ScuVy6H6iLhhRk9baA7igpY2BGLQUyzjhW0bhr83TG4nCWr4japFWjNmWjW6D84RD
 E58TRsKL6X0vXzg/l+K1r8RLocdEeGYn78QRLmNviQAweOI68S71UjD3rkr1haOwm3
 cLVcIRaaHphAhI6RkA817d3vn72iorFxiipZPGTw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.4] ([93.131.6.10]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MRUBA-1h1uKc1ZBw-00SeqM; Sat, 25
 May 2019 15:45:50 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <alpine.DEB.2.21.1905222114490.2618@hadrien>
 <81b409c6-5986-5961-5edf-843c6737d88c@web.de>
 <alpine.DEB.2.20.1905231500230.3573@hadrien>
 <b5c322d3-3162-953f-a985-53abc5064482@web.de>
 <alpine.DEB.2.21.1905251522470.2799@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <63bd01ee-ea4d-fcbe-dc07-98bc98347b1c@web.de>
Date: Sat, 25 May 2019 15:45:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1905251522470.2799@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:q5b9SzzMjuUcbwpkPhNPMGN8OSZprWtE6s3ZzpC62SE699VArId
 TkHyT+ixr/S6xIHiXzE6NXEQaIxYjnxt9r1rxHielANguFQLf1zgyyg17gSRmC6qbe/fO+V
 9kJWkbjlxB7TfuqUDl71vHNxaddhjEWzhggAkt+zMnT6q6rqVvY9exqUgQsFiApfWF6/ISR
 ZK9SQJZCRxqSBLzf2MEgg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XoLkCLcmqSY=:+oMxSaRt60BNLpXHsxtO1f
 /R3q9XnJGLKsLFeGk1BPy27TSydaT3i4XLKpda5u7S1yUl1ZbMPyKrj1egRUvQOsHu7Af+VPy
 Id2KP2TR2m+X4HX+tWYlNbN5HtJ0tBb6RgNkgJRL9X4hfSrEOHsbbTuBDfMcqVONLb1ivxpjy
 1eoZXeEfHfvE8k+b+K7a3nhhDcGHNhT6iPMjxcpeB5iYVXvNKE8CZkotS390zJcQxTjmafQ5z
 HgPFcKU8Hw7kgA0LAsqoskos8lz8VM5of1iW//Ax7QMKMKsfN3rbnliBmuxEqyIzY4CNrAYtU
 lliBzt0GyovSwEkguUZhwQKVSIddeBudaH6qxYmzVKzmVq0rXZtnPVmG8IQVL7WGTesFzWOyF
 2N0GgKZEDWVT0+0t+gFeVAYZVkwDK8aJ+f2Uo82Kmu6Y1+zX1LxyIJF6Rbeks8gdXsN+zPCVy
 Dowb5kR7FrOYRaJEbTyCp2xgeDIjx3TFVzEKF63VcNOgVWjjLwdlWqFIM0TLRsl8P/xtCEz3w
 xY0d0wkCHsrcrZrhT/+Yo0O2oxa5qM6XGTYRlox/TC1UZXUQ+kM7WWkzZ3yjwYCx5abFJleWe
 pXoA2oqTwBLFaxJjVAxpCZsM7tbl3Sm0pYZeaVKFhWzfSbeXpW1PRtJ3ZsVTAQux0HDEkWqpp
 UW8El7IB7zkK366KcH07cm2gdzcqcaTFKNBHsYh3xchIvDKI1SNmuKZh1NP1oAC9gWNGgXyNI
 PYnfAOIZWw1+vqpVLqzsd3ahKTZMy86vkDXeh0elS94HEEByv8Y4VFSuPWFUhPJmcDrAG0YHz
 hWPli68axxZ8IBLk9lxpa3VcXLWQItgE8Qqz2WmvUQKV34LP01rZ1kh0ZqcAnZgwClWe5RMcR
 DsauNZ/qN0IfbrHi+T4mRWCcj32taYGDqcazG4uqgkCgxYr64p8TFrxHGec6RCvEqy/Ahu3Px
 gXM4elCg5qzZ+G3KBn1AI+wLLj4HhQLYJpIMCQDtU5c/+UbreBG2e
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 25 May 2019 15:45:52 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 25 May 2019 15:45:50 +0200 (CEST)
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

Pj4g4oCc4oCmCj4+IGxldCAoYzFiLGMxbSxjMWEpID0gTGlzdC5oZCBjMSBpbgo+PiDigKbigJ0K
Pj4KPj4KPj4gQ2FuIHRoaXMgcHJvZ3JhbW1pbmcgYXBwcm9hY2ggcmVzdWx0IGluIHVuZGVzaXJh
YmxlIGRhdGEgZHVwbGljYXRpb24/Cj4KPiBUaGVyZSBpcyBubyBkYXRhIGR1cGxpY2F0aW9uLgoK
VGhlIGludm9sdmVkIGRhdGEgc3RydWN0dXJlcyBhcmUgdW5jbGVhciBhdCB0aGUgbW9tZW50LgoK
Cj4gTGVhcm4gYWJvdXQgcG9pbnRlcnMuCgpIb3cgbWFueSBkaWZmZXJlbnQgcG9pbnRlcnMgd2ls
bCByZWZlciB0byBlbXB0eSBzdHJpbmdzIGhlcmU/CgoKCj4+ICogV2hpY2ggdGV4dHMgd291bGQg
eW91IGV4cGVjdCBmb3IgeW91ciB2YXJpYWJsZXMg4oCc4oCmbeKAnT8KPgo+IFRoZXJlIGlzIGFu
IGV4YW1wbGU6Cj4KPiBjNGI6IC8qIGEgY29tbWVudDEgKi8KPiBjNG06IC8qaW4gYXJnbGlzdCov
Cj4gYzRhOiAvKiBhIGNvbW1lbnQyICovCgpIb3cgd291bGQgeW91IGxpa2UgdG8gaGFuZGxlIHNv
dXJjZSBjb2RlIGVsZW1lbnRzIHdpdGhvdXQKcGFyYW1ldGVyIGxpc3RzPwoKUmVnYXJkcywKTWFy
a3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2Np
IG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYu
ZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
