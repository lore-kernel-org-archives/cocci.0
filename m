Return-Path: <SRS0=VzTg=C6=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69224C4346B
	for <cocci@archiver.kernel.org>; Mon, 21 Sep 2020 15:29:47 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B75FE20BED
	for <cocci@archiver.kernel.org>; Mon, 21 Sep 2020 15:29:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B75FE20BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08LFTPsM017316;
	Mon, 21 Sep 2020 17:29:25 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 81573778D;
	Mon, 21 Sep 2020 17:29:25 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 282DF5F8F
 for <cocci@systeme.lip6.fr>; Mon, 21 Sep 2020 17:29:24 +0200 (CEST)
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com
 [209.85.167.67])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08LFTNRi002022
 for <cocci@systeme.lip6.fr>; Mon, 21 Sep 2020 17:29:23 +0200 (CEST)
Received: by mail-lf1-f67.google.com with SMTP id y17so14499766lfa.8
 for <cocci@systeme.lip6.fr>; Mon, 21 Sep 2020 08:29:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=n6tgcOAvkDKfi/2+T+2xL+Uc3W4IOMeRY4n7RmB/zy8=;
 b=pQQlv772mhw00ilAv05Iqv9MbY48bDvI3xYzLAAtEsgmtdDD8LHM/SNTvkPmJ6uEjf
 okSl+Eqm/HU2arhzk0AowJmvUBkAmNRJUjmgLhxF9D7EA3kGGBdjReci5cnZs1/lBzp0
 7RvtfLZlB0bwZlOys4dHKOOQ6eg8ifwzY141SUpuwIF9VhIuFqTkYNsdAbQrsD8B4m9H
 gXMpNRwVJkSc+jr+DjLTeML3a54S3/dzR4KBLDoNPURxHpBeJprCV/UTZy9TR+Av4mFw
 r7edJX5+tOAAyvrVoyps6ClMJbaBCT9XRWHjIPY0GjwnHZodiY6xy9WYDS1SPr3mc+Xy
 wuHg==
X-Gm-Message-State: AOAM5315wL/UprQ8LCnujUOvZGVQoeFubHY+CszCaYIE/QDzgJI9PeyM
 nNaej4BT4Kigtuf7vvj1YwE=
X-Google-Smtp-Source: ABdhPJx5Zk00p9P5rnXFyIkIDMNgevgZ+WLQx7FkDDwOv1k1DmzMXbT+QzaYbuQ/B4beKo9mYRltgw==
X-Received: by 2002:a19:be86:: with SMTP id o128mr154937lff.220.1600702163141; 
 Mon, 21 Sep 2020 08:29:23 -0700 (PDT)
Received: from green.intra.ispras.ru (winnie.ispras.ru. [83.149.199.91])
 by smtp.googlemail.com with ESMTPSA id w4sm2626579lff.231.2020.09.21.08.29.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 08:29:22 -0700 (PDT)
From: Denis Efremov <efremov@linux.com>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Mon, 21 Sep 2020 18:28:50 +0300
Message-Id: <20200921152850.59194-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200902151859.403354-1-efremov@linux.com>
References: <20200902151859.403354-1-efremov@linux.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 21 Sep 2020 17:29:25 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 21 Sep 2020 17:29:23 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: [Cocci] [PATCH v2] coccinelle: misc: add excluded_middle.cocci
	script
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

Check for !A || A && B condition. It's equivalent to !A || B.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
Changes in v2:
 - spelling mistake fixed
 - position variable moved on the && operator
 - patch pattern changed to - (A && B)
 - word "condition" removed from warning message

 scripts/coccinelle/misc/excluded_middle.cocci | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 scripts/coccinelle/misc/excluded_middle.cocci

diff --git a/scripts/coccinelle/misc/excluded_middle.cocci b/scripts/coccinelle/misc/excluded_middle.cocci
new file mode 100644
index 000000000000..ab28393e4843
--- /dev/null
+++ b/scripts/coccinelle/misc/excluded_middle.cocci
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Condition !A || A && B is equivalent to !A || B.
+///
+// Confidence: High
+// Copyright: (C) 2020 Denis Efremov ISPRAS
+// Options: --no-includes --include-headers
+
+virtual patch
+virtual context
+virtual org
+virtual report
+
+@r depends on !patch@
+expression A, B;
+position p;
+@@
+
+* !A || (A &&@p B)
+
+@depends on patch@
+expression A, B;
+@@
+
+  !A ||
+-       (A && B)
++       B
+
+@script:python depends on report@
+p << r.p;
+@@
+
+coccilib.report.print_report(p[0], "WARNING !A || A && B is equivalent to !A || B")
+
+@script:python depends on org@
+p << r.p;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING !A || A && B is equivalent to !A || B")
-- 
2.26.2

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
