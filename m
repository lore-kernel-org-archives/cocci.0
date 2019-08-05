Return-Path: <SRS0=TxBn=WB=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7690DC433FF
	for <cocci@archiver.kernel.org>; Mon,  5 Aug 2019 10:21:58 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9152220880
	for <cocci@archiver.kernel.org>; Mon,  5 Aug 2019 10:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9152220880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x75ALeW2007508;
	Mon, 5 Aug 2019 12:21:40 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id AC27B7786;
	Mon,  5 Aug 2019 12:21:40 +0200 (CEST)
Received: from osiris.lip6.fr (osiris.lip6.fr [132.227.60.30])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2A9D876B2
 for <cocci@systeme.lip6.fr>; Mon,  5 Aug 2019 12:21:39 +0200 (CEST)
Received: from poleia.lip6.fr (poleia.lip6.fr [132.227.201.8])
 by osiris.lip6.fr (8.15.2/8.15.2) with ESMTP id x75ALcCm025779;
 Mon, 5 Aug 2019 12:21:38 +0200 (CEST)
Received: from newmail.lip6.fr (localhost [127.0.0.1])
 by poleia.lip6.fr (Postfix) with ESMTPA id AE3D032FC38;
 Mon,  5 Aug 2019 12:21:38 +0200 (CEST)
MIME-Version: 1.0
Date: Mon, 05 Aug 2019 12:21:38 +0200
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <656aeb1b-9c94-a428-bb0e-4397a0432651@linbit.com>
References: <b4c91fb8-5606-c06e-e349-5415458cf3b5@linbit.com>
 <alpine.DEB.2.21.1908030841460.2547@hadrien>
 <656aeb1b-9c94-a428-bb0e-4397a0432651@linbit.com>
Message-ID: <86f2f173d513c37b86553c866e201213@lip6.fr>
X-Sender: Julia.Lawall@lip6.fr
User-Agent: Roundcube Webmail/1.3.9
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 05 Aug 2019 12:21:41 +0200 (CEST)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.4.3
 (osiris.lip6.fr [132.227.60.30]); Mon, 05 Aug 2019 12:21:38 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.30
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

