Return-Path: <SRS0=pxvX=HV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A933C433E0
	for <cocci@archiver.kernel.org>; Fri, 19 Feb 2021 09:25:12 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC06064DD3
	for <cocci@archiver.kernel.org>; Fri, 19 Feb 2021 09:25:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC06064DD3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 11J9OnUO020871;
	Fri, 19 Feb 2021 10:24:49 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 942BC77C0;
	Fri, 19 Feb 2021 10:24:49 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4A8803E64
 for <cocci@systeme.lip6.fr>; Fri, 19 Feb 2021 10:24:47 +0100 (CET)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com
 [209.85.208.174])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 11J9OkkG009269
 for <cocci@systeme.lip6.fr>; Fri, 19 Feb 2021 10:24:46 +0100 (CET)
Received: by mail-lj1-f174.google.com with SMTP id c17so16741947ljn.0
 for <cocci@systeme.lip6.fr>; Fri, 19 Feb 2021 01:24:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7+1XXFxtp0NTyFOGv6KWqg5UlcFRsTicQF0RpwlPL7Q=;
 b=WM6iXgOYx6e264oJ+qNWtOI9bNcwdA6RwoXE/cxLQ30fOlalXAXicN3pC+PoQZfnPu
 Xgz/1m8/8l9OKcSleerx6Zx3zIJqYozrgc7zlUKkhSKv5S0s3pTgVSimlod5dyEH7fEg
 HtJqdw+R2DibUMcAJE27LjHN5ksEWYnNm7Bkoi1Mku8BJVe8v2a7kMAQEnfjzjOD6n5/
 o5W06Axps3fzkY57kFDMutfbplaLOLsVEnSLhaRDT4cZ9+jlO+tBcXgbdwxapwKeF2MA
 ZKBAm3lXoWhMO6jEy/ESGZi6/mlyO/cHnEZf/LwsRnTljUrtTQ/6FZgLOTyiZ+xnc4/O
 WLIg==
X-Gm-Message-State: AOAM530gPmSU0IpMUTHiXfs+eRvQn8eRFCuQrqo1Iq84lG8Fo+SeHl4D
 sXBh0mvs83ByvFGYLus9tb0=
X-Google-Smtp-Source: ABdhPJy1UPI6F6L2u+sjkmiZ9cEBWFrfgN8EzY9HIRoikI0eGFQFvwW2jgOdsDrq84Z/XyGJMHrw6A==
X-Received: by 2002:ac2:4a72:: with SMTP id q18mr5212436lfp.335.1613726686615; 
 Fri, 19 Feb 2021 01:24:46 -0800 (PST)
Received: from localhost.localdomain (broadband-188-32-236-56.ip.moscow.rt.ru.
 [188.32.236.56])
 by smtp.googlemail.com with ESMTPSA id 21sm868769lfo.238.2021.02.19.01.24.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Feb 2021 01:24:46 -0800 (PST)
From: Denis Efremov <efremov@linux.com>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Fri, 19 Feb 2021 12:24:48 +0300
Message-Id: <20210219092448.13760-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210216080133.455456-1-efremov@linux.com>
References: <20210216080133.455456-1-efremov@linux.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 19 Feb 2021 10:24:50 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 19 Feb 2021 10:24:46 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: [Cocci] [PATCH v2] coccinelle: misc: add swap script
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

 scripts/coccinelle/misc/swap.cocci | 101 +++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 scripts/coccinelle/misc/swap.cocci

diff --git a/scripts/coccinelle/misc/swap.cocci b/scripts/coccinelle/misc/swap.cocci
new file mode 100644
index 000000000000..d5da9888c222
--- /dev/null
+++ b/scripts/coccinelle/misc/swap.cocci
@@ -0,0 +1,101 @@
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
+@r depends on !patch@
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
+@depends on (rpvar || rp)@
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
-- 
2.26.2

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
