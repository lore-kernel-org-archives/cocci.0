Return-Path: <SRS0=Nczh=V7=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B05DC31E40
	for <cocci@archiver.kernel.org>; Sat,  3 Aug 2019 12:33:33 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80A072085B
	for <cocci@archiver.kernel.org>; Sat,  3 Aug 2019 12:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="K/3AwsVv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80A072085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x73CX9Ea004769;
	Sat, 3 Aug 2019 14:33:09 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8E850778D;
	Sat,  3 Aug 2019 14:33:09 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 43B27768E
 for <cocci@systeme.lip6.fr>; Sat,  3 Aug 2019 14:33:07 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x73CX5a2015128
 for <cocci@systeme.lip6.fr>; Sat, 3 Aug 2019 14:33:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1564835583;
 bh=7fMAbhRlwVLqiOgPrmJ0IXhB0bTWcecXgK01xQf8Z7k=;
 h=X-UI-Sender-Class:To:References:Subject:Cc:From:Date:In-Reply-To;
 b=K/3AwsVvHyq6H8CoW87DIGJvE9zax8cLj/w2jpDqfECAyDA3r1QKjGz945iQC927t
 3ajBsi9sE/FNfM4vtcLhRjIWC2s6DdgjvjKpDIq8akS6xN2LdyevWu++E8yFWgD28k
 HkiBEGdvRGetZLowIVDpzIxOGp8VWc5WMQcNU3uY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.167.240]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M413W-1iC6Wb2ePa-00rXuV; Sat, 03
 Aug 2019 14:33:03 +0200
To: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
References: <b4c91fb8-5606-c06e-e349-5415458cf3b5@linbit.com>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <a1d13989-c4fa-9376-6727-dfe899260b16@web.de>
Date: Sat, 3 Aug 2019 14:32:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b4c91fb8-5606-c06e-e349-5415458cf3b5@linbit.com>
Content-Language: en-US
X-Provags-ID: V03:K1:fIMamCKErLgo4b4iOcFdC2eWK8hOY7ZovwS8yE9tExBlqvDkoLq
 UkX5iZAYI6tUw2wp0vXEo2Ut7XZgtPAzfecq3ubBIu/jMhdbV8k7WDECqpG8GdhOtHgIi+t
 FBFcY9zM3j/W/QDLXR/x/m4nRE9BME1u/2RugDOWotw+Ilnh6bTyiwJ2gGMuMS+Y/E9LEau
 +ezhsRNzRNd3Ws+ed5Sng==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FUtfrazBloI=:fmHfQAjkINZGzpP69/ofv0
 Gbogk1OpbWXg/Qoguz77cR7lp15v/6uE5cuGfZjroZeLdrYmf2+T+XRwogwNjTcKaCGdpWvzl
 STcVUv/q75AoJKi0NtHZk+YPf5PeIdII/HuimDiZt2+mBNqOWBVGIWSuJSfWgz9P73eA+knZ7
 ZQQvRP8iLqvXz24apsFW3i9qPv+JrNUNSE9cmvnVGS4rps5y+wkBdHRjdbC1BuWaZ2HQd43g0
 nnYxKtTQg4MTqCLTtqtZaTAjU9838XsWWLW/SIt+fr7d4HHNe3guFs5ka9UDZMk6pfbjs7WoY
 JE7v1qulDclo31GT5ncCLPypnXfJltaNWFC1JIpj1mBF3lzSXrm1yJZS/4O03YVrDheZsgGQR
 0Trz5mhKspXVLywrVVUZ+8lfQ9UC3DNnTiK30ry1B145iYQ9HhyrDqN+jXab5E9NlzezXtXXX
 7Pu/92EYxVxfBFSeDnaWJsu83UsznvsVkxvPHNUY24T0kkHxP79RTHZoYCSO2D4huKLnRcYKn
 Wz58bQJBS5KqV6MYv1RWo+gioRtBBytojEndHg9j5nQlTYnM/iDUICxJq9psvpwxrdd5Fmb/i
 ZPiHEO6iEZ2koMvyN1qcKmBeEJSeIXXF4uG3NLDG6fiwUBtrWXniWwX8O/x237uVzsJwVA9Oh
 RFKkBfLEMMXIz+ykXyMKmpaVHqqMQgUT9jBB/0zHcvs0n0K2xOgc0pX0ebX1pxI5DXYygIfm/
 w2cOgkxNcu04MQqioAu4Cd7H5pDLYJMTLah58QZ8uerinx8gLTLtgeo6yjd46+asDYZsAuU4a
 aD4hy3R/DHFUYzOXHCvsOh/d6bxISoFk5+A2MEysjNCHK4U50FEmolXC87YUjVaHwJyh4lGUJ
 M9VBcaJ3C6rBQ+LpoydmmwxCSrjkWr2a9m5nEC3h2u62UxkARW+iA0ovEwaXPYagOKKFlPvFw
 7rm72RtVsF5oFusN3rnB/ss3WuCVH7w0lSzOdKx+SAJ8TnsNabWICyWAZigRGUzqrCHQTZmS2
 83HIayrYyS5d+Tm2zDu+tbZq09pf4kroACaiGrCDqte5wNMWXjbcLcbPRpMUX2eQcusSIixbL
 rCg0WUQP28M3bnz6dEKdEoV969uD59aPEww/2LG7b+2ru/gV0Ys5A7l51FXdMbMT99zvUhGYe
 zEHbQ=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 03 Aug 2019 14:33:10 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 03 Aug 2019 14:33:06 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Make rule depend on comment
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

