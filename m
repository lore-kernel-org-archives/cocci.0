Return-Path: <SRS0=8ujx=BV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAED5C433E0
	for <cocci@archiver.kernel.org>; Tue, 11 Aug 2020 07:50:25 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E535205CB
	for <cocci@archiver.kernel.org>; Tue, 11 Aug 2020 07:50:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E535205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07B7o4c2003007;
	Tue, 11 Aug 2020 09:50:04 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 83B3D4084;
	Tue, 11 Aug 2020 09:50:04 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5D3833C97
 for <cocci@systeme.lip6.fr>; Tue, 11 Aug 2020 09:50:03 +0200 (CEST)
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com
 [209.85.167.68])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 07B7o2XC029246
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 11 Aug 2020 09:50:02 +0200 (CEST)
Received: by mail-lf1-f68.google.com with SMTP id k13so6160715lfo.0
 for <cocci@systeme.lip6.fr>; Tue, 11 Aug 2020 00:50:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7c9LgDQzwFBP2P6ArJr6sk6r1j+llzDsGb6lR6H9a1Q=;
 b=jyyTE1JymqxjDPpjp+yk7nHrcXIcfvNZIuGgj8aDCiEwZSaUuBvHQ27AzJnmDz3YzO
 qd9wOQQZQP1x5X1DbbjC2s0as6mGMXwcnP1dlYSCKh/OH2RB56iQIEzZp6keYwMQeU47
 TG7pX9UwuYVN55Jy/lrHYSwV0v/6nE9Ogel/bru5dY5jTdHqypMI3UYLrtzkAEWzeXRW
 Hl4kj//xHwvfZEg4t+twbELiHwK/qczhk0LurIqPIKfMDNZmtF7cBHbZ+RyAKnp7NpAB
 Kv4XUSxFuLYGc9xFS6Y3hBqxYoVpJ72d/nTiEq0h3BfXRFdT5ftrhZgLCB+C1NCAolsT
 ylww==
X-Gm-Message-State: AOAM532HWU4Rrck20ZqAkahKW2jNh37fzsWfj4+hoTr9TU+1Vi7Ha3zn
 vfUsE5p+giPZZbvZROfb8y8=
X-Google-Smtp-Source: ABdhPJxckJBrZD99vkzMZyK+yaa6woS9Ys9iCWecK6RVC95+nlUjQnGrP0mhZ4kjyiZEIGMSn83ang==
X-Received: by 2002:ac2:4542:: with SMTP id j2mr2586816lfm.110.1597132202193; 
 Tue, 11 Aug 2020 00:50:02 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru.
 [37.110.38.130])
 by smtp.googlemail.com with ESMTPSA id z25sm9918170ljz.13.2020.08.11.00.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2020 00:50:01 -0700 (PDT)
From: Denis Efremov <efremov@linux.com>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Tue, 11 Aug 2020 10:49:53 +0300
Message-Id: <20200811074953.73994-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200604140805.111613-1-efremov@linux.com>
References: <20200604140805.111613-1-efremov@linux.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 11 Aug 2020 09:50:04 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 11 Aug 2020 09:50:02 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Eric Biggers <ebiggers@kernel.org>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [Cocci] [PATCH] coccinelle: api: update kzfree script to
	kfree_sensitive
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

Commit 453431a54934 ("mm, treewide: rename kzfree() to kfree_sensitive()")
renames kzfree to kfree_sensitive and uses memzero_explicit(...) instead of
memset(..., 0, ...) internally. Update cocci script to reflect these
changes.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
Julia, I think you can squash this commit with original script, or I can
resend the whole script since it's not merged to the mainline.

 .../{kzfree.cocci => kfree_sensitive.cocci}   | 29 +++++++++----------
 1 file changed, 13 insertions(+), 16 deletions(-)
 rename scripts/coccinelle/api/{kzfree.cocci => kfree_sensitive.cocci} (70%)

diff --git a/scripts/coccinelle/api/kzfree.cocci b/scripts/coccinelle/api/kfree_sensitive.cocci
similarity index 70%
rename from scripts/coccinelle/api/kzfree.cocci
rename to scripts/coccinelle/api/kfree_sensitive.cocci
index 33625bd7cec9..e4a066a0b77d 100644
--- a/scripts/coccinelle/api/kzfree.cocci
+++ b/scripts/coccinelle/api/kfree_sensitive.cocci
@@ -1,13 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0-only
 ///
-/// Use kzfree, kvfree_sensitive rather than memset or
-/// memzero_explicit followed by kfree
+/// Use kfree_sensitive, kvfree_sensitive rather than memset or
+/// memzero_explicit followed by kfree.
 ///
 // Confidence: High
 // Copyright: (C) 2020 Denis Efremov ISPRAS
 // Options: --no-includes --include-headers
 //
-// Keywords: kzfree, kvfree_sensitive
+// Keywords: kfree_sensitive, kvfree_sensitive
 //
 
 virtual context
@@ -18,7 +18,8 @@ virtual report
 @initialize:python@
 @@
 # kmalloc_oob_in_memset uses memset to explicitly trigger out-of-bounds access
-filter = frozenset(['kmalloc_oob_in_memset', 'kzfree', 'kvfree_sensitive'])
+filter = frozenset(['kmalloc_oob_in_memset',
+		    'kfree_sensitive', 'kvfree_sensitive'])
 
 def relevant(p):
     return not (filter & {el.current_element for el in p})
@@ -56,17 +57,13 @@ type T;
 - memzero_explicit@m((T)E, size);
   ... when != E
       when strict
-// TODO: uncomment when kfree_sensitive will be merged.
-// Only this case is commented out because developers
-// may not like patches like this since kzfree uses memset
-// internally (not memzero_explicit).
-//(
-//- kfree(E)@p;
-//+ kfree_sensitive(E);
-//|
+(
+- kfree(E)@p;
++ kfree_sensitive(E);
+|
 - \(vfree\|kvfree\)(E)@p;
 + kvfree_sensitive(E, size);
-//)
+)
 
 @rp_memset depends on patch@
 expression E, size;
@@ -80,7 +77,7 @@ type T;
       when strict
 (
 - kfree(E)@p;
-+ kzfree(E);
++ kfree_sensitive(E);
 |
 - \(vfree\|kvfree\)(E)@p;
 + kvfree_sensitive(E, size);
@@ -91,11 +88,11 @@ p << r.p;
 @@
 
 coccilib.report.print_report(p[0],
-  "WARNING: opportunity for kzfree/kvfree_sensitive")
+  "WARNING: opportunity for kfree_sensitive/kvfree_sensitive")
 
 @script:python depends on org@
 p << r.p;
 @@
 
 coccilib.org.print_todo(p[0],
-  "WARNING: opportunity for kzfree/kvfree_sensitive")
+  "WARNING: opportunity for kfree_sensitive/kvfree_sensitive")
-- 
2.26.2

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
