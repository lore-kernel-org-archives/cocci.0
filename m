Return-Path: <SRS0=A19M=S7=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2218C43219
	for <cocci@archiver.kernel.org>; Mon, 29 Apr 2019 14:42:45 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C74EE20656
	for <cocci@archiver.kernel.org>; Mon, 29 Apr 2019 14:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="TkfZV0Gn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C74EE20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3TEgTgU012850
          ; Mon, 29 Apr 2019 16:42:29 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 61C747741;
	Mon, 29 Apr 2019 16:42:29 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3F29C7732
 for <cocci@systeme.lip6.fr>; Mon, 29 Apr 2019 16:42:27 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x3TEgQhS016571
 for <cocci@systeme.lip6.fr>; Mon, 29 Apr 2019 16:42:26 +0200 (CEST)
X-pt: isis.lip6.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1556548934;
 bh=xAaLvpIXNsQKCwgvQrHkOErW+JEvemJlHu5VWEWLets=;
 h=X-UI-Sender-Class:To:References:Subject:Cc:From:Date:In-Reply-To;
 b=TkfZV0GnSVb5mraU+T1odI1SUjAQoPT2IsSKYS7Fph65dx2qRxo+zzCNXAWHd5Cxz
 cbMqoPhCPIcEEybe2LaGZekQZYIUMUcHEGGyi4OF83PvscShX6yZNUcgJcwAwrhJF4
 e4LPOG4ckD5vrz1MTV6XFmzjB4sg60Gu8Z+wtq4g=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.48.110.249]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LopeB-1grqPd1w31-00gpLY; Mon, 29
 Apr 2019 16:42:14 +0200
To: Nicholas Mc Guire <der.herr@hofr.at>
References: <20190429060512.GA16251@osadl.at>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <0c9fd263-74d0-908d-9c84-b4ce702d1601@web.de>
Date: Mon, 29 Apr 2019 16:42:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190429060512.GA16251@osadl.at>
Content-Language: en-GB
X-Provags-ID: V03:K1:it1F9JGbDri+RhQYTb0ChIvuSCXGpu/qMgHrDb+u5Lex9ANMVGF
 yKEa2+WjC2gimJFFvBhAC6HgHcc/unG7vHM8GXnLkSxacS2ub1dlsT+nTznK0HyQNsue86m
 puwPCszgQIaPrK7nVif4v5ppRUD49WrQFqvg1wd4YHfZAl65GH8S5Pa5fWLw+utz3N7xMOs
 ++Le0roZ8NArfE5hUaMJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Bm4EaA3r4gs=:YZDtw0jbvah15g2ADDCgr2
 PkxXIIFtKVvN/rsW7H8sWgWzP2fHlQ9Idw93ImeIwjXG3TQv+xtCwXPl/m2flLUdwP+z5tLD+
 Ch/nSdzu80z2n+3BkEqVgdnrUvTy4/FGbR+8Ha8nV6Oy43KieJvtUPEYh8eE0QWYGP+SubVVj
 hBS8S2XQgemDaf+q9cEa9WgscgKy3oE4XbH33tcvfW/rl0hW+4NxUQgQMfnhiBWmsn+zp57VU
 f4StR4CW+yp13eew7IoI63132oGEgKgq+559/bNbhcj0A0+wi+U+3iH7KINUcyv78Cvb3yX/p
 tpS2V/XkLcWev8yEBwjwWX8URiCwZGgAHs9lXUy3ZHDShwUSix3dj8LdEg7IXBB1g5NolW8SJ
 FoKrbHmjdgN0tbLCxsD+ArHExEJgDRImtdTND+rBVCcs+dOnLLkoEfsIUKV6X52LZz3ddQg7z
 GOQVTNiKo0dLmxfqxGw8mUPOR/KSjPBFjTsHu1F4BRnkgkK6k5vDMpu50bBI4VDr4JenH4GBW
 9HTg9vuTGbC3zk2GfGQYQNdyT95Po5fm2I4IxpRSnBD0eKqiORrAShllbIYknBIDfapmBX7B9
 4sG5v6ZYPmvKhw3aWKzOYT70ff4vzGYthRqtG14QACe5qA/VQhBuWODIAHFhk474G94aBtS0R
 JXM6ckoBcYDsX/xrvwFwDYR5MAXLEq796OZGwM3tAwFfRUZhPX4DYoBYAbmApdDG8ysfx61By
 OgXW5hZcBt0lokGK+C+9xcnI3jk+G56w6x0FMsoVPeBzzDBn1bE9qRpmw7d22SspoMQr/fDNB
 eTUPoCqMD+uuRTxpI6Ng4qVfZN2mBSp7OKFaaZswxpF39pFmav5o9v5b6CKFgcQWlW3yox9Rz
 7I59QjQiWpbsfzgtc52RX1TvCg6yZbrCjsOhwcHiqTtFTVdqnBfGyc/fbrjcvDfeGuQIPmE8X
 J4bJdzUtx/Q==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 29 Apr 2019 16:42:30 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 29 Apr 2019 16:42:26 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Detecting false positive sparse with Coccinelle
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

