Return-Path: <SRS0=ZWNV=TY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979D6C072B5
	for <cocci@archiver.kernel.org>; Fri, 24 May 2019 19:37:40 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 339A220863
	for <cocci@archiver.kernel.org>; Fri, 24 May 2019 19:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwp6f9/V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 339A220863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4OJbSKj022285;
	Fri, 24 May 2019 21:37:28 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 50CAE7752;
	Fri, 24 May 2019 21:37:28 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E8FD57747
 for <cocci@systeme.lip6.fr>; Fri, 24 May 2019 21:37:25 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4OJbPBj025195
 for <cocci@systeme.lip6.fr>; Fri, 24 May 2019 21:37:25 +0200 (CEST)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com
 [209.85.210.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1D77C20863
 for <cocci@systeme.lip6.fr>; Fri, 24 May 2019 19:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1558726644;
 bh=G2t0WZcZXxWXpP9DMPxLbS7qtZZA4kPdSYJT28u2H54=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=jwp6f9/VKF01TxtrPE2S/pRCfN/Pw6LVY42pvc/MFzT3naxPpOMzbm2N3lSr23L+x
 EXINZgpZJSlGijHKEurnLQUhfBF7z16xbgY755/GkSdYVpZHbWmpbkzvTWWiKL3piI
 UtcrGIFLFB1Hj6NTAnggdjJX3PjrXIjwe8ulgwgI=
Received: by mail-ot1-f50.google.com with SMTP id s19so9725566otq.5
 for <cocci@systeme.lip6.fr>; Fri, 24 May 2019 12:37:24 -0700 (PDT)
X-Gm-Message-State: APjAAAXW4MDX3G7o1IpzCllbGo6vLE+tuJyqMECSjXfr5hKndhun48MJ
 2tkMQh53Si+Atcf0ktIhvyGKQIUlFn4kzEUeQAA=
X-Google-Smtp-Source: APXvYqya6rDkNCZS8ew208HMtNd4QDrCZB7B8AvDHA+kzu0NUI/P7v71pXk414hu/+JHXx6YitUVl+EoTBaGX/ZgD1M=
X-Received: by 2002:a9d:4d0c:: with SMTP id n12mr28532068otf.305.1558726643521; 
 Fri, 24 May 2019 12:37:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAOZdJXWVyC3o6vVbNEakhr8p4vX4j3wkkSyJg77-hcQ7Nqhf=g@mail.gmail.com>
In-Reply-To: <CAOZdJXWVyC3o6vVbNEakhr8p4vX4j3wkkSyJg77-hcQ7Nqhf=g@mail.gmail.com>
From: Timur Tabi <timur@kernel.org>
Date: Fri, 24 May 2019 14:36:46 -0500
X-Gmail-Original-Message-ID: <CAOZdJXWja4mBf-gKSZ-HQaPs3c3x1ur2=BgPh6MnPx+eN7EgYQ@mail.gmail.com>
Message-ID: <CAOZdJXWja4mBf-gKSZ-HQaPs3c3x1ur2=BgPh6MnPx+eN7EgYQ@mail.gmail.com>
To: Timur Tabi <timur@kernel.org>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 24 May 2019 21:37:28 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 24 May 2019 21:37:25 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] How to concatenate identifier with text?
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

On Fri, May 24, 2019 at 2:13 PM Timur Tabi <timur@kernel.org> wrote:

> void myfunc(int x)
> {
>     goto myfunc_exit;
> }
>
> My problem is that cocci takes "func_exit" literally.  I tried
> func##_exit, but that didn't work.  How do I make this work?

I figured it out:

@@
identifier func;
fresh identifier label = func ## "_exit";
@@
func(...) {
<+...
+    goto label;
...+>
}
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
