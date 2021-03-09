Return-Path: <SRS0=c3K5=IH=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AF2C433E0
	for <cocci@archiver.kernel.org>; Tue,  9 Mar 2021 06:39:33 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E7AE64EF0
	for <cocci@archiver.kernel.org>; Tue,  9 Mar 2021 06:39:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E7AE64EF0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 1296d8TO025543;
	Tue, 9 Mar 2021 07:39:08 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5F88377BF;
	Tue,  9 Mar 2021 07:39:08 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A32C33C3C
 for <cocci@systeme.lip6.fr>; Tue,  9 Mar 2021 07:39:06 +0100 (CET)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com
 [209.85.167.53])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 1296d6dg007981
 for <cocci@systeme.lip6.fr>; Tue, 9 Mar 2021 07:39:06 +0100 (CET)
Received: by mail-lf1-f53.google.com with SMTP id n16so25250303lfb.4
 for <cocci@systeme.lip6.fr>; Mon, 08 Mar 2021 22:39:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lI4Y0ym2MRyh7P3eGGhPMMllSH0LqL9Xl8CVZBQeWNY=;
 b=TGrrIyte++zAUYvS2N/nA9nS2aFUGnPG1d76lPZdLMVnmayVtLrjV+rRxz0EAW2Cqa
 MuyoQ5HaZC9CX8JysNgeMhWWKGcrjAmBmhPCx6sBgCW17xlTBsvVCP7SOdfoA4Kp1zPA
 paZZss1KdMxjbBwXADXdquOBLC9eJExTmwMoDFjnSn4P7OckBvUmuhMIVMYZJcbR8DcQ
 orTvNu3Ar/R6239AbiCkMUvivkt1Vwrr7U8EIL2DYzaRMmHIvghZJ6dmYL3gdcDAgdnW
 ocaaia1a5eUv8JNETJ4Xft9pYCE7MONkZSTrJ9hnJ+50suRb3DWqyIgzFtbHTzUMiVlP
 JQ0A==
X-Gm-Message-State: AOAM531HyOPbPQcJWYLaseDz0pNU61d80TcvVvv5nsOcYZFI0w1Hy4r7
 WLvEIbwcd5C3UPGNesmvq08=
X-Google-Smtp-Source: ABdhPJwPn4bAZxr1ER6dLdreaL03ebhvn/r6StR+N7kHfOKaCRoci7k7ypWw99y7zbZ2Z0X/rZuNjA==
X-Received: by 2002:a19:c185:: with SMTP id
 r127mr16171502lff.530.1615271945716; 
 Mon, 08 Mar 2021 22:39:05 -0800 (PST)
Received: from localhost.. (broadband-188-32-236-56.ip.moscow.rt.ru.
 [188.32.236.56])
 by smtp.googlemail.com with ESMTPSA id x36sm1623352lfu.129.2021.03.08.22.39.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Mar 2021 22:39:05 -0800 (PST)
From: Denis Efremov <efremov@linux.com>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Tue,  9 Mar 2021 09:39:03 +0300
Message-Id: <20210309063903.13231-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210216160326.1341741-1-efremov@linux.com>
References: <20210216160326.1341741-1-efremov@linux.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 09 Mar 2021 07:39:09 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 09 Mar 2021 07:39:06 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: [Cocci] [PATCH v5] coccinelle: misc: add minmax script
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
Changes in v5:
 - parentheses droppped in pminif and pmaxif rules (max_val = x ...)

 scripts/coccinelle/misc/minmax.cocci | 206 +++++++++++++++++++++++++++
 1 file changed, 206 insertions(+)
 create mode 100644 scripts/coccinelle/misc/minmax.cocci

diff --git a/scripts/coccinelle/misc/minmax.cocci b/scripts/coccinelle/misc/minmax.cocci
new file mode 100644
index 000000000000..eccdd3eb3452
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
+-		min_val = x;
+-	} else {
+-		min_val = y;
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
