Return-Path: <SRS0=D+wQ=BN=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29022C433DF
	for <cocci@archiver.kernel.org>; Mon,  3 Aug 2020 18:58:11 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02F04207DF
	for <cocci@archiver.kernel.org>; Mon,  3 Aug 2020 18:58:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F04207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 073IvumU020197;
	Mon, 3 Aug 2020 20:57:56 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1034B76BF;
	Mon,  3 Aug 2020 20:57:56 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8E2E341F5
 for <cocci@systeme.lip6.fr>; Mon,  3 Aug 2020 20:57:54 +0200 (CEST)
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
 [209.85.208.193])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 073IvruA005476
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 3 Aug 2020 20:57:54 +0200 (CEST)
Received: by mail-lj1-f193.google.com with SMTP id x9so40867279ljc.5
 for <cocci@systeme.lip6.fr>; Mon, 03 Aug 2020 11:57:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1QdS0fy0Eqxo2sy6ZpyXla/1BB0SZsD0LwltC3usfSw=;
 b=FuUTzyGnM7de1SLo/3EyMR3+RikjS5u+QZzqeyL392RV/VRLYz8Zfu4QqgklkZKDEb
 hfttS1MtRAaVHV/lNF9rQ6h4RA2+aHZpqTwv9JeTrigsRrkR2ADcwtmymyQ/W3XfG2Lt
 gIkqOa4gCDFgPb38QFkaqnwQBSxAwn57ACBByB2/5q67CZVsWoE413AwgCd7/68WENoL
 nOktnD9olGOoE6iHaIZ8cTdcByXHvjzMHq3JKZ40JSZKD2FBeQ4WWiVzGusjIEKp0Jy9
 9hfON+w/qZo2yn9MhMvQyLtuUqCnw/Mz9GUnNWE6QKNj1j8pqZDDrd3S/fn5QIxuZja8
 kLMw==
X-Gm-Message-State: AOAM5313gbGILpKOwccFBrQvf74Bkdb0Zf+SbBbCp60PX+xwHQnvwPlB
 yR1qkz+EqtmFG3xSWDsSbMs=
X-Google-Smtp-Source: ABdhPJwR24ba6sf0nTdpjdIarESYwacwL6Hv7073yML11fbIURk6Uk+CPKNRuICs5SO/OBiuNQXQSQ==
X-Received: by 2002:a2e:804b:: with SMTP id p11mr9084289ljg.221.1596481073216; 
 Mon, 03 Aug 2020 11:57:53 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru.
 [37.110.38.130])
 by smtp.googlemail.com with ESMTPSA id r8sm3042645lfm.42.2020.08.03.11.57.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 11:57:52 -0700 (PDT)
From: Denis Efremov <efremov@linux.com>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Mon,  3 Aug 2020 21:57:49 +0300
Message-Id: <20200803185749.39034-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200803105601.12162-1-efremov@linux.com>
References: <20200803105601.12162-1-efremov@linux.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 03 Aug 2020 20:57:56 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 03 Aug 2020 20:57:54 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: [Cocci] [PATCH v2] coccinelle: api: add kvmalloc script
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
Changes in v2:
 - binary operator cmp added
 - NULL comparisions simplified
 - "T x" case added to !patch mode

 scripts/coccinelle/api/kvmalloc.cocci | 142 ++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)
 create mode 100644 scripts/coccinelle/api/kvmalloc.cocci

diff --git a/scripts/coccinelle/api/kvmalloc.cocci b/scripts/coccinelle/api/kvmalloc.cocci
new file mode 100644
index 000000000000..20b22e3d0f74
--- /dev/null
+++ b/scripts/coccinelle/api/kvmalloc.cocci
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Find if/else condition with kmalloc/vmalloc calls.
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
+binary operator cmp = {<=, <, ==, >, >=};
+identifier x;
+type T;
+position p;
+@@
+
+(
+* if (size cmp E1 || ...)@p {
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
+* if (E == NULL)@p {
+    ...
+*   E = \(vmalloc\|vzalloc\|vmalloc_node\|vzalloc_node\)(..., size, ...)
+    ...
+  }
+|
+* T x = \(kmalloc\|kzalloc\|kcalloc\|kmalloc_node\|kzalloc_node\|
+*         kmalloc_array\|kmalloc_array_node\|kcalloc_node\)(..., size, ...);
+  ... when != x = E1
+      when != size = E1
+      when any
+* if (x == NULL)@p {
+    ...
+*   x = \(vmalloc\|vzalloc\|vmalloc_node\|vzalloc_node\)(..., size, ...)
+    ...
+  }
+)
+
+@depends on patch@
+expression E, E1, flags, size, node;
+binary operator cmp = {<=, <, ==, >, >=};
+identifier x;
+type T;
+@@
+
+(
+- if (size cmp E1)
+-    E = kmalloc(size, flags);
+- else
+-    E = vmalloc(size);
++ E = kvmalloc(size, flags);
+|
+- E = kmalloc(size, flags | __GFP_NOWARN);
+- if (E == NULL)
+-   E = vmalloc(size);
++ E = kvmalloc(size, flags);
+|
+- T x = kmalloc(size, flags | __GFP_NOWARN);
+- if (x == NULL)
+-   x = vmalloc(size);
++ T x = kvmalloc(size, flags);
+|
+- if (size cmp E1)
+-    E = kzalloc(size, flags);
+- else
+-    E = vzalloc(size);
++ E = kvzalloc(size, flags);
+|
+- E = kzalloc(size, flags | __GFP_NOWARN);
+- if (E == NULL)
+-   E = vzalloc(size);
++ E = kvzalloc(size, flags);
+|
+- T x = kzalloc(size, flags | __GFP_NOWARN);
+- if (x == NULL)
+-   x = vzalloc(size);
++ T x = kvzalloc(size, flags);
+|
+- if (size cmp E1)
+-    E = kmalloc_node(size, flags, node);
+- else
+-    E = vmalloc_node(size, node);
++ E = kvmalloc_node(size, flags, node);
+|
+- E = kmalloc_node(size, flags | __GFP_NOWARN, node);
+- if (E == NULL)
+-   E = vmalloc_node(size, node);
++ E = kvmalloc_node(size, flags, node);
+|
+- T x = kmalloc_node(size, flags | __GFP_NOWARN, node);
+- if (x == NULL)
+-   x = vmalloc_node(size, node);
++ T x = kvmalloc_node(size, flags, node);
+|
+- if (size cmp E1)
+-    E = kvzalloc_node(size, flags, node);
+- else
+-    E = vzalloc_node(size, node);
++ E = kvzalloc_node(size, flags, node);
+|
+- E = kvzalloc_node(size, flags | __GFP_NOWARN, node);
+- if (E == NULL)
+-   E = vzalloc_node(size, node);
++ E = kvzalloc_node(size, flags, node);
+|
+- T x = kvzalloc_node(size, flags | __GFP_NOWARN, node);
+- if (x == NULL)
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
