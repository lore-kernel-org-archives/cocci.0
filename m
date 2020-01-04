Return-Path: <SRS0=4KhK=2Z=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D35C2D0C2
	for <cocci@archiver.kernel.org>; Sat,  4 Jan 2020 13:51:37 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BF44215A4
	for <cocci@archiver.kernel.org>; Sat,  4 Jan 2020 13:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BF44215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 004Dp6Ch016937;
	Sat, 4 Jan 2020 14:51:06 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 849C777DE;
	Sat,  4 Jan 2020 14:51:06 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 07C8F73E2
 for <cocci@systeme.lip6.fr>; Sat,  4 Jan 2020 14:51:05 +0100 (CET)
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 004Dom3F003393
 for <cocci@systeme.lip6.fr>; Sat, 4 Jan 2020 14:50:50 +0100 (CET)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R861e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=wenyang@linux.alibaba.com;
 NM=1; PH=DS; RN=11; SR=0; TI=SMTPD_---0TmoWX7W_1578145843; 
Received: from IT-C02W23QPG8WN.local(mailfrom:wenyang@linux.alibaba.com
 fp:SMTPD_---0TmoWX7W_1578145843) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 04 Jan 2020 21:50:45 +0800
To: Julia Lawall <julia.lawall@inria.fr>
References: <20200104064448.24314-1-wenyang@linux.alibaba.com>
 <alpine.DEB.2.21.2001040759360.2636@hadrien>
 <7d9d8f10-7eb6-ffc3-5084-5ed1a08d4bcb@linux.alibaba.com>
 <alpine.DEB.2.21.2001040951450.2636@hadrien>
From: Wen Yang <wenyang@linux.alibaba.com>
Message-ID: <b98d1f9e-a32f-7c85-996c-2c604a014af2@linux.alibaba.com>
Date: Sat, 4 Jan 2020 21:50:43 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2001040951450.2636@hadrien>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 04 Jan 2020 14:51:06 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 04 Jan 2020 14:51:03 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Matthias Maennich <maennich@google.com>, linux-kernel@vger.kernel.org,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] coccinelle: semantic patch to check for
 inappropriate do_div() calls
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

