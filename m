Return-Path: <SRS0=MFMu=54=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B940CC2BA2B
	for <cocci@archiver.kernel.org>; Sun, 12 Apr 2020 16:53:11 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 062B9206C3
	for <cocci@archiver.kernel.org>; Sun, 12 Apr 2020 16:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="fm3S7tma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 062B9206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03CGqvi2001823;
	Sun, 12 Apr 2020 18:52:57 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1334B77F9;
	Sun, 12 Apr 2020 18:52:57 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5960A775A
 for <cocci@systeme.lip6.fr>; Sun, 12 Apr 2020 18:52:55 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03CGqsJY007277
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Sun, 12 Apr 2020 18:52:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1586710373;
 bh=RCuV1Z7yqFyXpoPSJBc6sgV40IuZAVto4sLQfKzQX8k=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=fm3S7tmawRyOP7PkiI7C4adSKXZ0SqyNQLPdUekicUdHu/1K/LTLYunmxsKqL4WqK
 nJBHCvEv8OjifQGzR045Iknw9edO3rQwO/DNeDnKeZ6A2LffqM6RCi4QBLYzH5X56C
 dx1FT7w8vzzV68KLjnhjnnn0Nxq1fR0ikI9ijUBE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.125.27]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lm4Z3-1ioL240Pbd-00Zk2n; Sun, 12
 Apr 2020 18:52:53 +0200
To: Julia Lawall <julia.lawall@inria.fr>
References: <146360ce-9cfb-e6f5-1601-fa95460c2cd5@web.de>
 <alpine.DEB.2.21.2004101712080.3039@hadrien>
 <f0b37f45-5144-a1c5-3f52-5bfbb6f3635f@web.de>
 <alpine.DEB.2.21.2004111600560.2369@hadrien>
 <fcbca1d9-7375-b488-54b2-a3934b90c6ed@web.de>
 <alpine.DEB.2.21.2004112036270.2369@hadrien>
 <d878a25d-29fd-28b1-fa6f-2e0f44763d73@web.de>
 <alpine.DEB.2.21.2004121050210.2419@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <ab6d402e-3c12-25ab-162a-f200c382dd0a@web.de>
Date: Sun, 12 Apr 2020 18:52:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2004121050210.2419@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:UIJJWR3eDC8+4NlQSHI++R46pHpuqvEVk867T6SueKCXeBQSSSU
 12IzzD5h9ZIV48QnoLHAv0MiUSAElJC0vVKUx39D+gejIYLkClu5BiHQS0N+b6NQ1Z8KPNR
 zLn1yUYqu5PoAiKNWkYKI7UbcAmBf9y1HMlhR/j0xEPzeoWz+x6tnbm2PrBrDf6GKlzzoR5
 na7THxnvmpYyLjpm/e8fQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:39UKEm/27cQ=:UzgQoB+F1PcVXvHxFLTQEy
 YVsrL434NMforuRJ58TKIaS0a9p4bGLh8KKhg71ApPiL0E9+zw7AEAbiIliE3gY6hjvAI0DGo
 Yd1ow/LUsV/1GgpVLt/pU4Cm0sUHnfRrR8x+7/1W+7KF/j8Z9wkr0sYpiS6NNaSS+5puOgVfw
 AJbGHGYFjooHvPd0TlM0nKLsYW5YVR8RTpDic1Tkkjr+SKFejzT0F81NUm+JNPRKFlJ1mf/mN
 Iwoi9u4EtimqMQbrPpsEyOFqLrKHByDX3rzTxrufzY6hsOWgdIq80h5KQFGu+7F4mLXvQpaYp
 g99v6YVSywTRTIGo7VbgtyKz+WGvLqoJ231lYsG9QqBXNqIq8Jc4B7VEVl5JyqgIoIeTpg10x
 UVxjMdfllgYJDJGMqIm/8W6Q3ffioXhcETVIFZyCM3jXvImPvUkEiaUq7xhbhtrG5R9hAXIBC
 TfkczIjncD58jBB1bzap6ByGRnKOjpbpLv6y8YsCBoZqNAV0UjMWSibRQ+ZnJza3JyQJ2tEKq
 ZFs/bMUAz3lXUwC/EV6Gc7AhxHDKZ11wpnKW1BTd/4L+8yT98kWGMnTHQC8egJykURKzuqIBB
 6f7Mfg99pAbnwbHKTcbjgwu+Be6M6ulyWB4t0Dk4j0nTMv/xJyUMKREGinxUVv87J61wjRERT
 S1VFweIjBRMRTToS9/Af8Fz+MD21twjGxzgDgLUzZwWzg5rYlG50ZDb6dTXeP8ma5rL3k3sM/
 wvXH88F5y2Rqx7IkKcgVPIBPkr+Lg0K5mdBfq6iBHOhxpZp5rtJ4BS+ZdKnSN6aOmhhSu++dn
 pv+36jDP0Du7rh2a6IoAwcdlC/nJZlCSVy1oHqc0WkJNIPr43nPEBHnWWXjP2dYZ6hI7t08fT
 3pyxCER8iCsffjBwpqUF+VrwMxTheM1Q3peBTFvVYTyzaVRsE0ZIuIPgAKDfg7tcPfxB7wB7k
 A/rVvwcDja1oETNNl7x6O2fM9HMBPYbMT3bqu6a2rtdu4CtghutJHmzSCLrYOG22MNKTQi1p6
 0EHF/08EPnBTVhvvU9rrGxZG/52D1wBRulK2l84HgfDwTvTMaaPZ+ZmQnaNTkbiKzRRt6yFdI
 0beF/RS6k/WeGLk6D4tK/xLSnI3AjBdYddzACDZTwwgtOIhYKLz4ViHvWFwBCmy2NqO6ZjRgY
 1GSeTWWkC02gpsFLquGtJp4sAlFYCOrGvLnwvRsc+dmb1UYH0VIcdArsRJR4BHE6GjWVJGYYR
 +s+drV05jNLQaAk0K
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 12 Apr 2020 18:52:57 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 12 Apr 2020 18:52:54 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] More support for SmPL data processing with databases?
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

