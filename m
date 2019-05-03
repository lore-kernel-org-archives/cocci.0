Return-Path: <SRS0=EwIO=TD=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A59C43219
	for <cocci@archiver.kernel.org>; Fri,  3 May 2019 08:03:30 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F5C820675
	for <cocci@archiver.kernel.org>; Fri,  3 May 2019 08:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=mykolab.com header.i=@mykolab.com header.b="1UxJ48lv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F5C820675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mykolab.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x43839Va029828
          ; Fri, 3 May 2019 10:03:09 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8B1E07737;
	Fri,  3 May 2019 10:03:09 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 199097734
 for <cocci@systeme.lip6.fr>; Fri,  3 May 2019 10:03:08 +0200 (CEST)
Received: from mx.kolabnow.com (mx.kolabnow.com [95.128.36.42])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x43837TX021991
 for <cocci@systeme.lip6.fr>; Fri, 3 May 2019 10:03:07 +0200 (CEST)
X-pt: isis.lip6.fr
Received: from localhost (unknown [127.0.0.1])
 by ext-mx-out003.mykolab.com (Postfix) with ESMTP id BE53C40413;
 Fri,  3 May 2019 10:03:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mykolab.com; h=
 message-id:references:in-reply-to:subject:subject:from:from:date
 :date:content-transfer-encoding:content-type:content-type
 :mime-version:received:received:received; s=dkim20160331; t=
 1556870586; x=1558684987; bh=OzuU6VA7HRA1nzGenfo09Ok4tdeSQKuSiT5
 Eka1ufGk=; b=1UxJ48lvBd/U51BgyrXoXK05RGl8olsLHmWGBCmohtCBC6OXl2a
 2bNl125Efnuxr6SZfECpW5Rw732PbmWQWHDiGYMbhaKeBgp7BFx3fthyjGVoInb4
 ooFA35kAg4yHTGwWOWNlnOtWWoNU6gl9sLkaoWP/8X6R2nIaHI1E33RZvglIMWJt
 kE0OtQeGAbBGWhyvY0IcZL2FyQF4J6RyWPog5Ws0UQ1yt7BwAw+0qoqGzKArGgPU
 h304AssCEcFn5mf9B3YTNYlmtchzkJ40MC5rmzT4Fg/00feeNqCokMcIOOizVmqE
 jugwBlrczOzuJEdPFcUScR0rxk+9ft2tChwsFpUJWLQM7+NKoGbB9LVQYw9Ny0U5
 Y9vkZgY8cm8JpSL6D1bEklQ9nvzM0BO1GWPWpN3V0QqgyiNuuSh0v4J8ZW6ZII0w
 r+9Kpfk4RhwRv8P2OIQg9d/NjxPEDaZ5vTeLB0n93mW4Yr8FhYyX+9YswD6+M3wa
 8bmTfIZTN84zxrQignhPWrliRsxo+Q0LriUgpJHVzdrtMvGMRsZD3cbi/8xtTTtk
 POTx+ilyLq8p+5Dlc5pDEcJBaVsWPo6EJWM96md316VwD7iuyYYwOGbwxzyHkBQ1
 gYf2nbAY0GfPXBzTdNeBzbOTQpHraeDf8FU1K/F12J/8eDRSwzBK+odk=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
 by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JXXDYKBf9U2f; Fri,  3 May 2019 10:03:06 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
 by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id E0881403B4;
 Fri,  3 May 2019 10:03:05 +0200 (CEST)
Received: from int-subm003.mykolab.com (unknown [10.9.37.3])
 by int-mx001.mykolab.com (Postfix) with ESMTPS id 95F5029F;
 Fri,  3 May 2019 10:03:05 +0200 (CEST)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="=_0afc65e056d079b13e7d2eb9ab4668fc"
Content-Transfer-Encoding: 7bit
Date: Fri, 03 May 2019 10:03:04 +0200
From: Michael Stefaniuc <mstefani@mykolab.com>
To: Julia Lawall <julia.lawall@lip6.fr>
In-Reply-To: <alpine.DEB.2.20.1905030916530.3572@hadrien>
References: <1f616769-3fb1-6d41-93eb-82aecc5cb766@mykolab.com>
 <alpine.DEB.2.20.1905030916530.3572@hadrien>
Message-ID: <04697af8fb0c96a2e14d15fc11d708a7@mykolab.com>
X-Sender: mstefani@mykolab.com
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 03 May 2019 10:03:10 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 03 May 2019 10:03:07 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Matching more than one declaration?
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
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

--=_0afc65e056d079b13e7d2eb9ab4668fc
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8;
 format=flowed

On 2019-05-03 09:17, Julia Lawall wrote:
> On Thu, 2 May 2019, Michael Stefaniuc wrote:
> 
>> Hello,
>> 
>> it seems that more than one declaration cannot be matched in one rule:
>> 
>> @@
>> identifier i, f;
>> @@
>> - int i;
>> - int f;
>> 
>> That won't match
>> 
>> void foo(void)
>> {
>>     int i;
>>     float f;
> 
> The semantic patch has int int and the code has int float.  If the code
> has int int, it matches fine.
Duh... I messed it up while simplifying my test case :/

It does work but only in function scope and not in global scope.
I've attached the fixed test case.

thanks
bye
       michael

--=_0afc65e056d079b13e7d2eb9ab4668fc
Content-Transfer-Encoding: base64
Content-Type: text/x-c;
 name=declare.c
Content-Disposition: attachment;
 filename=declare.c;
 size=60

aW50IGk7CmZsb2F0IGY7Cgp2b2lkIGZvbyh2b2lkKQp7CiAgICBpbnQgaTsKICAgIGZsb2F0IGY7
Cn0K
--=_0afc65e056d079b13e7d2eb9ab4668fc
Content-Transfer-Encoding: base64
Content-Type: text/plain;
 name=declare.cocci
Content-Disposition: attachment;
 filename=declare.cocci;
 size=43

QEAKaWRlbnRpZmllciBpLCBmOwpAQAotIGludCBpOwotIGZsb2F0IGY7Cg==
--=_0afc65e056d079b13e7d2eb9ab4668fc
Content-Transfer-Encoding: base64
Content-Type: text/x-diff;
 name=declare.diff
Content-Disposition: attachment;
 filename=declare.diff;
 size=133

LS0tIGRlY2xhcmUuYworKysgL3RtcC9jb2NjaS1vdXRwdXQtNTI3OS1jMmYxM2QtZGVjbGFyZS5j
CkBAIC0zLDYgKzMsNCBAQCBmbG9hdCBmOwogCiB2b2lkIGZvbyh2b2lkKQogewotICAgIGludCBp
OwotICAgIGZsb2F0IGY7CiB9Cg==
--=_0afc65e056d079b13e7d2eb9ab4668fc
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--=_0afc65e056d079b13e7d2eb9ab4668fc--
