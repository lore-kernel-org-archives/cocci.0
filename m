Return-Path: <SRS0=lOWR=SY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5911EC10F11
	for <cocci@archiver.kernel.org>; Mon, 22 Apr 2019 16:29:05 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61757214AF
	for <cocci@archiver.kernel.org>; Mon, 22 Apr 2019 16:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="XJsal31n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61757214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3MGSoFq027931
          ; Mon, 22 Apr 2019 18:28:51 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C08C07725;
	Mon, 22 Apr 2019 18:28:50 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id EAFCC7261
 for <cocci@systeme.lip6.fr>; Mon, 22 Apr 2019 18:28:48 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3MGSmGC024428
 for <cocci@systeme.lip6.fr>; Mon, 22 Apr 2019 18:28:48 +0200 (CEST)
X-pt: isis.lip6.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1555950527;
 bh=hWO7xDfhIANbVkCTXTmL4lRAn38B1SukrUsTIINb5IQ=;
 h=X-UI-Sender-Class:To:References:Subject:Cc:From:Date:In-Reply-To;
 b=XJsal31nxmR6i3DWLi22uadxL3sfpMKHBh1a26/E0Iyzp/XqexwiMgtIBPc48AqmR
 vDWv2gdwQAhFnMY+qfLhT8XK1U/OuwSQqybbLER9yEd2yYV4IroWTecIh0wPonb7jl
 4Fc/wyHubDdR5UoQiuUdTSQ/V9e8/YFH3WUa9L1U=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.132.90.186]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lcxw8-1gaRHr0THE-00iAgg; Mon, 22
 Apr 2019 18:28:47 +0200
To: Evan Zhao <tacingiht@gmail.com>
References: <CAAGQS2vWgFjbU9t9QXKgDefp1TcOnMoDwPFE0kMpU_203JXEag@mail.gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <79e7d754-f02f-d449-4090-0036274f70b5@web.de>
Date: Mon, 22 Apr 2019 18:28:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAAGQS2vWgFjbU9t9QXKgDefp1TcOnMoDwPFE0kMpU_203JXEag@mail.gmail.com>
Content-Language: en-US
X-Provags-ID: V03:K1:OZMzMkcxqEtsIEFsWnyOuWIwb7XCv+yT9IGMROZ/KbcOZozvtKd
 TS8u/+gO1wLaZ6UroUBtdEQ8Owfqvy03URvymRJHlTlayN1vACzU/IdnaEyZ2Kvyehngn3a
 T1umkTQEZTGVN22qqjyBQL1TLFU+7yjAzOyGEV22bYvWiLkPkvNvPAQjuBTqwjeNpv/g3kM
 wHDeHv40Zyi6TR9Y2VGGQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bdSCpc6tCEM=:J5/t6gkQea+oL4TjzBOsoj
 m4SmgYk8mnLRj4NJ6TiuAT+kqYo+4FwsMPFxl6zgmtzRQjJ1ND4j4E4vAKIqchEGP3nn3E4W8
 raOQbuTY8FDqKeq4L7VKPlTAyvm8WKpC+/6lXt7tlieU6m0yFrJXWAoyaApdd7xeXnCLG0EIT
 /8LboGB4sKeXVB/hyWZQ8M+jzvAfk5Lpgz3jSDUjtsauRnh89pHC3M2ByYwHZKueU+6NE0Kh7
 WeaFhNirPCS8Uz9W4n4ZWUPqXrOsPFj+Bxb/5XMAkC1J1qdGd/GbaZx3NtXgn1D6FXdgOsyE+
 vUQkbYyZnhB0jwwjoxXKkHVp3QQ3xPU5wO41luZaiEymjY3g8bl++KfcolBU0iV1/BhQfX9AE
 JhV3gL92ZJ69cSukxjSag/4yK5EVlSAF5PDGA5iY2+xhqVW8jMbWfDurIaFonDnOiYKFul3bM
 RSR3u48UPgQfA38rxzR3RcAdyMdb9kfujtI2SOdNOievkBJzjY/LcG2c2yiLIvMBf/QVVGwd6
 HD0E1lAS6LSEoFhjE53hZMlPJV+TevZpZ/CtPRVuKb8LUZENHu5UzsYvOEkYSP9qmyD43N9KH
 z3Ja+Gcm2H24Jg6Wldbp2JlcAIyqdTFqQeJE2oPp1Ip9gCc/7x6CXYWpps7svIOjVRHgIhh8U
 IbSDI9AJTLpPNV8UiVkQFhEwHf1IVkuHz/WtdhgT7WS5hGqG3qmXH/9hrN2CUAdgLTa32vBs4
 YJMb3AT8F8AWXyZICaHfMTu9aWh2MHmUT/s6UOChWdFy/Dk/DC3k6ucADHqWqpTem0qX8fRca
 9zdJa35P5HI4tNUis4Sej03tdYtgReFagqR35xBTIPVlR5P050OZg14xr2qAqmlEec/CHrkde
 dj60XHfpdLmMeoD2Wq9ZZsqL299x2ykTuO3Re17U3fmmf6U8BRWLUTMxq/kNDjblYPkyu8xaa
 7mwsfkI23xA==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 22 Apr 2019 18:28:51 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 22 Apr 2019 18:28:48 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Addition of do-while support for SmPL
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