PiBJIHRoaW5rIHRoYXQgeW91ciBpc3N1ZSBhYm91dCBzb21ldGhpbmcgbWF0Y2hpbmcgb3Igbm90
IGhhcyBub3RoaW5nIHRvIGRvCj4gd2l0aCB0aGUgZGF0YWJhc2UgY29kZSwgYW5kIHlvdSBjb3Vs
ZCBlYXNpbHkgcmVtb3ZlIGl0IGZvciB0aGUgcHVycG9zZXMgb2YKPiByZXBvcnRpbmcgYSBjb25j
ZXJuIHdpdGggQ29jY2luZWxsZS4KClNvZnR3YXJlIGV2b2x1dGlvbiBjYW4gYmUgY29udGludWVk
IGFsc28gdG9nZXRoZXIgd2l0aCB5b3VyIGNvbnN0cnVjdGl2ZSBmZWVkYmFjay4KCkkgYWRhcHRl
ZCBhbm90aGVyIFNtUEwgc2NyaXB0IGFjY29yZGluZyB0byBhIHJlY2VudCBpbmZvcm1hdGlvbi4K
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvY29jY2kvMTdhNDU5MmItOTJiZC1lNGM5LTg0ODEtN2Q0
NjYxNmNiMWQwQHdlYi5kZS9ULyNtNGY1OTcyMWQyMDExYWM0ZGVkNjAyZjJlNjNlMGM2M2YyMmEx
NWZhOQpodHRwczovL3N5c3RlbWUubGlwNi5mci9waXBlcm1haWwvY29jY2kvMjAyMC1BcHJpbC8w
MDcxMzMuaHRtbAoKSXQgY2FuIGJlY29tZSBtb3JlIGludGVyZXN0aW5nIHRvIGluY3JlYXNlIGFs
c28gdGhlIGFwcGxpY2F0aW9uIG9mIFNtUEwgY29uanVuY3Rpb25zCmxpa2UgdGhlIGZvbGxvd2lu
Zy4KCkBmaW5kQApleHByZXNzaW9uIGFjdGlvbiwgY2hlY2ssIHJlc3VsdDsKcG9zaXRpb24gcDsK
c3RhdGVtZW50IGlzLCBlczsKQEAKIHJlc3VsdCA9IGFjdGlvbiguLi4pOwogaWZAcCAoCigKICAg
ICAgPCsuLi4gcmVzdWx0IC4uLis+CiYgICAgIGNoZWNrCikgICAgICkKICAgICBpcwogZWxzZQog
ICAgIGVzCgoKTm93IEkgc3R1bWJsZSBvbiBjb3JyZXNwb25kaW5nIHNvZnR3YXJlIGRldmVsb3Bt
ZW50IGNoYWxsZW5nZXMuCgplbGZyaW5nQFNvbm5lOn4vUHJvamVrdGUvTGludXgvbmV4dC1wYXRj
aGVkPiBzcGF0Y2ggfi9Qcm9qZWt0ZS9Db2NjaW5lbGxlL2phbml0b3IvbGlzdF9jb25kaXRpb25f
Y2hlY2tzX2FmdGVyX2Z1bmN0aW9uX2NhbGxzMi5jb2NjaSBkcml2ZXJzL2dwdS9kcm0vbWNkZS9t
Y2RlX2Rydi5jCuKApgpVc2luZyBTUUxBbGNoZW15IHZlcnNpb246CjEuMy4xNQrigKYKc3FsYWxj
aGVteS5leGMuSW50ZWdyaXR5RXJyb3I6IChzcWxpdGUzLkludGVncml0eUVycm9yKSBVTklRVUUg
Y29uc3RyYWludCBmYWlsZWQ6IHBhaXJzLmZ1bmN0aW9uLCBwYWlycy5zb3VyY2VfZmlsZSwgcGFp
cnMubGluZSwgcGFpcnMuY29sdW1uCltTUUw6IElOU0VSVCBJTlRPIHBhaXJzIChmdW5jdGlvbiwg
c291cmNlX2ZpbGUsIGxpbmUsICJjb2x1bW4iLCBhY3Rpb24sICJjaGVjayIpIFZBTFVFUyAoPywg
PywgPywgPywgPywgPyldCuKApgoKCkkgaG9wZSB0aGF0IGl0IGNhbiBiZWNvbWUgZWFzaWVyIHRv
IGNsYXJpZnkgd2hlcmUgdW5leHBlY3RlZCBkdXBsaWNhdGUga2V5cwp3b3VsZCBvY2N1ciBhcyBp
biBteSB0ZXN0IGFwcHJvYWNoLgoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0
ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2Nj
aQo=
