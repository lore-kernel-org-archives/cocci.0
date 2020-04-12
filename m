Return-Path: <SRS0=MFMu=54=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59120C2BA2B
	for <cocci@archiver.kernel.org>; Sun, 12 Apr 2020 13:01:58 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A66D120705
	for <cocci@archiver.kernel.org>; Sun, 12 Apr 2020 13:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="UXyMDyOR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A66D120705
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03CD1dWA006317;
	Sun, 12 Apr 2020 15:01:39 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B1BCE77F9;
	Sun, 12 Apr 2020 15:01:39 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 123A1775A
 for <cocci@systeme.lip6.fr>; Sun, 12 Apr 2020 15:01:38 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03CD1bqT029977
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Sun, 12 Apr 2020 15:01:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1586696496;
 bh=m6H3Gtflx+dU+SQ5jHI9lNThzYmuY0geHNyXSPRKTuA=;
 h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
 b=UXyMDyORAnz/aKbAXj4uP1k9+aWaAb1zK8pmACFQz5wCbZGux7o9MbZGcBnWdMJHN
 k78B+nGvBTerHhZa8xDWbt3/CmYqivTH0Va5Wy5BVfBr53Tc+DHeoSERHmYKqJEFpI
 B3eS+DEJDbCcjQcxX0HDKhplS90mhcV2LMR8XqP0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.125.27]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MTPel-1joOil0N0B-00SLWm; Sun, 12
 Apr 2020 15:01:36 +0200
To: Julia Lawall <julia.lawall@inria.fr>
References: <146360ce-9cfb-e6f5-1601-fa95460c2cd5@web.de>
 <alpine.DEB.2.21.2004101712080.3039@hadrien>
 <f0b37f45-5144-a1c5-3f52-5bfbb6f3635f@web.de>
 <alpine.DEB.2.21.2004111600560.2369@hadrien>
 <fcbca1d9-7375-b488-54b2-a3934b90c6ed@web.de>
 <alpine.DEB.2.21.2004112036270.2369@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <37f5b3b3-0971-89e1-5010-9924e5b50810@web.de>
Date: Sun, 12 Apr 2020 15:01:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2004112036270.2369@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:CATIiwcsgMzOMsrN6hMaQM3Gv/5nQChA5nuGb784OIhSyx5xtOm
 j3xLRmTXlcADxLQka5FxJTRZ6OesVuPRemjZkk9EeYiaBsK4guLNHxGfZ9s73yJLujrvNPx
 LFTosP3n/OEfLeWzCoWwlUMGouR679Zwc6tODmUzaafwNLbnaDjzI9sQ4EYVMJfhFyrAnKU
 k/O1+KAVmnFevVLAN6CUQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ETvVBxj1+uk=:ZQhnj6ghP5ad1tBI0HKzUQ
 TU1n5CcoUvCRb9WW2CwEfUkxqIpDisi/6tdTRlPww9TS7PYbpYn/fVh60CKXbgNbqMBD7b9Kb
 ajoV6PnMNj2S1DW5pCr8JOsSa5OuDyi3Qszh7hWVduGTXLsODsVljtu0LpkF9zLJOECrwDu8+
 R34GXiRQG5HrViZIW5KPmaF9syqbcQxKUdGSeJkuYEfU1Z9DJURYgEDSJYq3YrC6EfD8dL3mJ
 7w4RRfdyReesH5IjFe/wc6Y8n4QYXTZ1v6nPLRFUzkxoQM3/JmmnY45Y5ixlGZ8jv/eiPyKGz
 LY5ODYA/K5DX9y7m+YacIaD4bnFDVBoY57YIAiaGP2k5PDVn1W57yloTLmK8jSTDEzZEt+07y
 CKsrk2GNg5A5/nLHMwfCtXeSsl52/frz2Od3e05v8Q9/fl8Y5v2wMcUUw8rWED++o85vQoWFy
 6gdSGgjvclP52yTVhZRQq9OjX/gXCnQKfYA+gNjy5gi6yyAuWul+545KWzFhGqeKNR8AFvgr+
 JUMq/0ftund/9TSWpXkN/tvIrz3TiZEzl1YHTRmCUdkeQ9zoV96Etbiu0tQ+M+dcS/uCRkswF
 Cn5z/I+60x8gajiuV9O4BDswXM8MDyqhgiCB3QsdR0jdKrSxAvCfymzfF8FaavQ9Mr0EDbgXD
 Z5Q5gACwCiEDfA45oX6ZAN6HgqqdSqFhSiW11NAWeNTnhlTKHz/DT4Yh+4WBlVwED24rh2pMz
 bM35pbTC40mFXIrMk3X/NdYCYokCbGBkiSKXNA8QFxMM2ZVrphJ06Apio7kcz8Nyia4yzEB7Y
 PUCpjAe1Dh3m00ZPWNiYS4JG0ncswPsv5XfU96/bNO3wAQLcbsbto0EVPyn1SaswGVRoClF2+
 vLPqFU5xOJYs+Jrjwl3gGJmhiqA0Q5Zr/QI7cfBKren5SsIQma2yVPAfnUo+MA34nrbV497at
 WPu6k+WEHFTIRyGundWwCbKD0+CR/Y78muyUckogHmHQXD43TD+170liT2fkUlvB0MdHQfovk
 CyoLLJWsnH9usHu5avjTjFDvdT+qmKuTzDx25Y9dqAbJeDKO8Jf6FDiUC09cy3IXx3hlqfdZv
 6ml8SAS/chq1/IUYTQSVC7uK0xfo29yZ0t7xckUujR2KFU85LSWQnEpAFi8HXFrK4h9hCRMde
 fSONChw2cqLRfVvu8mP9Pvvsvqtzz1nqkdc78E8uTmVB7MLEJU+lcLcGfocq2gKk1QRg0BFPe
 EKDceFsBNT1fMftoj
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 12 Apr 2020 15:01:40 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 12 Apr 2020 15:01:37 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Reporting variations of condition checks according to
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

