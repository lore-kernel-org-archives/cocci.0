Return-Path: <SRS0=bhL7=YX=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6963CA9EC5
	for <cocci@archiver.kernel.org>; Wed, 30 Oct 2019 20:01:12 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD63720650
	for <cocci@archiver.kernel.org>; Wed, 30 Oct 2019 20:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="JrKiw6Xw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD63720650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9UK0wbR015820;
	Wed, 30 Oct 2019 21:00:58 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id F344276F8;
	Wed, 30 Oct 2019 21:00:57 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 11E1374CD
 for <cocci@systeme.lip6.fr>; Wed, 30 Oct 2019 21:00:56 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9UK0tL0001502;
 Wed, 30 Oct 2019 21:00:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1572465655;
 bh=eWdZ1bzADp9GPkOgCeE2ifEiJACU4/FOVRdou2VL+j8=;
 h=X-UI-Sender-Class:Subject:To:References:From:Cc:Date:In-Reply-To;
 b=JrKiw6Xwhfcku6QU+oeKYWsiK9pshWdsvXEaStNVVg6tXzcjIUTqz939ylstbJa6q
 090bE1/wUQP7liD3CWQR5VBF/Bragp5Vv5Fm9kmlJUIDVNBsVVuCzZ59yDcy/8aaTU
 1+z1zXCMnhlkZiOLK8gnJjrtjiGVrmO+KJMtDIjw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.104.79]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MK6mD-1iQjUh3dQr-001QpY; Wed, 30
 Oct 2019 21:00:54 +0100
To: Julia Lawall <Julia.Lawall@lip6.fr>
References: <fe6868a4-01f5-2832-9081-7643be0ab4a1@web.de>
 <3e3f40db-2422-c64d-3825-35f8c2471eb7@web.de>
 <161bbb97-09d9-f128-bd25-ef9348534144@web.de>
 <bd082d16-3038-1c8f-0a8a-bef8e6498aae@web.de>
 <2db8691d768571f6c275f3d89401df23@lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <3389d97e-37a6-e755-bfb6-73b98cfd5bca@web.de>
Date: Wed, 30 Oct 2019 21:00:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <2db8691d768571f6c275f3d89401df23@lip6.fr>
Content-Language: en-US
X-Provags-ID: V03:K1:Qd+knsl2KeDn9epFbTKPYGA5ZcvhGTYY8cgL9OxZCO7Pu/VFImx
 ecBM/QyRXGdCf0fsinkV2qU9kCpF34VbVnbnOGDotNZy8IgmQvWBFWx5Aa5fygJucZWiztk
 KNKiNpEoJ6Ceuc8ocDNLMMK19MDK6mdwFwcJPWXmCiSt+GBDRmfmZOHQDMrbiMTbk/1S4yK
 6C3scrsQa8T5hPb5jQEaQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:L8aRGiGnsz4=:v0OidKIitP10I/tNM53e4x
 3F9lxldvv24dfW2vwFURXHfqgu3WdbZJ/hctY8938T1P6dN66Gxvs03gx+gI8HCUF9EOpCRpL
 JdjR6Lvn6Sbg1Y4hyzkw4/sJ12rm3YPWC4hjEQQkvMgg+Tyw12W52B0l9sLW2fevkX0PEUdJm
 ulIOjBCxo+oUnNjFkv5Nnxyuiqp095vs6AZhUiSPeILbzaMdBE5QVND8RxEv2R94ST+GdToQ7
 vwKGW6bmwaIHOAx49t2HmkSWrs0t4z/JEaLQQh45qCMjDigeMfXFkBzZVYfrgNvMtdG6n2QIT
 0EKTJZrCldLFJCulNmoOxCv0yexBx8jQ+6DQrtU7EtlglmEv7ELr+aWFEW75lXvPPpKoyG1V6
 n6bXHXz/rOjwTBsqnrSNBF6OiUWcKI4AcrdCrCSGM+6SVZlerICQPPlXfW1KZTUH45xku1j7d
 Fjzik0CWNTJp8bVh0qJUOfuZM3hugqJapQE6Sk9yUhwK/t8klGtVuokG1GkxL1tQuAFkqve5P
 yZc9B5U1ULBimXkq5ifQx0530ADDq3jNs2oVdOrPzTF1fOSCxTrCe/SspXoZIWM32h4dRqOek
 WcsbKwT/f7HqTHFDEs7VknNsFhcuOCcABE1tusKfEQC9Z7fcOzKJe1BLAYx7k/RR5DFRIEjAh
 UTRnaEJUzbWGNKwmejJAt8QS1EguymJNTULg8rlLoUSpc0XCbh3uB10qTD5uJa2y5QZ31OR3/
 I0UYgHXgKNmX1ZH+eruT1M4OU4NWTxAYzo3HVPO1B+zc8uPqCtj2zKxUVNQ0ng2a+mzNCrfKL
 8jUSnNqY1lDpCNHoYfW7Xwvjtg3hkQZF+Za51qr34AFoh3Y0H6Ok4dsx8tOYHmpJE2Bd+pC0u
 qEeS3VnNxQ+XK2/zmTb6Dm5q3FczJsr/qHe1mi4EKFVoXOUEjTg7X1HPD9qTDFkOrWXWP6Rku
 e0vjViBM7/xJ8uYaCh5JHVs2YMCH/ItVbIew+3TiJPB7FGRxKcdVM3iXI03a/yTSqHDfORWZS
 YKRzUTvB7n6icKW7za6TTTImUKJ5Q57pxCzvXpp8SrknT35fUogNpjC+PoiDPGfB7nOE7DkG+
 iqzbyqwp9mL/hJ1N5B/qAnItlov7QScHohryoyK9sqw0gBo6uVC0HbpJrhIcJOWCL+5ON3vzx
 ugOhsqsRUS7CzZjGFWtlcs0CCLLFiubF6VXRCcIX8tTAJRYJb7PtBFdibw91vYNAuMr4LzGXM
 HS/jtcJKaydrWwxb5LcVUhwLz8bMDxVVq21DXjVD9VFA9Oh2q07U2Mm4bKiw=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 30 Oct 2019 21:00:58 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 30 Oct 2019 21:00:55 +0100 (CET)
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

