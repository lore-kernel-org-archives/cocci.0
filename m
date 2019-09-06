Return-Path: <SRS0=PWh2=XB=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PLING_QUERY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947C7C43331
	for <cocci@archiver.kernel.org>; Fri,  6 Sep 2019 20:56:05 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1367620693
	for <cocci@archiver.kernel.org>; Fri,  6 Sep 2019 20:56:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1367620693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x86Ktk2A001765;
	Fri, 6 Sep 2019 22:55:46 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 007777797;
	Fri,  6 Sep 2019 22:55:46 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D5D3B7793
 for <cocci@systeme.lip6.fr>; Fri,  6 Sep 2019 22:55:43 +0200 (CEST)
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
 [209.85.208.66])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x86KtgN2013287
 for <cocci@systeme.lip6.fr>; Fri, 6 Sep 2019 22:55:42 +0200 (CEST)
Received: by mail-ed1-f66.google.com with SMTP id o9so7762680edq.0
 for <cocci@systeme.lip6.fr>; Fri, 06 Sep 2019 13:55:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Q50YWDbiSd1qIGUsdn2HhgRM3zE7h0WNAycJ80w5WqI=;
 b=amy296s4DFHPzlFfX7UJ2/fttJ0AjHTswPWsv/G80gHnuph4Y9jbr+zcXeC55RemlB
 z3L+O9tAYIZY9mWL+Q/QWmxeVPWM4Hp2AJvMQsyRhtL6WEDR9kWqqIZuqk1GjDPf4R8C
 yaxFCxUP/yOT0knB4xsXkn1DKM2CkXkUnpRLfpmuPpnK6Z3SnqMVMQjAKq4+bpr46dGO
 LLdf3RnAM6ZT6Ylm/7l3zfIBsVMJJlspj0ch478aDOXr57U4kwYb8xUsDRj46aNiSiUo
 Si9Ss1FPbZyrACWhqK/otJSJnLh15GD9DEVPgctE1Jh1LPjEnp22Yhs/clSoicBV1IeU
 M55A==
X-Gm-Message-State: APjAAAUEwtnRGeWcd4qfnb04K43lkrPeKUnG9Tcw1CzGIE6+5IA4Phd0
 VfMyRQj2KnfY5OshJ28mbMI=
X-Google-Smtp-Source: APXvYqx1IskuV1YVXPEkNqMrhmasdZALFNksi0W7EFZ/LXpgqcz7IDSlJEfbpYTNi5H8vpkn2vCYDw==
X-Received: by 2002:a17:906:7294:: with SMTP id
 b20mr9136472ejl.216.1567803342364; 
 Fri, 06 Sep 2019 13:55:42 -0700 (PDT)
Received: from [10.68.32.192] (broadband-188-32-48-208.ip.moscow.rt.ru.
 [188.32.48.208])
 by smtp.gmail.com with ESMTPSA id a17sm1143026edv.66.2019.09.06.13.55.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2019 13:55:41 -0700 (PDT)
To: Julia Lawall <julia.lawall@lip6.fr>
References: <20190825130536.14683-1-efremov@linux.com>
 <20190829171013.22956-1-efremov@linux.com>
 <alpine.DEB.2.21.1909062217240.2643@hadrien>
From: Denis Efremov <efremov@linux.com>
Message-ID: <3981b788-cd0b-d2c4-4585-d209f6f6a522@linux.com>
Date: Fri, 6 Sep 2019 23:55:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1909062217240.2643@hadrien>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 06 Sep 2019 22:55:46 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 06 Sep 2019 22:55:42 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>, Joe Perches <joe@perches.com>,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH v2] scripts: coccinelle: check for !(un)?likely
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

Hi,

On 06.09.2019 23:19, Julia Lawall wrote:
> 
> 
> On Thu, 29 Aug 2019, Denis Efremov wrote:
> 
>> This patch adds coccinelle script for detecting !likely and
>> !unlikely usage. These notations are confusing. It's better
>> to replace !likely(x) with unlikely(!x) and !unlikely(x) with
>> likely(!x) for readability.
>>
>> The rule transforms !likely(x) to unlikely(!x) based on this logic:
>>   !likely(x) iff
>>   !__builtin_expect(!!(x), 1) iff
>>    __builtin_expect(!!!(x), 0) iff
>>   unlikely(!x)
>>
>> For !unlikely(x) to likely(!x):
>>   !unlikely(x) iff
>>   !__builtin_expect(!!(x), 0) iff
>>   __builtin_expect(!!!(x), 1) iff
>>   likely(!x)
>>
>> Signed-off-by: Denis Efremov <efremov@linux.com>
>> Cc: Julia Lawall <Julia.Lawall@lip6.fr>
>> Cc: Gilles Muller <Gilles.Muller@lip6.fr>
>> Cc: Nicolas Palix <nicolas.palix@imag.fr>
>> Cc: Michal Marek <michal.lkml@markovi.net>
>> Cc: Markus Elfring <Markus.Elfring@web.de>
>> Cc: Joe Perches <joe@perches.com>
>> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> 
> Acked-by: Julia Lawall <julia.lawall@lip6.fr>
> 
> A small improvement though would be to improve the explicit dependency of
> the last four python rules on r1 and r2.  Those rules won't execute unless
> the inherited metavariable has a value, which makes the same dependency.
> 
> julia

I think I will resend this patch as a part of patchset with all warnings fixed
in a couple of days. Hope this will help to create a discussion point with other
developers about readability of "!likely" and "!unlikely".

Thanks,
Denis
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
