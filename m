Return-Path: <SRS0=hTpQ=YH=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48973C4CECE
	for <cocci@archiver.kernel.org>; Mon, 14 Oct 2019 11:01:02 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 912972064A
	for <cocci@archiver.kernel.org>; Mon, 14 Oct 2019 11:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="NlITKxc5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 912972064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9EB0kYu003060;
	Mon, 14 Oct 2019 13:00:46 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3A44777B2;
	Mon, 14 Oct 2019 13:00:46 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 91A527792
 for <cocci@systeme.lip6.fr>; Mon, 14 Oct 2019 13:00:44 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9EB0iC4018444;
 Mon, 14 Oct 2019 13:00:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1571050819;
 bh=xrGXtPuKB7BZoJU7yIAnXezCInYi4asmh4v6z8sWQCE=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=NlITKxc5+CyaY4c/sxstI2L0wFXWpEBWN9N4jrt1RNs7xbA1kqgTP5GRKVsk6rUaQ
 Aao2kNkiXM1usVDg74PZSvalPKxGKwjbMo7XMqP82dcbeT3dZ3OkJ4bhurdZH2khhq
 xuFueti4bI5nwMy1jkjvr88n99FG8u5siBc968zo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.26.106]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MBCMP-1iANBG1Ym5-00AEhj; Mon, 14
 Oct 2019 13:00:19 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <alpine.DEB.2.21.1910112200230.3284@hadrien>
 <11a68d96-ace6-889b-596b-e34590b7b965@web.de>
 <alpine.DEB.2.21.1910131806400.2565@hadrien>
 <21abdc24-95d3-be59-0a93-4b60e790a239@web.de>
 <alpine.DEB.2.21.1910131836530.2565@hadrien>
 <e6b2ca0d-1477-2528-afc1-34272e48b89a@web.de>
 <alpine.DEB.2.21.1910141223120.2330@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <33ad2958-c9b6-0705-7936-13b18a2dd166@web.de>
Date: Mon, 14 Oct 2019 13:00:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910141223120.2330@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:UqycyDYx0vhSx5cpbiMNJH3cf/bh7kToJ7i8TG10uYi54SCgf47
 oCZtDYS1ut0hxbdhyR+ms9E2hcGWSR+Jk5iN5N8B7XWZBxORf4r6pk6ZXaHa8g9HYxH+mgg
 2Md+mB0vB6cOP0cESTs/1pNtvBv/cFyzH1aY4F4k2jcR1okhwwLWg7+xMhflrz2KXMgz3Ap
 BOEOgBhY4mYX6EOGW6cZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PHehaGqTMD0=:1CbGTMM3nn2VY1TG2NDkoW
 pZYX+yUZXcuN9UOm5O3Ui72gDWd1wiikhG6rL6JEioJRbVXQxZG2Nn6zuh7E9m4J5OCdLkPV0
 1SwHP5pmxGMj3ZmGt8LWXvdlLUOtaJ6IAqOeXd7+0dxKCM+uMqvBI0xZUtVyqae1oXcfcCWZ4
 ElbRv8UI73Ytk9jimyGWFer25ehUe6hRMOrLMtCvFKeU3K0ZIkMxuOAkFWE/nWEDjIRfq9qDA
 Qh11GVCugDTN9X36+JCDEE3bRSpbCPiFIL5X4UwURnhUUiAXTGnwC7RUlT/TmK5n5kY5VBSzL
 FjrjseBWCNERERvTCOeVaV3zBUR8utF46PKfrc4h+LKjQ82kfy7cg2OOkpQDIbJMbHTanm4BW
 dfVfDimg1sFtBiHm+WJELIR30D56IUnAWhDGABCkoxhvV11xR/1pPq49yg6Ha3MFzLGu2c+SG
 RjwzxUxNJh7rPIzQBcN1Mdfwut2Wof34GLnPVRvvNFwErxW+P0Ar3JVd3bHP2DryWrYVT9EW1
 kUwJIBHpktHpBh8EYpuNrX1fg/XwD3zigPbPNb5VkZ9+GiGthdgKf46EDyXBjMImHbg+tgBKJ
 Pd1f/Rs12gL/ICQDCmbdqvW8NIN3IRXVx8sY4ErMfsEjqKXLgpi7oE/ilRCodxiOAmksLufFw
 O6rDWYxnyGYbREpJtSeHZQPxZqN9GC0a+SrZXpP6UlalcaOhzPnj0SkM4kC3zkejjT+jWx0X4
 yUZU58kcJis0thRjrT0ghN4cQUReQaLL8/I3YToHJCve+wmaz3Gvhrf0LezuXexrQI5RnMVOt
 E4nJcNJHv7n9qJU9TdEqfdZxDFL51HZQrovBq8wMVaVAJngtuDKFqz9ozbSXHRr1Zephimp7M
 6j/AnsiHL8Z/nfDQMsCCoqhFwBo2yLvSjETYWPMKgSqB+bxzyai/P0PVr6zbu+l6DWfzslc19
 0bnDzEc0d6T9ZAg4k5MgnvryiJdBNy0r2bPnTVaN0aiFJ2pD+CGq7uFvSUJXmUHdk7CM8e+yu
 IAnzA0UGAtwi0pUFULIfbD2AUpBtCRio3n811RHVr0nSppR+uH2iOuQvboPRFXxn5M8niGCoj
 /6hUTwvqhE+xIo6qSGRmPPLFu6CVmCuUWeF344KY83d9+Ua3kTl56BjM97oVQnkCF8bIgZk5x
 JJKZsF3q59Z0eI7IZ0XhvgJWOYABZz2PNw9jBqzOj1d5wdA5guGFGJQUmRNp9m0tJuc9bJ8TJ
 k1hYDWY1xukd3GMFGh3ZLSWosL4IsVpJ+5Zw0QWg4x0cf65mJ573dKb4Y/gk=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 14 Oct 2019 13:00:46 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 14 Oct 2019 13:00:44 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Adjusting macros with SmPL?
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

>> I imagine that context-dependent data processing will be needed here
>> to distinguish if preprocessor code should be adjusted (or not).
>> How much will this technical aspect matter?
>
> Macros are supposed to be written on one line.

I suggest to reconsider also this view.
Would you like to take line continuations (or the escaping of line breaks)
into account?


> Anyway, to my understanding the goal was not to modify the #define part,
> but rather only the code part.

The shown transformation approach can probably be interpreted in two ways.

1. A source code modification should be performed behind a macro
   which can be empty.

2. Something should be generally adjusted. It would not matter then
   if the change is relevant (only) for preprocessor code (or not).


Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
