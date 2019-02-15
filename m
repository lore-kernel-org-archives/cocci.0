Return-Path: <SRS0=7OsK=QW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A1FC43381
	for <cocci@archiver.kernel.org>; Fri, 15 Feb 2019 19:59:30 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B334021B18
	for <cocci@archiver.kernel.org>; Fri, 15 Feb 2019 19:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=mykolab.com header.i=@mykolab.com header.b="UBCaIDBY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B334021B18
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mykolab.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1FJx5c8025374
          ; Fri, 15 Feb 2019 20:59:05 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8E3DB76FA;
	Fri, 15 Feb 2019 20:59:05 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 51DD176F7
 for <cocci@systeme.lip6.fr>; Fri, 15 Feb 2019 20:59:03 +0100 (CET)
Received: from mx.kolabnow.com (mx.kolabnow.com [95.128.36.42])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1FJx2jm029204
 for <cocci@systeme.lip6.fr>; Fri, 15 Feb 2019 20:59:02 +0100 (CET)
X-pt: isis.lip6.fr
Received: from localhost (unknown [127.0.0.1])
 by ext-mx-out001.mykolab.com (Postfix) with ESMTP id 24A411501;
 Fri, 15 Feb 2019 20:59:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mykolab.com; h=
 content-transfer-encoding:content-language:content-type
 :content-type:in-reply-to:mime-version:date:date:message-id:from
 :from:references:subject:subject:received:received:received; s=
 dkim20160331; t=1550260741; x=1552075142; bh=m1NQNAKC6yE0gri7NuD
 SaKIAV5FQ+7cxZ2mUUCDo2ig=; b=UBCaIDBYBKQMEHFcIoQfLe7s3wJsdrI/nZq
 MQ5I6IMfQMYjGtw+kVxsi4vrKnguY7eRUrlURw/JgWxakCXkhETNf1KAHU43u9cT
 fiIToBhgWzVQXR9XuQcuM6+zMP5TTAdD30sOzb8XulLzPGhm97ESrHp6IrJGDFjp
 1IFgVCi2ht4e/1e65Ek76vd6JJoP2hPu9kdhtHFZaqTTb34tYEcH074jwts5Pie7
 ao0NHXqYKGQ0lbUgxhvfspGD+qIjJXGh6o+d8T2fDoUQawzQF9uhSp983wt34h3w
 0ILb2xIqzAJ008d3ZQikxcwxg5HnVWCtvEUhxglzPzAH/Fq+/YICO1PiRnf08U+Z
 AeX2UMYbW5+9jrySHTUUP5AT8qTowAVOErj9A9wkuKwAuGOjSbKgMbsMl9GLfdnT
 dxFRyRDtMt0GYYnmFvPMKo6Xxd019KnRDZymN8YpjB2tMRqCg+gKVEq3VeFrGoGV
 gwWCj1eCJKC4iO7j4ahokFTBtlaymbsB53sITJIQQux/ztJCJ3JfSGxZFkqKCs2x
 qNZeAXtdeP34iJqgiSKxk1ogPIKNIcumEY9ZJRpqFwg5cGkMPMekojdVAZR1+drU
 bB+A7JK9efMnYAXp+nz0WwVQgIWcONv7ZcXahYPTXYIK5Fh5hhAxblcPFEgHWR4p
 xazAj0a4=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
 by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L3nk9nLxfS_P; Fri, 15 Feb 2019 20:59:01 +0100 (CET)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
 by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id 289F414FF;
 Fri, 15 Feb 2019 20:59:01 +0100 (CET)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
 by int-mx002.mykolab.com (Postfix) with ESMTPS id E223A25EA;
 Fri, 15 Feb 2019 20:59:00 +0100 (CET)
To: Markus Elfring <Markus.Elfring@web.de>
References: <fb42aa05-f4d0-53cb-7eda-4f0a5db6cd3c@mykolab.com>
 <5c9a7783-6345-3acc-0ffd-b5b5bc3c8fbc@web.de>
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
Message-ID: <d6992b0c-a449-dc77-affc-442bd0727927@mykolab.com>
Date: Fri, 15 Feb 2019 20:58:49 +0100
MIME-Version: 1.0
In-Reply-To: <5c9a7783-6345-3acc-0ffd-b5b5bc3c8fbc@web.de>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 15 Feb 2019 20:59:06 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 15 Feb 2019 20:59:02 +0100 (CET)
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