PiDigKYgLSB0aGUgcHJvYmxlbSB0aG91Z2ggaXMgdGhhdCBJJ20gdW5hYmxlCj4gdG8gaW5zZXJ0
IHRoZSAoX19mb3JjZSBfX2JlMTYpIGNhc3QgaW4gdGhlIHBhdGNoIHJ1bGUgYXMKPiBjb2NjaW5l
bGxlIGlzIHJlZnVzaW5nIGhvc2UgbGluZXMuIOKApgoKSXQgc2VlbXMgdGhhdCBJIGNhbiBub3Qg
aGVscCBkaXJlY3RseSB3aXRoIHRoaXMgY29uY2Vybi4gQnV0IGEgZmV3IG90aGVyCmltcGxlbWVu
dGF0aW9uIGRldGFpbHMgaW4geW91ciBhcHByb2FjaCBjYXVnaHQgYWxzbyBteSBkZXZlbG9wbWVu
dCBhdHRlbnRpb24Kb25jZSBtb3JlLgoKMS4gQSBkaXNqdW5jdGlvbiBpcyB1c2VkIGZvciB0aGUg
U21QTCBydWxlIOKAnGFjaGVja+KAnS4KICAgSSBmaW5kIHRoYXQgZHVwbGljYXRlZCBTbVBMIGNv
ZGUgY2FuIGJlIGF2b2lkZWQgdGhlcmUuCiAgIEhvdyBkbyB5b3UgdGhpbmsgYWJvdXQgdG8gc3Bl
Y2lmeSB0aGUgZGVzaXJlZCBmdW5jdGlvbiBuYW1lcwogICBieSBhIGNvcnJlc3BvbmRpbmcgU21Q
TCBjb25zdHJhaW50IG9yIGEgbmVzdGVkIGRpc2p1bmN0aW9uPwoKMi4gVGhlIGFkZGl0aW9uIG9m
IGEgY2FzdCBjYW4gYmUgc3BlY2lmaWVkIGluIGEgbW9yZSBzdWNjaW5jdCB3YXkKICAgZm9yIHRo
ZSBTbVBMIHJ1bGUg4oCcYWZpeOKAnS4KCjMuIFRoZSBzcGVjaWZpY2F0aW9uIOKAnEBzY3JpcHQ6
cHl0aG9uIGRlcGVuZHMgb24gcGF0Y2hA4oCdIG1pZ2h0IHJlc3VsdCBpbgogICB1bmRlc2lyYWJs
ZSBkYXRhIG91dHB1dC4KICAgV291bGQgeW91IGxpa2UgdG8gc2VsZWN0IGFuIG90aGVyIG91dHB1
dCBjaGFubmVsIHRoYW4KICAgZm9yIHRoZSBnZW5lcmF0ZWQgZGlmZj8KClJlZ2FyZHMsCk1hcmt1
cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBt
YWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZy
L21haWxtYW4vbGlzdGluZm8vY29jY2kK
