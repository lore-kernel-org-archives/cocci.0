Return-Path: <SRS0=v8/u=UF=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29409C04AB5
	for <cocci@archiver.kernel.org>; Thu,  6 Jun 2019 09:10:26 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96DAF2083E
	for <cocci@archiver.kernel.org>; Thu,  6 Jun 2019 09:10:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96DAF2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=univ-grenoble-alpes.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x569A93W016430;
	Thu, 6 Jun 2019 11:10:09 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 513677760;
	Thu,  6 Jun 2019 11:10:09 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 200C8775C
 for <cocci@systeme.lip6.fr>; Thu,  6 Jun 2019 11:10:07 +0200 (CEST)
Received: from zm-mta-out-1.u-ga.fr (zm-mta-out-1.u-ga.fr [152.77.200.56])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x569A4mq007718
 for <cocci@systeme.lip6.fr>; Thu, 6 Jun 2019 11:10:04 +0200 (CEST)
Received: from zm-mta-out.u-ga.fr (zm-mta-out.u-ga.fr [152.77.200.58])
 by zm-mta-out-1.u-ga.fr (Postfix) with ESMTP id 0BCB1A04AD;
 Thu,  6 Jun 2019 11:10:04 +0200 (CEST)
Received: from smtps.univ-grenoble-alpes.fr (smtps.univ-grenoble-alpes.fr
 [152.77.1.30])
 by zm-mta-out.u-ga.fr (Postfix) with ESMTP id 07A22E00B3;
 Thu,  6 Jun 2019 11:10:04 +0200 (CEST)
Received: from dock-palix.imag.fr (dock-palix.imag.fr [129.88.52.145])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: palixn@univ-grenoble-alpes.fr)
 by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id CEE00125EB7;
 Thu,  6 Jun 2019 11:10:03 +0200 (CEST)
To: Julia Lawall <julia.lawall@lip6.fr>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>
References: <bd88dcf8-e3cb-4a63-8ebd-ce703506890e@metux.net>
 <alpine.DEB.2.21.1906052154110.2622@hadrien>
From: Nicolas Palix <nicolas.palix@univ-grenoble-alpes.fr>
Organization: =?UTF-8?Q?Universit=c3=a9_Grenoble-Alpes?=
Message-ID: <49ef04c7-f32c-c322-f7b9-b4afecca7763@univ-grenoble-alpes.fr>
Date: Thu, 6 Jun 2019 11:10:03 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1906052154110.2622@hadrien>
Content-Language: fr
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 06 Jun 2019 11:10:09 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 06 Jun 2019 11:10:05 +0200 (CEST)
X-Greylist: Whitelist-UGA SMTP Authentifie (palixn@univ-grenoble-alpes.fr) via
 submission-587 ACL (112)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] splitting and fingerprinting findings
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

