Return-Path: <SRS0=XtGu=TJ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1B9C04AB1
	for <cocci@archiver.kernel.org>; Thu,  9 May 2019 07:14:18 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3864021019
	for <cocci@archiver.kernel.org>; Thu,  9 May 2019 07:14:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3864021019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x497Dxa7015533
          ; Thu, 9 May 2019 09:13:59 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 60B6F773E;
	Thu,  9 May 2019 09:13:59 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A8CA67739
 for <cocci@systeme.lip6.fr>; Thu,  9 May 2019 09:13:57 +0200 (CEST)
Received: from poleia.lip6.fr (poleia.lip6.fr [132.227.201.8])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x497DvZf005015
 ; Thu, 9 May 2019 09:13:57 +0200 (CEST)
X-pt: isis.lip6.fr
Received: from newmail.lip6.fr (localhost [127.0.0.1])
 by poleia.lip6.fr (Postfix) with ESMTPA id 20C29672904;
 Thu,  9 May 2019 09:13:57 +0200 (CEST)
MIME-Version: 1.0
Date: Thu, 09 May 2019 09:13:57 +0200
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Nicolas Koenig <koenigni@student.ethz.ch>
In-Reply-To: <e31c049b-867d-5141-3563-17d528d482e7@student.ethz.ch>
References: <83363fd9-a6b1-28be-e0a7-168f205cb551@student.ethz.ch>
 <9c5ba524fec340a9c6ea8809e93ee0e8@lip6.fr>
 <e31c049b-867d-5141-3563-17d528d482e7@student.ethz.ch>
Message-ID: <d286a21bb0748830aca6644daeecce33@lip6.fr>
X-Sender: Julia.Lawall@lip6.fr
User-Agent: Roundcube Webmail/1.3.9
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 09 May 2019 09:13:59 +0200 (CEST)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 09 May 2019 09:13:57 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: seth.arnold@canonical.com, cocci@systeme.lip6.fr
Subject: Re: [Cocci] Coccinelle question
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

PiBJdCBzZWVtIHRvIG1hdGNoLiBSdW5uaW5nIHRoZSBmb2xsb3dpbmcgbGl0dGxlIHBhdGNoL3Nj
cmlwdAo+IAo+IEBACj4gdHlwZSBUOwo+IGlkZW50aWZpZXIgZm47Cj4gQEAKPiAKPiAtIFQgZm4o
Cj4gKyB2b2lkIGZuKFQgKnJldCwKPiAJLi4uKSB7Li4ufQo+IAo+IGdlbmVyYXRlcywgZm9yIGV4
YW1wbGUsIHRoZSBmb2xsb3dpbmcgZGlmZgo+IAo+IC1pbnQgZm9vKHZvaWQpIHsKPiArdm9pZCBm
b28oaW50ICpyZXQsIHZvaWQpIHsKPiAgICByZXR1cm4gMDsKPiAgfQo+IAo+IEFueSBpZGVhIHdo
YXQgdGhlIGJlc3Qgd2F5IHRvIHByZXZlbnQgdGhpcyB3b3VsZCBiZT8KCk9LLCBzb3JyeSwgSSBk
aWRuJ3Qgbm90aWNlIHRoYXQgaXQgd2FzIG9ubHkgLi4uIGluIHRoZSBtYXRjaGluZyBwYXJ0LiAg
SSAKdGhpbmsgeW91IGNvdWxkIGp1c3QgcHV0IGEgZHVtbXkgcGFyYW1ldGVyOgoKQEAKdHlwZSBU
LFQxOwppZGVudGlmaWVyIGZuLGk7CkBACgotIFQgZm4oCisgdm9pZCBmbihUICpyZXQsCglUMSBp
LCAuLi4pIHsuLi59CgpUaGF0IHNob3VsZCBtYXRjaCBjYXNlcyB3aXRoIG9ubHkgb25lIHBhcmFt
ZXRlciwgZXZlbiB0aG91Z2ggdGhlICwgCmRvZXNuJ3QgbWF0Y2ggYW55dGhpbmcuCgpqdWxpYQoK
Cj4+IAo+Pj4gVGhhbmsgeW91IGluIGFkdmFuY2UhCj4+PiAKPj4+IMKgIE5pY29sYXMKPj4+IAo+
Pj4gUC5TLjogSXMgdGhlcmUgYSBjb21tdW5pdHkgd2hlcmUgSSBjYW4gYXNrIHN1Y2ggcXVlc3Rp
b25zIHdpdGhvdXQKPj4+IGJvdGhlcmluZyBwZW9wbGUgcGVyc29uYWxseT8KPj4gCj4+IFllcywg
dGhlcmUgaXMgYSBtYWlsaW5nIGxpc3QuLMKgIFlvdSBzaG91bGQgc2VlIHRoaXMgaW4gdGhlIGNv
bnRhY3QgCj4+IGxpbmsgYXQgY29jY2luZWxsZS5saXA2LmZyLsKgIFlvdSBzaG91bGQgam9pbiB0
aGUgbWFpbGluZyBsaXN0IHNvIEkgCj4+IGRvbid0IGhhdmUgdG8gYXBwcm92ZSB0aGUgcG9zdHMu
Cj4gCj4gVGhhbmsgeW91LCBJJ3ZlIHN1YnNjcmliZWQgYW5kIGFkZGVkIHRoZSBsaXN0IHRvIHRo
aXMgdGhyZWFkCj4gCj4gICBOaWNvbGFzCj4gCj4+IAo+PiBqdWxpYQpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lA
c3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8v
Y29jY2kK
