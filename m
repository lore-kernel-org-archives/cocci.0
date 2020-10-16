Return-Path: <SRS0=kdUr=DX=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB03FC433DF
	for <cocci@archiver.kernel.org>; Fri, 16 Oct 2020 08:55:45 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 971C420663
	for <cocci@archiver.kernel.org>; Fri, 16 Oct 2020 08:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 971C420663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09G8tFsH024713;
	Fri, 16 Oct 2020 10:55:15 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 9ECA9778E;
	Fri, 16 Oct 2020 10:55:15 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 87D8D578C
 for <cocci@systeme.lip6.fr>; Fri, 16 Oct 2020 10:55:13 +0200 (CEST)
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com
 [209.85.167.65])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09G8tCeH004350
 for <cocci@systeme.lip6.fr>; Fri, 16 Oct 2020 10:55:12 +0200 (CEST)
Received: by mail-lf1-f65.google.com with SMTP id d24so1910635lfa.8
 for <cocci@systeme.lip6.fr>; Fri, 16 Oct 2020 01:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XqET9rq5UxV1QJoA7trPocYpAymNdwYe4u5Sw7ENZqk=;
 b=b53Ajepk4N5Ly9r0nvagJmNKoePS7ZPRYfmBoW64xJGt3Km5sHTVhSSHaq++BU6mIW
 WOTxtxT/mrzwbsxsgi+h6o2POwLOS1c90erHutP4ygawcHUs7kHmhiU4WWJpqmOkLQqB
 n4wa0OtHMI3FqfI0yDazX6yGquPChQrsiHxQ7TCn/uYsE+u1UhQe0fH4bmhllmAeOtOw
 mtnxLSHkylKO5tAya82zhZ5Pu/YDyv7JMMpvJfpO3Wr/KIb/hm6hmlUkrNHWsuzBxB9n
 T09PZ4zZh0IokRniB/Yht+RQGNbgA/4yR7vW0xaMlAHXGJ7JT/jwunPhtvaGSvU8k1fM
 ITVQ==
X-Gm-Message-State: AOAM532b3FysAZerYJe3kb1iEhK5b/p37a4nCR0s5gL7kzFU6d+w/Uvu
 3j2iLST0N55IS/DxGoDS0sk=
X-Google-Smtp-Source: ABdhPJy4hfqqushixS4hdONPleRqaLq5YILjiwJg4Ho1OlUyak0TrmzOe3pOoVUh1+0Tmsq9o+sD5g==
X-Received: by 2002:ac2:4833:: with SMTP id 19mr795307lft.136.1602838512489;
 Fri, 16 Oct 2020 01:55:12 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru.
 [37.110.38.130])
 by smtp.googlemail.com with ESMTPSA id g9sm612889lfd.1.2020.10.16.01.55.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2020 01:55:11 -0700 (PDT)
From: Denis Efremov <efremov@linux.com>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Fri, 16 Oct 2020 11:54:42 +0300
Message-Id: <20201016085442.23299-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605204237.85055-1-efremov@linux.com>
References: <20200605204237.85055-1-efremov@linux.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 16 Oct 2020 10:55:15 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 16 Oct 2020 10:55:12 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Alexander Popov <alex.popov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [Cocci] [PATCH v8] coccinelle: api: add kfree_mismatch script
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

Check that alloc and free types of functions match each other.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
Changes in v2:
 - Lines are limited to 80 characters where possible
 - Confidence changed from High to Medium because of 
   fs/btrfs/send.c:1119 false-positive
 - __vmalloc_area_node() explicitly excluded from analysis
   instead of !(file in "mm/vmalloc.c") condition
Changes in v3:
 - prints style in org && report modes changed for python2
Changes in v4:
 - missing msg argument to print_todo fixed
Changes in v5:
 - fix position p in kfree rule
 - move @kok and @v positions in choice rule after the arguments
 - remove kvmalloc suggestions
Changes in v6:
 - more asterisks added in context mode
 - second @kok added to the choice rule
Changes in v7:
 - file renamed to kfree_mismatch.cocci
 - python function relevant() removed
 - additional rule for filtering free positions added
 - btrfs false-positive fixed
 - confidence level changed to high
 - kvfree_switch rule added
 - names for position variables changed to @a (alloc) and @f (free)
