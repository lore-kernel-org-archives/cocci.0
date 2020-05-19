Return-Path: <SRS0=x7/Q=7B=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE91DC433E0
	for <cocci@archiver.kernel.org>; Tue, 19 May 2020 11:43:25 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FA1A20709
	for <cocci@archiver.kernel.org>; Tue, 19 May 2020 11:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="WSJX3aHi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FA1A20709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04JBhM0k014992;
	Tue, 19 May 2020 13:43:22 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 38E907559;
	Tue, 19 May 2020 13:43:22 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 94C543DC8
 for <cocci@systeme.lip6.fr>; Tue, 19 May 2020 13:43:20 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04JBhJB0023555
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Tue, 19 May 2020 13:43:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589888598;
 bh=OTT638tdxdTmaMjKVCS7Ab2pMGECmv3kpetM7/VMKds=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=WSJX3aHiRG02ysVcz0u4gVnGPnl2tJ9lSao63H7qBxMrQjod7/oIcZMdjc79Xsapc
 jgPt0UIpwJQbBAC+mETlUqfh/fXiJTuH0OrX1KWhNgbIsWoIly6Fm9+RkBZzTdKgwk
 oNYWzZEHVpdN0+CcCCPTFm5hB6HV3ViGFWlVe++s=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.146.173]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MqZQY-1jEvRu032e-00mQG1; Tue, 19
 May 2020 13:43:18 +0200
To: Julia Lawall <julia.lawall@inria.fr>
References: <4a677190-b494-138c-4782-eec033a77377@web.de>
 <alpine.DEB.2.21.2005181118540.2467@hadrien>
 <0a93e321-42de-3534-9c4a-d67132a1289e@web.de>
 <alpine.DEB.2.21.2005181217580.2467@hadrien>
 <8f3cbbd1-653e-ab2d-5a41-18eec00ae828@web.de>
 <alpine.DEB.2.21.2005181234210.2467@hadrien>
 <e3d5a92f-0c78-c1ca-47ab-d2bb2864efaa@web.de>
 <alpine.DEB.2.21.2005181248310.2467@hadrien>
 <5c451649-4077-e54c-e01d-6bdbc0d02046@web.de>
 <alpine.DEB.2.21.2005191321270.2503@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <9b764738-8c6d-b066-925e-03d26c5ed063@web.de>
Date: Tue, 19 May 2020 13:43:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2005191321270.2503@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:+8BwgFmudxN5ga3mmy6n/GYdkPg2YeP3OT1FicxZbCAKI3ScHKy
 O0dpu0e0nAljh8e+KBztlpFu2K2b0JpTqh313qqJVh7Za9c1IHhMQ9i6klHFRyQNcPY/sDd
 Hwt8+31HtTDmZTgwMuBEvRY57VrqLlBwt6k86Jnz5TiycgJjQqzJRNwV7lmLDpLezF3VgYc
 ciM3XFAwwJEhOqaBiQBkA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IzNwfnucv1Y=:W3Cx+tx7k362blyzJFqUOz
 0e5WEkHv4p2ZIH2FRGwo5EW9HmK7/k6r8vEsN/plcXhnW/3hmrrM2OF6ETc5hVUZsSq74kw76
 wTHEs/aBBwv6rQufBibg1GDuHPV8B4PSaCvXFnUPbWeqqIkc0jGtTSzmsyW3mlEJlbVx++9Vx
 xReDLSXbY3NJBT9oHXaseoOCuXHXud588jsynOQLpR6ES/ViY9TRsYqHyem+5IBL/nkpR50Am
 isvzua9T/VNjIDxqzfrXvfYBtAp3DAe/8lYqbeha5mnDJmAKEdIVNjMdZgtwRmHo0QF42wU8U
 bARgDsN7l7kFGVQPZomTAUtWKXfE9yg32kg1HFv6NrUxr625bBqO0LwS6xGx7ePYpVyXc2W+M
 NoqfsOoKoLZgTbzGt+4rAEP748xtkvTAcRCQckawdH3pE+g9nhZFYKGsRWTgu5X1Pkh4i8zZ2
 hw9y5xFnKFVeXW2uZ/UcNZqAsG4X6MoajhEyC5IawIJVc7OnyehNQfdaqBLukkdwdB83+dkkv
 +YIROsKnJOeOdc7PYLlkdTpnpvxQTqSya8jeI8Gfoa6efYRtBWgX7VuEN9Vex3eqRN/YkokNX
 AbL1GFe6GyafWLq5aHLyejQf63RVfkNL4JdLV0KayElwx47idh4KAj9yt0+gnP4jz4AmvjKPF
 VmIViDC5Sc8H3w1/Xch6PMXbO5VBVTL814VlfFR2qxtYbl5mLR/POt5qyKXiJ8HulXLcZmhnS
 cFC1IZYFIz6EgFLXyrO8aD1eAPxM6KERz4jn5TRIJy6XcYwvWWZ71ODQGQiPnM3QV5F43iscC
 n/yw5gi9homklMgHvpuHMufDbpxhtatVbJK840P1RX8ILT0a0fmW1/r+iGxCga4/Vnv/G2pUp
 v+Rld5hcF+ImBgr3rEPAJkKHznsze9Aer5EzbPWdfmsrYR7ZnWcH2hP8eJOkC8xQX3VNeRK+M
 ANENzMDdpCNv9kJGnykQiiv2sKyh52p+KMVnrV8w4Bn/PEU1IhcLQY/AbzSGps/jRKEQaFL6X
 FXw5xUc7JiO9ae2suopD/9ok3XiZ0jTspzUnvZInGx1vhQ9q/+oHaGlHEitv5akWHe/wfNTW6
 2awqtcvczctKZk8gWNJ9tp0PBBp0q0eg7Y5YjPKTXLDioXQPdXPewtgPZBLsSkqu28T0HqNGk
 UF80PNqygxqEv6kXU8ypJ/YL+mH0u0ONbbu0A3e7A1YTiTtXVWpus87Wopd/rL7us/Gr2TUh4
 6ygRJeIbEW94JhVtJ
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 19 May 2020 13:43:22 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 19 May 2020 13:43:20 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Chuhong Yuan <hslester96@gmail.com>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] How to match function calls in macros?
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

