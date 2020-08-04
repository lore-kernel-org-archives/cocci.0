Return-Path: <SRS0=V5+4=BO=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C988C433E1
	for <cocci@archiver.kernel.org>; Tue,  4 Aug 2020 06:33:44 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE8D120722
	for <cocci@archiver.kernel.org>; Tue,  4 Aug 2020 06:33:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE8D120722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0746XNDZ011067;
	Tue, 4 Aug 2020 08:33:23 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7791876BF;
	Tue,  4 Aug 2020 08:33:23 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D5423428B
 for <cocci@systeme.lip6.fr>; Tue,  4 Aug 2020 08:33:21 +0200 (CEST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com
 [209.85.208.174])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0746XKFj018336
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 4 Aug 2020 08:33:21 +0200 (CEST)
Received: by mail-lj1-f174.google.com with SMTP id h19so42280583ljg.13
 for <cocci@systeme.lip6.fr>; Mon, 03 Aug 2020 23:33:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Qeu5MDd4KBBCgrdFklrimt69m51WRq2SozOPA79zyA0=;
 b=pKFktyLJ3Or0hxF9bZL5SVVgOPP+0fIvIN25aCw8KAp4idvqo0FunQU/KQC9n6N1WM
 hZQQXPf1zGt6MBa5cV1xlUCdxEabvl79KLDLzwMWGKXS5Jl7LAq+nEyXgLQCCucBJKmY
 IrhMBNrSWiTNOWiP3+rOOTWu7v1PpK+uMa6BAB4ys6CncOwV9ReL3JWBvjnjmVoC+WPA
 dtgN+5TSUOdUO/RunzKFSCUuAuZc6Nf/Pe+g1X9qXEj3YTaTP4hYK/Oe7++hxg9WL73z
 jltIPzOJjhVbsVemBxcalc8f8kX86GsC9oe58Jz2c5UdXXqKniPZDy58TTUSWkhc5r2O
 1ygw==
X-Gm-Message-State: AOAM5317MAIzgQ5IcI8gjp11eVFxK9yZiku3EYZFUIQjtdQCBnG6kkvT
 kAvbB7yp9FX2TX7R0iU9Gyc=
X-Google-Smtp-Source: ABdhPJxvR5yrqcUJ2/9DRAG7rLbEfRcNzZ1De7ZgEmZ/4U/tGqD0OQCp0Yj/iwH6U1nwMTPZGQ1Rmg==
X-Received: by 2002:a2e:80a:: with SMTP id 10mr9713537lji.103.1596522800505;
 Mon, 03 Aug 2020 23:33:20 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru.
 [37.110.38.130])
 by smtp.googlemail.com with ESMTPSA id b16sm5086244ljk.24.2020.08.03.23.33.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 23:33:19 -0700 (PDT)
From: Denis Efremov <efremov@linux.com>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Tue,  4 Aug 2020 09:32:45 +0300
Message-Id: <20200804063245.8383-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200803105601.12162-1-efremov@linux.com>
References: <20200803105601.12162-1-efremov@linux.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 04 Aug 2020 08:33:23 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 04 Aug 2020 08:33:21 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: [Cocci] [PATCH v3] coccinelle: api: add kvmalloc script
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

Suggest kvmalloc, kvfree instead of opencoded patterns.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
Changes in v2:
 - binary operator cmp added
 - NULL comparisions simplified
 - "T x" case added to !patch mode
Changes in v3:
 - kvfree rules added

 scripts/coccinelle/api/kvmalloc.cocci | 188 ++++++++++++++++++++++++++
 1 file changed, 188 insertions(+)
 create mode 100644 scripts/coccinelle/api/kvmalloc.cocci

diff --git a/scripts/coccinelle/api/kvmalloc.cocci b/scripts/coccinelle/api/kvmalloc.cocci
new file mode 100644
index 000000000000..2cb9281cc092
--- /dev/null
+++ b/scripts/coccinelle/api/kvmalloc.cocci
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Find if/else condition with kmalloc/vmalloc calls.
+/// Suggest to use kvmalloc instead. Same for kvfree.
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
+@initialize:python@
+@@
+filter = frozenset(['kvfree'])
+
+def relevant(p):
+    return not (filter & {el.current_element for el in p})
+
+@kvmalloc depends on !patch@
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
+@kvfree depends on !patch@
+expression E;
+position p : script:python() { relevant(p) };
+@@
+
+* if (is_vmalloc_addr(E))@p {
+    ...
+*   vfree(E)
+    ...
+  } else {
+    ... when != krealloc(E, ...)
+        when any
+*   \(kfree\|kzfree\)(E)
+    ...
+  }
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
+@depends on patch@
+expression E;
+position p : script:python() { relevant(p) };
+@@
+
+- if (is_vmalloc_addr(E))@p
+-   vfree(E);
+- else
+-   kfree(E);
++ kvfree(E);
+
+@script: python depends on report@
+p << kvmalloc.p;
+@@
+
+coccilib.report.print_report(p[0], "WARNING: opportunity for kvmalloc")
+
+@script: python depends on org@
+p << kvmalloc.p;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING: opportunity for kvmalloc")
+
+@script: python depends on report@
+p << kvfree.p;
+@@
+
+coccilib.report.print_report(p[0], "WARNING: opportunity for kvfree")
+
+@script: python depends on org@
+p << kvfree.p;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING: opportunity for kvfree")
-- 
2.26.2

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
