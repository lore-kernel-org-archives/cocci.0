Return-Path: <SRS0=0+7Q=ZO=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127BAC43215
	for <cocci@archiver.kernel.org>; Fri, 22 Nov 2019 10:44:48 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BA7420840
	for <cocci@archiver.kernel.org>; Fri, 22 Nov 2019 10:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="kcN42Vzt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA7420840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAMAiXZk029919;
	Fri, 22 Nov 2019 11:44:34 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D4B0E77E3;
	Fri, 22 Nov 2019 11:44:33 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8275D77D2
 for <cocci@systeme.lip6.fr>; Fri, 22 Nov 2019 11:44:32 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAMAiVQg007771;
 Fri, 22 Nov 2019 11:44:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1574419471;
 bh=CF0/CZ3Z/v4PKUxzhOtJ91uE32FBC5IoDpG47n8TTKI=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=kcN42VzttlAzd/DgtWaX8V82WUh4VbYMag/V7kZyMMd7oLE5Rth2Ids7+X5yLZkUV
 aHSieJIooTA+Rg/47e3pYWIbcyigGpPs63kp+M7Pov2Es+CYDS5E5yHGqwQ3ihml5F
 n9FVi+3Kppf2C2JPMqfKpsXyW77Ui3vaIW33LYIQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.244.174.75]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LaTtv-1i7nYu1mrX-00mOCh; Fri, 22
 Nov 2019 11:44:31 +0100
To: Julia Lawall <julia.lawall@lip6.fr>
References: <cc561358-4d00-9f1f-eaa2-8fae400ccc8b@web.de>
 <alpine.DEB.2.21.1911221025570.2793@hadrien>
 <8a44f286-72ad-14c4-6ee9-b8aa25ccba3e@web.de>
 <alpine.DEB.2.21.1911221050320.2793@hadrien>
 <46f7430f-8176-27ed-1150-af9fc69b03a7@web.de>
 <alpine.DEB.2.21.1911221134210.2793@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <da29f2ea-7037-3237-8ec5-4464379e7a54@web.de>
Date: Fri, 22 Nov 2019 11:44:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1911221134210.2793@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:2tlQy84TkC1LmfrTs6V+fIGPNmVxZeDh/hK6S32OBy17PrgT03u
 DNX/eFseI93QUuVQZFpFFKLg6uE17gy9pYnXquBTETQAqioiu/TCuyloD3KjB95KfCUPi/q
 MbfBbGRO+5SR0/+dtuO3YaD9ISU/BIMA5aHffsGLugVJJU0mR7fCecNyitJcy2DhVXpG8jV
 3Z0EbuF1JEzzXlzp09f6w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EiZt2jyuUo8=:f6P75xlBdtQPqKjM6gOv5d
 t8HfmZSuY3JmPhyNHc99LF9IMNimk6IC71PS8IO3K9FsfkXfxK+uv1DMnb0H1iawML6DuBefo
 LJmepwNh667ZtsI+t0UqLvUj2wbgsEBBnGzWzrte9cj/lAQDFvl5fXarAuPVou4bq1qzpKC3H
 hptTHb/8Zpo16crXIil9+TO2HOwKI3+yc0Uf2u0tSmBi+5Jd1qc7UXNi/0CFHwHqc2Bp2tBS1
 ixiDfpgxdmOyFxRBG+rZ9ef5FCE4ROOHdZ5WmcTpBQ51NFRzP9SlSm22u4Ti4NNKXI7cFVHcZ
 D9g4ND29ZUO9EV8HWT9z74SefxG8S/Gmc2k83UswXhqT7LR97YFYXyfXjnJVRtSmqeRfUmfej
 Uq/Os4HWTeNLvw5/Al6Hqr81yut6zWOyFzbHFCCHGvuIsONqhJ/85VL3Pxcg2fTMDLhXbbOeu
 bNu7hu0L37u4cjLq8GVxt78+dN+jvF/MTaabwbGn/QfQyRq6X7N/7hG7hw4AqNgFITaZC9xv4
 /Cu3+Y37fbwPRgGtaX47i2rrRALMTtvJKJbxd7ePI4lCba0aBXvWhVx4YBVM6urQpThER2OEr
 e8n+pcqRdkKwaYbQ3EvP6Gc37MW2U76Ji3DKZz5V16vx2OsgljwdY8deBJ7ojknjGDR3YvIIJ
 foC7Mb66jzgrWJqcQLMCsUaeYs4DEa9NOOUdfiMzmPE3wskH/Ws1EeqiYVDg4ksYJ4RubAs9I
 ZOI2bDFufeW7eMHJ6bwNePox+oKJgdgfdjkY5ZIgNSRhhKOm5ceiFdNImOoKpqypA3w70PHl+
 fEM9XHWtcn3jetScLHNjMT/FmV7WWXG9uLfMIK2X8X8PZ6lsB39FPl7DOTPSuHV/r+Oxko71F
 Hz9dU7/2KI6rJlmhRZQ1lqkbPA7IyPKLIH1p/GR/dsLl7J+cb8NPhZcLz3AqNf6rmC8OxOBjr
 X3Z5j/65qg5qyUBmyGxd7NwpsiPLlq11aWT9cpu2BImFFZ2pI9wAXiJzq+AEXa8O2rj8K915f
 UR9pjFT0j1Uw8X1i8jrMn4spozC89V9M7c/46g6epMxyEGYrjEDCTQByrbtKRj59+r0xoaVSX
 7nKEP+p9VT4ItOU+FRPafdS3zUerSlbcpiVCg97TL4KUd6OLK+qPvUXvqpw4WrV9apWA+VQp8
 DQc6+S8xyGl6bbGmh41C/FU9DujkZXVjzfBucXUDkydGbFvtaJHl6BZQvSQTLgUcdZWUmfklu
 OeoxHKEsvaQJ+Sy3UB/uf5w/hPEUXmSyr+j+mXawpHMY/AHaHMNO9ZOJrY2I=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 22 Nov 2019 11:44:34 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 22 Nov 2019 11:44:31 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Concerns around type safety for usage of expressions
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

