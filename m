Return-Path: <SRS0=O4Qb=WZ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PLING_QUERY,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB47C3A59F
	for <cocci@archiver.kernel.org>; Thu, 29 Aug 2019 17:10:49 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24DF22173E
	for <cocci@archiver.kernel.org>; Thu, 29 Aug 2019 17:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24DF22173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7THARc7012177;
	Thu, 29 Aug 2019 19:10:27 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 814227791;
	Thu, 29 Aug 2019 19:10:27 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 89B1D778B
 for <cocci@systeme.lip6.fr>; Thu, 29 Aug 2019 19:10:25 +0200 (CEST)
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7THAOSZ021056
 for <cocci@systeme.lip6.fr>; Thu, 29 Aug 2019 19:10:24 +0200 (CEST)
Received: by mail-wm1-f68.google.com with SMTP id v15so4530942wml.0
 for <cocci@systeme.lip6.fr>; Thu, 29 Aug 2019 10:10:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HpNYDE1F3tP7xvZy6HHQgQLZGRxzmgxL5p1Yz/TyyDk=;
 b=h+/v7kua8wKuTL45HsFpbNkNv61d55eriaH6NgsqiBZ43+s3Cll7FF6eXnqW3Gf5A0
 6Bd36rNqWCuhgIHfLPOBMVCHzsY5RK+kInPqFLCYWmjNg6C824wSVuZhdhJDZv6uw1fW
 b1l1KaaYo2Cmu6a73P82N+7P+mZwQ4+gpPLxZ2Ky9XH930q8IC8bXFA1o2JOBLpC2lT4
 bJdLzJEVg1lTX53VRAcJ28MKVMVq0CrCF79skcRCC0LrWY4NsKFW5V8ys1sNffYCvn9H
 uYR95xUIitpH90t8gZ7cLDJQehXHwZdxgwMQZ2GAZdCJNnHclQKxZRLO77ov+mJfEEYJ
 NWqw==
X-Gm-Message-State: APjAAAUsn+ysZMb+N2mJKm+W+8HeLOb0UGob3pOJE96OwHHO81yiIamo
 9lQzbqbv7Xvk4ZgM1dZwsMQ=
X-Google-Smtp-Source: APXvYqx28paD2KyQUm43t2KjrNbTIZ44MCT11WvNWh7dxKbGOutx6mT8RF+VLi6rGpNbkU8IVDDPEA==
X-Received: by 2002:a1c:8083:: with SMTP id b125mr5664275wmd.100.1567098624277; 
 Thu, 29 Aug 2019 10:10:24 -0700 (PDT)
Received: from green.intra.ispras.ru (bran.ispras.ru. [83.149.199.196])
 by smtp.googlemail.com with ESMTPSA id g26sm2210892wmh.32.2019.08.29.10.10.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2019 10:10:23 -0700 (PDT)
From: Denis Efremov <efremov@linux.com>
To: linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr
Date: Thu, 29 Aug 2019 20:10:13 +0300
Message-Id: <20190829171013.22956-1-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190825130536.14683-1-efremov@linux.com>
References: <20190825130536.14683-1-efremov@linux.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 29 Aug 2019 19:10:28 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 29 Aug 2019 19:10:24 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Markus Elfring <Markus.Elfring@web.de>, Joe Perches <joe@perches.com>
Subject: [Cocci] [PATCH v2] scripts: coccinelle: check for !(un)?likely usage
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

This patch adds coccinelle script for detecting !likely and
!unlikely usage. These notations are confusing. It's better
to replace !likely(x) with unlikely(!x) and !unlikely(x) with
likely(!x) for readability.

The rule transforms !likely(x) to unlikely(!x) based on this logic:
  !likely(x) iff
  !__builtin_expect(!!(x), 1) iff
   __builtin_expect(!!!(x), 0) iff
  unlikely(!x)

For !unlikely(x) to likely(!x):
  !unlikely(x) iff
  !__builtin_expect(!!(x), 0) iff
  __builtin_expect(!!!(x), 1) iff
  likely(!x)

Signed-off-by: Denis Efremov <efremov@linux.com>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Gilles Muller <Gilles.Muller@lip6.fr>
Cc: Nicolas Palix <nicolas.palix@imag.fr>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Markus Elfring <Markus.Elfring@web.de>
Cc: Joe Perches <joe@perches.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 scripts/coccinelle/misc/neg_unlikely.cocci | 89 ++++++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 scripts/coccinelle/misc/neg_unlikely.cocci

diff --git a/scripts/coccinelle/misc/neg_unlikely.cocci b/scripts/coccinelle/misc/neg_unlikely.cocci
new file mode 100644
index 000000000000..9aac0a7ff042
--- /dev/null
+++ b/scripts/coccinelle/misc/neg_unlikely.cocci
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Use unlikely(!x) instead of !likely(x) and vice versa.
+/// Notations !unlikely(x) and !likely(x) are confusing.
+//
+// Confidence: High
+// Copyright: (C) 2019 Denis Efremov, ISPRAS.
+// Options: --no-includes --include-headers
+
+virtual patch
+virtual context
+virtual org
+virtual report
+
+//----------------------------------------------------------
+//  For context mode
+//----------------------------------------------------------
+
+@depends on context disable unlikely@
+expression E;
+@@
+
+*! \( likely \| unlikely \) (E)
+
+//----------------------------------------------------------
+//  For patch mode
+//----------------------------------------------------------
+
+@depends on patch disable unlikely@
+expression E;
+@@
+
+(
+-!likely(!E)
++unlikely(E)
+|
+-!likely(E)
++unlikely(!E)
+|
+-!unlikely(!E)
++likely(E)
+|
+-!unlikely(E)
++likely(!E)
+)
+
+//----------------------------------------------------------
+//  For org and report mode
+//----------------------------------------------------------
+
+@r1 depends on (org || report) disable unlikely@
+expression E;
+position p;
+@@
+
+!likely@p(E)
+
+@r2 depends on (org || report) disable unlikely@
+expression E;
+position p;
+@@
+
+!unlikely@p(E)
+
+@script:python depends on org && r1@
+p << r1.p;
+@@
+
+coccilib.org.print_todo(p[0], "unlikely(!x) is more readable than !likely(x)")
+
+@script:python depends on org && r2@
+p << r2.p;
+@@
+
+coccilib.org.print_todo(p[0], "likely(!x) is more readable than !unlikely(x)")
+
+@script:python depends on report && r1@
+p << r1.p;
+@@
+
+coccilib.report.print_report(p[0],
+	"unlikely(!x) is more readable than !likely(x)")
+
+@script:python depends on report && r2@
+p << r2.p;
+@@
+
+coccilib.report.print_report(p[0],
+	"likely(!x) is more readable than !unlikely(x)")
+
-- 
2.21.0

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
