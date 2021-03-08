Return-Path: <SRS0=tA4o=IG=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3D8C433DB
	for <cocci@archiver.kernel.org>; Mon,  8 Mar 2021 19:12:57 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD60565177
	for <cocci@archiver.kernel.org>; Mon,  8 Mar 2021 19:12:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD60565177
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 128JCbNo005288;
	Mon, 8 Mar 2021 20:12:37 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1649477BF;
	Mon,  8 Mar 2021 20:12:37 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 370203BA2
 for <cocci@systeme.lip6.fr>; Mon,  8 Mar 2021 20:12:35 +0100 (CET)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com
 [209.85.167.52])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 128JCYlx028959
 for <cocci@systeme.lip6.fr>; Mon, 8 Mar 2021 20:12:34 +0100 (CET)
Received: by mail-lf1-f52.google.com with SMTP id q25so22769217lfc.8
 for <cocci@systeme.lip6.fr>; Mon, 08 Mar 2021 11:12:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=afP4kefJJSWnfkTP8BQ+r54P2vlw+syUq9XfIeAB8YE=;
 b=Ce8fFFIZRs4K5LbD51gVsw0e4di3/MVoiv9ZtktjOLqOcSeXG8QMP+es0gDT6Hf3KM
 FaMo07AqxJgP5rfiIEeqJH0x4IOn35NW2MUWuec0Mv1H3Lvzgvepw+H5hik9rvgMwXwf
 wP6NR1Unpnpl3fX+eYZiYTD9ter7b+WKVoy8N7rrzg5kmLBog0u8u717S6FeiYwxhag2
 6tHqOgolBy33Id1gj/D/LPQAcTrPbp9MgDqCbnpuwG8FKSF48xy0NKQdL8GXFdEXQXwc
 4g2RIBh/tD1EfJ6hYNrpEMyFoBCTLn+JKF0n0Sdza7ct3OHIGlEjMnnUYAhv4xXpMeS4
 xx4w==
X-Gm-Message-State: AOAM5314pAXuYayb8ToM6G4DLJVmH9TxL6JBmM2PZLQ3e29767QIvNq2
 aq1kqd5wncQJ/xqQVwLu7Ew=
X-Google-Smtp-Source: ABdhPJyqo5t9w7K5r1yW96oN4dU+gW41inH3X6zO8ESg5vkEij9UFT340CdfCZ0k0aEBrPFSQTmqVg==
X-Received: by 2002:a05:6512:110a:: with SMTP id
 l10mr16001088lfg.140.1615230753711; 
 Mon, 08 Mar 2021 11:12:33 -0800 (PST)
Received: from localhost.. (broadband-188-32-236-56.ip.moscow.rt.ru.
 [188.32.236.56])
 by smtp.googlemail.com with ESMTPSA id p9sm1603298ljn.16.2021.03.08.11.12.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Mar 2021 11:12:33 -0800 (PST)
From: Denis Efremov <efremov@linux.com>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Mon,  8 Mar 2021 22:12:15 +0300
Message-Id: <20210308191215.1362498-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 08 Mar 2021 20:12:37 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 08 Mar 2021 20:12:34 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: [Cocci] [PATCH] coccinelle: misc: restrict patch mode in
	flexible_array.cocci
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

Skip patches generation for structs/unions with a single field.
Changing a zero-length array to a flexible array member in a struct
with no named members breaks the compilation. However, reporting
such cases is still valuable, e.g. commit 637464c59e0b
("ACPI: NFIT: Fix flexible_array.cocci warnings").

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 scripts/coccinelle/misc/flexible_array.cocci | 23 ++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/scripts/coccinelle/misc/flexible_array.cocci b/scripts/coccinelle/misc/flexible_array.cocci
index 947fbaff82a9..f427fd68ed2d 100644
--- a/scripts/coccinelle/misc/flexible_array.cocci
+++ b/scripts/coccinelle/misc/flexible_array.cocci
@@ -51,21 +51,40 @@ position p : script:python() { relevant(p) };
   };
 )
 
+@only_field depends on patch@
+identifier name, array;
+type T;
+position q;
+@@
+
+(
+  struct name {@q
+    T array[0];
+  };
+|
+  struct {@q
+    T array[0];
+  };
+)
+
 @depends on patch@
 identifier name, array;
 type T;
 position p : script:python() { relevant(p) };
+// position @q with rule "only_field" simplifies
+// handling of bitfields, arrays, etc.
+position q != only_field.q;
 @@
 
 (
-  struct name {
+  struct name {@q
     ...
     T array@p[
 -       0
     ];
   };
 |
-  struct {
+  struct {@q
     ...
     T array@p[
 -       0
-- 
2.26.2

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
