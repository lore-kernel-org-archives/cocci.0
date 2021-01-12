Return-Path: <SRS0=eIV6=GP=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D1AC433E0
	for <cocci@archiver.kernel.org>; Tue, 12 Jan 2021 17:04:04 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9623A2311B
	for <cocci@archiver.kernel.org>; Tue, 12 Jan 2021 17:04:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9623A2311B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 10CH3fmJ014104;
	Tue, 12 Jan 2021 18:03:41 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id F3EE277B8;
	Tue, 12 Jan 2021 18:03:40 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5CD6837BB
 for <cocci@systeme.lip6.fr>; Tue, 12 Jan 2021 18:03:39 +0100 (CET)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com
 [209.85.167.46])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 10CH3csB014626
 for <cocci@systeme.lip6.fr>; Tue, 12 Jan 2021 18:03:38 +0100 (CET)
Received: by mail-lf1-f46.google.com with SMTP id o19so4474951lfo.1
 for <cocci@systeme.lip6.fr>; Tue, 12 Jan 2021 09:03:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OE34cr5aIEuZnwyuwqoFeFWr84R2hqWAq9IrFW87HEU=;
 b=JGDfRQgzzq9wvq1RulWzr0GvoLS/QvIkt93yfSi3kUZV5bD3cEHX5NCdNaIoMphtej
 ad6Rx73SkN3v4JU7ljQfRZmhrZUl1me3SAlSk8mCXv6PMrZ5BRKwOqpNfevqXUBg2hYd
 5QK/iifhhfZeiE5MqbVLWPNO0TGYFL45k8N6ngOdB7Jz8yPRQuxXmGe3wJD/zjf4O5xm
 9d/DxNmXg4IwgE0T9hbcargZOpZcykNhSg3AhqSiJ815W8NJtaGOSzX3lVoSxEHmUWXJ
 Km/V7tBflx+ezTD8pE029q+VYnWi9rxyhaWa43dRTQdxg8oa12hXHkb3i6/rjAzAoqPg
 JFfw==
X-Gm-Message-State: AOAM530iHTcvRJgroAiCV989SHr4MjMCezyaOQOcaeGftR9TJg3OhG/J
 pxvfDM/JH4oEu6ONN6ovkkmwWRdrqyHrSA==
X-Google-Smtp-Source: ABdhPJwpVgKHDwDilCFs7eUioG+sNO8idg+gOpOxbgxJZSzD+yAvlqamrCa3EjpL5wDawSnHDni9jw==
X-Received: by 2002:a19:5f0a:: with SMTP id t10mr2566840lfb.568.1610471018323; 
 Tue, 12 Jan 2021 09:03:38 -0800 (PST)
Received: from [10.68.32.192] (broadband-188-32-236-56.ip.moscow.rt.ru.
 [188.32.236.56])
 by smtp.gmail.com with ESMTPSA id e20sm462620lfn.221.2021.01.12.09.03.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Jan 2021 09:03:37 -0800 (PST)
To: Julia Lawall <julia.lawall@inria.fr>
References: <9bd6a75e-c595-a623-de09-04d261263167@linux.com>
 <alpine.DEB.2.22.394.2101121708580.2766@hadrien>
From: Denis Efremov <efremov@linux.com>
Message-ID: <4e87794f-1e17-babb-54fe-f190df0b877c@linux.com>
Date: Tue, 12 Jan 2021 20:03:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2101121708580.2766@hadrien>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 12 Jan 2021 18:03:41 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 12 Jan 2021 18:03:39 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] How to match switch cases and their absence with
 coccinelle?
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



On 1/12/21 7:13 PM, Julia Lawall wrote:
> 
> 
> On Tue, 12 Jan 2021, Denis Efremov wrote:
> 
>> Hi,
>>
>> Let's suppose I have this pattern:
>> @fix exists@
>> position p;
>> @@
>>
>> binder_release_work(...)
>> {
>> 	...
>> 	switch (...) {
>> *		case BINDER_WORK_NODE: ... break;@p
>> 	}
>> 	...
> 
> Add when any to the outer ...s

Thanks, this helped.

> 
>> }
>>
>> and I want to match binder_release_work() function in drivers/android/binder.c
>> file (linux kernel, master)
>>
>> Seems like the rule is not enough, it gives nothing:
>> $ spatch --cocci-file binder.cocci drivers/android/binder.c
>> init_defs_builtins: /usr/lib64/coccinelle/standard.h
>> HANDLING: drivers/android/binder.c
>>
>> 1) What can I do to reliable check that there is a special case in a switch?
>> 2) Is it possible to check that there is no case handling with something like:
>> 	switch (...) {
>> 		... when != case BINDER_WORK_NODE: ... break;
>> 	}
> 
> I don't know if that will work.  But you can do it with two rules.  In the
> first rule, you could put a position variable on the switch, and then in
> the second rule, you could make a position variable that is required to be
> different than the first one, and that is also attached to a switch.

Yes, I use this method currently.

Also I faced the problem when I can't use ... in the beginning of enum, i.e.:
struct binder_work {
        ...
        enum binder_work_type {
                ... // <== will not work
*               BINDER_WORK_NODE,
                ...
        } type;
	...
}

This works:
struct binder_work {
        ...
        enum binder_work_type {
		// BINDER_WORK_TRANSACTION = ..., // also will not work
                BINDER_WORK_TRANSACTION = 1,
                BINDER_WORK_TRANSACTION_COMPLETE,
                BINDER_WORK_RETURN_ERROR,
*               BINDER_WORK_NODE,
                ...
        } type;
        ...
}

Thanks,
Denis
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
