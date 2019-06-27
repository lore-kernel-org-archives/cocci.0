Return-Path: <SRS0=nFVp=U2=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13640C48BD7
	for <cocci@archiver.kernel.org>; Thu, 27 Jun 2019 14:12:50 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EA082064A
	for <cocci@archiver.kernel.org>; Thu, 27 Jun 2019 14:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="QSnBJhCB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EA082064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5RECX8u003136;
	Thu, 27 Jun 2019 16:12:33 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8D8DF7782;
	Thu, 27 Jun 2019 16:12:33 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5B1D17772
 for <cocci@systeme.lip6.fr>; Thu, 27 Jun 2019 16:12:31 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5RECTmu029773;
 Thu, 27 Jun 2019 16:12:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1561644748;
 bh=OZGyxRBXcwQ9E1nPjeR9OttF6Vwc1iXOuV5W8v4LQH8=;
 h=X-UI-Sender-Class:Subject:To:References:Cc:From:Date:In-Reply-To;
 b=QSnBJhCBiEOb5XgStmd06rGQlXNZrPMJsz1Lo3o/p1sG6mBF5xEOz8Kgbt0PNeLU1
 pjt5sF1MQ8Xv7v1wZSLWye9oTWiwal4LntfTmC3H5FfjgIgSsSzVuYUgpDwOr59sgE
 vaq88tWkfhpHm/bNE5dTGaGAYOWkKxBOoOlnPX/8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.74.178]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Md4pC-1hyZx82Eny-00IE00; Thu, 27
 Jun 2019 16:12:28 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <708207db-69d7-8962-e507-cd705142d0c4@web.de>
 <f79ae892-a674-5f69-1d25-88594a89ebff@web.de>
 <alpine.DEB.2.21.1906271332240.2627@hadrien>
 <f84bb58a-916b-0d6b-64fd-7805bd8db827@web.de>
 <alpine.DEB.2.21.1906271427250.2627@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <ddc47c39-1977-fa90-2f93-72acb2303d6c@web.de>
Date: Thu, 27 Jun 2019 16:12:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1906271427250.2627@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:3YzvbS9Zlq4vDbSxOXJjW5OHf7ZwKo9B6pyWSo85PO7eRh82+M+
 WIs5QomqKhu9/mF47R10nKbtEYpPtOxIWM9CxBidBew4JpIPfHuG0qBToJZd7468Cs0wdvn
 QjyWWKkm+h/qqmYHASYIibNb7BQaVHBNlLSyA0DSFQI6p6S0w/dihcpycNrlYDhHPvISJhD
 HzvMhloU5gZA2Epv3Iytg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:khjimGeDet8=:pQmmJd+wZ36apHE6wrpVlN
 eJklz3qV0iXUQ6faZ0jdIzqz1Ryt99eQq3KLtzvlR0EJjd8E1jTiiLXWxmwg/0pM/Oupz8pKo
 LByknKUWll33y3PlAgtmke6dw0bmleU92pLzuWSLXix0EOKv09QgF9Y0OSb4qBdZK1Iaedcbe
 f8rKWB4SV2iWn9KqeWZRlsJGl+0jl7um3afeVEJ1TfbXUpHQEftI45MT+A+KwetFF2aFW7R3M
 nJu2ek6GmQkF13Qizw8LLkX+zho1FhqbKQIWnlAyi8+kFvOrZwQ4eABoBPnIeYioOc8jGeO7X
 w575dJpwhaEbh5Zros9OcyWQCklDV4FW6rDkjfSC9kH744Cu6vv5i1QEmhebFyVerlyTUGrk4
 C5Gv5mYpzYhd65u6Wee96ENIuXsCc6IKQqc5kiduund6MbsGrHdHqqFIh7RlR3KmmZT/7KJDq
 bee+PYAMQD9kwrxe22iiqpf59IQWTev3R5IBU3W324NIefbsloAL7EljA94cY7qLsOR6dM6xN
 /5acaSL4BKA42L75vfeSNcSNFVHf4TO0TXNnsP6qzNsplBG2kRiV92iCPLWoqkgSGVQ/1OERK
 BGTqMz9od4upRLaA4wy0pJtJJx23EclIbXUOQWbrUZy7CQKxacrUkTfZKQJ9Z2zHhk5YYUeyz
 pEB2Op/Cx0DWEny8E/9Z1O0ifjhoWItoGh+YQPcfa0kGsZajqowbfrjNo3exlB0aIVeBP8+TT
 AM27Ww2ttfTMTfaGwFmRDsu5CeUKyyHnQ5Z7xbhdmTccG6lO9H8TJ/oZBkXpfmXahHJH7863V
 GcQ+GEo99GwGjfjBQZ0LfBc8qwcrAXClupFg92N+2s1TcxQWqWrf4oo3FYiEG1f61jeh5AaXe
 RF5BrJBhdfWE8Yt1g81/LrfNxHliPl7AK6p7lkedgw54aWHOoRWsORPponwncRPlVgCfK/s5K
 FZvwDvRzldeuJEcJObc1HlVgEIAB5ex0lz6O/LTRmC9aoSwyHTJgFzcr1vdea+FkJrCzsaWa1
 6+pgxAB9E7Mw1aA0bOByFI4eRWNx/4lZIvu4yxXaR+xSorGP+VoIZj6oubl9ILUn+P37UJj1O
 +KECF3lKnECqtboW9U8OYFkC4rS85pgT/oh
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 27 Jun 2019 16:12:34 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 27 Jun 2019 16:12:30 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Moving exception handling code to the end of a function
 implementation with SmPL?
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

