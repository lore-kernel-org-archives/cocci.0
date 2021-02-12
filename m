Return-Path: <SRS0=/q4u=HO=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288C7C433E6
	for <cocci@archiver.kernel.org>; Fri, 12 Feb 2021 20:18:52 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 719B864E36
	for <cocci@archiver.kernel.org>; Fri, 12 Feb 2021 20:18:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 719B864E36
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 11CKIWJa010535;
	Fri, 12 Feb 2021 21:18:32 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5045B77AC;
	Fri, 12 Feb 2021 21:18:32 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3E6EA3B26
 for <cocci@systeme.lip6.fr>; Fri, 12 Feb 2021 21:18:30 +0100 (CET)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com
 [209.85.208.173])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 11CKIT0R013819
 for <cocci@systeme.lip6.fr>; Fri, 12 Feb 2021 21:18:29 +0100 (CET)
Received: by mail-lj1-f173.google.com with SMTP id j6so526397ljo.5
 for <cocci@systeme.lip6.fr>; Fri, 12 Feb 2021 12:18:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=D5S3NogKOZo9yTcKzDQCqDiuUHRnpTF0lV+WfEy31zY=;
 b=e2xA4PFT0t9pUZBQnBUM/2fX4oZbaHLoyE7NVtD4yzpDk13cxJdkaHCgxjKBB+qCde
 8cgd6FbprGUMZFu27fKok0XEFyVO+1LdfjUnPKk935337e2eRnz9PKKriBqB/CoHcFNM
 a0cMhOX+0G0ZgfahHVYWI7iTXJD/FO9F6KKjigPc1RyN5JXcq6EldkuQ8SUcYIECgPSx
 qGte1LXokCsoYhZG8QtD6SbuXPB65RBrH5KAzIXyGc6wEkGYPkkDFLfLSD2SDcipTAKd
 oXuTOrKVhML+mURYgnRZ6plZOW4P24NvlbWLmgiHNGuqADZNPWOwz/1jXCOLHfMtW2px
 rygg==
X-Gm-Message-State: AOAM533LLAsoHHQx1wJIju+pi8HmPGyNYyoKSEuQpHsm1neQ48NIt4K5
 00hcuNRMdZ2tqzbt4TpPoJcuaUu8sSkr/A==
X-Google-Smtp-Source: ABdhPJxx1CrhHM4nsaN22d47vocsr+lW3Lm79SXhbvojDVwfT++Ju50xDZnpxP6J1jwfhx2zbaE0Xg==
X-Received: by 2002:a2e:3207:: with SMTP id y7mr2600522ljy.190.1613161109142; 
 Fri, 12 Feb 2021 12:18:29 -0800 (PST)
Received: from [10.68.32.147] (broadband-188-32-236-56.ip.moscow.rt.ru.
 [188.32.236.56])
 by smtp.gmail.com with ESMTPSA id i13sm1240501lfl.125.2021.02.12.12.18.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Feb 2021 12:18:28 -0800 (PST)
To: Julia Lawall <julia.lawall@inria.fr>
References: <0c2a01f3-e48b-fc67-78b4-f061026aec42@linux.com>
 <alpine.DEB.2.22.394.2102121504100.9350@hadrien>
From: Denis Efremov <efremov@linux.com>
Message-ID: <f7c2e83e-0cdd-d414-0fb1-e57cd380dce7@linux.com>
Date: Fri, 12 Feb 2021 23:18:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2102121504100.9350@hadrien>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 12 Feb 2021 21:18:33 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 12 Feb 2021 21:18:29 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Backward compatibility issue
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



On 2/12/21 5:04 PM, Julia Lawall wrote:
> 
> 
> On Thu, 11 Feb 2021, Denis Efremov wrote:
> 
>> Hi, one of my patterns started to fail tests on latest coccinelle.
>> I've bisected the commit that introduces "error". It's:
>> commit db60e916633d2cb3ae31140364783fdf85ed10f4
>> "make information about SmPL iterator and declarer names available to the C parser"
>>
>> To reproduce the error:
>> $ cd linux
>> $ git checkout 5b01014759991887b1e450c9def01e58c02ab81b
>> $ wget https://raw.githubusercontent.com/evdenis/cvehound/master/cvehound/cve/CVE-2016-9793.cocci
>> $ spatch -D detect --cocci-file CVE-2016-9793.cocci net/core/sock.c
>> # spatch before db60e916633d2cb3ae31140364783fdf85ed10f4 will find the match
>> net/core/sock.c:718:16-17: ERROR: CVE-2016-9793
>> net/core/sock.c:754:16-17: ERROR: CVE-2016-9793
>> ...
>> # spatch >= db60e916633d2cb3ae31140364783fdf85ed10f4 will not match the same code
> 
> If you change typedef u32 to symbol u32, it should be good.  It is no use
> to Coccinelle to know that u32 is a typedef in this code.

After changing typedef to symbol, git version starts to match the code,
but coccinelle 1.0.8 starts to fail the detection. Well, this doesn't
solve the problem for me.

What's the difference between symbol and typedef? How can I understand
when to use one or another?

Thanks,
Denis
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
