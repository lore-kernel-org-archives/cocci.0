Return-Path: <SRS0=02ua=7V=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F5DC433DF
	for <cocci@archiver.kernel.org>; Mon,  8 Jun 2020 15:01:16 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FA6D206C3
	for <cocci@archiver.kernel.org>; Mon,  8 Jun 2020 15:01:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA6D206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 058F1Djm009299;
	Mon, 8 Jun 2020 17:01:13 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 55EFE7783;
	Mon,  8 Jun 2020 17:01:13 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E731344A7
 for <cocci@systeme.lip6.fr>; Mon,  8 Jun 2020 17:01:11 +0200 (CEST)
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com
 [209.85.208.196])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 058F1Bnb011577
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 8 Jun 2020 17:01:11 +0200 (CEST)
Received: by mail-lj1-f196.google.com with SMTP id x18so4417907lji.1
 for <cocci@systeme.lip6.fr>; Mon, 08 Jun 2020 08:01:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=exJpUcD9iTuoeD+RQrF+EIXmGMlhgaTXtJncvvlvAk0=;
 b=YOs11WC1+ZVxm1alJtDpZtb+RhCLwdvPezDf/O4p4mLIb1SeNb8a+VDe5Ck7Bk47ju
 gt/SsfBVfMaJLbLib4PLHGoDswI6efX9DX5NG6EzR45bW+rUoRdqjFPWB/f+Kl7vwSgJ
 lt7p+V9AxIOx/gm4gWy84JbNm8+3fi0lgR+4H6SLb8rVvGTwxGxHNo5dWddkX8Y67VqH
 aNjzA6dmCoEMLc72koM0SqEsmFgXkMI8hdr7xKrepCxwpoeSoNt4SxKDEuNYyRZMjEcV
 M+c8yo4ovPlrIGrP3TtDOIwrnBfzR9tUT3Sk86j/ff6tlVg7CYpkybPAt97UOdbzZlTl
 aPhA==
X-Gm-Message-State: AOAM530mZ/PyXCmJH8d/JNYLdJr2U4QXYBQzwbXTV1IaId8l0VfEFWFa
 Zxp1MBManb1q0s9I6gygwsA=
X-Google-Smtp-Source: ABdhPJyDFsvVJzzCo2+DwICPtXyXHTVNh5CKDd4tolo+GuOiJuRevDylwfPjtNkxuYiwEjHyeiUkXA==
X-Received: by 2002:a2e:9855:: with SMTP id e21mr11002311ljj.214.1591628470929; 
 Mon, 08 Jun 2020 08:01:10 -0700 (PDT)
Received: from localhost.localdomain ([213.87.137.116])
 by smtp.googlemail.com with ESMTPSA id r16sm279228ljn.106.2020.06.08.08.01.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 08:01:10 -0700 (PDT)
From: Denis Efremov <efremov@linux.com>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Mon,  8 Jun 2020 18:00:34 +0300
Message-Id: <20200608150038.223747-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 08 Jun 2020 17:01:13 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 08 Jun 2020 17:01:11 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH v2 0/4] Update memdup_user.cocci
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

Add GFP_USER to the allocation flags and handle vmemdup_user().
The third patch supresses memdup_user(), vmemdup_user() functions
detection. Last patch is a proof of concept for the rule selfchecking.
Gives the ability to detect that an open-coded pattern in a function
definition that we search for in the kernel sources changed.

Denis Efremov (4):
  coccinelle: api: extend memdup_user transformation with GFP_USER
  coccinelle: api: extend memdup_user rule with vmemdup_user()
  coccinelle: api: filter out memdup_user definitions
  coccinelle: api: add selfcheck for memdup_user rule

 scripts/coccinelle/api/memdup_user.cocci | 106 ++++++++++++++++++++++-
 1 file changed, 103 insertions(+), 3 deletions(-)

-- 
2.26.2

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
