Return-Path: <SRS0=JQUB=RS=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE254C43381
	for <cocci@archiver.kernel.org>; Fri, 15 Mar 2019 02:24:50 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16FC721872
	for <cocci@archiver.kernel.org>; Fri, 15 Mar 2019 02:24:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16FC721872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2F2OYWO014927
          ; Fri, 15 Mar 2019 03:24:34 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DE4367719;
	Fri, 15 Mar 2019 03:24:33 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E080B7714
 for <cocci@systeme.lip6.fr>; Fri, 15 Mar 2019 03:24:31 +0100 (CET)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.217.80.70])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x2F2OS6w019283
 for <cocci@systeme.lip6.fr>; Fri, 15 Mar 2019 03:24:30 +0100 (CET)
X-pt: isis.lip6.fr
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
 by Forcepoint Email with ESMTPS id CE52A2E56648D56CFF59;
 Fri, 15 Mar 2019 10:24:24 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
 by mse01.zte.com.cn with ESMTP id x2F2OG0C097582;
 Fri, 15 Mar 2019 10:24:16 +0800 (GMT-8)
 (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
 by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
 with ESMTP id 2019031510245239-4956102 ;
 Fri, 15 Mar 2019 10:24:52 +0800 
From: Wen Yang <wen.yang99@zte.com.cn>
To: Julia.Lawall@lip6.fr
Date: Fri, 15 Mar 2019 10:24:41 +0800
Message-Id: <1552616681-17985-1-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release
 8.5.3FP6|November 21, 2013) at 2019-03-15 10:24:52,
 Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-03-15 10:24:01, Serialize complete at 2019-03-15 10:24:01
X-MAIL: mse01.zte.com.cn x2F2OG0C097582
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 15 Mar 2019 03:24:34 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 15 Mar 2019 03:24:30 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: wang.yi59@zte.com.cn, michal.lkml@markovi.net, nicolas.palix@imag.fr,
        linux-kernel@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        cocci@systeme.lip6.fr
Subject: [Cocci] [PATCH] coccinelle: semantic patch for missing of_node_put
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

Looking for places where there is an of_node_put on some paths
but not on others. This SmPL checks that there is a put of the
same data elsewhere in the function, so perhaps that will
alleviate the concern about puts where they are not needed,
while still making it possible to find the ones that are needed.

Suggested-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Reviewed-by: Julia Lawall <Julia.Lawall@lip6.fr>
---
 scripts/coccinelle/free/of_node_put.cocci | 57 +++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 scripts/coccinelle/free/of_node_put.cocci

diff --git a/scripts/coccinelle/free/of_node_put.cocci b/scripts/coccinelle/free/of_node_put.cocci
new file mode 100644
index 0000000..6a29830
--- /dev/null
+++ b/scripts/coccinelle/free/of_node_put.cocci
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+/// Find missing of_node_put
+///
+// Confidence: Moderate
+// Comments:
+// Options: --no-includes --include-headers
+
+virtual report
+virtual org
+
+@r exists@
+local idexpression struct device_node *x;
+identifier f;
+statement S,S1,S2;
+expression e,e1;
+position p1,p2;
+type T,T1;
+@@
+
+(
+x = f@p1(...);
+... when != e = (T)x
+if (x == NULL || ...) S1
+else S2
+... when != of_node_put(x)
+ when != if (x) { ... of_node_put(x) ... }
+ when != e1 = (T1)x
+(
+return x;
+|
+return@p2 ...;
+)
+&
+x = f(...)
+...
+if (<+...x...+>) S
+...
+of_node_put(x);
+)
+
+@script:python depends on report@
+p1 << r.p1;
+p2 << r.p2;
+@@
+
+coccilib.report.print_report(p2[0],
+			     "ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line "
+			     + p1[0].line
+			     + ", but without a corresponding object release within this function.")
+
+@script:python depends on org@
+p1 << r.p1;
+p2 << r.p2;
+@@
+
+cocci.print_main("acquired a node pointer with refcount incremented", p1)
+cocci.print_secs("needed of_node_put", p2)
-- 
2.9.5

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