PiBJIHdvdWxkIGxpa2UgdG8gc2hvdyB5b3UgbXkgZWZmb3J0cyBvbiBhZGRpbmcgdGhlIG1pc3Np
bmcgZG93aGlsZSBsb29wIGluIFNtUEwuCgpEbyB5b3UgcmVmZXIgdG8gdGhlIGZ1bmN0aW9uYWxp
dHkg4oCcZG8g4oCmIHdoaWxlKOKApikgbG9vcOKAnSBoZXJlPwoKVGhhbmtzIGZvciB5b3VyIGlu
dGVyZXN0IGluIHNvZnR3YXJlIGV4dGVuc2lvbnMgYWNjb3JkaW5nIHRvIHRoaXMgdG9waWMuCmh0
dHBzOi8vc3lzdGVtZS5saXA2LmZyL3BpcGVybWFpbC9jb2NjaS8yMDE1LU1heS8wMDIwMzAuaHRt
bApodHRwczovL2xvcmUua2VybmVsLm9yZy9jb2NjaS81NTU4QUUyOS42MDYwNDA3QHVzZXJzLnNv
dXJjZWZvcmdlLm5ldC8KCgo+IEkgdGhpbmsgaXQncyBydXN0aWMgYW5kIEkgY291bGQgdXNlIHlv
dXIgcHJvZmVzc2lvbmFsIHN1Z2dlc3Rpb25zCgoqIEhvdyBkbyB5b3UgdGhpbmsgYWJvdXQgcHJv
dmlkaW5nIGEgbW9yZSByZWFzb25hYmxlIGRlc2NyaXB0aW9uIGFsc28KICBpbiB0aGUgcGF0Y2gg
ZmlsZT8KCiogSSB3b3VsZCBwcmVmZXIgeW91ciByZWFsIG5hbWUgaW4gdGhlIHNpZ25hdHVyZS4K
ICBTZWUgYWxzbzoKICBodHRwczovL2dpdGh1Yi5jb20vY29jY2luZWxsZS9jb2NjaW5lbGxlL2Js
b2IvODQ4Zjg1ZTI1NjUxNjMzMGMwNmY1ZmQ4ZGM3ODJiODU0ZWQ5YWEwMy9yZWFkbWUudHh0I0w5
MAoKCj4gdG8gcmVmaW5lIHRoZSBjb2RlIGFuZCBjb21wbGV0ZSB0aGUgdGVzdCBzZXQuCgoqIFdv
dWxkIHlvdSBsaWtlIHRvIGFkZCBhIGRpcmVjdG9yeSBmb3IgeW91ciB0ZXN0IGNvbGxlY3Rpb24/
CgoqIFdpbGwgbGluZSBicmVha3MgYmUgbmVlZGVkIGF0IHRoZSBlbmQgb2YgdGV4dCBzb3VyY2Ug
ZmlsZXM/CgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpo
dHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
