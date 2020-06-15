Return-Path: <SRS0=AA88=74=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36493C433DF
	for <cocci@archiver.kernel.org>; Mon, 15 Jun 2020 18:23:47 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C55DB2074A
	for <cocci@archiver.kernel.org>; Mon, 15 Jun 2020 18:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U+NpbKGI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C55DB2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05FINW9A007248;
	Mon, 15 Jun 2020 20:23:32 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id CF4387577;
	Mon, 15 Jun 2020 20:23:32 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C3B45402B
 for <cocci@systeme.lip6.fr>; Mon, 15 Jun 2020 20:23:30 +0200 (CEST)
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1042])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05FINPEI007367
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 15 Jun 2020 20:23:26 +0200 (CEST)
Received: by mail-pj1-x1042.google.com with SMTP id m2so208387pjv.2
 for <cocci@systeme.lip6.fr>; Mon, 15 Jun 2020 11:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=IvShgxoC6bEvinDvmURRTORSW1iT83qg7H2qgSQS19E=;
 b=U+NpbKGIkE9uBSFYj785QYFB+7ya2GdLJf26a5eZptaE+Q9l3S4vQkrMwGK7idV1Q/
 FaLWXHRWuMIlQR1nmVSYMSzeaWFof6bo246BhYUINV13Iwgnpu/4WR/Gn4BWy3eofGKv
 AkLGdGsLoSUZbPWfwHx9/xA2V3pCZV1Z7gByw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=IvShgxoC6bEvinDvmURRTORSW1iT83qg7H2qgSQS19E=;
 b=RAfhWZ3LefkG29zY/nZTMXH9lxjN7BhC8Oysg/N4CMAFtMB7pwnWyulLv+lYGuUlG9
 y/rAQ4K6TgnqSodcpvG75VIYCsXzJgSEH8isxJmnauRyslcJ3QeodYu9buTOfnDOY8UI
 SdIQohLrUt6M6YDVfuYgORqmyvaE9Dffmdyzp5YLhYedYZT917JQg4vSUqq41zopYcA5
 qh0QG2aLvuduMbnX4EU8MhijOAV/5+CTNCtKUBHWvprj+6VYRnatwAbLutuHyajtEww2
 mZAT6++zP/aNMwUAn76QTHGAs1wHwPdtCOm8pK5KmWmAd8SW2qL6otkOq+A5LJThKtH3
 +bNA==
X-Gm-Message-State: AOAM533H3n+tOCTWuqnVwpe5Uno3vSR+Rkeks/cqz6Rn9ADGwzSgj02V
 /TnOCxz2ZrfdczLFvJjo6pUYRQ==
X-Google-Smtp-Source: ABdhPJz0RZjZviKdUtNJ9eldCEtBXBpRgBgFrvR3r26zSJFIETSsILbIXvrl1mnG2zXN6hNYIQGOpg==
X-Received: by 2002:a17:90a:1da6:: with SMTP id
 v35mr546338pjv.177.1592245405235; 
 Mon, 15 Jun 2020 11:23:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id b3sm14373082pft.127.2020.06.15.11.23.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2020 11:23:24 -0700 (PDT)
Date: Mon, 15 Jun 2020 11:23:23 -0700
From: Kees Cook <keescook@chromium.org>
To: Denis Efremov <efremov@linux.com>
Message-ID: <202006151123.3C2CB7782@keescook>
References: <20200615102045.4558-1-efremov@linux.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200615102045.4558-1-efremov@linux.com>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 15 Jun 2020 20:23:33 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 15 Jun 2020 20:23:26 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: Julia Lawall <Julia.Lawall@lip6.fr>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
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
> Detect an opencoded expression that is used before or after
> array_size()/array3_size()/struct_size() to compute the same size.
> 
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Denis Efremov <efremov@linux.com>

Oh, very cool! How much does this find currently?

-- 
Kees Cook
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
