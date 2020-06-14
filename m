Return-Path: <SRS0=yQoC=73=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D70C433DF
	for <cocci@archiver.kernel.org>; Sun, 14 Jun 2020 07:26:18 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37D54206D7
	for <cocci@archiver.kernel.org>; Sun, 14 Jun 2020 07:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="poAfA8qm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37D54206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05E7QDbG024218;
	Sun, 14 Jun 2020 09:26:13 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3A16A7760;
	Sun, 14 Jun 2020 09:26:13 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id DA87244A7
 for <cocci@systeme.lip6.fr>; Sun, 14 Jun 2020 08:23:29 +0200 (CEST)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:344])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05E6NPwe007463
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 14 Jun 2020 08:23:25 +0200 (CEST)
Received: by mail-wm1-x344.google.com with SMTP id l26so11551058wme.3
 for <cocci@systeme.lip6.fr>; Sat, 13 Jun 2020 23:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:date:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=N1Il4xoBAYB6lrYOu3YcPFEnwJ6e8hDdQ9lMllcuG9Y=;
 b=poAfA8qmym4rYJdB3stjZDtiZpaDtnYqyka4MnGnEskXyU84c46tiixAu+86jqvUmN
 j1untMiJ6Mu3xjgwpuTXmrtD5bo3zeqcv/BECGLJ4S5FDrVrl1A+D1EgQ6J53xyAREya
 v32RSRAJoAMKB+LnWuiG1GH6OEv0TSU/gijpKB6UUFCz+CeMm6SxJgnot67U2cJGIcpb
 EkP6jLAn1GCjGcSfbFjoN5Isk/EOM3lCPodkyhhRfGiwMRPx8WVz8bM1sLzHSMJVUNhk
 INC1Z4KZUoMc4SF1rXiDBy58FxhAtUQZUVIoFrJ4O/0CSYBY4AZg9SIFkKTf+IUw+gRG
 NeVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=N1Il4xoBAYB6lrYOu3YcPFEnwJ6e8hDdQ9lMllcuG9Y=;
 b=Zr5Be/TuDK8bjrEI/kkat/vWWTOfzkC/rSvqmxVf27e3G3vGkU03FrWkeYH6tE5K8i
 F6V9DJoFWJk0rqsjmQ8n2zSjESTJ3lPzSIghyawKR/OBLmIKNpoWW6hzjJX4fnO9RxUl
 KRYPMmXZyWmUHz/2B2De3dID7878mLvcGUHGnjl1fk1SKfAklJcZZjttQhiIkLz8GUWy
 qz8A2h1IEItcNX6II7HA41RmqHuREl9do+khxH6eTMoGJ+vbIaXAOFLs4lnsbamjMl6Q
 25CN0IvHuedPpfN1xRbvkaxqs1b+Hx/aHjJSA2LghRrPTFnA0bg4ZUKIeVyQbwvpKfpj
 KqfQ==
X-Gm-Message-State: AOAM532KdJFQL1q0q1VJb5RQb45ipSY6NbI/nUhu8j9EowcCl2IiSprT
 2+Ulq8EeB4E4NzqDZhI9Hcs=
X-Google-Smtp-Source: ABdhPJxULrdAk6E8dtV25ET2u+P9wFrPndeaqahsaKJzMLUGzY8AdG6s0Ujh+UsaXdwr5dZVIV4vTg==
X-Received: by 2002:a05:600c:2147:: with SMTP id
 v7mr6927026wml.101.1592115804881; 
 Sat, 13 Jun 2020 23:23:24 -0700 (PDT)
Received: from homer.simpson.net ([185.221.151.23])
 by smtp.googlemail.com with ESMTPSA id g18sm17078831wme.17.2020.06.13.23.23.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jun 2020 23:23:24 -0700 (PDT)
Message-ID: <1592115803.27290.33.camel@gmail.com>
From: Mike Galbraith <umgwanakikbuti@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>, cocci@systeme.lip6.fr,
        Julia
 Lawall <julia.lawall@lip6.fr>
Date: Sun, 14 Jun 2020 08:23:23 +0200
In-Reply-To: <b14e6d1d-afa0-5c28-547a-9bb1a987f6fd@infradead.org>
References: <b14e6d1d-afa0-5c28-547a-9bb1a987f6fd@infradead.org>
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 14 Jun 2020 09:26:13 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 14 Jun 2020 08:23:25 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Sun, 14 Jun 2020 09:26:11 +0200
Subject: Re: [Cocci] coccinelle issues
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

On Sat, 2020-06-13 at 21:07 -0700, Randy Dunlap wrote:
> Hi,
> 
> OK, I've not used Coccinelle and now I am trying to use it.

I've never used it either, or intend to really, but seeing that it
lives on github and more importantly, it's raining outside....

> It seems that I am having a few issues.
> The primary one is when I run spatch (via 'make coccicheck' in
> the kernel source tree), it tells me:
> 
> Python error: No module named coccilib.elems
> 
> I do see "elems.py" in /usr/local/lib64/coccinelle/python/coccilib.
> 
> I am using coccinelle-master downloaded from github on
> Friday June 12, 2020.

I didn't download, rather pulled/built.  I didn't have the same issue
you did, but make coccicheck was a bust here until I backed down to
version 1.0.6.  Neither HEAD, 1.0.8 or 1.0.7 ran, and following its
MODE=blah suggestion helped not at all.

No idea if 1.0.6 will work for you, but it did for me, and doesn't take
long at all to build once you get the ocaml goop it wants installed.

Hohum, now to whack all that, and find something else to do ;-)

	-Mike
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
