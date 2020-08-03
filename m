Return-Path: <SRS0=D+wQ=BN=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32712C433DF
	for <cocci@archiver.kernel.org>; Mon,  3 Aug 2020 08:22:31 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C903E206E2
	for <cocci@archiver.kernel.org>; Mon,  3 Aug 2020 08:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C903E206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0738MJjk026372;
	Mon, 3 Aug 2020 10:22:19 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 48EA476BF;
	Mon,  3 Aug 2020 10:22:19 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 39B4741F5
 for <cocci@systeme.lip6.fr>; Mon,  3 Aug 2020 10:22:17 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0738MGas006021
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 3 Aug 2020 10:22:16 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: jaskaran_singh) with ESMTPSA id D06B6291705
Message-ID: <ba1f8a2dc9e079bc01fc2037f1246f25cd956ee5.camel@collabora.com>
From: Jaskaran Singh <jaskaran.singh@collabora.com>
To: Markus Elfring <Markus.Elfring@web.de>,
        Julia Lawall
 <julia.lawall@inria.fr>
Date: Mon, 03 Aug 2020 13:52:09 +0530
In-Reply-To: <3474ebf5-c902-63e9-8244-08a0f3407b72@web.de>
References: <e4f3c4e8-03e8-dbc2-5871-0d111b3086a4@web.de>
 <alpine.DEB.2.22.394.2008020904310.2531@hadrien>
 <eead5e2a-da8d-83cd-eeb4-f193702b800f@web.de>
 <alpine.DEB.2.22.394.2008021348430.2531@hadrien>
 <82af6b44-ea09-b86f-81f7-e96e8594a31d@web.de>
 <alpine.DEB.2.22.394.2008021513010.2531@hadrien>
 <065fee88-5206-5d9b-c83c-4e6a20aefd85@web.de>
 <alpine.DEB.2.22.394.2008021632210.2531@hadrien>
 <8f357aa0-7811-a5b8-a061-814899654e88@web.de>
 <alpine.DEB.2.22.394.2008021733340.2531@hadrien>
 <c1822815-456f-316d-93b5-88beb55a0d69@web.de>
 <alpine.DEB.2.22.394.2008021814220.2531@hadrien>
 <74a5a472-4431-46e7-bd8b-95886f031c93@web.de>
 <alpine.DEB.2.22.394.2008021859010.2531@hadrien>
 <3474ebf5-c902-63e9-8244-08a0f3407b72@web.de>
Organization: Collabora
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 03 Aug 2020 10:22:19 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 03 Aug 2020 10:22:16 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] [00/43] cocci: Add support for meta attributes to SmPL
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

T24gTW9uLCAyMDIwLTA4LTAzIGF0IDA3OjM3ICswMjAwLCBNYXJrdXMgRWxmcmluZyB3cm90ZToK
PiA+ID4gRG8geW91IGNhcmUgaWYgYSBTbVBMIG5hbWUgdmFyaWFibGUgd291bGQgYWNjaWRlbnRh
bGx5IG5vdCBiZQo+ID4gPiB1c2VkCj4gPiA+IChsaWtlIGluIHRoZSBzY3JpcHQg4oCcCj4gPiA+
IGh0dHBzOi8vZ2l0aHViLmNvbS9jb2NjaW5lbGxlL2NvY2NpbmVsbGUvYmxvYi8wNGYzNmQ1Mzdi
OWY2YzBjMTI3ZDA1MTg0Y2NjZDIxZjFhNDZiOTUyL3Rlc3RzL21ldGFhdHRyLmNvY2NpI0wy4oCd
Cj4gPiA+ICk/Cj4gPiAKPiA+IEl0IGFjdHVhbGx5IGlzIHVzZWQsIHRvIGhlbHAgcGFyc2luZyB0
aGUgLmMgZmlsZS4gIFRoaXMgaW5mb3JtYXRpb24KPiA+IHdpbGwKPiA+IGJlIGFkZGVkIHRvIHRo
ZSBkb2N1bWVudGF0aW9uIHNob3J0bHkuCj4gCj4gSSB3b3VsZCBleHBlY3QgdGhhdCB0aGUgZm9s
bG93aW5nIFNtUEwgc2NyaXB0IHZhcmlhbnQgd2lsbCBnZW5lcmF0ZQo+IGFsc28gYSBwYXRjaC4K
PiAoV2h5IHdvdWxkIGV4dHJhIOKAnGhlbHDigJ0gYmUgbmVlZGVkIGZvciBwYXJzaW5nIHNvdXJj
ZSBmaWxlcz8pCj4gCj4gQHJlcGxhY2VtZW50QAo+IGF0dHJpYnV0ZSBhOwo+IGlkZW50aWZpZXIg
YjsKPiBAQAo+IC1pbnQKPiArY2hhcgo+ICBiIGEgPSAxOwo+IAo+IAo+IEJ5IHRoZSB3YXk6Cj4g
SSBoYXZlIG5vdGljZWQgYW5vdGhlciBkZXRhaWwgd2hpY2ggSSBmaW5kIHF1ZXN0aW9uYWJsZSBh
dCB0aGUKPiBtb21lbnQuCj4gCj4gZWxmcmluZ0BTb25uZTp+L1Byb2pla3RlL0NvY2NpbmVsbGUv
MjAxNjAyMDU+IHNwYXRjaCAtLXBhcnNlLWNvY2NpCj4gdGVzdHMvbWV0YWF0dHItMi5jb2NjaQo+
IOKApgo+ICgKPiAtaW50Cj4gICA+Pj4gY2hhcgo+ICBiIGEgPSAxOwo+IC1zaWduZWQKPiAgID4+
PiBjaGFyCj4gLWludCBiIGEgPSAxOwo+ICkKPiDigKYKPiAKClByb2JhYmx5IGEgcHJldHR5IHBy
aW50aW5nIG1pc3Rha2UuIEknbGwgZml4IHRoaXMuCgpUaGFua3MsCkphc2thcmFuLgoKPiBJIHdv
dWxkIGludGVycHJldCB0aGUgZGlzcGxheSBmb3IgdGhlIHNlY29uZCBwYXJ0IG9mIHN1Y2ggYSBT
bVBMCj4gZGlzanVuY3Rpb24KPiBpbiB0aGUgd2F5IHRoYXQgYSB2YXJpYWJsZSBkZWZpbml0aW9u
IHdpbGwgYmUgZGVsZXRlZCAoaW5zdGVhZCBvZgo+IHRha2luZyBvbmx5Cj4gdGhlIGtleSB3b3Jk
IOKAnHNpZ25lZOKAnSBhbHNvIGludG8gYWNjb3VudCBhY2NvcmRpbmcgdG8gdGhlIGlzb21vcnBo
aXNtCj4g4oCcYWRkX3NpZ25lZOKAnSkuCj4gCj4gUmVnYXJkcywKPiBNYXJrdXMKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlz
dApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9s
aXN0aW5mby9jb2NjaQo=
