Return-Path: <SRS0=yQoC=73=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9C7C433E0
	for <cocci@archiver.kernel.org>; Sun, 14 Jun 2020 08:41:29 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD9C020714
	for <cocci@archiver.kernel.org>; Sun, 14 Jun 2020 08:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXJgNqwO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD9C020714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05E8fPq5013252;
	Sun, 14 Jun 2020 10:41:25 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id EC62B7760;
	Sun, 14 Jun 2020 10:41:24 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id EC60944A7
 for <cocci@systeme.lip6.fr>; Sun, 14 Jun 2020 09:57:14 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:436])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05E7vESC014518
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 14 Jun 2020 09:57:14 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id y17so13938339wrn.11
 for <cocci@systeme.lip6.fr>; Sun, 14 Jun 2020 00:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ejrmKJ5suA/ul60ZWwfCzRoEO6jjBQQw/DSkq2qPsS4=;
 b=YXJgNqwOInbHitvNHON9xaHgHUDXwm/aQTV9HHw/83zizwiNh7XA3dPvMHywmz8PV4
 /1iXjjEzL9Mt+X2eiDRH2dzZcI/2NgMBMmPCTtba49ryFe1YdM4Vie5qTYHp85FHBh4G
 JJFDcaNBBkSXqAES57OsxkoTKRFJTFhgp4j3RX2KgLM+m9NQzxfgjXORqUTCI4yNdZSk
 1afCLl+qh0Sg5s82dSIolnl9OX0gnlmoMuS6FIPDoEAtikHMt/E1N1++B6pp9merrRMa
 kdlW107k0Lk9eM6hc7i1gfYWgaCO/VMqLRqGKblVAgPyO5O0ye3vS3Zqq6NZKGTD37Aw
 X7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ejrmKJ5suA/ul60ZWwfCzRoEO6jjBQQw/DSkq2qPsS4=;
 b=SXSDDK7HfMfh5ioTp3hko8mgWuh7Sha0sjrDDCeMrWRNcEikGlrJVIlD+IRf/Q/Lnk
 w/wlbucTPSlfLNFzfZ76fKUJ1gcftzj6iSyq3KuZvwSrQVgepqoeDD+WtYS5YtukzP+6
 3sqnwTAWok7lzDKN5VnvyzVvX22rn1aeTA93VHo4ib7C3k4P5m5u7pg4uvc9YA/q9Z+x
 DcPRnjXcus+J5ast+SMoG2S3zFpHWDPiFuC8yee/13QZbsz+lIEn5PzXhGwG+Tx/P7ao
 zYRaD0kj1s+PAmr8rr9oiJ16cswgCrT1bRVhcN82LvllzjS5hAGQK3AC+0RI1aNqpyU7
 7h0w==
X-Gm-Message-State: AOAM530faPWrqhhNvM0NwTF3/PPSPuauGlei9PKUXvI365dIDH7UEnxG
 0xg+GEDkNe6/DCzNjO+cpaI=
X-Google-Smtp-Source: ABdhPJwHnlAsDLBHiGuH1Qn/AgsI6W+spLHPAMlj06Rz4b8jfcaSvoMjSsHOEDK5+LMdaYJJ6VkGrw==
X-Received: by 2002:adf:e40c:: with SMTP id g12mr23383263wrm.121.1592121434337; 
 Sun, 14 Jun 2020 00:57:14 -0700 (PDT)
Received: from homer.simpson.net ([185.221.151.23])
 by smtp.googlemail.com with ESMTPSA id n204sm17921853wma.5.2020.06.14.00.57.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2020 00:57:13 -0700 (PDT)
Message-ID: <1592121432.2129.9.camel@gmail.com>
From: Mike Galbraith <umgwanakikbuti@gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Sun, 14 Jun 2020 09:57:12 +0200
In-Reply-To: <alpine.DEB.2.22.394.2006140940000.2849@hadrien>
References: <b14e6d1d-afa0-5c28-547a-9bb1a987f6fd@infradead.org>
 <1592115803.27290.33.camel@gmail.com>
 <alpine.DEB.2.22.394.2006140940000.2849@hadrien>
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 14 Jun 2020 10:41:25 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 14 Jun 2020 09:57:14 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Sun, 14 Jun 2020 10:41:23 +0200
Cc: Randy Dunlap <rdunlap@infradead.org>, cocci@systeme.lip6.fr
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

On Sun, 2020-06-14 at 09:42 +0200, Julia Lawall wrote:
> 
> On Sun, 14 Jun 2020, Mike Galbraith wrote:
> 
> 
> > I didn't download, rather pulled/built.  I didn't have the same issue
> > you did, but make coccicheck was a bust here until I backed down to
> > version 1.0.6.  Neither HEAD, 1.0.8 or 1.0.7 ran, and following its
> > MODE=blah suggestion helped not at all.
> 
> Did you get a segmentation fault?

Nope.  Turned out to be a dinky install gotcha.  Creating a symlink..

lrwxrwxrwx 1 root root 27 Jun 14 09:40 /usr/local/coccinelle/lib -> /usr/local/coccinelle/lib64

..seems to have fixed 1.0.8 all up.  The very first time I installed, I
had to create one directory (forget which) by hand as well.

	-Mike
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
