Return-Path: <SRS0=jkZ/=X4=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2200C10F14
	for <cocci@archiver.kernel.org>; Thu,  3 Oct 2019 20:09:51 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5643E2086A
	for <cocci@archiver.kernel.org>; Thu,  3 Oct 2019 20:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=mykolab.com header.i=@mykolab.com header.b="vrDtRL/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5643E2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mykolab.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x93K9ci2015314;
	Thu, 3 Oct 2019 22:09:38 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5654E77B4;
	Thu,  3 Oct 2019 22:09:38 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id F007D77A9
 for <cocci@systeme.lip6.fr>; Thu,  3 Oct 2019 22:09:35 +0200 (CEST)
Received: from mx.kolabnow.com (mx.kolabnow.com [95.128.36.42])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x93K9YYH025783
 for <cocci@systeme.lip6.fr>; Thu, 3 Oct 2019 22:09:34 +0200 (CEST)
Received: from localhost (unknown [127.0.0.1])
 by ext-mx-out003.mykolab.com (Postfix) with ESMTP id 09179404E0;
 Thu,  3 Oct 2019 22:09:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mykolab.com; h=
 content-transfer-encoding:content-language:content-type
 :content-type:in-reply-to:mime-version:date:date:message-id:from
 :from:references:subject:subject:received:received:received; s=
 dkim20160331; t=1570133373; x=1571947774; bh=59iXH+5lkJLqDYeUnx7
 xNAPsaAZCpAaTXE0kgb5Mk5M=; b=vrDtRL/yS8A69ZQLaXX4BVMxcPzgq0sYm/n
 KzFdg5LXZiPs8Ge3IX2U4lN0dOlf4AVhL52AYXM4GUlNSFEuyhy590tHPmqiGBdt
 9JxCE6pdrbOxyJ4wHBgG98mc/d7umR57uqbFa7Y6cZQg4VFmbS5DOUlWSsQSmen6
 Nac9kQfv50C2GEvvxNC+ZyJqDH2kblSEiGWJlaodOEpBSxEURkupKyHaFZpCU6K8
 Gg1WDozuDno4Wkd9eW4V2mKqbUaighe3wMuK5oBHS7mA5Hrh6JQlyHSL2L8GqRK6
 ZeyL/hrwd3oD9r5wn45UV1KMwmIOOmiwvDehBSPCZ3TdKr+rW+ZYsH4wePLM0r39
 +S9tuKiN4vOLteTS0u5GGEP6PbDYvnQugw53NZZtjkaaGn5vWRtyh9zKbB1ohw7i
 /im4ySANceXZlkJKSCKpGqx1kE69ZPDFPOksnYI7XsEPfXtdzc+AmUWapb2Jt22J
 JNPjgenCgiP0cckpNiji3uzSrFeRaeOuk6Kx4duOB9K+WUmFPPwHNRIWkbRInTtu
 P1FDWm0Oh0cf2GwYpGrhsnNVaENZIR9MToj84AZIBnARdcNaORiwCERh+HRZddUF
 sumQCL/DN/KYapm0R6qdiv5tfNcn6j44WCIs4K3/XnXQ2p7XnWU7TIP32S/Gtn6x
 3sLS4g7Y=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
 by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5llM8XWDJ0KK; Thu,  3 Oct 2019 22:09:33 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
 by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 9BFE0403BB;
 Thu,  3 Oct 2019 22:09:33 +0200 (CEST)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
 by int-mx003.mykolab.com (Postfix) with ESMTPS id 4FAE32F15;
 Thu,  3 Oct 2019 22:09:33 +0200 (CEST)
To: Julia Lawall <julia.lawall@lip6.fr>
References: <c0801ee0-c227-5d9d-50ff-3ad872621808@mykolab.com>
 <alpine.DEB.2.21.1910030745320.2638@hadrien>
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
Message-ID: <24b4e9ee-f2c6-e46c-ef27-f911bdca53f8@mykolab.com>
Date: Thu, 3 Oct 2019 22:09:24 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910030745320.2638@hadrien>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 03 Oct 2019 22:09:38 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 03 Oct 2019 22:09:34 +0200 (CEST)
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

On 10/3/19 7:45 AM, Julia Lawall wrote:
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
> What is the type of these things?
The test patch has the types in it, but here they are again:
u8"" ==> char[]
u"" ==> char16_t[]
U"" ==> char32_t[]
L"" ==> wchar_t[] (which depends on the compilation flags, 32bit
normally but 16bit with mingw and Wine)


bye
	michael


>>
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
