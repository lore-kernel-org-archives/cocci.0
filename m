Return-Path: <SRS0=v8PH=77=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9578DC433E0
	for <cocci@archiver.kernel.org>; Thu, 18 Jun 2020 20:48:37 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2954420890
	for <cocci@archiver.kernel.org>; Thu, 18 Jun 2020 20:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UvJOh2wd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2954420890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05IKmNjb022384;
	Thu, 18 Jun 2020 22:48:23 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2A68A7577;
	Thu, 18 Jun 2020 22:48:23 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id CC7DA402B
 for <cocci@systeme.lip6.fr>; Thu, 18 Jun 2020 22:48:21 +0200 (CEST)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:62b])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05IKmJBE004085
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 18 Jun 2020 22:48:20 +0200 (CEST)
Received: by mail-pl1-x62b.google.com with SMTP id y17so2954041plb.8
 for <cocci@systeme.lip6.fr>; Thu, 18 Jun 2020 13:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=5wHSbymKQDDBwBrZLoO+dcxDF79vuSWQfqndXQUqIEM=;
 b=UvJOh2wdpig8UGI1kDYufCna/uzFb9g2HxW+FlbTg9OLYcsUNyA7Zm+5loP2mfDTaP
 ao6/eXd7oGrSYxq+ZBHv0038e5LdVHhpg+l3qnpvf/6iejyxs5UQQ+Jmsh6cA+dnC3Fp
 7M+DCKEzdagkxKHjqKsKnFTHlgXEhgiFKKL5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=5wHSbymKQDDBwBrZLoO+dcxDF79vuSWQfqndXQUqIEM=;
 b=m/sy4AZ/L0Yq4q41YOVGYUwJLfWsmRFnd6zOvLJwaTFC8nUmghgHW0X4NcENN8kH5s
 kprUmtTuZScPDNHz87S/jR7YZ3ralYsh6NMIbtdkpuwf1ES1uA9qBzDnslM9S2ebqRuf
 TS+JAp0wHFoD2rM9pjpInJESK1wvas8s8vJLuVNL34F1rZM1ZL3YXZPVCMY2hgtFTYJ4
 mLJTLGjka38MbBCljn/wF2YmWbNLXFahd6p102nLMfVtfWVeZokaUq3W6zs26Fj0i+t+
 2sEq+mlkpj1P4XDfFCOOjIX+gtoBFNOWWQcVMd5ZrCQm2aTakNCZLNrlqpNsM16hqN7Q
 jKmA==
X-Gm-Message-State: AOAM530+Quu+r0aHfXxngtP74LBefuXXjIelItyugQyBDZX9UpOc6lmG
 mvBnXW13Afzsl4iQ2w1tdnD5Zg==
X-Google-Smtp-Source: ABdhPJwxQ4Kfo5lluDI1fVk+5aVGpXScF8cH5rCNSpV+eNigyHi64sJBCw3omrWvi0tBKsfW6crGog==
X-Received: by 2002:a17:90a:4d09:: with SMTP id
 c9mr152642pjg.137.1592513298942; 
 Thu, 18 Jun 2020 13:48:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id 1sm3678364pfx.210.2020.06.18.13.48.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2020 13:48:18 -0700 (PDT)
Date: Thu, 18 Jun 2020 13:48:17 -0700
From: Kees Cook <keescook@chromium.org>
To: Julia Lawall <julia.lawall@inria.fr>
Message-ID: <202006181346.ECCBE1FC0E@keescook>
References: <20200615102045.4558-1-efremov@linux.com>
 <202006171103.327F86B1C@keescook>
 <alpine.DEB.2.22.394.2006172051280.3083@hadrien>
 <202006181249.8B826D9@keescook>
 <alpine.DEB.2.22.394.2006182155260.2367@hadrien>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2006182155260.2367@hadrien>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 18 Jun 2020 22:48:23 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 18 Jun 2020 22:48:20 +0200 (CEST)
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

On Thu, Jun 18, 2020 at 09:56:18PM +0200, Julia Lawall wrote:
> @@
> identifier i,fld;
> expression e;
> @@
> 
> \(\(i\|e.fld\|e->fld\) \& E\)
> 
> The e will match all of the variants you are concerned about.

Ah, I see! Okay, that's good. And the "& E" part is to effectively
collect it into E (as in, both the left and right of the & must match).

So to do the matching from earlier:

@@
identifier i, fld;
expression e, ARG1, ARG2;
@@

array_size(\(\(i\|e.fld\|e->fld\) \& ARG1\), ARG2);


?


-- 
Kees Cook
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
