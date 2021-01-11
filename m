Return-Path: <SRS0=qIOj=GO=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F84C433DB
	for <cocci@archiver.kernel.org>; Mon, 11 Jan 2021 21:12:38 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 008B8207B6
	for <cocci@archiver.kernel.org>; Mon, 11 Jan 2021 21:12:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 008B8207B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 10BLCDD5017990;
	Mon, 11 Jan 2021 22:12:13 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2EE2377B8;
	Mon, 11 Jan 2021 22:12:13 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B7E1A74B6
 for <cocci@systeme.lip6.fr>; Mon, 11 Jan 2021 22:12:11 +0100 (CET)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com
 [209.85.167.42])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 10BLCBX3005434
 for <cocci@systeme.lip6.fr>; Mon, 11 Jan 2021 22:12:11 +0100 (CET)
Received: by mail-lf1-f42.google.com with SMTP id a12so88157lfl.6
 for <cocci@systeme.lip6.fr>; Mon, 11 Jan 2021 13:12:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2vJa3dOaxFyFn7zgmPeKdabRIShB4J/4OSAWMeL6QG0=;
 b=HxEFsLMGFQqrOgqc5euOrZ1Ur7q3XFt/jK7q+pXqtojQ+u5yhe3iOZpGIWHPd1c1zR
 hwN6INGPc+f0owQRAuawPrnuo8r3odq30R/rJMFY88SvFlIL+m+JI7xWJlwDWoAFSfmG
 +fr+PLxOuDpABca4ZAbuWg8ixhKSN2pT5nBFeViLlofysXpXow27QjoQuH+rC0mnChcw
 wxSKo+KD7kiRY+UUKKzM6gDdziUz+IzOef9Xea3uWMNpgNd6NUKQ00YBF9W5B6syiaqc
 b8ckDrojf4HGc9VZb31OKKFyI2lfG088Wc0rOItVNayZRIYSWZl125JHM5Cq6EaqZtvv
 2LWw==
X-Gm-Message-State: AOAM530Ax1gVCbcNq+jdXxyQKkBsLA6YHyKuL5ZT7OVstChhlvEqcRRZ
 y1ufTTz6UhwcwHKWfKB5tDnju7amZPrDaA==
X-Google-Smtp-Source: ABdhPJzfQpQ+IBeU85u4+wWbnhsbuKXTRVYf4/1Ky8eFn1Ir3198PM5bgBZtQurbTofaBvtz/LA2rg==
X-Received: by 2002:a05:6512:552:: with SMTP id
 h18mr583386lfl.558.1610399530558; 
 Mon, 11 Jan 2021 13:12:10 -0800 (PST)
Received: from [10.68.32.192] (broadband-188-32-236-56.ip.moscow.rt.ru.
 [188.32.236.56])
 by smtp.gmail.com with ESMTPSA id w14sm116745lfn.169.2021.01.11.13.12.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Jan 2021 13:12:09 -0800 (PST)
To: Julia Lawall <julia.lawall@inria.fr>
References: <854fdad7-cf2d-49d8-571c-1ac64fa90fb6@linux.com>
 <alpine.DEB.2.22.394.2101112122350.15982@hadrien>
 <a9c270d0-19c4-0357-173f-a2f9c8a1d7ce@linux.com>
 <alpine.DEB.2.22.394.2101112135260.15982@hadrien>
 <b671db37-a57a-6ee4-5324-26658c2ec9ef@linux.com>
 <alpine.DEB.2.22.394.2101112159140.15982@hadrien>
From: Denis Efremov <efremov@linux.com>
Message-ID: <7afc07a9-5a94-bacc-ab5a-0e8d61b986d9@linux.com>
Date: Tue, 12 Jan 2021 00:12:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2101112159140.15982@hadrien>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 Jan 2021 22:12:13 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 11 Jan 2021 22:12:11 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] How to match function-like macro calls,
 e.g. RTA_ALIGN(rta->rta_len)?
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



