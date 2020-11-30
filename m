Return-Path: <SRS0=DeXm=FE=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FC6C63777
	for <cocci@archiver.kernel.org>; Mon, 30 Nov 2020 22:48:34 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36E6B20725
	for <cocci@archiver.kernel.org>; Mon, 30 Nov 2020 22:48:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36E6B20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0AUMm8p4010055;
	Mon, 30 Nov 2020 23:48:08 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B99D47539;
	Mon, 30 Nov 2020 23:48:08 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0BF90620
 for <cocci@systeme.lip6.fr>; Mon, 30 Nov 2020 23:48:07 +0100 (CET)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0AUMm5Km017717
 for <cocci@systeme.lip6.fr>; Mon, 30 Nov 2020 23:48:06 +0100 (CET)
IronPort-SDR: moDR6pXTAJDi0YOvqp9XeRty6TvCzAv7XzEWa9oguUuZSYMHJH9VNkDl4Aq2vrUdP6kYjSkWa3
 a0DNaHNf7bBQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="152555699"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; d="scan'208";a="152555699"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Nov 2020 14:48:04 -0800
IronPort-SDR: UExOb3KvlvzKRhswWgJqqSdtZF6sEwrar/W1YwbUCMvz6PDncOo0Id6ZcB/NhVr+Sp0PaBZGJI
 +E3cnLpqc68A==
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; d="scan'208";a="549290809"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Nov 2020 14:48:04 -0800
Date: Mon, 30 Nov 2020 14:48:04 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <20201130224803.GA1447340@iweiny-DESK2.sc.intel.com>
References: <20201128054145.GP1161629@iweiny-DESK2.sc.intel.com>
 <13b5bbf1-4dda-9dc2-46cd-a98e71537769@web.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <13b5bbf1-4dda-9dc2-46cd-a98e71537769@web.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 30 Nov 2020 23:48:09 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 30 Nov 2020 23:48:06 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Automating a kmap/mem*/kunmap transformation
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

