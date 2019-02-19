Return-Path: <SRS0=aura=Q2=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAC1C43381
	for <cocci@archiver.kernel.org>; Tue, 19 Feb 2019 04:47:25 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72FA0217D7
	for <cocci@archiver.kernel.org>; Tue, 19 Feb 2019 04:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibsgaard-io.20150623.gappssmtp.com header.i=@ibsgaard-io.20150623.gappssmtp.com header.b="DPN0TWA3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72FA0217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ibsgaard.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1J4ktIg000610
          ; Tue, 19 Feb 2019 05:46:55 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5DF2976FB;
	Tue, 19 Feb 2019 05:46:55 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D75D676F9
 for <cocci@systeme.lip6.fr>; Tue, 19 Feb 2019 05:46:53 +0100 (CET)
Received: from mail-it1-x134.google.com (mail-it1-x134.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:134] (may be forged))
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1J4kqaw003228
 for <cocci@systeme.lip6.fr>; Tue, 19 Feb 2019 05:46:52 +0100 (CET)
X-pt: isis.lip6.fr
Received: by mail-it1-x134.google.com with SMTP id v72so3328935itc.0
 for <cocci@systeme.lip6.fr>; Mon, 18 Feb 2019 20:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ibsgaard-io.20150623.gappssmtp.com; s=20150623;
 h=mime-version:from:date:message-id:subject:to;
 bh=+b1V/t2ZcQeUsJYsUcmPrJ+aDz3cWyNzbJi8jD68pM0=;
 b=DPN0TWA3BXWtzJL7hRIa4Gm9WEYEPTmbgFnq6+Xypi7u+laiN3WEubvQEDOcf4U37k
 xYIbrPrVVFpOJoIZSiS37JTmbjMls5w+gTOLZ/pGOFMk8aBB8jAQv5HA/tXMh0GrBHiF
 KOvFVDipwBxs6YXWvvmTwlBrgjj9Bw17uN5mGe+/cFNRtq/5OC9eAj75xFdM2Q3aBnY3
 QUA0aZnneFoFWs311z1vOwbKfC3tjk4Qgg/UZ1GXn9/4BAs2/hKGhCxb5iq3P1fzRTgW
 Tu4TnUKZAvhZ/+fMNUslIm+/XvntQXeHYhG5u1G+ENuzgBGi4hc6W/r4VWRjmJ2upNxQ
 btaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=+b1V/t2ZcQeUsJYsUcmPrJ+aDz3cWyNzbJi8jD68pM0=;
 b=tT7e+Vfa7E/LT/eKoKGHkBU6R8051V/nfBpQjv4xwnljOJXb+1iVovXGaZTS8VBSGJ
 2cNoGEcvJ1PocEOjZcs95uTteGfarYMR3bbA45IVbzh9O2Oz2K4XJ7MpEBy5Zl3+cJcJ
 jf7XyNTsIHpv5Z305FTcegzprun8hYMIwoZfB9TB0zKhXnzCBO3yOX1RiIw3e7Odvbro
 Cb8rnkCkpqyeui+RUhN2WLtFAhEcMpvNRT2znR6er2eWc3PG1dY0xnOZSkrIrdvJ34fI
 PxVY2D/7fFZ/vcdWNPH1L2ieHW+int60pNogHxzO5Uhs6kGMyHk3h+i6lAyo9gHdTLVh
 HCNQ==
X-Gm-Message-State: AHQUAuZcy/LGlH0Pzj2nkZbvdUH2USowBNEDg/vuY5QHXFOuTomJ6ky3
 gMlMXwhnzhAGIl5wd6ckK4zy+dQfHBEg2uKceuA79VYi6w0=
X-Google-Smtp-Source: AHgI3IaWjYFfQPy+2ZtsbZ5dmp88gAyHtqfMH00VIkhCYvis49gaBl8y8bA5EUq6Yk2Ki/fge3y6DVZU5pKG0a+rPCM=
X-Received: by 2002:a5e:9412:: with SMTP id q18mr15257929ioj.233.1550541722281; 
 Mon, 18 Feb 2019 18:02:02 -0800 (PST)
MIME-Version: 1.0
From: thomas pedersen <thomas@ibsgaard.io>
Date: Mon, 18 Feb 2019 18:01:51 -0800
Message-ID: <CABWD38=R3aZDpEvRTc-aidKuQ9QT1BhfN+h7Zo_PLu2SgvdBmw@mail.gmail.com>
To: cocci@systeme.lip6.fr
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 19 Feb 2019 05:46:56 +0100 (CET)
X-Greylist: Delayed for 02:39:22 by milter-greylist-4.4.3 (isis.lip6.fr
 [IPv6:2001:660:3302:283c:0:0:0:2]); Tue, 19 Feb 2019 05:46:52 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: [Cocci] SmPL patch against C macro
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

Hello,

I'm trying to write an SmPL patch which will modify C macro. The test files are:

# test_macro.c
#define MYMACRO(adsf) { \
        .foo = (asdf),\
}

# test_macro.cocci
@@
expression E;
@@

{
.foo = E
+ * 1000
}

Running with:
$ spatch --debug --sp-file test_macro.cocci test_macro.c

Gives the output:
Unsupported form of #define: File "test_macro.c", line 1

What's the correct syntax to match against a similar macro?

Thanks,
Thomas
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
