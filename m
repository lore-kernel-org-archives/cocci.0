Return-Path: <SRS0=82Xq=HP=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC51C433E0
	for <cocci@archiver.kernel.org>; Sat, 13 Feb 2021 21:38:33 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2034164E29
	for <cocci@archiver.kernel.org>; Sat, 13 Feb 2021 21:38:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2034164E29
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 11DLc7Cm017219;
	Sat, 13 Feb 2021 22:38:07 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A62A077E2;
	Sat, 13 Feb 2021 22:38:07 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id CE89724DD
 for <cocci@systeme.lip6.fr>; Sat, 13 Feb 2021 22:23:28 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:72d])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 11DLNRWs007629
 for <cocci@systeme.lip6.fr>; Sat, 13 Feb 2021 22:23:27 +0100 (CET)
Received: by mail-qk1-x72d.google.com with SMTP id w19so3075188qki.13
 for <cocci@systeme.lip6.fr>; Sat, 13 Feb 2021 13:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=+8agD4NEJjhqvnSlMNk/HZ1/kpOl/xG4gk2GwQViNJg=;
 b=0By5OheH0/1s9ZMQUGIKxlCkkVWdGDT28YwWhBFrK9Tz41iyX/50QpFxYitlgovEa+
 uWISQgZnb1jBX63hBVl4YJNtC6XQNX0TL9V43mcgofUBiek4jq2bIUBYWG06Oez1O7Ax
 jGP1PDoIUmEKyCw3UxIaZNa4QWJlu7+zgIyJrlit9XQhZzCIqihZ5UF/vBhOSEczsJU6
 /VCiDr0VSJp0wYIGA0bfLOX627rcoG7i3kFOzPNZ7dJH6JpH61f+2oMR8S2+NEx+UrHc
 iH4IHU5AixintcVsH/5l16Werlirt3j9z7Xm5PS0x5I7qBBnATvdq3+TdB71VuJ+Vrnn
 Ca4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+8agD4NEJjhqvnSlMNk/HZ1/kpOl/xG4gk2GwQViNJg=;
 b=aFfISCg69vu8fPNpSuLthiPruQZeMr0Zm0fXba7RyidR/OxTXAtIb8cN5BVN43bj2z
 VSzX0w2ftlzydmmas5Yf9UrK6Q2dQ8O/q2sepBTAzmsYDrkrOM1BJ6azivQqG4+Z74OU
 wAylMkudU576f9doIt1BftrtNTp5H03gzB1qwCmuefU5sOZCTWqWy0Nza3S55KWwPvcv
 Cn5zxx/ky67JRgMuyihSJgYvuOqbbaYHkPyA7URPnKRykc8cMnV1CFvNYqcnUZOBmz6Z
 GhXlZct08CoiC+mIYIBUbszJGNAWx8FFJBql7U5HAjX/alyuS1ex54NxklovsoKhzZtT
 avjw==
X-Gm-Message-State: AOAM532hdQ8Z/zbfK02bsl8cZoBKGpY4hia30h4SYc31OulVwxFQQsII
 vELzj9mPGowahBqq8nIcEJCYTQ==
X-Google-Smtp-Source: ABdhPJy9CmPiikBDItuNxIehWZmYehkwpaHppD/sd+fhY3CEUwVBjxyCFtry6nNrEXGgqrr4i7WRFw==
X-Received: by 2002:a37:4d93:: with SMTP id a141mr8806358qkb.332.1613251407070; 
 Sat, 13 Feb 2021 13:23:27 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:b44a:999a:5914:71f7])
 by smtp.gmail.com with ESMTPSA id h6sm8983681qkf.96.2021.02.13.13.23.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Feb 2021 13:23:26 -0800 (PST)
Date: Sat, 13 Feb 2021 16:23:22 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Julia Lawall <julia.lawall@inria.fr>
Message-ID: <YChDSqSeMgNAAbDJ@nand.local>
References: <YCKi4Ca0RbcfZLRB@nand.local>
 <alpine.DEB.2.22.394.2102121506050.9350@hadrien>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2102121506050.9350@hadrien>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 13 Feb 2021 22:38:07 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sat, 13 Feb 2021 22:23:27 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Sat, 13 Feb 2021 22:38:04 +0100
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Missing package for Ubuntu 20.04 LTS?
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

Hi Julia,

On Fri, Feb 12, 2021 at 03:06:16PM +0100, Julia Lawall wrote:
> > Is there a planned release of coccinelle that will appear in the focal
> > suite?
>
> Can you use the PPA?
>
> https://launchpad.net/~npalix/+archive/ubuntu/coccinelle

Yes, we could. But it's an extra step that all users of Ubuntu Focal
will have to take. Note that 20.04 is the image that all users of
GitHub Actions' "runs-on: ubuntu-latest" get, so anybody in that group
who wants to use coccinelle will have to configure and install from the
PPA.

Is there a reason that 20.04 was skipped when preparing a release for
the official suites?

Thanks,
Taylor
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