PiBUaGVyZSBpcyBubyByZWFzb24gd2h5IGEgcGF0Y2ggc2hvdWxkIGJlIGdlbmVyYXRlZCBpbiB0
aGlzIGNhc2UuCj4gQXMgeW91IHNob3VsZCBrbm93IHdlbGwsIEEgLi4uIEIgb25seSBtYXRjaGVz
IGluIGEgdHJhbnNmb3JtYXRpb24gY2FzZQo+IGlmIGV2ZXJ5IHBhdGggZnJvbSBBIGxlYWRzIHRv
IGNvZGUgbWF0Y2hpbmcgQi4gIFRoYXQgaXMgbm90IHRoZSBjYXNlIGluIHlvdXIgZXhhbXBsZS4K
ClRoZSBleGNlcHRpb24gaGFuZGxpbmcgY29kZSBzaG91bGQgdXN1YWxseSBiZSBleGVjdXRlZCBh
dCB0aGUgZW5kIG9mCmZ1bmN0aW9uIGltcGxlbWVudGF0aW9ucyBhZnRlciBhbiBlcnJvciBzaXR1
YXRpb24gd2FzIGRldGVjdGVkLgoKRG8geW91IHRyeSB0byByZWZlciB0byBzcGVjaWZpYyBpbmZv
cm1hdGlvbiBmcm9tIHRoZSBzb2Z0d2FyZSBkb2N1bWVudGF0aW9uCmxpa2UgdGhlIGZvbGxvd2lu
Zz8KCmh0dHBzOi8vZ2l0aHViLmNvbS9jb2NjaW5lbGxlL2NvY2NpbmVsbGUvYmxvYi9lZDFlYjhl
MDZmODAwNzM5ZDM5OTIxNThkMzY5NDVjMGM0YzZmMGM3L2RvY3MvbWFudWFsL2NvY2NpX3N5bnRh
eC50ZXgjTDE3OQrigJzigKYKQSBkZXBlbmRzIG9uIGNsYXVzZSBjYW4gZnVydGhlciBpbmRpY2F0
ZSB3aGV0aGVyIHRoZSBjbGF1c2Ugc2hvdWxkIGJlIHNhdGlzZmllZApmb3IgYWxsIHRoZSBicmFu
Y2hlcyAoZm9yYWxsKSBvciBvbmx5IGZvciBvbmUgKGV4aXN0cykuIGV4aXN0cyBpcyB0aGUgZGVm
YXVsdC4K4oCm4oCdCgpUaGUgZm9sbG93aW5nIHNpbXBsZSB0cmFuc2Zvcm1hdGlvbiBhcHByb2Fj
aCBzZWVtcyB0byB3b3JrIGluIHRoZSB3YXkKd2hpY2ggSSBleHBlY3RlZCBzb21laG93IGluaXRp
YWxseS4KCkBhZGRpdGlvbiBleGlzdHNACmV4cHJlc3Npb24gb2JqZWN0OwpAQAogb2JqZWN0ID0g
a3phbGxvYyguLi4pCiAuLi4gd2hlbiBhbnkKIGRldmljZV91bnJlZ2lzdGVyKC4uLik7CiBvdXQ6
CitrZnJlZShvYmplY3QpOwogcmV0dXJuIEVSUl9QVFIoLi4uKTsKCgpEb2VzIHRoaXMgY2hhbmdl
IHNwZWNpZmljYXRpb24gaW5kaWNhdGUgdGhlbiBhIGRpc2FncmVlbWVudCBhYm91dAphIGRlZmF1
bHQgU21QTCBydWxlIHByb3BlcnR5PwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBz
eXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9j
b2NjaQo=
