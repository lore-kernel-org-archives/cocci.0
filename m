Return-Path: <SRS0=Y7kI=BT=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DFBC433DF
	for <cocci@archiver.kernel.org>; Sun,  9 Aug 2020 21:27:40 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 844DF206A2
	for <cocci@archiver.kernel.org>; Sun,  9 Aug 2020 21:27:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 844DF206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 079LRDlO013504;
	Sun, 9 Aug 2020 23:27:13 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 60E56428B;
	Sun,  9 Aug 2020 23:27:13 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3AC834084
 for <cocci@systeme.lip6.fr>; Sun,  9 Aug 2020 23:27:11 +0200 (CEST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com
 [209.85.208.169])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 079LRAPv007390
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 9 Aug 2020 23:27:10 +0200 (CEST)
Received: by mail-lj1-f169.google.com with SMTP id i10so7518532ljn.2
 for <cocci@systeme.lip6.fr>; Sun, 09 Aug 2020 14:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=V+0cPGM3bRsE7YkU0y2eQl4qVGY5GO2VaxSnu9p+qWk=;
 b=RGYfDqBqHfAXSt6v7dQSkxCmMknJ8w5kWxAvdsO4Jd+R7IwVTWUmPkQ+vtCBva9xDA
 lt7IsAqiylNhYp3ykEityleXUwGbTNSHkJApzZds4xbHi/079a/FbTNoc5RtfVWzWEQf
 Hup7wl4UtGg8dS2bkUxKl+jvvTDf1gFFUy+nDG5owitBUnVCHqbbn/ErWbApqXFe/bH2
 Sn7NDfZPK31iTnKcmtprx5JpFXaNe/2Ymv/E9EP2t56EVxQ58maVoIZWazBCC4PgZEij
 55SPfFxpURjsdpOpnlUoMgiNFmcMdGH+5eFxnlgicHKMpfPNR/05FIxOSby4R7r2Ebk6
 4q9Q==
X-Gm-Message-State: AOAM532mvYNN4Ma06wbxAJlMhXAnWGpqqGfFAm+7PIVhPFsOd01H7+Wg
 XPoNavo3f7JMvkn3Mv9hCgk=
X-Google-Smtp-Source: ABdhPJywEO7G7AjBEBjlke7hxs6urEH6pmbyTMrO5IqAjs+lVoCFfvgzB6RBDCyMWzMcpThbsBF+9w==
X-Received: by 2002:a2e:9bc8:: with SMTP id w8mr10166240ljj.351.1597008429929; 
 Sun, 09 Aug 2020 14:27:09 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru.
 [37.110.38.130])
 by smtp.googlemail.com with ESMTPSA id b204sm9684239lfd.48.2020.08.09.14.27.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2020 14:27:09 -0700 (PDT)
From: Denis Efremov <efremov@linux.com>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Mon, 10 Aug 2020 00:26:55 +0300
Message-Id: <20200809212655.58457-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200806220342.25426-1-efremov@linux.com>
References: <20200806220342.25426-1-efremov@linux.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 09 Aug 2020 23:27:14 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 09 Aug 2020 23:27:10 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [Cocci] [PATCH v2] coccinelle: misc: add flexible_array.cocci script
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

Commit 68e4cd17e218 ("docs: deprecated.rst: Add zero-length and one-element
arrays") marks one-element and zero-length arrays as deprecated. Kernel
code should always use "flexible array members" instead.

The script warns about one-element and zero-length arrays in structs.

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

On the current master branch, the rule generates:
 - context: https://gist.github.com/evdenis/e2b4323491f9eff35376372df07f723c
 - patch: https://gist.github.com/evdenis/46081da9d68ecefd07edc3769cebcf32

 scripts/coccinelle/misc/flexible_array.cocci | 88 ++++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 scripts/coccinelle/misc/flexible_array.cocci

diff --git a/scripts/coccinelle/misc/flexible_array.cocci b/scripts/coccinelle/misc/flexible_array.cocci
new file mode 100644
index 000000000000..bf6dcda1783e
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
+@depends on patch exists@
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
+msg = "WARNING: use flexible-array member instead"
+coccilib.report.print_report(p[0], msg)
+
+@script: python depends on org@
+p << r.p;
+@@
+
+msg = "WARNING: use flexible-array member instead"
+coccilib.org.print_todo(p, msg)
-- 
2.26.2

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
