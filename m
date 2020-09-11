Return-Path: <SRS0=eQR0=CU=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF647C433E2
	for <cocci@archiver.kernel.org>; Fri, 11 Sep 2020 13:53:17 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E90F22276
	for <cocci@archiver.kernel.org>; Fri, 11 Sep 2020 13:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1V65bei"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E90F22276
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08BDqpbq019728;
	Fri, 11 Sep 2020 15:52:51 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0C1E7778C;
	Fri, 11 Sep 2020 15:52:51 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 219985F8F
 for <cocci@systeme.lip6.fr>; Fri, 11 Sep 2020 15:50:10 +0200 (CEST)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:443])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08BDo7Fi015777
 for <cocci@systeme.lip6.fr>; Fri, 11 Sep 2020 15:50:07 +0200 (CEST)
Received: by mail-wr1-x443.google.com with SMTP id m6so11603791wrn.0
 for <cocci@systeme.lip6.fr>; Fri, 11 Sep 2020 06:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nT31LQihlGES3XBi9qi6rIDEsIrCyiWiwAwPBPR3FeQ=;
 b=O1V65bei9i+sAdwH/CWpyxW5mBTdKr/oOaga84JeTelaHyfsHbulHu4x1iUSu5PWK2
 8vksMccmoRfyYbwYegP9AdphFhNWTKXe/Ud/fs/LobE1sR2XCFz6woi0kFSObnj+ranY
 1wXHE+6dl1Fc1xwZL1jdEIi/Nrv0m0EMOzEjR5J5dUfpZ+GDrNLH3roHYiQ2qaeIkz4h
 YHwE7jLB9eARe7ME9vznJ23vwzMX1LnXAjaf0ePo7iZJrrLyYRpVqO81k86HxyML9B1U
 BAm15l6t4fCQpoD3pjNoTwGpgD4ukZBf9e7i60l8R59qsGUS1t0gpwtFDUshlqvBx/aR
 hrJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=nT31LQihlGES3XBi9qi6rIDEsIrCyiWiwAwPBPR3FeQ=;
 b=AiEMRAHRtQIh8kiG7aJlqKGfz3VZAnl/0tIBK1G0Z8dMTLnYp1HoMg/qIvKp2lQal6
 z5av90EzkGWGA+beUJg463QU+V0J5hvR/iLnquq/2jELVXYh9zEWA4bxlthmLtX1qQq2
 MQH//6u3hvY4qaNdkfSoxCzUHxkJnoMEYeggHvL4CavDz1WVBr/l4vEoS+5Gy9G+XAGP
 qTnXnDxnhDX5hGYob/I4KeID5YoinvHZiGoQQjNhuUcHJbpt+NBxgKr1FBVGo41DpbrT
 t8IY6AIffuBYkBdneUFeDqdo4ocMGR7Cn+ZE0ydppCPuN9DUL2QfiZTrMQgQhwoa7tv3
 21Hg==
X-Gm-Message-State: AOAM533WQxR80/iFhJpJS2VSxXCtob80MKqwLz6k9qL/Ft9fAAsnLSCB
 8cCeIZsGcM2jipfNR3jk8fs=
X-Google-Smtp-Source: ABdhPJzgUZhv9R/6x7e+9tAD5bHrnj1uOz2SsmxNk4a9JkcFXFmrLU8LQvEveulMScnLKVKsnh4ywA==
X-Received: by 2002:adf:94c1:: with SMTP id 59mr2348866wrr.29.1599832207377;
 Fri, 11 Sep 2020 06:50:07 -0700 (PDT)
