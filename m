Return-Path: <SRS0=6akS=O3=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7268C43387
	for <cocci@archiver.kernel.org>; Tue, 18 Dec 2018 16:44:54 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6785B21873
	for <cocci@archiver.kernel.org>; Tue, 18 Dec 2018 16:44:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6785B21873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sysmocom.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBIGig0V024907
          ; Tue, 18 Dec 2018 17:44:42 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A7AC3740A;
	Tue, 18 Dec 2018 17:44:42 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 41B493A55
 for <cocci@systeme.lip6.fr>; Tue, 18 Dec 2018 17:44:41 +0100 (CET)
Received: from mail.sysmocom.de (mail.sysmocom.de [144.76.43.93])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBIGiefU024243
 for <cocci@systeme.lip6.fr>; Tue, 18 Dec 2018 17:44:40 +0100 (CET)
X-pt: isis.lip6.fr
Received: from public-mail (mail.sysmocom.de [144.76.43.93])
 by mail.sysmocom.de (Postfix) with ESMTP id 84E944B85CA
 for <cocci@systeme.lip6.fr>; Tue, 18 Dec 2018 16:44:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at sysmocom.de
Received: from mail.sysmocom.de ([144.76.43.93])
 by public-mail (mail.sysmocom.de [144.76.43.93]) (amavisd-new, port 10024)
 with ESMTP id 17KpFdarJ54T; Tue, 18 Dec 2018 16:44:39 +0000 (UTC)
Received: from [10.9.1.140] (ds9.sysmocom.de [90.187.64.137])
 by mail.sysmocom.de (Postfix) with ESMTPSA id B08B64B85B9
 for <cocci@systeme.lip6.fr>; Tue, 18 Dec 2018 16:44:39 +0000 (UTC)
To: cocci@systeme.lip6.fr
References: <0c0bf80c-56bd-6560-12b8-97a4b1b89963@sysmocom.de>
 <alpine.DEB.2.21.1812130724080.2458@hadrien>
 <346d748c-c073-7567-5547-23ec8a47c9b6@sysmocom.de>
 <alpine.DEB.2.21.1812132057380.2465@hadrien>
 <28194663-42c4-83b6-4a21-545408fd7e12@sysmocom.de>
 <alpine.DEB.2.20.1812181716490.2886@hadrien>
From: Max <msuraev@sysmocom.de>
Message-ID: <372cf517-11cb-3021-fc5b-219b26022493@sysmocom.de>
Date: Tue, 18 Dec 2018 17:44:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1812181716490.2886@hadrien>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 18 Dec 2018 17:44:43 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 18 Dec 2018 17:44:40 +0100 (CET)
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

