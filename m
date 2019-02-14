Return-Path: <SRS0=eKzF=QV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D482FC43381
	for <cocci@archiver.kernel.org>; Thu, 14 Feb 2019 22:10:06 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4806121B1C
	for <cocci@archiver.kernel.org>; Thu, 14 Feb 2019 22:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=mykolab.com header.i=@mykolab.com header.b="qaAFgBsH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4806121B1C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mykolab.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1EM9ssK023555
          ; Thu, 14 Feb 2019 23:09:54 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E0D6E76FA;
	Thu, 14 Feb 2019 23:09:53 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 91ABC76F4
 for <cocci@systeme.lip6.fr>; Thu, 14 Feb 2019 23:09:52 +0100 (CET)
Received: from mx.kolabnow.com (mx.kolabnow.com [95.128.36.42])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1EM9oIc017368
 for <cocci@systeme.lip6.fr>; Thu, 14 Feb 2019 23:09:51 +0100 (CET)
X-pt: isis.lip6.fr
Received: from localhost (unknown [127.0.0.1])
 by ext-mx-out003.mykolab.com (Postfix) with ESMTP id C4F2741371;
 Thu, 14 Feb 2019 23:09:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mykolab.com; h=
 content-transfer-encoding:content-language:content-type
 :content-type:in-reply-to:mime-version:date:date:message-id:from
 :from:references:subject:subject:received:received:received; s=
 dkim20160331; t=1550182190; x=1551996591; bh=Ebd+hmGz1MbBDdINQVp
 fRr/+GqEyOd59EDPxsUqNeVk=; b=qaAFgBsHVQ+UNV0hta0bK/PlyWiaDFf1UVR
 gOrWbbE6sAVIOvCKtaV/oKTEdrXNFdoXQPgEYV063HarwBBCKpK1ldKZ+W643Oj4
 4vE80Murviz1/r0A3mbsGSAgQ5wgnRkO63+eRJWgIMp1JVGNBr2IuHB24ItQr7zA
 OlQaeGnCfzSmSI1riHCMf2PHd1aOHopUpir1iI3BaWarjK+PDm3dmAE6/SAoSJl0
 FCBMDQVascg2mZF92ncf93Y4qoaJALH/gMl+96zpzrNEwy0EP9v187Nbn8PBpJEp
 P5fcYDdXIMjrB0tlsnxM2OqYW4+eUIL5vl3KoMhm7iU08Vx+kVd3QRUdOgqVaMAe
 rFbEyB5qpTQPUUXHhlVFi1+YeFfvc9MfOQQ02jqjPn8k/wspFwsRM7m1T9qRiwh9
 KEM3nDn7Gl+ZJBXZwRoTK5yw/0jvQvSRaVvon5p3JmJApbWdptT8WrsiVgtXrWHS
 Ey1p1ZbvpyA9bbsRrxSOLoG02v7DqINXYw04TIuqyQ89x7t9xl9KOH1hMzOOON5R
 lEOMReJwLp/hr5cnPp5HM3UHlrM4pRy+G7EkwfEEXNHl2w6yhB5D4VffcwcYHFxq
 a5fovaZ53gv/2kGBj7FhjAVPpdvaoymyeekbpcqCtUioKGC5eXFdC++7c54zWMxc
 HkqSF+xk=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
 by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vnMdIwK2A8Dk; Thu, 14 Feb 2019 23:09:50 +0100 (CET)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
 by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 29CF941312;
 Thu, 14 Feb 2019 23:09:50 +0100 (CET)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
 by int-mx003.mykolab.com (Postfix) with ESMTPS id F253CB7A;
 Thu, 14 Feb 2019 23:09:49 +0100 (CET)
To: Julia Lawall <julia.lawall@lip6.fr>
References: <fb42aa05-f4d0-53cb-7eda-4f0a5db6cd3c@mykolab.com>
 <alpine.DEB.2.21.1902142227120.2804@hadrien>
