Return-Path: <SRS0=0GNs=4Z=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B498BC3F2D1
	for <cocci@archiver.kernel.org>; Sun,  8 Mar 2020 08:44:40 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3412020838
	for <cocci@archiver.kernel.org>; Sun,  8 Mar 2020 08:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGR9rIC1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3412020838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0288iQuH029812;
	Sun, 8 Mar 2020 09:44:26 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 992027742;
	Sun,  8 Mar 2020 09:44:26 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E29FA781C
 for <cocci@systeme.lip6.fr>; Sun,  8 Mar 2020 09:44:23 +0100 (CET)
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:541])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0288iMkl006007
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 8 Mar 2020 09:44:23 +0100 (CET)
Received: by mail-pg1-x541.google.com with SMTP id s2so3294867pgv.6
 for <cocci@systeme.lip6.fr>; Sun, 08 Mar 2020 00:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BWmU0CCIAJ+awXhzPRis2ZnBs9YE2AOgvD/U4w8cFVI=;
 b=fGR9rIC1Won/UochR+VtI8cmUmtayiA7fU1kYtzLKcdXc/1fcm2MqUegMmNKYCscDQ
 /QkalyLLmuX+s3tlHK7MWQ2sqNZl+HHnWcjsABEZMkElZb26lrzW5NfYB0E1wy/x2tK+
 DXWwjFRFLF/NVLg099getxrCql+VsdtFfhzw9Gde+hdlv0rA09VboJUe4xcJOpCNA40d
 sUKrN6Q/XhHIxKtnCC77SAf7Q8PNl8bhksN+3Ff/9CeZg4hloWMSO/i49WrUZETCpzFq
 I3Jom6XuOwFo8L4FS/g++W+6mZo7AfGX4viS08a02Myx57IBysG6lKc9EC9mE36dyHR+
 ATVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BWmU0CCIAJ+awXhzPRis2ZnBs9YE2AOgvD/U4w8cFVI=;
 b=rdXJc2hGMkCAEXaf9gIQ67HuEcVVb9rzWu4pNk8mjbQanJsWAIbdgtTE1MnXmOQVJq
 g27YSP+OIcwRseO9qKCvRhXTjyxiC4ycge5JVpqHT92JyW/e+0OysYQwDFJEOnDfFeLP
 79ZUjbkik5xn8resbo5O5diWX931wfiB5OcDbo8S7HV4Y/bA6q+8OE/aK67hZKXHIxkT
 Ep3qnPExZyMDp9sxFBhuuldhbdtuNhwd6Eth8BjGB+mupvHNOXXkBasVMGuxJJS5KtUi
 78pF+LmJWkC741yYtoQqrtJoim4vQs2N8kA+SOlPlW21oM9uxy6/6W9GHL8utLwl/MNE
 JcEA==
X-Gm-Message-State: ANhLgQ0RgKoK4Wq1/8XzP9QwdR86O1MCKQqiKy4AvnT3ybDYRB7X74rF
 5/vNOeGE8CD/2/VhnMLHfj/nsBF2
X-Google-Smtp-Source: ADFU+vuybUjwe/vqOERl050UPJBWNHBNHjJHvvhLMvaa9xdofrmZZ/AoXTIKfcNOfisuKCg1hozHVQ==
X-Received: by 2002:a63:c507:: with SMTP id f7mr10830711pgd.278.1583657061509; 
 Sun, 08 Mar 2020 00:44:21 -0800 (PST)
Received: from localhost.localdomain ([1.38.148.20])
 by smtp.gmail.com with ESMTPSA id b3sm14587244pjo.30.2020.03.08.00.44.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Mar 2020 00:44:21 -0800 (PST)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun,  8 Mar 2020 14:13:48 +0530
Message-Id: <20200308084356.14506-6-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200308084356.14506-1-jaskaransingh7654321@gmail.com>
References: <20200308084356.14506-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 08 Mar 2020 09:44:26 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 08 Mar 2020 09:44:23 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 05/13] ocaml: coccilib: Reflect EnumDeclTag and
	EnumDeclDotsTag
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

The SmPL AST now has these constructors. Reflect these changes in
coccilib.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 ocaml/coccilib.mli | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/ocaml/coccilib.mli b/ocaml/coccilib.mli
index 9b00e130..d01d2a93 100644
--- a/ocaml/coccilib.mli
+++ b/ocaml/coccilib.mli
@@ -3056,6 +3056,7 @@ module Ast_cocci :
       | LogicalOpTag of logicalOp
       | DeclarationTag of declaration
       | FieldTag of field
+      | EnumDeclTag of enum_decl
       | InitTag of initialiser
       | StorageTag of storage
       | IncFileTag of inc_file
@@ -3073,6 +3074,7 @@ module Ast_cocci :
       | StmtDotsTag of statement dots
       | AnnDeclDotsTag of annotated_decl dots
       | AnnFieldDotsTag of annotated_field dots
+      | EnumDeclDotsTag of enum_decl dots
       | DefParDotsTag of define_param dots
       | TypeCTag of typeC
       | ParamTag of parameterTypeDef
@@ -3621,6 +3623,7 @@ module Ast0_cocci :
       | DotsStmtTag of statement dots
       | DotsDeclTag of declaration dots
       | DotsFieldTag of field dots
+      | DotsEnumDeclTag of enum_decl dots
       | DotsCaseTag of case_line dots
       | DotsDefParamTag of define_param dots
       | IdentTag of ident
@@ -3634,6 +3637,7 @@ module Ast0_cocci :
       | InitTag of initialiser
       | DeclTag of declaration
       | FieldTag of field
+      | EnumDeclTag of enum_decl
       | StmtTag of statement
       | ForInfoTag of forinfo
       | CaseLineTag of case_line
@@ -3651,6 +3655,7 @@ module Ast0_cocci :
     val dotsStmt : statement dots -> anything
     val dotsDecl : declaration dots -> anything
     val dotsField : field dots -> anything
+    val dotsEnumDecl : enum_decl dots -> anything
     val dotsCase : case_line dots -> anything
     val dotsDefParam : define_param dots -> anything
     val ident : ident -> anything
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