Pj4gV2l0aCB3aGljaCBTbVBMIGNvbnN0cnVjdHMgc2hvdWxkIGJlIGVuc3VyZWQgdGhhdCBhIHNl
YXJjaCBwYXR0ZXJuCj4+IGxpa2Ug4oCcPCsuLi4gZiguLi4pIC4uLis+4oCdIHJlZmVycyBvbmx5
IHRvIGNvbnRlbnQgZnJvbSB0aGUgc2FtZSBsb2dpY2FsIHNvdXJjZSBsaW5lPwo+PiBodHRwczov
L2VuLmNwcHJlZmVyZW5jZS5jb20vdy9jL2xhbmd1YWdlL3RyYW5zbGF0aW9uX3BoYXNlcyNQaGFz
ZV8yCj4KPiBQbGVhc2Ugc3RvcCBhc2tpbmcgdGhlIHNhbWUgcXVlc3Rpb24gb3ZlciBhbmQgb3Zl
ci4KCkkgaG9wZSB0aGF0IHRoZSBleHBlY3RlZCBhbmQgYWN0dWFsbHkgc3VwcG9ydGVkIHNvZnR3
YXJlIGZ1bmN0aW9uYWxpdHkKd2lsbCBiZWNvbWUgY2xlYXJlci4KCgo+IEluIHRoZSBjb250ZXh0
IG9mIGEgbWFjcm8gZGVmaW5pdGlvbiwgPCsuLi4gZiguLi4pIC4uLis+IHdpbGwgb25seSBtYXRj
aAo+IHdoYXQgaXMgZnJvbSB0aGUgc2FtZSBsb2dpY2FsIHNvdXJjZSBsaW5lLgoKRG9lcyB0aGUg
ZnVuY3Rpb25hbGl0eSBvZiB0aGUgU21QTCBuZXN0IGNvbnN0cnVjdCBjaGFuZ2UgYWNjb3JkaW5n
IHRvCnByZXZpb3VzIHNvdXJjZSBjb2RlPwoKQXJlIHRoZXJlIG1vcmUgYXNwZWN0cyB0byBjb25z
aWRlciBmb3IgdGhlIHNhZmUgaGFuZGxpbmcgb2YgcGh5c2ljYWwgc291cmNlIGxpbmVzPwoKCj4g
QmVjYXVzZSB0aGF0IGlzIGFsbCB0aGF0IHRoZXJlIGlzIGluIGEgbWFjcm8gZGVmaW5pdGlvbi4K
CldlIGhvcGUgc28gYWxzbyBhY2NvcmRpbmcgdG8gdGhlIGluaXRpYWwgY2xhcmlmaWNhdGlvbiBy
ZXF1ZXN0IGZvciB0aGlzIGlzc3VlLgoKCj4gSWYgQ29jY2luZWxsZSBpcyB3b3JraW5nIG9uIGEg
bWFjcm8gZGVmaW5pdGlvbiwgaXQgd29ya3Mgb25seSBvbiB0aGF0IG1hY3JvIGRlZmluaXRpb24u
CgpTdWNoIGFuIGV4cGVjdGF0aW9uIGNhbiBldmVudHVhbGx5IGJlIGZpbmUuCgpEaWQgSSBvdmVy
bG9vayBhbnkgaW5mb3JtYXRpb24gZm9yIHRoaXMgZGV0YWlsIGluIHRoZSBzb2Z0d2FyZSBkb2N1
bWVudGF0aW9uIHNvIGZhcj8KaHR0cHM6Ly9naXRodWIuY29tL2NvY2NpbmVsbGUvY29jY2luZWxs
ZS9ibG9iLzdjZjJjMjNlNjQwNjZkNTI0OWE2NGEzMTZjYzUzNDc4MzFmN2E2M2YvZG9jcy9tYW51
YWwvY29jY2lfc3ludGF4LnRleCNMMTczNgoKCj4gSWYgaXQgaXMgd29ya2luZyBvbiBhIGZ1bmN0
aW9uIGRlZmluaXRpb24sIGl0IHdvcmtzIG9ubHkgb24gdGhhdCBmdW5jdGlvbiBkZWZpbml0aW9u
LgoKRG9lcyB0aGUgcG9zaXRpb24gb2YgdGhlIGRlZmluZSBkaXJlY3RpdmUgaW5mbHVlbmNlIHRo
aXMgdmlldz8KClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZy
Cmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