Pj4gcmVwbGFjZW1lbnQ6IGFscmVhZHkgdGFnZ2VkIHRva2VuOgo+Cj4gWW91IHRyeSB0byBhZGQg
dHdvIHRoaW5ncyBvbmUgb25lIHRva2VuLCB3aGljaCBpcyBub3QgYWxsb3dlZC4KCkhvdyBkbyB5
b3UgdGhpbmsgYWJvdXQgdG8gY2xhcmlmeSB3aHkgYSBzb3VyY2UgZmlsZSBhZGp1c3RtZW50Cmxp
a2UgdGhlIGZvbGxvd2luZyBjYW4gbGV0IG15IFNtUEwgc2NyaXB0IHN1Y2NlZWQgaW4gYSB0ZXN0
IGNvbmZpZ3VyYXRpb24/CgplbGZyaW5nQFNvbm5lOn4vUHJvamVrdGUvQ29jY2luZWxsZS9Qcm9i
ZT4gZGlmZiAtdSBtZWdhcmFpZF9zYXMtZXhjZXJwdDEuYyBtZWdhcmFpZF9zYXMtZXhjZXJwdDIu
YwrigKYKQEAgLTMyLDI0ICszMiw3IEBACiAJCWdvdG8gb3V0X2tmcmVlX2lvYzsKIAl9CgotCWlm
IChpbnN0YW5jZS0+dW5sb2FkID09IDEpIHsKLQkJZXJyb3IgPSAtRU5PREVWOwotCQlnb3RvIG91
dF9rZnJlZV9pb2M7Ci0JfQotCi0JaWYgKGRvd25faW50ZXJydXB0aWJsZSgmaW5zdGFuY2UtPmlv
Y3RsX3NlbSkpIHsKLQkJZXJyb3IgPSAtRVJFU1RBUlRTWVM7Ci0JCWdvdG8gb3V0X2tmcmVlX2lv
YzsKLQl9Ci0KLQlpZiAgKG1lZ2FzYXNfd2FpdF9mb3JfYWRhcHRlcl9vcGVyYXRpb25hbChpbnN0
YW5jZSkpIHsKLQkJZXJyb3IgPSAtRU5PREVWOwotCQlnb3RvIG91dF91cDsKLQl9Ci0KLQllcnJv
ciA9IG1lZ2FzYXNfbWdtdF9md19pb2N0bChpbnN0YW5jZSwgdXNlcl9pb2MsIGlvYyk7Ci1vdXRf
dXA6Ci0JdXAoJmluc3RhbmNlLT5pb2N0bF9zZW0pOworLy8gRGVsZXRlZCBwYXJ0Cgogb3V0X2tm
cmVlX2lvYzoKIAlrZnJlZShpb2MpOwoKCldoZXJlIGRpZCB0aGUgQ29jY2luZWxsZSBzb2Z0d2Fy
ZSBnZXQgdGhlIGltcHJlc3Npb24gdGhhdCBhbnl0aGluZwp3b3VsZCBiZSBhZGRlZCB0b28gb2Z0
ZW4gYXQgdGhlIGVuZCBvZiBzdWNoIGEgZnVuY3Rpb24gaW1wbGVtZW50YXRpb24/CgpSZWdhcmRz
LApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
Q29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUu
bGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
