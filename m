Return-Path: <SRS0=bJsz=6M=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4CCC83001
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 17:41:37 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32376208E0
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 17:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cilium-io.20150623.gappssmtp.com header.i=@cilium-io.20150623.gappssmtp.com header.b="dbaa97wu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32376208E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cilium.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03SHfKxm021705;
	Tue, 28 Apr 2020 19:41:20 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E3DF37807;
	Tue, 28 Apr 2020 19:41:19 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id DF2F03DC8
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 12:11:27 +0200 (CEST)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:342])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03SABQQc000593
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 12:11:27 +0200 (CEST)
Received: by mail-wm1-x342.google.com with SMTP id v4so1960039wme.1
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 03:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cilium-io.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=M6eJ2Sj6KOyIhQF5x8kDPYk3Z2UkxiYJo6iUr1+aHSM=;
 b=dbaa97wuNUCYCaGK++fFiHgmC2ElK01eG1AJ7nSMO/Po5JvlxHS8kistCK4emKGf6S
 RCKUQFDaWqs85ADc8GTCzasFA9xTGxwtdKOuqovosfFOLHcRcwlyY8xYK69ggWmRa5im
 tEpNIZSB9N4I5wOnsT2BmGdW26gezCsYW+QINpY4wdEGbg9Ctdn2nkucnNJs1/xdlQ23
 edh1bpcGIUKPu4dq73uIanMC7imxYficqYCFXrldUVphEEWGJViNFKcjDCC+ft/kWv/d
 Jid7zacO0z4alGmQmhFSRukAvGfOtdA6YT4GlU2UzUGdT9F1589qaNqsFHBa7zTdXk4Q
 uo3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=M6eJ2Sj6KOyIhQF5x8kDPYk3Z2UkxiYJo6iUr1+aHSM=;
 b=fAKYGWobZK6R4KPRVBzG+qnuckQcnSiOul0qkgprW7a7dTupAt1aTZvt0+K1CDTIdU
 hlcfu3kn/dziT88GlYh76A3twhNraw62OoSPkS5chuxxmr49z3j8MfXBUDs30kuJGNL0
 cOJyNU+7txi+gzB+p3z+ZVr+ZLxzKVDpFQXBfFAi7imTUKDLK1lW+V9jRrN6RN/UGkYs
 T+no2g/B5Uvy3b1CYSUir/7e88ea2RYmGoZEaZfFvec5V3qOWO9GRAXfBbkn/3JSwx4V
 qmArT3KpPx7bYOhLbMDkAe6nM/2IuB2O3Y74TyxeJPs2KkJecIuxRT8QqGp7yNLMJJCT
 lfEQ==
X-Gm-Message-State: AGi0PuYzzKZX9sVGf7Unb9lPj859A5piiPSiGUFmbhZsafwlcLY1k0bA
 e2zA7t3PA0m5NCldrNq5JSmc
X-Google-Smtp-Source: APiQypKrsn4rhRV0RR3JB/WrTLoY1ogNadAie1h5mQ+2YR4s9w4M5OrzUMfXiHaD7C25K2Ay6/2I9Q==
X-Received: by 2002:a1c:2dc7:: with SMTP id t190mr3529546wmt.129.1588068686755; 
 Tue, 28 Apr 2020 03:11:26 -0700 (PDT)
Received: from Mem ([145.136.49.157])
 by smtp.gmail.com with ESMTPSA id y40sm26567462wrd.20.2020.04.28.03.11.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 03:11:26 -0700 (PDT)
Date: Tue, 28 Apr 2020 12:11:25 +0200
From: Paul Chaignon <paul@cilium.io>
To: cocci@systeme.lip6.fr
Message-ID: <20200428101124.GA18321@Mem>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 28 Apr 2020 19:41:20 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 28 Apr 2020 12:11:27 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Tue, 28 Apr 2020 19:41:18 +0200
Cc: paul.chaignon@gmail.com
Subject: [Cocci] Using a macro for variable attributes
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

Hi all,

I am working on a small semantic patch to annotate specific variables in
our codebase with __attribute__((aligned(8))). The following program works
fine.

  @r@
  expression e1, e2;
  identifier x;
  @@
  (
    struct \(icmphdr\|icmp6hdr\) x
  + __attribute__((aligned(8)))
    ;
  |
    struct \(icmphdr\|icmp6hdr\) x
  + __attribute__((aligned(8)))
    = ...;
  )
    ... when exists
    ctx_load_bytes(e1, e2, &x, ...)

However, when I replace __attribute__((aligned(8))) with our internal
macro __align_stack_8, it fails with the following error:

  plus: parse error:
    File "/home/paul/cilium/contrib/coccinelle/aligned.cocci", line 7, column 2, charpos = 77
    around = '__align_stack_8',
    whole content = + __align_stack_8

I've tried adding '#define __align_stack_8' in a file passed with
--macro-file, without success. Is this a known limitation for macros or
am I missing something?

Thanks,
Paul
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