On 1/11/21 11:59 PM, Julia Lawall wrote:
> 
> 
> On Mon, 11 Jan 2021, Denis Efremov wrote:
> 
>>
>>
>> On 1/11/21 11:40 PM, Julia Lawall wrote:
>>>
>>>
>>> On Mon, 11 Jan 2021, Denis Efremov wrote:
>>>
>>>>
>>>>
>>>> On 1/11/21 11:23 PM, Julia Lawall wrote:
>>>>>
>>>>>
>>>>> On Mon, 11 Jan 2021, Denis Efremov wrote:
>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> Let's suppose I want to match otx_cpt_aead_cbc_aes_sha_setkey() function from
>>>>>> drivers/crypto/marvell/octeontx/otx_cptvf_algs.c file (linux kernel).
>>>>>>
>>>>>> My pattern:
>>>>>> @exists@
>>>>>> identifier rta, param, key, keylen;
>>>>>> position p;
>>>>>> @@
>>>>>>
>>>>>> otx_cpt_aead_cbc_aes_sha_setkey(...,
>>>>>> 	unsigned char *key, unsigned int keylen)
>>>>>> {
>>>>>> 	...
>>>>>> *	if (RTA_PAYLOAD(rta) < sizeof(*param))@p
>>>>>> 		goto badkey;
>>>>>> 	...
>>>>>> *	key += RTA_ALIGN(rta->rta_len);
>>>>>> *	keylen -= RTA_ALIGN(rta->rta_len);
>>>>>> 	...
>>>>>> }
>>>>>>
>>>>>> $ spatch --no-includes --include-headers --cocci-file test.cocci drivers/crypto/marvell/octeontx/otx_cptvf_algs.c
>>>>>> init_defs_builtins: /usr/lib64/coccinelle/standard.h
>>>>>> minus: parse error:
>>>>>>   File "test.cocci", line 13, column 9, charpos = 219
>>>>>>   around = 'RTA_ALIGN',
>>>>>>   whole content = *     key += RTA_ALIGN(rta->rta_len);
>>>>>>
>>>>>>
>>>>>> What can I do to match RTA_ALIGN(...) lines?
>>>>>
>>>>> I don't understand the problem.  I took your rule and your command line,
>>>>> and everything was fine.
>>>>
>>>> I use version:
>>>> spatch version 1.0.8-gc1dbb4f-dirty compiled with OCaml version 4.11.1
>>>> Flags passed to the configure script: --build=x86_64-redhat-linux-gnu --host=x86_64-redhat-linux-gnu --program-prefix= --disable-dependency-tracking --prefix=/usr --exec-prefix=/usr --bindir=/usr/bin --sbindir=/usr/sbin --sysconfdir=/etc --datadir=/usr/share --includedir=/usr/include --libdir=/usr/lib64 --libexecdir=/usr/libexec --localstatedir=/var --sharedstatedir=/var/lib --mandir=/usr/share/man --infodir=/usr/share/info --with-python=/usr/bin/python3 --with-menhir=/usr/bin/menhir
>>>> OCaml scripting support: yes
>>>> Python scripting support: yes
>>>> Syntax of regular expressions: PCRE
>>>>
>>>> Maybe parsing error is fixed in new versions?
>>>
>>> I can't imagine what would cause a parsing error here.  I don't see what
>>> could be special about RTA_ALIGN.  Normally Coccinelle doesn't even know
>>> that it is a macro.  Maybe you can try to simplify the semantic patch a
>>> little bit and see if there is some change that causes the problem to
>>> disappear?  Does the problem disappear if you use a name other than
>>> RTA_ALIGN?
>>
>> Changing:
>> 	key += RTA_ALIGN(rta->rta_len);
>> to:
>> 	key = RTA_ALIGN(rta->rta_len);
>>
>> makes the parsing error disappear.
>>
>> Using aop instead of += leads to the same parsing error:
>> assignment operator aop;
>> key aop RTA_ALIGN(rta->rta_len);
>> init_defs_builtins: /usr/lib64/coccinelle/standard.h
>> minus: parse error:
>>   File "test.cocci", line 14, column 10, charpos = 245
>>   around = 'RTA_ALIGN',
>>   whole content = *     key aop RTA_ALIGN(rta->rta_len);
> 
> I assume not, but does spatch --parse-cocci test.cocci work?

Works with "key =" pattern, with "key +=" or "key aop" doesn't.
The errors are the same:
spatch --parse-cocci test.cocci 
init_defs_builtins: /usr/lib64/coccinelle/standard.h
minus: parse error: 
  File "test.cocci", line 13, column 9, charpos = 219
  around = 'RTA_ALIGN',
  whole content = *     key += RTA_ALIGN(rta->rta_len);

Denis
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
