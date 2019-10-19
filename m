Return-Path: <SRS0=2FHN=YM=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713CDCA9EAC
	for <cocci@archiver.kernel.org>; Sat, 19 Oct 2019 19:40:28 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5624E222BD
	for <cocci@archiver.kernel.org>; Sat, 19 Oct 2019 19:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Yo5zD4Hw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5624E222BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9JJeC11002625;
	Sat, 19 Oct 2019 21:40:12 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4B28477B8;
	Sat, 19 Oct 2019 21:40:12 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 64CE57792
 for <cocci@systeme.lip6.fr>; Sat, 19 Oct 2019 21:40:10 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9JJe9ad023611;
 Sat, 19 Oct 2019 21:40:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1571514009;
 bh=K7EZ3Cx1icHseoKfN+jpBbRH8KetijHSw7CYNHlVkK8=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=Yo5zD4HwKUqVKXP+69iOY29CkamnXaZxFTv7IlsqeNKtIQcv3GVyEARhdN1Hhgi7w
 Pc/zf8S0kxIaVZh2X5gIxdJ2/nxJMRvDYgtm1pJ4/9jBOfpMhZlK+ZSvdCyEH/2f4x
 SHb6rRBjz0mr1ddDn8+eO+MMYdwWcJZ8NSkEFJI8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.29.47]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MUF50-1iU3Y31JPG-00R32w; Sat, 19
 Oct 2019 21:40:09 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <24130ec6-4a20-7be4-755f-a6dfffcb6c97@web.de>
 <alpine.DEB.2.21.1910101509370.2305@hadrien>
 <45be389f-23f9-cbff-fa5f-8ad111124f94@web.de>
 <alpine.DEB.2.21.1910181530460.3697@hadrien>
 <1a3776fe-7f18-e072-9bda-30d10ffd1c07@web.de>
 <32b67cc6-0dd9-6615-d8ed-5c2dfe2af863@web.de>
 <alpine.DEB.2.21.1910191740020.3272@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <958b4a11-e45b-3795-a3cb-08f98aaa40d6@web.de>
Date: Sat, 19 Oct 2019 21:40:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910191740020.3272@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:9bNGlDe+bsc9PAcDZnmcg3dPleD/QW7T+sVJb/em8aQ0RPLmT5r
 rnQ6sp/wb3wn+Dtp4GPlaSb6PLXQncTxPuv3anlTvwHZYqH4w615jClyo6WbIQlEjInWd7T
 oJAdW4qiP+9w2KReZGQJy1Ky+9wqieGzO+Zr/Bc4f+pTn/nRMj3y+QiJqI/+YiKjpZhBN5Q
 0io0z+MU+mI4BweSf/yig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:o8cBN1JjQrY=:iWX7JBwqwtXJ6yRMlMSR/k
 /v+bQrae1TAD0P8LRyU09mubPndsoAXrDHj8uAjqLLwm9yFhVyfQL/jF1HK241zj2vqhtxRjV
 5UP2AoreBGem530z1KTZzetLRZt6IgVG64lq2XEF4f9jOV5jLSJN0yOuXvEXuBBJndHjKLo0K
 O7iK+xh7oyqtIDeanbDeqLlfYxQvRaKUAO/gu/IDZdilFHKpnmx1m3w6Rd3p7ctqTHfSg1/bl
 0YavEuaYhh64KZAK3FcWkmkLvV1D473DSV4lRPr32EZiNr6wHIQbN5lmulpJkve1P7AfynCNy
 59f+1oEJEKJH0zcOsgyxbNkXcnPRMTZIizFpsBFfDv0nusD9iWkkPdeb200ni4a4cLYpMKUqb
 tqBU3sRTfzNMQoEeZipDD8aGIsPPgCgtN8kG46aQFkw1mzSI2FdT8jaz9N4OdFsPEiA0Af3jg
 FiNgS8403kDnRiSVW2Te9ntqdrVIprqgo50QLQyrCj70hqlVi7wIQqg27qwPPFau6yxLNHhsY
 TWyCTfIXG66kdRYq+JuzmsKiB4vFOdgbfAShCvvMb4SvfKPwOmBKoxSIJrLO0kEoS4ofCxVRY
 V60BrVIMLYOcXB1diIDQm1NcoMSQQAlUQYBOOR17Zd3SVBSQ8Q+uxWaRhfsmqWFaKKufaCHul
 U7+YrFBQzDJGsAsHKnYrBtNYKnGhSNlL7r0/Bf0VUyhr+tqPhecYpvCDKx+WVGdmQI0eY+gvi
 eBiuf3du1tnqgiA/gqlHXB1TK/7C9G1vVlTXERBhq0EeL6CZIw6JwDLcUwp3+V3czXNtDoVJJ
 tsj07VOCRD3KjSMkSYeS3KhnRi06AY8jtOWA3wJBjCNU+0TVgkTFIjV0fxa2vqXTomvxCo5j2
 uATKRTAUN30mx2slwsMeTOTin87Dnkeh6yD7Qz/rDoQ5iuzI7YIwmisiv/JDuQKU8ua/PoHDH
 dd7J1r0uDPraZwQHaEF+AxLX9qmYvqMK5q5IYMLtOxTrQE+8hFJzwcM+fjaGcPWTBWeljKhL3
 5Bc9AoJxIy4IGgx4JeQVeWGDI19qNGqpSVkhWU3RA2B1nM+1cqKFx2HuQ7j7tvpAGUPzc7CTB
 xNL1O4ZZDyKF3ijYG1XdWwh8sNmKeRuwNoSPX3Iwi3pAeabHeURxvbfE2LTebIYmUOS5feISy
 u0wgDk65I0NHuBzlXoCoYS4oxfGiEATAYtZKQrUZW7Ne0+GfyTZJmUTTajMnryU4OPr4hGtyF
 gfd8oResB5hpfk6mFO3JDUJ6TzWl0vdUlthUNsao95Wa5yqkQSYULh2i20HI=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 19 Oct 2019 21:40:12 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 19 Oct 2019 21:40:09 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Software analysis with SmPL around unchecked pointer
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

