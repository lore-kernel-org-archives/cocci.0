Return-Path: <SRS0=PX7z=CT=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0298C433E2
	for <cocci@archiver.kernel.org>; Thu, 10 Sep 2020 19:51:43 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AB88208E4
	for <cocci@archiver.kernel.org>; Thu, 10 Sep 2020 19:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e3QOW6li"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AB88208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08AJpFXD003346;
	Thu, 10 Sep 2020 21:51:16 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DAB9C778C;
	Thu, 10 Sep 2020 21:51:15 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 804527595
 for <cocci@systeme.lip6.fr>; Thu, 10 Sep 2020 21:51:13 +0200 (CEST)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:442])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08AJpAID008523
 for <cocci@systeme.lip6.fr>; Thu, 10 Sep 2020 21:51:11 +0200 (CEST)
Received: by mail-pf1-x442.google.com with SMTP id z19so5306849pfn.8
 for <cocci@systeme.lip6.fr>; Thu, 10 Sep 2020 12:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=+cHRkT8sNFeWTbynGyxN3PPYP8ykbg0LglvItAS32tg=;
 b=e3QOW6liZzQXG+Kv2AcwAesvbHXZXtz83QCDVvrluTaPKCOoFGrEp8/WJIbrbwBrvn
 h4scUnJ51PfrgEOp3GFTHmUzxVSBoQuw0WKCBUKih20chmEnh1bNIhopi9J3wcIWomN9
 rieGPxZXAOcUJ9GBL/9QNZzYnFo7NmUnIfdY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+cHRkT8sNFeWTbynGyxN3PPYP8ykbg0LglvItAS32tg=;
 b=dKnNDmKcwO9QyGpryNq7Y1MGHNmstRHYlNmuUCJOQL0QWrcmVqw3rqwo3SC5wPG2ej
 D50+Vx3VPpimLmJOUfPIS5/dO/hhXYE05kc9mmg8JZo4B5bSun+bp9Xvfi2cqZzt1CtQ
 V8+3YAreQPbc/BvYebf2jBAmvA2Q2JgH7QPaHt29enhew/NrnFjOM9U2KHqBZWLdbvcm
 wMbkIVt3BrIhj1BMhVfNdO5+wijKDQBfP//M+eiWDmFMHN5FBDMqX+QaE/JHuGkaZ+j4
 TDYBwHC07UXAs6nHQsWJ0HlnNm2zvT7pfhFvHhV8yksqOCZTc+HAvgaq6XrIKF3+xFOH
 a3Tw==
X-Gm-Message-State: AOAM530a8iqJv5TRWekMLODssylSxShVdBKo//7ztOQ89lDOJOSyIfSk
 VT8eUPT9XDr2pP4cbiIOgXlUlg==
X-Google-Smtp-Source: ABdhPJy3Vb6fYslObxnLlySxaRWzrc6tYBUQWTnl/9XhUVGIeStG6vd//sipTl6dmBxBI1gqfF58iQ==
X-Received: by 2002:aa7:9730:0:b029:13e:d13d:a091 with SMTP id
 k16-20020aa797300000b029013ed13da091mr7054551pfg.40.1599767470434; 
 Thu, 10 Sep 2020 12:51:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id l1sm6732890pfc.164.2020.09.10.12.51.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 12:51:09 -0700 (PDT)
Date: Thu, 10 Sep 2020 12:51:08 -0700
From: Kees Cook <keescook@chromium.org>
To: Joe Perches <joe@perches.com>
Message-ID: <202009101250.FBB416D@keescook>
References: <20200811210127.11889-1-efremov@linux.com>
 <20200901094812.428896-1-efremov@linux.com>
 <afc2cffdd315d3e4394af149278df9e8af7f49f4.camel@perches.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <afc2cffdd315d3e4394af149278df9e8af7f49f4.camel@perches.com>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 10 Sep 2020 21:51:16 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 10 Sep 2020 21:51:11 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] checkpatch: Warn on self-assignments
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

On Sat, Sep 05, 2020 at 10:58:29AM -0700, Joe Perches wrote:
> The uninitialized_var() macro was removed recently via
> commit 63a0895d960a ("compiler: Remove uninitialized_var() macro")
> as it's not a particularly useful warning and its use can
> "paper over real bugs".
> 
> Add a checkpatch test to warn on self-assignments as a means
> to avoid compiler warnings and as a back-door mechanism to
> reproduce the old uninitialized_var macro behavior.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

I like it! :)

Can you add a section to code style and include a link in the checkpatch
warning to it? (Feel free to just reuse the text removed from
deprecated.rst)

-- 
Kees Cook
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
