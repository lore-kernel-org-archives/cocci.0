Return-Path: <SRS0=17+G=QX=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F09C43381
	for <cocci@archiver.kernel.org>; Sat, 16 Feb 2019 20:58:03 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7D0A21A4A
	for <cocci@archiver.kernel.org>; Sat, 16 Feb 2019 20:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=mykolab.com header.i=@mykolab.com header.b="jP4195/i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7D0A21A4A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mykolab.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1GKvh9d004415
          ; Sat, 16 Feb 2019 21:57:43 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5157F76FA;
	Sat, 16 Feb 2019 21:57:43 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0BC9176F4
 for <cocci@systeme.lip6.fr>; Sat, 16 Feb 2019 21:57:41 +0100 (CET)
Received: from mx.kolabnow.com (mx.kolabnow.com [95.128.36.42])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1GKvdoO002709
 for <cocci@systeme.lip6.fr>; Sat, 16 Feb 2019 21:57:40 +0100 (CET)
X-pt: isis.lip6.fr
Received: from localhost (unknown [127.0.0.1])
 by ext-mx-out001.mykolab.com (Postfix) with ESMTP id 60CF582A;
 Sat, 16 Feb 2019 21:57:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mykolab.com; h=
 content-transfer-encoding:content-language:content-type
 :content-type:in-reply-to:mime-version:date:date:message-id:from
 :from:references:subject:subject:received:received:received; s=
 dkim20160331; t=1550350657; x=1552165058; bh=o2FM/oosdFHgXBUtVwW
 JW51yF27oioFE4QFBxjqMF3s=; b=jP4195/i/qCGTR5O8q/CFs1hkRFyqejjMHZ
 i9Ma/JIxIEWXFEQIWQYDpzQmxWAqy1jlEfcEfrrFoiEbcEc7YYL+5KMLN8kHnm2x
 YIVRxhneTQ9roSnoVkDz9bulXaPUbgPIQtpsMY3hqRKXT1z5O1G7VV1PDopMTIpT
 V/5DD5AGfSSIFYAT2uSjmCqfy6XxJ661V6sFcR7sy9aZHLXOwnINZ9wTVseoloqQ
 IyN3oeOPU1VBjYdKuLgdJuqrZW/TR+K4NxJ23ks1KQGDWfgMze5aYeQuNABj5Z9G
 jC/feG095y6/VQEIkZ53htB9aKoKD76ZUDy+bxyqTP/8XPcErJYG6wcsWCoJTH9o
 VrKsokkvRCFDIaV/ZhVsaNRUndKnTEyem0xmYKczcYXQrFBxzBDp5/9vF+3bmwP5
 6aRKdlMYDT2vFnfvgjyGn1tTwKg5wGPtmhR8kBDWD/EpMzvAIs5viK3no5athmr4
 Tk/ZUe3S/zrvDrRbcMA4nFQlVG+AAyToEJ+9mV/zkgAFNovLOYmSD0n7GekEkTSn
 FLkkF8RitLAUXITvNS5yYp56QnYyd+UobRvkzDfS049aZn3gDv2uU1ooaHzNxgfV
 jS2RCnRCHYe0qgf1vN0r0ctAz8vrRoZZvk2ebf55uUeRngKElmdLQPPg3s4luKPP
 9wu5jyK8=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
 by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dqaPFC_Khd2W; Sat, 16 Feb 2019 21:57:37 +0100 (CET)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
 by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id 4D54D344;
 Sat, 16 Feb 2019 21:57:37 +0100 (CET)
Received: from ext-subm003.mykolab.com (unknown [10.9.6.3])
 by int-mx002.mykolab.com (Postfix) with ESMTPS id 0B1E025A0;
 Sat, 16 Feb 2019 21:57:36 +0100 (CET)
To: Markus Elfring <Markus.Elfring@web.de>
References: <fb42aa05-f4d0-53cb-7eda-4f0a5db6cd3c@mykolab.com>
 <5c9a7783-6345-3acc-0ffd-b5b5bc3c8fbc@web.de>
 <d6992b0c-a449-dc77-affc-442bd0727927@mykolab.com>
 <831a2b76-a77f-0fad-4449-e47e6acf26d9@web.de>
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
Message-ID: <49aeed10-bcbf-ff0e-e877-0f708be61bd8@mykolab.com>
Date: Sat, 16 Feb 2019 21:57:35 +0100
MIME-Version: 1.0
In-Reply-To: <831a2b76-a77f-0fad-4449-e47e6acf26d9@web.de>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 16 Feb 2019 21:57:44 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 16 Feb 2019 21:57:40 +0100 (CET)
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

T24gMi8xNi8xOSA3OjAwIEFNLCBNYXJrdXMgRWxmcmluZyB3cm90ZToKPj4gVGhlIGdlbmVyaWMg
dHJhbnNmb3JtYXRpb24gaXMgc2ltcGxlIGJ1dCBwZXJmZWN0IGF0IHRoZSBzYW1lIHRpbWUgYW5k
Cj4+IHNob3djYXNlcyBjb2NjaW5lbGxlcyBleHByZXNzaXZlbmVzcyBhbmQgYmVhdXR5Lgo+IAo+
IEFub3RoZXIg4oCcZmFsc2UgcG9zaXRpdmUgbGVmdG92ZXLigJ0gcG9pbnRlZCBmdXJ0aGVyIHNv
ZnR3YXJlIGRldmVsb3BtZW50Cj4gb3Bwb3J0dW5pdGllcyBvdXQgYWNjb3JkaW5nIHRvIHlvdXIg
c3VnZ2VzdGlvbiDigJxbUEFUQ0hdIG9sZWF1dDMyL3Rlc3RzOgo+IFByb3BhZ2F0ZSB0aGUgY29u
c3QgaW5zdGVhZCBvZiBjYXN0aW5nIGl0IGF3YXnigJ0sIGRpZG4ndCBpdD8KPiBodHRwczovL3Nv
dXJjZS53aW5laHEub3JnL3BhdGNoZXMvZGF0YS8xNTg2MzEKPz8/CgphLikgVGhhdCBwYXRjaCBp
cyBub3QgYSBjYXN0IHRvIHNlbGYgc28gbm8gImZ1cnRoZXIgc29mdHdhcmUgZGV2ZWxvcG1lbnQK
b3Bwb3J0dW5pdGllcyIgdG8gbXkgc2VsZmNhc3QuY29jY2kgc2NyaXB0LgoKYi4pIEFjdHVhbGx5
IGRvaW5nIGNvZGUgY2xlYW51cCBpcyBhIGJldHRlciB3YXkgb2YgZmluZGluZyBuZXcKIm9wcG9y
dHVuaXRpZXMiIGZvciBtb3JlIGNsZWFudXAuIFRoZSB2YWd1ZSBoaW50cyBmb3IgImZ1cnRoZXIg
c29mdHdhcmUKZGV2ZWxvcG1lbnQgb3Bwb3J0dW5pdGllcyIgYXJlIGFjdHVhbGx5IGhhcm1mdWwg
YXMgdGhleSBhZGQgbm9pc2UgYW5kCmRldHJhY3QgZnJvbSB0aGUgYnVnIHJlcG9ydC4KCmJ5ZQoJ
bWljaGFlbApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpD
b2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5s
aXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
