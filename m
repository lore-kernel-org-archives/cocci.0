Return-Path: <SRS0=g0NP=CG=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0EFC433E2
	for <cocci@archiver.kernel.org>; Fri, 28 Aug 2020 07:59:08 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 430912078A
	for <cocci@archiver.kernel.org>; Fri, 28 Aug 2020 07:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ISB7ntnk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 430912078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07S7wgH1003281;
	Fri, 28 Aug 2020 09:58:42 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B2016777D;
	Fri, 28 Aug 2020 09:58:42 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id AE0834316
 for <cocci@systeme.lip6.fr>; Fri, 28 Aug 2020 09:58:41 +0200 (CEST)
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1041])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 07S7wdgL029051
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 28 Aug 2020 09:58:40 +0200 (CEST)
Received: by mail-pj1-x1041.google.com with SMTP id ds1so167433pjb.1
 for <cocci@systeme.lip6.fr>; Fri, 28 Aug 2020 00:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=PElpbzIDHomzRDBqhzC9EtSuGk5dGo9/mZ4Zosmva34=;
 b=ISB7ntnkpAQLBD08Qe+CwRG4oyGX7bNu/54ttG6U4kcZTr1CXqDq7aE+vYsiYrQ3XC
 fhJu3Ot9XdAp4t9UCHO6tiaW9UlBnbYqGlXJetJ0SNrvmGpkR7KXkZ2OP4/ljZQVwmRF
 XYYJOVWz5g8XjNxGsph+V5EoqidDtb5wUP1nY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PElpbzIDHomzRDBqhzC9EtSuGk5dGo9/mZ4Zosmva34=;
 b=mTkmylsbfNjXZMRilfGXDGckEe3MVBer+irC4osBSc07wYbYsEvGsCHAjqnk64fAH2
 6t9VbqrcOHL/wg/kLKDGaxMTvheD8S2PZ61AfYiOL3Ttn/sYh27rdwuGiNSqp7KIY+or
 U+TF+pVsrxbaIYugtoKPx91e5GNRz8WZh7SV5p2Dcp3SnmOJuzKkWdosJuHtDdYxBcTB
 bXZ3ZC10CqlJjlwRm3+PUIndOPhjkI2vlWkYy8MnBwKgbmdLr9VK5QjlyTVQS7p6uI1u
 /5qAB0G3kgUSCSpOY19FRFNOB3514trRV5i2aI7BiUl2L67EOoHRAWAoTIpsiLn979/S
 30gA==
X-Gm-Message-State: AOAM5317WbX6UycGV11qp9mQ5EWRSXhbC8McV4SNDLrNqwwC363UYVkX
 9+4Cg06fuN/IabuZSnvkqL2HWA==
X-Google-Smtp-Source: ABdhPJwYWtmVVE1J1r8j2+MZXqOUgShBQU9gpECocvKDQTrB1tC/VMiqwggHpKTrwS4yij/XM1+b/g==
X-Received: by 2002:a17:90a:b10a:: with SMTP id
 z10mr223586pjq.102.1598601519328; 
 Fri, 28 Aug 2020 00:58:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id y7sm403384pjn.54.2020.08.28.00.58.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 00:58:38 -0700 (PDT)
Date: Fri, 28 Aug 2020 00:58:37 -0700
From: Kees Cook <keescook@chromium.org>
To: Joe Perches <joe@perches.com>
Message-ID: <202008280056.6442BCC@keescook>
References: <20200827071537.GA168593@kroah.com>
 <20200827131819.7rcl2f5js3hkoqj2@lenovo-laptop>
 <def24e9e-018c-9712-0d07-d4cbc84f07d9@rasmusvillemoes.dk>
 <20200827144846.yauuttjaqtxaldxg@lenovo-laptop>
 <5d1dfb9b031130d4d20763ec621233a19d6a88a2.camel@perches.com>
 <alpine.DEB.2.22.394.2008272141220.2482@hadrien>
 <5853c58e-7d26-2cf9-6cbf-698ecd93cbf9@linux.com>
 <202008271517.ECC1F1F8F@keescook>
 <5ebe5c2737b59d04f1b8a46008cd3159c638f9d0.camel@perches.com>
 <d99c613aa70617f440c51d9413372b858a4ae826.camel@perches.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d99c613aa70617f440c51d9413372b858a4ae826.camel@perches.com>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 28 Aug 2020 09:58:43 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 28 Aug 2020 09:58:41 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, Alex Dewar <alex.dewar90@gmail.com>,
        cocci <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] [PATCH] usb: atm: don't use snprintf() for sysfs attrs
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

On Thu, Aug 27, 2020 at 09:12:06PM -0700, Joe Perches wrote:
> Perhaps something like the below with a sample conversion
> that uses single and multiple sysfs_emit uses.

On quick review, I like it. :)

> [...]
> +int sysfs_emit(char *buf, char *pos, const char *fmt, ...)
> +{
> +	int len;
> +	va_list args;
> +
> +	WARN(pos < buf, "pos < buf\n");
> +	WARN(pos - buf >= PAGE_SIZE, "pos >= PAGE_SIZE (%tu > %lu)\n",
> +	     pos - buf, PAGE_SIZE);
> +	if (pos < buf || pos - buf >= PAGE_SIZE)
> +		return 0;

This can be:

	if (WARN(pos < buf, "pos < buf\n") ||
	    WARN(pos - buf >= PAGE_SIZE, "pos >= PAGE_SIZE (%tu > %lu)\n",
		 pos - buf, PAGE_SIZE))
		return 0;

-- 
Kees Cook
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
