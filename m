Return-Path: <SRS0=ycDg=T2=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A03C282E3
	for <cocci@archiver.kernel.org>; Sun, 26 May 2019 13:06:11 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC5EA20815
	for <cocci@archiver.kernel.org>; Sun, 26 May 2019 13:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="qA5lIs7c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC5EA20815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4QD5srK012900;
	Sun, 26 May 2019 15:05:54 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id AB0EF7747;
	Sun, 26 May 2019 15:05:54 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id DFEAB773A
 for <cocci@systeme.lip6.fr>; Sun, 26 May 2019 15:05:51 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4QD5oWt011546;
 Sun, 26 May 2019 15:05:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1558875948;
 bh=hQ1vMYSCxE00y2TNHMJuziKIF7RAh1THnx5pdGSNmZU=;
 h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
 b=qA5lIs7c0WQtsvqt2NFHVKgOvh8eEYCz6g5pUuMfDA68Y/LLMHpDvHEHlrL2MH6E2
 OZwia2ivdxj7T7JtI6Fpdpd+O1j5GoVeRlaVpazPvLUtScN105tPAFl5CwoX4kGgq3
 WJ5DlYfZj2BzAyPnbCv3hy3fdgufagI8QnTCU/As=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.4] ([78.49.116.98]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M1o3y-1gbG5O0mbK-00tgfc; Sun, 26
 May 2019 15:05:48 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <alpine.DEB.2.21.1905222114490.2618@hadrien>
 <81b409c6-5986-5961-5edf-843c6737d88c@web.de>
 <alpine.DEB.2.20.1905231500230.3573@hadrien>
 <b5c322d3-3162-953f-a985-53abc5064482@web.de>
 <0782D580-3DD6-4419-B5E1-C04215FB2E3B@lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <d96051ba-3a49-52aa-cc43-b7e4251fde8e@web.de>
Date: Sun, 26 May 2019 15:05:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <0782D580-3DD6-4419-B5E1-C04215FB2E3B@lip6.fr>
Content-Language: en-GB
X-Provags-ID: V03:K1:W7+r3igQIDMUjHUE5iM5OnTj7nVk3m5XL1IlnlulrAtCZSafept
 sKe4q/ekGFmnFjKqZK76LifrqEGOomNmdVSi/u0eARRnESmi9rudnom6yEZKLD2lAJzWDo7
 me3jtO+IGzGsaLgcDHEiaRBCt7pPUgmNTa8i6mIkGTf2kvDzhT3Re9IarTaPpw+75x69JoK
 15QHk51tcL+Ts95QBp1BQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JSyeOBmnrc4=:0yD/l3+OQkUSBIhkOxFcRP
 Fx5QV7bI+gqjwI+LfB6ozfppbeBXTIa82L+AizdebIRoJZ1pmvqxW3xl/4ZqyvItjdkTmF18w
 A/0SnKbVJZi32O0IP+DB0T3eNOIOB54Y09f3cyyn3tD1kkLl70ds33svfMHh141+V6ASTn+1/
 5oQ217DgcYEYfPHJy7z5E429Wph8jd/g4fR68n/Y4z1XKSbxxOD7yW+Ihl+Hwwa+pK03t319o
 Lw9vjfT8YazIwkYpEmYXqiFID7tp5tFwEdcDiIeSf6Xaq1tNWYPNTvhlT7UdvnfPiaWNASpY4
 z1HpSDLcYxN3sgUIcyxQd74g9kDdjMkUhI9PSKwyogizeaztlmPKoaYrgBRjfeBv6IOvAMFfq
 X8rj4X6gPZP+5t67ysoRK7YBz+DeLXQRBE4yC/4nV3rYh1dw8iPCdQkq45IFENOXkKINT7hkO
 7HwI11MGSXB+ewa6tffl/FANNkv6GU8+PMpRxQZ+tZiVi8zz3uXhRs1MBYOIG4/Xa7SVrG66D
 Q15W9eLlFpHs/iZ7LaAH2yXYhbFg0hV5Asnr69bE7W4A9H67FybhHTfL5D3or9AFI/yvDy00S
 9TrjzexFCF1atYc/+5boYFk6lHh0xMwUFmAOAQNdsEBkelK03vCqPSc6OZSXjUxirxHiiTbuj
 RaVLo0DVbhbg0yPkbdd6G4vEvmEgUQeJ5Kq3YzFXDSxs+GPTL5Uo7nxoDWeuYHl9nUu302e77
 AuNERKSTy0o6wloSVJyS1FAmQE6VJon+EFnjIENZQLZ1X5eY+U9VZ1y3e5PMSVmNUk2bTRy4p
 /gg4BgrR4l9DtEiPk4YiQFuLgg+248wQGiJgPtfCbUAuG15L6Y4evNvNEpr3k2V6rSq+fpGQw
 WlcWVNOsr3DXuC0MD2uCT9JzdO7agahqLpTm5t2x6hWeKKlbP26QBGaUh/nL1K5KJLOIqOTe4
 IkB2Ecp4HWwLay/RAlq2ilDCPupxvbi4r62fymfgjnR/upKMiHTlv
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 26 May 2019 15:05:55 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 26 May 2019 15:05:50 +0200 (CEST)
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

Pj4gZWxmcmluZ0BTb25uZTp+L1Byb2pla3RlL0NvY2NpbmVsbGUvMjAxNjAyMDU+IENPQ0NJTkVM
TEVfSE9NRT0kKHB3ZCkgL3Vzci9sb2NhbC9iaW4vb3BhbSBjb25maWcgZXhlYyAtLXN3aXRjaCA0
LjA3LjEgLi9zcGF0Y2gub3B0IGRlbW9zL2NvbW1lbnRzLmNvY2NpIGRlbW9zL2NvbW1lbnRzLmMK
Pj4g4oCmCj4+IGMxYjogLyogYmVmb3JlIHRoZSBmdW5jdGlvbiDigKYgICovCj4+IOKApgo+Pgo+
Pgo+PiAqIE5vdyBJIHdvbmRlciB3aHkgdGhpcyBkaXNwbGF5IGlzIHByZXNlbnRlZCBpbiB0aHJl
ZSB2YXJpYXRpb25zLgo+Cj4gQmVmb3JlIHdpdGhpbiBhbmQgYWZ0ZXIKCkkgYXNzdW1lIHRoYXQg
dGhpcyB0ZXJzZSBpbmZvcm1hdGlvbiBjYW4gaW5kaWNhdGUgYW5vdGhlciB0ZW1wb3JhcnkKY29t
bXVuaWNhdGlvbiBkaWZmaWN1bHR5LgpTbyBJIHRyeSBvbmNlIG1vcmUgdG8gYWNoaWV2ZSBhIGNv
cnJlc3BvbmRpbmcgY2xhcmlmaWNhdGlvbiBhbHNvCmluIHRoaXMgYXJlYS4KCiogSG93IGRvIHlv
dSB0aGluayBhYm91dCBteSBleHBlY3RhdGlvbiB0aGF0IHRoZSBPQ2FtbCBzY3JpcHQgcnVsZQog
IHNob3VsZCBiZSBldmFsdWF0ZWQgb25seSBvbmNlIGJlY2F1c2UgYSBzaW5nbGUgZnVuY3Rpb24g
aW1wbGVtZW50YXRpb24KICBleGFtcGxlIGlzIGFuYWx5c2VkIGhlcmU/CgoqIENhbiB0aGUgZGV0
ZXJtaW5hdGlvbiB3aGljaCB0ZXh0IHNob3VsZCBiZWxvbmcgdG8gdGhlIGF0dHJpYnV0ZQogIOKA
nGJlZm9yZeKAnSBvciDigJxhZnRlcuKAnSBiZWNvbWUgbW9yZSBjaGFsbGVuZ2luZyBmb3Igc3Rh
dGVtZW50IG1ldGF2YXJpYWJsZXM/CgoKPj4gKiBXaGljaCB0ZXh0cyB3b3VsZCB5b3UgZXhwZWN0
IGZvciB5b3VyIHZhcmlhYmxlcyDigJzigKZt4oCdPwoKQ2FuIGZyYWdtZW50cyBvZiBpZGVudGlm
aWVycyBiZSBtaXhlZCB3aXRoIGNvbW1lbnQgZGF0YT8KClJlZ2FyZHMsCk1hcmt1cwpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxp
c3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4v
bGlzdGluZm8vY29jY2kK