Changes in v8:
 - kzfree() replaced with kfree_sensitive()
 - "position f != free.fok;" simplified to "position f;" in patch
   and kvfree_switch rules

 scripts/coccinelle/api/kfree_mismatch.cocci | 229 ++++++++++++++++++++
 1 file changed, 229 insertions(+)
 create mode 100644 scripts/coccinelle/api/kfree_mismatch.cocci

diff --git a/scripts/coccinelle/api/kfree_mismatch.cocci b/scripts/coccinelle/api/kfree_mismatch.cocci
new file mode 100644
index 000000000000..843b794fac7b
--- /dev/null
+++ b/scripts/coccinelle/api/kfree_mismatch.cocci
@@ -0,0 +1,229 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Check that kvmalloc'ed memory is freed by kfree functions,
+/// vmalloc'ed by vfree functions and kvmalloc'ed by kvfree
+/// functions.
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
+@alloc@
+expression E, E1;
+position kok, vok;
+@@
+
+(
+  if (...) {
+    ...
+    E = \(kmalloc\|kzalloc\|krealloc\|kcalloc\|
+          kmalloc_node\|kzalloc_node\|kmalloc_array\|
+          kmalloc_array_node\|kcalloc_node\)(...)@kok
+    ...
+  } else {
+    ...
+    E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|
+          vzalloc_node\|vmalloc_exec\|vmalloc_32\|
+          vmalloc_32_user\|__vmalloc\|__vmalloc_node_range\|
+          __vmalloc_node\)(...)@vok
+    ...
+  }
+|
+  E = \(kmalloc\|kzalloc\|krealloc\|kcalloc\|kmalloc_node\|kzalloc_node\|
+        kmalloc_array\|kmalloc_array_node\|kcalloc_node\)(...)@kok
+  ... when != E = E1
+      when any
+  if (E == NULL) {
+    ...
+    E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|
+          vzalloc_node\|vmalloc_exec\|vmalloc_32\|
+          vmalloc_32_user\|__vmalloc\|__vmalloc_node_range\|
+          __vmalloc_node\)(...)@vok
+    ...
+  }
+)
+
+@free@
+expression E;
+position fok;
+@@
+
+  E = \(kvmalloc\|kvzalloc\|kvcalloc\|kvzalloc_node\|kvmalloc_node\|
+        kvmalloc_array\)(...)
+  ...
+  kvfree(E)@fok
+
+@vfree depends on !patch@
+expression E;
+position a != alloc.kok;
+position f != free.fok;
+@@
+
+* E = \(kmalloc\|kzalloc\|krealloc\|kcalloc\|kmalloc_node\|
+*       kzalloc_node\|kmalloc_array\|kmalloc_array_node\|
+*       kcalloc_node\)(...)@a
+  ... when != if (...) { ... E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|vmalloc_exec\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|__vmalloc_node_range\|__vmalloc_node\)(...); ... }
+      when != is_vmalloc_addr(E)
+      when any
+* \(vfree\|vfree_atomic\|kvfree\)(E)@f
+
+@depends on patch exists@
+expression E;
+position a != alloc.kok;
+position f != free.fok;
+@@
+
+  E = \(kmalloc\|kzalloc\|krealloc\|kcalloc\|kmalloc_node\|
+        kzalloc_node\|kmalloc_array\|kmalloc_array_node\|
+        kcalloc_node\)(...)@a
+  ... when != if (...) { ... E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|vmalloc_exec\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|__vmalloc_node_range\|__vmalloc_node\)(...); ... }
+      when != is_vmalloc_addr(E)
+      when any
+- \(vfree\|vfree_atomic\|kvfree\)(E)@f
++ kfree(E)
+
+@kfree depends on !patch@
+expression E;
+position a != alloc.vok;
+position f != free.fok;
+@@
+
+* E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|
+*       vmalloc_exec\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|
+*       __vmalloc_node_range\|__vmalloc_node\)(...)@a
+  ... when != is_vmalloc_addr(E)
+      when any
+* \(kfree\|kfree_sensitive\|kvfree\)(E)@f
+
+@depends on patch exists@
+expression E;
+position a != alloc.vok;
+position f != free.fok;
+@@
+
+  E = \(vmalloc\|vzalloc\|vmalloc_user\|vmalloc_node\|vzalloc_node\|
+        vmalloc_exec\|vmalloc_32\|vmalloc_32_user\|__vmalloc\|
+        __vmalloc_node_range\|__vmalloc_node\)(...)@a
+  ... when != is_vmalloc_addr(E)
+      when any
+- \(kfree\|kvfree\)(E)@f
++ vfree(E)
+
+@kvfree depends on !patch@
+expression E;
+position a, f;
+@@
+
+* E = \(kvmalloc\|kvzalloc\|kvcalloc\|kvzalloc_node\|kvmalloc_node\|
+*       kvmalloc_array\)(...)@a
+  ... when != is_vmalloc_addr(E)
+      when any
+* \(kfree\|kfree_sensitive\|vfree\|vfree_atomic\)(E)@f
+
+@depends on patch exists@
+expression E;
+@@
+
+  E = \(kvmalloc\|kvzalloc\|kvcalloc\|kvzalloc_node\|kvmalloc_node\|
+        kvmalloc_array\)(...)
+  ... when != is_vmalloc_addr(E)
+      when any
+- \(kfree\|vfree\)(E)
++ kvfree(E)
+
+@kvfree_switch depends on !patch@
+expression alloc.E;
+position f;
+@@
+
+  ... when != is_vmalloc_addr(E)
+      when any
+* \(kfree\|kfree_sensitive\|vfree\|vfree_atomic\)(E)@f
+
+@depends on patch exists@
+expression alloc.E;
+position f;
+@@
+
+  ... when != is_vmalloc_addr(E)
+      when any
+(
+- \(kfree\|vfree\)(E)@f
++ kvfree(E)
+|
+- kfree_sensitive(E)@f
++ kvfree_sensitive(E)
+)
+
+@script: python depends on report@
+a << vfree.a;
+f << vfree.f;
+@@
+
+msg = "WARNING kmalloc is used to allocate this memory at line %s" % (a[0].line)
+coccilib.report.print_report(f[0], msg)
+
+@script: python depends on org@
+a << vfree.a;
+f << vfree.f;
+@@
+
+msg = "WARNING kmalloc is used to allocate this memory at line %s" % (a[0].line)
+coccilib.org.print_todo(f[0], msg)
+
+@script: python depends on report@
+a << kfree.a;
+f << kfree.f;
+@@
+
+msg = "WARNING vmalloc is used to allocate this memory at line %s" % (a[0].line)
+coccilib.report.print_report(f[0], msg)
+
+@script: python depends on org@
+a << kfree.a;
+f << kfree.f;
+@@
+
+msg = "WARNING vmalloc is used to allocate this memory at line %s" % (a[0].line)
+coccilib.org.print_todo(f[0], msg)
+
+@script: python depends on report@
+a << kvfree.a;
+f << kvfree.f;
+@@
+
+msg = "WARNING kvmalloc is used to allocate this memory at line %s" % (a[0].line)
+coccilib.report.print_report(f[0], msg)
+
+@script: python depends on org@
+a << kvfree.a;
+f << kvfree.f;
+@@
+
+msg = "WARNING kvmalloc is used to allocate this memory at line %s" % (a[0].line)
+coccilib.org.print_todo(f[0], msg)
+
+@script: python depends on report@
+ka << alloc.kok;
+va << alloc.vok;
+f << kvfree_switch.f;
+@@
+
+msg = "WARNING kmalloc (line %s) && vmalloc (line %s) are used to allocate this memory" % (ka[0].line, va[0].line)
+coccilib.report.print_report(f[0], msg)
+
+@script: python depends on org@
+ka << alloc.kok;
+va << alloc.vok;
+f << kvfree_switch.f;
+@@
+
+msg = "WARNING kmalloc (line %s) && vmalloc (line %s) are used to allocate this memory" % (ka[0].line, va[0].line)
+coccilib.org.print_todo(f[0], msg)
+
-- 
2.26.2

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
