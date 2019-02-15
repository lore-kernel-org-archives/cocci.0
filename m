Return-Path: <SRS0=7OsK=QW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F03FC43381
	for <cocci@archiver.kernel.org>; Fri, 15 Feb 2019 20:04:59 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C97321B18
	for <cocci@archiver.kernel.org>; Fri, 15 Feb 2019 20:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=mykolab.com header.i=@mykolab.com header.b="bJUjmgG0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C97321B18
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mykolab.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1FK4cHP001530
          ; Fri, 15 Feb 2019 21:04:38 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4F0E376FA;
	Fri, 15 Feb 2019 21:04:38 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8E82276F7
 for <cocci@systeme.lip6.fr>; Fri, 15 Feb 2019 21:04:37 +0100 (CET)
Received: from mx.kolabnow.com (mx.kolabnow.com [95.128.36.40])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1FK4aA7018397
 for <cocci@systeme.lip6.fr>; Fri, 15 Feb 2019 21:04:36 +0100 (CET)
X-pt: isis.lip6.fr
Received: from localhost (unknown [127.0.0.1])
 by ext-mx-out002.mykolab.com (Postfix) with ESMTP id 68ACC1535;
 Fri, 15 Feb 2019 21:04:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mykolab.com; h=
 content-transfer-encoding:content-language:content-type
 :content-type:in-reply-to:mime-version:date:date:message-id:from
 :from:references:subject:subject:received:received:received; s=
 dkim20160331; t=1550261075; x=1552075476; bh=WiZ9geQp+ya7HEDz1Mq
 3of0hMiBp6FT+V0z6uTXtFA0=; b=bJUjmgG0/Sdr+yk+UAAZw70g7is75+oDavz
 0nJhxv/sJ4v+LQVbZHvkKdMJZGluGOJW5Jakhngy595/7yjRipIgP0hi7ZhtPXYs
 c3+LtZ0V6/zJKMgPLKf1gjKvK4Qdv+O5+5w2pBhg3gcLYiVLAQQWZD2dsJfNuBd3
 q/ljotl2eB5b3F6pHMjDdd94okzr8PJIa5pRLEYzYBRfB8f4YOP1hV/VpYsmYA0S
 FAmX4GcfA9RicVp+V9M8NyuSotOgBqeXFPK1/+SPRFk+yHC6CIUmG/2thR+uTdze
 MZOZr5xJwNsjTR94at3VmESpvK+5ZnHa5IygWQxkrx4D4GcipL31afkp0a09b8hN
 mvBSt6nrbOyZLB1gb7Kn1J8FifbWFjIowkUC/VHDd3hZqWWahbOeV+a7VqjYHDMl
 NXOYbTKgiXMwMhlLvE6g+wHltPwdhDVtrsdZbyztspXn8qsOTDavylUxl2iZdETB
 zpsdsPw7e1sNBcIyv757BzfRU4x+Yuz+1oqXBd/DoCCH7wMwanauMQCAVlR9uXvg
 RxDcwRtT1i0JFsZ18MJaRdklqk8YwcxTPC/XT6V4b65oDOSqpIMtUTNJ24s/icX8
 zBb50crROMXFjH3vIb4XEe4D/devijHl8l34d0fv/7OVwq82ixUXsZ3l3SPLkx/T
 0jPo+TGA=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
 by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lzZmk8VPXzBt; Fri, 15 Feb 2019 21:04:35 +0100 (CET)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
 by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id 613BC330;
 Fri, 15 Feb 2019 21:04:35 +0100 (CET)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
 by int-mx002.mykolab.com (Postfix) with ESMTPS id 0AF402579;
 Fri, 15 Feb 2019 21:04:34 +0100 (CET)
