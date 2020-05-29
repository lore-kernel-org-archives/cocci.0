Return-Path: <SRS0=Yx51=7L=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EFCC433DF
	for <cocci@archiver.kernel.org>; Fri, 29 May 2020 12:09:48 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC43A206F0
	for <cocci@archiver.kernel.org>; Fri, 29 May 2020 12:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsQYrw5I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC43A206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04TC9j4M012286;
	Fri, 29 May 2020 14:09:45 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2E7657783;
	Fri, 29 May 2020 14:09:45 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 925AC5D47
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 14:09:43 +0200 (CEST)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:443])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04TC9frF024490
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 14:09:42 +0200 (CEST)
Received: by mail-pf1-x443.google.com with SMTP id n18so1310175pfa.2
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 05:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bZ6pS8AgHrGgUWxTtl9ZJbx/zzrWJSzl0y4c7eKWW6w=;
 b=KsQYrw5IwHGg6MxG7LMlC1X7GSpV8IO+PpSRq/QJyBgW/OI32SGSn+xW3N5zQOyaQR
 tCjb7rnIwhhTV8I88BOu7ci0OoGPXzs996TQU4ga7vCx4KzMcTbtPu4S4/muuTSeGM7B
 w1/ISxJfnPvlCzk9ZizLwto04CQo/wzzCT3qE1RcfvB367wMpiQj7M+qhpsZgo3Umyz2
 HUVEbfNJDqYvUcY99pNKHmLk9jWtE0Gb7RegfAsHjaWx+3JBX27zzklOEmIRtvZ7tljI
 ngMPkCqsSEBUCG/55pAjVVFRKip0k2R3TuGmVxyacG/LRXNMhLklRChzfxnI6PcBfrn+
 PA0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bZ6pS8AgHrGgUWxTtl9ZJbx/zzrWJSzl0y4c7eKWW6w=;
 b=Yo1qSGKHi2WyAk4QgX2H2e+8jfRbv0v2WXrF3VArS9TH9JfzratgqdVItSqfghp5ps
 JsxqA79iXTDDWK3zvn1WxXoiexgOWWJgMHPoGlJn1vimum/SOXtMz9EAhK3D1ZQyyPgb
 2TDCHrjo19X/FXUyHlGy8VC9fEECP/4oWoDnhSYuSmgFagkABM+u8WDDrV3Fxym/JIAy
 GIn4uSV960af0uk9o2LSKtmLAu++az8HbUcjvEFyyWMz8HOewlyL4nFljeVHuN1K6IhU
 PpXtYrzU8P4qxTP/RHTIaRIIpjQzchrGFZIE7qqVfIsQ2T+Rjxxkb5lJ/sB/a/Vb6kye
 ykvQ==
X-Gm-Message-State: AOAM531+N9LjN4HaJ1A5b7O0IQ/wYhf+DoFGH2oBeGNwmdyZzwnJOuFa
 UJItJO5L4M7XVnwIqWqRqfFkikwH
X-Google-Smtp-Source: ABdhPJxziO4+zD1YQUVFQH6nwQepc9y4ePIdtmyMy+1EEug3r49q6UKOlK3B/86PDK08PApRE8fF/A==
X-Received: by 2002:a63:e804:: with SMTP id s4mr8224234pgh.260.1590754181175; 
 Fri, 29 May 2020 05:09:41 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:694:e576:19d1:a79b:707d:59f2])
 by smtp.gmail.com with ESMTPSA id dw13sm7975161pjb.40.2020.05.29.05.09.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2020 05:09:40 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 29 May 2020 17:36:50 +0530
Message-Id: <20200529120703.31145-21-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200529120703.31145-1-jaskaransingh7654321@gmail.com>
References: <20200529120703.31145-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 29 May 2020 14:09:45 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 29 May 2020 14:09:43 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 20/32] parsing_c: ast_c: Add Cast attributes
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

Add cast attributes to the C AST. This is a list of attributes in the
Cast type of the C AST.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/ast_c.ml  | 2 +-
 parsing_c/ast_c.mli | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/parsing_c/ast_c.ml b/parsing_c/ast_c.ml
index 204bd412..7a945162 100644
--- a/parsing_c/ast_c.ml
+++ b/parsing_c/ast_c.ml
@@ -343,7 +343,7 @@ and expression = (expressionbis * exp_info ref (* semantic: *)) wrap3
 
   | SizeOfExpr     of expression
   | SizeOfType     of fullType
-  | Cast           of fullType * expression
+  | Cast           of fullType * attribute list * expression
 
   (* gccext: *)
   | StatementExpr of compound wrap (* ( )     new scope *)
diff --git a/parsing_c/ast_c.mli b/parsing_c/ast_c.mli
index 5411bbb3..0e23ceaa 100644
--- a/parsing_c/ast_c.mli
+++ b/parsing_c/ast_c.mli
@@ -104,7 +104,7 @@ and expressionbis =
   | RecordPtAccess of expression * name
   | SizeOfExpr of expression
   | SizeOfType of fullType
-  | Cast of fullType * expression
+  | Cast of fullType * attribute list * expression
   | StatementExpr of compound wrap
   | Constructor of fullType * initialiser
   | ParenExpr of expression
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
