Return-Path: <SRS0=bgdO=76=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF80C433E0
	for <cocci@archiver.kernel.org>; Wed, 17 Jun 2020 18:15:29 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28E1B206E2
	for <cocci@archiver.kernel.org>; Wed, 17 Jun 2020 18:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SdUds60V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28E1B206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05HIFBH1006306;
	Wed, 17 Jun 2020 20:15:11 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 462077577;
	Wed, 17 Jun 2020 20:15:11 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 12A023D0F
 for <cocci@systeme.lip6.fr>; Wed, 17 Jun 2020 20:15:10 +0200 (CEST)
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:643])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05HIF86u029723
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Wed, 17 Jun 2020 20:15:09 +0200 (CEST)
Received: by mail-pl1-x643.google.com with SMTP id k6so1303054pll.9
 for <cocci@systeme.lip6.fr>; Wed, 17 Jun 2020 11:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=RdqXevPl9uJkE3HCx2/ZTZ7Vh1kelDtYj8huy4vkv0A=;
 b=SdUds60VPFAsN4bvveQ4jp5InHf0ZUUz99xRZhRp+41UMQMhVcoiKwCBGDJIHZscBK
 lx55XnwUC1mpIChq7Ak6UivUmeED3KnMSVgfzqfMaYH+MWJtecnmKZJZJc4BiMoRn0wU
 Amjjdv31jrGXmKUOkF/93WsA6oExSqQUwhLVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=RdqXevPl9uJkE3HCx2/ZTZ7Vh1kelDtYj8huy4vkv0A=;
 b=EBaXrC/1xAbf6KX11Z6Um7rfg4e8WMuFpG7ZQ53rkq6u8+osMdJg8gGQTWUocVYOfK
 gEobyNB82UA0r2raDuL+udOV3Yec2wZHsnI5x0WOScMY1fn0vVD9MI5JX9/BwZ6TYVYj
 D2TKFFVjijrBbI8cRukeF7KZo8JZnALrUaSxWtG+LyVfBgX6d2smXAIwl3DmvBwPK19j
 ZUD6iD06/DohkGKn65EQ+IfOMEup1Kmn0Za8p4fDdIIValbYXINr5fuvx/uhb6TsOY8W
 W2WsZKjoBxyUO+iF7P7yfUYg39z+QVdAf/2TssiR+BzY2hjIxrBs8d/kNG8s8X/y97NP
 4tdA==
X-Gm-Message-State: AOAM5331wZKF8sYx74A+4L7wcQh5cqBQvpMaKXfTw4yR0nduw7pn1wie
 X8qRHQsmg5Nt1cfjjv+LIdJvkw==
X-Google-Smtp-Source: ABdhPJxTzLtLJsscJ1qfMfUDlWH0JrF41Ue4dtI+ASH3RecBTT03vfvBuhXEXW6KMgo01pRZpUjNeA==
X-Received: by 2002:a17:90a:7c48:: with SMTP id
 e8mr264393pjl.235.1592417707785; 
 Wed, 17 Jun 2020 11:15:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id m22sm498891pfk.216.2020.06.17.11.15.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 11:15:06 -0700 (PDT)
Date: Wed, 17 Jun 2020 11:15:05 -0700
From: Kees Cook <keescook@chromium.org>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Message-ID: <202006171103.327F86B1C@keescook>
References: <20200615102045.4558-1-efremov@linux.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200615102045.4558-1-efremov@linux.com>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 17 Jun 2020 20:15:11 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 17 Jun 2020 20:15:09 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH] coccinelle: misc: add array_size_dup script to
 detect missed overlow checks
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

On Mon, Jun 15, 2020 at 01:20:45PM +0300, Denis Efremov wrote:
> +@as@
> +expression E1, E2;
> +@@
> +
> +array_size(E1, E2)

BTW, is there a way yet in Coccinelle to match a fully qualified (?)
identifier? For example, if I have two lines in C:

A)
	array_size(variable, 5);
B)
	array_size(instance->member.size, 5);
C)
	array_size(instance->member.size + 1, 5);
D)
	array_size(function_call(variable), 5);


This matches A, B, C, and D:

@@
expression ARG1;
expression ARG2;
@@

array_size(ARG1, ARG2);


This matches only A:

@@
identifier ARG1;
expression ARG2;
@@

array_size(ARG1, ARG2);


How do I get something to match A and B but not C and D (i.e. I do not
want to match any operations, function calls, etc, only a variable,
which may be identified through dereference, array index, or struct
member access.)


-- 
Kees Cook
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
