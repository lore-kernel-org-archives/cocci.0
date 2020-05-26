Return-Path: <SRS0=3aZu=7I=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8399DC433DF
	for <cocci@archiver.kernel.org>; Tue, 26 May 2020 01:22:05 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9666F206D5
	for <cocci@archiver.kernel.org>; Tue, 26 May 2020 01:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=xteddy-org.20150623.gappssmtp.com header.i=@xteddy-org.20150623.gappssmtp.com header.b="EYnbajpO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9666F206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xteddy.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04Q1M0Xr011968;
	Tue, 26 May 2020 03:22:00 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A57C27783;
	Tue, 26 May 2020 03:22:00 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0A8D03E1D
 for <cocci@systeme.lip6.fr>; Tue, 26 May 2020 03:21:59 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:433])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04Q1LwSg011558
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 26 May 2020 03:21:58 +0200 (CEST)
Received: by mail-wr1-x433.google.com with SMTP id l11so18827420wru.0
 for <cocci@systeme.lip6.fr>; Mon, 25 May 2020 18:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xteddy-org.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yeko01jck5Mfh0IDTQJVRa3Oq2v7QaDOPoQrIvHPHFU=;
 b=EYnbajpOh5cYTLMq5Yf9L7zf90f+p2cdFz9t33HaFhJGkge3KOWWv/VYegrlbkArkU
 9w8UFMQ9dXAveRiWMQf7q0GOQxESwEe/+ryuS5izdDNto3x+dCQlb05UxEVRsZyWwOpE
 GfijhmfO6RiUqXWrf6xJGrp6unRz/Ut8+EvD7tuUzXWcg/tm3zRcb6mIGOII5VFcz2oA
 5V/BJREDBY/hTg0rNHmzhZo7m3vuXvbDM9plion/S3hLOXzzhIpkMNXsme0wUw2NvVlv
 Hfppnakru5INEXCUBQNnhTSUXFJOfLKWw/r9MoBt7p1HwcEmeMJQ8K6EVDGuELe83WQo
 Oz0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yeko01jck5Mfh0IDTQJVRa3Oq2v7QaDOPoQrIvHPHFU=;
 b=APBxczti6eydvhc+t4vuDQgFBUbaMWeXQZ+kzMIfo8O7/6HjiLiU7MlT/ZED045ODu
 zay6/pEI7X3N1W9A7+5vIQQwtjV1WfYlybmIxB0/ZbF9Cyhs3AJ5rtlfbrgaVE8Dawiq
 oxTXq6JLYSODeePi5Qeh/E2qM4RmiMgUPELpTGpzRe/TVMfRUh2d/SYikrwmhiShroQQ
 T+WkpYHEgmY5uyFeV3+sc1tka+rz9798Iv8VfhHuW5EPYWKD0yLO5AGR4zneVpGmB4NO
 liOXC4vo2AQKNcho1dWgUw3yntnqrV6SWhawvHfJLx0sAcBtmjXPP5r5Mr4fdnjUECyF
 uLOQ==
X-Gm-Message-State: AOAM532SJmyjkmE5ng6PVqbabm+gbvkTd6J6GBfSFctD0bBDNEB0ArE7
 YFBxDBKBBIofuokSHfRGcSuUF9Jz/tuXo46iPMp7RA==
X-Google-Smtp-Source: ABdhPJz0e/TS4V1gWJMu3/jNETtjZO6vLF0FDbfZjv5QGgyRSC2fNZwuX50yxE47ufJZZBT30weeO5qCH4yonp95wsI=
X-Received: by 2002:a5d:6802:: with SMTP id w2mr17676218wru.68.1590456118051; 
 Mon, 25 May 2020 18:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <24b3f013-21e4-99e8-5366-cfc944077cc2@web.de>
In-Reply-To: <24b3f013-21e4-99e8-5366-cfc944077cc2@web.de>
From: Thomas Adam <thomas@xteddy.org>
Date: Tue, 26 May 2020 02:21:47 +0100
Message-ID: <CAOhcEPY8r2fjJmJP4A6ZzFdhTGJB=RYVcVt8k6KV9EaMzc_oSQ@mail.gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 26 May 2020 03:22:01 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 26 May 2020 03:21:58 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Using SmPL scripts to mangle function arguments
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

On Sun, 17 May 2020 at 10:22, Markus Elfring <Markus.Elfring@web.de> wrote:
> Generally, yes.
>
> A more complete source code transformation approach can become challenging.

So I've decided to try and take a different approach, and have
rethrough the function interface.

Rather than try and modify the arguments in the way I was, I think it
makes sense to largely keep the existing function signatures.

So for example, currently there is:

func_old(int level, const char *func, const char *fmt, ...);

What I'm after here is to modify func_old, such that I drop the "int
level" parameter, and change the *func occurrences to "__func__", and
drag the variadic arguments with the transformation, hence, I'd like
func_old to now look like:

func_old(const char *func, const char *fmt, ...);

So what was once:

func_old(ERR, "MyFunction", "%s: hello: %d, %d", myvar, x, y);

Should now be:

func_old(__func__,  "%s: hello: %d, %d", myvar, x, y);

I'm having trouble expressing my smPL to understand the ellipses
correctly.  Here's what I have so far:

@@
expression L, F;
@@

- func_old(L, F, ...);
+ func_old(__func_, ...);

... but here, things fall apart:

init_defs_builtins: /usr/bin/../lib/coccinelle/standard.h
File "contrib/coccinelle/remove_debug.cocci", line 6, column 21, charpos = 68
  around = '...',
  whole content = + func_old(__func__, ...);

Any ideas on what I'm doing wrong?  If there's appropriate
documentation on this, please feel free to point me toward it.  I feel
as though I'm missing something obvious here, so thanks for your time
and for any help you can give.

-- Thomas
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
