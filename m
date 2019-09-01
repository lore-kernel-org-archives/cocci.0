Return-Path: <SRS0=rzKh=W4=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DAAC3A5A4
	for <cocci@archiver.kernel.org>; Sun,  1 Sep 2019 17:39:50 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B53242173E
	for <cocci@archiver.kernel.org>; Sun,  1 Sep 2019 17:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B53242173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x81HdZ4g022872;
	Sun, 1 Sep 2019 19:39:35 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 07A1F6204;
	Sun,  1 Sep 2019 19:39:35 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 114E15F8A
 for <cocci@systeme.lip6.fr>; Sun,  1 Sep 2019 19:39:33 +0200 (CEST)
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
 [209.85.208.68])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x81HdVrJ010063
 for <cocci@systeme.lip6.fr>; Sun, 1 Sep 2019 19:39:31 +0200 (CEST)
Received: by mail-ed1-f68.google.com with SMTP id z51so13632946edz.13
 for <cocci@systeme.lip6.fr>; Sun, 01 Sep 2019 10:39:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0wSbAT31pUQLK0avkX7bfMBXJEaiMB9FtdWtd8fTkuI=;
 b=bgV0/zzYqZ4kJ2VAWGUFLl1NnWow0z61Y2Znr+Lr5WXMd+ThcB5fgTBBfhyaxRN/q8
 WFEp9qjeS7V+3I8+46MuTdInAUZyQmbMyXJlhcb2gZ5rHi0/wKVijTx3C/0raRMB255j
 xwyuXQL069DrzaJXe4I7KoJyg3tpqLK/STuevseoGIR5S6vaDtulxOYfWKpN/jxa1HVK
 xXUq8pKlfX4+BE9e2fnceiMgjHJc2iqXf2990WlBVNoPFD6aPGPMpMdTpUkM67Fp+5Z8
 uvrQYoVQXBby8j1g0rGxOrQQaHP8cgDYc0AKaTr+PtvetErn6s7Y/ohI48PQRxu6G0Qz
 lEhA==
X-Gm-Message-State: APjAAAVFyaNvRoX5R37qGNx9qcBuv8CcFp5UhHz6ICnfTUB6YoaPvMXP
 OGJXmok51GqunQKIRIO3REo=
X-Google-Smtp-Source: APXvYqzmvf/srhJRI2HrfYdFo6+eKwvDtDsIPL/s7+ubC9fM5BBOe9SBCLB4Z+jBivfIm0B4biN1Rg==
X-Received: by 2002:aa7:db0c:: with SMTP id t12mr13449835eds.297.1567359571711; 
 Sun, 01 Sep 2019 10:39:31 -0700 (PDT)
Received: from [10.68.32.192] (broadband-188-32-48-208.ip.moscow.rt.ru.
 [188.32.48.208])
 by smtp.gmail.com with ESMTPSA id qt5sm231872ejb.11.2019.09.01.10.39.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Sep 2019 10:39:31 -0700 (PDT)
To: Pavel Machek <pavel@ucw.cz>, Joe Perches <joe@perches.com>
References: <20190825130536.14683-1-efremov@linux.com>
 <b5bae2981e27d133b61d99b08ee60244bf7aabe3.camel@perches.com>
 <20190901172403.GA1047@bug>
From: Denis Efremov <efremov@linux.com>
Message-ID: <45362841-2ae6-e946-2ae0-ab56a98f15ca@linux.com>
Date: Sun, 1 Sep 2019 20:39:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190901172403.GA1047@bug>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 01 Sep 2019 19:39:35 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 01 Sep 2019 19:39:31 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] scripts: coccinelle: check for !(un)?likely
	usage
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



On 01.09.2019 20:24, Pavel Machek wrote:
> Hi!
> 
>>> This patch adds coccinelle script for detecting !likely and !unlikely
>>> usage. It's better to use unlikely instead of !likely and vice versa.
>>
>> Please explain _why_ is it better in the changelog.
>>
>> btw: there are relatively few uses like this in the kernel.
>>
>> $ git grep -P '!\s*(?:un)?likely\s*\(' | wc -l
>> 40
>>
>> afaict: It may save 2 bytes of x86/64 object code.
>>
>> For instance:
>>
>> $ diff -urN kernel/tsacct.lst.old kernel/tsacct.lst.new|less
>> --- kernel/tsacct.lst.old       2019-08-25 09:21:39.936570183 -0700
>> +++ kernel/tsacct.lst.new       2019-08-25 09:22:20.774324886 -0700
>> @@ -24,158 +24,153 @@
>>    15:  48 89 fb                mov    %rdi,%rbx
>>         u64 time, delta;
>>  
>> -       if (!likely(tsk->mm))
>> +       if (unlikely(tsk->mm))
> 
> Are you sure this is equivalent?
> 
> 									Pavel

Hi,

No, it's not correct. Thanks Rasmus for clarifying the things here.
This was my mistake. As a human, I failed to parse "likely" and "!"
and made too hasty conclusions :)

The correct transformation is in v2. This will be
!likely(tsk->mm) -> unlikely(!tsk->mm)

Thanks,
Denis
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
