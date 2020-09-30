Return-Path: <SRS0=m8hJ=DH=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E01C4727C
	for <cocci@archiver.kernel.org>; Wed, 30 Sep 2020 16:01:41 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8540206F7
	for <cocci@archiver.kernel.org>; Wed, 30 Sep 2020 16:01:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8540206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08UG1ARD013741;
	Wed, 30 Sep 2020 18:01:10 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 6E43B7794;
	Wed, 30 Sep 2020 18:01:10 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A85C93F6C
 for <cocci@systeme.lip6.fr>; Wed, 30 Sep 2020 18:01:08 +0200 (CEST)
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com
 [209.85.167.65])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08UG1704026641
 for <cocci@systeme.lip6.fr>; Wed, 30 Sep 2020 18:01:08 +0200 (CEST)
Received: by mail-lf1-f65.google.com with SMTP id b12so2777108lfp.9
 for <cocci@systeme.lip6.fr>; Wed, 30 Sep 2020 09:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ycDxrhlZbMZ3QAe5FRdISwHYI96aiWhTWEOCVCIV1mY=;
 b=oRGBrUFs4/L2sbCVpH7b539qGEGsZhlV9pzYLUC4WANVOvElnT08KctHys5QpOkmN9
 a0/ERBwsziCq1CGVCLxrGbhLBe6ukqmddbwRditO6RxHZ00JsMuEtjp3khZEHF04vgfs
 ad9JK/QfVtRSCRAe8MBSGVfmtpMcK0CBQIGRNYJOzGKUeKSckRffMGVMmNja/ctb9Gs5
 /kirQdvLy6s04jdC250m3Gcx/8XCYO7Ar8jsVR+i+qkN4ddR54OZBwDdpkMuqbCIwwfT
 9L7iroCok6UXkdcQ4ZVEHTJHNiManRj9VoHrhkCyorqq9SoefhkVh96V5p3PoDF96dpr
 DnCQ==
X-Gm-Message-State: AOAM533EeJMfGzyiNa70yY9nJCehhd3T9UTf2MhlYpuv0fMktW7DL1bm
 JbHUBJgmlFzfxwe3DKoy3ys=
X-Google-Smtp-Source: ABdhPJyxotBYkge4LIgChQyvbG7H74KmdrtQx+Ra7kF49AzbAQIBUykQKgNZodD/EQEl9gN/s+J4sw==
X-Received: by 2002:a19:614b:: with SMTP id m11mr1222865lfk.6.1601481667344;
 Wed, 30 Sep 2020 09:01:07 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru.
 [37.110.38.130])
 by smtp.googlemail.com with ESMTPSA id c1sm194909ljd.105.2020.09.30.09.01.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 09:01:06 -0700 (PDT)
From: Denis Efremov <efremov@linux.com>
To: julia.lawall@inria.fr
Date: Wed, 30 Sep 2020 19:00:46 +0300
Message-Id: <20200930160046.726661-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200804063245.8383-1-efremov@linux.com>
References: <20200804063245.8383-1-efremov@linux.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 30 Sep 2020 18:01:10 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 30 Sep 2020 18:01:08 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: [Cocci] [PATCH v4] coccinelle: api: add kvmalloc script
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
Changes in v4:
 - pattern updated to match only GFP_KERNEL/__GFP_NOWARN flags
   to avoid possible false-positives

All patches are sent:
[1] https://lore.kernel.org/patchwork/patch/1296428/
[2] https://lore.kernel.org/patchwork/patch/1296636/
[3] https://lore.kernel.org/patchwork/patch/1282895/
[4] https://lore.kernel.org/patchwork/patch/1296631/

 scripts/coccinelle/api/kvmalloc.cocci | 256 ++++++++++++++++++++++++++
 1 file changed, 256 insertions(+)
 create mode 100644 scripts/coccinelle/api/kvmalloc.cocci