Pj4gSSBob3BlIHRoYXQgYW5vdGhlciBjbGFyaWZpY2F0aW9uIGNhbiBiZSBhY2hpZXZlZCBhbHNv
IGZvciB0aGUgc29mdHdhcmUKPj4gYmVoYXZpb3VyIG9mIHRoZSBmb2xsb3dpbmcgc291cmNlIGNv
ZGUgYW5hbHlzaXMgYXBwcm9hY2guCj4KPiBJIGRvbid0IHJ1biBjb2RlIHRoYXQgaW52b2x2ZXMg
ZGF0YWJhc2VzLiAgSWYgeW91IGJlbGlldmUgdGhhdCB0aGVyZSBpcyBhCj4gcHJvYmxlbSB3aXRo
IHRoZSBzZW1hbnRpYyBwYXRjaCwgeW91IGhhdmUgdG8gbWFrZSBhIHNtYWxsIHZlcnNpb24gdGhh
dAo+IGlsbHVzdHJhdGVzIHRoZSBwcm9ibGVtLgoKV291bGQgeW91IGZpbmQgdGhlIHRlc3QgcmVz
dWx0IGVhc2llciB0byBjbGFyaWZ5IGZvciB0aGUgZm9sbG93aW5nClNtUEwgc2NyaXB0IGV4YW1w
bGU/CgoKQGRpc3BsYXkxQApleHByZXNzaW9uIGFjdGlvbiwgZTsKcG9zaXRpb24gcDsKc3RhdGVt
ZW50IGlzLCBlczsKQEAKKmUgPSBhY3Rpb24oLi4uKTsKIGlmQHAgKDwrLi4uIGUgLi4uKz4pCiAg
ICBpcwogZWxzZQogICAgZXMKCkBkaXNwbGF5MkAKZXhwcmVzc2lvbiBjaGVjazsKcG9zaXRpb24g
ZGlzcGxheTEucDsKc3RhdGVtZW50IGRpc3BsYXkxLmlzLCBkaXNwbGF5MS5lczsKQEAKKmlmQHAg
KGNoZWNrKQogICAgaXMKIGVsc2UKICAgIGVzCgoKZWxmcmluZ0BTb25uZTp+L1Byb2pla3RlL0Nv
Y2NpbmVsbGUvamFuaXRvcj4gc3BhdGNoIC0tcGFyc2UtY29jY2kgc2hvd19jb25kaXRpb25fY2hl
Y2tzX2FmdGVyX2Z1bmN0aW9uX2NhbGxzMi5jb2NjaQrigKYKd2FybmluZzogaXNvIGRyb3BfZWxz
ZSBkb2VzIG5vdCBtYXRjaCB0aGUgY29kZSBiZWxvdyBvbiBsaW5lIDE3CmlmQHAgKGNoZWNrKSBp
c2Vsc2UgZXMK4oCmCgoKV2lsbCBhbnkgc29mdHdhcmUgaW1wcm92ZW1lbnRzIGJlY29tZSBpbnRl
cmVzdGluZyBmb3Igc3VjaCBhbiB1c2UgY2FzZT8KClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QK
Q29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlz
dGluZm8vY29jY2kK
