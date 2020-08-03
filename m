Return-Path: <SRS0=D+wQ=BN=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500C7C433E0
	for <cocci@archiver.kernel.org>; Mon,  3 Aug 2020 10:56:38 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD8D32064B
	for <cocci@archiver.kernel.org>; Mon,  3 Aug 2020 10:56:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD8D32064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 073AuE2i015180;
	Mon, 3 Aug 2020 12:56:14 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2929376BF;
	Mon,  3 Aug 2020 12:56:14 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8950C41F5
 for <cocci@systeme.lip6.fr>; Mon,  3 Aug 2020 12:56:12 +0200 (CEST)
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com
 [209.85.167.67])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 073AuBK5013114
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 3 Aug 2020 12:56:11 +0200 (CEST)
Received: by mail-lf1-f67.google.com with SMTP id 140so20212149lfi.5
 for <cocci@systeme.lip6.fr>; Mon, 03 Aug 2020 03:56:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MMWR59ppgwvDkLer5o1rKBFEg1vToLpYYmzQrSMwZDA=;
 b=f8hPMTPiL0yyiJHepyo1qgkVONlbgzMQucuAV+hQkY2DuL6ySkxCgFAchISjg6CMcu
 KnFftRb0xdbD/RynYlT7CcNXQCPFTZyhp+90gOv7lSNRMulf50vrW/JHurKEf1fWrzIz
 3AxTedZMFOCRvA3bJett4EsVboqC7Fl+zJ5sstSdU73ytQt2FsxhQOIbyh0+uoQQ68ww
 MnT8H6W/ZVNxyHEgEqJLWN0veq1fKlVOIHn0QXtjhM1InMTnxo0iEl/okuoFUaSScfXG
 gnuBKhVxln008a4yfcWhwvBPXbcfGCYQcY6vDzwIsIxJPiVQsvcbLKrhLW9+f/JhTE3o
 HMrQ==
X-Gm-Message-State: AOAM532fFIdLIuZxNCIqLRE8rAqhYt/4lsQ1JE84MMt/XpmHzg0cx4YK
 2oDi1++30bahm8w7f+MgxkU=
X-Google-Smtp-Source: ABdhPJzpYVnZgPuVjD+eeb26rEsIXasQclbm8WTkDfDp5i5cUFrnfCSrvUWAc4ACFTmaGAAlzfFE5A==
X-Received: by 2002:a19:c206:: with SMTP id l6mr8177709lfc.152.1596452171263; 
 Mon, 03 Aug 2020 03:56:11 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru.
 [37.110.38.130])
 by smtp.googlemail.com with ESMTPSA id d5sm878932ljc.80.2020.08.03.03.56.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 03:56:10 -0700 (PDT)
From: Denis Efremov <efremov@linux.com>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Mon,  3 Aug 2020 13:56:01 +0300
Message-Id: <20200803105601.12162-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 03 Aug 2020 12:56:14 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 03 Aug 2020 12:56:12 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: [Cocci] [PATCH] coccinelle: api: add kvmalloc script
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

Suggest kvmalloc instead of opencoded kmalloc && vmalloc condition.

Signed-off-by: Denis Efremov <efremov@linux.com>
---

If coccinelle fails with "Segmentation fault" during analysis, then
one needs to increase stack limit, e.g. ulimit -s 32767.

Current, I've sent only one patch for this rule and will send the rest
after the merge window. https://lkml.org/lkml/2020/7/31/986

 scripts/coccinelle/api/kvmalloc.cocci | 127 ++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)
 create mode 100644 scripts/coccinelle/api/kvmalloc.cocci

