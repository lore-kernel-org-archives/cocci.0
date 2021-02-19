Return-Path: <SRS0=pxvX=HV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09085C433DB
	for <cocci@archiver.kernel.org>; Fri, 19 Feb 2021 09:07:49 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FE8C64EAF
	for <cocci@archiver.kernel.org>; Fri, 19 Feb 2021 09:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FE8C64EAF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 11J97ZgO023490;
	Fri, 19 Feb 2021 10:07:35 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0D3C877C0;
	Fri, 19 Feb 2021 10:07:35 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 820CA3E64
 for <cocci@systeme.lip6.fr>; Fri, 19 Feb 2021 10:07:33 +0100 (CET)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com
 [209.85.208.175])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 11J97W9B028621
 for <cocci@systeme.lip6.fr>; Fri, 19 Feb 2021 10:07:33 +0100 (CET)
Received: by mail-lj1-f175.google.com with SMTP id a17so16467900ljq.2
 for <cocci@systeme.lip6.fr>; Fri, 19 Feb 2021 01:07:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xyq5nG2yr38aemsnJfNSmiVO/9QJ0+e2d+IFGadQ8SI=;
 b=rHWrHH5NB77Vw6xfQU67qbUQydhhhw7rqejYkWAzRb6K2q2kPyZDeqigAl3fJS2f9a
 QbuUz15oG9YstIv8PjWfH27I6SMTsYd88kZhgZYCI53r7TaqhZRhpzcFoxSZ1VQJsEm+
 vLB3EgUFmGR9osQZjNaEjP/oGVJIP+0yqm6pCdm87/LVQSaHPMhctK3Q5RUJrN6HoQ2S
 p+67ffltwA8h4uksYgbhwQQnGMEUlIVL1UmG7nbgcMxTrDs+mU5cWxZn0CvrasI6OinY
 oMf542TooCycN9wWFvJHBysiAQCLodGkhqepQt/mD8EsyBDtCUXvWdbEgWAVrFvWL96b
 q+Dw==
X-Gm-Message-State: AOAM532T2hep0j90cCJmRwK/sdeiSB+LqbPBOY4hE+/U1mcRd+EKZIOW
 yfwN4UObbbVPK43Elgq4Uzttpa980sCerw==
X-Google-Smtp-Source: ABdhPJyh5xjPIJcNbDRYZFGZdha1/lEiSWn8YXBXcjs4x5PCv6Jf96UBIOZJyxu9rGD+IAsWBb48xw==
X-Received: by 2002:a2e:9c94:: with SMTP id x20mr5246491lji.366.1613725652675; 
 Fri, 19 Feb 2021 01:07:32 -0800 (PST)
Received: from [10.68.32.147] (broadband-188-32-236-56.ip.moscow.rt.ru.
 [188.32.236.56])
 by smtp.gmail.com with ESMTPSA id l23sm911213ljg.72.2021.02.19.01.07.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Feb 2021 01:07:32 -0800 (PST)
To: Julia Lawall <julia.lawall@inria.fr>
References: <20210216080133.455456-1-efremov@linux.com>
 <20210219090520.8812-1-efremov@linux.com>
From: Denis Efremov <efremov@linux.com>
Message-ID: <d12393d9-982c-53f5-9db6-0397aef95179@linux.com>
Date: Fri, 19 Feb 2021 12:07:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210219090520.8812-1-efremov@linux.com>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 19 Feb 2021 10:07:35 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 19 Feb 2021 10:07:33 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH v2] coccinelle: misc: add minmax script
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

Sorry for wrong thread, I'll resend v2 to the right one.

Denis

