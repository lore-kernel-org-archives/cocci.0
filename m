Return-Path: <SRS0=fE6L=M4=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65264C4338F
	for <cocci@archiver.kernel.org>; Thu,  5 Aug 2021 10:22:28 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B259B610A2
	for <cocci@archiver.kernel.org>; Thu,  5 Aug 2021 10:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B259B610A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 175AMOY3015049;
	Thu, 5 Aug 2021 12:22:24 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 175AC120C5;
	Thu,  5 Aug 2021 12:22:24 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C0856120C5
 for <cocci@systeme.lip6.fr>; Thu,  5 Aug 2021 12:22:22 +0200 (CEST)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 175A7v6V007465
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 5 Aug 2021 12:07:57 +0200 (CEST)
Received: by mail-qk1-f172.google.com with SMTP id c9so5619551qkc.13
 for <cocci@systeme.lip6.fr>; Thu, 05 Aug 2021 03:07:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BgKdFE0vGQVPJxa/hxgCIV92XvRlmWHmQs+8hZ4rLCM=;
 b=jaVZRAlaech/Jqxo5U0f//F6EJm2BWtGfVXaJ8jRDBx/EDY2vHbbWeaTFxLJUBzrY0
 HmSIIbkplUAUGx9QsGPyDubEvbhoj5AHshrHdmWNelf69AbU2F3REKe5DYlLUJOYDCGd
 dcP1AXPSgxrYN9MLT08mEv1vrAo1vvPHj2ijUtwYPnCetWsTL8oUm4pZ60k6pWa3hQ83
 SyTd7I4pdDlukg2WS3Ya15nwvbEjb8aF1b/oi34tMu/ZStzU9zCgt/l2CsVQR9fSGRbx
 P3T9LqGBz0t8eOfiSOjjYrI5cnRo7AIp7QQud2+Kcop75pUIBk/TaW3wDm0u/gjcGIHf
 F2fw==
X-Gm-Message-State: AOAM530rzwbHTFqkL1L27g1EvuXcqwBMXzQ8LKFRusFcWLLRkYm2Mxq8
 Kj287/cTWkfC9U7bPDB7R5g=
X-Google-Smtp-Source: ABdhPJy/zGi8yLdv+kWEZaFUANkNBcK1RcK0BY6S4OaxGh9FCIl6mQEQZIrcNdStl+gpzpQ4Dv97WA==
X-Received: by 2002:a37:9dcd:: with SMTP id g196mr2956011qke.99.1628158076768; 
 Thu, 05 Aug 2021 03:07:56 -0700 (PDT)
Received: from [10.10.132.158] ([83.149.199.249])
 by smtp.gmail.com with ESMTPSA id b66sm367820qkf.135.2021.08.05.03.07.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Aug 2021 03:07:56 -0700 (PDT)
To: Weizhao Ouyang <o451686892@gmail.com>, Julia.Lawall@inria.fr,
        Gilles.Muller@inria.fr, nicolas.palix@imag.fr, michal.lkml@markovi.net
References: <20210805095822.1732125-1-o451686892@gmail.com>
From: Denis Efremov <efremov@linux.com>
Message-ID: <3cb9caa9-b7d3-5b1b-7020-63d72506c7c7@linux.com>
Date: Thu, 5 Aug 2021 13:07:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210805095822.1732125-1-o451686892@gmail.com>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 05 Aug 2021 12:22:24 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 05 Aug 2021 12:07:58 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [RESEND] coccinelle: api: rename kzfree to
	kfree_sensitive
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

On 8/5/21 12:58 PM, Weizhao Ouyang wrote:
> Commit 453431a54934 ("mm, treewide: rename kzfree() to
> kfree_sensitive()") renamed kzfree() to kfree_sensitive(),
> it should be applied to coccinelle.
> 
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>

Acked-by: Denis Efremov <efremov@linux.com>

> ---
>  scripts/coccinelle/api/kvmalloc.cocci | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/coccinelle/api/kvmalloc.cocci b/scripts/coccinelle/api/kvmalloc.cocci
> index c30dab718a49..5ddcb76b76b0 100644
> --- a/scripts/coccinelle/api/kvmalloc.cocci
> +++ b/scripts/coccinelle/api/kvmalloc.cocci
> @@ -79,7 +79,7 @@ position p : script:python() { relevant(p) };
>    } else {
>      ... when != krealloc(E, ...)
>          when any
> -*   \(kfree\|kzfree\)(E)
> +*   \(kfree\|kfree_sensitive\)(E)
>      ...
>    }
>  
> 

Regards,
Denis
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
