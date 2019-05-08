Return-Path: <SRS0=TZ8o=TI=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5ABC04A6B
	for <cocci@archiver.kernel.org>; Wed,  8 May 2019 13:52:26 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A17E820449
	for <cocci@archiver.kernel.org>; Wed,  8 May 2019 13:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A17E820449
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=student.ethz.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x48Dq6ZR002249
          ; Wed, 8 May 2019 15:52:07 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DA3A57739;
	Wed,  8 May 2019 15:52:06 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D5FC67736
 for <cocci@systeme.lip6.fr>; Wed,  8 May 2019 15:52:04 +0200 (CEST)
Received: from edge20.ethz.ch (edge20.ethz.ch [82.130.99.26])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x48DpUgb010478
 for <cocci@systeme.lip6.fr>; Wed, 8 May 2019 15:51:30 +0200 (CEST)
X-pt: isis.lip6.fr
Received: from mailm211.d.ethz.ch (129.132.139.35) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 8 May
 2019 15:41:53 +0200
Received: from [10.5.43.51] (10.5.43.51) by mailm211.d.ethz.ch
 (2001:67c:10ec:5603::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 8 May 2019
 15:41:41 +0200
To: Julia Lawall <Julia.Lawall@lip6.fr>, <cocci@systeme.lip6.fr>
References: <83363fd9-a6b1-28be-e0a7-168f205cb551@student.ethz.ch>
 <9c5ba524fec340a9c6ea8809e93ee0e8@lip6.fr>
From: Nicolas Koenig <koenigni@student.ethz.ch>
Message-ID: <e31c049b-867d-5141-3563-17d528d482e7@student.ethz.ch>
Date: Wed, 8 May 2019 16:42:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <9c5ba524fec340a9c6ea8809e93ee0e8@lip6.fr>
Content-Language: en-US
X-Originating-IP: [10.5.43.51]
X-ClientProxiedBy: mailm211.d.ethz.ch (2001:67c:10ec:5603::25) To
 mailm211.d.ethz.ch (2001:67c:10ec:5603::25)
X-TM-SNTS-SMTP: F4A989E763B6DE3F80A20CFC87EDAF449D8C2ACD67C27655AC6AA4F2B8874BDC2000:8
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 08 May 2019 15:52:09 +0200 (CEST)
X-Greylist: Delayed for 00:09:18 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Wed, 08 May 2019 15:51:30 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: seth.arnold@canonical.com
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

SGVsbG8gSnVsaWEsIHdvcmxkLAoKVGhhbmsgeW91IGZvciB0aGUgcXVpY2sgcmVwbHkKCk9uIDA4
LzA1LzIwMTkgMTQ6MTAsIEp1bGlhIExhd2FsbCB3cm90ZToKPiBMZSAwOC4wNS4yMDE5IDEyOjE1
LCBOaWNvbGFzIEtvZW5pZyBhIMOpY3JpdMKgOgo+PiBIaSBKdWxpYSwKPj4KPj4gSSd2ZSByZWNl
bnRseSBzdGFydGVkIHRvIGxlYXJuIGFib3V0IGNvY2luZWxsZSwgYnV0IEkgaGF2ZSBhIGZldwo+
PiBxdWVzdGlvbnMgSSBjYW4ndCBmb3IgdGhlIGxpZmUgb2YgbWUgZmluZCB0aGUgYW5zd2VycyB0
byBpbiB0aGUKPj4gZG9jdW1lbnRhdGlvbiwgc28gSSBob3BlIHRoYXQgeW91IChhcyBvbmUgb2Yg
dGhlIHBlcnNvbnMgd29ya2luZyBvbgo+PiBjb2NjaW5lbGxlKSBtaWdodCBiZSBhYmxlIHRvIGhl
bHAuCj4+Cj4+IEknbSB0cnlpbmcgdG8gd3JpdGUgYSBzbWFsbCBzY3JpcHQgdGhhdCByZXBsYWNl
cyBlYWNoIHJldHVybiB2YWx1ZQo+PiB3aXRoIGFuIGFyZ3VtZW50IG9mIHRoZSBzYW1lIHR5cGUu
IFRoaXMgcmVxdWlyZXMgc3BlY2lhbC1jYXNpbmcKPj4gZnVuY3Rpb25zIHRoYXQgZG9uJ3QgdGFr
ZSBhcmd1bWVudHMsIHNvIEkgbG9va2VkIGF0IHRoZSBmb2xsb3dpbmcKPj4gZXhhbXBsZSBJIGZv
dW5kIGluIHRoZSBvZmZpY2lhbCBkb2N1bWVudGF0aW9uCj4+Cj4+IEBACj4+IGV4cHJlc3Npb24g
RSxmOwo+PiBAQAo+PiAoCj4+IGlmICg8Ky4uLiBmKC4uLikgLi4uKz4pIHsgQlVHKCk7IH0KPj4g
fAo+PiAtIGlmIChFKSB7IEJVRygpOyB9Cj4+ICsgQlVHX09OKEUpOwo+PiApCj4+Cj4+IGFuZCB0
cmllZCB0byBhZGFwdCBpdCwgc28gdGhhdCBpdCAoZm9yIHRoZSBtb21lbnQpIGp1c3QgaWdub3Jl
cwo+PiBmdW5jdGlvbnMgd2l0aG91dCBhcmd1bWVudHMKPj4KPj4gQEAKPj4gdHlwZSBUOwo+PiBp
ZGVudGlmaWVyIEY7Cj4+IEBACj4+ICgKPj4gaW50IEYgKCB2b2lkICkgeyAuLi4gfQo+PiB8Cj4+
IC0gVAo+PiArIHZvaWQKPj4gwqDCoMKgwqDCoMKgIEYgKAo+PiArwqDCoMKgwqDCoMKgwqDCoCBU
ICpyZXQsCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC4uLiApIHsgLi4uIH0K
Pj4gKQo+Pgo+PiBUaGlzIHlpZWxkcyBhIHN5bnRheCBlcnJvciwgdGhvdWdoCj4+Cj4+IGluaXRf
ZGVmc19idWlsdGluczogL3Vzci9saWIvY29jY2luZWxsZS9zdGFuZGFyZC5oCj4+IDM1IDM2Cj4+
IEZhdGFsIGVycm9yOiBleGNlcHRpb24gRmFpbHVyZSgibWludXM6IHBhcnNlIGVycm9yOiBcbiA9
IEZpbGUKPj4gXCJ0ZXN0MS5jb2NjaVwiLCBsaW5lIDYsIGNvbHVtbiA0LMKgIGNoYXJwb3MgPSAz
NVxuwqDCoMKgIGFyb3VuZCA9ICdGJywKPj4gd2hvbGUgY29udGVudCA9IGludCBGICggdm9pZCAp
IHsgLi4uIH1cbiIpCj4+Cj4+IEFueSBoaW50IHdoYXQgSSdtIGRvaW5nIHdyb25nIHdvdWxkIGhl
bHAuIEFsc28sIHdoYXQgYXJlIGluIGdlbmVyYWwKPj4gdGhlIHJ1bGVzIGZvciB0aGUgJyggfCAp
JyBzeW50YXg/Cj4gCj4gSSdtIG5vdCBzdXJlIHdoZXRoZXIgeW91IGNhbiBtYWtlIGEgZGlzanVu
Y3Rpb24gZm9yIGEgZnVuY3Rpb24gCj4gZGVmaW5pdGlvbi4gCgpJdCBzZWVtcyB0byB3b3JrIGZv
ciBmb3J3YXJkIGZ1bmN0aW9uIGRlY2xhcmFydGlvbnMsIGp1c3Qgbm90IGZvciAKZGVjbGFyYXRp
b25zIHdpdGggaW1wbGVtZW50YXRpb24gYXR0YWNoZWQKCkBACnR5cGUgVDsKaWRlbnRpZmllciBm
bjsKQEAKCigKICAgVCB4eXp6eSguLi4pOwp8Ci0gIFQgZm4KKyAgdm9pZCBmbgoJKC4uLik7CikK
CndvcmtzIGFzIGV4cGVjdGVkLCB3aGlsZQoKQEAKdHlwZSBUOwppZGVudGlmaWVyIGZuOwpAQAoK
KAogICBUIHh5enp5KC4uLikgey4uLn0KfAotICBUIGZuCisgIHZvaWQgZm4KCSguLi4pIHsuLi59
CikKCnlpZWxkcyBhIHBhcnNlciBlcnJvci4KCj4gQnV0IEkgZG9uJ3QgdGhpbmsgdGhhdCBhIGZ1
bmN0aW9uIHdpdGgganVzdCB2b2lkIGFzIGEgCj4gcGFyYW1ldGVyIGxpc3Qgd2lsbCBtYXRjaCB3
aGF0IHlvdSBoYXZlIGluIHRoZSBvdGhlciBkaXNqdW5jdCwgc28gSSAKPiB0aGluayB5b3UgY2Fu
IGp1c3QgZ2V0IHJpZCBvZiB0aGUgdm9pZCBjYXNlLgoKSXQgc2VlbSB0byBtYXRjaC4gUnVubmlu
ZyB0aGUgZm9sbG93aW5nIGxpdHRsZSBwYXRjaC9zY3JpcHQKCkBACnR5cGUgVDsKaWRlbnRpZmll
ciBmbjsKQEAKCi0gVCBmbigKKyB2b2lkIGZuKFQgKnJldCwKCS4uLikgey4uLn0KCmdlbmVyYXRl
cywgZm9yIGV4YW1wbGUsIHRoZSBmb2xsb3dpbmcgZGlmZgoKLWludCBmb28odm9pZCkgewordm9p
ZCBmb28oaW50ICpyZXQsIHZvaWQpIHsKICAgIHJldHVybiAwOwogIH0KCkFueSBpZGVhIHdoYXQg
dGhlIGJlc3Qgd2F5IHRvIHByZXZlbnQgdGhpcyB3b3VsZCBiZT8KCj4gCj4+IFRoYW5rIHlvdSBp
biBhZHZhbmNlIQo+Pgo+PiDCoCBOaWNvbGFzCj4+Cj4+IFAuUy46IElzIHRoZXJlIGEgY29tbXVu
aXR5IHdoZXJlIEkgY2FuIGFzayBzdWNoIHF1ZXN0aW9ucyB3aXRob3V0Cj4+IGJvdGhlcmluZyBw
ZW9wbGUgcGVyc29uYWxseT8KPiAKPiBZZXMsIHRoZXJlIGlzIGEgbWFpbGluZyBsaXN0LizCoCBZ
b3Ugc2hvdWxkIHNlZSB0aGlzIGluIHRoZSBjb250YWN0IGxpbmsgCj4gYXQgY29jY2luZWxsZS5s
aXA2LmZyLsKgIFlvdSBzaG91bGQgam9pbiB0aGUgbWFpbGluZyBsaXN0IHNvIEkgZG9uJ3QgaGF2
ZSAKPiB0byBhcHByb3ZlIHRoZSBwb3N0cy4KClRoYW5rIHlvdSwgSSd2ZSBzdWJzY3JpYmVkIGFu
ZCBhZGRlZCB0aGUgbGlzdCB0byB0aGlzIHRocmVhZAoKICAgTmljb2xhcwoKPiAKPiBqdWxpYQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWls
aW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21h
aWxtYW4vbGlzdGluZm8vY29jY2kK
