Return-Path: <SRS0=pxvX=HV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDBBC433DB
	for <cocci@archiver.kernel.org>; Fri, 19 Feb 2021 09:06:09 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F4F964EAF
	for <cocci@archiver.kernel.org>; Fri, 19 Feb 2021 09:06:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F4F964EAF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 11J95dJl012248;
	Fri, 19 Feb 2021 10:05:39 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E72E677C0;
	Fri, 19 Feb 2021 10:05:38 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id AAC743E64
 for <cocci@systeme.lip6.fr>; Fri, 19 Feb 2021 10:05:36 +0100 (CET)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com
 [209.85.208.181])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 11J95aMS025147
 for <cocci@systeme.lip6.fr>; Fri, 19 Feb 2021 10:05:36 +0100 (CET)
Received: by mail-lj1-f181.google.com with SMTP id c17so16485676ljn.0
 for <cocci@systeme.lip6.fr>; Fri, 19 Feb 2021 01:05:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4SYuc31NBuKizkQQlJfdfOc2gXxQ85QiVTeukEPxaJo=;
 b=iEA4UIS6HzYyRmD7iMZEzn9O/qQnxdLkOVFcjEG7xEc3slkAOWCfGCUp47337+Da+C
 9pLCi+X0DEwwV7pxrbhm5kQdcicSYB5ZSIA0Z7ZP2uYnrFA0hLIDszWWkIU/Y1Lvcjzg
 HT2SLcR+QCj927jjjvb7qZQmOVVmSd4fyK8PN5nQ0Vq2+EGbamfQ6cUuu/R5bvsGjKfy
 xFPaYDDcU8pzIZnzG/qNysyVqw9AC3YPhNuKpDisfR+PC4kQpYlyx4WTnjfwL4jaOBh/
 DHB/EYDAYebOHkZSFGcq15UCIgM+VNL5wqNDimd4evHw8uZUopIoDsqZETntfOsCFYtz
 ITNg==
X-Gm-Message-State: AOAM533m3iWFguCFlLgd+L88mtjXYCapY0x56wMzSCLn98OJyHrM6ww1
 EYYdMCBx5q5XyIGx8LiH3Mg=
X-Google-Smtp-Source: ABdhPJxk/zPhW0YoA4R5eXWF9hptagCSADw59N9qPWU/Z5oCVrDLkYhTL8UTXmkD8zdkmp8hXAetfA==
X-Received: by 2002:a2e:95c8:: with SMTP id y8mr2486238ljh.419.1613725535773; 
 Fri, 19 Feb 2021 01:05:35 -0800 (PST)
Received: from localhost.localdomain (broadband-188-32-236-56.ip.moscow.rt.ru.
 [188.32.236.56])
 by smtp.googlemail.com with ESMTPSA id a20sm162635lji.77.2021.02.19.01.05.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Feb 2021 01:05:34 -0800 (PST)
From: Denis Efremov <efremov@linux.com>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Fri, 19 Feb 2021 12:05:20 +0300
Message-Id: <20210219090520.8812-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210216080133.455456-1-efremov@linux.com>
References: <20210216080133.455456-1-efremov@linux.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 19 Feb 2021 10:05:39 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 19 Feb 2021 10:05:36 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: [Cocci] [PATCH v2] coccinelle: misc: add minmax script
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

Check for opencoded min(), max() implementations.

Signed-off-by: Denis Efremov <efremov@linux.com>
---

Changes in v2:
 - <... ...> instead of ... when any
 - org mode reports fixed
 - patch rule to drop excessive ()

 scripts/coccinelle/misc/minmax.cocci | 224 +++++++++++++++++++++++++++
 1 file changed, 224 insertions(+)
 create mode 100644 scripts/coccinelle/misc/minmax.cocci