T24gMi8xNS8xOSA3OjMwIEFNLCBNYXJrdXMgRWxmcmluZyB3cm90ZToKPj4gSSBoYXZlIHRoaXMg
dHJpdmlhbCBzY3JpcHQgdG8gcmVtb3ZlIHVzZWxlc3MgY2FzdHMgdG8gc2VsZjoKPj4gQCBkaXNh
YmxlIGRyb3BfY2FzdCBACj4+IHR5cGUgVDsKPj4gVCBFOwo+PiBAQAo+PiAtIChUKQo+PiAgICAg
IEUKPj4KPj4gSXQgd29ya3MgYnV0IEknbSBoaXR0aW5nIGZhbHNlIHBvc2l0aXZlcyB3aGVuIHRo
ZSBjb2RlIGNhc3RzIGF3YXkKPj4gcXVhbGlmaWVycyBmb3IgZmllbGQgdHlwZXMuCj4gCj4gQ2Fu
IHRoaXMgcmVzdWx0IGJlIGV4cGVjdGVkIHdoZW4geW91ciBzb3VyY2UgY29kZSB0cmFuc2Zvcm1h
dGlvbgo+IGFwcHJvYWNoIGlzIGp1c3QgdmVyeSBnZW5lcmljPwpJIGtub3cgb2Ygbm8gY2FzZSB3
aGVyZSByZW1vdmluZyB0aGUgc2VsZiBjYXN0IGluCiAgICAodHlwZW9mKGV4cHIpKWV4cHIKd291
bGRuJ3QgYmUgYSB0cnVlIG5vLW9wLgoKCj4+IEFwcGx5aW5nIHRoZSBnZW5lcmF0ZWQgZGlmZiB3
aWxsIGxlYWQgdG8gYSBnY2Mgd2FybmluZzoKPj4gJCBnY2MgLWMgIHF1YWxpZmllci5jCj4+IHF1
YWxpZmllci5jOiBJbiBmdW5jdGlvbiDigJhiYXrigJk6Cj4+IHF1YWxpZmllci5jOjEyOjEyOiB3
YXJuaW5nOiByZXR1cm4gZGlzY2FyZHMg4oCYY29uc3TigJkgcXVhbGlmaWVyIGZyb20KPj4gcG9p
bnRlciB0YXJnZXQgdHlwZSBbLVdkaXNjYXJkZWQtcXVhbGlmaWVyc10KPj4gICAgICByZXR1cm4g
JmItPmk7Cj4+ICAgICAgICAgICAgIF5+fn5+Cj4gCj4gCj4gV291bGQgeW91IGxpa2UgdG8gYWRk
IGFueSBTbVBMIGZpbHRlciBzcGVjaWZpY2F0aW9ucyBmb3Igc3VjaCBxdWFsaWZpZXJzPwpOby4K
Cj4+IEkgZXZlbiB0cmllZCBwcmVwZW5kaW5nIGFuIGFsdGVybmF0aW9uIHdpdGggImNvbnN0IFQg
Z29vZDsiIGJ1dCB0aGUgY2FzdAo+PiBzdGlsbCBnZXRzIHJlbW92ZWQuCj4gCj4gKiBIb3cgZG8g
eW91IHRoaW5rIGFib3V0IHRvIGNoZWNrIHRoZSBmdW5jdGlvbiBwYXJhbWV0ZXIgcHJvcGVydGll
cwo+ICAgaW4gbW9yZSBkZXRhaWw/CkJhZGx5LgoKPiAqIFVuZGVyIHdoaWNoIGNpcmN1bXN0YW5j
ZXMgd291bGQgeW91IHRyeSB0byBjYXN0IGNvbnN0bmVzcyBhd2F5PwpJJ20gbm90IHRyeWluZywg
dGhlIGNvZGUgZG9lcyB0aGF0IGFscmVhZHkuCgo+ICogV291bGQgeW91IGxpa2UgdG8gZGlzdGlu
Z3Vpc2ggdGhlIGludm9sdmVkIGRhdGEgdHlwZXMgYW55IG1vcmU/Ck5vLgoKVGhlIGdlbmVyaWMg
dHJhbnNmb3JtYXRpb24gaXMgc2ltcGxlIGJ1dCBwZXJmZWN0IGF0IHRoZSBzYW1lIHRpbWUgYW5k
CnNob3djYXNlcyBjb2NjaW5lbGxlcyBleHByZXNzaXZlbmVzcyBhbmQgYmVhdXR5LgoKCmJ5ZQoJ
bWljaGFlbAoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVt
ZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
