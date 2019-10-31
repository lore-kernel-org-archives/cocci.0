Return-Path: <SRS0=W2E7=YY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AFDCA9EC3
	for <cocci@archiver.kernel.org>; Thu, 31 Oct 2019 08:13:07 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F0942083E
	for <cocci@archiver.kernel.org>; Thu, 31 Oct 2019 08:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="pDis/qTB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F0942083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9V8Cmnt012217;
	Thu, 31 Oct 2019 09:12:48 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 852EA77BA;
	Thu, 31 Oct 2019 09:12:48 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9344A76F8
 for <cocci@systeme.lip6.fr>; Thu, 31 Oct 2019 09:12:46 +0100 (CET)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9V8Ckib014043;
 Thu, 31 Oct 2019 09:12:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1572509565;
 bh=vfQYLKTHi696ERutGRDba3zPWpNdYfrD6pvQkuIfq3Y=;
 h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
 b=pDis/qTBk2kQaoVpVU6ihrOXpnW5smh2fKa6JdsoDWs0VQZSUQTx3bzQ/GQaOJlH0
 NI4oNoOZ+NS/qX352G13EqhjcciDrlGG2IfyiRxrmMZ6i8oAfrxsqzndRnheG0/rxO
 lQ10B3uCTCYga2TF4YiAURS6I412FosciHcoDI1A=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.137.160]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MMn1H-1iKIXS2Zm3-008ZpY; Thu, 31
 Oct 2019 09:12:45 +0100
To: Julia Lawall <Julia.Lawall@lip6.fr>
References: <fe6868a4-01f5-2832-9081-7643be0ab4a1@web.de>
 <3e3f40db-2422-c64d-3825-35f8c2471eb7@web.de>
 <161bbb97-09d9-f128-bd25-ef9348534144@web.de>
 <bd082d16-3038-1c8f-0a8a-bef8e6498aae@web.de>
 <2db8691d768571f6c275f3d89401df23@lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <d75163a7-e30f-e9b2-8670-a49b86164a9e@web.de>
Date: Thu, 31 Oct 2019 09:12:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <2db8691d768571f6c275f3d89401df23@lip6.fr>
Content-Language: en-US
X-Provags-ID: V03:K1:/TA6flN+8U6rv2aX8lQ1G8ElmfeOlwkMRWDpYU8suxBO+qhfSVg
 6At3ewpr9Vquy1NpOkSQXU3+PN5KFnttNAlepVn4/cb0ifeWMbYAfml839rEfc+/LG18LMU
 iwMvHH2W3pn8OlA2wI2rUWR4h7lYFXa9DofBr5vNrC1xr/wh0erSHt8bNI45g1ls2EVmkgs
 S4YQsmnb+gNOwP9Th5RBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SPKtemDEk7w=:+31OJL0OjhnXuJ5/o1POAK
 IekfHUAik9R7TtCfSMX76ASaYKaWj2ke5tDh8IJVsUyVVLlStaBnfQ9Vc1GyQx2Igd5178Dq8
 p0Fu/HZCIqJYMSPMK98vTYrE2TNGQWZ2NPElh5wAHhNxY/0dH1juZCVrJ7n4VNnIwAbktsTVA
 L/Mbe3eaw9fP3iPoOrfnvcwiBjlb9zsG0P6a+HPD85bDzBSzZ2AZ2GZllheQuEycUlEMeM+Ib
 KPJRyDCz8mFJ77Tq7DSHoGO+eduG9gKGwUM/8JJynTJB5PNqi6ROOFTD5G7xvN2eIXKz4Y4v/
 mQwTHmxETonjD5Al9Zzx+OIf7XFIRBPFAw2rvMD+9PQhv90525M09apR5JZoCBPP+ouyvkIPX
 LkMPenWbLibALUEwxu6E9BKsZUtnswwr4IrNzyLoVpPfJDYbvHrUJRgn9aFx4MtM7kmPbrC+y
 VGBDHSaufwMOJhepokqqrZUumA9RIOt18mEup3/RPcwCNBOanhCfQ2ParzL0KZVW4X5VMPAn0
 vHHW/++WicU4eP5w+VpDoY/RDhWQKqq5h6xXlhZu9Zc5nRrHjQioQE2r+5vsLc/joAjbkVH7E
 1fdPxl34hI05c5xgJ9GKInaWXgcrNgiltF2wTm6pjIQOEfnqSMgz9Zhp012RR7TSUlANWEPDw
 MyPp46QBiNHpBcA8h6kTFHcpzdVzdwg1//yEHJZNPspl6Xh24PxblmciDT/l0rOpSSb70/SXU
 ESt5wCyGq32M20JYFUsjxn2TOSNL5VkzHfCWX35TsqZIqpznBPSf5W+/+V7fI16N9HrOFtzv/
 7aGzeGoWmVNzY2Q9Tr51zxdFqeGw6susY3nYUoMF2BMkxx2YsEMmChUf4Xx9MeVB6vrbvCWyn
 RQLrX4UUPnVKOAgn3IuzwsA0VIZBS6DXSUCCTpnh93Q53iirlwDtwdKlzxJFZEmiFxAMo37UZ
 5+GA8maW2l79d7SQFL+e4FYkeCceqr1mshlkARJltMWoi8hu9XYWEo/hjcc7ltevYt4Ui8JX5
 5UysfbOWrc0Vrc/1Y7My9g9r+J7pXNkjIw4McJiiN4boWBjiifjyWsGLerDEGz5euNLEoJ3Ue
 X/L5zheX4UD4Rkx+7kIbWG193q2j+3PdUzl0+abeKYNgXOr1F/Hc9wuAvlXl04EviQbN+QI9n
 XIYVa/oNPJv7lT111lQ0iU9KlJi0RtcU568r6kH4tvJ24WnznQ3KZ3xZz+uhZYFzD8YzJxPeX
 ofJc9X/bA1lpJYleCM4ZuHUS9Lzd7Ym8iVWu7XUDi2TXwoJ1+EHrFn2pJf+4=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 31 Oct 2019 09:12:49 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 31 Oct 2019 09:12:46 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] xusb-tegra186: Adding a function call behind a label
 with SmPL?
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

