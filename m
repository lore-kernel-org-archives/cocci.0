Return-Path: <SRS0=VPYo=LZ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310BDC11F64
	for <cocci@archiver.kernel.org>; Thu,  1 Jul 2021 12:31:54 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6342E613FE
	for <cocci@archiver.kernel.org>; Thu,  1 Jul 2021 12:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6342E613FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 161CVnWX018306;
	Thu, 1 Jul 2021 14:31:49 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E76EA7610;
	Thu,  1 Jul 2021 14:31:48 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D4DAC4065
 for <cocci@systeme.lip6.fr>; Thu,  1 Jul 2021 14:31:46 +0200 (CEST)
Received: from soleil.uvsq.fr (soleil.ipv6.uvsq.fr
 [IPv6:2001:660:300f:0:0:0:0:1])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 161CViWI003049
 for <cocci@systeme.lip6.fr>; Thu, 1 Jul 2021 14:31:44 +0200 (CEST)
Received: from mail.zx2c4.com (mail.zx2c4.com [104.131.123.232])
 by soleil.uvsq.fr (8.15.2/jtpda-5.4) with ESMTP id 161CVaSH020177
 for <cocci@systeme.lip6.fr>; Thu, 1 Jul 2021 14:31:42 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at soleil.uvsq.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105; 
 t=1625136306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=nJ7zmrJIpOFl4/dRB74jrchNLyo6sI1D7CYfIPUZ1OA=;
 b=g25YmUHJyQCTPRSzMTG/mH9+pMQ69CBAjsucgf4EKmyCsSJ/fm/AQB2S2u0k2MV/eBz6vB
 IAlOaMU9c5YxoeGsUcdUiyvQJYdkq/ivEQuj4WMrT/ZPEyzlU2akK/9+UgV7hftTfyk5zy
 jvWjMTB+4wGrvKPE0btFeoqNVmOrvbs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1840e6c9
 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO) for <cocci@systeme.lip6.fr>;
 Thu, 1 Jul 2021 10:45:06 +0000 (UTC)
Received: by mail-yb1-f180.google.com with SMTP id m9so10081651ybp.8
 for <cocci@systeme.lip6.fr>; Thu, 01 Jul 2021 03:45:06 -0700 (PDT)
X-Gm-Message-State: AOAM533m3huGHgoerMnkvDuyHlIIoxHV4pz8GuRwKiP+OJOQb63pAc5R
 2jenQ0aUEZtA/Q0YY5yBETz3Rt2aAazC9Lxnhjs=
X-Google-Smtp-Source: ABdhPJzwQkmigMkU0/exO//xTb1koN/sDnmXuuYt8nToLieUExZvUV/lC/qBaLCCSh4ms5xWlMdLC3XphVGbVe1zHPU=
X-Received: by 2002:a25:dc4f:: with SMTP id y76mr2385049ybe.49.1625136305920; 
 Thu, 01 Jul 2021 03:45:05 -0700 (PDT)
MIME-Version: 1.0
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Thu, 1 Jul 2021 12:44:55 +0200
X-Gmail-Original-Message-ID: <CAHmME9qXRpU6iDLDVE9gWv61aMOB7k+VGd_5k2jtZrdR1Ae4Xw@mail.gmail.com>
Message-ID: <CAHmME9qXRpU6iDLDVE9gWv61aMOB7k+VGd_5k2jtZrdR1Ae4Xw@mail.gmail.com>
To: cocci@systeme.lip6.fr
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 01 Jul 2021 14:31:49 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 01 Jul 2021 14:31:44 +0200 (CEST)
X-Greylist: Delayed for 01:02:48 by milter-greylist-4.6.2 (soleil.uvsq.fr
 [193.51.24.1]); Thu, 01 Jul 2021 14:31:42 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: [Cocci] wireguard project looking for coccinelles to assist with
	Linux->NT conversion
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

Hey list,

I'm in the midst of doing something potentially a bit taboo in these
parts: porting some Linux code to the NT kernel used by Windows.
Specifically, I'm porting wireguard-linux to wireguard-nt. In
evaluating whether to do a clean implementation or a 1:1 port, the
latter was chosen, as implementation fidelity and past security
analysis remains priority, and a simple port seemed like the most
straightforward and efficient way of getting there.

Things have mostly been going along swimmingly. Packets flow now, and
the whole thing basically works. One big part of this effort has been
a humongous "compat.h" file that maps Linuxisms to NTisms -- things
like locks and atomic ops and lists and such. Another big part of the
effort has been rewriting code or reimplementing core functions where
there's not an already available NT facility that has the same
semantics as Linux. For example, I wrote a tiny RCU implementation
recently. And finally some parts are being rearchitected. For example,
while we did reimplement the queue_work_on API initially, we're now
changing how we manage threads in NT anyway, so that's changing.
Anyway, the point is that our porting efforts are working well so far.

But... we still have this compat.h file, and we still have a lot of
code that "looks like" Linux code. At some point (soon, hopefully),
we're going to begin inlining the compat.h transformations, with an
aim of getting rid of compat.h entirely. "Well, duh, just run the
preprocessor on it," I hear some of you say. That works to a degree,
but we're also using things like typedefs, and other tricks, where
that isn't quite clean enough. There will also be some interesting
semantic mapping -- like changing one list API into another list API.
At some point, we'll also approach cosmetic things, changing
variables, struct members, and function names from
lovely_linux_identifiers_like_this into
GrossWindowsIdentifiersLikeThis, and changing `struct reasonable_name
{ ... }` into `typedef struct _TERRIBLE_NAME { ... } TERRIBLE_NAME`,
and things like that, because that's just how things go with NT
programming.

So the plan was to do this carefully by hand and maybe some grotesque
sed oneliners and then hope clang-format cleans it up. But obviously
coccinelle is a better tool for this, and one that would help us avoid
silly errors.

I was wondering if anybody on this list is a bit bored this summer and
wanted to spend a week or two on this. It's perhaps not the most
glamorous work, but it is very interesting -- at least in my
experience so far -- to wrap my mind around NT differences to Linux,
and this has stimulated me to think about some new ideas for Linux. It
also might wind up being a way into some more complex coccinelle use
cases, as I believe that many of the rules will be far from trivial
transformations (otherwise I would have just tackled this project
myself). So, if anyone here is interested, or knows somebody who's
interested, please do reach out.

Thanks,
Jason
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
