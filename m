Return-Path: <SRS0=Wces=HR=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18F7C433E0
	for <cocci@archiver.kernel.org>; Mon, 15 Feb 2021 11:52:07 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 094C064DE0
	for <cocci@archiver.kernel.org>; Mon, 15 Feb 2021 11:52:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 094C064DE0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 11FBplwO016240;
	Mon, 15 Feb 2021 12:51:47 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DF5E077C0;
	Mon, 15 Feb 2021 12:51:46 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0EA98376A
 for <cocci@systeme.lip6.fr>; Mon, 15 Feb 2021 12:51:46 +0100 (CET)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com
 [209.85.167.42])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 11FBpjS4014753
 for <cocci@systeme.lip6.fr>; Mon, 15 Feb 2021 12:51:45 +0100 (CET)
Received: by mail-lf1-f42.google.com with SMTP id v24so9663855lfr.7
 for <cocci@systeme.lip6.fr>; Mon, 15 Feb 2021 03:51:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5Pr14wZWNozifPH43vKx9v38gZi/XyYDuqQDBtN/QJE=;
 b=PjMnQDqW33f9eIuXr/HBUGG11ng/hNjHuMcPs601zK4xQSGGsufhc/JL1evcNDLS65
 D0kWuQ2f8GAgxPc2JCZTvVojYq7wB/hBR2Ln9TpSorUjS5fSmw8cLPrPwEOAV6CwuTP5
 PO0UR7wA494MyQNfiKN8BOIyNrizxAqr/pvqR9XGxc3D8pRuE+jNf5kFZQLtNgVax+qS
 HnTs39K6aF5FPIFgbihw8CksUvA/c3s5yfYzIZu1DZOP5ZEu4KGwl0C8dDlsoupxd0U9
 /pOcKAuPp6ncvfyFeNtvd5J5J3DsJPL/Tnv/cUtFG4fIWQ3AmwQOwyZCrr2xc4VTpemY
 46QA==
X-Gm-Message-State: AOAM531NYjT8Yvjhv82lHFZfpPUqS1IQKZrlMgfJYK1wJjWebnVH9kb3
 A3/3zBkBWaaVztsvm+SWkgUVwXrg/Q4N+Q==
X-Google-Smtp-Source: ABdhPJxfZxXmEJXNVmlzQe7Bal8cLa3E2f1eGW9IoYMfVoj2oXRj90pVRO6L7nrMVl+jQa2Vbbb7WA==
X-Received: by 2002:a19:592:: with SMTP id 140mr8078599lff.411.1613389904958; 
 Mon, 15 Feb 2021 03:51:44 -0800 (PST)
Received: from [10.68.32.147] (broadband-188-32-236-56.ip.moscow.rt.ru.
 [188.32.236.56])
 by smtp.gmail.com with ESMTPSA id l19sm3627039lji.53.2021.02.15.03.51.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Feb 2021 03:51:44 -0800 (PST)
To: Julia Lawall <julia.lawall@inria.fr>
References: <f3aefcce-4ba1-f49a-c47a-fb6e7a164a19@linux.com>
 <alpine.DEB.2.22.394.2102151246510.2808@hadrien>
From: Denis Efremov <efremov@linux.com>
Message-ID: <bddd397c-2bb1-ef20-d2cd-e1c8af6a2de3@linux.com>
Date: Mon, 15 Feb 2021 14:51:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2102151246510.2808@hadrien>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 15 Feb 2021 12:51:47 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 15 Feb 2021 12:51:45 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Problem with partial patch generation
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



On 2/15/21 2:47 PM, Julia Lawall wrote:
> 
> 
> On Mon, 15 Feb 2021, Denis Efremov wrote:
> 
>> Hi,
>>
>> I wrote a simple rule (swap.cocci):
>>
>> virtual patch
>>
>> @depends on patch@
>> identifier tmp;
>> expression a, b;
>> type T;
>> @@
>>
>> (
>> - T tmp;
>> |
>> - T tmp = 0;
>> |
>> - T *tmp = NULL;
>> )
>> ... when != tmp
>> - tmp = a;
>> - a = b;
>> - b = tmp;
>> + swap(a, b);
>> ... when != tmp
>>
>> I would expect it to remove a local variable only if there is a match
>> with swap template.
>>
>> However, it generates "partial" patch on 5.11 linux code:
>> $ spatch --version
>> spatch version 1.0.8-00201-g267f9cf8cc82 compiled with OCaml version 4.11.1
>> $ spatch -D patch --sp-file swap.cocci mm/filemap.c
>> --- mm/filemap.c
>> +++ /tmp/cocci-output-445786-88aa66-filemap.c
>> @@ -2348,7 +2348,7 @@ static int generic_file_buffered_read_ge
>>         struct file_ra_state *ra = &filp->f_ra;
>>         pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
>>         pgoff_t last_index = (iocb->ki_pos + iter->count + PAGE_SIZE-1) >> PAGE_SHIFT;
>> -       int i, j, nr_got, err = 0;
>> +       int i, nr_got, err = 0;
>>
>>         nr = min_t(unsigned long, last_index - index, nr);
>>  find_page:
>>
>> How can I improve the rule?
> 
> I don't get a match with the latest version of Coccinelle.
> 
> If the latest version of Coccinelle were to become a release, would that
> be good enough for you?  Or do you need 1.0.8 to work as well?

I planned to submit the swap rule to scripts/coccinelle. However, I can
create more strict pattern for the patch mode. Maybe adding "when strict"
is suitable here?
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