SSBzZWUuIFllcyzCoCAtLWFsbC1pbmNsdWRlcyBkaWQgdGhlIHRyaWNrIGZvciBtZSwgdGhhbmsg
eW91LgoKQWx0aG91Z2ggSSdtIHN0aWxsIGhhdmUgdG8gdXBkYXRlIHN0cnVjdCBmaWVsZHMgaW4g
YWRkaXRpb24gdG8gc3RydWN0IApuYW1lIGFuZCBpdCBzZWVtcyBsaWtlIEknbSB1c2luZyB0eXBl
ZGVmIGluIGEgd3Jvbmcgd2F5LgoKRm9yIGV4YW1wbGU6CgpfX19fX19fX19fX19fX19fX19fX19f
XwoKQEAKQEAKc3RydWN0Ci0gb2xkX2FkZHIKKyBuZXdfYWRkcmVzcwoKQEAKaWRlbnRpZmllciBh
Owp0eXBlZGVmIG5ld19hZGRyZXNzOwpAQApuZXdfYWRkcmVzcyBhOwotIGEubGVuOworIGEubGVu
Z3RoOwoKX19fX19fX19fX19fX19fX19fX19fX18KClRoaXMgZG9lcyBub3QgY2F1c2UgZmllbGQg
dXBkYXRlcyBhbHRob3VnaCBmaXJzdCBwYXJ0IChuYW1lcykgd29ya3MuCgpVc2luZyAndHlwZWRl
ZiBzdHJ1Y3QgbmV3X2FkZHJlc3MnIGluc3RlYWQgZ2l2ZXMgIm1ldGE6IHBhcnNlIGVycm9yIi4K
ClVzaW5nICdvbGRfYWRkcicgaW5zdGVhZCBvZiAnbmV3X2FkZHJlc3MnIGluIDJuZCBwYXJ0IGRv
ZXNuJ3QgbWFrZSBhbnkgCmRpZmZlcmVuY2UuCgpUaGUgbGVuL2xlbmd0aCBhcmUgcHJldHR5IGdl
bmVyaWMgbmFtZXMgdXNlZCBpbiBtdWx0aXBsZSBzdHJ1Y3RzLiBIb3cgZG8gCkkgaW5zdHJ1Y3Qg
Q29jY2luZWxsZSB0byBtYWtlIHJlcGxhY2VtZW50IG9ubHkgZm9yIGlkZW50aWZpZXJzIHdoaWNo
IApiZWxvbmcgdG8gYSBwYXJ0aWN1bGFyIHN0cnVjdCB0eXBlIChvciBwb2ludGVyIHRvIGl0KT8K
CklzIHRoZXJlIHNvbWUgc3BlY2lmaWMgbWV0YXZlciBzeW50YXggcmVsYXRlZCB0byBzdHJ1Y3Rz
IHdoaWNoIEkgaGF2ZW4ndCAKZm91bmQgeWV0PwoKMTguMTIuMTggMTc6MTksIEp1bGlhIExhd2Fs
bCDQv9C40YjQtdGCOgo+Cj4gQnkgZGVmYXVsdCwgQ29jY2luZWxsZSBvbmx5IGluY2x1ZGVzIHRo
ZSBoZWFkZXJzIHRoYXQgaGF2ZSB0aGUgc2FtZSBuYW1lCj4gYXMgdGhlIC5jIGZpbGUuICBJZSBm
b3IgZm9vLmMsIGl0IGNvbnNpZGVycyB0aGF0IGZvby5oIGlzIHByYmFibHkKPiBpbXBvcnRhbnQs
IGFuZCB0aHVzIHdvcnRoIHRoZSBvZnRlbiBsYXJnZSBleHRyYSBydW50aW1lIGNvc3QgdG8gdGFr
ZSBpbnRvCj4gYWNjb3VudC4KPgo+IElmIHlvdSB3YW50IG1vcmUgYWdncmVzc2l2ZSBpbmNsdXNp
b24gb2YgaGVhZGVycywgeW91IG5lZWQgLS1hbGwtaW5jbHVkZXMKPiAodGhlIGhlYWRlcnMgZXhw
bGljaXRseSBtZW50aW9uZWQgaW4gdGhlIC5jIGZpbGUpIG9yIC0tcmVjdXJzaXZlLWluY2x1ZGVz
Cj4gKGhlYWRlcnMgaW5jbHVkZWQgYnkgb3RoZXIgaGVhZGVycykuCj4KPiBqdWxpYQoKLS0gCi0g
TWF4IFN1cmFldiA8bXN1cmFldkBzeXNtb2NvbS5kZT4gICAgICAgaHR0cDovL3d3dy5zeXNtb2Nv
bS5kZS8KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT0KKiBzeXNtb2NvbSAtIHN5c3RlbXMgZm9yIG1vYmlsZSBjb21t
dW5pY2F0aW9ucyBHbWJICiogQWx0LU1vYWJpdCA5MwoqIDEwNTU5IEJlcmxpbiwgR2VybWFueQoq
IFNpdHogLyBSZWdpc3RlcmVkIG9mZmljZTogQmVybGluLCBIUkIgMTM0MTU4IEIKKiBHZXNjaGFl
ZnRzZnVlaHJlciAvIE1hbmFnaW5nIERpcmVjdG9yczogSGFyYWxkIFdlbHRlCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QK
Q29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlz
dGluZm8vY29jY2kK
