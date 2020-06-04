Return-Path: <SRS0=OH0s=7R=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DDCC433DF
	for <cocci@archiver.kernel.org>; Thu,  4 Jun 2020 14:08:28 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FAFE207D8
	for <cocci@archiver.kernel.org>; Thu,  4 Jun 2020 14:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FAFE207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 054E8MBk022670;
	Thu, 4 Jun 2020 16:08:22 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C1A507567;
	Thu,  4 Jun 2020 16:08:22 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3900D5D47
 for <cocci@systeme.lip6.fr>; Thu,  4 Jun 2020 16:08:21 +0200 (CEST)
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
 [209.85.208.193])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 054E8KrJ014981
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 4 Jun 2020 16:08:20 +0200 (CEST)
Received: by mail-lj1-f193.google.com with SMTP id 9so7443246ljc.8
 for <cocci@systeme.lip6.fr>; Thu, 04 Jun 2020 07:08:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8XEypNhNnT+UKcy1b1PvwbnH+QucPWD84O3G9vxNRDY=;
 b=P8nNN4zgsjG47SQ4GorjrmYAEOCU+e7/ZOBsKuXpmru/j8tw10HDSFEeuifNSYzHF5
 9LNguYaE+JAp28Ix5/vS98Es3HZyksrJZ1CRlWNyDjSzKT3/vDIZ+dENjSLwWIwBsI7J
 VtlS/ABZQ6KQkvF3yVO01NPzj3GNBjAC6eVCjG0XyGAiRKrRG8HNB6cRZ9ReRPHi1tZm
 dpHgwKoh2yvnOtUfvCvk2iLm+kXtZj4ENPoc0L/fzreVBb+eKYH4agT0WzTMeucbuDaq
 qcYmTQfb7pC6lBrf0a2ltJ9BVBQuryi/NiuVGkvgDsD+TdYIARfWyRrc3wudH9Ul3xWe
 QENQ==
X-Gm-Message-State: AOAM531zgbPWERnftnS+43ozPBddHNYwsPLZH9eSt7x87vTZrX9wfO8a
 jY17LXqQeJFVe7qAttQ85gA=
X-Google-Smtp-Source: ABdhPJz9HUDfF6IfPeO7FOB6cVHTiPQE+UUfUHaNhd/awncMoLi7YDormQhrTauiRh6hIjY5qcIxvw==
X-Received: by 2002:a05:651c:547:: with SMTP id
 q7mr2054309ljp.437.1591279700104; 
 Thu, 04 Jun 2020 07:08:20 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru.
 [37.110.38.130])
 by smtp.googlemail.com with ESMTPSA id w6sm1142864ljw.11.2020.06.04.07.08.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 07:08:19 -0700 (PDT)
From: Denis Efremov <efremov@linux.com>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Thu,  4 Jun 2020 17:08:04 +0300
Message-Id: <20200604140805.111613-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 04 Jun 2020 16:08:24 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 04 Jun 2020 16:08:20 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: [Cocci] [PATCH] coccinelle: api: add kzfree script
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

Check for memset() with 0 followed by kfree().

Signed-off-by: Denis Efremov <efremov@linux.com>
---
Patches:
1. kzfree in drivers/w1 https://lkml.org/lkml/2020/6/4/438
2. kzfree in drivers/iommu/ https://lkml.org/lkml/2020/6/4/421
3. kzfree in drivers/scsi/ https://lkml.org/lkml/2020/6/4/442

 scripts/coccinelle/api/kzfree.cocci | 53 +++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 scripts/coccinelle/api/kzfree.cocci

diff --git a/scripts/coccinelle/api/kzfree.cocci b/scripts/coccinelle/api/kzfree.cocci
new file mode 100644
index 000000000000..c6b8f7676af4
--- /dev/null
+++ b/scripts/coccinelle/api/kzfree.cocci
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Use kzfree rather than memset with 0 followed by kfree
+///
+// Confidence: High
+// Copyright: (C) 2020 Denis Efremov ISPRAS
+// Options: --no-includes --include-headers
+//
+// Keywords: kzfree
+//
+
+virtual context
+virtual org
+virtual report
+virtual patch
+
+// Ignore kzfree definition
+// Ignore kasan test
+@r depends on !patch && !(file in "lib/test_kasan.c") && !(file in "mm/slab_common.c")@
+expression E;
+position p;
+@@
+
+(
+* memset(E, 0, ...);
+|
+* memset(E, '\0', ...);
+)
+* kfree(E)@p;
+
+@r1 depends on patch && !(file in "lib/test_kasan.c") && !(file in "mm/slab_common.c")@
+expression E;
+@@
+
+(
+- memset(E, 0, ...);
+|
+- memset(E, '\0', ...);
+)
+- kfree(E);
++ kzfree(E);
+
+@script:python depends on report@
+p << r.p;
+@@
+
+coccilib.report.print_report(p[0], "WARNING opportunity for kzfree")
+
+@script:python depends on org@
+p << r.p;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING opportunity for kzfree")
-- 
2.26.2

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