To: Julia Lawall <julia.lawall@lip6.fr>
References: <fb42aa05-f4d0-53cb-7eda-4f0a5db6cd3c@mykolab.com>
 <alpine.DEB.2.21.1902142227120.2804@hadrien>
 <bcdc0b27-8ede-f77b-4d99-26e8a0bb6e5a@mykolab.com>
 <alpine.DEB.2.21.1902150721060.2896@hadrien>
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
Message-ID: <0424c3b6-e69e-8aa0-e324-ffd0af304705@mykolab.com>
Date: Fri, 15 Feb 2019 21:04:33 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902150721060.2896@hadrien>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 15 Feb 2019 21:04:38 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 15 Feb 2019 21:04:36 +0100 (CET)
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

T24gMi8xNS8xOSA3OjIyIEFNLCBKdWxpYSBMYXdhbGwgd3JvdGU6Cj4gCj4gCj4gT24gVGh1LCAx
NCBGZWIgMjAxOSwgTWljaGFlbCBTdGVmYW5pdWMgd3JvdGU6Cj4gCj4+IE9uIDIvMTQvMTkgMTA6
MzggUE0sIEp1bGlhIExhd2FsbCB3cm90ZToKPj4+Cj4+Pgo+Pj4gT24gVGh1LCAxNCBGZWIgMjAx
OSwgTWljaGFlbCBTdGVmYW5pdWMgd3JvdGU6Cj4+Pgo+Pj4+IEhlbGxvLAo+Pj4+Cj4+Pj4gSSBo
YXZlIHRoaXMgdHJpdmlhbCBzY3JpcHQgdG8gcmVtb3ZlIHVzZWxlc3MgY2FzdHMgdG8gc2VsZjoK
Pj4+PiBAIGRpc2FibGUgZHJvcF9jYXN0IEAKPj4+PiB0eXBlIFQ7Cj4+Pj4gVCBFOwo+Pj4+IEBA
Cj4+Pj4gLSAoVCkKPj4+PiAgICAgIEUKPj4+Pgo+Pj4+IEl0IHdvcmtzIGJ1dCBJJ20gaGl0dGlu
ZyBmYWxzZSBwb3NpdGl2ZXMgd2hlbiB0aGUgY29kZSBjYXN0cyBhd2F5Cj4+Pj4gcXVhbGlmaWVy
cyBmb3IgZmllbGQgdHlwZXMuIFBsZWFzZSBzZWUgdGhlIGF0dGFjaGVkIHRlc3QgY2FzZToKPj4+
PiAtIEdvb2Q6IENhc3QgaXMga2VwdCBpbiBmb28oKQo+Pj4+IC0gQmFkOiBDYXN0IGlzIGRyb3Bw
ZWQgaW4gYmF6KCkKPj4+Pgo+Pj4+IEFwcGx5aW5nIHRoZSBnZW5lcmF0ZWQgZGlmZiB3aWxsIGxl
YWQgdG8gYSBnY2Mgd2FybmluZzoKPj4+PiAkIGdjYyAtYyAgcXVhbGlmaWVyLmMKPj4+PiBxdWFs
aWZpZXIuYzogSW4gZnVuY3Rpb24g4oCYYmF64oCZOgo+Pj4+IHF1YWxpZmllci5jOjEyOjEyOiB3
YXJuaW5nOiByZXR1cm4gZGlzY2FyZHMg4oCYY29uc3TigJkgcXVhbGlmaWVyIGZyb20KPj4+PiBw
b2ludGVyIHRhcmdldCB0eXBlIFstV2Rpc2NhcmRlZC1xdWFsaWZpZXJzXQo+Pj4+ICAgICAgcmV0
dXJuICZiLT5pOwo+Pj4+ICAgICAgICAgICAgIF5+fn5+Cj4+Pj4KPj4+PiBJIHRyaWVkIGRpc2Fi
bGluZyB0aGUgb3B0aW9uYWxfcXVhbGlmaWVyIGlzbyBidXQgdGhhdCBoYXMgbm8gZWZmZWN0Ogo+
Pj4+IC0gTm90IG5lZWRlZCBmb3IgdGhlIGZvbygpIGNhc2UKPj4+PiAtIE5vIGVmZmVjdCBmb3Ig
dGhlIGJheigpIGNhc2UKPj4+Pgo+Pj4+IEkgZXZlbiB0cmllZCBwcmVwZW5kaW5nIGFuIGFsdGVy
bmF0aW9uIHdpdGggImNvbnN0IFQgZ29vZDsiIGJ1dCB0aGUgY2FzdAo+Pj4+IHN0aWxsIGdldHMg
cmVtb3ZlZC4KPj4+Cj4+PiBUaGUgZm9sbG93aW5nIGlzIGJldHRlciwgYnV0IG5vdCBwZXJmZWN0
LCBpbiB0aGF0IGl0IHJlcXVpcmVzIHRoYXQgdGhlCj4+PiBjb25zdCB0aGluZyBoYXZlIHR5cGUg
cG9pbnRlciB0byBhIHN0cnVjdHVyZS4gIEl0IGNvdWxkIGJlIHBvc3NpYmxlIHRvCj4+PiBleHBs
aWNpdGx5IGNvbnNpZGVyIG1vcmUgdHlwZSBwYXR0ZXJucy4KPj4gV2VsbCwgaXQgZG9lc24ndCBm
aXhlcyB0aGUgcHJvYmxlbSB0aGF0IHRoZSBxdWFsaWZpZXIgaXMgbm90IHByb3BhZ2F0ZWQKPj4g
ZnJvbSB0aGUgc3RydWN0IHRvIGl0cyBmaWVsZHMuIENvZGUgbGlrZSB0aGlzIGlzbid0IG1hdGNo
ZWQgd2l0aCBvcgo+PiB3aXRob3V0IHRoZSBjb2NjaSBtb2RpZmljYXRpb24uCj4+Cj4+IGNvbnN0
IGludCAqenp6KGNvbnN0IHN0cnVjdCBiYXIgKmIpCj4+IHsKPj4gICAgIHJldHVybiAoY29uc3Qg
aW50ICopJmItPmk7Cj4+IH0KPj4KPj4gVGhhdCdzIGJlY2F1c2UgIiZiLT5pIiBoYXMgdGhlIHR5
cGUgb2YganVzdCAiaW50KiIgaW5zdGVhZCBvZiB0aGUKPj4gY29ycmVjdCAiY29uc3QgaW50KiIu
Cj4gCj4gT0suICBJIGNhbiBjaGFuZ2UgaXQgaW4gdGhlIHdheSB0aGF0IGlzIHN1Z2dlc3RlZC4g
IEluIHRoZSBzaG9ydCB0ZXJtLCB5b3UKPiBjYW4gYWRkIGFub3RoZXIgY2FzZSB0byB0aGUgZGlz
anVuY3Rpb24sIGllIC0gKGNvbnN0IFQpLCB0byByZWR1Y2UgdGhlCj4gbnVtYmVyIG9mIGZhbHNl
IHBvc2l0aXZlcy4KVGhhbmtzIQpJIGp1c3Qgd2FudGVkIHRvIHJlcG9ydCB0aGUgYnVnLCB0aGVy
ZSdzIG5vIHVyZ2VuY3kgd2hhdHNvZXZlci4KQWZ0ZXIgYWxsIHRoaXMgaXMganVzdCBqYW5pdG9y
aWFsIHdvcmssIEknbSBzdXJlIHRoZSBjYXN0cyB3aWxsIHdhaXQgZm9yCm1lIGEgZmV3IG1vcmUg
eWVhcnMgOykKCmJ5ZQoJbWljaGFlbAoKCgo+Pj4KPj4+IEBkaXNhYmxlIGRyb3BfY2FzdEAKPj4+
IHR5cGUgVCxUMTsKPj4+IFQgRTsKPj4+IGlkZW50aWZpZXIgaTsKPj4+IGNvbnN0IHN0cnVjdCBp
ICpjOwo+Pj4gQEAKPj4+Cj4+PiAoCj4+PiAgIGMKPj4+IHwKPj4+IC0gKFQpCj4+PiAgICBFCj4+
PiApCj4+Pgo+Pj4ganVsaWEKPj4+Cj4+Cj4+Cj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5s
aXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