TGUgMDUuMDguMjAxOSAxMDozNiwgQ2hyaXN0b3BoIELDtmhtd2FsZGVyIGEgw6ljcml0wqA6Cj4g
VGhhbmtzIGZvciB5b3VyIHJlcGx5IQo+IAo+PiBCdXQgaW4geW91ciBjYXNlLCB3b3VsZCBpdCBz
dWZmaWNlIGp1c3QgdG8gcHV0IGFuIGlmIGluIHRoZSBweXRob24gCj4+IGNvZGU/Cj4+IE9yIGlz
IGl0IGVzc2VudGlhbCB0aGF0IHRoZSBmaXJzdCBydWxlIGFjdHVhbGx5IG5vdCBtYXRjaD8KPj4g
Cj4+IGp1bGlhCj4gSSdtIHByZXR0eSBzdXJlIHRoZSBiZXN0IHdheSB0byBnbyBhYm91dCB0aGlz
IGlzIHRvIGhhdmUgdGhlIHNjcmlwdCAKPiBydWxlCj4gYWN0dWFsbHkgbm90IG1hdGNoLgoKT0ss
IHRoaXMgY2FuIGJlIGRvbmUgYnkgYXNzb2NpYXRpbmcgc2NyaXB0IGNvZGUgd2l0aCB0aGUgbWV0
YXZhcmlhYmxlIAphbmQgaGF2aW5nIHRoZSBzY3JpcHQgY29kZSBjaGVjayB0aGF0IHRoZSBzZXQg
b2YgY29tbWVudHMgaXMgbm9uLWVtcHR5LiAgCkknbGwgdHJ5IHRvIGFkZCB0aGlzIHdpdGhpbiB0
aGUgbmV4dCBkYXkuCgpqdWxpYQoKPiBBbGxvdyBtZSB0byBvdXRsaW5lIG15IHJlYWwgd29ybGQg
dXNlLWNhc2UgZm9yIHRoaXM6Cj4gCj4gQmFzaWNhbGx5LCB3ZSdyZSBidWlsZGluZyBhIGtlcm5l
bCBjb21wYXRpYmlsaXR5IGxheWVyIGJhc2VkIG9uIAo+IGNvY2NpbmVsbGUgZm9yCj4gYW4gb3V0
LW9mLXRyZWUgbW9kdWxlLgo+IFRoaXMgcGFydGljdWxhciBzZW1hbnRpYyBwYXRjaCBjaXJjbGVz
IGFyb3VuZCB0aGUga1t1bl1tYXBfYXRvbWljKCkgCj4gZnVuY3Rpb25zLgo+IFNwZWNpZmljYWxs
eSwgc29tZXdoZXJlIGluIHRoZSBrZXJuZWwncyBoaXN0b3J5LCB0aGUgd2F5IHRvIHVzZSB0aGVz
ZSAKPiBmdW5jdGlvbnMKPiB3ZW50IGZyb20gdGhpczoKPiAKPiAgICAgdm9pZCAqYWRkciA9IGtt
YXBfYXRvbWljKHBhZ2UsIEtNX1VTRVIwKTsKPiAKPiB0byB0aGlzOgo+IAo+ICAgICB2b2lkICph
ZGRyID0ga21hcF9hdG9taWMocGFnZSk7Cj4gCj4gQXMgd2UncmUgbG9va2luZyB0byBldmVudHVh
bGx5IHVwc3RyZWFtIG91ciBtb2R1bGUsIHdlIG9idmlvdXNseSBjYW5ub3QgCj4gaGF2ZSB0aGUK
PiBvbGQgS01fKiBjb25zdGFudHMgbHlpbmcgYXJvdW5kIGluIG91ciBjb2RlLCBzbyB3ZSBzb21l
aG93IG5lZWQgdG8gCj4gcmVzdG9yZSB0aGUKPiBzZW1hbnRpYyBpbmZvcm1hdGlvbiB0aGF0IHdh
cyBsb3N0IGJ5IHJlbW92aW5nIHRoaXMgcGFyYW1ldGVyLgo+IFRoZSB3YXkgd2UgZGVjaWRlZCB0
byBnbyBhYm91dCB0aGlzIGlzIHRvIGFkZCBhICJ0YWciIHRvIGVhY2ggZnVuY3Rpb24KPiBjb250
YWluaW5nCj4gYSBrW3VuXW1hcF9hdG9taWMgY2FsbDsgaW1hZ2luZSB0aGUgZm9sbG93aW5nOgo+
IAo+ICAgICBpbnQgZm9vKCkKPiAgICAgLyoga21hcCBjb21wYXQ6IEtNX1VTRVIwICovCj4gICAg
IHsKPiAgICAgICAgIHZvaWQgKmFkZHIgPSBrbWFwX2F0b21pYyhwYWdlKTsKPiAgICAgICAgIC8v
IC4uLgo+ICAgICAgICAga3VubWFwX2F0b21pYyhhZGRyKTsKPiAgICAgfQo+IAo+IEl0IHdvdWxk
IG5vdyBiZSBjb2NjaW5lbGxlcyBqb2IgdG8gbWFrZSBzdXJlIHRoYXQgZWFjaCBrW3VuXW1hcF9h
dG9taWMgCj4gY2FsbCBpcwo+IGF1Z21lbnRlZCBieSB0aGlzIGxlZ2FjeSBwYXJhbWV0ZXIgKEtN
X1VTRVIwIGluIHRoaXMgY2FzZSkuIEhlcmUncyB0aGUgCj4gc2VtYW50aWMKPiBwYXRjaCBJIGNh
bWUgdXAgd2l0aCB0byBhY2NvbXBsaXNoIHRoaXM6Cj4gCj4gCj4gICAgIEAgZmluZF9rbWFwX3Rh
Z2dlZF9mdW5jdGlvbiBACj4gICAgIGNvbW1lbnRzIHRhZzsKPiAgICAgaWRlbnRpZmllciBmbjsK
PiAgICAgQEAKPiAgICAgZm4oLi4uKUB0YWcgewo+ICAgICAuLi4KPiAgICAgfQo+IAo+ICAgICBA
IHNjcmlwdDpweXRob24gcGFyc2Vfa21hcF90YWcgQAo+ICAgICB0YWcgPDwgZmluZF9rbWFwX3Rh
Z2dlZF9mdW5jdGlvbi50YWc7Cj4gICAgIGttOwo+ICAgICBAQAo+ICAgICBpbXBvcnQgcmUKPiAg
ICAgbWF0Y2ggPSByZS5zZWFyY2gocideXC9cKlxza21hcCBjb21wYXQ6ICguKilcc1wqXC8kJywg
dGFnWzBdLmFmdGVyKQo+ICAgICBpZiBtYXRjaDoKPiAgICAgICAgIGNvY2NpbmVsbGUua20gPSBt
YXRjaC5ncm91cCgxKQo+IAo+ICAgICBAQAo+ICAgICBleHByZXNzaW9uIHBhZ2UsIGFkZHI7Cj4g
ICAgIGlkZW50aWZpZXIgZmluZF9rbWFwX3RhZ2dlZF9mdW5jdGlvbi5mbjsKPiAgICAgaWRlbnRp
ZmllciBwYXJzZV9rbWFwX3RhZy5rbTsKPiAgICAgQEAKPiAgICAgZm4oLi4uKSB7Cj4gICAgIDwu
Li4KPiAgICAgKAo+ICAgICAta21hcF9hdG9taWMocGFnZSkKPiAgICAgK2ttYXBfYXRvbWljKHBh
Z2UsIGttKQo+ICAgICB8Cj4gICAgIC1rdW5tYXBfYXRvbWljKGFkZHIpCj4gICAgICtrdW5tYXBf
YXRvbWljKGFkZHIsIGttKQo+ICAgICApCj4gICAgIC4uLj4KPiAgICAgfQo+IAo+IAo+IFRoZSBm
aXJzdCBydWxlIGZpbmRzIHRoZSBjb21tZW50IGJldHdlZW4gdGhlIGFyZ3VtZW50IGxpc3QgYW5k
IHRoZSAKPiBvcGVuaW5nIGN1cmx5Cj4gYnJhY2UsIHRoZSBzZWNvbmQgcnVsZSBwYXJzZXMgb3V0
IHRoZSBLTV8qIGNvbnN0YW50IHVzaW5nIGEgcmVnZXgsIGFuZCAKPiB0aGUgdGhpcmQKPiBydWxl
IHJlcGxhY2VzIGFsbCBjYWxscyB0byBrW3VuXW1hcF9hdG9taWMgLS0gaW5zZXJ0aW5nIHRoZSBj
b3JyZWN0IAo+IHBhcmFtZXRlci4KPiAKPiBUaGlzIHdvcmtzIGp1c3QgZmluZSwgZXhjZXB0IGZv
ciB0aGUgY2FzZSB3aGVyZSBubyAidGFnIiB3YXMgZm91bmQuIAo+IFRoZW4gc3BhdGNoCj4gcHJv
ZHVjZXMgb3V0cHV0IGxpa2U6Cj4gCj4gCj4gICAgICBpbnQgZm9vKCkKPiAgICAgIHsKPiAgICAg
ICAgICAgICBpbnQgcGFnZSA9IDEyMzQ7Cj4gICAgIC0gICAgICAgdm9pZCAqYWRkciA9IGttYXBf
YXRvbWljKHBhZ2UpOwo+ICAgICArICAgICAgIHZvaWQgKmFkZHIgPSBrbWFwX2F0b21pYyhwYWdl
LAo+ICAgICArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbml0aWFsIHZhbHVlOiBj
b25zaWRlciB1c2luZwo+IGNvY2NpbmVsbGUudmFybmFtZSk7Cj4gICAgICAgICAgICAgLy8gLi4u
Cj4gICAgIC0gICAgICAga3VubWFwX2F0b21pYyhhZGRyKTsKPiAgICAgKyAgICAgICBrdW5tYXBf
YXRvbWljKGFkZHIsIGluaXRpYWwgdmFsdWU6IGNvbnNpZGVyIHVzaW5nCj4gY29jY2luZWxsZS52
YXJuYW1lKTsKPiAKPiAKPiBXaGljaCBzZWVtcyB0byBtZSBsaWtlIGl0IHdvdWxkIGNvbmZ1c2Ug
c29tZW9uZSB3aG8gZG9lc24ndCBrbm93IAo+IGV4YWN0bHkgd2hhdAo+IHBhdGNoaW5nIGlzIGRv
bmUgYmVoaW5kIHRoZSBzY2VuZXMuCj4gCj4gSWRlYWxseSwgSSB3b3VsZCBsaWtlIGZvciBjb2Nj
aW5lbGxlIHRvIG5vdCB0b3VjaCB0aGUgZnVuY3Rpb24gYXQgYWxsCj4gaWYgaXQgZG9lc24ndAo+
IGhhdmUgYSAidGFnIi4gSSdtIG5vdCBzdXJlIGlmIHRoaXMgaXMgb2JqZWN0aXZlbHkgdGhlIGJl
c3Qgc29sdXRpb24sCj4gYnV0IGl0IHNlZW1zCj4gdGhlIG1vc3QgbG9naWNhbCB0byBtZS4KPiAK
PiBJJ2QgYmUgZ2xhZCB0byBoZWFyIGFueSBpbnB1dCB5b3UgbWlnaHQgaGF2ZSByZWdhcmRpbmcg
dGhpcy4KPiAKPiBBZ2FpbiwgdGhhbmtzIGZvciBhbGwgdGhlIGhlbHAhCj4gCj4gLS0KPiBDaHJp
c3RvcGggQsO2aG13YWxkZXIKPiBMSU5CSVQgfCBLZWVwaW5nIHRoZSBEaWdpdGFsIFdvcmxkIFJ1
bm5pbmcKPiBEUkJEIEhBIOKAlCAgRGlzYXN0ZXIgUmVjb3Zlcnkg4oCUIFNvZnR3YXJlIGRlZmlu
ZWQgU3RvcmFnZQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVt
ZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