From: Michael Stefaniuc <mstefani@mykolab.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mstefani@mykolab.com; prefer-encrypt=mutual; keydata=
 mQGiBEBzHYsRBACu8uw/xP4j/RYT/HBhw46jwNx9tJaHUADksKmmNRMVnpAX768sVFOMz+rO
 4Zfx0pGoaMrfw5yCh3v+fwh7hh8mMutZ6HmtOZho10hd/Kp+1JSpFDVP5b92ATr2Yexd+SXz
 jSbCDGLjGGpPWEEtNzu4UhdRwIIymdQqVTx6aCvscwCgvsbD+M9kmUWdToQI/H6QYsNBmukD
 /iPmBemMiw69xBzH+pLCpfdlnundj/ZXXdUO86Br6reg9q5m5Vv4ClyTHMIXcd6Dnm43S2Z9
 OvCDwtBMm+Hu5H89/B6E0NSyknn7CMciD3bLklFGQl4isyF+6Gnd5MTr1cM1Pm0EtYmCAdhK
 +h9SW2NWnPQOr2b3KRrn6rFRumTqA/0YDv8IvVRQZjv9DqK4YP7/va7GGUJHS44ksPyHuQXI
 gZVvHgE5ntSjBeUULoTk6vY55JTdgj3w2BdW9zvjUD9O7kDCf/sx74YvInw3bHsTDo4C7mr3
 QPWIVHKF63dElZwTNL+W0pzwDi6nBnu6RGpiQgI6gktIE13ySF1HjoKAjbQ1TWljaGFlbCBT
 dGVmYW5pdWMgKGVuYyBwd2Qga2V5KSA8bXN0ZWZhbmlAcmVkaGF0LmNvbT6IXwQTEQIAHwQL
 BwMCAxUCAwMWAgECHgECF4AFAlNET0gFCRw3Mz0ACgkQ0ei8kcpE1VFHMgCgtPjwlA34jJ2F
 a1TPymfo6IGo9y4Anj05IAwUKKSPJez3LojfovAYMEryuQINBFNETU8BEAD2GkRuwYIX8RZt
 rxtlr5m3mVvxeW4k+Zq7LfFDJ4tGFDDIQAGWPK1RfljVjvPSPxzsoj+KynXnIqw9e6PoSNg3
 tDMQaKvaLpzAKRUZIRJrIdCNuXQxvVI6Jxgg3GVbFider//67y+8rBJE5+QZp5zaIS4ifm90
 9NnHtOvr0ddJ1r26IwOo8/Pyg7y+bTN/Xuu5qr/zOeTcdJMtaQ2kbBh3IU2FSRGvUZTG9UNg
 aU54KKX7+Zu3cziEK87r89Y1fZTr0rZfdQNaUwivxHY4nOXN+EAFl3mfaHnYIsdSDG3mqza8
 RgoqLJpOGvl0JVlyYI9jgOvi05q+kFzGlZj1raAgnImzXh3p2se1sxUuXrmYkQt9b9OrFiCf
 XYuWEVgNoW6qpmzYHkjOGBcATANhv9JBoNbMQEsg7oeyeCZzI3se8yXkif89NLB3MmLFHcPV
 ui8Pv/6Y9/MAHq6ohM7AVJtOKt21jsb8R+Me3k5BoHkdU3iUAviScLKqiR5v5eL084gZtijv
 2ZgGfw1bNcX3y7VYsw5omvw042uGxzA76tm9hRjxDKK9OA/GAtkv20gusA4fZXUSuy7RRJ8N
 T7U24WD4lRLCBjkNnV4izQHr9qwM6I/5/jP8mguRSL7HguxBLcyL7ZQ01aQALcc43v/p5Vw4
 96b3Et/nZrVw04xtwwvuhQARAQABiE8EGBECAA8CGwwFAlNET6oFCQlmA9sACgkQ0ei8kcpE
 1VGjvgCfWX5kaF0YptgUFItMH6U8kA6vnRsAoJkVZPLvJDyYi4TiEaZXyk+3DKPf
Message-ID: <bcdc0b27-8ede-f77b-4d99-26e8a0bb6e5a@mykolab.com>
Date: Thu, 14 Feb 2019 23:09:48 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902142227120.2804@hadrien>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 14 Feb 2019 23:09:54 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 14 Feb 2019 23:09:51 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Qualifiers for field types get lost
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

