Return-Path: <SRS0=OH0s=7R=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4679CC433E0
	for <cocci@archiver.kernel.org>; Thu,  4 Jun 2020 20:49:24 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB477206DC
	for <cocci@archiver.kernel.org>; Thu,  4 Jun 2020 20:49:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB477206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 054KnLlo027220;
	Thu, 4 Jun 2020 22:49:21 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3BB4F7567;
	Thu,  4 Jun 2020 22:49:21 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id AE0465D47
 for <cocci@systeme.lip6.fr>; Thu,  4 Jun 2020 22:49:19 +0200 (CEST)
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com
 [209.85.167.67])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 054KnIrL017981
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 4 Jun 2020 22:49:18 +0200 (CEST)
Received: by mail-lf1-f67.google.com with SMTP id d7so4444124lfi.12
 for <cocci@systeme.lip6.fr>; Thu, 04 Jun 2020 13:49:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KGhAdvcQJQ2qMPulVRPuuC9wYcPzRQ4SOxiHdw45kYM=;
 b=G/rIHZ0GTjacoiYbZ0L6VBw8htMaBMuDGt8JPo9g87SSlsN2k2m9Co66t1BUNcU9UN
 FoGzqgWpihnT0DlFIrx2FFPnStLvYmB06ctePKTydbYhHVUHlS5qi6RNL2mpBrz4Wq9H
 AKo3Iy8CV0sntyqfWxWiT5o1Sg2unV1rlHm/DD8AG7XwCwIH4diHZqtWDuTkxTLIdRdl
 ddzKt30o4dlobyL31KwcBhC2x3ZANpwc49pgZrunFKH10A5azqo/tcrL+57igLoDL1aE
 GpbWevcBnKJnyFDJPLxilp0/UjRC+3QcmM+ovTyHOQcDe3o0qT9c//l22RopDqeaAuOU
 eEAg==
X-Gm-Message-State: AOAM533h97XGc5NyIJ2D2BeAT+O3PRRl6BNvxFE2fyGc39wZcl+QR18j
 WuSvQ/bsAAILU8UaWxObZQM=
X-Google-Smtp-Source: ABdhPJyMSXyrh8zAP1X2eBLQS0LzwEa5XF3RYVMhR17BKJpMawdEDFDPGOJ0CTh+/xaOHWtXK/1zUA==
X-Received: by 2002:a05:6512:110e:: with SMTP id
 l14mr3258264lfg.25.1591303757728; 
 Thu, 04 Jun 2020 13:49:17 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru.
 [37.110.38.130])
 by smtp.googlemail.com with ESMTPSA id b144sm155718lfg.82.2020.06.04.13.49.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 13:49:15 -0700 (PDT)
From: Denis Efremov <efremov@linux.com>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Thu,  4 Jun 2020 23:48:46 +0300
Message-Id: <20200604204846.15897-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200604140805.111613-1-efremov@linux.com>
References: <20200604140805.111613-1-efremov@linux.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 04 Jun 2020 22:49:21 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 04 Jun 2020 22:49:18 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Joe Perches <joe@perches.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [Cocci] [PATCH v2] coccinelle: api: add kzfree script
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

Check for memset()/memset_explicit() with 0 followed by
kfree()/vfree()/kvfree().

Signed-off-by: Denis Efremov <efremov@linux.com>
---
Changes in v2:
- memset_explicit() added
- kvfree_sensitive() added
- forall added to r1
- ... between memset and kfree added
  Unfortunately, it doesn't work as I would expect it to in "patch"
  mode. I've added my comment about it in the rule. It can be safely
  removed from the patch if I misunderstood something.

Another "strange" behaviour that I faced that r2 rule works only if I
write 2 expression lines:
expression *E;
expression size;
If I try to use a single line "expression *E, size;" then r2 matches nothing.

 scripts/coccinelle/api/kzfree.cocci | 65 +++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 scripts/coccinelle/api/kzfree.cocci

diff --git a/scripts/coccinelle/api/kzfree.cocci b/scripts/coccinelle/api/kzfree.cocci
new file mode 100644
index 000000000000..5c7e4bb13bb7
--- /dev/null
+++ b/scripts/coccinelle/api/kzfree.cocci
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Use kzfree, kvfree_sensitive rather than memset or
+/// memset_explicit with 0 followed by kfree
+///
+// Confidence: High
+// Copyright: (C) 2020 Denis Efremov ISPRAS
+// Options: --no-includes --include-headers
+//
+// Keywords: kzfree, kvfree_sensitive
+//
+
+virtual context
+virtual patch
+virtual org
+virtual report
+
+
+// Ignore kzfree definition
+// Ignore kasan test
+@r depends on !patch && !(file in "lib/test_kasan.c") && !(file in "mm/slab_common.c") forall@
+expression *E;
+position p;
+@@
+
+* \(memset\|memset_explicit\)(E, 0, ...);
+  ... when != E
+      when strict
+* \(kfree\|vfree\|kvfree\)(E)@p;
+
+@r1 depends on patch && !(file in "lib/test_kasan.c") && !(file in "mm/slab_common.c")@
+expression *E;
+expression size;
+@@
+
+- \(memset\|memset_explicit\)(E, 0, size);
+/// Unfortunately, it doesn't work as in !patch mode.
+/// spatch (v1.0.8) should patch 4 functions in linux 5.7 with this rule
+/// and uncommented "when" lines. With only "... when != E" line 2 functions
+/// are patched, none with "when strict". 3 functions patch is produced by the
+/// rule with "when" lines commented out.
+//  ... when != E
+//      when strict
+(
+- kfree(E);
++ kzfree(E);
+|
+- vfree(E);
++ kvfree_sensitive(E, size);
+|
+- kvfree(E);
++ kvfree_sensitive(E, size);
+)
+
+@script:python depends on report@
+p << r.p;
+@@
+
+coccilib.report.print_report(p[0], "WARNING opportunity for kzfree/kvfree_sensitive")
+
+@script:python depends on org@
+p << r.p;
+@@
+
+coccilib.org.print_todo(p[0], "WARNING opportunity for kzfree/kvfree_sensitive")
-- 
2.26.2

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