On 2/19/21 12:05 PM, Denis Efremov wrote:
> Check for opencoded min(), max() implementations.
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
> 
> Changes in v2:
>  - <... ...> instead of ... when any
>  - org mode reports fixed
>  - patch rule to drop excessive ()
> 
>  scripts/coccinelle/misc/minmax.cocci | 224 +++++++++++++++++++++++++++
>  1 file changed, 224 insertions(+)
>  create mode 100644 scripts/coccinelle/misc/minmax.cocci
> 
> diff --git a/scripts/coccinelle/misc/minmax.cocci b/scripts/coccinelle/misc/minmax.cocci
> new file mode 100644
> index 000000000000..61d6b61fd82c
> --- /dev/null
> +++ b/scripts/coccinelle/misc/minmax.cocci
> @@ -0,0 +1,224 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +///
> +/// Check for opencoded min(), max() implementations.
> +/// Generated patches sometimes require adding a cast to fix compile warning.
> +/// Warnings/patches scope intentionally limited to a function body.
> +///
> +// Confidence: Medium
> +// Copyright: (C) 2021 Denis Efremov ISPRAS
> +// Options: --no-includes --include-headers
> +//
> +// Keywords: min, max
> +//
> +
> +
> +virtual report
> +virtual org
> +virtual context
> +virtual patch
> +
> +@rmax depends on !patch@
> +identifier func;
> +expression x, y;
> +binary operator cmp = {>, >=};
> +position p;
> +@@
> +
> +func(...)
> +{
> +	<...
> +*	x cmp@p y ? x : y
> +	...>
> +}
> +
> +@rmaxif depends on !patch@
> +identifier func;
> +expression x, y;
> +expression max_val;
> +binary operator cmp = {>, >=};
> +position p;
> +@@
> +
> +func(...)
> +{
> +	<...
> +*	if (x cmp@p y) {
> +*		max_val = x;
> +*	} else {
> +*		max_val = y;
> +*	}
> +	...>
> +}
> +
> +@rmin depends on !patch@
> +identifier func;
> +expression x, y;
> +binary operator cmp = {<, <=};
> +position p;
> +@@
> +
> +func(...)
> +{
> +	<...
> +*	x cmp@p y ? x : y
> +	...>
> +}
> +
> +@rminif depends on !patch@
> +identifier func;
> +expression x, y;
> +expression min_val;
> +binary operator cmp = {<, <=};
> +position p;
> +@@
> +
> +func(...)
> +{
> +	<...
> +*	if (x cmp@p y) {
> +*		min_val = x;
> +*	} else {
> +*		min_val = y;
> +*	}
> +	...>
> +}
> +
> +@pmax depends on patch@
> +identifier func;
> +expression x, y;
> +binary operator cmp = {>=, >};
> +position p;
> +@@
> +
> +func@p(...)
> +{
> +	<...
> +-	x cmp y ? x : y
> ++	max(x, y)
> +	...>
> +}
> +
> +@pmaxif depends on patch@
> +identifier func;
> +expression x, y;
> +expression max_val;
> +binary operator cmp = {>=, >};
> +position p;
> +@@
> +
> +func@p(...)
> +{
> +	<...
> +-	if (x cmp y) {
> +-		max_val = x;
> +-	} else {
> +-		max_val = y;
> +-	}
> ++	max_val = max(x, y);
> +	...>
> +}
> +
> +@pmin depends on patch@
> +identifier func;
> +expression x, y;
> +binary operator cmp = {<=, <};
> +position p;
> +@@
> +
> +func@p(...)
> +{
> +	<...
> +-	x cmp y ? x : y
> ++	min(x, y)
> +	...>
> +}
> +
> +@pminif depends on patch@
> +identifier func;
> +expression x, y;
> +expression min_val;
> +binary operator cmp = {<=, <};
> +position p;
> +@@
> +
> +func@p(...)
> +{
> +	<...
> +-	if (x cmp y) {
> +-		min_val = x;
> +-	} else {
> +-		min_val = y;
> +-	}
> ++	min_val = min(x, y);
> +	...>
> +}
> +
> +@depends on (pmax || pmaxif || pmin || pminif)@
> +identifier func;
> +expression x, y;
> +position p;
> +// FIXME: Coccinelle consumes all available ram and
> +// and timeouts on every file.
> +// position p = { pmin.p, pminif.p, pmax.p, pmaxif.p };
> +@@
> +
> +func@p(...)
> +{
> +	<...
> +(
> +-	(min((x), (y)))
> ++	min(x, y)
> +|
> +-	(max((x), (y)))
> ++	max(x, y)
> +)
> +	...>
> +}
> +
> +@script:python depends on report@
> +p << rmax.p;
> +@@
> +
> +coccilib.report.print_report(p[0], "WARNING opportunity for max()")
> +
> +@script:python depends on org@
> +p << rmax.p;
> +@@
> +
> +coccilib.org.print_todo(p[0], "WARNING opportunity for max()")
> +
> +@script:python depends on report@
> +p << rmaxif.p;
> +@@
> +
> +coccilib.report.print_report(p[0], "WARNING opportunity for max()")
> +
> +@script:python depends on org@
> +p << rmaxif.p;
> +@@
> +
> +coccilib.org.print_todo(p[0], "WARNING opportunity for max()")
> +
> +@script:python depends on report@
> +p << rmin.p;
> +@@
> +
> +coccilib.report.print_report(p[0], "WARNING opportunity for min()")
> +
> +@script:python depends on org@
> +p << rmin.p;
> +@@
> +
> +coccilib.org.print_todo(p[0], "WARNING opportunity for min()")
> +
> +@script:python depends on report@
> +p << rminif.p;
> +@@
> +
> +coccilib.report.print_report(p[0], "WARNING opportunity for min()")
> +
> +@script:python depends on org@
> +p << rminif.p;
> +@@
> +
> +coccilib.org.print_todo(p[0], "WARNING opportunity for min()")
> 
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