diff --git a/scripts/coccinelle/misc/minmax.cocci b/scripts/coccinelle/misc/minmax.cocci
new file mode 100644
index 000000000000..61d6b61fd82c
--- /dev/null
+++ b/scripts/coccinelle/misc/minmax.cocci
@@ -0,0 +1,224 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Check for opencoded min(), max() implementations.
+/// Generated patches sometimes require adding a cast to fix compile warning.
+/// Warnings/patches scope intentionally limited to a function body.
+///
+// Confidence: Medium
+// Copyright: (C) 2021 Denis Efremov ISPRAS
+// Options: --no-includes --include-headers
+//
+// Keywords: min, max
+//
+
+
+virtual report
+virtual org
+virtual context
+virtual patch
+
+@rmax depends on !patch@
+identifier func;
+expression x, y;
+binary operator cmp = {>, >=};
+position p;
+@@
+
+func(...)
+{
+	<...
+*	x cmp@p y ? x : y
+	...>
+}
+
+@rmaxif depends on !patch@
+identifier func;
+expression x, y;
+expression max_val;
+binary operator cmp = {>, >=};
+position p;
+@@
+
+func(...)
+{
+	<...
+*	if (x cmp@p y) {
+*		max_val = x;
+*	} else {
+*		max_val = y;
+*	}
+	...>
+}
+
+@rmin depends on !patch@
+identifier func;
+expression x, y;
+binary operator cmp = {<, <=};
+position p;
+@@
+
+func(...)
+{
+	<...
+*	x cmp@p y ? x : y
+	...>
+}
+
+@rminif depends on !patch@
+identifier func;
+expression x, y;
+expression min_val;
+binary operator cmp = {<, <=};
+position p;
+@@
+
+func(...)
+{
+	<...
+*	if (x cmp@p y) {
+*		min_val = x;
+*	} else {
+*		min_val = y;
+*	}
+	...>
+}
+
+@pmax depends on patch@
+identifier func;
+expression x, y;
+binary operator cmp = {>=, >};
+position p;
+@@
+
+func@p(...)
+{
+	<...
+-	x cmp y ? x : y
++	max(x, y)
+	...>
+}
+
+@pmaxif depends on patch@
+identifier func;
+expression x, y;
+expression max_val;
+binary operator cmp = {>=, >};
+position p;
+@@
+
+func@p(...)
+{
+	<...
+-	if (x cmp y) {
+-		max_val = x;
+-	} else {
+-		max_val = y;
+-	}
++	max_val = max(x, y);
+	...>
+}
+
+@pmin depends on patch@
+identifier func;
+expression x, y;
+binary operator cmp = {<=, <};
+position p;
+@@
+
+func@p(...)
+{
+	<...
+-	x cmp y ? x : y
++	min(x, y)
+	...>
+}
+
+@pminif depends on patch@
+identifier func;
+expression x, y;
+expression min_val;
+binary operator cmp = {<=, <};
+position p;
+@@
+
+func@p(...)
+{
+	<...
+-	if (x cmp y) {
+-		min_val = x;
+-	} else {
+-		min_val = y;
+-	}
++	min_val = min(x, y);
+	...>
+}
+
+@depends on (pmax || pmaxif || pmin || pminif)@
+identifier func;
+expression x, y;
+position p;
+// FIXME: Coccinelle consumes all available ram and
+// and timeouts on every file.
+// position p = { pmin.p, pminif.p, pmax.p, pmaxif.p };
+@@
+
+func@p(...)
+{
+	<...
+(
+-	(min((x), (y)))
++	min(x, y)
+|
+-	(max((x), (y)))
++	max(x, y)
+)
+	...>
+}
+
+@script:python depends on report@
+p << rmax.p;
+@@
+
+coccilib.report.print_report(p[0], "WARNING opportunity for max()")
+
+@script:python depends on org@
+p << rmax.p;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING opportunity for max()")
+
+@script:python depends on report@
+p << rmaxif.p;
+@@
+
+coccilib.report.print_report(p[0], "WARNING opportunity for max()")
+
+@script:python depends on org@
+p << rmaxif.p;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING opportunity for max()")
+
+@script:python depends on report@
+p << rmin.p;
+@@
+
+coccilib.report.print_report(p[0], "WARNING opportunity for min()")
+
+@script:python depends on org@
+p << rmin.p;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING opportunity for min()")
+
+@script:python depends on report@
+p << rminif.p;
+@@
+
+coccilib.report.print_report(p[0], "WARNING opportunity for min()")
+
+@script:python depends on org@
+p << rminif.p;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING opportunity for min()")
-- 
2.26.2

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
