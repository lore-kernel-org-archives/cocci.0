Return-Path: <SRS0=43Z/=6Z=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5DFC47255
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:09:30 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF04C20720
	for <cocci@archiver.kernel.org>; Mon, 11 May 2020 10:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1YHPKkk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF04C20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04BA9Jda027639;
	Mon, 11 May 2020 12:09:19 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5F9D13E6B;
	Mon, 11 May 2020 12:09:19 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 23BC63DC8
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:09:18 +0200 (CEST)
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:541])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04BA9GHF025275
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 12:09:17 +0200 (CEST)
Received: by mail-pg1-x541.google.com with SMTP id u35so1363962pgk.6
 for <cocci@systeme.lip6.fr>; Mon, 11 May 2020 03:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=E9xs+VxrE+SKT0t/5AoaC7h0As2M2DyZtXWTfrJjWgM=;
 b=V1YHPKkkh3dReyTQ6UzrK1BP3naleJSXlnZMIwSz32x90CKn0knwSgSNU837RmL8x4
 adGQ2h/lm5Cq4rG+OhKybkIjI6w6P/I5umdIi6Ut5hVnQmGFUwLQqNH/NzDi1RGynjB4
 kU1IrISnfEfxaTwbP/A4LFTwkjhu4qkmLriW2BTs34X2CQ1ing/jy/jdVQmScTefc+hU
 boLPmrGeND0u3mum0Cfrzi5cpShuneYhpacX2OafNs5e93Mi42UHs0ZAVp/PGqFobd0n
 wZuG5n/dNjGQspWDCOrYXaqC56HEYVk7PbKepCFMEwV28EXKoUG3ykK+aXhcRnZSOmQJ
 GHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E9xs+VxrE+SKT0t/5AoaC7h0As2M2DyZtXWTfrJjWgM=;
 b=K1SDzpn7G7Jqk6FBlZqL9ujDzHZp0CNDTkyETZPFPuMUZrtap5dM2HJ+4LicWcUjQQ
 AXXYtkfDKg+PP1WLyA3qzmzBv1c24qCLCKoRTSxAvran0KvEJUREkgMAB1Uys5mOUjYk
 X3uQTLU6jA2tHgI0cNcoN43zHSXux0t1goI1EmPfMgTY/5Jkj6Bl8yG7BbANSlGx3ccD
 FC0kQS7ENAEl7JNAU+NoVhSCK9S1NuWy2sUoS6G8r3DkGuiIxbVU82xt8x2YCLp0vMJM
 hIKcSu9K95OLne6BjB/+TxnR5TxUEyIE1NPBe+wyg5iPx9f3q+88J0+2PAbsKgV9C0gI
 f0IQ==
X-Gm-Message-State: AGi0PuY9M8MK+CVUoCjN3xlbYk5DWdE/rNBbFNNt+lFsWspNvwX6ok0D
 2dosSUb+y1qJp3l8CA7tbjM2B/1To3Q=
X-Google-Smtp-Source: APiQypJcqqYnDAxt1j/n/42Zm7WWH7mTUMi2BG1IvYH3X6OyCv7FzeRpmyzEPLu0npIYxRcUkVIx/w==
X-Received: by 2002:aa7:92cc:: with SMTP id k12mr14743427pfa.184.1589191755840; 
 Mon, 11 May 2020 03:09:15 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:382:66db:4729:1ab8:2139:8945])
 by smtp.gmail.com with ESMTPSA id
 o99sm9772994pjo.8.2020.05.11.03.09.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 03:09:15 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 11 May 2020 15:37:08 +0530
Message-Id: <20200511100715.19819-26-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200511100715.19819-1-jaskaransingh7654321@gmail.com>
References: <20200511100715.19819-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 May 2020 12:09:19 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 11 May 2020 12:09:17 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v2 25/32] parsing_c: visitor_c: Visit Cast attributes
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

Cast attributes are added to the C AST. Visit these attributes in
the C AST visitor.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/visitor_c.ml | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/parsing_c/visitor_c.ml b/parsing_c/visitor_c.ml
index 57b5f32b..77a011d8 100644
--- a/parsing_c/visitor_c.ml
+++ b/parsing_c/visitor_c.ml
@@ -324,7 +324,10 @@ let rec vk_expr = fun bigf expr ->
 
     | SizeOfExpr  (e) -> exprf e
     | SizeOfType  (t) -> vk_type bigf t
-    | Cast    (t, e) -> vk_type bigf t; exprf e
+    | Cast    (t, a, e) ->
+        vk_type bigf t;
+        a +> List.iter (vk_attribute bigf);
+        exprf e
 
     (* old: | StatementExpr (((declxs, statxs), is)), is2 ->
      *          List.iter (vk_decl bigf) declxs;
@@ -1188,7 +1191,11 @@ let rec vk_expr_s = fun bigf expr ->
 
       | SizeOfExpr  (e) -> SizeOfExpr (exprf e)
       | SizeOfType  (t) -> SizeOfType (vk_type_s bigf t)
-      | Cast    (t, e)  -> Cast (vk_type_s bigf t, exprf e)
+      | Cast    (t, a, e)  ->
+          Cast
+            (vk_type_s bigf t,
+             a +> List.map (vk_attribute_s bigf),
+             exprf e)
 
       | StatementExpr (statxs, is) ->
           StatementExpr (
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