SGksCgpMZSAwNS8wNi8yMDE5IMOgIDIxOjU2LCBKdWxpYSBMYXdhbGwgYSDDqWNyaXTCoDoKPiAK
PiAKPiBPbiBXZWQsIDUgSnVuIDIwMTksIEVucmljbyBXZWlnZWx0LCBtZXR1eCBJVCBjb25zdWx0
IHdyb3RlOgo+IAo+PiBIaSBmb2xrcywKPj4KPj4KPj4gSSdkIGxpa2UgdG8gaGFjayB1cCBzb21l
IHNjcmlwdHMgdGhhdCBhdXRvbWF0aWNhbGx5IHNjYW4gYW5kIHJlcG9ydAo+PiBmaW5kaW5ncyBv
biBhIGRhaWx5IGJhc2lzLCBlZy4gb24gdGhlIGxpbnV4LW5leHQgdHJlZS4gT2J2aW91c2x5LAo+
PiBub2JvZHkgY2FuIHNlcmlvdXNseSByZWFkIHRoaXMgYWxsIGF0IG9uY2UsIGVzcGVjaWFsbHkg
bm90IG9uIGEKPj4gZGFpbHkgYmFzaXMuCj4+Cj4+IFRoZXJlZm9yZSBJIG5lZWQgdG86Cj4+Cj4+
ICogc3BsaXQgdGhlIGZpbmRpbmdzIChlZy4gYnkgcnVsZXNldCBvciBhZmZlY3RlZCBmaWxlcyAv
IHN1YnN5c3RlbXMpCj4+ICogZmlsdGVyIG91dCBmaW5kaW5ncyB0aGF0IGFscmVhZHkgaGF2ZSBi
ZWVuIHJlcG9ydGVkLgo+Pgo+PiBUaGUgc2Vjb25kIHBhcnQgc2VlbXMgdG8gYmUgdHJpY2tpZXN0
IG9uZSwgYXMgdGhlIGNvZGUgbWlnaHQgc2xpZ2h0bHkKPj4gY2hhbmdlIGluIHRoZSBtZWFudGlt
ZSwgbGFlZGluZyB0byBkaWZmZXJlbnQgcGF0Y2ggb3V0cHV0cy4gSWdub3JpbmcKPj4gdGhlIEBA
IGxpbmVzIHNob3VsZCBhdCBsZWFzdCBkcm9wIGEgbGFyZ2UgcG9ydGlvbiBvZiB0aGUgZHVwbGlj
YXRlcywKPj4gYnV0IEknbGwgeWV0IGhhdmUgdG8gc2VlIGhvdyB3ZWxsIHRoYXQgd29ya3MgLi4u
Cj4+Cj4+IERpZCBhbnlvbmUgZWxzZSBhbHJlYWR5IHdvcmtpbmcgb24gdGhhdCB0b3BpYyA/Cj4g
Cj4gVGhlIDAtZGF5IHBlb3BsZSBkbyBzb21ldGhpbmcuCj4gCj4gVGhlIHRvb2wgSGVyb2RvdG9z
IGFkZHJlc3NlZCB0aGlzLCBidXQgc2VlbXMgdG8gYmUgaGFyZCB0byBnZXQgd29ya2luZy4KClN0
aWxsIG1haW50YWluZWQuIDspCgpJIGhhdmUgc29tZW9uZSBjdXJyZW50bHkgd29ya2luZyBvbiBp
dCB0byBtYWtlIG9wdGlvbmFsIGEgc2V0IG9mIApmZWF0dXJlcyB0aGF0IGFyZSB1c2VsZXNzIGZv
ciB5b3VyIHB1cnBvc2UuCgpIb3dldmVyLCBJIG5ldmVyIHVzZWQgaXQgb24gbGludXgtbmV4dC4u
LgoKWW91IG1heSBhbHNvIHRha2UgYSBsb29rIGF0IGNndW0vZ3VtdHJlZSB0byB0cmFjayBjaGFu
Z2VzIGluIGEgbW9yZSAKZmluZXIgd2F5IHRoYW4gZGlmZi4KCgo+IAo+IEluIGdlbmVyYWwsIHlv
dSBuZWVkIHRvIGp1c3QgaW50ZXJwcmV0IHRoZSByZXBvcnQgbGluZSBudW1iZXJzIGFuZCB0aGUK
PiBkaWZmIGh1bmtzIHRvIGZpZ3VyZSBvdXQgd2hldGhlciB0aGUgcmVwb3J0IGxpbmVzIGFyZSBv
ciBhcmUgbm90IGluIHRoZQo+IGNoYW5nZWQgbGluZXMgb2YgY29kZS4KPiAKPiBGb3IgZXhhbXBs
ZSwgaWYgdGhlIHJlcG9ydCB3YXMgb24gbGluZSA2OSBhbmQgaXMgbm93IG9uIGxpbmUgNzAsIGFu
ZCB0aGUKPiBvbmx5IGNoYW5nZSB3YXMgdG8gcmVwbGFjZSBsaW5lIDItMyBieSBsaW5lcyAyLTQs
IGllIGFkZCBhIG5ldyBsaW5lLCB0aGVuCj4gdGhlIHJlcG9ydCBvbiBsaW5lIDcwIGlzIHRoZSBz
YW1lIGFzIHRoZSByZXBvcnQgb24gbGluZSA2OS4KPiAKPiBqdWxpYQo+IF9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gQ29jY2kgbWFpbGluZyBsaXN0Cj4g
Q29jY2lAc3lzdGVtZS5saXA2LmZyCj4gaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9s
aXN0aW5mby9jb2NjaQo+IAoKCi0tIApOaWNvbGFzIFBhbGl4Cmh0dHA6Ly9saWctbWVtYnJlcy5p
bWFnLmZyL3BhbGl4LwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lz
dGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