Pj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbmV4dC9s
aW51eC1uZXh0LmdpdC90cmVlL2RyaXZlcnMvZ3B1L2RybS9hcm0vZGlzcGxheS9rb21lZGEva29t
ZWRhX2Rldi5jP2lkPWM0Yjk4NTBiMzY3Njg2OWFjMGRlZjU4ODVkNzgxZDE3ZjY0YjNhODYjbjIy
Mgo+Pgo+PiDigKYKPj4gQEAgLTIyMizigKYgQEAgc3RydWN0IGtvbWVkYV9kZXYgKmtvbWVkYV9k
ZXZfY3JlYXRlKHN0cgo+Pgo+PiAgCWNsa19wcmVwYXJlX2VuYWJsZShtZGV2LT5hY2xrKTsKPj4K
Pj4gLQltZGV2LT5mdW5jcyA9IHByb2R1Y3QtPmlkZW50aWZ5KG1kZXYtPnJlZ19iYXNlLCAmbWRl
di0+Y2hpcCk7Cj4+ICAJaWYgKCFrb21lZGFfcHJvZHVjdF9tYXRjaChtZGV2LCBwcm9kdWN0LT5w
cm9kdWN0X2lkKSkgewo+PiDigKYKPj4gCW1kZXYtPmZ1bmNzLT5pbml0X2Zvcm1hdF90YWJsZSht
ZGV2KTsKPj4KPj4gCWVyciA9IG1kZXYtPmZ1bmNzLT5lbnVtX3Jlc291cmNlcyhtZGV2KTsKPj4g
4oCmCj4+Cj4+Cj4+IE5vdyBJIHdvdWxkIGFwcHJlY2lhdGUgb25jZSBtb3JlIGlmIHRoZSBkZXNj
cmlwdGlvbiBmb3IgdGhlIHN1cHBvcnRlZAo+PiBzb2Z0d2FyZSBiZWhhdmlvdXIgY2FuIGJlIGNv
bXBsZXRlZCBmb3IgdGhlIHNhZmUgdXNhZ2Ugb2YgU21QTAo+PiBjb2RlIGV4Y2x1c2lvbiBzcGVj
aWZpY2F0aW9ucy4K4oCmCj4gSSBoYXZlIG5vIGlkZWEgd2hhdCB5b3UgYXJlIGFza2luZyBhYm91
dCBoZXJlLgoKSSBob3BlIHRoYXQgYW5vdGhlciB3b3JkaW5nIGFwcHJvYWNoIGNhbiBjb250cmli
dXRlIGFub3RoZXIgYml0CnRvIGEgYmV0dGVyIGNvbW1vbiB1bmRlcnN0YW5kaW5nIG9mIHRoZSBp
bnZvbHZlZCBzb3VyY2UgY29kZQphbmFseXNpcyBleHBlY3RhdGlvbnMuCgoKPiBBcmUgeW91IGNv
bmNlcm5lZCB0aGF0IHlvdSBkb24ndCBrbm93IHRoZSByZXR1cm4gdHlwZSBvZiBtZGV2LT5mdW5j
cy0+aW5pdF9mb3JtYXRfdGFibGU/CgpObywgbm90IGluIHRoaXMgdGVzdCBjYXNlLgoKVGhpcyBt
ZW1iZXIgZnVuY3Rpb24gaXMgZGVjbGFyZWQgd2l0aCB0aGUgcmV0dXJuIHR5cGUg4oCcdm9pZOKA
nS4KaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjUuNC1yYzIvc291cmNlL2RyaXZl
cnMvZ3B1L2RybS9hcm0vZGlzcGxheS9rb21lZGEva29tZWRhX2Rldi5oI0w4MwpodHRwczovL2dp
dC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9uZXh0L2xpbnV4LW5leHQuZ2l0
L3RyZWUvZHJpdmVycy9ncHUvZHJtL2FybS9kaXNwbGF5L2tvbWVkYS9rb21lZGFfZGV2Lmg/aWQ9
YzRiOTg1MGIzNjc2ODY5YWMwZGVmNTg4NWQ3ODFkMTdmNjRiM2E4NiNuOTQKCkkgd291bGQgZmlu
ZCB0aGlzIGZ1bmN0aW9uIGNhbGwgcXVlc3Rpb25hYmxlIG90aGVyd2lzZS4KClRoZSBkZXNpcmVk
IGZ1bmN0aW9uIGlzIGRldGVybWluZWQgb3ZlciB0aGUgcG9pbnRlciDigJxtZGV2LT5mdW5jc+KA
nQp3aGljaCB3YXMgcHJvdmlkZWQgYnkgYSBjYWxsIG9mIHRoZSBmdW5jdGlvbiDigJxwcm9kdWN0
LT5pZGVudGlmeSjigKYp4oCdLgpUaGUgcHJvdmlkZWQgZnVuY3Rpb24gcG9pbnRlciBpcyBhY3R1
YWxseSBub3QgZGlyZWN0bHkgY2hlY2tlZAphZnRlciB0aGUgZGF0YSBzdHJ1Y3R1cmUgbWVtYmVy
IGFzc2lnbm1lbnQuClRoaXMgY291bGQgYmUgYW4gYW5hbHlzaXMgY29uY2Vybi4gKEJ1dCBpdCBj
YW4gYmUgZGV0ZXJtaW5lZCBieSBpbnNwZWN0aW9uCm9mIGludm9sdmVkIHNvdXJjZSBmaWxlcyB0
aGF0IGEgdmFsaWQgcG9pbnRlciB3aWxsIHByb2JhYmx5IGJlIHNldC4KSSBhc3N1bWUgdGhhdCB0
aGUgZXhjbHVzaW9uIG9mIG51bGwgcG9pbnRlcnMgd291bGQgYmUgdG9vIGNoYWxsZW5naW5nCmZv
ciB0aGUgZGlzY3Vzc2VkIHRpbnkgU21QTCBzY3JpcHQuKQoKVGhlIHVuY2VydGFpbnR5IGFyb3Vu
ZCB0aGUgcGFydGx5ICh1bilkb2N1bWVudGVkIHNvZnR3YXJlIGJlaGF2aW91cgpmb3IgU21QTCB3
aGVuIGNvbnN0cmFpbnRzIG1ha2VzIGl0IHVuY2xlYXIgdGhlbiBpZiB0aGUgcHJlc2VudGVkCnNv
dXJjZSBjb2RlIHBsYWNlIHNob3VsZCBmaW5hbGx5IGJlIHRyZWF0ZWQgYXMgYSBmYWxzZSBwb3Np
dGl2ZS4KU2hvdWxkIGl0IGhhdmUgYmVlbiBleGNsdWRlZCBiZWNhdXNlIHBvaW50ZXIgZXhwcmVz
c2lvbnMgc2hvdWxkIGJlIGRldGVjdGFibGUKZm9yIHRoZSBtZXRhdmFyaWFibGUg4oCceeKAnSAo
YSBiaXQgbGF0ZXIpPwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxp
cDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
