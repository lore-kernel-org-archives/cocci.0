Return-Path: <SRS0=WTRX=TX=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D71C282DD
	for <cocci@archiver.kernel.org>; Thu, 23 May 2019 19:15:27 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9EA120863
	for <cocci@archiver.kernel.org>; Thu, 23 May 2019 19:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="o7F1kIfC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9EA120863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4NJFE8i024965;
	Thu, 23 May 2019 21:15:14 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DA448775C;
	Thu, 23 May 2019 21:15:13 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id BB25F7759
 for <cocci@systeme.lip6.fr>; Thu, 23 May 2019 21:15:11 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4NJFB3i008699;
 Thu, 23 May 2019 21:15:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1558638910;
 bh=iwuqTcnRWNenCV2aB4ISk6JMN35HrQ0xWfBQOMQ8Gjs=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=o7F1kIfC8ikoQLo5wl+m6eKD7Ja3jl6bHSwN5c1uo8IgnTXMZ3xHsx2HkzogC0kq7
 RGRPPDOFVsLXg3TL8lfj0bwa5bD7/bBj9D+PxA6oep98urLoL9NZldf1wZWB3vMeTA
 XUMjPbqG1rHOTpW1Cl0t0AVbscvwSHHN0rtb4tFs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.4] ([93.135.166.247]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LrsGE-1gUcNP3cEA-013fPe; Thu, 23
 May 2019 21:15:09 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <alpine.DEB.2.21.1905222114490.2618@hadrien>
 <81b409c6-5986-5961-5edf-843c6737d88c@web.de>
 <alpine.DEB.2.20.1905231500230.3573@hadrien>
 <3a79c8f5-9483-397a-eb98-adeb40634fe8@web.de>
 <alpine.DEB.2.20.1905231659010.3573@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <cfd828ab-c931-4ee8-3650-dd5b280f2ef6@web.de>
Date: Thu, 23 May 2019 21:15:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1905231659010.3573@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:NXtrfPx8SmxO/lT/W8B3BHRdxfNLkTrv+W+bFz1ufjcGko6aVct
 VdBDyKAX/RTW3Oz/2cx2B3wMbLep2SoWaAlQtKEj+EkwwPiRza+mLjYgDZ0dzitMn1V9S/P
 0ftrhoyikN7kDw+E1FXLf1C6JAj4d5Hk3FkEN37uPxUwG/vy8OAdkgC8S2ipQ11h/A3PCE2
 24bcWMvVU8iTf7Z23jfzA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:31/XSkpoy04=:3X5gZof0/VWE9PkfACUA6R
 VHBKQ45J6NY2ogkyhVFiY7mxFMii7A6GXOKJ2FLwkdmbxkIytCspwziPZqPFcYkw6s/byG8Gj
 YQ2GwipPv3dQady8g8zxmH1WzZpwijQuWovNi+6ast2F9kyCBAaBT1fiHwd78Z3nckitdGt6a
 OsBvc00RWerVUqHIfhp1Z77aJrNoA41R9E6LZwEpEU6WgILDJ+y3WYxOefCuXIK0k8E7t5HGk
 ILf6gwJ9r8bsL9Pxc/ZMhUtK3gGM/ahvRbSTtcbmoZcNSEAWveHHTIgYDGXdJFxP4hk9G7gNb
 QjiE585RhSKAGCqNTtiuDmykK7RvhmoiXYYp3DtaRAYnGPWvtLwxI2IMAActfJNv5L+wk+SKY
 GmdirDxMandAhyOxDiBtc4qHAGa6Wa/G292lB1xiXWAU1lcLBNpvuNPN0OpZSn27SFnEawV5z
 340eegzwuA3OfEiJtLkuL9a/XGcku+Tb/y23Iok/5ZPvsgyE0fg0wDHI3wNNZ7h7205Ve9R7I
 f8JiY9yZOrwMVWdFyLgqqRcy10ky6R4BomekH971hXqqhuhVN9vd3fjgbYejv1goXSKTGDZ90
 8KKiEiK1s4Zcb0VfiQvHEFVl2bUJDgROS6qfvsMzuUFx4a1yX4QlRRQ6hXkuqohewn1uR81cT
 oNuA9srZruqYVnJ3ekatnFJ7wu6ELMQs0APhBq3sSylJxhNpRVpD3Asj86FG44Z0R510ozIgx
 4r1/nAc2Nf1QkIWM31kun+NtO+BxAZKzgqU1VGDUNeX/3N8K+3+njvMRBWk6dbe+gsUDco83J
 RrVMlHIstsWgAGqj7q4Xy/0hpTch9qRHiM4YTfr7swqiwTmG9w0zwC0cO3rzhxI6Qf9maR52r
 IUyXOCUMgRmrHSBUopFXDxDXtLGlsddFXDlW9a2mMu9acyuF8np76hNLId3BnGk7xT78YT6Jf
 fbyPRp6UkFbIFV8kXUM4qx6VgJ8jDwygNCzIgXQ78h/cx+t+jql7d
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 23 May 2019 21:15:14 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 23 May 2019 21:15:11 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Development challenges around OCaml usage for SmPL
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

PiBZb3UgY2FuIGRvIHdoYXRldmVyIHlvdSB3YW50IGluIHRoZSBvY2FtbCBjb2RlLgoKVGhpcyBw
cm9ncmFtbWluZyBsYW5ndWFnZSBoYXMgZ290IGFsc28gYSBnZW5lcmFsIHBvdGVudGlhbC4KQnV0
IEkgZmluZCB0aGF0IHRoZXJlIGFyZSBzcGVjaWFsIGRldmVsb3BtZW50IGNoYWxsZW5nZXMgdG8g
Y29uc2lkZXIKZm9yIHNvZnR3YXJlIGNvbXBvbmVudHMgd2hpY2ggZG8gbm90IGJlbG9uZyB0byBp
dHMgc3RhbmRhcmQgbGlicmFyeS4KSG93IGRvIHlvdSB0aGluayBhYm91dCB0byB0YWtlIGFub3Ro
ZXIgbG9vayBhdCBhbiBleHRlbnNpb24gcmVxdWVzdApsaWtlIOKAnFN1cHBvcnQgZm9yIHNwZWNp
ZmljYXRpb24gb2YgYWRkaXRpb25hbCBsaWJyYXJ5IGRpcmVjdG9yaWVz4oCdCmZvciB0aGUgc2Vt
YW50aWMgcGF0Y2ggbGFuZ3VhZ2U/Cmh0dHBzOi8vZ2l0aHViLmNvbS9jb2NjaW5lbGxlL2NvY2Np
bmVsbGUvaXNzdWVzLzE5CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUu
bGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