Pj4gRG8geW91IGZpbmQgaXQgZWFzaWVyIHRvIGNsYXJpZnkgdHJhbnNmb3JtYXRpb24gcG9zc2li
aWxpdGllcyBhcm91bmQKPj4gYXBwbGljYXRpb25zIG9mIGEgbWFjcm8gbGlrZSDigJxDT1BZX0FS
UkFZ4oCdPwo+PiBodHRwczovL2dpdGh1Yi5jb20vZ2l0L2dpdC9ibG9iL2Q5NjYwOTVkYjAxMTkw
YTIxOTZlMzExOTVlYTZmYTBjNzIyYWE3MzIvZ2l0LWNvbXBhdC11dGlsLmgjTDg4OQo+Cj4gSSBz
dGlsbCBkb24ndCB1bmRlcnN0YW5kIHdoYXQgeW91IGFyZSBhc2tpbmcuCgpJIGhvcGUgdGhhdCBh
bHNvIHRoaXMgY29tbXVuaWNhdGlvbiBkaWZmaWN1bHR5IHdpbGwgYmUgcmVzb2x2ZWQuCgoKPiBN
YXliZSBpdCB3b3VsZCBiZSBtb3JlIHVuZGVyc3RhbmRhYmxlIGlmIHlvdSB3b3VsZCBwcm9wb3Nl
IGEgc2VtYW50aWMgcGF0Y2guCgpTb21lIFNtUEwgc2NyaXB0cyBhcmUgc3RpbGwgaW4gY29ycmVz
cG9uZGluZyByZXZpZXcgcXVldWVzLgoKQW5vdGhlciBleGFtcGxlOgrigJxbUEFUQ0hdIGNvY2Np
bmVsbGU6IGltcHJvdmUgYXJyYXkuY29jY2nigJ0gZnJvbSAyMDE5LTExLTE4Cmh0dHBzOi8vcHVi
bGljLWluYm94Lm9yZy9naXQvMGQ5Y2Y3NzItMjY4ZC1iZDAwLTFjYmItMGJiYmVjOWRmYzlhQHdl
Yi5kZS8KClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0
dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