T24gMi8xNC8xOSAxMDozOCBQTSwgSnVsaWEgTGF3YWxsIHdyb3RlOgo+IAo+IAo+IE9uIFRodSwg
MTQgRmViIDIwMTksIE1pY2hhZWwgU3RlZmFuaXVjIHdyb3RlOgo+IAo+PiBIZWxsbywKPj4KPj4g
SSBoYXZlIHRoaXMgdHJpdmlhbCBzY3JpcHQgdG8gcmVtb3ZlIHVzZWxlc3MgY2FzdHMgdG8gc2Vs
ZjoKPj4gQCBkaXNhYmxlIGRyb3BfY2FzdCBACj4+IHR5cGUgVDsKPj4gVCBFOwo+PiBAQAo+PiAt
IChUKQo+PiAgICAgIEUKPj4KPj4gSXQgd29ya3MgYnV0IEknbSBoaXR0aW5nIGZhbHNlIHBvc2l0
aXZlcyB3aGVuIHRoZSBjb2RlIGNhc3RzIGF3YXkKPj4gcXVhbGlmaWVycyBmb3IgZmllbGQgdHlw
ZXMuIFBsZWFzZSBzZWUgdGhlIGF0dGFjaGVkIHRlc3QgY2FzZToKPj4gLSBHb29kOiBDYXN0IGlz
IGtlcHQgaW4gZm9vKCkKPj4gLSBCYWQ6IENhc3QgaXMgZHJvcHBlZCBpbiBiYXooKQo+Pgo+PiBB
cHBseWluZyB0aGUgZ2VuZXJhdGVkIGRpZmYgd2lsbCBsZWFkIHRvIGEgZ2NjIHdhcm5pbmc6Cj4+
ICQgZ2NjIC1jICBxdWFsaWZpZXIuYwo+PiBxdWFsaWZpZXIuYzogSW4gZnVuY3Rpb24g4oCYYmF6
4oCZOgo+PiBxdWFsaWZpZXIuYzoxMjoxMjogd2FybmluZzogcmV0dXJuIGRpc2NhcmRzIOKAmGNv
bnN04oCZIHF1YWxpZmllciBmcm9tCj4+IHBvaW50ZXIgdGFyZ2V0IHR5cGUgWy1XZGlzY2FyZGVk
LXF1YWxpZmllcnNdCj4+ICAgICAgcmV0dXJuICZiLT5pOwo+PiAgICAgICAgICAgICBefn5+fgo+
Pgo+PiBJIHRyaWVkIGRpc2FibGluZyB0aGUgb3B0aW9uYWxfcXVhbGlmaWVyIGlzbyBidXQgdGhh
dCBoYXMgbm8gZWZmZWN0Ogo+PiAtIE5vdCBuZWVkZWQgZm9yIHRoZSBmb28oKSBjYXNlCj4+IC0g
Tm8gZWZmZWN0IGZvciB0aGUgYmF6KCkgY2FzZQo+Pgo+PiBJIGV2ZW4gdHJpZWQgcHJlcGVuZGlu
ZyBhbiBhbHRlcm5hdGlvbiB3aXRoICJjb25zdCBUIGdvb2Q7IiBidXQgdGhlIGNhc3QKPj4gc3Rp
bGwgZ2V0cyByZW1vdmVkLgo+IAo+IFRoZSBmb2xsb3dpbmcgaXMgYmV0dGVyLCBidXQgbm90IHBl
cmZlY3QsIGluIHRoYXQgaXQgcmVxdWlyZXMgdGhhdCB0aGUKPiBjb25zdCB0aGluZyBoYXZlIHR5
cGUgcG9pbnRlciB0byBhIHN0cnVjdHVyZS4gIEl0IGNvdWxkIGJlIHBvc3NpYmxlIHRvCj4gZXhw
bGljaXRseSBjb25zaWRlciBtb3JlIHR5cGUgcGF0dGVybnMuCldlbGwsIGl0IGRvZXNuJ3QgZml4
ZXMgdGhlIHByb2JsZW0gdGhhdCB0aGUgcXVhbGlmaWVyIGlzIG5vdCBwcm9wYWdhdGVkCmZyb20g
dGhlIHN0cnVjdCB0byBpdHMgZmllbGRzLiBDb2RlIGxpa2UgdGhpcyBpc24ndCBtYXRjaGVkIHdp
dGggb3IKd2l0aG91dCB0aGUgY29jY2kgbW9kaWZpY2F0aW9uLgoKY29uc3QgaW50ICp6enooY29u
c3Qgc3RydWN0IGJhciAqYikKewogICAgcmV0dXJuIChjb25zdCBpbnQgKikmYi0+aTsKfQoKVGhh
dCdzIGJlY2F1c2UgIiZiLT5pIiBoYXMgdGhlIHR5cGUgb2YganVzdCAiaW50KiIgaW5zdGVhZCBv
ZiB0aGUKY29ycmVjdCAiY29uc3QgaW50KiIuCgpieWUKCW1pY2hhZWwKCj4gCj4gQGRpc2FibGUg
ZHJvcF9jYXN0QAo+IHR5cGUgVCxUMTsKPiBUIEU7Cj4gaWRlbnRpZmllciBpOwo+IGNvbnN0IHN0
cnVjdCBpICpjOwo+IEBACj4gCj4gKAo+ICAgYwo+IHwKPiAtIChUKQo+ICAgIEUKPiApCj4gCj4g
anVsaWEKPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1l
LmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
