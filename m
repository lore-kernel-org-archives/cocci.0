Return-Path: <SRS0=yQoC=73=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DE3C433E0
	for <cocci@archiver.kernel.org>; Sun, 14 Jun 2020 21:54:11 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31E952071A
	for <cocci@archiver.kernel.org>; Sun, 14 Jun 2020 21:54:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31E952071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05ELs81B025771;
	Sun, 14 Jun 2020 23:54:08 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 6D2A17760;
	Sun, 14 Jun 2020 23:54:08 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id DE77044A7
 for <cocci@systeme.lip6.fr>; Sun, 14 Jun 2020 23:54:06 +0200 (CEST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com
 [209.85.167.45])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05ELs6VF029913
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 14 Jun 2020 23:54:06 +0200 (CEST)
Received: by mail-lf1-f45.google.com with SMTP id w15so8348003lfe.11
 for <cocci@systeme.lip6.fr>; Sun, 14 Jun 2020 14:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=exuwoJRcicaA0UCuHwfbQdxe2r5HN92fxJmC6sAbWzI=;
 b=ozvTvXunbIdV9XCQtTWRhDtU1MC5o3EJFiGavDSsr4RKPJcuwnvXxAAG2H03tDXqmX
 3xigjm2GyxAKZ2rsGbobohEf7qq//0Jb9JKfhkITc1dUsehkSbi7VmTqNXO6dqoZ+j1b
 9NYIJTgQijVA1CMFSqYEmk4SxkiUTkVowafjxyJERJo5l7kSqY2DDoKBjtjl3WcQkgjh
 2tk6jr25bcBJKCDIQxusMcgrXJ1A+A+d5YSo+NcQLMzrfXjbrPnhCjmy2PktxWUX68C6
 Kp2G5IgaS926wfWaKJDF0bjdUYRqXyh6dfeJrY55DGPdZ7ObAuaXiNOW9R+KyrHqAzyG
 tvkA==
X-Gm-Message-State: AOAM5331Y22l6wcsF5Exb1HvBXuoEIkPwxKslU6s+eiLTPogUa4N1vxa
 sAwTPnniGvV1T891PBCa8xM=
X-Google-Smtp-Source: ABdhPJz1YZTJNXqbMcTdX5Y2lYQHHOcc8cpxCKrcEhwrlQvnmP0ytzbdjeQZbhp7FMrpAuh2f6jEYQ==
X-Received: by 2002:a19:8305:: with SMTP id f5mr5845453lfd.173.1592171645720; 
 Sun, 14 Jun 2020 14:54:05 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru.
 [37.110.38.130])
 by smtp.googlemail.com with ESMTPSA id g5sm3467254ljk.93.2020.06.14.14.54.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2020 14:54:04 -0700 (PDT)
From: Denis Efremov <efremov@linux.com>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Mon, 15 Jun 2020 00:54:14 +0300
Message-Id: <20200614215414.40034-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200604140805.111613-1-efremov@linux.com>
References: <20200604140805.111613-1-efremov@linux.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 14 Jun 2020 23:54:08 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 14 Jun 2020 23:54:06 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: [Cocci] [PATCH v3] coccinelle: api: add kzfree script
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

Check for memset()/memzero_explicit() followed by kfree()/vfree()/kvfree().

Signed-off-by: Denis Efremov <efremov@linux.com>
---
Changes in v2:
 - memset_explicit() added
 - kvfree_sensitive() added
 - forall added to r1
 - ... between memset and kfree added
Changes in v3:
 - Explicit filter for definitions instead of !(file in "...") conditions
 - type T added to match casts
 - memzero_explicit() patterns fixed
 - additional rule "cond" added to filter false-positives

 scripts/coccinelle/api/kzfree.cocci | 90 +++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 scripts/coccinelle/api/kzfree.cocci

diff --git a/scripts/coccinelle/api/kzfree.cocci b/scripts/coccinelle/api/kzfree.cocci
new file mode 100644
index 000000000000..4758ca5a781e
--- /dev/null
+++ b/scripts/coccinelle/api/kzfree.cocci
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Use kzfree, kvfree_sensitive rather than memset or
+/// memzero_explicit followed by kfree
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
+@initialize:python@
+@@
+# kmalloc_oob_in_memset uses memset to explicitly trigger out-of-bounds access
+filter = frozenset(['kmalloc_oob_in_memset', 'kzfree', 'kvfree_sensitive'])
+
+def relevant(p):
+    return not (filter & {el.current_element for el in p})
+
+@cond@
+position ok;
+@@
+
+if (...)
+  \(memset@ok\|memzero_explicit@ok\)(...);
+
+@r depends on !patch forall@
+expression E;
+position p : script:python() { relevant(p) };
+position m != cond.ok;
+type T;
+@@
+
+(
+* memset@m((T)E, 0, ...);
+|
+* memzero_explicit@m((T)E, ...);
+)
+  ... when != E
+      when strict
+* \(kfree\|vfree\|kvfree\)(E)@p;
+
+@rp_memzero depends on patch@
+expression E, size;
+position p : script:python() { relevant(p) };
+type T;
+@@
+
+- memzero_explicit((T)E, size)@p;
+  ... when != E
+      when strict
+- \(kfree\|vfree\|kvfree\)(E);
++ kvfree_sensitive(E, size);
+
+@rp_memset depends on patch@
+expression E, size;
+position p : script:python() { relevant(p) };
+type T;
+@@
+
+- memset((T)E, size)@p;
+  ... when != E
+      when strict
+(
+- kfree(E);
++ kzfree(E);
+|
+- \(vfree\|kvfree\)(E);
++ kvfree_sensitive(E, size);
+)
+
+@script:python depends on report@
+p << r.p;
+@@
+
+coccilib.report.print_report(p[0],
+  "WARNING: opportunity for kzfree/kvfree_sensitive")
+
+@script:python depends on org@
+p << r.p;
+@@
+
+coccilib.org.print_todo(p[0],
+  "WARNING: opportunity for kzfree/kvfree_sensitive")
-- 
2.26.2

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
