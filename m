Return-Path: <SRS0=VzTg=C6=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4E1C43635
	for <cocci@archiver.kernel.org>; Mon, 21 Sep 2020 17:50:12 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 233AC216C4
	for <cocci@archiver.kernel.org>; Mon, 21 Sep 2020 17:50:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 233AC216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08LHncPP029054;
	Mon, 21 Sep 2020 19:49:38 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 86CAC778D;
	Mon, 21 Sep 2020 19:49:38 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4E11E5F8F
 for <cocci@systeme.lip6.fr>; Mon, 21 Sep 2020 19:49:37 +0200 (CEST)
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com
 [209.85.208.196])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08LHnast017338
 for <cocci@systeme.lip6.fr>; Mon, 21 Sep 2020 19:49:36 +0200 (CEST)
Received: by mail-lj1-f196.google.com with SMTP id u4so11828779ljd.10
 for <cocci@systeme.lip6.fr>; Mon, 21 Sep 2020 10:49:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JYVL6vVhxxsHwQqcaJ+Y/Dyr3s/BHvLdogiat9zzOMY=;
 b=gAmPUhMj+7K3h3qn69cQa8QYp3g4Rr6bR6K5ixIUYro73xyMm2V4qSf+FHhJcDbo8a
 CzNSyQGcbWn3rPLu0AAHhl/44HMQztt+0dCrZmJBGC/ly0N1f1HqnDxjV84KTv0Vt7lo
 TCxgBtLuEwJYVrnm25wobk+5yPkHs7zrup9O+thkAJD0nPKFmWvx+TM5vuVYhKTy2C7X
 dsEJmaT0QEh7OaHIxYYBK4v+z5f4AUKot0T4rW8TWCV32D2qcLzrZnhzS5/o3bTRSPL4
 Zd1tOSvdHcumw8hPHlbYlTc6kG2gDxhG72rPEz7e+NkPJR5r/FRIgNkJREogOOXwQYbZ
 5Ieg==
X-Gm-Message-State: AOAM5337C3PVxh6w8GRmdnZSVnywq9wlpUovr9mGNOmxDX8mfPUNBtMA
 UvEiHiH6Rswhgb7x74QOps8=
X-Google-Smtp-Source: ABdhPJyuIwK4gStrZns8fCO6n/pBDKraTe1BTnTEwKWkDnih4NCMna1EpOuzxJwnULIkwuD7H5324g==
X-Received: by 2002:a2e:3203:: with SMTP id y3mr269898ljy.261.1600710575899;
 Mon, 21 Sep 2020 10:49:35 -0700 (PDT)
Received: from green.intra.ispras.ru (winnie.ispras.ru. [83.149.199.91])
 by smtp.googlemail.com with ESMTPSA id q24sm2773353lfo.149.2020.09.21.10.49.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 10:49:35 -0700 (PDT)
From: Denis Efremov <efremov@linux.com>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Mon, 21 Sep 2020 20:49:20 +0300
Message-Id: <20200921174920.87241-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200806220342.25426-1-efremov@linux.com>
References: <20200806220342.25426-1-efremov@linux.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 21 Sep 2020 19:49:38 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 21 Sep 2020 19:49:36 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [Cocci] [PATCH v3] coccinelle: misc: add flexible_array.cocci script
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

One-element and zero-length arrays are deprecated [1]. Kernel
code should always use "flexible array members" instead, except
for existing uapi definitions.

The script warns about one-element and zero-length arrays in structs.

[1] commit 68e4cd17e218 ("docs: deprecated.rst: Add zero-length and
    one-element arrays")

Cc: Kees Cook <keescook@chromium.org>
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Denis Efremov <efremov@linux.com>
---
Changes in v2:
 - all uapi headers are now filtered-out. Unfortunately, coccinelle
   doesn't provide structure names in Location.current_element.
   For structures the field is always "something_else". Thus, there is
   no easy way to create a list of existing structures in uapi headers
   and suppress the warning only for them, but not for the newly added
   uapi structures.
 - The pattern doesn't require 2+ fields in a structure/union anymore.
   Now it also checks single field structures/unions.
 - The pattern simplified and now uses disjuction in array elements
   (Thanks, Markus)
 - Unions are removed from patch mode
 - one-element arrays are removed from patch mode. Correct patch may
   involve turning the array to a simple field instead of a flexible
   array.
Changes in v3:
 - exists removed from "depends on patch"
 - position argument fixed in org mode
 - link to the online documentation added to the warning message

 scripts/coccinelle/misc/flexible_array.cocci | 88 ++++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 scripts/coccinelle/misc/flexible_array.cocci

diff --git a/scripts/coccinelle/misc/flexible_array.cocci b/scripts/coccinelle/misc/flexible_array.cocci
new file mode 100644
index 000000000000..947fbaff82a9
--- /dev/null
+++ b/scripts/coccinelle/misc/flexible_array.cocci
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Zero-length and one-element arrays are deprecated, see
+/// Documentation/process/deprecated.rst
+/// Flexible-array members should be used instead.
+///
+//
+// Confidence: High
+// Copyright: (C) 2020 Denis Efremov ISPRAS.
+// Comments:
+// Options: --no-includes --include-headers
+
+virtual context
+virtual report
+virtual org
+virtual patch
+
+@initialize:python@
+@@
+def relevant(positions):
+    for p in positions:
+        if "uapi" in p.file:
+             return False
+    return True
+
+@r depends on !patch@
+identifier name, array;
+type T;
+position p : script:python() { relevant(p) };
+@@
+
+(
+  struct name {
+    ...
+*   T array@p[\(0\|1\)];
+  };
+|
+  struct {
+    ...
+*   T array@p[\(0\|1\)];
+  };
+|
+  union name {
+    ...
+*   T array@p[\(0\|1\)];
+  };
+|
+  union {
+    ...
+*   T array@p[\(0\|1\)];
+  };
+)
+
+@depends on patch@
+identifier name, array;
+type T;
+position p : script:python() { relevant(p) };
+@@
+
+(
+  struct name {
+    ...
+    T array@p[
+-       0
+    ];
+  };
+|
+  struct {
+    ...
+    T array@p[
+-       0
+    ];
+  };
+)
+
+@script: python depends on report@
+p << r.p;
+@@
+
+msg = "WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)"
+coccilib.report.print_report(p[0], msg)
+
+@script: python depends on org@
+p << r.p;
+@@
+
+msg = "WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)"
+coccilib.org.print_todo(p[0], msg)
-- 
2.26.2

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
