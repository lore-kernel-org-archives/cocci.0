Return-Path: <SRS0=4KhK=2Z=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5407BC32767
	for <cocci@archiver.kernel.org>; Sat,  4 Jan 2020 08:50:35 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB706222C4
	for <cocci@archiver.kernel.org>; Sat,  4 Jan 2020 08:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB706222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0048oFYa015754;
	Sat, 4 Jan 2020 09:50:15 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4D57677DE;
	Sat,  4 Jan 2020 09:50:15 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C306A73E2
 for <cocci@systeme.lip6.fr>; Sat,  4 Jan 2020 09:50:13 +0100 (CET)
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0048nwaR005253
 for <cocci@systeme.lip6.fr>; Sat, 4 Jan 2020 09:50:06 +0100 (CET)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R581e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04420; MF=wenyang@linux.alibaba.com;
 NM=1; PH=DS; RN=11; SR=0; TI=SMTPD_---0Tmn9rCl_1578127795; 
Received: from IT-C02W23QPG8WN.local(mailfrom:wenyang@linux.alibaba.com
 fp:SMTPD_---0Tmn9rCl_1578127795) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 04 Jan 2020 16:49:56 +0800
To: Julia Lawall <julia.lawall@inria.fr>
References: <20200104064448.24314-1-wenyang@linux.alibaba.com>
 <alpine.DEB.2.21.2001040759360.2636@hadrien>
From: Wen Yang <wenyang@linux.alibaba.com>
Message-ID: <7d9d8f10-7eb6-ffc3-5084-5ed1a08d4bcb@linux.alibaba.com>
Date: Sat, 4 Jan 2020 16:49:55 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2001040759360.2636@hadrien>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 04 Jan 2020 09:50:15 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 04 Jan 2020 09:50:12 +0100 (CET)
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

