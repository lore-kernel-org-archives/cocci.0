Return-Path: <SRS0=0wmz=ID=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE85C433E0
	for <cocci@archiver.kernel.org>; Fri,  5 Mar 2021 08:19:43 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A41365014
	for <cocci@archiver.kernel.org>; Fri,  5 Mar 2021 08:19:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A41365014
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 1258JPLH015607;
	Fri, 5 Mar 2021 09:19:25 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 03AE977CC;
	Fri,  5 Mar 2021 09:19:25 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 13BC05DC3
 for <cocci@systeme.lip6.fr>; Fri,  5 Mar 2021 09:19:24 +0100 (CET)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com
 [209.85.208.180])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 1258JNKG017118
 for <cocci@systeme.lip6.fr>; Fri, 5 Mar 2021 09:19:23 +0100 (CET)
Received: by mail-lj1-f180.google.com with SMTP id h4so1710123ljl.0
 for <cocci@systeme.lip6.fr>; Fri, 05 Mar 2021 00:19:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7XRAtGgHFapF9tffRIfz1dXxRDSD82LqpiHt4CHnG+I=;
 b=uLC85giWvmRn+av34Y+mGnhhuYO4ysOfqAISYu1jMPmY/2LlC1UiZREAvrxZIJPZm0
 S1V4dWrh/dctWA4KMVedbcVQkwdJygfBC7tae+aLbMWaORqFrNr/wz98kKfwSbb17Ea9
 5jniKirCw1Eisd6g3GN7km+ZfQ6klcGdTNB6VhBaKDgfOeaH14fd/d98+a/84OTDuaLv
 ju0TxTKGoBYIgCUYhYVb6CzyrmV/CDPRsEvavZBd2CCvCPWlwrNfWLmAY3NWTHtcXcy9
 sc1GCe6HCWsy8kG92WcuN1MBb+ad7gg5jPCprHvtBgR4F591Zb1Ms0eDMl3VaMYI94JT
 LljA==
X-Gm-Message-State: AOAM533qLcJml4oc1kj/ba5d/Bi6cyzwNbiBOP8wBipi9G8X6OTykXzc
 NcePCbIUXDZNqAi+hAgrzacVuOWUbACKmg==
X-Google-Smtp-Source: ABdhPJw2R5rlkuLDcbpZVPlXAG3oBxCCi+2zpkb3QB9mdGcZB9maGd1JhSnhgqr3YVQSOj1X36PLNA==
X-Received: by 2002:a2e:9004:: with SMTP id h4mr4549253ljg.326.1614932363219; 
 Fri, 05 Mar 2021 00:19:23 -0800 (PST)
Received: from localhost.. (broadband-188-32-236-56.ip.moscow.rt.ru.
 [188.32.236.56])
 by smtp.googlemail.com with ESMTPSA id s6sm209273lfg.242.2021.03.05.00.19.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Mar 2021 00:19:22 -0800 (PST)
From: Denis Efremov <efremov@linux.com>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Fri,  5 Mar 2021 13:16:40 +0300
Message-Id: <20210305101640.7717-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210216160326.1341741-1-efremov@linux.com>
References: <20210216160326.1341741-1-efremov@linux.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 05 Mar 2021 09:19:25 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 05 Mar 2021 09:19:23 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: [Cocci] [PATCH v3] coccinelle: misc: add minmax script
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
Changes in v3:
 - "depends on patch && (pmax || pmaxif || pmin || pminif)" fixed

 scripts/coccinelle/misc/minmax.cocci | 224 +++++++++++++++++++++++++++
 1 file changed, 224 insertions(+)
 create mode 100644 scripts/coccinelle/misc/minmax.cocci

diff --git a/scripts/coccinelle/misc/minmax.cocci b/scripts/coccinelle/misc/minmax.cocci
new file mode 100644
index 000000000000..f577f08d1e6e
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
+@depends on patch && (pmax || pmaxif || pmin || pminif)@
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