Received: from localhost.localdomain
 (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
 by smtp.gmail.com with ESMTPSA id w14sm4865331wrk.95.2020.09.11.06.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2020 06:50:06 -0700 (PDT)
From: Alex Dewar <alex.dewar90@gmail.com>
To: 
Date: Fri, 11 Sep 2020 14:49:42 +0100
Message-Id: <20200911134956.60910-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 11 Sep 2020 15:52:51 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 11 Sep 2020 15:50:07 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Fri, 11 Sep 2020 15:52:50 +0200
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr, Julia Lawall <Julia.Lawall@lip6.fr>,
        Alex Dewar <alex.dewar90@gmail.com>
Subject: [Cocci] [PATCH] scripts: kzfree.cocci: Deprecate use of kzfree
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

kzfree() is effectively deprecated as of commit 453431a54934 ("mm,
treewide: rename kzfree() to kfree_sensitive()"). It is currently just a
legacy alias for kfree_sensitive(), which achieves the same thing.

Update kzfree.cocci accordingly:
1) Replace instances of kzfree with kfree_sensitive
2) Merge different rules for memset/memset_explicit as kzfree and
   kfree_sensitive are now equivalent
3) Rename script to kfree_sensitive.cocci

In addition:
4) Move the script to the free/ subfolder, where it would seem to fit
   better

Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
 .../kfree_sensitive.cocci}                    | 38 +++++--------------
 1 file changed, 10 insertions(+), 28 deletions(-)
 rename scripts/coccinelle/{api/kzfree.cocci => free/kfree_sensitive.cocci} (59%)

diff --git a/scripts/coccinelle/api/kzfree.cocci b/scripts/coccinelle/free/kfree_sensitive.cocci
similarity index 59%
rename from scripts/coccinelle/api/kzfree.cocci
rename to scripts/coccinelle/free/kfree_sensitive.cocci
index 33625bd7cec9..a87f93f2ed5c 100644
--- a/scripts/coccinelle/api/kzfree.cocci
+++ b/scripts/coccinelle/free/kfree_sensitive.cocci
@@ -1,13 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0-only
 ///
-/// Use kzfree, kvfree_sensitive rather than memset or
-/// memzero_explicit followed by kfree
+/// Use k{,v}free_sensitive rather than memset or memzero_explicit followed by
+/// k{,v}free
 ///
 // Confidence: High
 // Copyright: (C) 2020 Denis Efremov ISPRAS
 // Options: --no-includes --include-headers
 //
-// Keywords: kzfree, kvfree_sensitive
+// Keywords: kfree_sensitive, kvfree_sensitive
 //
 
 virtual context
@@ -18,7 +18,7 @@ virtual report
 @initialize:python@
 @@
 # kmalloc_oob_in_memset uses memset to explicitly trigger out-of-bounds access
-filter = frozenset(['kmalloc_oob_in_memset', 'kzfree', 'kvfree_sensitive'])
+filter = frozenset(['kmalloc_oob_in_memset', 'kfree_sensitive', 'kvfree_sensitive'])
 
 def relevant(p):
     return not (filter & {el.current_element for el in p})
@@ -53,34 +53,16 @@ position m != cond.ok;
 type T;
 @@
 
+(
 - memzero_explicit@m((T)E, size);
-  ... when != E
-      when strict
-// TODO: uncomment when kfree_sensitive will be merged.
-// Only this case is commented out because developers
-// may not like patches like this since kzfree uses memset
-// internally (not memzero_explicit).
-//(
-//- kfree(E)@p;
-//+ kfree_sensitive(E);
-//|
-- \(vfree\|kvfree\)(E)@p;
-+ kvfree_sensitive(E, size);
-//)
-
-@rp_memset depends on patch@
-expression E, size;
-position p : script:python() { relevant(p) };
-position m != cond.ok;
-type T;
-@@
-
+|
 - memset@m((T)E, 0, size);
+)
   ... when != E
       when strict
 (
 - kfree(E)@p;
-+ kzfree(E);
++ kfree_sensitive(E);
 |
 - \(vfree\|kvfree\)(E)@p;
 + kvfree_sensitive(E, size);
@@ -91,11 +73,11 @@ p << r.p;
 @@
 
 coccilib.report.print_report(p[0],
-  "WARNING: opportunity for kzfree/kvfree_sensitive")
+  "WARNING: opportunity for k{,v}free_sensitive")
 
 @script:python depends on org@
 p << r.p;
 @@
 
 coccilib.org.print_todo(p[0],
-  "WARNING: opportunity for kzfree/kvfree_sensitive")
+  "WARNING: opportunity for k{,v}free_sensitive")
-- 
2.28.0

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
