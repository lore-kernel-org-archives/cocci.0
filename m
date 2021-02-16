Return-Path: <SRS0=ltO7=HS=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A42AC433DB
	for <cocci@archiver.kernel.org>; Tue, 16 Feb 2021 08:02:00 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87AB264D9E
	for <cocci@archiver.kernel.org>; Tue, 16 Feb 2021 08:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87AB264D9E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 11G81cik016338;
	Tue, 16 Feb 2021 09:01:38 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C1B0177C0;
	Tue, 16 Feb 2021 09:01:38 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7124C39D7
 for <cocci@systeme.lip6.fr>; Tue, 16 Feb 2021 09:01:37 +0100 (CET)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com
 [209.85.208.181])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 11G81a7O011599
 for <cocci@systeme.lip6.fr>; Tue, 16 Feb 2021 09:01:37 +0100 (CET)
Received: by mail-lj1-f181.google.com with SMTP id u4so10680024ljh.6
 for <cocci@systeme.lip6.fr>; Tue, 16 Feb 2021 00:01:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=uFThXabaiyaapHkWm2pAsaBD7G1U96eLmd8X49gddgo=;
 b=KhjXHR3O82C+Ducf1w0ds5OGqkssb7TxLk9X6AG3BrAZFggyG5NBfkL2rpXR/qHRAN
 2ZunfqkMEFv9pkhOufyjL1VlBBW9FztqlxDz7A1SPCQ1jeNX1SWcTvPRIYtEgPwaj7Ub
 R7X3bjQKD3VpyfWS4jf22epEq60tJZhTzdMF5UtaisChJJ4AyaWWT8Vguk427yq4VDNG
 oYyx2M+2BNBE4tUUEEEofMBeAd4YUif5vc+oeXCua/UHJfrw3IUK7G67UmBiHtvOdbEb
 EAaKcwyQ4LrqF2nT2C+AniZEaAPbH6zoYQygn7Ef21PTe9BlN43LypKecvnTZMICOvY4
 pk7w==
X-Gm-Message-State: AOAM530eq7FznLDL3+AJ3S5gjCqQ+jrj7/2UwGki2Vi9Eb1IxuARqGIB
 fETxm66kknFv6aEEXsJdmRU=
X-Google-Smtp-Source: ABdhPJxZMTAPypUYuhEx+CTwH4TV528teZWJ6i0ongr0r3kKwipLnEVP4lqR9ayYIop3KwGWOcSv6A==
X-Received: by 2002:a2e:a368:: with SMTP id i8mr4366039ljn.455.1613462496667; 
 Tue, 16 Feb 2021 00:01:36 -0800 (PST)
Received: from localhost.localdomain (broadband-188-32-236-56.ip.moscow.rt.ru.
 [188.32.236.56])
 by smtp.googlemail.com with ESMTPSA id l9sm3123586lfp.209.2021.02.16.00.01.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Feb 2021 00:01:36 -0800 (PST)
From: Denis Efremov <efremov@linux.com>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Tue, 16 Feb 2021 11:01:33 +0300
Message-Id: <20210216080133.455456-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 16 Feb 2021 09:01:39 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 16 Feb 2021 09:01:37 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: [Cocci] [PATCH] coccinelle: misc: add swap script
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

Check for opencoded swap() implementation.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 scripts/coccinelle/misc/swap.cocci | 77 ++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 scripts/coccinelle/misc/swap.cocci

diff --git a/scripts/coccinelle/misc/swap.cocci b/scripts/coccinelle/misc/swap.cocci
new file mode 100644
index 000000000000..38227a5d0855
--- /dev/null
+++ b/scripts/coccinelle/misc/swap.cocci
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Check for opencoded swap() implementation.
+///
+// Confidence: High
+// Copyright: (C) 2021 Denis Efremov ISPRAS
+// Options: --no-includes --include-headers
+//
+// Keywords: swap
+//
+
+virtual patch
+virtual org
+virtual report
+virtual context
+
+@r depends on !patch@
+identifier tmp;
+expression a, b;
+type T;
+position p;
+@@
+
+(
+* T tmp;
+|
+* T tmp = 0;
+|
+* T *tmp = NULL;
+)
+... when != tmp
+* tmp = a;
+* a = b;@p
+* b = tmp;
+... when != tmp
+
+@depends on patch@
+identifier tmp;
+expression a, b;
+type T;
+@@
+
+(
+- T tmp;
+|
+- T tmp = 0;
+|
+- T *tmp = NULL;
+)
+... when != tmp
+- tmp = a;
+- a = b;
+- b = tmp;
++ swap(a, b);
+... when != tmp
+
+@depends on patch@
+identifier tmp;
+expression a, b;
+@@
+
+- tmp = a;
+- a = b;
+- b = tmp;
++ swap(a, b);
+
+@script:python depends on report@
+p << r.p;
+@@
+
+coccilib.report.print_report(p[0], "WARNING opportunity for swap()")
+
+@script:python depends on org@
+p << r.p;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING opportunity for swap()")
-- 
2.26.2

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
