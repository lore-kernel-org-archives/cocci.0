Return-Path: <SRS0=Yx51=7L=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D1CC433DF
	for <cocci@archiver.kernel.org>; Fri, 29 May 2020 12:09:22 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01C6D206F0
	for <cocci@archiver.kernel.org>; Fri, 29 May 2020 12:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZDTfYs3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01C6D206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04TC9Jrd010249;
	Fri, 29 May 2020 14:09:19 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 544B87783;
	Fri, 29 May 2020 14:09:19 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 316475D47
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 14:09:17 +0200 (CEST)
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:644])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04TC9FlT016199
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 14:09:16 +0200 (CEST)
Received: by mail-pl1-x644.google.com with SMTP id x18so1098765pll.6
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 05:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BoYnjbUIzA7PZWWKCtdCogdX3oJtvleHvw9nDhGFwPM=;
 b=mZDTfYs3pTcqu6+V8dsGTSEfB7+9DfNWr2XJF8CmNrv5NlmrGO4bjvhNo/o+WQaB9k
 sno7qKTYFvC1YYvCT0z3sQWwKpzNoKchpt8WxejelXpbjmPUkJAbC5lQ9SCgZ2k0Zsr4
 6zmw0p0Tuzqu40CEQN65/eCbSOd75vmF/NnxBKUK7fhYtbpfxCJXlYwPJw5iNFu12oN2
 VqmM4D/KTWMVsxalFAnRNDgIse4Vj/5bwdmTi8/Dn4C+p6/k+JoyinRT7zNNUij0gSfs
 pApTQhUFSSYMOH3DpnKCD+qwxarc+FJ01pMdzxNRTB/utyvlCZocCegDmUK2GOhkfHNv
 5wVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BoYnjbUIzA7PZWWKCtdCogdX3oJtvleHvw9nDhGFwPM=;
 b=JOurGa/j3xfEEJXGtZ45QdWH9vRZta1Fwse4WPPnQwRc+By/FCSjeQeOkTg37rkcdZ
 N2MTzScbtjgADLwya06mfgBGf5NQIc2qduksQwICe4iDu2ffAu6q42dHVKuHuXmcUIkB
 FBqN86N42zqDcphI5MlrQpAYbzr0ntvkDg6zvkrvVL5DU9mgN4GVc2pyQ5sSmYeYIKE/
 LpJZ30GxgSVRXJCJc4qvEhjbsIlg0bIcdlD6B6lKK9MkfVlI/y0QkAc1xkRjvUIU1jg+
 UkJhv6efDzU1PxzDCmqiCNyQpQMrkbrQiq5hrYD+FMsn+gObq0tbjnjrF2UMohKx9MN4
 hL6w==
X-Gm-Message-State: AOAM5302aRB0SvyRXEZBFXqWwUotR3Z1d+rHXC3WkUitj/YuN6t2JvjP
 RB3cSDFTjQiV77EUXni8LR7PRdxj
X-Google-Smtp-Source: ABdhPJzsEY4shWALEU++Dc852QvwukAqcjnQS2QsrNY/GMI3Ad5rqIH02E9uEijbRXD0qHhIexHmkQ==
X-Received: by 2002:a17:90a:2ec1:: with SMTP id
 h1mr9330774pjs.145.1590754154772; 
 Fri, 29 May 2020 05:09:14 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:694:e576:19d1:a79b:707d:59f2])
 by smtp.gmail.com with ESMTPSA id dw13sm7975161pjb.40.2020.05.29.05.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2020 05:09:14 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 29 May 2020 17:36:44 +0530
Message-Id: <20200529120703.31145-15-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200529120703.31145-1-jaskaransingh7654321@gmail.com>
References: <20200529120703.31145-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 29 May 2020 14:09:19 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 29 May 2020 14:09:16 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 14/32] parsing_cocci: ast_cocci: Add cast
	attributes
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

Add cast attributes to the SmPL AST. This is a list of attributes in the
Cast type of the SmPL AST.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/ast_cocci.ml  | 4 ++--
 parsing_cocci/ast_cocci.mli | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/parsing_cocci/ast_cocci.ml b/parsing_cocci/ast_cocci.ml
index 919d1dcc..72c613ec 100644
--- a/parsing_cocci/ast_cocci.ml
+++ b/parsing_cocci/ast_cocci.ml
@@ -194,8 +194,8 @@ and base_expression =
 	              string mcode (* ] *)
   | RecordAccess   of expression * string mcode (* . *) * ident
   | RecordPtAccess of expression * string mcode (* -> *) * ident
-  | Cast           of string mcode (* ( *) * fullType * string mcode (* ) *) *
-                      expression
+  | Cast           of string mcode (* ( *) * fullType * attr list *
+                      string mcode (* ) *) * expression
   | SizeOfExpr     of string mcode (* sizeof *) * expression
   | SizeOfType     of string mcode (* sizeof *) * string mcode (* ( *) *
                       fullType * string mcode (* ) *)
diff --git a/parsing_cocci/ast_cocci.mli b/parsing_cocci/ast_cocci.mli
index 4b6e7296..af1563f6 100644
--- a/parsing_cocci/ast_cocci.mli
+++ b/parsing_cocci/ast_cocci.mli
@@ -178,8 +178,8 @@ and base_expression =
 	              string mcode (* ] *)
   | RecordAccess   of expression * string mcode (* . *) * ident
   | RecordPtAccess of expression * string mcode (* -> *) * ident
-  | Cast           of string mcode (* ( *) * fullType * string mcode (* ) *) *
-                      expression
+  | Cast           of string mcode (* ( *) * fullType * attr list *
+                      string mcode (* ) *) * expression
 
   | SizeOfExpr     of string mcode (* sizeof *) * expression
   | SizeOfType     of string mcode (* sizeof *) * string mcode (* ( *) *
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
