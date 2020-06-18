Return-Path: <SRS0=v8PH=77=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF60C433E0
	for <cocci@archiver.kernel.org>; Thu, 18 Jun 2020 10:24:02 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FEC720899
	for <cocci@archiver.kernel.org>; Thu, 18 Jun 2020 10:24:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FEC720899
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05IANhss007375;
	Thu, 18 Jun 2020 12:23:43 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0356B7577;
	Thu, 18 Jun 2020 12:23:43 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 261C9402B
 for <cocci@systeme.lip6.fr>; Thu, 18 Jun 2020 12:23:41 +0200 (CEST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com
 [209.85.167.49])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05IANdV4027123
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 18 Jun 2020 12:23:40 +0200 (CEST)
Received: by mail-lf1-f49.google.com with SMTP id d27so3146737lfq.5
 for <cocci@systeme.lip6.fr>; Thu, 18 Jun 2020 03:23:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ubgAniuLZwUefX9aPUKilP2kkhN35Iuff9mjSqyql7k=;
 b=s9cwE4wmyVNNTqhhGG3mnjyASyF3FkdYPyaWvU0lPKyfVKO8shUjcpwzUkUvrLsLZf
 2v1yW3HF+DRAL15W/54+OyTqioHNNi/thw7JAWztapTrcWshiM1NZ0nJJK0PQPqIz+kh
 xjGisylRXdHJ2DUs6FsM9U5s8meJCBctb/UqnO/I/aCSc38xt9fdkcRUKVZz3KZk+3d9
 qvJGIMX26wbnDpBZD/LatNZ/1JBvfoDa9HXzAvxVF/LyZ/JZ9y0SAFGurxqMpKkfnJqP
 M6gnkNYuNaNc5WPnVHzJIMmk4KCthX0vk6mYVyKl4MBAiHduixgY2iNG5C8QhXerkNUN
 oOTg==
X-Gm-Message-State: AOAM5305Kv0VGJL+ZkmGkYd7q63L14MeG81pB+UAsBrKfOfTWjZFPHu7
 fVDkbknbEe7pZikw2RjGadI=
X-Google-Smtp-Source: ABdhPJyHZwVg/wsvx7Lo95dRSERAP076Soy/X4/VnowSrs0AGcQdBE10aNp54yu2cNcAx4SXqni7TA==
X-Received: by 2002:a05:6512:308e:: with SMTP id
 z14mr2000619lfd.29.1592475819472; 
 Thu, 18 Jun 2020 03:23:39 -0700 (PDT)
Received: from localhost.localdomain ([213.87.137.195])
 by smtp.googlemail.com with ESMTPSA id z13sm657226lfd.7.2020.06.18.03.23.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2020 03:23:38 -0700 (PDT)
From: Denis Efremov <efremov@linux.com>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Thu, 18 Jun 2020 13:23:08 +0300
Message-Id: <20200618102308.7305-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200615102045.4558-1-efremov@linux.com>
References: <20200615102045.4558-1-efremov@linux.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 18 Jun 2020 12:23:43 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 18 Jun 2020 12:23:40 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Kees Cook <keescook@chromium.org>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [Cocci] [PATCH v2] coccinelle: misc: add array_size_dup script to
	detect missed overlow checks
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

Detect an opencoded expression that is used before or after
array_size()/array3_size()/struct_size() to compute the same size.

Cc: Gustavo A. R. Silva <garsilva@embeddedor.com>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Denis Efremov <efremov@linux.com>
---
Changes in v2:
 - python rules moved next to SmPL patterns
 - assignment operator used
 - struct_size patterns fixed to check only E3, since
   E1, E2 are sizeofs of a structure and a member
   of a structure

 scripts/coccinelle/misc/array_size_dup.cocci | 309 +++++++++++++++++++
 1 file changed, 309 insertions(+)
 create mode 100644 scripts/coccinelle/misc/array_size_dup.cocci