CgpPbiAyMDIwLzEvNCA0OjU1IOS4i+WNiCwgSnVsaWEgTGF3YWxsIHdyb3RlOgo+IE9uIFNhdCwg
NCBKYW4gMjAyMCwgV2VuIFlhbmcgd3JvdGU6Cj4gCj4+Cj4+Cj4+IE9uIDIwMjAvMS80IDM6MDAg
5LiL5Y2ILCBKdWxpYSBMYXdhbGwgd3JvdGU6Cj4+PiBPbiBTYXQsIDQgSmFuIDIwMjAsIFdlbiBZ
YW5nIHdyb3RlOgo+Pj4KPj4+PiBkb19kaXYoKSBkb2VzIGEgNjQtYnktMzIgZGl2aXNpb24uCj4+
Pj4gV2hlbiB0aGUgZGl2aXNvciBpcyB1bnNpZ25lZCBsb25nLCB1NjQsIG9yIHM2NCwKPj4+PiBk
b19kaXYoKSB0cnVuY2F0ZXMgaXQgdG8gMzIgYml0cywgdGhpcyBtZWFucyBpdAo+Pj4+IGNhbiB0
ZXN0IG5vbi16ZXJvIGFuZCBiZSB0cnVuY2F0ZWQgdG8gemVybyBmb3IgZGl2aXNpb24uCj4+Pj4g
VGhpcyBzZW1hbnRpYyBwYXRjaCBpcyBpbnNwaXJlZCBieSBNYXRldXN6IEd1emlrJ3MgcGF0Y2g6
Cj4+Pj4gY29tbWl0IGIwYWI5OWU3NzM2YSAoInNjaGVkOiBGaXggcG9zc2libGUgZGl2aWRlIGJ5
IHplcm8gaW4gYXZnX2F0b20oKQo+Pj4+IGNhbGN1bGF0aW9uIikKPj4+Pgo+Pj4+IFNpZ25lZC1v
ZmYtYnk6IFdlbiBZYW5nIDx3ZW55YW5nQGxpbnV4LmFsaWJhYmEuY29tPgo+Pj4+IENjOiBKdWxp
YSBMYXdhbGwgPEp1bGlhLkxhd2FsbEBsaXA2LmZyPgo+Pj4+IENjOiBHaWxsZXMgTXVsbGVyIDxH
aWxsZXMuTXVsbGVyQGxpcDYuZnI+Cj4+Pj4gQ2M6IE5pY29sYXMgUGFsaXggPG5pY29sYXMucGFs
aXhAaW1hZy5mcj4KPj4+PiBDYzogTWljaGFsIE1hcmVrIDxtaWNoYWwubGttbEBtYXJrb3ZpLm5l
dD4KPj4+PiBDYzogTWF0dGhpYXMgTWFlbm5pY2ggPG1hZW5uaWNoQGdvb2dsZS5jb20+Cj4+Pj4g
Q2M6IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+Cj4+Pj4g
Q2M6IE1hc2FoaXJvIFlhbWFkYSA8eWFtYWRhLm1hc2FoaXJvQHNvY2lvbmV4dC5jb20+Cj4+Pj4g
Q2M6IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPgo+Pj4+IENjOiBjb2NjaUBz
eXN0ZW1lLmxpcDYuZnIKPj4+PiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZwo+Pj4+
IC0tLQo+Pj4+ICAgIHNjcmlwdHMvY29jY2luZWxsZS9taXNjL2RvX2Rpdi5jb2NjaSB8IDY2Cj4+
Pj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4+Pj4gICAgMSBmaWxlIGNo
YW5nZWQsIDY2IGluc2VydGlvbnMoKykKPj4+PiAgICBjcmVhdGUgbW9kZSAxMDA2NDQgc2NyaXB0
cy9jb2NjaW5lbGxlL21pc2MvZG9fZGl2LmNvY2NpCj4+Pj4KPj4+PiBkaWZmIC0tZ2l0IGEvc2Ny
aXB0cy9jb2NjaW5lbGxlL21pc2MvZG9fZGl2LmNvY2NpCj4+Pj4gYi9zY3JpcHRzL2NvY2NpbmVs
bGUvbWlzYy9kb19kaXYuY29jY2kKPj4+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+Pj4+IGluZGV4
IDAwMDAwMDAuLmYxYjcyZDEKPj4+PiAtLS0gL2Rldi9udWxsCj4+Pj4gKysrIGIvc2NyaXB0cy9j
b2NjaW5lbGxlL21pc2MvZG9fZGl2LmNvY2NpCj4+Pj4gQEAgLTAsMCArMSw2NiBAQAo+Pj4+ICsv
LyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5Cj4+Pj4gKy8vLyBkb19kaXYo
KSBkb2VzIGEgNjQtYnktMzIgZGl2aXNpb24uCj4+Pj4gKy8vLyBXaGVuIHRoZSBkaXZpc29yIGlz
IHVuc2lnbmVkIGxvbmcsIHU2NCwgb3IgczY0LAo+Pj4+ICsvLy8gZG9fZGl2KCkgdHJ1bmNhdGVz
IGl0IHRvIDMyIGJpdHMsIHRoaXMgbWVhbnMgaXQKPj4+PiArLy8vIGNhbiB0ZXN0IG5vbi16ZXJv
IGFuZCBiZSB0cnVuY2F0ZWQgdG8gemVybyBmb3IgZGl2aXNpb24uCj4+Pj4gKy8vLwo+Pj4+ICsv
LyMgVGhpcyBtYWtlcyBhbiBlZmZvcnQgdG8gZmluZCB0aG9zZSBpbmFwcHJvcHJpYXRlIGRvX2Rp
diAoKSBjYWxscy4KPj4+PiArLy8KPj4+PiArLy8gQ29uZmlkZW5jZTogTW9kZXJhdGUKPj4+PiAr
Ly8gQ29weXJpZ2h0OiAoQykgMjAyMCBXZW4gWWFuZywgQWxpYmFiYS4KPj4+PiArLy8gQ29tbWVu
dHM6Cj4+Pj4gKy8vIE9wdGlvbnM6IC0tbm8taW5jbHVkZXMgLS1pbmNsdWRlLWhlYWRlcnMKPj4+
PiArCj4+Pj4gK3ZpcnR1YWwgY29udGV4dAo+Pj4+ICt2aXJ0dWFsIG9yZwo+Pj4+ICt2aXJ0dWFs
IHJlcG9ydAo+Pj4+ICsKPj4+PiArQGRlcGVuZHMgb24gY29udGV4dEAKPj4+PiArZXhwcmVzc2lv
biBmOwo+Pj4+ICtsb25nIGw7Cj4+Pj4gK3Vuc2lnbmVkIGxvbmcgdWw7Cj4+Pj4gK3U2NCB1bDY0
Owo+Pj4+ICtzNjQgc2w2NDsKPj4+PiArCj4+Pj4gK0BACj4+Pj4gKygKPj4+PiArKiBkb19kaXYo
ZiwgbCk7Cj4+Pj4gK3wKPj4+PiArKiBkb19kaXYoZiwgdWwpOwo+Pj4+ICt8Cj4+Pj4gKyogZG9f
ZGl2KGYsIHVsNjQpOwo+Pj4+ICt8Cj4+Pj4gKyogZG9fZGl2KGYsIHNsNjQpOwo+Pj4+ICspCj4+
Pj4gKwo+Pj4+ICtAciBkZXBlbmRzIG9uIChvcmcgfHwgcmVwb3J0KUAKPj4+PiArZXhwcmVzc2lv
biBmOwo+Pj4+ICtsb25nIGw7Cj4+Pj4gK3Vuc2lnbmVkIGxvbmcgdWw7Cj4+Pj4gK3Bvc2l0aW9u
IHA7Cj4+Pj4gK3U2NCB1bDY0Owo+Pj4+ICtzNjQgc2w2NDsKPj4+PiArQEAKPj4+PiArKAo+Pj4+
ICtkb19kaXZAcChmLCBsKTsKPj4+PiArfAo+Pj4+ICtkb19kaXZAcChmLCB1bCk7Cj4+Pj4gK3wK
Pj4+PiArZG9fZGl2QHAoZiwgdWw2NCk7Cj4+Pj4gK3wKPj4+PiArZG9fZGl2QHAoZiwgc2w2NCk7
Cj4+Pj4gKykKPj4+PiArCj4+Pj4gK0BzY3JpcHQ6cHl0aG9uIGRlcGVuZHMgb24gb3JnQAo+Pj4+
ICtwIDw8IHIucDsKPj4+PiArQEAKPj4+PiArCj4+Pj4gK21zZz0iV0FSTklORzogV0FSTklORzog
ZG9fZGl2KCkgZG9lcyBhIDY0LWJ5LTMyIGRpdmlzaW9uLCB3aGljaCBtYXkKPj4+PiB0cnVuY2F0
aW9uIHRoZSBkaXZpc29yIHRvIDMyLWJpdCIKPj4+PiArY29jY2lsaWIub3JnLnByaW50X3RvZG8o
cFswXSwgbXNnKQo+Pj4+ICsKPj4+PiArQHNjcmlwdDpweXRob24gZGVwZW5kcyBvbiByZXBvcnRA
Cj4+Pj4gK3AgPDwgci5wOwo+Pj4+ICtAQAo+Pj4+ICsKPj4+PiArbXNnPSJXQVJOSU5HOiBXQVJO
SU5HOiBkb19kaXYoKSBkb2VzIGEgNjQtYnktMzIgZGl2aXNpb24sIHdoaWNoIG1heQo+Pj4+IHRy
dW5jYXRpb24gdGhlIGRpdmlzb3IgdG8gMzItYml0Igo+Pj4+ICtjb2NjaWxpYi5yZXBvcnQucHJp
bnRfcmVwb3J0KHBbMF0sIG1zZykKPj4+Cj4+PiBBIGZldyBzbWFsbCBpc3N1ZXM6IFlvdSBoYXZl
IFdBUk5JTkc6IHR3aWNlIGluIGVhY2ggY2FzZSwgYW5kIHRydW5jYXRpb24KPj4+IHNob3VsZCBi
ZSB0cnVuY2F0ZS4KPj4+Cj4+Cj4+IFRoYW5rcyBmb3IgeW91ciBjb21tZW50cywgd2Ugd2lsbCBm
aXggaXQgc29vbi4KPj4KPj4+IElzIHRoZXJlIGFueSBnZW5lcmljIHN0cmF0ZWd5IGZvciBmaXhp
bmcgdGhlc2UgaXNzdWVzPwo+Pj4KPj4KPj4gV2UgaGF2ZSBkb25lIHNvbWUgZXhwZXJpbWVudHMs
IHN1Y2ggYXM6Cj4+IGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDIwLzEvMi8xMzU0Cj4gCj4gVGhh
bmtzLiAgQWN0dWFsbHksIEkgd291bGQgYXBwcmVjaWF0ZSBrbm93aW5nIGFib3V0IHN1Y2ggZXhw
ZXJpbWVudHMgd2hlbgo+IHRoZSBzZW1hbnRpYyBwYXRjaCBpcyBzdWJtaXR0ZWQsIHNpbmNlIGVn
IGluIHRoaXMgY2FzZSBJIGFtIG5vdCByZWFsbHkgYW4KPiBleHBlcnQgaW4gdGhpcyBpc3N1ZS4K
PiAKPj4KPj4gLQlhdmcgPSByZWMtPnRpbWU7Cj4+IC0JZG9fZGl2KGF2ZywgcmVjLT5jb3VudGVy
KTsKPj4gKwlhdmcgPSBkaXY2NF91bChyZWMtPnRpbWUsIHJlYy0+Y291bnRlcik7Cj4+Cj4+IC0t
PiBGdW5jdGlvbiByZXBsYWNlbWVudCB3YXMgcGVyZm9ybWVkIGhlcmUsCj4+ICAgICAgYW5kIHNp
bXBsZSBjb2RlIGNsZWFudXAgd2FzIGFsc28gcGVyZm9ybWVkLgo+Pgo+Pgo+PiAtCQlkb19kaXYo
c3RkZGV2LCByZWMtPmNvdW50ZXIgKiAocmVjLT5jb3VudGVyIC0gMSkgKiAxMDAwKTsKPj4gKwkJ
c3RkZGV2ID0gZGl2NjRfdWwoc3RkZGV2LAo+PiArCQkJCSAgcmVjLT5jb3VudGVyICogKHJlYy0+
Y291bnRlciAtIDEpICogMTAwMCk7Cj4+Cj4+IC0tPiBPbmx5IHRoZSBmdW5jdGlvbiByZXBsYWNl
bWVudCBpcyBwZXJmb3JtZWQgaGVyZSAoYmVjYXVzZSB0aGUgdmFyaWFibGUKPj4g4oCYc3RkZGV2
4oCZIGNvcnJlc3BvbmRzIHRvIGEgbW9yZSBjb21wbGljYXRlZCBlcXVhdGlvbiwgY2xlYW5pbmcg
aXQgd2lsbCByZWR1Y2UKPj4gcmVhZGFiaWxpdHkpLgo+IAo+IFdvdWxkIGl0IGJlIHJlYXNvbmFi
bGUgdG8gZXh0ZW5kIHRoZSB3YXJuaW5nIHRvIHNheSAiY29uc2lkZXIgdXNpbmcKPiBkaXY2NF91
bCBpbnN0ZWFkIj8gIE9yIGRvIHlvdSB0aGluayBpdCBpcyBvYnZpb3VzIHRvIGV2ZXJ5b25lPwo+
IAoKVGhhbmsgeW91IGZvciB5b3VyIGNvbW1lbnRzLgpXZSBwbGFuIHRvIG1vZGlmeSBpdCBhcyBm
b2xsb3dzOgptc2c9IldBUk5JTkc6IGRvX2RpdigpIGRvZXMgYSA2NC1ieS0zMiBkaXZpc2lvbiwg
cGxlYXNlIGNvbnNpZGVyIHVzaW5nIApkaXY2NF91bCwgZGl2NjRfbG9uZywgZGl2NjRfdTY0IG9y
IGRpdjY0X3M2NCBpbnN0ZWFkLiIKCj4+IEluIGFkZGl0aW9uLCB0aGVyZSBhcmUgc29tZSBjb2Rl
cyB0aGF0IGRvIG5vdCBuZWVkIHRvIGJlIG1vZGlmaWVkOgo+PiBodHRwczovL2dpdC5rZXJuZWwu
b3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9uZXh0L2xpbnV4LW5leHQuZ2l0L3RyZWUvZHJp
dmVycy9uZXQvY2FuL2Rldi5jI24yNjMKPiAKPiBXb3VsZCBpdCBiZSB3b3J0aCBoYXZpbmcgYSBz
cGVjaWFsIGNhc2UgZm9yIGNvbnN0YW50cyBhbmQgY2hlY2tpbmcgd2hldGhlcgo+IHRoZSB2YWx1
ZSBpcyBvYnZpb3VzbHkgc2FmZSBhbmQgbm8gd2FybmluZyBpcyBuZWVkZWQ/Cj4KVGhhbmtzLgpU
aGlzIGlzIHZlcnkgdmFsdWFibGUgaW4gcmVkdWNpbmcgZmFsc2UgcG9zaXRpdmVzLCBhbmQgd2Un
bGwgdHJ5IHRvIAppbXBsZW1lbnQgaXQuCgotLQpCZXN0IFdpc2hlcywKV2VuCgo+PiBTbyB3ZSBq
dXN0IHByaW50IGEgd2FybmluZy4KPj4gQXMgZm9yIGhvdyB0byBmaXggaXQsIHdlIG5lZWQgdG8g
YW5hbHl6ZSB0aGUgY29kZSBjYXJlZnVsbHkuCj4+Cj4+IC0tCj4+IEJlc3QgV2lzaGVzLAo+PiBX
ZW4KPj4KPj4KPj4KPiAKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5
c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
