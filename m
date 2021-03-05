Return-Path: <SRS0=0wmz=ID=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005F7C433E0
	for <cocci@archiver.kernel.org>; Fri,  5 Mar 2021 08:13:20 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DB7364F0B
	for <cocci@archiver.kernel.org>; Fri,  5 Mar 2021 08:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DB7364F0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 1258D2QE006645;
	Fri, 5 Mar 2021 09:13:02 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1D09977CC;
	Fri,  5 Mar 2021 09:13:02 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 025C15DC3
 for <cocci@systeme.lip6.fr>; Fri,  5 Mar 2021 09:13:00 +0100 (CET)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com
 [209.85.208.177])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 1258Cxbv012602
 for <cocci@systeme.lip6.fr>; Fri, 5 Mar 2021 09:12:59 +0100 (CET)
Received: by mail-lj1-f177.google.com with SMTP id t9so1646036ljt.8
 for <cocci@systeme.lip6.fr>; Fri, 05 Mar 2021 00:12:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qzDw47z9cmcIPC1rW9QLd8oJb6CmtII1SB7vSsEPO4U=;
 b=LNLpVNWHs05WR1VSDsgBCyboLZCcQ0DXO+FpBJPgZIaUi3wkO4xyT9O2FyQE6osdQJ
 +rHZLWsGrkS6cpMP3/Q9QiuJATTztU7wGBvnB+tsL+ZXwKcEKZUshhwtkk9B6dwGH7c2
 1DiTo0ArKUcJuLCiK3nMNj8JtwAaGZnM0Zo35FxgAhT/cPIN1FcflUoPOnoxW4rld+3Y
 DPsggkTj5KuNaZIOCABhz2WXjwlBOvW1d67QE0Og2z1wKWmbjx8G+v1alkfpxuIIPEKH
 Ae8BanK/nL/9JXdRabAO7+CIxExLElrKsNrDgi//FTyhx/4AVtikuHXiSaDXDrHFtpmn
 4Ibg==
X-Gm-Message-State: AOAM533L8bkSqwCiXES1mm2MsPbQh2Xw3IRUsB7L7cJahQVPgxLRwA08
 vXolRkPq4h/3H35hEgX31uc=
X-Google-Smtp-Source: ABdhPJz1MdDwfyMYub7E7P7on1mycF+wwHmmYUSZ2/sgWeVmBS8BLUGnQLtAMnm74QuQ7lxIaH/nKw==
X-Received: by 2002:a2e:9595:: with SMTP id w21mr4584541ljh.72.1614931979242; 
 Fri, 05 Mar 2021 00:12:59 -0800 (PST)
Received: from localhost.. (broadband-188-32-236-56.ip.moscow.rt.ru.
 [188.32.236.56])
 by smtp.googlemail.com with ESMTPSA id u13sm209651lfr.124.2021.03.05.00.12.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Mar 2021 00:12:58 -0800 (PST)
From: Denis Efremov <efremov@linux.com>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Fri,  5 Mar 2021 13:09:56 +0300
Message-Id: <20210305100956.6222-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210216080133.455456-1-efremov@linux.com>
References: <20210216080133.455456-1-efremov@linux.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 05 Mar 2021 09:13:03 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 05 Mar 2021 09:12:59 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: [Cocci] [PATCH v3] coccinelle: misc: add swap script
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

Check for opencoded swap() implementation.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
Changes in v2:
 - additional patch rule to drop excessive {}
 - fix indentation in patch mode by anchoring ;
Changes in v3:
 - Rule added for simple (without var init) swap highlighting in !patch mode 
 - "depends on patch && (rpvar || rp)" fixed

 scripts/coccinelle/misc/swap.cocci | 122 +++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)
 create mode 100644 scripts/coccinelle/misc/swap.cocci

diff --git a/scripts/coccinelle/misc/swap.cocci b/scripts/coccinelle/misc/swap.cocci
new file mode 100644
index 000000000000..c5e71b7ef7f5
--- /dev/null
+++ b/scripts/coccinelle/misc/swap.cocci
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Check for opencoded swap() implementation.
+///
+// Confidence: High
+// Copyright: (C) 2021 Denis Efremov ISPRAS
+// Options: --no-includes --include-headers
+//
+// Keywords: swap
+//
+
+virtual patch
+virtual org
+virtual report
+virtual context
+
+@rvar depends on !patch@
+identifier tmp;
+expression a, b;
+type T;
+position p;
+@@
+
+(
+* T tmp;
+|
+* T tmp = 0;
+|
+* T *tmp = NULL;
+)
+... when != tmp
+* tmp = a;
+* a = b;@p
+* b = tmp;
+... when != tmp
+
+@r depends on !patch@
+identifier tmp;
+expression a, b;
+position p != rvar.p;
+@@
+
+* tmp = a;
+* a = b;@p
+* b = tmp;
+
+@rpvar depends on patch@
+identifier tmp;
+expression a, b;
+type T;
+@@
+
+(
+- T tmp;
+|
+- T tmp = 0;
+|
+- T *tmp = NULL;
+)
+... when != tmp
+- tmp = a;
+- a = b;
+- b = tmp
++ swap(a, b)
+  ;
+... when != tmp
+
+@rp depends on patch@
+identifier tmp;
+expression a, b;
+@@
+
+- tmp = a;
+- a = b;
+- b = tmp
++ swap(a, b)
+  ;
+
+@depends on patch && (rpvar || rp)@
+@@
+
+(
+  for (...;...;...)
+- {
+	swap(...);
+- }
+|
+  while (...)
+- {
+	swap(...);
+- }
+|
+  if (...)
+- {
+	swap(...);
+- }
+)
+
+
+@script:python depends on report@
+p << r.p;
+@@
+
+coccilib.report.print_report(p[0], "WARNING opportunity for swap()")
+
+@script:python depends on org@
+p << r.p;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING opportunity for swap()")
+
+@script:python depends on report@
+p << rvar.p;
+@@
+
+coccilib.report.print_report(p[0], "WARNING opportunity for swap()")
+
+@script:python depends on org@
+p << rvar.p;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING opportunity for swap()")
-- 
2.26.2

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
