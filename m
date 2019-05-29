Return-Path: <SRS0=gowI=T5=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50367C28CC1
	for <cocci@archiver.kernel.org>; Wed, 29 May 2019 20:32:04 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF70F2415A
	for <cocci@archiver.kernel.org>; Wed, 29 May 2019 20:32:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF70F2415A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4TKVqcO017300;
	Wed, 29 May 2019 22:31:52 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id CFAB37762;
	Wed, 29 May 2019 22:31:51 +0200 (CEST)
Received: from osiris.lip6.fr (osiris.lip6.fr [132.227.60.30])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4A26D7756
 for <cocci@systeme.lip6.fr>; Wed, 29 May 2019 22:31:48 +0200 (CEST)
Received: from poleia.lip6.fr (poleia.lip6.fr [132.227.201.8])
 by osiris.lip6.fr (8.15.2/8.15.2) with ESMTP id x4TKVlbq009033;
 Wed, 29 May 2019 22:31:47 +0200 (CEST)
Received: from newmail.lip6.fr (localhost [127.0.0.1])
 by poleia.lip6.fr (Postfix) with ESMTPA id 9A669672841;
 Wed, 29 May 2019 22:31:47 +0200 (CEST)
MIME-Version: 1.0
Date: Wed, 29 May 2019 22:31:47 +0200
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Timur Tabi <timur@kernel.org>
In-Reply-To: <CAOZdJXX_if3sa_qrVRPF-wpwEmM-_Yb=45gr+ZF==PUA3B79dA@mail.gmail.com>
References: <CAOZdJXUYqKX6KEwzXqMR-Wq-gsdHOZzHu9O--5HD2gmb56O36g@mail.gmail.com>
 <alpine.DEB.2.21.1905242147210.2514@hadrien>
 <CAOZdJXXV0a7VgRvLcYvzLZrPzVNsr6+WAxf4e6HDsE+U59zShA@mail.gmail.com>
 <alpine.DEB.2.21.1905242211550.2514@hadrien>
 <CAOZdJXUK1BvbfrG2KTW4r-36A115izB+cYwuaAQ8xTmu5WMHHA@mail.gmail.com>
 <CAOZdJXX_if3sa_qrVRPF-wpwEmM-_Yb=45gr+ZF==PUA3B79dA@mail.gmail.com>
Message-ID: <fad7175b0c56154744004ef4a6ad248c@lip6.fr>
X-Sender: Julia.Lawall@lip6.fr
User-Agent: Roundcube Webmail/1.3.9
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 29 May 2019 22:31:52 +0200 (CEST)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.4.3
 (osiris.lip6.fr [132.227.60.30]); Wed, 29 May 2019 22:31:47 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.30
Cc: cocci <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking if a line of code *does not* exist
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

TGUgMjkuMDUuMjAxOSAyMjoyNiwgVGltdXIgVGFiaSBhIMOpY3JpdMKgOgo+IE9uIFdlZCwgTWF5
IDI5LCAyMDE5IGF0IDI6MzMgUE0gVGltdXIgVGFiaSA8dGltdXJAa2VybmVsLm9yZz4gd3JvdGU6
Cj4+IG1pbnVzOiBwYXJzZSBlcnJvcjoKPj4gICBGaWxlICIvaG9tZS90dGFiaS9ib2FyZG9iai5j
b2NjaSIsIGxpbmUgMTQsIGNvbHVtbiAxLCBjaGFycG9zID0gMTM1Cj4+ICAgYXJvdW5kID0gJ3wn
LAo+PiAgIHdob2xlIGNvbnRlbnQgPSAgfAo+IAo+IEkgZGlkIHNvbWUgcmVhZGluZyBvZiB0aGUg
ZG9jdW1lbnRhdGlvbiBhbmQgY2FtZSB1cCB3aXRoIHRoaXMuICBJCj4gdGhpbmsgaXQncyBpbiBp
bXByb3ZlbWVudCwgYnV0IGl0IHN0aWxsIGRvZXNuJ3Qgd29yay4KPiAKPiBAQAo+IGlkZW50aWZp
ZXIgZnVuYzsKPiBmcmVzaCBpZGVudGlmaWVyIGxhYmVsID0gZnVuYyAjIyAiX2V4aXQiOwo+IHR5
cGUgVDsKPiBleHByZXNzaW9uIHg7Cj4gc3RhdGVtZW50IFM7Cj4gQEAKPiBmdW5jKC4uLikgewo+
IDwrLi4uCj4gIHggPQo+ICgKPiAgKFQpCj4gIFwoTUFDUk8xXHxNQUNSTzJcfE1BQ1JPM1wpCj4g
fAo+ICBcKE1BQ1JPMVx8TUFDUk8yXHxNQUNSTzNcKQo+ICkKPiAgKC4uLik7Cj4gKAo+ICBpZiAo
eCA9PSBOVUxMKSBTCj4gfAo+ICtpZiAoeCA9PSBOVUxMKQo+ICt7Cj4gKyAgICBzdGF0dXMgPSBF
UlJPUjsKPiArICAgIGdvdG8gbGFiZWw7Cj4gK30KPiApCj4gLi4uKz4KPiB9Cj4gCj4gVGhpcyBn
aXZlcyBtZToKPiAyMTogbm8gYXZhaWxhYmxlIHRva2VuIHRvIGF0dGFjaCB0bwo+IAo+IFNvIGl0
IGxvb2tzIGxpa2UgdGhlICJcKE1BQ1JPMVx8TUFDUk8yXHxNQUNSTzNcKSIgaXNuJ3QgY29ycmVj
dCwgYnV0IEkKPiBkb24ndCBzZWUgd2hhdCdzIHdyb25nIHdpdGggaXQuCgoKVGhlICsgY29kZSBo
YXMgdG8gYmUgYWRqYWNlbnQgdG8gc29tZSAtIG9yIGNvbnRleHQgY29kZS4gIFNvIHlvdSBtYXkg
Cm5lZWQgdG8gZHVwbGljYXRlIHNvbWUgICBjb2RlIGluIHRoZSBkaWZmZXJlbnQgYnJhbmNoZXMg
b2YgdGhlIApkaXNqdW5jdGlvbi4KCkp1xLppYQpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2
LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