diff --git a/scripts/coccinelle/api/kvmalloc.cocci b/scripts/coccinelle/api/kvmalloc.cocci
new file mode 100644
index 000000000000..76d6aeab7c09
--- /dev/null
+++ b/scripts/coccinelle/api/kvmalloc.cocci
@@ -0,0 +1,127 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Find conditions in code for kmalloc/vmalloc calls.
+/// Suggest to use kvmalloc instead.
+///
+// Confidence: High
+// Copyright: (C) 2020 Denis Efremov ISPRAS
+// Options: --no-includes --include-headers
+//
+
+virtual patch
+virtual report
+virtual org
+virtual context
+
+@opportunity depends on !patch@
+expression E, E1, size;
+position p;
+@@
+
+(
+* if (\(size <= E1\|size < E1\|size == E1\|size > E1\) || ...)@p {
+    ...
+*    E = \(kmalloc\|kzalloc\|kcalloc\|kmalloc_node\|kzalloc_node\|
+*          kmalloc_array\|kmalloc_array_node\|kcalloc_node\)(..., size, ...)
+    ...
+  } else {
+    ...
+*    E = \(vmalloc\|vzalloc\|vmalloc_node\|vzalloc_node\)(..., size, ...)
+    ...
+  }
+|
+* E = \(kmalloc\|kzalloc\|kcalloc\|kmalloc_node\|kzalloc_node\|
+*       kmalloc_array\|kmalloc_array_node\|kcalloc_node\)(..., size, ...)
+  ... when != E = E1
+      when != size = E1
+      when any
+* if (\(!E\|E == NULL\))@p {
+    ...
+*   E = \(vmalloc\|vzalloc\|vmalloc_node\|vzalloc_node\)(..., size, ...)
+    ...
+  }
+)
+
+@depends on patch@
+expression E, E1, flags, size, node;
+identifier x;
+type T;
+@@
+
+(
+- if (\(size <= E1\|size < E1\|size == E1\|size > E1\))
+-    E = kmalloc(size, flags);
+- else
+-    E = vmalloc(size);
++ E = kvmalloc(size, flags);
+|
+- E = kmalloc(size, flags | __GFP_NOWARN);
+- if (\(!E\|E == NULL\))
+-   E = vmalloc(size);
++ E = kvmalloc(size, flags);
+|
+- T x = kmalloc(size, flags | __GFP_NOWARN);
+- if (\(!x\|x == NULL\))
+-   x = vmalloc(size);
++ T x = kvmalloc(size, flags);
+|
+- if (\(size <= E1\|size < E1\|size == E1\|size > E1\))
+-    E = kzalloc(size, flags);
+- else
+-    E = vzalloc(size);
++ E = kvzalloc(size, flags);
+|
+- E = kzalloc(size, flags | __GFP_NOWARN);
+- if (\(!E\|E == NULL\))
+-   E = vzalloc(size);
++ E = kvzalloc(size, flags);
+|
+- T x = kzalloc(size, flags | __GFP_NOWARN);
+- if (\(!x\|x == NULL\))
+-   x = vzalloc(size);
++ T x = kvzalloc(size, flags);
+|
+- if (\(size <= E1\|size < E1\|size == E1\|size > E1\))
+-    E = kmalloc_node(size, flags, node);
+- else
+-    E = vmalloc_node(size, node);
++ E = kvmalloc_node(size, flags, node);
+|
+- E = kmalloc_node(size, flags | __GFP_NOWARN, node);
+- if (\(!E\|E == NULL\))
+-   E = vmalloc_node(size, node);
++ E = kvmalloc_node(size, flags, node);
+|
+- T x = kmalloc_node(size, flags | __GFP_NOWARN, node);
+- if (\(!x\|x == NULL\))
+-   x = vmalloc_node(size, node);
++ T x = kvmalloc_node(size, flags, node);
+|
+- if (\(size <= E1\|size < E1\|size == E1\|size > E1\))
+-    E = kvzalloc_node(size, flags, node);
+- else
+-    E = vzalloc_node(size, node);
++ E = kvzalloc_node(size, flags, node);
+|
+- E = kvzalloc_node(size, flags | __GFP_NOWARN, node);
+- if (\(!E\|E == NULL\))
+-   E = vzalloc_node(size, node);
++ E = kvzalloc_node(size, flags, node);
+|
+- T x = kvzalloc_node(size, flags | __GFP_NOWARN, node);
+- if (\(!x\|x == NULL\))
+-   x = vzalloc_node(size, node);
++ T x = kvzalloc_node(size, flags, node);
+)
+
+@script: python depends on report@
+p << opportunity.p;
+@@
+
+coccilib.report.print_report(p[0], "WARNING: opportunity for kvmalloc")
+
+@script: python depends on org@
+p << opportunity.p;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING: opportunity for kvmalloc")
-- 
2.26.2

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
