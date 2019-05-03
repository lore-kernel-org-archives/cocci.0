Return-Path: <SRS0=EwIO=TD=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAC6C43219
	for <cocci@archiver.kernel.org>; Fri,  3 May 2019 20:44:49 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0B8B206BB
	for <cocci@archiver.kernel.org>; Fri,  3 May 2019 20:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=mykolab.com header.i=@mykolab.com header.b="UfFdM2pk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0B8B206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mykolab.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x43KiQfS019863
          ; Fri, 3 May 2019 22:44:27 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D61237737;
	Fri,  3 May 2019 22:44:26 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id ED6FE7734
 for <cocci@systeme.lip6.fr>; Fri,  3 May 2019 22:44:24 +0200 (CEST)
Received: from mx.kolabnow.com (mx.kolabnow.com [95.128.36.42])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x43KiNjs002386
 for <cocci@systeme.lip6.fr>; Fri, 3 May 2019 22:44:23 +0200 (CEST)
X-pt: isis.lip6.fr
Received: from localhost (unknown [127.0.0.1])
 by ext-mx-out001.mykolab.com (Postfix) with ESMTP id 2C32F59B;
 Fri,  3 May 2019 22:44:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mykolab.com; h=
 content-transfer-encoding:content-language:content-type
 :content-type:in-reply-to:mime-version:date:date:message-id:from
 :from:references:subject:subject:received:received:received; s=
 dkim20160331; t=1556916262; x=1558730663; bh=67NoBGID3uF7bfTC6Y+
 XWrT19p4vZQtjHK2hvncHj2k=; b=UfFdM2pkKzo19Rl24dYx965pjZ1MsMVXD14
 gseQepLpTD3VMf0CbYWQ2L6wMkYoYcdcksp4/NKzPdp1U9xQQY3ilha1Q6DCKEuE
 nXdlwPfvzvEplXm4jg2w31SiFr5h1fKx4SbfPqO/S9pqbg6thulfbiyIE8PY9dK8
 Yjd6HD6hq5x7Hq2Q5gZddXh+sxhGK5rY6eiiQvHutdc1s7UfjF5wPkM+lGQlSC4+
 ILkfUr2q/5y5Jr9G5DMUMh9+8F5v7imKdn2QIuBkmHnpj7VmZoRcqZh02ZS5ll9b
 aLAkngLUfhILwxQ2nSY5MfMqLMgNm8O2uwGKterbOJnGDWzn2ImfElzjhGGx6bCm
 WbZZiirDoewH431AL6XOgar6FoRENX8JcDfMmTkQoLIGZFFOPWPQQfnr79m2JveT
 TaLiQwlQnjvMY4JFIZHCI9xbCkGentj8th9Tf8FMjRv192xv5aQJ/hPAGR9iSHYK
 i9AnW29S3uPH9reGNV6qfoWXTQkInhgI0NE1dOWNWUu8WOI7L6weoZKUr8u8jewM
 IsIT3thi/648g/gevvV9EGRo56qpJXn4xF5F/YV70waldkdSZ+o+QjgjURmmVBDt
 3MP8rcFFwu5XgQCTUdEh/areDfVKvECQ+1qtaC/8jesA6AsH9EEFoF05W3g1kDhN
 4aHmPLl4=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
 by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vc8u0noZDgFV; Fri,  3 May 2019 22:44:22 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
 by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id 00F21414;
 Fri,  3 May 2019 22:44:21 +0200 (CEST)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
 by int-mx003.mykolab.com (Postfix) with ESMTPS id AAC1F3C0C;
 Fri,  3 May 2019 22:44:21 +0200 (CEST)
To: Julia Lawall <julia.lawall@lip6.fr>
References: <1f616769-3fb1-6d41-93eb-82aecc5cb766@mykolab.com>
 <alpine.DEB.2.20.1905030916530.3572@hadrien>
 <04697af8fb0c96a2e14d15fc11d708a7@mykolab.com>
 <alpine.DEB.2.21.1905032238080.3158@hadrien>
From: Michael Stefaniuc <mstefani@mykolab.com>
Openpgp: preference=signencrypt
Message-ID: <354d44e4-7d8d-06ce-2e3b-6ac545a09b43@mykolab.com>
Date: Fri, 3 May 2019 22:44:14 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1905032238080.3158@hadrien>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 03 May 2019 22:44:27 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 03 May 2019 22:44:23 +0200 (CEST)
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

On 5/3/19 10:39 PM, Julia Lawall wrote:
> 
> 
> On Fri, 3 May 2019, Michael Stefaniuc wrote:
> 
>> On 2019-05-03 09:17, Julia Lawall wrote:
>>> On Thu, 2 May 2019, Michael Stefaniuc wrote:
>>>
>>>> Hello,
>>>>
>>>> it seems that more than one declaration cannot be matched in one rule:
>>>>
>>>> @@
>>>> identifier i, f;
>>>> @@
>>>> - int i;
>>>> - int f;
>>>>
>>>> That won't match
>>>>
>>>> void foo(void)
>>>> {
>>>>     int i;
>>>>     float f;
>>>
>>> The semantic patch has int int and the code has int float.  If the code
>>> has int int, it matches fine.
>> Duh... I messed it up while simplifying my test case :/
>>
>> It does work but only in function scope and not in global scope.
>> I've attached the fixed test case.
> 
> No, it won't work in global scope.  You can only match one top-level thing
> at a time, and each declaration is a top-level thing.  Youcan make a
> series of rules that depend on the previous ones, and only make the change
> if all are matched.
Ok, thanks. That's what I did as a workaround.

bye
	michael

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