PiBJIGhhdmUgYSBxdWVzdGlvbiByZWdhcmRpbmcgdGhlIG5ldyAiY29tbWVudHMiIGZlYXR1cmUu
CgpJIGhvcGUgdGhhdCBmdXJ0aGVyIGNvbGxhdGVyYWwgZXZvbHV0aW9uIHdpbGwgaGFwcGVuIGFy
b3VuZCB0aGlzIGZ1bmN0aW9uYWxpdHkuCgoKPiBAIHIgQAoKPiBpZGVudGlmaWVyIGZuOwoKPiBj
b21tZW50cyBjOwoKPiBAQAoKPiBmbigpQGMKCj4gewoKPiB9CgoKKiBXaGljaCBjb21tZW50cyB3
aWxsIGFwcGVhciBiZXR3ZWVuIGEgY2xvc2luZyBwYXJlbnRoZXNpcyBhbmQgYW4gb3BlbmluZyBj
dXJseSBicmFja2V0PwoKKiBBcmUgeW91IGFsc28gbG9va2luZyBmb3IgZnVuY3Rpb24gaW1wbGVt
ZW50YXRpb25zIHdoaWNoIGFyZSBub3QgZW1wdHk/CiAgKFdvdWxkIHlvdSBsaWtlIHRvIGFkZCBh
IFNtUEwgZWxsaXBzaXMgdG8geW91ciBzb3VyY2UgY29kZSBzZWFyY2ggYXBwcm9hY2g/KQoKCj4g
VGhlIGlzc3VlIGhlcmUgaXMgdGhhdCBJIHdvdWxkIGxpa2UgdG8gdHJpZ2dlciB0aGUgcHl0aG9u
IHNjcmlwdAoKPiAoaS5lLiBzYXRpc2Z5IHRoZSAiciIgcnVsZSkgaWZmIHRoZSBjb21tZW50IGlz
IGFjdHVhbGx5IHByZXNlbnQuCgo+IENhbiBJIG1ha2UgdGhlIHJ1bGUgZGVwZW5kIG9uIHRoZSBj
b21tZW50IGJlaW5nIHRoZXJlPwoKCkl0IHNlZW1zIHRoYXQgdGhpcyBleHBlY3RhdGlvbiBpcyBu
b3QgZGlyZWN0bHkgc3VwcG9ydGVkIGJ5IHRoZSBjdXJyZW50IHNvZnR3YXJlCnZlcnNpb24gYXQg
dGhlIG1vbWVudC4KQnV0IEkgaW1hZ2luZSB0aGF0IHNvbWV0aGluZyBjYW4gYmUgYWNoaWV2ZWQg
aW4gdGhpcyBkaXJlY3Rpb24gYnkgdGhlIHVzYWdlIG9mCmEgc3VwcG9ydGVkIHNjcmlwdGluZyBs
YW5ndWFnZSB0b2dldGhlciB3aXRoIG11bHRpcGxlIFNtUEwgcnVsZXMuCkhvdyBkbyB5b3UgdGhp
bmsgYWJvdXQgdG8gdXNlIHRoZSBmdW5jdGlvbiDigJxpbmNsdWRlX21hdGNo4oCdPwooU2VlIGFs
c28gaW5mb3JtYXRpb24gZnJvbSDigJxtYW4gY29jY2lsaWIK4oCdLikKClJlZ2FyZHMsCk1hcmt1
cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBt
YWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZy
L21haWxtYW4vbGlzdGluZm8vY29jY2kK
