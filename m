Return-Path: <SRS0=6akS=O3=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C103AC43387
	for <cocci@archiver.kernel.org>; Tue, 18 Dec 2018 16:15:29 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 626EA21841
	for <cocci@archiver.kernel.org>; Tue, 18 Dec 2018 16:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 626EA21841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sysmocom.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBIGFGIO018757
          ; Tue, 18 Dec 2018 17:15:16 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4E72D740A;
	Tue, 18 Dec 2018 17:15:16 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 90A963A55
 for <cocci@systeme.lip6.fr>; Tue, 18 Dec 2018 17:15:14 +0100 (CET)
Received: from mail.sysmocom.de (mail.sysmocom.de [144.76.43.93])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBIGFDbZ003846
 for <cocci@systeme.lip6.fr>; Tue, 18 Dec 2018 17:15:13 +0100 (CET)
X-pt: isis.lip6.fr
Received: from public-mail (mail.sysmocom.de [144.76.43.93])
 by mail.sysmocom.de (Postfix) with ESMTP id B9D7F4B7DBF
 for <cocci@systeme.lip6.fr>; Tue, 18 Dec 2018 16:15:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at sysmocom.de
Received: from mail.sysmocom.de ([144.76.43.93])
 by public-mail (mail.sysmocom.de [144.76.43.93]) (amavisd-new, port 10024)
 with ESMTP id zbXbegVKOWCD; Tue, 18 Dec 2018 16:15:13 +0000 (UTC)
Received: from [10.9.1.140] (ds9.sysmocom.de [90.187.64.137])
 by mail.sysmocom.de (Postfix) with ESMTPSA id D9D454B7DAE
 for <cocci@systeme.lip6.fr>; Tue, 18 Dec 2018 16:15:12 +0000 (UTC)
To: cocci@systeme.lip6.fr
References: <0c0bf80c-56bd-6560-12b8-97a4b1b89963@sysmocom.de>
 <alpine.DEB.2.21.1812130724080.2458@hadrien>
 <346d748c-c073-7567-5547-23ec8a47c9b6@sysmocom.de>
 <alpine.DEB.2.21.1812132057380.2465@hadrien>
From: Max <msuraev@sysmocom.de>
Message-ID: <28194663-42c4-83b6-4a21-545408fd7e12@sysmocom.de>
Date: Tue, 18 Dec 2018 17:15:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1812132057380.2465@hadrien>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 18 Dec 2018 17:15:16 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 18 Dec 2018 17:15:13 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: Re: [Cocci] struct replacement
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

VGhhdCBhbG1vc3Qgd29ya3M6IGJvdGggZnVuY3Rpb24gcGFyYW1ldGVycyBhbmQgdmFyaWFibGUg
ZGVjbGFyYXRpb25zIAphcmUgdXBkYXRlZCBpbiAuYyBmaWxlcyBidXQgdGhlIGZ1bmN0aW9uIHBy
b3RvdHlwZXMgaW4gLmggYXJlIGlnbm9yZWQuCgpJIGNhbGwgaXQgYXMgZm9sbG93czoKCnNwYXRj
aCAtLWluLXBsYWNlIC0tc3AtZmlsZSBzdHJ1Y3Quc3BhdGNoIC1JIGluY2x1ZGUgLS1kaXIgc3Jj
CgpUaGUgc291cmNlIGNvZGUgZnJvbSAnc3JjJyBpcyB1cGRhdGVkIGJ1dCBoZWFkZXIgZmlsZXMg
aW4gJ2luY2x1ZGUnIGFyZSAKbm90IGFmZmVjdGVkLgoKU3BlY2lmeWluZyBtdWx0aXBsZSBkaXIg
ZG9lc24ndCB3b3JrOiAiaWdub3JpbmcgYWxsIGJ1dCB0aGUgbGFzdCAKc3BlY2lmaWVkIGRpcmVj
dG9yeSIuCgpBZGRpbmcgLS1pbmNsdWRlLWhlYWRlcnMgZG9lc24ndCBkbyB3aGF0IEkgaG9wZWQg
aXQgd291bGQuCgpVc2luZyB0b3AtbGV2ZWwgZGlyZWN0b3J5IGRvZXNuJ3QgaGVscCBhcyB3ZWxs
OiAuYyBpbiBtdWx0aXBsZSBzdWItZGlycyAKYXJlIHByb2Nlc3NlZCBidXQgLmggYXJlIG5vdC4K
ClJlYWRpbmcgZG9jcyBzbyBmYXIgcmV2ZWFsZWQgbm8gd2F5IHRvIHVwZGF0ZSBmdW5jdGlvbiBk
ZWZpbml0aW9uIGluIApib3RoIC5jIGFuZCAuaCBhdCB0aGUgc2FtZSB0aW1lLgoKRG9lcyBzcGF0
Y2ggaGF2ZSB0byBiZSBjYWxsZWQgaW4gc29tZSBzcGVjaWFsIHdheSBmb3IgdGhpcyB0byB3b3Jr
PyBPciAKLnNwYXRjaCBmaWxlIHNob3VsZCBoYXZlIHNvbWUgcGFydGljdWxhciBzeW50YXggc28g
aXQgd291bGQgYWZmZWN0IGJvdGggCi5jIGFuZCAuaCBzaW11bHRhbmVvdXNseT8KCjEzLjEyLjE4
IDIxOjAxLCBKdWxpYSBMYXdhbGwg0L/QuNGI0LXRgjoKPgo+IElmIHRoaXMgaXMgdG8gYmUgYSBm
dW5jdGlvbiBwcm90b3R5cGUsIHRoZSBwYXJhbWV0ZXIgc2hvdWxkIGJlIHN1cnJvdW5kZWQKPiB3
aXRoIGNvbW1hcy4gIElmIHRoZXJlIGlzIG5vIGNvbW1hIGJlZm9yZSBvciBhZnRlciB0aGUgcGFy
YW1ldGVyCj4gZGVjbGFyYXRpb24sIENvY2NpbmVsbGUgd2lsbCB0YWtlIGNhcmUgb2YgZG9pbmcg
dGhlIHJpZ2h0IHRoaW5nLgo+Cj4gQnV0IGFjdHVhbGx5IHlvdXIgcnVsZSBzaG91bGQgYmU6Cj4K
PiBAQAo+IEBACj4KPiBzdHJ1Y3QKPiAtICAgb2xkX3RoaW5nCj4gKyAgIG5ld190aGluZwo+Cj4g
VGhlbiBpdCB3aWxsIGp1c3QgY2hhbmdlIHRoZSB0eXBlIHdoZXJlZXZlciBpdCBvY2N1cnMuCj4K
LS0gCi0gTWF4IFN1cmFldiA8bXN1cmFldkBzeXNtb2NvbS5kZT4gICAgICAgaHR0cDovL3d3dy5z
eXNtb2NvbS5kZS8KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT0KKiBzeXNtb2NvbSAtIHN5c3RlbXMgZm9yIG1vYmls
ZSBjb21tdW5pY2F0aW9ucyBHbWJICiogQWx0LU1vYWJpdCA5MwoqIDEwNTU5IEJlcmxpbiwgR2Vy
bWFueQoqIFNpdHogLyBSZWdpc3RlcmVkIG9mZmljZTogQmVybGluLCBIUkIgMTM0MTU4IEIKKiBH
ZXNjaGFlZnRzZnVlaHJlciAvIE1hbmFnaW5nIERpcmVjdG9yczogSGFyYWxkIFdlbHRlCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5n
IGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxt
YW4vbGlzdGluZm8vY29jY2kK
