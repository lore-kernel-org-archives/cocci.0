Return-Path: <SRS0=BYw3=AD=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2886FC433E0
	for <cocci@archiver.kernel.org>; Mon, 22 Jun 2020 22:11:35 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6179D20738
	for <cocci@archiver.kernel.org>; Mon, 22 Jun 2020 22:11:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6179D20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05MMBIcm009195;
	Tue, 23 Jun 2020 00:11:18 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 04CE27773;
	Tue, 23 Jun 2020 00:11:18 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3A0ED3BAB
 for <cocci@systeme.lip6.fr>; Tue, 23 Jun 2020 00:11:16 +0200 (CEST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com
 [209.85.167.49])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05MMBEkJ006964
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 23 Jun 2020 00:11:15 +0200 (CEST)
Received: by mail-lf1-f49.google.com with SMTP id t74so10560782lff.2
 for <cocci@systeme.lip6.fr>; Mon, 22 Jun 2020 15:11:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OZuyls1cMAwtwJjsM2adYow5pWrQPEerf0VMA+Z2UtA=;
 b=XL396RtkP7d6EiTFHwBWrzGOC+a/bLIPTFSxwl43vDCh85mxfq26pgBKP4HJN7lEQp
 qHvraJAbXQ51UDXJzXrCHa8CwAVEEHdt4iLxJTSCrQEfIs8kTSFx8FpPZCw3jWHJLaUL
 ALOR/6MXeq/yfYRvAyYcYmZrAoN9DUR9MpVbwzIkbk/TFm+4R+Yo2pS/WTlp00ESOQul
 xk+KZgRTF/W41xf0VrpL/XtyqlxyDE7jIyjEkv6ZFEJAKWwzasGblm8IA1CLnZ2CI0GL
 JG6KxxSg8wtNU0NpeRjfm8ly12Ki3y2Izvm0C6qXxtozT5rdaqOYfWEx5I0b82KCnc+h
 H65A==
X-Gm-Message-State: AOAM532TXQFTfw4iUm2t0inEfXYExRJrMvukYDXKUlCVhem7vlvnK8c9
 AGdIDOMh3wGmnpjlsYMk8QU=
X-Google-Smtp-Source: ABdhPJzjbZiQ3nbSwFtSlsYo/E6omKmiTX7TPjlHrGObRdpZqKPeEco721dhmnBmTv4MkCeTGVLmRQ==
X-Received: by 2002:a19:e346:: with SMTP id c6mr11129516lfk.177.1592863874519; 
 Mon, 22 Jun 2020 15:11:14 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru.
 [37.110.38.130])
 by smtp.googlemail.com with ESMTPSA id a23sm3738767lfb.10.2020.06.22.15.11.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 15:11:13 -0700 (PDT)
From: Denis Efremov <efremov@linux.com>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Tue, 23 Jun 2020 01:10:56 +0300
Message-Id: <20200622221056.34241-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200615102045.4558-1-efremov@linux.com>
References: <20200615102045.4558-1-efremov@linux.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 23 Jun 2020 00:11:18 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 23 Jun 2020 00:11:15 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: [Cocci] [PATCH v4] coccinelle: misc: add array_size_dup script to
	detect missed overflow checks
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

Signed-off-by: Denis Efremov <efremov@linux.com>
---
Changes in v2:
 - python rules moved next to SmPL patterns
 - assignment operator used
 - struct_size patterns fixed to check only E3, since
   E1, E2 are sizeofs of a structure and a member
   of a structure
Changes in v3:
 - s/overlow/overflow/ typo fixed (thanks, Markus)
 - \(&E1\|&E2\) changed to &\(E1\|E2\)
 - print strings breaks removed
Changes in v4:
 - duplicates warning removed
 - python2 compatability in report&&org modes added
 - s/down the code/later/ warning changed
 - \(E1\|E2\|subE1\|subE2\) patterns simplified to \(subE1\|subE2\)

 scripts/coccinelle/misc/array_size_dup.cocci | 209 +++++++++++++++++++
 1 file changed, 209 insertions(+)
 create mode 100644 scripts/coccinelle/misc/array_size_dup.cocci

