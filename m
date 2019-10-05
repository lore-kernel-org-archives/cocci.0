Return-Path: <SRS0=uzOD=X6=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2BDC4740A
	for <cocci@archiver.kernel.org>; Sat,  5 Oct 2019 20:33:38 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 133C4222C5
	for <cocci@archiver.kernel.org>; Sat,  5 Oct 2019 20:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=mykolab.com header.i=@mykolab.com header.b="SSDPVtyc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 133C4222C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mykolab.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x95KXHpO010482;
	Sat, 5 Oct 2019 22:33:17 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 948A277AA;
	Sat,  5 Oct 2019 22:33:17 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D634D77A9
 for <cocci@systeme.lip6.fr>; Sat,  5 Oct 2019 22:33:15 +0200 (CEST)
Received: from mx.kolabnow.com (mx.kolabnow.com [95.128.36.42])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x95KXFTD000053
 for <cocci@systeme.lip6.fr>; Sat, 5 Oct 2019 22:33:15 +0200 (CEST)
Received: from localhost (unknown [127.0.0.1])
 by ext-mx-out003.mykolab.com (Postfix) with ESMTP id 09B5841143;
 Sat,  5 Oct 2019 22:33:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mykolab.com; h=
 content-transfer-encoding:content-language:content-type
 :content-type:in-reply-to:mime-version:date:date:message-id:from
 :from:references:subject:subject:received:received:received; s=
 dkim20160331; t=1570307594; x=1572121995; bh=75wBdYTpBoK0SmnnJIN
 7vz+8ZK/ag0KeNa/ZQE/akTY=; b=SSDPVtycpNNBgGFHXno7ehvg0aBEGoVXwcu
 perZUvWyuH5AswIoU3t6wIB3sygEOrLc9/ZnkpxE8/ETIGnEe+GMi8MdgjSEiO3T
 ivtBj+kBGjdK2r+6LIlFQQhcuxqVf2WazN1kSHjzD+5qwQZ/wOO4HWNhpnIica56
 uCIKvNOg//02p47o3kzPLm+yiQvZZftxiAOPpOz/m+U2fuZX/zbOmtJw9O0WfK0o
 x3yIRretuQQvsTakjh+BTFf59Dn81zyjxCOJtfS+gmyo3EeTZSv8wUPsbS1DXIEa
 hxpqck3kUPjdE3qfQpjaYwEAusn3f/aseWr1ZH0k9S69Be4L0C58u/WIkU+Zxn+R
 FekE6ONyfrP8BLhXiFunGd8ocunPoWr+BAgXsIieDu1mfO01T9RbCMMBeyKhjkL1
 9DUD3rqv08+igUnxeeQy7TSt5BzX7F4BVZ4Fuxksg4VsRTPeCfURwv8G0vNh9WTA
 6EGvCRJufX/Qo8I9kGyP50U0T74W3GIZLcNWSmNGu4kBM/iewn2kQuSeCQgCcOEU
 MY0lsEDouRLcCMcB4Qe994Dde1ee7X5AUkNnxu/GKLwW3c6SLZtKuxtifi7S/+WM
 q56ELj5bAoAClOeKsvnfOtS46iIHL4lSNgz1kjX1TtOTBrygbUZTQbkIFRCzdqyb
 KqhHL3fk=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
 by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rnyxih8Ko29K; Sat,  5 Oct 2019 22:33:14 +0200 (CEST)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
 by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 9259940BAD;
 Sat,  5 Oct 2019 22:33:14 +0200 (CEST)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
 by int-mx002.mykolab.com (Postfix) with ESMTPS id 43614958;
 Sat,  5 Oct 2019 22:33:14 +0200 (CEST)
To: Julia Lawall <julia.lawall@lip6.fr>
References: <c0801ee0-c227-5d9d-50ff-3ad872621808@mykolab.com>
 <alpine.DEB.2.21.1910050006580.2561@hadrien>
From: Michael Stefaniuc <mstefani@mykolab.com>
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
 a1TPymfo6IGo9y4Anj05IAwUKKSPJez3LojfovAYMEry
Message-ID: <16fc84e6-4b43-f27c-323a-8cfd99318e27@mykolab.com>
Date: Sat, 5 Oct 2019 22:33:03 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910050006580.2561@hadrien>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 05 Oct 2019 22:33:18 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 05 Oct 2019 22:33:15 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Missing support in SmPL for wide char character
 constants and string literals
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

On 10/5/19 12:07 AM, Julia Lawall wrote:
> 
> 
> On Wed, 2 Oct 2019, Michael Stefaniuc wrote:
> 
>> Hello!
>>
>> SmPL doesn't support the character constants of the form:
>> u'c', U'c', L'c'
>>
>> nor the string literals of the form:
>> u8"", u"", U"", L""
> 
> The constants are now working.  Nothing has been done to add the
> corresponding types.
Many thanks Julia, tested and it works nicely.

I don't need the types, I've added them only for completeness.
In Wine we just need L"" and WCHAR and I typedef the later.


bye
	michael


>> A test case is attached as a patch for the coccinelle tests.
>>
>> minus: parse error:
>>   File "tests/wchar.cocci", line 8, column 22, charpos = 106
>>   around = ''',
>>   whole content = - char16_t zero = u'\0';
>>
>>
>> thanks
>> bye
>> 	michael
>>

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
