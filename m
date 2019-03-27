Return-Path: <SRS0=yQhI=R6=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5467C43381
	for <cocci@archiver.kernel.org>; Wed, 27 Mar 2019 10:20:27 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B4BE20700
	for <cocci@archiver.kernel.org>; Wed, 27 Mar 2019 10:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=mykolab.com header.i=@mykolab.com header.b="sB6UUWdt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B4BE20700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mykolab.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2RAKEFo014105
          ; Wed, 27 Mar 2019 11:20:14 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 64C757663;
	Wed, 27 Mar 2019 11:20:14 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id F15333B64
 for <cocci@systeme.lip6.fr>; Wed, 27 Mar 2019 11:20:12 +0100 (CET)
Received: from mx.kolabnow.com (mx.kolabnow.com [95.128.36.42])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2RAKCmH016881
 for <cocci@systeme.lip6.fr>; Wed, 27 Mar 2019 11:20:12 +0100 (CET)
X-pt: isis.lip6.fr
Received: from localhost (unknown [127.0.0.1])
 by ext-mx-out003.mykolab.com (Postfix) with ESMTP id 8F5D841112;
 Wed, 27 Mar 2019 11:20:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mykolab.com; h=
 message-id:references:in-reply-to:subject:subject:from:from:date
 :date:content-transfer-encoding:content-type:content-type
 :mime-version:received:received:received; s=dkim20160331; t=
 1553682010; x=1555496411; bh=l9gofYY11dSowKPtMHZB9dRinU1660Ywdjd
 xg/SnCFU=; b=sB6UUWdt5s/pwrQV/oH5gAJKDfqZcYy2WYDkYUuy+DSmcmGKdmg
 374rjJ9xIa/FQoJBrZvaYRIk5MVJncHp5BY9lfiTs8sPuD1AqY9HOMTu8aco6ARf
 ZE83ndZw6eygGe3e/2ThM9nRmc3UDzT/6mb+tz14Dv5DG3zfz8HtIMVFDcKf+7JT
 UZNWbhyC/JIkda7a6iGmZJJEPOijAhJSi5U43iezUrb6OFENeHcLBP1eXlZc6WsS
 83GSTAW9/K3Dn9SmbT4rslKBU8yi41cgs4RM2NLxNNYN06DcMfimQlOCRBUoFdNX
 f9osBFa590sjZ9odLQzPOBQe9NXTzlP86Zl8sd+MoYf8bv1lR0/V4wurUcZqg4za
 Eatw3UyUcKsBRbHAt/SkOP7b51dQb8LAG+PCVWosxkSCsSJCI9H0XK72Iwc38Ddr
 pDJtJqRpipWL7gQvnSuktxQ1ZejsRbf5EwADgPVV+fWihaWZqN7QqLVnQPVwV6at
 d+vduWP8SCvUFmeDe7gbguL7CA8Jgqi/nSsSOU3pZMemQ7GCSmIQRsM3Zl+/7McM
 TFCqNAFIXDMO34rYMBU4VXfK+PSVsNZ6RxNzfEo8Yit/LuZ3x0/P+SRo0g+fCPz9
 WT+O3ja1x7igIf1z9MIYrb8YLLTS7jcuAtRJmFS1AINzBCPEWdPDzJq8=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
 by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A38uwpaC2-MP; Wed, 27 Mar 2019 11:20:10 +0100 (CET)
Received: from int-mx002.mykolab.com (unknown [10.9.13.2])
 by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 97AE141111;
 Wed, 27 Mar 2019 11:20:10 +0100 (CET)
Received: from int-subm002.mykolab.com (unknown [10.9.37.2])
 by int-mx002.mykolab.com (Postfix) with ESMTPS id 848F92806;
 Wed, 27 Mar 2019 11:20:10 +0100 (CET)
MIME-Version: 1.0
Date: Wed, 27 Mar 2019 11:20:09 +0100
From: Michael Stefaniuc <mstefani@mykolab.com>
To: Julia Lawall <julia.lawall@lip6.fr>
In-Reply-To: <alpine.DEB.2.21.1903270826060.2461@hadrien>
References: <51927c57-784e-6154-7032-0a4a266ac6f0@mykolab.com>
 <alpine.DEB.2.21.1903270826060.2461@hadrien>
Message-ID: <b4e082410353f7abda6a777cde0583ad@mykolab.com>
X-Sender: mstefani@mykolab.com
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 27 Mar 2019 11:20:15 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 27 Mar 2019 11:20:12 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Capturing all array initializers?
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

On 2019-03-27 08:26, Julia Lawall wrote:
> On Wed, 27 Mar 2019, Michael Stefaniuc wrote:
> 
>> Hello,
>> 
>> I'm trying to do this transformation,
>> from:
>>     const WCHAR wstr[] = {'u','t','f','1','6','
>> ','s','t','r','i','n','g','\0'};
>> to:
>>     const WCHAR wstr[] = u"utf16 string";
>> 
>> I had hoped to be able to use an expression list for the array
>> initializer, but that produces a parse error. I know that technically 
>> an
>> array initializer is not an expression list, but it looks like one.
>> Is there another metavariable that I can use instead?
> 
> I think that there is initializer list?
Indeed there is, thanks!

But 'initializer' is totally missing from 
http://coccinelle.lip6.fr/docs/main_grammar002.html , there's where I 
have looked for it.

bye
      michael
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
