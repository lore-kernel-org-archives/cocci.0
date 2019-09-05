Return-Path: <SRS0=VydO=XA=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89953C43331
	for <cocci@archiver.kernel.org>; Thu,  5 Sep 2019 14:16:22 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1469F21907
	for <cocci@archiver.kernel.org>; Thu,  5 Sep 2019 14:09:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1469F21907
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x85E9SSW023409;
	Thu, 5 Sep 2019 16:09:28 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7B52F7797;
	Thu,  5 Sep 2019 16:09:28 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id DE20B7796
 for <cocci@systeme.lip6.fr>; Thu,  5 Sep 2019 16:08:47 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x85E8kX2001506
 for <cocci@systeme.lip6.fr>; Thu, 5 Sep 2019 16:08:47 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2413728;
 Thu,  5 Sep 2019 07:08:46 -0700 (PDT)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1F003F67D;
 Thu,  5 Sep 2019 07:08:45 -0700 (PDT)
To: Julia Lawall <julia.lawall@lip6.fr>
References: <d9df847c-199d-e78d-aff2-6f14629d63b5@arm.com>
 <alpine.DEB.2.21.1909051358550.2651@hadrien>
From: Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <52304e37-9ad2-487b-954b-0dfa721dfa76@arm.com>
Date: Thu, 5 Sep 2019 15:08:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1909051358550.2651@hadrien>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 05 Sep 2019 16:09:29 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 05 Sep 2019 16:08:47 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Thu, 05 Sep 2019 16:09:26 +0200
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Matching variable declarations
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

On 05/09/2019 13:03, Julia Lawall wrote:
>> I tried to write it as
>> ---
>> - T
>> + int
>> var
>> ? = E
>> ;
>> ---
>> but that doesn't seem to be a valid syntax.
> 
> No.  ? is restricted to complete statements.
> 

Makes sense now that I'm looking at other snippets, thanks.

>>
>>
>> Now, I'd like to match declarations of several variables in a single
>> statement as well.
>>
>> Say I want to get something like
>>
>> - long a, b = 2, c, d = 42, e;
>> + long a, b = 2, c, e;
>> + int d = 42;
>>
>>  (match on longs initialized to 42)
>>
>> My current attempt is
>> ---
>> @@
>> identifier var;
>> type T = long;
>> expression L, R;
>> @@
>>
>> T L,
>> - var = 42
>> R;
>> + int var;
>> ---
>> But that isn't valid either. How should I go about writing this sort of
>> rule?
> 
> Declaartions with multiple variables are tricky.  By the following may
> work:
> 
> - long
> + int
>   x;
> 
> Since you are leaving the variables alone in this case, I think this will
> match thing that declare multiple variables as well.
> 

I can't get it to match on something like

	long a, b = 42;

Perhaps a roundabout way of getting there - would it be possible to
specify a rule where an identifier has to be a variable? That way I could
at least print their use and cross-check the output diff (I don't expect
multiple variables declaration to be common for this, but would like to
have some way of raising a flag when it does occur).

>>
>> If you're curious, there's more context about what I'm trying to achieve
>> at:
>>
>> https://lore.kernel.org/lkml/20190902210558.GA23013@avx2/
> 
> I guess your next question will be about converting %ld to %d, etc.
> 
> It may be helpful to look at coccinelle/demos/format.cocci
> 

Thanks for the pointers & swift reply! Much appreciated.
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
