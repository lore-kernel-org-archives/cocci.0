Return-Path: <SRS0=hLsS=CW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B91DC43461
	for <cocci@archiver.kernel.org>; Sun, 13 Sep 2020 06:15:30 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D1592098B
	for <cocci@archiver.kernel.org>; Sun, 13 Sep 2020 06:15:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D1592098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08D6F98S022044;
	Sun, 13 Sep 2020 08:15:09 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id CC84D778A;
	Sun, 13 Sep 2020 08:15:09 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 92AC24316
 for <cocci@systeme.lip6.fr>; Sun, 13 Sep 2020 08:15:07 +0200 (CEST)
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com
 [209.85.167.67])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08D6F62E025263
 for <cocci@systeme.lip6.fr>; Sun, 13 Sep 2020 08:15:06 +0200 (CEST)
Received: by mail-lf1-f67.google.com with SMTP id d15so10001641lfq.11
 for <cocci@systeme.lip6.fr>; Sat, 12 Sep 2020 23:15:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VIVA2HaGuHbJZKovmrROTl+HQozHCTJ5N0cUfUx1nfg=;
 b=eW4ckrFvfSPQXQULCBbzaVsXxwmnVdk52T8kq6SUpnxZmij4v24rz7X8BxcxD1Mm9g
 ZYwL95RoUwfEN9GZ/mBWI4rgE/3mH4oOIePwyzhuqJxudDGQtKetNvCyBTGdSjGc4ijB
 XwFXklMHpVSdfDHgQJT47t4MThzgounWuaCBNmBxm9XAqWtArjw0rpbk/3oHVq27s0lT
 Ef4bwsmnpN99NqSqgN96TLaxIBjnUyUSipXTYeMXQybcEOrGft/xxsMuMzQD0nVABl5r
 dzuL7AIqZsKsDIY/pxrFKFOxhBS4gO86styHT1Lw2NdUpRwtR+4Nmc/buiDpAiPD5UcO
 ZnXA==
X-Gm-Message-State: AOAM532B+Yt8AvWL6AjpwfgyOuJUsTuIZtRxCV569L6NxJh0SlhSYpAM
 8hzTp0aAq67tPcm3EVVMTD0=
X-Google-Smtp-Source: ABdhPJwjH7ptCUkCoTy2pV6UjoybHb3zAonsb7RgEuRKBhZkx+nQpSW3dH2K2ViPBYuAB1LpHhpf9Q==
X-Received: by 2002:a19:754:: with SMTP id 81mr2416069lfh.272.1599977706439;
 Sat, 12 Sep 2020 23:15:06 -0700 (PDT)
Received: from [192.168.1.184] ([213.87.159.180])
 by smtp.gmail.com with ESMTPSA id x5sm1939351lff.280.2020.09.12.23.15.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 12 Sep 2020 23:15:05 -0700 (PDT)
To: Julia Lawall <julia.lawall@inria.fr>
References: <20200806220342.25426-1-efremov@linux.com>
 <20200809212655.58457-1-efremov@linux.com>
 <alpine.DEB.2.22.394.2009121642070.2362@hadrien>
From: Denis Efremov <efremov@linux.com>
Message-ID: <c717ff19-73c3-2369-7b61-318b0a9662ab@linux.com>
Date: Sun, 13 Sep 2020 09:15:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2009121642070.2362@hadrien>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 13 Sep 2020 08:15:10 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 13 Sep 2020 08:15:06 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: "Gustavo A . R . Silva" <gustavoars@kernel.org>, cocci@systeme.lip6.fr,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH v2] coccinelle: misc: add flexible_array.cocci
	script
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

Hi,

