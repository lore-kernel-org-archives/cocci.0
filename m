Return-Path: <SRS0=tA4o=IG=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B597C433DB
	for <cocci@archiver.kernel.org>; Mon,  8 Mar 2021 07:05:12 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EEE464F96
	for <cocci@archiver.kernel.org>; Mon,  8 Mar 2021 07:05:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EEE464F96
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 12874sQ2001001;
	Mon, 8 Mar 2021 08:04:54 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1D45177BF;
	Mon,  8 Mar 2021 08:04:54 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B522B5DC3
 for <cocci@systeme.lip6.fr>; Mon,  8 Mar 2021 08:04:52 +0100 (CET)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com
 [209.85.208.171])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 12874qRU021055
 for <cocci@systeme.lip6.fr>; Mon, 8 Mar 2021 08:04:52 +0100 (CET)
Received: by mail-lj1-f171.google.com with SMTP id p15so14679795ljc.13
 for <cocci@systeme.lip6.fr>; Sun, 07 Mar 2021 23:04:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oHlzT8YFV71X+qnYl7bOaqCLNeFyzOS3n6PKubU4sbU=;
 b=RxEebcOY7+oMV01FmdHecP/76UDmTuvCaXSVpBJHuvuxcVcXFJOevfqmPq2dquNRpg
 B8kqFjqIrkdTRzPMRlJPM7juIuHi7NAr623Uk+ZS3fK6jWqAnbHKZfZu+i5Uh+TVjwux
 8E333sHtX/7PSEMNnHP8QEUISVK3zOi3iYX/CifrAEl+OS3A3NkA1AgXsQ0eFQH1VOQc
 EbT4sHUsNdwlHtzWjgiy05NEsKwltN9opvJeh6flQ8IRzWkGysUA5UP2B3MlM1pHJ/tf
 dumvvj5bNySTolB6SUaHVqOqFNC8tpiIN/hEEiAhUK4ktMaJvvzFLcI/KMcNuWfzTbc6
 4Fhg==
X-Gm-Message-State: AOAM532COF5OYUyLDG0DrFcP0J8YxM4ahLG7Dof8LY9HHYoHQDeq14SN
 IbJ23B1Inqr672J4d7CE3m4=
X-Google-Smtp-Source: ABdhPJwBb/VgOOANmqxIuQ+ScNlBbDyaGSOQdt4xw6BLiNC7ZPCGUa9SX30ol23DJBuDMFFPgrCZhg==
X-Received: by 2002:a2e:8596:: with SMTP id b22mr12961861lji.482.1615187091786; 
 Sun, 07 Mar 2021 23:04:51 -0800 (PST)
Received: from localhost.. (broadband-188-32-236-56.ip.moscow.rt.ru.
 [188.32.236.56])
 by smtp.googlemail.com with ESMTPSA id f9sm1372925ljg.115.2021.03.07.23.04.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Mar 2021 23:04:51 -0800 (PST)
From: Denis Efremov <efremov@linux.com>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Mon,  8 Mar 2021 10:04:45 +0300
Message-Id: <20210308070445.104768-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210216160326.1341741-1-efremov@linux.com>
References: <20210216160326.1341741-1-efremov@linux.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 08 Mar 2021 08:04:54 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 08 Mar 2021 08:04:52 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: [Cocci] [PATCH v4] coccinelle: misc: add minmax script
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
Changes in v4:
 - refarmatting rule removed
 - () brackets added to the patch rules to omit excessive ones
 - org/report prints changed to cycle (for p0 in p: ...)

 scripts/coccinelle/misc/minmax.cocci | 206 +++++++++++++++++++++++++++
 1 file changed, 206 insertions(+)
 create mode 100644 scripts/coccinelle/misc/minmax.cocci

diff --git a/scripts/coccinelle/misc/minmax.cocci b/scripts/coccinelle/misc/minmax.cocci
new file mode 100644
index 000000000000..63eeba1702ec
--- /dev/null
+++ b/scripts/coccinelle/misc/minmax.cocci
@@ -0,0 +1,206 @@
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
+*	((x) cmp@p (y) ? (x) : (y))
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
+*	if ((x) cmp@p (y)) {
+*		max_val = (x);
+*	} else {
+*		max_val = (y);
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
+*	((x) cmp@p (y) ? (x) : (y))
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
+*	if ((x) cmp@p (y)) {
+*		min_val = (x);
+*	} else {
+*		min_val = (y);
+*	}
+	...>
+}
+
+@pmax depends on patch@
+identifier func;
+expression x, y;
+binary operator cmp = {>=, >};
+@@
+
+func(...)
+{
+	<...
+-	((x) cmp (y) ? (x) : (y))
++	max(x, y)
+	...>
+}
+
+@pmaxif depends on patch@
+identifier func;
+expression x, y;
+expression max_val;
+binary operator cmp = {>=, >};
+@@
+
+func(...)
+{
+	<...
+-	if ((x) cmp (y)) {
+-		max_val = (x);
+-	} else {
+-		max_val = (y);
+-	}
++	max_val = max(x, y);
+	...>
+}
+
+@pmin depends on patch@
+identifier func;
+expression x, y;
+binary operator cmp = {<=, <};
+@@
+
+func(...)
+{
+	<...
+-	((x) cmp (y) ? (x) : (y))
++	min(x, y)
+	...>
+}
+
+@pminif depends on patch@
+identifier func;
+expression x, y;
+expression min_val;
+binary operator cmp = {<=, <};
+@@
+
+func(...)
+{
+	<...
+-	if ((x) cmp (y)) {
+-		min_val = (x);
+-	} else {
+-		min_val = (y);
+-	}
++	min_val = min(x, y);
+	...>
+}
+
+@script:python depends on report@
+p << rmax.p;
+@@
+
+for p0 in p:
+	coccilib.report.print_report(p0, "WARNING opportunity for max()")
+
+@script:python depends on org@
+p << rmax.p;
+@@
+
+for p0 in p:
+	coccilib.org.print_todo(p0, "WARNING opportunity for max()")
+
+@script:python depends on report@
+p << rmaxif.p;
+@@
+
+for p0 in p:
+	coccilib.report.print_report(p0, "WARNING opportunity for max()")
+
+@script:python depends on org@
+p << rmaxif.p;
+@@
+
+for p0 in p:
+	coccilib.org.print_todo(p0, "WARNING opportunity for max()")
+
+@script:python depends on report@
+p << rmin.p;
+@@
+
+for p0 in p:
+	coccilib.report.print_report(p0, "WARNING opportunity for min()")
+
+@script:python depends on org@
+p << rmin.p;
+@@
+
+for p0 in p:
+	coccilib.org.print_todo(p0, "WARNING opportunity for min()")
+
+@script:python depends on report@
+p << rminif.p;
+@@
+
+for p0 in p:
+	coccilib.report.print_report(p0, "WARNING opportunity for min()")
+
+@script:python depends on org@
+p << rminif.p;
+@@
+
+for p0 in p:
+	coccilib.org.print_todo(p0, "WARNING opportunity for min()")
-- 
2.26.2

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