diff --git a/scripts/coccinelle/misc/array_size_dup.cocci b/scripts/coccinelle/misc/array_size_dup.cocci
new file mode 100644
index 000000000000..d3d635b2d4fc
--- /dev/null
+++ b/scripts/coccinelle/misc/array_size_dup.cocci
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Check for array_size(), array3_size(), struct_size() duplicates.
+/// Three types of patterns for these functions:
+///  1. An opencoded expression is used before array_size() to compute the same size
+///  2. An opencoded expression is used after array_size() to compute the same size
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
+  ... when != \(subE1\|subE2\) aop E3
+      when != &\(subE1\|subE2\)
+* array_size(E1, E2)@p2
+
+@script:python depends on report@
+p1 << as_next.p1;
+p2 << as_next.p2;
+@@
+
+msg = "WARNING: array_size is used later (line %s) to compute the same size" % (p2[0].line)
+coccilib.report.print_report(p1[0], msg)
+
+@script:python depends on org@
+p1 << as_next.p1;
+p2 << as_next.p2;
+@@
+
+msg = "WARNING: array_size is used later (line %s) to compute the same size" % (p2[0].line)
+coccilib.org.print_todo(p1[0], msg)
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
+  ... when != \(subE1\|subE2\) aop E3
+      when != &\(subE1\|subE2\)
+* E1 * E2@p2
+
+@script:python depends on report@
+p1 << as_prev.p1;
+p2 << as_prev.p2;
+@@
+
+msg = "WARNING: array_size is already used (line %s) to compute the same size" % (p1[0].line)
+coccilib.report.print_report(p2[0], msg)
+
+@script:python depends on org@
+p1 << as_prev.p1;
+p2 << as_prev.p2;
+@@
+
+msg = "WARNING: array_size is already used (line %s) to compute the same size" % (p1[0].line)
+coccilib.org.print_todo(p2[0], msg)
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
+  ... when != \(subE1\|subE2\|subE3\) aop E4
+      when != &\(subE1\|subE2\|subE3\)
+* array3_size(E1, E2, E3)@p2
+
+@script:python depends on report@
+p1 << as3_next.p1;
+p2 << as3_next.p2;
+@@
+
+msg = "WARNING: array3_size is used later (line %s) to compute the same size" % (p2[0].line)
+coccilib.report.print_report(p1[0], msg)
+
+@script:python depends on org@
+p1 << as3_next.p1;
+p2 << as3_next.p2;
+@@
+
+msg = "WARNING: array3_size is used later (line %s) to compute the same size" % (p2[0].line)
+coccilib.org.print_todo(p1[0], msg)
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
+  ... when != \(subE1\|subE2\|subE3\) aop E4
+      when != &\(subE1\|subE2\|subE3\)
+* E1 * E2 * E3@p2
+
+@script:python depends on report@
+p1 << as3_prev.p1;
+p2 << as3_prev.p2;
+@@
+
+msg = "WARNING: array3_size is already used (line %s) to compute the same size" % (p1[0].line)
+coccilib.report.print_report(p2[0], msg)
+
+@script:python depends on org@
+p1 << as3_prev.p1;
+p2 << as3_prev.p2;
+@@
+
+msg = "WARNING: array3_size is already used (line %s) to compute the same size" % (p1[0].line)
+coccilib.org.print_todo(p2[0], msg)
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
+  ... when != subE3 aop E4
+      when != &subE3
+* struct_size(E1, E2, E3)@p2
+
+@script:python depends on report@
+p1 << ss_next.p1;
+p2 << ss_next.p2;
+@@
+
+msg = "WARNING: struct_size is used later (line %s) to compute the same size" % (p2[0].line)
+coccilib.report.print_report(p1[0], msg)
+
+@script:python depends on org@
+p1 << ss_next.p1;
+p2 << ss_next.p2;
+@@
+
+msg = "WARNING: struct_size is used later (line %s) to compute the same size" % (p2[0].line)
+coccilib.org.print_todo(p1[0], msg)
+
+@ss_prev@
+expression subE3 <= ss.E3;
+expression ss.E1, ss.E2, ss.E3, E4;
+assignment operator aop;
+position p1, p2;
+@@
+
+* struct_size(E1, E2, E3)@p1
+  ... when != subE3 aop E4
+      when != &subE3
+* E1 * E2 + E3@p2
+
+@script:python depends on report@
+p1 << ss_prev.p1;
+p2 << ss_prev.p2;
+@@
+
+msg = "WARNING: struct_size is already used (line %s) to compute the same size" % (p1[0].line)
+coccilib.report.print_report(p2[0], msg)
+
+@script:python depends on org@
+p1 << ss_prev.p1;
+p2 << ss_prev.p2;
+@@
+
+msg = "WARNING: struct_size is already used (line %s) to compute the same size" % (p1[0].line)
+coccilib.org.print_todo(p2[0], msg)
-- 
2.26.2

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