CgpPbiAyMDIwLzEvNCAzOjAwIOS4i+WNiCwgSnVsaWEgTGF3YWxsIHdyb3RlOgo+IE9uIFNhdCwg
NCBKYW4gMjAyMCwgV2VuIFlhbmcgd3JvdGU6Cj4gCj4+IGRvX2RpdigpIGRvZXMgYSA2NC1ieS0z
MiBkaXZpc2lvbi4KPj4gV2hlbiB0aGUgZGl2aXNvciBpcyB1bnNpZ25lZCBsb25nLCB1NjQsIG9y
IHM2NCwKPj4gZG9fZGl2KCkgdHJ1bmNhdGVzIGl0IHRvIDMyIGJpdHMsIHRoaXMgbWVhbnMgaXQK
Pj4gY2FuIHRlc3Qgbm9uLXplcm8gYW5kIGJlIHRydW5jYXRlZCB0byB6ZXJvIGZvciBkaXZpc2lv
bi4KPj4gVGhpcyBzZW1hbnRpYyBwYXRjaCBpcyBpbnNwaXJlZCBieSBNYXRldXN6IEd1emlrJ3Mg
cGF0Y2g6Cj4+IGNvbW1pdCBiMGFiOTllNzczNmEgKCJzY2hlZDogRml4IHBvc3NpYmxlIGRpdmlk
ZSBieSB6ZXJvIGluIGF2Z19hdG9tKCkgY2FsY3VsYXRpb24iKQo+Pgo+PiBTaWduZWQtb2ZmLWJ5
OiBXZW4gWWFuZyA8d2VueWFuZ0BsaW51eC5hbGliYWJhLmNvbT4KPj4gQ2M6IEp1bGlhIExhd2Fs
bCA8SnVsaWEuTGF3YWxsQGxpcDYuZnI+Cj4+IENjOiBHaWxsZXMgTXVsbGVyIDxHaWxsZXMuTXVs
bGVyQGxpcDYuZnI+Cj4+IENjOiBOaWNvbGFzIFBhbGl4IDxuaWNvbGFzLnBhbGl4QGltYWcuZnI+
Cj4+IENjOiBNaWNoYWwgTWFyZWsgPG1pY2hhbC5sa21sQG1hcmtvdmkubmV0Pgo+PiBDYzogTWF0
dGhpYXMgTWFlbm5pY2ggPG1hZW5uaWNoQGdvb2dsZS5jb20+Cj4+IENjOiBHcmVnIEtyb2FoLUhh
cnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPgo+PiBDYzogTWFzYWhpcm8gWWFtYWRh
IDx5YW1hZGEubWFzYWhpcm9Ac29jaW9uZXh0LmNvbT4KPj4gQ2M6IFRob21hcyBHbGVpeG5lciA8
dGdseEBsaW51dHJvbml4LmRlPgo+PiBDYzogY29jY2lAc3lzdGVtZS5saXA2LmZyCj4+IENjOiBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnCj4+IC0tLQo+PiAgIHNjcmlwdHMvY29jY2luZWxs
ZS9taXNjL2RvX2Rpdi5jb2NjaSB8IDY2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKwo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA2NiBpbnNlcnRpb25zKCspCj4+ICAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IHNjcmlwdHMvY29jY2luZWxsZS9taXNjL2RvX2Rpdi5jb2NjaQo+Pgo+PiBkaWZm
IC0tZ2l0IGEvc2NyaXB0cy9jb2NjaW5lbGxlL21pc2MvZG9fZGl2LmNvY2NpIGIvc2NyaXB0cy9j
b2NjaW5lbGxlL21pc2MvZG9fZGl2LmNvY2NpCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4+IGlu
ZGV4IDAwMDAwMDAuLmYxYjcyZDEKPj4gLS0tIC9kZXYvbnVsbAo+PiArKysgYi9zY3JpcHRzL2Nv
Y2NpbmVsbGUvbWlzYy9kb19kaXYuY29jY2kKPj4gQEAgLTAsMCArMSw2NiBAQAo+PiArLy8gU1BE
WC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQo+PiArLy8vIGRvX2RpdigpIGRvZXMg
YSA2NC1ieS0zMiBkaXZpc2lvbi4KPj4gKy8vLyBXaGVuIHRoZSBkaXZpc29yIGlzIHVuc2lnbmVk
IGxvbmcsIHU2NCwgb3IgczY0LAo+PiArLy8vIGRvX2RpdigpIHRydW5jYXRlcyBpdCB0byAzMiBi
aXRzLCB0aGlzIG1lYW5zIGl0Cj4+ICsvLy8gY2FuIHRlc3Qgbm9uLXplcm8gYW5kIGJlIHRydW5j
YXRlZCB0byB6ZXJvIGZvciBkaXZpc2lvbi4KPj4gKy8vLwo+PiArLy8jIFRoaXMgbWFrZXMgYW4g
ZWZmb3J0IHRvIGZpbmQgdGhvc2UgaW5hcHByb3ByaWF0ZSBkb19kaXYgKCkgY2FsbHMuCj4+ICsv
Lwo+PiArLy8gQ29uZmlkZW5jZTogTW9kZXJhdGUKPj4gKy8vIENvcHlyaWdodDogKEMpIDIwMjAg
V2VuIFlhbmcsIEFsaWJhYmEuCj4+ICsvLyBDb21tZW50czoKPj4gKy8vIE9wdGlvbnM6IC0tbm8t
aW5jbHVkZXMgLS1pbmNsdWRlLWhlYWRlcnMKPj4gKwo+PiArdmlydHVhbCBjb250ZXh0Cj4+ICt2
aXJ0dWFsIG9yZwo+PiArdmlydHVhbCByZXBvcnQKPj4gKwo+PiArQGRlcGVuZHMgb24gY29udGV4
dEAKPj4gK2V4cHJlc3Npb24gZjsKPj4gK2xvbmcgbDsKPj4gK3Vuc2lnbmVkIGxvbmcgdWw7Cj4+
ICt1NjQgdWw2NDsKPj4gK3M2NCBzbDY0Owo+PiArCj4+ICtAQAo+PiArKAo+PiArKiBkb19kaXYo
ZiwgbCk7Cj4+ICt8Cj4+ICsqIGRvX2RpdihmLCB1bCk7Cj4+ICt8Cj4+ICsqIGRvX2RpdihmLCB1
bDY0KTsKPj4gK3wKPj4gKyogZG9fZGl2KGYsIHNsNjQpOwo+PiArKQo+PiArCj4+ICtAciBkZXBl
bmRzIG9uIChvcmcgfHwgcmVwb3J0KUAKPj4gK2V4cHJlc3Npb24gZjsKPj4gK2xvbmcgbDsKPj4g
K3Vuc2lnbmVkIGxvbmcgdWw7Cj4+ICtwb3NpdGlvbiBwOwo+PiArdTY0IHVsNjQ7Cj4+ICtzNjQg
c2w2NDsKPj4gK0BACj4+ICsoCj4+ICtkb19kaXZAcChmLCBsKTsKPj4gK3wKPj4gK2RvX2RpdkBw
KGYsIHVsKTsKPj4gK3wKPj4gK2RvX2RpdkBwKGYsIHVsNjQpOwo+PiArfAo+PiArZG9fZGl2QHAo
Ziwgc2w2NCk7Cj4+ICspCj4+ICsKPj4gK0BzY3JpcHQ6cHl0aG9uIGRlcGVuZHMgb24gb3JnQAo+
PiArcCA8PCByLnA7Cj4+ICtAQAo+PiArCj4+ICttc2c9IldBUk5JTkc6IFdBUk5JTkc6IGRvX2Rp
digpIGRvZXMgYSA2NC1ieS0zMiBkaXZpc2lvbiwgd2hpY2ggbWF5IHRydW5jYXRpb24gdGhlIGRp
dmlzb3IgdG8gMzItYml0Igo+PiArY29jY2lsaWIub3JnLnByaW50X3RvZG8ocFswXSwgbXNnKQo+
PiArCj4+ICtAc2NyaXB0OnB5dGhvbiBkZXBlbmRzIG9uIHJlcG9ydEAKPj4gK3AgPDwgci5wOwo+
PiArQEAKPj4gKwo+PiArbXNnPSJXQVJOSU5HOiBXQVJOSU5HOiBkb19kaXYoKSBkb2VzIGEgNjQt
YnktMzIgZGl2aXNpb24sIHdoaWNoIG1heSB0cnVuY2F0aW9uIHRoZSBkaXZpc29yIHRvIDMyLWJp
dCIKPj4gK2NvY2NpbGliLnJlcG9ydC5wcmludF9yZXBvcnQocFswXSwgbXNnKQo+IAo+IEEgZmV3
IHNtYWxsIGlzc3VlczogWW91IGhhdmUgV0FSTklORzogdHdpY2UgaW4gZWFjaCBjYXNlLCBhbmQg
dHJ1bmNhdGlvbgo+IHNob3VsZCBiZSB0cnVuY2F0ZS4KPiAKClRoYW5rcyBmb3IgeW91ciBjb21t
ZW50cywgd2Ugd2lsbCBmaXggaXQgc29vbi4KCj4gSXMgdGhlcmUgYW55IGdlbmVyaWMgc3RyYXRl
Z3kgZm9yIGZpeGluZyB0aGVzZSBpc3N1ZXM/Cj4gCgpXZSBoYXZlIGRvbmUgc29tZSBleHBlcmlt
ZW50cywgc3VjaCBhczoKaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMjAvMS8yLzEzNTQKCgotCWF2
ZyA9IHJlYy0+dGltZTsKLQlkb19kaXYoYXZnLCByZWMtPmNvdW50ZXIpOworCWF2ZyA9IGRpdjY0
X3VsKHJlYy0+dGltZSwgcmVjLT5jb3VudGVyKTsKCi0tPiBGdW5jdGlvbiByZXBsYWNlbWVudCB3
YXMgcGVyZm9ybWVkIGhlcmUsCiAgICAgYW5kIHNpbXBsZSBjb2RlIGNsZWFudXAgd2FzIGFsc28g
cGVyZm9ybWVkLgoKCi0JCWRvX2RpdihzdGRkZXYsIHJlYy0+Y291bnRlciAqIChyZWMtPmNvdW50
ZXIgLSAxKSAqIDEwMDApOworCQlzdGRkZXYgPSBkaXY2NF91bChzdGRkZXYsCisJCQkJICByZWMt
PmNvdW50ZXIgKiAocmVjLT5jb3VudGVyIC0gMSkgKiAxMDAwKTsKCi0tPiBPbmx5IHRoZSBmdW5j
dGlvbiByZXBsYWNlbWVudCBpcyBwZXJmb3JtZWQgaGVyZSAoYmVjYXVzZSB0aGUgCnZhcmlhYmxl
IOKAmHN0ZGRlduKAmSBjb3JyZXNwb25kcyB0byBhIG1vcmUgY29tcGxpY2F0ZWQgZXF1YXRpb24s
IGNsZWFuaW5nIAppdCB3aWxsIHJlZHVjZSByZWFkYWJpbGl0eSkuCgpJbiBhZGRpdGlvbiwgdGhl
cmUgYXJlIHNvbWUgY29kZXMgdGhhdCBkbyBub3QgbmVlZCB0byBiZSBtb2RpZmllZDoKaHR0cHM6
Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbmV4dC9saW51eC1uZXh0
LmdpdC90cmVlL2RyaXZlcnMvbmV0L2Nhbi9kZXYuYyNuMjYzCgpTbyB3ZSBqdXN0IHByaW50IGEg
d2FybmluZy4KQXMgZm9yIGhvdyB0byBmaXggaXQsIHdlIG5lZWQgdG8gYW5hbHl6ZSB0aGUgY29k
ZSBjYXJlZnVsbHkuCgotLSAKQmVzdCBXaXNoZXMsCldlbgoKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0
ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2Nj
aQo=
