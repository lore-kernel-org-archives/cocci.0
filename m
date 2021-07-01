Return-Path: <SRS0=594F=ME=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F2DC07E99
	for <cocci@archiver.kernel.org>; Mon, 12 Jul 2021 08:47:09 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57C7A61006
	for <cocci@archiver.kernel.org>; Mon, 12 Jul 2021 08:47:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57C7A61006
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 16C8l4KV026821;
	Mon, 12 Jul 2021 10:47:04 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id EFCFC776E;
	Mon, 12 Jul 2021 10:47:03 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3106B3FE7
 for <cocci@systeme.lip6.fr>; Mon, 12 Jul 2021 10:47:02 +0200 (CEST)
Received: from mail.zx2c4.com (mail.zx2c4.com [104.131.123.232])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 16C8l0Ml020171
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 12 Jul 2021 10:47:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105; 
 t=1625148058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1XU5W9Hv8QC05Kv7GHUyRXP19OBBrfP8IZdKfcKJoEI=;
 b=f30uiiWL4SQaIQfatFAscd5gjwlKX38U9bjuod6svsdokXSs7FXRoRN2ss1/XX+JLG7VQq
 P07FO4dtZGMDbzf5/JNFNgJBd7efgXLsoIiXmK/hgCrqEAThlplHcYuEcfxV4JMWHCdIfU
 4daS9uAxV3vJQF6tK/dk7J/LwwTnCUw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 071b0854
 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO) for <cocci@systeme.lip6.fr>;
 Thu, 1 Jul 2021 14:00:58 +0000 (UTC)
Received: by mail-yb1-f175.google.com with SMTP id o139so10962284ybg.9
 for <cocci@systeme.lip6.fr>; Thu, 01 Jul 2021 07:00:57 -0700 (PDT)
X-Gm-Message-State: AOAM532vmf7FLDzrZbqrfmlKpGPPmj3Rx8eaMapdGP4+EfIAv1hwBEzk
 TbHCnLn4vgSQQmod7007LZ1ljOi+ANs1aisAz/U=
X-Google-Smtp-Source: ABdhPJzHm2xKWzV/kVvA+2Bb5MQbgL0FILEi0hhOiVkSImkG5eVib3hrfOcEijLheRK688gCJHTb+Au3QE9DkjMqkDA=
X-Received: by 2002:a25:acde:: with SMTP id x30mr10545413ybd.123.1625148057344; 
 Thu, 01 Jul 2021 07:00:57 -0700 (PDT)
MIME-Version: 1.0
References: <471a429f-76aa-44af-19d4-10f53992866d@johannesthoma.com>
In-Reply-To: <471a429f-76aa-44af-19d4-10f53992866d@johannesthoma.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Thu, 1 Jul 2021 16:00:45 +0200
X-Gmail-Original-Message-ID: <CAHmME9rsyz8ntO9K8Kc7jxLP6zZcB1xHgXPp+gf5bi27zXBj8Q@mail.gmail.com>
Message-ID: <CAHmME9rsyz8ntO9K8Kc7jxLP6zZcB1xHgXPp+gf5bi27zXBj8Q@mail.gmail.com>
To: johannes@johannesthoma.com
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 12 Jul 2021 10:47:04 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 12 Jul 2021 10:47:01 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, Philipp Reisner <philipp.reisner@linbit.com>
Subject: Re: [Cocci] wireguard project looking for coccinelles to assist
 with Linux->NT conversion (WinDRBD)
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

Hi Johannes,

On Thu, Jul 1, 2021 at 3:42 PM Johannes Thoma
<johannes@johannesthoma.com> wrote:
> The approach we use attempts to minimize patches to the original
> source code and use a compatibility layer to map the Linux
> interfaces (and behaviour) to the Windows NT interfaces (and
> behaviour). Since we use Microsoft's C compiler to build the
> project we need to patch some compiler specific things (like
> MS C does not know gcc's typeof)
> My advice would be to keep the compat.h header (and related
> files) so that the changes to the Linux sources are kept
> at a minimum.

I have no desire nor plans to do this at all in any way, shape, or
form. The compat.h header is going away, and the whole project will be
transformed into native NT code, without Linuxisms. That is why I sent
the email to the cocci mailing list -- because we're going to
transform every inch of the code base. The goal is to have a totally
separate development path, to intentionally allow the implementations
to diverge and integrate well with the unique kernel paradigms of each
respective kernel. We've done that throughout the project - to
OpenBSD, FreeBSD, Userspace in two languages, and now to NT. In each
place, we prefer native implementations that make use of native
runtime facilities. We even take that approach with UIs, using native
OS toolkits, rather than trying to use something like Qt or Electron.
So, the compat.h stuff is definitely going away.

With that said, it looks like you've built up an impressive
translation layer! (FYI, from brief perusal it looks like your RCU
implementation has some issues; I'll send you a link to mine when it's
ready -- it's fully lockless like Linux's. And your get_random_bytes
looks like a security vulnerability. We can talk about NT-specific
stuff offlist though.)

Jason
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
