Return-Path: <SRS0=cjTc=E2=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDD9C5519F
	for <cocci@archiver.kernel.org>; Fri, 20 Nov 2020 13:16:40 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 111D522253
	for <cocci@archiver.kernel.org>; Fri, 20 Nov 2020 13:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=metafoo.de header.i=@metafoo.de header.b="ca0XXgVY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 111D522253
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=metafoo.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0AKDGD0u019238;
	Fri, 20 Nov 2020 14:16:14 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DE0657789;
	Fri, 20 Nov 2020 14:16:13 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 100767B6
 for <cocci@systeme.lip6.fr>; Fri, 20 Nov 2020 14:16:12 +0100 (CET)
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0AKDG7pP004909
 for <cocci@systeme.lip6.fr>; Fri, 20 Nov 2020 14:16:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de; 
 s=default2002;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=uNlmvTkJlfUfkP1mNVRlX6byRmlW03DDOuT/fy6Pb1s=; b=ca0XXgVYissccmdKgaqut10/FO
 TAtmChNCYpNV89EasjoGQIDrEctV7V6CPclmKyJOWw+zsRFnSr4Au5MONgXwyKSQnat4ipk2TizpY
 fRarKyOct1Zg7jjRizKZUxEm2VCKviawLgjQfzRd8pPyWCLlVB/Mj7hjPQrBZywYKuxpzMrAvJ/K4
 q9acNRrRnuxyKoaj7WbyhejLQUuCN9Mikz3YfPCfb4JA6O4bndMpfjO/Qvbwa2lkI9IYgHJ5yKkE7
 gEyBZ8l/xrX2O13LRtPXxr6kRiXcaRblQ/9DBNPbsUw5K1OVFGCZbGXnPRGw/LJDH4ZV3IKfE7fBr
 5uVDzPhA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
 by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92.3) (envelope-from <lars@metafoo.de>)
 id 1kg6Gf-0004jy-6g; Fri, 20 Nov 2020 14:16:02 +0100
Received: from [62.216.202.98] (helo=[192.168.178.20])
 by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <lars@metafoo.de>)
 id 1kg6Ge-0008B9-Ue; Fri, 20 Nov 2020 14:16:01 +0100
To: Alexandru Ardelean <ardeleanalex@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>
References: <CA+U=Dspy5+RE9agcLr6eY9DCMa1c5+++0JLeugMMBRXz4YLj1w@mail.gmail.com>
 <CAHp75VcT5hZH6m0Dri1h_EFjc7=4+1XoE7sRuQyfO75k9A0GKA@mail.gmail.com>
 <b74517242de5790f8ab0cd9be00a70b9ab96564c.camel@perches.com>
 <alpine.DEB.2.22.394.2011201140480.2750@hadrien>
 <CA+U=Dsp8Aws7_GARfgNE4w_1pK-hDVW9WVsWHF1TfZUEUo0Hbw@mail.gmail.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <4af50412-a22f-4ca1-adb0-d732438c6669@metafoo.de>
Date: Fri, 20 Nov 2020 14:16:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CA+U=Dsp8Aws7_GARfgNE4w_1pK-hDVW9WVsWHF1TfZUEUo0Hbw@mail.gmail.com>
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/25993/Thu Nov 19 14:11:24 2020)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 20 Nov 2020 14:16:14 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 20 Nov 2020 14:16:08 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: LKML <linux-kernel@vger.kernel.org>, Robo Bot <apw@canonical.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Joe Perches <joe@perches.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        cocci <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Proposal for a new checkpatch check;
 matching _set_drvdata() & _get_drvdata()
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

