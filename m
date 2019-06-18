Return-Path: <SRS0=bRnq=UR=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5C0C31E51
	for <cocci@archiver.kernel.org>; Tue, 18 Jun 2019 08:10:56 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 341852147A
	for <cocci@archiver.kernel.org>; Tue, 18 Jun 2019 08:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="QrECzH4V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 341852147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5I8Agmi004579;
	Tue, 18 Jun 2019 10:10:42 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8301D7779;
	Tue, 18 Jun 2019 10:10:42 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B65C27767
 for <cocci@systeme.lip6.fr>; Tue, 18 Jun 2019 10:10:40 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5I8AexA013732;
 Tue, 18 Jun 2019 10:10:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1560845436;
 bh=luV6ng6R5qVzhKd1r4Ri/NWqzzI0jCOF2KXvd5TbztA=;
 h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
 b=QrECzH4VHkchti0Jx6ZsxdDG8bqRYYnqwlTEatjL/gveQaxOSpW2lDhuth7e/CHT8
 yyALkJWkQ5ULbVxjuHqGmQ/3o1ozgK/dBzh+BqNooLuLsGYIeL2esR56LHvMCLTo2j
 JboSsUP0Y2OT6/JM1ncLFwzA5cfOaKu0vrmFqXfE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.86.175]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Mg7Vd-1i0ZKg3NbR-00NUvb; Tue, 18
 Jun 2019 10:10:35 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <f9e28910-d42b-cdea-31f4-1b084db33023@web.de>
 <alpine.DEB.2.21.1906162214390.2537@hadrien>
 <bbf7e602-0a78-9595-31b1-b4dc70195df2@web.de>
 <alpine.DEB.2.21.1906170747030.2965@hadrien>
 <20258ea9-f69b-a0c2-01ed-e3ee8681bdf0@web.de>
 <alpine.DEB.2.21.1906170807290.2965@hadrien>
 <f66261cf-b6d1-5b2c-7756-a17585cc0ce6@web.de>
 <alpine.DEB.2.21.1906170830240.2965@hadrien>
 <c5a19a87-4948-196c-4f74-872c207061ed@web.de>
 <alpine.DEB.2.20.1906170938530.3699@hadrien>
 <edbc59ca-2c16-bd0c-df27-ec2b9983d0e7@web.de>
 <alpine.DEB.2.20.1906180936090.3707@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <fc4109fa-d6e6-c826-bc65-fa137c9cd6b0@web.de>
