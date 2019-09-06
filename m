Return-Path: <SRS0=PWh2=XB=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097AEC0030B
	for <cocci@archiver.kernel.org>; Fri,  6 Sep 2019 07:00:06 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80933206BB
	for <cocci@archiver.kernel.org>; Fri,  6 Sep 2019 07:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iRXVe9Zm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80933206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x866xn7p009124;
	Fri, 6 Sep 2019 08:59:49 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0F75277A6;
	Fri,  6 Sep 2019 08:59:49 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 532037790
 for <cocci@systeme.lip6.fr>; Fri,  6 Sep 2019 07:15:29 +0200 (CEST)
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:643] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x865FSfA026018
 for <cocci@systeme.lip6.fr>; Fri, 6 Sep 2019 07:15:28 +0200 (CEST)
Received: by mail-pl1-x643.google.com with SMTP id 4so2529605pld.10
 for <cocci@systeme.lip6.fr>; Thu, 05 Sep 2019 22:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=message-id:mime-version:content-transfer-encoding:in-reply-to
 :references:to:from:cc:subject:user-agent:date;
 bh=a2LOjFUhPbLgvkL0tM4GO8ba+rPlY6cRwAaIH0yqFhI=;
 b=iRXVe9ZmTGD6DLbHMktGQnAtedAWPBdz7jfymGxrUHhWBukit0PWtlbth0La978u4W
 4wHVbNbkLT+hNE5YQs7GQUbnhTcakSld9AVTwqa+DQ0eWRcv4mpThhKxksYejdJLIkix
 vlXcgcR3HwmnXbsldwWOY/BcqLadXdiuBsE5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:mime-version
 :content-transfer-encoding:in-reply-to:references:to:from:cc:subject
 :user-agent:date;
 bh=a2LOjFUhPbLgvkL0tM4GO8ba+rPlY6cRwAaIH0yqFhI=;
 b=XZ+Z7t29+kYbzyMcOo/kMd7Aq049p7in33ijMAIQ+pByg1B7iB8JlvdRSS17IbTl8D
 sWrxeDwGtNaj3CwHr+62z+pJKoNgAxLCiOb8d84wpneOiLpSXWLS6s6Z0bObgaNuDJSM
 uA7MZb9pYz9UqBJcqYWAX1c4rz5/QktUrc34qzM3QY7a4gfabWWxAeo29+oodVv1hn3J
 lUHeFV2XG2S69MawwvPBkCL4CkG1y6bxSg8nL+K2dXgSsSXh0+8Vy3rOwsCWH60GtuHD
 6Tb8Zks9hOKsu5jf4HjxNgXrEJcYFeWmGln32NnvQYbyjwq/WYrqrqjJhZpQcj3YLyVB
 zarQ==
X-Gm-Message-State: APjAAAUxrdHUWK3xbDxsceTSiC5DsWaTtactC9x4jGORZQqf0NMO+JrR
 lo1hweLiphXRAELCv6KtMEADwQ==
X-Google-Smtp-Source: APXvYqybda006Iz2xBYD2Y4oUD9Ac0B5n1TbiRO8U56Jzay1kDjVhUeq7xoi+MBZ7VylGLOqJ++gHw==
X-Received: by 2002:a17:902:9a88:: with SMTP id
 w8mr7280207plp.161.1567746927912; 
 Thu, 05 Sep 2019 22:15:27 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
 by smtp.gmail.com with ESMTPSA id b18sm4877779pfi.160.2019.09.05.22.15.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2019 22:15:27 -0700 (PDT)
Message-ID: <5d71eb6f.1c69fb81.31bc8.da2d@mx.google.com>
MIME-Version: 1.0
In-Reply-To: <20190906033006.17616-1-yuehaibing@huawei.com>
References: <20190906033006.17616-1-yuehaibing@huawei.com>
To: Gilles.Muller@lip6.fr, Julia.Lawall@lip6.fr, gregkh@linuxfoundation.org,
        michal.lkml@markovi.net, nicolas.palix@imag.fr, yuehaibing@huawei.com
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date: Thu, 05 Sep 2019 22:15:26 -0700
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 06 Sep 2019 08:59:49 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 06 Sep 2019 07:15:28 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Fri, 06 Sep 2019 08:59:47 +0200
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH -next] coccinelle: platform_get_irq: Fix parse
	error
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

Quoting YueHaibing (2019-09-05 20:30:06)
> When do coccicheck, I get this error:
> 
> spatch -D report --no-show-diff --very-quiet --cocci-file
> ./scripts/coccinelle/api/platform_get_irq.cocci --include-headers
> --dir . -I ./arch/x86/include -I ./arch/x86/include/generated -I ./include
>  -I ./arch/x86/include/uapi -I ./arch/x86/include/generated/uapi
>  -I ./include/uapi -I ./include/generated/uapi
>  --include ./include/linux/kconfig.h --jobs 192 --chunksize 1
> minus: parse error:
>   File "./scripts/coccinelle/api/platform_get_irq.cocci", line 24, column 9, charpos = 355
>   around = '\(',
>   whole content = if ( ret \( < \| <= \) 0 )
> 
> In commit e56476897448 ("fpga: Remove dev_err() usage
> after platform_get_irq()") log, I found the semantic patch,
> it fix this issue.
> 
> Fixes: 98051ba2b28b ("coccinelle: Add script to check for platform_get_irq() excessive prints")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Hmm I had this earlier but someone asked me to change it.

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