T24gU3VuLCBOb3YgMjksIDIwMjAgYXQgMTE6MTc6MTRBTSArMDEwMCwgTWFya3VzIEVsZnJpbmcg
d3JvdGU6Cj4gPiAxKSBIb3cgZG8gSSBnZXQgbWF0Y2hlcyB0byBpdGVyYXRlPwo+IAo+IEhvdyBk
byB5b3UgdGhpbmsgYWJvdXQgcG9zc2liaWxpdGllcyBmb3Ig4oCcaXRlcmF0aW9u4oCdPwo+IAo+
IAo+ID4JMWEpIFdoYXQgaXMgdGhlIGRpZmZlcmVuY2UgYmV0d2VlbiAnPCsuLi4gLi4uKz4nIGFu
ZCAnPC4uLiAuLi4+Jz8KPiAKPiBJIHN1Z2dlc3QgdG8gdGFrZSBhbm90aGVyIGxvb2sgYXQgdGhl
IHNlY3Rpb24g4oCcRG90IHZhcmlhbnRz4oCdIGluIHRoZSBhdmFpbGFibGUKPiBzb2Z0d2FyZSBk
b2N1bWVudGF0aW9uLgo+IGh0dHBzOi8vY29jY2luZWxsZS5naXRsYWJwYWdlcy5pbnJpYS5mci93
ZWJzaXRlL2RvY3MvbWFpbl9ncmFtbWFyMDA0Lmh0bWwjc2VjNwo+IAo+IFdvdWxkIHlvdSBsaWtl
IHRvIGRpc3Rpbmd1aXNoIGlmIHlvdSBhcmUgbG9va2luZyBmb3Igc291cmNlIGNvZGUgcGFydHMK
PiB3aGljaCBjYW4gYmUgb3B0aW9uYWw/CgpZZXMsIG5vdCBldmVyeSBmaWxlIHdpbGwgaGF2ZSB0
aGUgcGF0dGVybiBJJ20gbG9va2luZyBmb3IgYW5kIGFzIEkgZXhwbGFpbmVkIGluCm15IG90aGVy
IHRocmVhZCB0aGUgc2Vjb25kIGluc3RhbmNlIG9mIHRoYXQgcGF0dGVybiB3YXMgbm90IGJlaW5n
IG1hdGNoZWQgYW5kIEkKY291bGQgbm90IHVuZGVyc3RhbmQgd2h5LiAgSW4gdGhhdCBjYXNlIGVp
dGhlciAnKycgb3Igbm8gJysnIHNob3VsZCAoYW5kIGFzIEkKa25vdyBub3cgZG9lcykgd29yay4g
IEJ1dCBJIHRob3VnaHQgdGhlcmUgd2FzIHNvbWUgc2VjcmV0IHRvIHRoZW0gSSB3YXMKbWlzc2lu
Zy4uLiAgU29ycnkuLi4KCj4gCj4gCj4gPiAyKSBXaHkgY2FuJ3QgSSBnZXQgdGhlIHR5cGUgZGVj
bGFyYXRpb24gKHR5cGUgVlA7KSBtYXRjaGVkIGNvcnJlY3RseS4gIEl0IHdvcmtzCj4gPiAgICBz
b21lIHRpbWVzIGJ1dCBub3QgYWx3YXlzLiAgSXQgYWxzbyBtYXRjaGVzIGEgbG90IG9mIHJhbmRv
bSBkZWNsYXJhdGlvbnM/Cj4gCj4gSSBpbWFnaW5lIHRoYXQgaXQgd2lsbCBoZWxwIHRvIHBvaW50
IGEgZmV3IHNvdXJjZSBjb2RlIHBsYWNlcyBvdXQKPiB3aGVyZSB5b3UgZmluZCB0aGUgc2hvd24g
dHJhbnNmb3JtYXRpb24gYXBwcm9hY2ggaW1wcm92YWJsZS4KPiAKPiAKPiA+IDJhKSBhbmQgZm9y
IHNvbWUgcmVhc29uIGluIHRoZSBtb3JlIGFkdmFuY2VkIHNjcmlwdFszXSBpdCBjb21wbGV0ZWx5
IGJyZWFrcy4KPiAKPiBIb3cgZG9lcyBzdWNoIGFuIHVuZGVzaXJhYmxlIGZhaWx1cmUgbG9vayBs
aWtlPwo+IAo+IEkgd29uZGVyIGEgYml0IG1vcmUgYWJvdXQgdGhlIGRldGFpbCB3aHkgeW91IHdv
dWxkIGxpa2UgdG8gZW5jbG9zZQo+IHRoZSBTbVBMIGNvZGUgYnkgdGhlIGNvbnN0cnVjdCDigJw8
Li4uIOKApiAuLi4+4oCdIGhlcmUuCgpCZWNhdXNlIG9mIHRoZSBzZWNvbmQgaW5zdGFuY2Ugb2Yg
bXkgcGF0dGVybiBub3QgbWF0Y2hpbmcgSSB0aG91Z2h0IEkgbmVlZGVkIHRvCnNwZWNpZnkgdGhh
dCB0aGUgcGF0dGVybiBjb3VsZCBhcHBlYXIgMCBvciBtb3JlIHRpbWVzLiAgQnV0IEkgbm93IHJl
YWxpemUgdGhhdAp0aGUgcGF0dGVybiBzcGVjaWZpY2F0aW9uIHdhcyB3cm9uZy4KCj4gSSBmaW5k
IHRoYXQgdGhlIGNoYW5nZSBzcGVjaWZpY2F0aW9uIOKAnC1WUCBwdHI74oCdIHdvdWxkIG1lYW4g
dGhlbiB0aGF0Cj4gYWxsIHZhcmlhYmxlIGRlY2xhcmF0aW9ucyBzaG91bGQgYmUgZGVsZXRlZCBm
b3Igc2VsZWN0ZWQgc291cmNlIGZpbGVzLgoKCj4gCj4gCj4gV291bGQgeW91IGJlY29tZSBpbnRl
cmVzdGVkIGluIGFueSBtb3JlIGNvZGUgYWx0ZXJuYXRpdmVzIGZvciBzY3JpcHRzCj4gaW4gdGhl
IHNlbWFudGljIHBhdGNoIGxhbmd1YWdlPwo+IAo+IEV4YW1wbGVzOgo+IEEpCj4gKAo+IC1wdHIg
PSBrbWFwKHBhZ2UpOwo+IHwKPiAtcHRyID0ga21hcF9hdG9taWMocGFnZSk7Cj4gKQo+IAo+IAo+
IFRoaXMgU21QTCBkaXNqdW5jdGlvbiBmb3IgYSBkZWxldGlvbiBhcHByb2FjaCBjYW4gYmUgdHJh
bnNmb3JtZWQKPiBsaWtlIHRoZSBmb2xsb3dpbmcuCj4gCj4gLXB0ciA9IFwoIGttYXAgXHwga21h
cF9hdG9taWMgXCkgKHBhZ2UpOwoKVGhhbmtzIHllcyB0aGF0IGhlbHBzLgoKPiAKPiAKPiBCKQo+
ICgKPiAtbWVtc2V0KC4uLik7Cj4gK21lbUlyYSgpOwo+IHwKPiAtbWVtY3B5KC4uLik7Cj4gK21l
bUlyYSgpOwo+ICkKPiAKPiAKPiBUaGlzIFNtUEwgZGlzanVuY3Rpb24gZm9yIGEgcmVwbGFjZW1l
bnQgYXBwcm9hY2ggY2FuIGV2ZW50dWFsbHkgYmUgdHJhbnNmb3JtZWQKPiBsaWtlIHRoZSBmb2xs
b3dpbmcuCj4gCj4gLVwoIG1lbXNldCBcfCBtZW1jcHkgXCkgKC4uLikKPiArbWVtSXJhKCkKPiAg
OwoKVGhpcyBtYWtlcyBzZW5zZSBidXQgaXQgaXMgbm90IG15IGZpbmFsIGdvYWwgYW5kIHRoZSBm
aW5hbCBnb2FsIHJlcXVpcmVzIG1vcmUKbWFuaXB1bGF0aW9uIG9mIHRoZSBwYXJhbWV0ZXJzIHRv
IG1lbXNldC9tZW1jcHkuCgpCdXQgSSBhbSBjdXJpb3VzIHRvIGxlYXJuIG1vcmUgc28gSSdsbCBr
ZWVwIHRoZXNlIGFsdGVybmF0aXZlcyBpbiBtaW5kLgoKVGhhbmtzIQpJcmEKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApD
b2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0
aW5mby9jb2NjaQo=