Pj4gQGFkZGl0aW9uQAo+PiBleHByZXNzaW9uIG9iamVjdDsKPj4gQEAKPj4gwqBvYmplY3QgPSBr
emFsbG9jKC4uLikKPj4gwqAuLi4gd2hlbiBhbnkKPj4gwqBkZXZpY2VfdW5yZWdpc3RlciguLi4p
Owo+PiDCoG91dDoKPj4gK2tmcmVlKG9iamVjdCk7Cj4+IMKgcmV0dXJuIEVSUl9QVFIoLi4uKTsK
Pgo+IFRoZXJlIGlzIG5vIHJlYXNvbiB3aHkgYSBwYXRjaCBzaG91bGQgYmUgZ2VuZXJhdGVkIGlu
IHRoaXMgY2FzZS4KCldlIGNvbWUgYWxvbmcgZGlmZmVyZW50IHNvZnR3YXJlIGRldmVsb3BtZW50
IHZpZXdzIGFsc28gZm9yIHRoaXMgdXNlIGNhc2UuCkkgdGVuZCBzdGlsbCB0byBpbnRlcnByZXQg
c29tZSBvZiBteSBzb3VyY2UgY29kZSBzZWFyY2ggcGF0dGVybnMgaW4gb3RoZXIgZGlyZWN0aW9u
cy4KCgo+IEFzIHlvdSBzaG91bGQga25vdyB3ZWxsLCBBIC4uLiBCIG9ubHkgbWF0Y2hlcyBpbiBh
IHRyYW5zZm9ybWF0aW9uIGNhc2UKPiBpZiBldmVyeSBwYXRoIGZyb20gQSBsZWFkcyB0byBjb2Rl
IG1hdGNoaW5nIEIuCgpOb3cgSSBpbWFnaW5lIHRoYXQgYW4gZXhwbGFuYXRpb24gb2Ygc3VjaCBp
bmZvcm1hdGlvbiBjYW4gYmVjb21lIG1vcmUgaW50ZXJlc3RpbmcKYWxzbyBiYXNlZCBvbiB0aGUg
YXBwbGllZCB0ZWNobm9sb2dpZXMgYXMgYSBrbm93bGVkZ2UgYmFja2dyb3VuZC4KaHR0cHM6Ly9n
aXRodWIuY29tL2NvY2NpbmVsbGUvY29jY2luZWxsZS9ibG9iL2VkMWViOGUwNmY4MDA3MzlkMzk5
MjE1OGQzNjk0NWMwYzRjNmYwYzcvZG9jcy9tYW51YWwvY29jY2lfc3ludGF4LnRleCNMODYwCgpo
dHRwczovL2VuLndpa2lwZWRpYS5vcmcvd2lraS9Db21wdXRhdGlvbl90cmVlX2xvZ2ljI1JlbGF0
aW9uc193aXRoX290aGVyX2xvZ2ljcwoKCj4gVGhhdCBpcyBub3QgdGhlIGNhc2UgaW4geW91ciBl
eGFtcGxlLgoKVGhlIHNob3duIFNtUEwgc2NyaXB0IGNhbiBwcm9iYWJseSBpbmRpY2F0ZSB0aGF0
IGEgcmV0dXJuIHN0YXRlbWVudCBzaG91bGQgb2NjYXNpb25hbGx5CmJlIGV4ZWN1dGVkIGlmIGEg
anVtcCB0byBpdCAoYWNjb3JkaW5nIHRvIHRoZSBsYWJlbCDigJxvdXTigJ0gZm9yIGV4YW1wbGUp
IHdhcyBwZXJmb3JtZWQgYmVmb3JlCihpbiBvbmUgaWYgYnJhbmNoKS4KClRoZSBmb2xsb3dpbmcg
c2ltcGxlIHRyYW5zZm9ybWF0aW9uIGFwcHJvYWNoIHNlZW1zIHRvIHdvcmsgYWxzbyBpbiB0aGUg
d2F5CndoaWNoIEkgZXhwZWN0ZWQgc29tZWhvdyBpbml0aWFsbHkuCgpAYWRkaXRpb25ACmV4cHJl
c3Npb24gb2JqZWN0OwpAQAogb2JqZWN0ID0ga3phbGxvYyguLi4pCiAuLi4gd2hlbiBleGlzdHMK
IGRldmljZV91bnJlZ2lzdGVyKC4uLik7CiBvdXQ6CitrZnJlZShvYmplY3QpOwogcmV0dXJuIEVS
Ul9QVFIoLi4uKTsKCgpDYW4gYW55IGV4dGVuc2lvbnMgZm9yIHRoZSBzb2Z0d2FyZSBkb2N1bWVu
dGF0aW9uIGhlbHAgdG8gbWFrZSB0aGUgYXBwbGljYXRpb24Kb2YgdGhlIHNlbWFudGljIHBhdGNo
IGxhbmd1YWdlIGVhc2llciBhbmQgc2FmZXIgZmluYWxseT8KClJlZ2FyZHMsCk1hcmt1cwpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5n
IGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxt
YW4vbGlzdGluZm8vY29jY2kK
