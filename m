Return-Path: <SRS0=O4Qb=WZ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B73C3A59F
	for <cocci@archiver.kernel.org>; Thu, 29 Aug 2019 17:13:20 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BDC12173E
	for <cocci@archiver.kernel.org>; Thu, 29 Aug 2019 17:13:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BDC12173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7THD8hl027368;
	Thu, 29 Aug 2019 19:13:08 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4D76A7791;
	Thu, 29 Aug 2019 19:13:08 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3C66E778B
 for <cocci@systeme.lip6.fr>; Thu, 29 Aug 2019 19:13:07 +0200 (CEST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7THD6eu016029
 for <cocci@systeme.lip6.fr>; Thu, 29 Aug 2019 19:13:06 +0200 (CEST)
Received: by mail-ed1-f45.google.com with SMTP id t50so4885648edd.2
 for <cocci@systeme.lip6.fr>; Thu, 29 Aug 2019 10:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=di8LUDxG63XQ7Xvb3E8hcpbi4JeDENkx37r4x30557s=;
 b=t8T0aVcg5CloIJfDrwYKsUZk/kr6NcwSjvPL0Aw+UgxEIrkWI3SS+qhUAh0nTyP8hC
 aY849Le7hMgzUcRTQ78TbdOWStJIJ1bbKmBEJ/bfRx27l9UiUjQ14OQy50HV3n/A4DxI
 bKPG0eLHSn8BKTmFNd9shrSG3zmJdFfLfkC1+G+SMr6lpUmT6HtlysnDOJ/OwuWmHKVg
 awkeVNCX8+v/iaIYHmSxBRbS7cWGwUo3Yh0CRLVMA30da/zx4H2PMJtPFWhwkvkci+yJ
 o7Kw87KP9n55kmTxc9OXA7SxUz6HictXqdYiV07EF1lJyn4U7b7g+E9HYuBK7G7hOrkR
 6XkQ==
X-Gm-Message-State: APjAAAWpjhPK+VhIYEwWvpWt5wJDs4dOHniXJ2gPtFVc4W1nHhHa5Lge
 bEc5pC5HCJfP/lmMdGlHAoE=
X-Google-Smtp-Source: APXvYqwNWp4EWWbghrJtatqWl4coi2+CPdJUHxDSmAc80Ju3nrSZBpwoFL+mCJQa4/IaQSXm2ndmSQ==
X-Received: by 2002:aa7:c498:: with SMTP id m24mr11109283edq.277.1567098786810; 
 Thu, 29 Aug 2019 10:13:06 -0700 (PDT)
Received: from [10.10.2.174] (bran.ispras.ru. [83.149.199.196])
 by smtp.gmail.com with ESMTPSA id l9sm534513eds.96.2019.08.29.10.13.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2019 10:13:06 -0700 (PDT)
To: linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr
References: <20190825130536.14683-1-efremov@linux.com>
 <20190829171013.22956-1-efremov@linux.com>
From: Denis Efremov <efremov@linux.com>
Message-ID: <d2f8cd31-f317-1b28-fb0a-bfb2cf689181@linux.com>
Date: Thu, 29 Aug 2019 20:13:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190829171013.22956-1-efremov@linux.com>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 29 Aug 2019 19:13:08 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 29 Aug 2019 19:13:07 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Markus Elfring <Markus.Elfring@web.de>, Joe Perches <joe@perches.com>
Subject: Re: [Cocci] [PATCH v2] scripts: coccinelle: check for !(un)?likely
	usage
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
Reply-To: efremov@linux.com
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

On 8/29/19 8:10 PM, Denis Efremov wrote:
> This patch adds coccinelle script for detecting !likely and
> !unlikely usage. These notations are confusing. It's better
> to replace !likely(x) with unlikely(!x) and !unlikely(x) with
> likely(!x) for readability.

I'm not sure that this rule deserves the acceptance.
Just to want to be sure that "!unlikely(x)" and "!likely(x)"
are hard-readable is not only my perception and that they
become more clear in form "likely(!x)" and "unlikely(!x)" too.

Thanks,
Denis
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