On 9/12/20 5:43 PM, Julia Lawall wrote:
> 
> 
> On Mon, 10 Aug 2020, Denis Efremov wrote:
> 
>> Commit 68e4cd17e218 ("docs: deprecated.rst: Add zero-length and one-element
>> arrays") marks one-element and zero-length arrays as deprecated. Kernel
>> code should always use "flexible array members" instead.
>>
>> The script warns about one-element and zero-length arrays in structs.
>>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
>> Signed-off-by: Denis Efremov <efremov@linux.com>
>> ---
>> Changes in v2:
>>  - all uapi headers are now filtered-out. Unfortunately, coccinelle
>>    doesn't provide structure names in Location.current_element.
>>    For structures the field is always "something_else". Thus, there is
>>    no easy way to create a list of existing structures in uapi headers
>>    and suppress the warning only for them, but not for the newly added
>>    uapi structures.
>>  - The pattern doesn't require 2+ fields in a structure/union anymore.
>>    Now it also checks single field structures/unions.
>>  - The pattern simplified and now uses disjuction in array elements
>>    (Thanks, Markus)
>>  - Unions are removed from patch mode
>>  - one-element arrays are removed from patch mode. Correct patch may
>>    involve turning the array to a simple field instead of a flexible
>>    array.
>>
>> On the current master branch, the rule generates:
>>  - context: https://gist.github.com/evdenis/e2b4323491f9eff35376372df07f723c
>>  - patch: https://gist.github.com/evdenis/46081da9d68ecefd07edc3769cebcf32
>>
>>  scripts/coccinelle/misc/flexible_array.cocci | 88 ++++++++++++++++++++
>>  1 file changed, 88 insertions(+)
>>  create mode 100644 scripts/coccinelle/misc/flexible_array.cocci
>>
>> diff --git a/scripts/coccinelle/misc/flexible_array.cocci b/scripts/coccinelle/misc/flexible_array.cocci
>> new file mode 100644
>> index 000000000000..bf6dcda1783e
>> --- /dev/null
>> +++ b/scripts/coccinelle/misc/flexible_array.cocci
>> @@ -0,0 +1,88 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +///
>> +/// Zero-length and one-element arrays are deprecated, see
>> +/// Documentation/process/deprecated.rst
>> +/// Flexible-array members should be used instead.
>> +///
>> +//
>> +// Confidence: High
>> +// Copyright: (C) 2020 Denis Efremov ISPRAS.
>> +// Comments:
>> +// Options: --no-includes --include-headers
>> +
>> +virtual context
>> +virtual report
>> +virtual org
>> +virtual patch
>> +
>> +@initialize:python@
>> +@@
>> +def relevant(positions):
>> +    for p in positions:
>> +        if "uapi" in p.file:
>> +             return False
>> +    return True
>> +
>> +@r depends on !patch@
>> +identifier name, array;
>> +type T;
>> +position p : script:python() { relevant(p) };
>> +@@
>> +
>> +(
>> +  struct name {
>> +    ...
>> +*   T array@p[\(0\|1\)];
>> +  };
>> +|
>> +  struct {
>> +    ...
>> +*   T array@p[\(0\|1\)];
>> +  };
>> +|
>> +  union name {
>> +    ...
>> +*   T array@p[\(0\|1\)];
>> +  };
>> +|
>> +  union {
>> +    ...
>> +*   T array@p[\(0\|1\)];
>> +  };
>> +)
>> +
>> +@depends on patch exists@
> 
> exists is not necessary here.  There are not multiple control-flow paths
> through a structure declaration.
> 
>> +identifier name, array;
>> +type T;
>> +position p : script:python() { relevant(p) };
>> +@@
>> +
>> +(
>> +  struct name {
>> +    ...
>> +    T array@p[
>> +-       0
>> +    ];
>> +  };
>> +|
>> +  struct {
>> +    ...
>> +    T array@p[
>> +-       0
>> +    ];
>> +  };
>> +)
>> +
>> +@script: python depends on report@
>> +p << r.p;
>> +@@
>> +
>> +msg = "WARNING: use flexible-array member instead"
>> +coccilib.report.print_report(p[0], msg)
>> +
>> +@script: python depends on org@
>> +p << r.p;
>> +@@
>> +
>> +msg = "WARNING: use flexible-array member instead"
>> +coccilib.org.print_todo(p, msg)
> 
> This should be coccilib.org.print_todo(p[0], msg)
> 


Thanks, I will send v3 with fixes and proper links to online documentation.

Regards,
Denis
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
