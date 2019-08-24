Return-Path: <SRS0=z30s=WU=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4821C3A59E
	for <cocci@archiver.kernel.org>; Sat, 24 Aug 2019 13:01:35 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB8372146E
	for <cocci@archiver.kernel.org>; Sat, 24 Aug 2019 13:01:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB8372146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7OD1K23014399;
	Sat, 24 Aug 2019 15:01:21 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DC443778E;
	Sat, 24 Aug 2019 15:01:20 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 216EF778B
 for <cocci@systeme.lip6.fr>; Sat, 24 Aug 2019 15:01:19 +0200 (CEST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7OD1IcD002913
 for <cocci@systeme.lip6.fr>; Sat, 24 Aug 2019 15:01:18 +0200 (CEST)
Received: by mail-wr1-f46.google.com with SMTP id t16so11037279wra.6
 for <cocci@systeme.lip6.fr>; Sat, 24 Aug 2019 06:01:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ilkTvzV5N6ZFqrI0OVSP1ZUkJsS6PfdEwQZH8pJKHts=;
 b=uA77/VQgWiAUArlffYN6i5YkjLrmTQETVlWzQfl0rEyB/igeqazearwmQ4QUIUmutF
 EGl1Qe1DoV01VLkolf1WG1AOLiO/bES0gLQmzuEeu9lN7VJQ/kT9u2vHZ/O3ixKLGuhE
 mmxHCBhz6/ObI3krX7khc9BGZ33rvBxX9Hh8N3n1S6LK1f2QZ/VJg8FjOWSwkXmKw+ZV
 q5XUam3euru8woIbvi0K+5PUJZYW/XEny7BOKYczy9GU7V/fQ9H3XUv2xjTxtf90+bfi
 NcYR/FDc3xgU9OczEhMn1ZKpOLgJ+YupI7zrFSMjNIcU/EYC0B1vg1QklmebydTiCqp4
 REZQ==
X-Gm-Message-State: APjAAAWdRv2nk+l5HzztEe1mhGecHmiQMoT//7Iuhe/3qP/cjBnb+d/q
 GDFF6k+ieNFpfLKlrDz31+6+XqQk
X-Google-Smtp-Source: APXvYqyGOarQOJmSUB4+ucXDotokCFGY8QENpbwNAfRlbqHou1q3tcfV2tJn3SCuD9nfdqAygD3xbQ==
X-Received: by 2002:a05:6000:1186:: with SMTP id
 g6mr11391269wrx.17.1566651678468; 
 Sat, 24 Aug 2019 06:01:18 -0700 (PDT)
Received: from [10.68.32.192] (broadband-188-32-48-208.ip.moscow.rt.ru.
 [188.32.48.208])
 by smtp.gmail.com with ESMTPSA id u186sm14493889wmu.26.2019.08.24.06.01.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Aug 2019 06:01:18 -0700 (PDT)
To: Julia Lawall <julia.lawall@lip6.fr>
References: <44525ca7-a97b-0858-9131-a97459bac4b5@linux.com>
 <alpine.DEB.2.21.1908241922190.2720@hadrien>
From: Denis Efremov <efremov@linux.com>
Message-ID: <b8aea4aa-e8d0-db47-f993-e5586a451577@linux.com>
Date: Sat, 24 Aug 2019 16:01:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1908241922190.2720@hadrien>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 24 Aug 2019 15:01:21 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 24 Aug 2019 15:01:18 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Rule for turning !unlikely to likely
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

On 24.08.2019 14:23, Julia Lawall wrote:
> 
> 
> On Sat, 24 Aug 2019, Denis Efremov wrote:
> 
>> Hi,
>>
>> I'm trying to write a rule for turning !unlikely to likely and vice versa.
>> However, it's hard for me to understand what is wrong with the rule and how to
>> make it work. Any suggestions? Do I need to introduce 'expression E;' instead
>> '(...)'? BTW, spatch hangs with -Dorg.
> 
> Try adding
> 
> disable unlikely
> 
> to each rule.  There is an isomorphism that makes likely and unlikely
> optional and perhaps it causes problems.

It's already added, as you could see it in the listing. :) Maybe I do it in the
wrong order?

@depends on context disable unlikely@
@depends on patch disable unlikely@
@r depends on (org || report) disable unlikely@

> 
> julia
> 
>>
>> The rule:
>>
>> virtual patch
>> virtual context
>> virtual org
>> virtual report
>>
>> //----------------------------------------------------------
>> //  For context mode
>> //----------------------------------------------------------
>>
>> @depends on context disable unlikely@
>> @@
>>
>> (
>> * !likely(...)
>> |
>> * !unlikely(...)
>> )
>>
>> //----------------------------------------------------------
>> //  For patch mode
>> //----------------------------------------------------------
>>
>> @depends on patch disable unlikely@
>> @@
>>
>> (
>> -!likely
>> +unlikely
>>  (...)
>> |
>> -!unlikely
>> +likely
>>  (...)
>> )
>>
>> //----------------------------------------------------------
>> //  For org and report mode
>> //----------------------------------------------------------
>>
>> @r depends on (org || report) disable unlikely@
>> position p;
>> @@
>>
>> (
>>  !likely@p(...)
>> |
>>  !unlikely@p(...)
>> )
>>
>> @script:python depends on org@
>> p << r.p;
>> @@
>>
>> coccilib.org.print_todo(p[0], "WARNING use unlikely instead of !likely")
>>
>> @script:python depends on report@
>> p << r.p;
>> @@
>>
>> msg="WARNING: Use unlikely instead of !likely and likely instead of !unlikely"
>> coccilib.report.print_report(p[0], msg)
>>
>> Thanks,
>> Denis
>> _______________________________________________
>> Cocci mailing list
>> Cocci@systeme.lip6.fr
>> https://systeme.lip6.fr/mailman/listinfo/cocci
>>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