T24gMTEvMjAvMjAgMTI6NTQgUE0sIEFsZXhhbmRydSBBcmRlbGVhbiB3cm90ZToKPiBPbiBGcmks
IE5vdiAyMCwgMjAyMCBhdCAxMjo0NyBQTSBKdWxpYSBMYXdhbGwgPGp1bGlhLmxhd2FsbEBpbnJp
YS5mcj4gd3JvdGU6Cj4+Cj4+Cj4+IE9uIFRodSwgMTkgTm92IDIwMjAsIEpvZSBQZXJjaGVzIHdy
b3RlOgo+Pgo+Pj4gT24gVGh1LCAyMDIwLTExLTE5IGF0IDE3OjE2ICswMjAwLCBBbmR5IFNoZXZj
aGVua28gd3JvdGU6Cj4+Pj4gT24gVGh1LCBOb3YgMTksIDIwMjAgYXQgNDowOSBQTSBBbGV4YW5k
cnUgQXJkZWxlYW4KPj4+PiA8YXJkZWxlYW5hbGV4QGdtYWlsLmNvbT4gd3JvdGU6Cj4+Pj4+IEhl
eSwKPj4+Pj4KPj4+Pj4gU28sIEkgc3R1bWJsZWQgb24gYSBuZXcgY2hlY2sgdGhhdCBjb3VsZCBi
ZSBhZGRlZCB0byBjaGVja3BhdGNoLgo+Pj4+PiBTaW5jZSBpdCdzIGluIFBlcmwsIEknbSByZWx1
Y3RhbnQgdG8gdHJ5IGl0Lgo+Pj4+Pgo+Pj4+PiBTZWVtcyBtYW55IGRyaXZlcnMgZ290IHRvIGEg
cG9pbnQgd2hlcmUgdGhleSBub3cgY2FsbCAobGV0J3Mgc2F5KQo+Pj4+PiBzcGlfc2V0X2RydmRh
dGEoKSwgYnV0IG5ldmVyIGFjY2VzcyB0aGF0IGluZm9ybWF0aW9uIHZpYQo+Pj4+PiBzcGlfZ2V0
X2RydmRhdGEoKS4KPj4+Pj4gUmVhc29ucyBmb3IgdGhpcyBzZWVtIHRvIGJlOgo+Pj4+PiAxLiBU
aGV5IGdvdCBjb252ZXJ0ZWQgdG8gZGV2aWNlLW1hbmFnZWQgZnVuY3Rpb25zIGFuZCB0aGVyZSBp
cyBubwo+Pj4+PiBsb25nZXIgYSByZW1vdmUgaG9vayB0byByZXF1aXJlIHRoZSBfZ2V0X2RydmRh
dGEoKSBhY2Nlc3MKPj4+Pj4gMi4gVGhleSBsb29rIGxpa2UgdGhleSB3ZXJlIGNvcGllZCBmcm9t
IGEgZHJpdmVyIHRoYXQgaGFkIGEKPj4+Pj4gX3NldF9kcnZkYXRhKCkgYW5kIHdoZW4gdGhlIGNv
ZGUgZ290IGZpbmFsaXplZCwgdGhlIF9zZXRfZHJ2ZGF0YSgpIHdhcwo+Pj4+PiBvbWl0dGVkCj4+
Pj4+Cj4+Pj4+IFRoZXJlIGFyZSBhIGZldyBmYWxzZSBwb3NpdGl2ZXMgdGhhdCBJIGNhbiBub3Rp
Y2UgYXQgYSBxdWljayBsb29rLAo+Pj4+PiBsaWtlIHRoZSBkYXRhIGJlaW5nIHNldCB2aWEgc29t
ZSB4eHhfc2V0X2RydmRhdGEoKSBhbmQgcmV0cmlldmVkIHZpYSBhCj4+Pj4+IGRldl9nZXRfZHJ2
ZGF0YSgpLgo+Pj4+IEkgY2FuIHNheSBxdWl0ZSBhIGZldy4gQW5kIHRoaXMgbWFrZXMgYSBkaWZm
ZXJlbmNlLgo+Pj4+IFNvLCBiYXNpY2FsbHkgYWxsIGRyaXZlcnMgdGhhdCBhcmUgdXNpbmcgUE0g
Y2FsbGJhY2tzIHdvdWxkIHJhdGhlciB1c2UKPj4+PiBkZXZfZ2V0X2RydmRhdGEoKSByYXRoZXIg
dGhhbiBidXMgc3BlY2lmaWMuCj4+Pj4KPj4+Pj4gSSB0aGluayBjaGVja3BhdGNoIHJlcG9ydGlu
ZyB0aGVzZSBhcyB3ZWxsIHdvdWxkIGJlIGFjY2VwdGFibGUgc2ltcGx5Cj4+Pj4+IGZyb20gYSBy
ZXZpZXdhYmlsaXR5IHBlcnNwZWN0aXZlLgo+Pj4+Pgo+Pj4+PiBJIGRpZCBhIHNoZWxsIHNjcmlw
dCB0byBxdWlja2x5IGNoZWNrIHRoZXNlLiBTZWUgYmVsb3cuCj4+Pj4+IEl0J3MgcHJldHR5IGJh
ZGx5IHdyaXR0ZW4gYnV0IGl0IGlzIGVub3VnaCBmb3IgbWUgdG8gZ2F0aGVyIGEgbGlzdC4KPj4+
Pj4gQW5kIEkgd3JvdGUgaXQgaW4gNSBtaW51dGVzIDpQCj4+Pj4+IEkgaW5pdGlhbGx5IG5vdGlj
ZWQgdGhpcyBpbiBzb21lIElJTyBkcml2ZXJzLCBhbmQgdGhlbiBJIHN1c3BlY3RlZAo+Pj4+PiB0
aGF0IHRoaXMgbWF5IGJlIG1vcmUgd2lkZXNwcmVhZC4KPj4+PiBJdCBzZWVtcyBtb3JlIHN1aXRh
YmxlIGZvciBjb2NjaW5lbGxlLgo+Pj4gVG8gbWUgYXMgd2VsbC4KPj4gVG8gbWUgYXMgd2VsbCwg
c2luY2UgaXQgc2VlbXMgdG8gaW52b2x2ZSBub25sb2NhbCBpbmZvcm1hdGlvbi4KPj4KPj4gSSdt
IG5vdCBzdXJlIHRvIHVuZGVyc3RhbmQgdGhlIG9yaWdpbmFsIHNoZWxsIHNjcmlwdC4gSXMgdGhl
cmUKPj4gc29tZXRoaW5nIGludGVyZXN0aW5nIGFib3V0IHBjaV9zZXRfZHJ2ZGF0YT8KPiBBaCwg
aXQncyBhIHN0dXBpZCBzY3JpcHQgSSB3cm90ZSBpbiA1IG1pbnV0ZXMsIHNvIEkgZGlkIG5vdCBi
b3RoZXIgdG8KPiBtYWtlIHRoaW5ncyBzbWFydC4KPiBJbiB0aGUgdGV4dC1tYXRjaGluZyBJIGRp
ZCBpbiBzaGVsbCwgdGhlcmUgYXJlIHNvbWUgZW50cmllcyB0aGF0IGNvbWUKPiBmcm9tIGNvbW1l
bnRzIGFuZCBkb2NzLgo+IEl0J3Mgb25seSBhYm91dCAzLTQgZW50cmllcywgc28gSSBqdXN0IGRp
ZCBhIHZpc3VhbC9tYW51YWwgaWdub3JlLgo+Cj4gSW4gZXNzZW5jZToKPiBUaGUgc2NyaXB0IHNl
YXJjaGVzIGZvciBhbGwgc3RyaW5ncyB0aGF0IGNvbnRhaW4gX3NldF9kcnZkYXRhLgo+IFRoZSBz
ZXBhcmF0b3JzIGFyZSB3aGl0ZXNwYWNlLgo+IEl0IGNyZWF0ZXMgYSBsaXN0IG9mIGFsbCAgeHh4
eF9zZXRfZHJ2ZGF0YSBmdW5jdGlvbnMuCj4gRm9yIGVhY2ggeHh4eF9zZXRfZHJ2ZGF0YSBmdW5j
dGlvbjoKPiAgICAgIEl0IGNoZWNrcyBhbGwgZmlsZXMgdGhhdCBoYXZlIGEgeHh4eF9zZXRfZHJ2
ZGF0YSBlbnRyeSwgYnV0IG5vCj4geHh4eF9nZXRfZHJ2ZGF0YQo+Cj4gSSBwaXBlZCB0aGlzIG91
dHB1dCBpbnRvIGEgZmlsZSBhbmQgc3RhcnRlZCBtYW51YWxseSBjaGVja2luZyB0aGUgZHJpdmVy
cy4KPiBUaGVyZSBpcyBvbmUgW0kgZm9yZ2V0IHdoaWNoIGZ1bmN0aW9uXSB0aGF0IGlzIHh4eHhf
c2V0X2RydmRhdGEoKSBidXQKPiBlcXVpdmFsZW50IGlzIHh4eHhfZHJ2ZGF0YSgpCj4KPiBBcyBB
bmR5IHNhaWQsIHNvbWUgcHJlY2F1dGlvbnMgbXVzdCBiZSB0YWtlbiBpbiBwbGFjZXMgd2hlcmUK
PiB4eHh4X3NldF9kcnZkYXRhKCkgaXMgY2FsbGVkIGJ1dCBkZXZfZ2V0X2RydmRhdGEoKSBpcyB1
c2VkLgo+IENhc2VzIGxpa2UgUE0gc3VzcGVuZC9yZXN1bWUgY2FsbHMuCj4gQW5kIHRoZXJlIG1h
eSBiZSBzb21lIGNhc2VzIG91dHNpZGUgdGhpcyBjb250ZXh0Lgo+CkRvaW5nIHNvbWV0aGluZyBs
aWtlIHRoaXMgd2l0aCBjb2NjaW5lbGxlIGlzIGZhaXJseSBlYXN5LgoKQnV0IEknZCBiZSB2ZXJ5
IGNhdXRpb3VzIGFib3V0IHB1dHRpbmcgc3VjaCBhIHNjcmlwdCBpbnRvIHRoZSBrZXJuZWwuIEl0
IAp3aWxsIHJlc3VsdCBpbiB0b28gbWFueSBmYWxzZSBwb3NpdGl2ZSBkcml2ZS1ieSBwYXRjaGVz
LiBTdWNoIGEgc2NyaXB0IAp3aWxsIG5vdCBkZXRlY3QgY2FzZXMgc3VjaCBhczoKCiDCoCogRHJp
dmVyIGlzIHNwbGl0IG92ZXIgbXVsdGlwbGUgZmlsZXMuIE9uZSBmaWxlIGRvZXMgCi4uLl9zZXRf
ZHJ2ZGF0YSgpLCBhbm90aGVyIGRvZXMgLi4uX2dldF9kcnZkYXRhKCkuCgogwqAqIEZyYW1ld29y
ayB1c2VzIGRydmRhdGEgdG8gZXhjaGFuZ2UgZGF0YSB3aXRoIHRoZSBkcml2ZXIuIEUuZyBkcml2
ZXIgCmlzIGV4cGVjdGVkIHRvIGNhbGwgc2V0X2RydmRhdGEoKSBhbmQgdGhlbiB0aGUgZnJhbWV3
b3JrIHVzZXMgCmdldF9kcnZkYXRhKCkgdG8gcmV0cmlldmUgdGhlIGRhdGEuIFRoaXMgaXMgbm90
IGEgdmVyeSBnb29kIHBhdHRlcm4sIGJ1dCAKdGhlcmUgYXJlIHNvbWUgcGFsY2VzIGludCBoZSBr
ZXJuZWwgd2hlcmUgdGhpcyBpcyB1c2VkLiBJIGJlbGlldmUgZm9yIApleGFtcGxlIFY0TDIgdXNl
cyB0aGlzLgoKLSBMYXJzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8v
c3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
