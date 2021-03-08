Return-Path: <SRS0=tA4o=IG=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BFDC433DB
	for <cocci@archiver.kernel.org>; Mon,  8 Mar 2021 07:30:50 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 728EA64EEF
	for <cocci@archiver.kernel.org>; Mon,  8 Mar 2021 07:30:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 728EA64EEF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 1287UMJZ021374;
	Mon, 8 Mar 2021 08:30:22 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2C60977BF;
	Mon,  8 Mar 2021 08:30:22 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D24AD5DC3
 for <cocci@systeme.lip6.fr>; Mon,  8 Mar 2021 08:30:20 +0100 (CET)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com
 [209.85.208.172])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 1287UKko001766
 for <cocci@systeme.lip6.fr>; Mon, 8 Mar 2021 08:30:20 +0100 (CET)
Received: by mail-lj1-f172.google.com with SMTP id i26so3162728ljn.1
 for <cocci@systeme.lip6.fr>; Sun, 07 Mar 2021 23:30:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=vSgQKtJu6DhjO0t3OJp5IkI2xLLW3/u/GFWiQflU5N8=;
 b=o+Q7wvu8gjPXJA3y8ZU/ZoHGx3Zdn27L3hj4ihSSXVNTR0EXdH0MBUNLPNl251FT1E
 ooqRl+NmFXtMBhpS4HI9HWozm3pfQKz2XiXLEInueXfvyq28svCUqUdpL67UOgFcMPCH
 khGkOf0uPV7TOB+odaVJ5azO/XKaE9Oj7ov3BM/K9FmQl14CJvCqjiUMhgbTsJHB7wnG
 r/z4iKg/V0zquhC42RZQh+AZsooxnmAPXZi3Xpm8h7QHyS5U7H2b7wxI8qFsKerz8VVk
 HiLQygz/6CA9+cvh7cWLGaXqpcu+R++Cn0P2ShYRqI5cDTVzEM6FNU+n2ejyIrnFTW08
 7cYg==
X-Gm-Message-State: AOAM532IZTO1+5GF74KTu7B1gwqbnla5p2bgMMxGBm89SupPdVuOXcpV
 z0mbKkhT3VOmSXrD4jzj74I=
X-Google-Smtp-Source: ABdhPJyQPspC+d+wFvk9zkmZuW/Zm4JYF2WiCRCuSTt7kUcoqXOKhyK3SzWrn3Q/iq2PVKb2y/twtA==
X-Received: by 2002:a2e:94cc:: with SMTP id r12mr12507920ljh.373.1615188620116; 
 Sun, 07 Mar 2021 23:30:20 -0800 (PST)
Received: from localhost.. (broadband-188-32-236-56.ip.moscow.rt.ru.
 [188.32.236.56])
 by smtp.googlemail.com with ESMTPSA id b25sm1383897ljo.80.2021.03.07.23.30.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Mar 2021 23:30:19 -0800 (PST)
From: Denis Efremov <efremov@linux.com>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Mon,  8 Mar 2021 10:30:18 +0300
Message-Id: <20210308073018.108487-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 08 Mar 2021 08:30:22 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 08 Mar 2021 08:30:20 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: [Cocci] [PATCH] coccinelle: misc: update uninitialized_var.cocci
	documentation
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

Remove the documentation link from the warning message because commit
3942ea7a10c9 ("deprecated.rst: Remove now removed uninitialized_var")
removed the section from documentation. Update the rule documentation
accordingly.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 scripts/coccinelle/misc/uninitialized_var.cocci | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/scripts/coccinelle/misc/uninitialized_var.cocci b/scripts/coccinelle/misc/uninitialized_var.cocci
index 8fa845cefe11..69bbaae47e73 100644
--- a/scripts/coccinelle/misc/uninitialized_var.cocci
+++ b/scripts/coccinelle/misc/uninitialized_var.cocci
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
 ///
 /// Please, don't reintroduce uninitialized_var().
-/// From Documentation/process/deprecated.rst:
+///
+/// From Documentation/process/deprecated.rst,
+/// commit 4b19bec97c88 ("docs: deprecated.rst: Add uninitialized_var()"):
 ///  For any compiler warnings about uninitialized variables, just add
 ///  an initializer. Using warning-silencing tricks is dangerous as it
 ///  papers over real bugs (or can in the future), and suppresses unrelated
@@ -11,6 +13,11 @@
 ///  obviously redundant, the compiler's dead-store elimination pass will make
 ///  sure there are no needless variable writes.
 ///
+/// Later, commit 3942ea7a10c9 ("deprecated.rst: Remove now removed
+/// uninitialized_var") removed this section because all initializations of
+/// this kind were cleaned-up from the kernel. This cocci rule checks that
+/// the macro is not explicitly or implicitly reintroduced.
+///
 // Confidence: High
 // Copyright: (C) 2020 Denis Efremov ISPRAS
 // Options: --no-includes --include-headers
@@ -40,12 +47,10 @@ position p;
 p << r.p;
 @@
 
-coccilib.report.print_report(p[0],
-  "WARNING this kind of initialization is deprecated (https://www.kernel.org/doc/html/latest/process/deprecated.html#uninitialized-var)")
+coccilib.report.print_report(p[0], "WARNING this kind of initialization is deprecated")
 
 @script:python depends on org@
 p << r.p;
 @@
 
-coccilib.org.print_todo(p[0],
-  "WARNING this kind of initialization is deprecated (https://www.kernel.org/doc/html/latest/process/deprecated.html#uninitialized-var)")
+coccilib.org.print_todo(p[0], "WARNING this kind of initialization is deprecated")
-- 
2.26.2

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
