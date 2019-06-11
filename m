Return-Path: <SRS0=MjcO=UK=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5B5C43218
	for <cocci@archiver.kernel.org>; Tue, 11 Jun 2019 07:51:12 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D32C2053B
	for <cocci@archiver.kernel.org>; Tue, 11 Jun 2019 07:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Ft9RnMEx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D32C2053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5B7ot5l005192;
	Tue, 11 Jun 2019 09:50:55 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4AD97775D;
	Tue, 11 Jun 2019 09:50:55 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 097625852
 for <cocci@systeme.lip6.fr>; Tue, 11 Jun 2019 09:50:53 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5B7oOMM014519;
 Tue, 11 Jun 2019 09:50:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1560239421;
 bh=CKV/rOj5u6CK/65YmBBWy6Vq0st8cYjLK/p3B4k9QAs=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=Ft9RnMEx2thoYOZ4OURc0agz88rNb2lt9VfjnJoFlR8LjiEdVAVPgtZuWrpPotSjy
 dlfgne5mtuXXf4PMtmx9lWkjRXmnqxLem8a/6ptDV/qOcUskkfgwutnnR4FrwS/JfX
 HzVuwOLcCCsyzkRSWlKIKSivEUpbYQIt7NTsTYzU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.4] ([78.48.16.56]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MKrOS-1habXx2INs-0007wr; Tue, 11
 Jun 2019 09:50:21 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <4a6a6c17-5190-f2ad-d1ed-981e55fffe4f@web.de>
 <alpine.DEB.2.21.1906102257030.2636@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <169696ef-4868-14e7-6afd-f3e4b458fa47@web.de>
Date: Tue, 11 Jun 2019 09:50:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1906102257030.2636@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:hhp9/8SXsL8W5HDcBJdhYkwDBn1F9RBRMQ0ijIZbksOdRjKAui0
 c2UoWJMyXwjALgrJH4Bh3LVLxSlZZOnFFd1u88cvnHt+v5ChKmb8ROvJuePAYPOQCYM0zZQ
 QI3Qw1OGmb+jXoy4DcavUtEYeZpwkck12w45TXmnasm3Q31f69xhhrDCi73o213FH9A6YlJ
 isOgOTm65J/TE8mS17qmw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gRdh/HQX2Q0=:vvP4w32ax5W9wtuW1maH/H
 UJ81YPtGSH+Shu4UBoZ+qTxKORq/leHLge10IDkZPqMmii6hneHPvwP9s1YMoCznagSuLttCg
 JFoMG3aI9/dEtThokeoqZtgtiCDNjKXgNuJGxmxysY87yyMnJmKQ8oKXjhcTdQYcU+fGFij9p
 LFZoNVcG9Xbp2NJ8XyE7eRRGyLONP1Xb4b+qz7qHVnnobEsapXnSNnCP86KCpbZu0Hus94xUo
 xNlhg/YmRbDhR3sV6bbqAjfdO1KDsxKzk5Tnly7isjsSPvfuSQhHTTjS/nffQ09NYywLWenNx
 2AaOZsoWgPw0gRgE8FjxZZVqYjp+hgq3inAfUn/uhXNgLNZMWe5CsXgi3L3Hoj0w3B9v9K8G8
 CPvxz+2yrbXidmymvNhy7QYv8V1eglTpxhUkt7QhphMrSDwqZAQbTSFRR6IHzLe4rvN52ia9S
 8xtht6NB04I9vhtyI1sqwSOM6Hn/weKggb3cZIcnbFnAEr6M+E99TflkqDyZw5fS4VonxBQGi
 uKB7nhK0yNunZieUYQ8CDqB8A+iqLFyFw74q8hsGtqc/O3PcuAiGfCQ3gzlkZl/II3jaQjSC+
 LyaiNbjiIAO5RBi9fKs7P7rk9MjAt8ynobrzW1aWAHI485XLwTxJ0+mHbWkd+YGwuK7f80ZFc
 KD02h4+bnhcERS1pPFMxD6/Pwv9RVLcdaY5+EgmSWYCTR08FJg1fCV8fqn52SQbIhiw8Y7ikp
 XU69tKvMHKiiUxmMlk/Dv0xWyi60rSLh+mQh1YW4CYhUqECCLauCJkVcVPbb9fyQh1cAzSB6J
 UhXYMFL7e4jk21cyMwbbqxuljs+wnLzUc+wx5uIA4QYsyWe6l0Lougm72G/WObrSHr/zvAat6
 aCx+fYbhfmzo5b1KhrXuv8b2Aij9HMa7Xk+xi5Of7a2qiEE4HB5mMzevmPfaavw5DMsHnpPtb
 2QlFNhRL4zxO1SelCP2+uEKuMgfJVh7NQjjcqsyF/lsx2vIJ3Qmy5
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 11 Jun 2019 09:50:55 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 11 Jun 2019 09:50:24 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Working with pipes for parallel SmPL data processing?
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

CgpBbSAxMC4wNi4xOSB1bSAyMzowMCBzY2hyaWViIEp1bGlhIExhd2FsbDoKPgo+Cj4gT24gU3Vu
LCA5IEp1biAyMDE5LCBNYXJrdXMgRWxmcmluZyB3cm90ZToKPgo+PiBIZWxsbywKPj4KPj4gVGhl
IENvY2NpbmVsbGUgc29mdHdhcmUgc3VwcG9ydHMgYWxzbyBhIHZhcmlhbnQgb2YgcGFyYWxsZWwg
ZGF0YSBwcm9jZXNzaW5nCj4+IGFmdGVyIHRoZSBwYXJhbWV0ZXIg4oCcLS1qb2Jz4oCdIHdhcyBw
YXNzZWQuCj4+IGh0dHBzOi8vZ2l0aHViLmNvbS9jb2NjaW5lbGxlL2NvY2NpbmVsbGUvYmxvYi83
ZWMzMWVkMWZhZGY3MzhiYzQ4N2NjZWZkYzYzYmZlMDU5OGY0NGNjL2RvY3MvbWFudWFsL3NwYXRj
aF9vcHRpb25zLnRleCNMNzQ1Cj4+Cj4+IEl0IGlzIG5pY2Ugd2hlbiBpdCB3b3JrcyB0byBkaXN0
cmlidXRlIGFuYWx5c2lzIG9uIHNvdXJjZSBmaWxlcyB0byBzb21lIHByb2Nlc3NvcnMuCj4+IFVu
Zm9ydHVuYXRlbHksIHVuZGVzaXJhYmxlIHNvZnR3YXJlIGJlaGF2aW91ciBjYW4gYmUgb2JzZXJ2
ZWQgaWYgYSBkYXRhYmFzZQo+PiBsaWtlIOKAnFBvc3RncmVTUUwgMTEuMy03LjHigJ0gd291bGQg
YmUgdXNlZCBpbiBzdWNoIGEgc3lzdGVtIGNvbmZpZ3VyYXRpb24uCj4+IFRodXMgSSBpbWFnaW5l
IHRoYXQgaXQgY2FuIGJlIG9jY2FzaW9uYWxseSBhcHByb3ByaWF0ZSB0byBwZXJmb3JtIGRlc2ly
ZWQKPj4gcGFyYWxsZWwgZGF0YSBwcm9jZXNzaW5nIGJ5IHRoZSB1c2FnZSBvZiBhIGRldGFpbGVk
IHBpcGVsaW5lIGluc3RlYWQuCj4+IGh0dHBzOi8vb2NhbWwuZ2l0aHViLmlvL29jYW1sdW5peC9w
aXBlcy5odG1sCj4+Cj4+IEhvdyBkbyB5b3UgdGhpbmsgYWJvdXQgYW5vdGhlciBhcHBsaWNhdGlv
biBmb3IgdGhpcyBraW5kIG9mCj4+IGludGVyLXByb2Nlc3MgY29tbXVuaWNhdGlvbj8KPgo+IFdo
ZW4geW91IHVzZSAtaiwKCndpdGggYSB2YWx1ZSBiaWdnZXIgdGhhbiBvbmUKCgo+IHlvdSBmb3Jr
IHByb2Nlc3NlcyB0aGF0IHRodXMgdGhlIGNoaWxkIHByb2Nlc3NlcyB3cml0ZSB0bwo+IGEgZGlm
ZmVyZW50IHJlZ2lvbiBvZiBtZW1vcnkgdGhhbiB0aGUgcGFyZW50IHByb2Nlc3MuCgpUaGlzIGNh
biBiZS4KCkJ1dCBzdWNoIGZvcmtlZCBwcm9jZXNzZXMgaGF2ZSBnb3QgYWNjZXNzIGFsc28gdG8g
Y29waWVkIGRhdGEKZnJvbSB0aGUgdGhlIHBhcmVudCBwcm9jZXNzLgoKCj4gSSBkb24ndCBoYXZl
IGFueSBpbnRlcmVzdCBpbiBjb25uZWN0aW5nIENvY2NpbmVsbGUgdG8gYSBkYXRhYmFzZSwKCkkg
YW0gY3VyaW91cyBpZiBhbnkgb3RoZXIgdXNlcnMgb2YgeW91ciBzb2Z0d2FyZSBjYW4gYWRqdXN0
CnRoZSBjb3JyZXNwb25kaW5nIGRldmVsb3BtZW50IGludGVyZXN0cy4KCgo+IHNvIEknbSBub3Qg
Z29pbmcgdG8gc3BlbmQgYW55IHRpbWUgb24gZGVidWdnaW5nIHlvdXIgaXNzdWUuCgpJIGhvcGUg
dGhhdCBjb2xsYXRlcmFsIHNvZnR3YXJlIGV2b2x1dGlvbiBjYW4gaGFwcGVuIGlmIG1vcmUgYWR2
aWNlcwp3aWxsIGJlIHRha2VuIGJldHRlciBpbnRvIGFjY291bnQgZnJvbSBleGlzdGluZyBzb2Z0
d2FyZSBkb2N1bWVudGF0aW9uLgpodHRwczovL2RvY3Muc3FsYWxjaGVteS5vcmcvZW4vMTMvY29y
ZS9wb29saW5nLmh0bWwjdXNpbmctY29ubmVjdGlvbi1wb29scy13aXRoLW11bHRpcHJvY2Vzc2lu
ZwoKClRoZSBkYXRhIHN0b3JhZ2UgaXMgd29ya2luZyBhbHJlYWR5IGlmIGtub3duIGRhdGFiYXNl
IGNvbm5lY3Rpb25zCndvdWxkIGJlIHBlcmZvcm1lZCBvbmx5IGJ5IGEgc2luZ2xlIHByb2Nlc3Mg
KGluc3RlYWQgb2YgYmFja2dyb3VuZCBwcm9jZXNzZXMpLgoKCj4gTWF5YmUgeW91IGNhbiB1c2Ug
YSBoYXNodGFibGUsCgpJIHdvdWxkIGZpbmQgYW4gb3RoZXIgZGF0YSBzdHJ1Y3R1cmUgbW9yZSBo
ZWxwZnVsIGZvciB0aGUgc3RvcmFnZQpvZiBhbmFseXNpcyByZXN1bHRzIGZyb20gcGFyYWxsZWwg
c291cmNlIGNvZGUgcHJvY2Vzc2luZy4KCgo+IHRoZW4gdXNlIG1lcmdlIGluIGEgZmluYWxpemUs
CgpUaGFua3MgZm9yIHN1Y2ggZmVlZGJhY2suCgoKPiBhbmQgdGhlIHdyaXRlIHRoZSBpbmZvcm1h
dGlvbiB0byB0aGUgZGF0YWJhc2UgaW4gdGhlIHBhcmVudCB0aHJlYWQuCgpUaGlzIGlzIGFsc28g
bXkgc29mdHdhcmUgZGV2ZWxvcG1lbnQgaWRlYSBmb3Igd29ya2luZyB3aXRoIGEgZGV0YWlsZWQK
cHJvY2VzcyBwaXBlbGluZS4KCgo+IFRoZSB1c2Ugb2YgbWVyZ2UgaXMgaWxsdXN0cmF0ZWQgaW4g
ZWcgdGVzdHMvbWVyZ2VfdmFycy5jb2NjaQoKSSB3b3VsZCBhYm91dCB0aGUgZGV0YWlsIHRoYXQg
YSB0ZXN0IHNvdXJjZSBmaWxlIGlzIGVtcHR5IGhlcmUuCmh0dHBzOi8vZ2l0aHViLmNvbS9jb2Nj
aW5lbGxlL2NvY2NpbmVsbGUvY29tbWl0LzAyMDcwMDFiNTI0MTA5MmU3YjIyY2Y0Zjk5YjIyZGIx
M2MwMWEyNGQjZGlmZi0yNzg2MmExZmUxM2I2M2U4NzFiMzU4ZTlmYzU0YjNiNwoKSSBmaW5kIHRo
ZSB1c2FnZSBvZiBDb2NjaW5lbGxlJ3MgbWVyZ2UgZnVuY3Rpb25hbGl0eSB1bmNsZWFyIGF0IHRo
ZSBtb21lbnQuCkNhbiBzdWNoIGFuIGFyZWEgYmVjb21lIGJldHRlciBkb2N1bWVudGVkPwoKUmVn
YXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0
ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