Date: Tue, 18 Jun 2019 10:10:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1906180936090.3707@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:kkPEOCIabvs653qvPqHlEBh253CywQesqS0ViyvF90CZjBvPjpa
 vgIkjn74iJbJBaG+q7DkYu3/0+A6bbFFavOtOhHS6R0ONqxUxCY+8z5nas7in3LIgEMtY67
 XJmcwut3vxHESZ5sTeNrobjWP7esjDIy8QC+58I1RABcjrLPreGGFUC820qEfy6oB+2aSNR
 tx/fa4sFg8G8U4xf+Uabw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uAKHoWq/mik=:mWHDs77CiFF9/UzoMP3ut2
 0Pwm/e//oaDBBSuQR97vldeN4CrX+hH4Hd6pRwyYcu+1vjF8iBDlVp9nYCSH8VCz57ITFYOLx
 zuGCLd2tPrshPEWbTAfQSJ0m5kL6NmTtGawz+PWd8BicX2Av9FccYLXGgAA/TmtuGIYQE7HJU
 V2SghzJJDZYjYy78oWlICNL9238QzJhjIunrOUNjUe88H8rYZw1X3DIUmcsqpbOGViW1kYYRM
 +mLm2wM6qXH48fZrqyPcxPpmD4EMV5GvfVk4NFVvP2g+sWbyPbyM8SAMlslJdj7lpEfSbmPnc
 ckqPAbkCwQ6ntYrUrm/roxZZbouGlEPq8XCMiwJkPRVHzZwFtdLUQw19X3esgakwkHtMUXV6S
 3iYxCHniUpVcD9x7vyZ418S+VV8PA22Ck+5cTGldG1Z90A/WMfWzuG1t3fhCPkX67rgaj4Ykn
 HR3zYM52lNm/YvFM3tzdA/9fNDaj+zMXMltvVH695geKJFuVRwLpdvhpF3GeMJad+ibaYEhCj
 ik25lt2z2tuaw++eJihQuEOoicx6JtCFMzkVjALQbo4ehmujE1gg1CFfaxRxzor1IJIhE/ixc
 bkzrpPhWIcwNwa/K7GUuw/NauyYHlT1cxmK1HmcPZjQKiSGUg+UV0vSNoiA1tHXTyI1Tkg5AF
 UphR4RxnMqOLOyi37ogYO1ha+FRfptkWeS5NLsz/WgNAtAV3gPmc63rwjmSucsCBqwaHiplFG
 wiHJ95TH5shnKsNmc29q3phrRGNQ6GB6bYtqAIsGlPMR3QmykoqgPduTJxaf/Yg6J8HkrujtK
 z6ii7wMiDwZv2t3S26CAjS1eIr+vMP4ZqFtdr4uBeDfwIbXTYTksAtEo0BfsCHSU5KBRZG2Hf
 LOmGS+EZeLaLzsxB/mvQJ95MLLVscUhF2VP6iXTmq/2BFE/YoaV6hOjCulZY6HxkcIRT2fyW2
 H12+laqYvOZeNL7a2HuQZbMjNjmNJJMICmVO5zw+At4f0RWxYqidj
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 18 Jun 2019 10:10:43 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 18 Jun 2019 10:10:40 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking for a null pointer with SmPL
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

PiBJZiB5b3UgdHVybiBvZmYgaXNvbW9ycGhpc21zLCBpdCB3aWxsIG9ubHkgbWF0Y2ggZXhhY3Rs
eSB3aGF0IHlvdSBoYXZlIHdyaXR0ZW4uCgpUaGlzIHNldHRpbmcgY2FuIG9jY2FzaW9uYWxseSBi
ZSBhcHByb3ByaWF0ZS4KCgo+IElzb21vcnBoaXNtcyBoYXZlIGEgY29zdCwgc28gdGhlIHByb3Zp
ZGVkIGlzb21vcnBoaXNtIG9ubHkgY29udmVydHMgIVggdG8KPiBYID09IE5VTEwgd2hlbiBYIGlz
IGEgcG9pbnRlci4gIElmIHlvdSB3YW50IHRvIG1ha2UgYW4gaXNvbW9ycGhpc20gdGhhdAo+IGRv
ZXMgc29tZXRoaW5nIGVsc2UsIHBsZWFzZSBmZWVsIGZyZWUuCgpJZiBkYXRhIHR5cGUgaW5mb3Jt
YXRpb24gY2FuIG5vdCBiZSB0YWtlbiBpbnRvIGFjY291bnQgZm9yIHRoZSB0cmFuc2Zvcm1hdGlv
bgpvZiBhIHNvdXJjZSBjb2RlIHNlYXJjaCBzcGVjaWZpY2F0aW9uIGF0IHRoaXMgcG9pbnQsIGl0
IGNhbiBiZWNvbWUgaW50ZXJlc3RpbmcKdG8gcmVhY3RpdmF0ZSBzZWxlY3RlZCDigJxpc29tb3Jw
aGlzbeKAnSBydWxlcyBvbiBkZW1hbmQgb25seSBhZnRlciB0eXBlIGluZm9ybWF0aW9uCmlzIGF2
YWlsYWJsZSBhdCBhIGxhdGVyIGRhdGEgcHJvY2Vzc2luZyBzdGVwLgoKUmVnYXJkcywKTWFya3Vz
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1h
aWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIv
bWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