diff --git a/scripts/coccinelle/misc/array_size_dup.cocci b/scripts/coccinelle/misc/array_size_dup.cocci
new file mode 100644
index 000000000000..c5214310285c
--- /dev/null
+++ b/scripts/coccinelle/misc/array_size_dup.cocci
@@ -0,0 +1,309 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Check for array_size(), array3_size(), struct_size() duplicates.
+/// Three types of patterns for these functions:
+///  1. An opencoded expression is used before array_size() to compute the same size
+///  2. An opencoded expression is used after array_size() to compute the same size
+///  3. Consecutive calls of array_size() with the same values
+/// From security point of view only first case is relevant. These functions
+/// perform arithmetic overflow check. Thus, if we use an opencoded expression
+/// before a call to the *_size() function we can miss an overflow.
+///
+// Confidence: High
+// Copyright: (C) 2020 Denis Efremov ISPRAS
+// Options: --no-includes --include-headers --no-loops
+
+virtual context
+virtual report
+virtual org
+
+@as@
+expression E1, E2;
+@@
+
+array_size(E1, E2)
+
+@as_next@
+expression subE1 <= as.E1;
+expression subE2 <= as.E2;
+expression as.E1, as.E2, E3;
+assignment operator aop;
+position p1, p2;
+@@
+
+* E1 * E2@p1
+  ... when != \(E1\|E2\|subE1\|subE2\) aop E3
+      when != \(&E1\|&E2\|&subE1\|&subE2\)
+* array_size(E1, E2)@p2
+
+@script:python depends on report@
+p1 << as_next.p1;
+p2 << as_next.p2;
+@@
+
+coccilib.report.print_report(p1[0],
+f"WARNING: array_size is used down the code (line {p2[0].line}) to compute \
+the same size")
+
+@script:python depends on org@
+p1 << as_next.p1;
+p2 << as_next.p2;
+@@
+
+coccilib.org.print_todo(p1[0],
+f"WARNING: array_size is used down the code (line {p2[0].line}) to compute \
+the same size")
+
+@as_prev@
+expression subE1 <= as.E1;
+expression subE2 <= as.E2;
+expression as.E1, as.E2, E3;
+assignment operator aop;
+position p1, p2;
+@@
+
+* array_size(E1, E2)@p1
+  ... when != \(E1\|E2\|subE1\|subE2\) aop E3
+      when != \(&E1\|&E2\|&subE1\|&subE2\)
+* E1 * E2@p2
+
+@script:python depends on report@
+p1 << as_prev.p1;
+p2 << as_prev.p2;
+@@
+
+coccilib.report.print_report(p2[0],
+f"WARNING: array_size is already used (line {p1[0].line}) to compute \
+the same size")
+
+@script:python depends on org@
+p1 << as_prev.p1;
+p2 << as_prev.p2;
+@@
+
+coccilib.org.print_todo(p2[0],
+f"WARNING: array_size is already used (line {p1[0].line}) to compute \
+the same size")
+
+@as_dup@
+expression subE1 <= as.E1;
+expression subE2 <= as.E2;
+expression as.E1, as.E2, E3;
+assignment operator aop;
+position p1, p2;
+@@
+
+* array_size(E1, E2)@p1
+  ... when != \(E1\|E2\|subE1\|subE2\) aop E3
+      when != \(&E1\|&E2\|&subE1\|&subE2\)
+* array_size(E1, E2)@p2
+
+@script:python depends on report@
+p1 << as_dup.p1;
+p2 << as_dup.p2;
+@@
+
+coccilib.report.print_report(p2[0],
+f"WARNING: same array_size (line {p1[0].line})")
+
+@script:python depends on org@
+p1 << as_dup.p1;
+p2 << as_dup.p2;
+@@
+
+coccilib.org.print_todo(p2[0],
+f"WARNING: same array_size (line {p1[0].line})")
+
+@as3@
+expression E1, E2, E3;
+@@
+
+array3_size(E1, E2, E3)
+
+@as3_next@
+expression subE1 <= as3.E1;
+expression subE2 <= as3.E2;
+expression subE3 <= as3.E3;
+expression as3.E1, as3.E2, as3.E3, E4;
+assignment operator aop;
+position p1, p2;
+@@
+
+* E1 * E2 * E3@p1
+  ... when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\) aop E4
+      when != \(&E1\|&E2\|&E3\|&subE1\|&subE2\|&subE3\)
+* array3_size(E1, E2, E3)@p2
+
+@script:python depends on report@
+p1 << as3_next.p1;
+p2 << as3_next.p2;
+@@
+
+coccilib.report.print_report(p1[0],
+f"WARNING: array3_size is used down the code (line {p2[0].line}) to compute \
+the same size")
+
+@script:python depends on org@
+p1 << as3_next.p1;
+p2 << as3_next.p2;
+@@
+
+coccilib.org.print_todo(p1[0],
+f"WARNING: array3_size is used down the code (line {p2[0].line}) to compute \
+the same size")
+
+@as3_prev@
+expression subE1 <= as3.E1;
+expression subE2 <= as3.E2;
+expression subE3 <= as3.E3;
+expression as3.E1, as3.E2, as3.E3, E4;
+assignment operator aop;
+position p1, p2;
+@@
+
+* array3_size(E1, E2, E3)@p1
+  ... when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\) aop E4
+      when != \(&E1\|&E2\|&E3\|&subE1\|&subE2\|&subE3\)
+* E1 * E2 * E3@p2
+
+@script:python depends on report@
+p1 << as3_prev.p1;
+p2 << as3_prev.p2;
+@@
+
+coccilib.report.print_report(p2[0],
+f"WARNING: array3_size is already used (line {p1[0].line}) to compute \
+the same size")
+
+@script:python depends on org@
+p1 << as3_prev.p1;
+p2 << as3_prev.p2;
+@@
+
+coccilib.org.print_todo(p2[0],
+f"WARNING: array3_size is already used (line {p1[0].line}) to compute \
+the same size")
+
+@as3_dup@
+expression subE1 <= as3.E1;
+expression subE2 <= as3.E2;
+expression subE3 <= as3.E3;
+expression as3.E1, as3.E2, as3.E3, E4;
+assignment operator aop;
+position p1, p2;
+@@
+
+* array3_size(E1, E2, E3)@p1
+  ... when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\) aop E4
+      when != \(&E1\|&E2\|&E3\|&subE1\|&subE2\|&subE3\)
+* array3_size(E1, E2, E3)@p2
+
+@script:python depends on report@
+p1 << as3_dup.p1;
+p2 << as3_dup.p2;
+@@
+
+coccilib.report.print_report(p2[0],
+f"WARNING: same array3_size (line {p1[0].line})")
+
+@script:python depends on org@
+p1 << as3_dup.p1;
+p2 << as3_dup.p2;
+@@
+
+coccilib.org.print_todo(p2[0],
+f"WARNING: same array3_size (line {p1[0].line})")
+
+@ss@
+expression E1, E2, E3;
+@@
+
+struct_size(E1, E2, E3)
+
+@ss_next@
+expression subE3 <= ss.E3;
+expression ss.E1, ss.E2, ss.E3, E4;
+assignment operator aop;
+position p1, p2;
+@@
+
+* E1 * E2 + E3@p1
+  ... when != \(E3\|subE3\) aop E4
+      when != \(&E3\|&subE3\)
+* struct_size(E1, E2, E3)@p2
+
+@script:python depends on report@
+p1 << ss_next.p1;
+p2 << ss_next.p2;
+@@
+
+coccilib.report.print_report(p1[0],
+f"WARNING: struct_size is used down the code (line {p2[0].line}) to compute \
+the same size")
+
+@script:python depends on org@
+p1 << ss_next.p1;
+p2 << ss_next.p2;
+@@
+
+coccilib.org.print_todo(p1[0],
+f"WARNING: struct_size is used down the code (line {p2[0].line}) to compute \
+the same size")
+
+@ss_prev@
+expression subE3 <= ss.E3;
+expression ss.E1, ss.E2, ss.E3, E4;
+assignment operator aop;
+position p1, p2;
+@@
+
+* struct_size(E1, E2, E3)@p1
+  ... when != \(E3\|subE3\) aop E4
+      when != \(&E3\|&subE3\)
+* E1 * E2 + E3@p2
+
+@script:python depends on report@
+p1 << ss_prev.p1;
+p2 << ss_prev.p2;
+@@
+
+coccilib.report.print_report(p2[0],
+f"WARNING: struct_size is already used (line {p1[0].line}) to compute \
+the same size")
+
+@script:python depends on org@
+p1 << ss_prev.p1;
+p2 << ss_prev.p2;
+@@
+
+coccilib.org.print_todo(p2[0],
+f"WARNING: struct_size is already used (line {p1[0].line}) to compute \
+the same size")
+
+@ss_dup@
+expression subE3 <= ss.E3;
+expression ss.E1, ss.E2, ss.E3, E4;
+assignment operator aop;
+position p1, p2;
+@@
+
+* struct_size(E1, E2, E3)@p1
+  ... when != \(E3\|subE3\) aop E4
+      when != \(&E3\|&subE3\)
+* struct_size(E1, E2, E3)@p2
+
+@script:python depends on report@
+p1 << ss_dup.p1;
+p2 << ss_dup.p2;
+@@
+
+coccilib.report.print_report(p2[0],
+f"WARNING: same struct_size (line {p1[0].line})")
+
+@script:python depends on org@
+p1 << ss_dup.p1;
+p2 << ss_dup.p2;
+@@
+
+coccilib.org.print_todo(p2[0],
+f"WARNING: same struct_size (line {p1[0].line})")
-- 
2.26.2

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