diff --git a/scripts/coccinelle/api/kvmalloc.cocci b/scripts/coccinelle/api/kvmalloc.cocci
new file mode 100644
index 000000000000..c30dab718a49
--- /dev/null
+++ b/scripts/coccinelle/api/kvmalloc.cocci
@@ -0,0 +1,256 @@
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
+identifier flags;
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
+*          kmalloc_array\|kmalloc_array_node\|kcalloc_node\)
+*          (..., size, \(flags\|GFP_KERNEL\|\(GFP_KERNEL\|flags\)|__GFP_NOWARN\), ...)
+    ...
+  } else {
+    ...
+*    E = \(vmalloc\|vzalloc\|vmalloc_node\|vzalloc_node\)(..., size, ...)
+    ...
+  }
+|
+* E = \(kmalloc\|kzalloc\|kcalloc\|kmalloc_node\|kzalloc_node\|
+*       kmalloc_array\|kmalloc_array_node\|kcalloc_node\)
+*       (..., size, \(flags\|GFP_KERNEL\|\(GFP_KERNEL\|flags\)|__GFP_NOWARN\), ...)
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
+*         kmalloc_array\|kmalloc_array_node\|kcalloc_node\)
+*         (..., size, \(flags\|GFP_KERNEL\|\(GFP_KERNEL\|flags\)|__GFP_NOWARN\), ...);
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
+expression E, E1, size, node;
+binary operator cmp = {<=, <, ==, >, >=};
+identifier flags, x;
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
+- if (size cmp E1)
+-    E = kmalloc(size, \(GFP_KERNEL\|GFP_KERNEL|__GFP_NOWARN\));
+- else
+-    E = vmalloc(size);
++ E = kvmalloc(size, GFP_KERNEL);
+|
+- E = kmalloc(size, flags | __GFP_NOWARN);
+- if (E == NULL)
+-   E = vmalloc(size);
++ E = kvmalloc(size, flags);
+|
+- E = kmalloc(size, \(GFP_KERNEL\|GFP_KERNEL|__GFP_NOWARN\));
+- if (E == NULL)
+-   E = vmalloc(size);
++ E = kvmalloc(size, GFP_KERNEL);
+|
+- T x = kmalloc(size, flags | __GFP_NOWARN);
+- if (x == NULL)
+-   x = vmalloc(size);
++ T x = kvmalloc(size, flags);
+|
+- T x = kmalloc(size, \(GFP_KERNEL\|GFP_KERNEL|__GFP_NOWARN\));
+- if (x == NULL)
+-   x = vmalloc(size);
++ T x = kvmalloc(size, GFP_KERNEL);
+|
+- if (size cmp E1)
+-    E = kzalloc(size, flags);
+- else
+-    E = vzalloc(size);
++ E = kvzalloc(size, flags);
+|
+- if (size cmp E1)
+-    E = kzalloc(size, \(GFP_KERNEL\|GFP_KERNEL|__GFP_NOWARN\));
+- else
+-    E = vzalloc(size);
++ E = kvzalloc(size, GFP_KERNEL);
+|
+- E = kzalloc(size, flags | __GFP_NOWARN);
+- if (E == NULL)
+-   E = vzalloc(size);
++ E = kvzalloc(size, flags);
+|
+- E = kzalloc(size, \(GFP_KERNEL\|GFP_KERNEL|__GFP_NOWARN\));
+- if (E == NULL)
+-   E = vzalloc(size);
++ E = kvzalloc(size, GFP_KERNEL);
+|
+- T x = kzalloc(size, flags | __GFP_NOWARN);
+- if (x == NULL)
+-   x = vzalloc(size);
++ T x = kvzalloc(size, flags);
+|
+- T x = kzalloc(size, \(GFP_KERNEL\|GFP_KERNEL|__GFP_NOWARN\));
+- if (x == NULL)
+-   x = vzalloc(size);
++ T x = kvzalloc(size, GFP_KERNEL);
+|
+- if (size cmp E1)
+-    E = kmalloc_node(size, flags, node);
+- else
+-    E = vmalloc_node(size, node);
++ E = kvmalloc_node(size, flags, node);
+|
+- if (size cmp E1)
+-    E = kmalloc_node(size, \(GFP_KERNEL\|GFP_KERNEL|__GFP_NOWARN\), node);
+- else
+-    E = vmalloc_node(size, node);
++ E = kvmalloc_node(size, GFP_KERNEL, node);
+|
+- E = kmalloc_node(size, flags | __GFP_NOWARN, node);
+- if (E == NULL)
+-   E = vmalloc_node(size, node);
++ E = kvmalloc_node(size, flags, node);
+|
+- E = kmalloc_node(size, \(GFP_KERNEL\|GFP_KERNEL|__GFP_NOWARN\), node);
+- if (E == NULL)
+-   E = vmalloc_node(size, node);
++ E = kvmalloc_node(size, GFP_KERNEL, node);
+|
+- T x = kmalloc_node(size, flags | __GFP_NOWARN, node);
+- if (x == NULL)
+-   x = vmalloc_node(size, node);
++ T x = kvmalloc_node(size, flags, node);
+|
+- T x = kmalloc_node(size, \(GFP_KERNEL\|GFP_KERNEL|__GFP_NOWARN\), node);
+- if (x == NULL)
+-   x = vmalloc_node(size, node);
++ T x = kvmalloc_node(size, GFP_KERNEL, node);
+|
+- if (size cmp E1)
+-    E = kvzalloc_node(size, flags, node);
+- else
+-    E = vzalloc_node(size, node);
++ E = kvzalloc_node(size, flags, node);
+|
+- if (size cmp E1)
+-    E = kvzalloc_node(size, \(GFP_KERNEL\|GFP_KERNEL|__GFP_NOWARN\), node);
+- else
+-    E = vzalloc_node(size, node);
++ E = kvzalloc_node(size, GFP_KERNEL, node);
+|
+- E = kvzalloc_node(size, flags | __GFP_NOWARN, node);
+- if (E == NULL)
+-   E = vzalloc_node(size, node);
++ E = kvzalloc_node(size, flags, node);
+|
+- E = kvzalloc_node(size, \(GFP_KERNEL\|GFP_KERNEL|__GFP_NOWARN\), node);
+- if (E == NULL)
+-   E = vzalloc_node(size, node);
++ E = kvzalloc_node(size, GFP_KERNEL, node);
+|
+- T x = kvzalloc_node(size, flags | __GFP_NOWARN, node);
+- if (x == NULL)
+-   x = vzalloc_node(size, node);
++ T x = kvzalloc_node(size, flags, node);
+|
+- T x = kvzalloc_node(size, \(GFP_KERNEL\|GFP_KERNEL|__GFP_NOWARN\), node);
+- if (x == NULL)
+-   x = vzalloc_node(size, node);
++ T x = kvzalloc_node(size, GFP_KERNEL, node);
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
+coccilib.report.print_report(p[0], "WARNING opportunity for kvmalloc")
+
+@script: python depends on org@
+p << kvmalloc.p;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING opportunity for kvmalloc")
+
+@script: python depends on report@
+p << kvfree.p;
+@@
+
+coccilib.report.print_report(p[0], "WARNING opportunity for kvfree")
+
+@script: python depends on org@
+p << kvfree.p;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING opportunity for kvfree")
-- 
2.26.2

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
