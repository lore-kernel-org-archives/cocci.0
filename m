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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE06C433E1
	for <cocci@archiver.kernel.org>; Fri, 29 May 2020 12:10:25 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57DE420814
	for <cocci@archiver.kernel.org>; Fri, 29 May 2020 12:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/h/BZ33"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57DE420814
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04TCAMfu019787;
	Fri, 29 May 2020 14:10:22 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D99827783;
	Fri, 29 May 2020 14:10:22 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 451775D47
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 14:10:21 +0200 (CEST)
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:541])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04TCAJYv018981
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 14:10:20 +0200 (CEST)
Received: by mail-pg1-x541.google.com with SMTP id u5so1417605pgn.5
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 05:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kOSNkAJM7YmgUnwR6hfpPIBY1iMqoMfM/FUCtwfu9kE=;
 b=d/h/BZ33hSM0x+Me6PAgDFLYuKuhN0fgBedTRdmO5SiPYtg395UeTMlc9p9gc0kxOk
 TqRxN6HK7HL6f2A5uprw2pzWWjTc6ep9Z2V1cM6yoZbZtRekuHIamIBcDoddLr0SMpY/
 tcYUGSZVUvf20SArFEcUEAJ8bCvaDSM88m2NQGLdA/C+wQukbIHh1MKunuiPFaq05KKr
 DOznP7wjDZ3cqBjltQRf+giYjyiuUBEXENjd9mI17tcnupV9eAq5xeAsQsGJ8ZvmiPkb
 iOCiuthmPobTCajJFYAg1wkU8Q0IQCZm5jplWEYbwa0wbG/jNQFw6Y3Y5kZmuz3EeesK
 VrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kOSNkAJM7YmgUnwR6hfpPIBY1iMqoMfM/FUCtwfu9kE=;
 b=WqHGpBDAtKOyB+jbOeVIYnZgtPTN1fBnzgFVZEqLf7nP7GFDCv11aYca3owEfuLEn7
 QJpXkOhcVCodQNahE9wi6dOv7+7u6Kk3Xc3PbaDny5pagJx7jdj9rRiurVEW+1E5hsNi
 OqYy0zG+XeGNNXbVkCfLAFXZvIRTIY2V00FqjjComefJIrSC3de0XmgFa2D8hZ051rsr
 ExakS7fk8wWn2xBqOqPaqC4nQHuqXL7zWFl42s94RFJAHSbKtiO9dON457uvpWewjK5h
 d3Kh320i6//+07QNoF3EbaE0jgIwZhyNoK3b3vNPsB+5U3KMKB2SOwcSBp32cQuFlFcA
 fP0g==
X-Gm-Message-State: AOAM5315D3HaAyqi4livywR7akWCBW1i81nolquv2bsA6cJveWflT4gL
 bJb6wfd6Y6quv01QqJFcKHhaDlqs
X-Google-Smtp-Source: ABdhPJxDMPeVCG6nN//nw4Fl4kyEU8yQQN8djdXYmrLSFn2H4LYkbk4NHpASAV5hIeLbe92q/GpAKw==
X-Received: by 2002:a05:6a00:843:: with SMTP id
 q3mr8113760pfk.107.1590754218795; 
 Fri, 29 May 2020 05:10:18 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:694:e576:19d1:a79b:707d:59f2])
 by smtp.gmail.com with ESMTPSA id dw13sm7975161pjb.40.2020.05.29.05.10.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2020 05:10:18 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 29 May 2020 17:36:58 +0530
Message-Id: <20200529120703.31145-29-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200529120703.31145-1-jaskaransingh7654321@gmail.com>
References: <20200529120703.31145-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 29 May 2020 14:10:22 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 29 May 2020 14:10:20 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 28/32] ocaml: coccilib: Reflect Cast attributes
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

Cast attributes are added to the C and SmPL ASTs. Reflect these changes
in coccilib.mli.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 ocaml/coccilib.mli | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/ocaml/coccilib.mli b/ocaml/coccilib.mli
index 30cb1a08..a007e6bc 100644
--- a/ocaml/coccilib.mli
+++ b/ocaml/coccilib.mli
@@ -146,7 +146,7 @@ module Ast_c :
       | RecordPtAccess of expression * name
       | SizeOfExpr of expression
       | SizeOfType of fullType
-      | Cast of fullType * expression
+      | Cast of fullType * attribute list * expression
       | StatementExpr of compound wrap
       | Constructor of fullType * initialiser
       | ParenExpr of expression
@@ -2570,7 +2570,7 @@ module Ast_cocci :
       | ArrayAccess of expression * string mcode * expression * string mcode
       | RecordAccess of expression * string mcode * ident
       | RecordPtAccess of expression * string mcode * ident
-      | Cast of string mcode * fullType * string mcode * expression
+      | Cast of string mcode * fullType * attr list * string mcode * expression
       | SizeOfExpr of string mcode * expression
       | SizeOfType of string mcode * string mcode * fullType * string mcode
       | TypeExp of fullType
@@ -3306,7 +3306,7 @@ module Ast0_cocci :
       | ArrayAccess of expression * string mcode * expression * string mcode
       | RecordAccess of expression * string mcode * ident
       | RecordPtAccess of expression * string mcode * ident
-      | Cast of string mcode * typeC * string mcode * expression
+      | Cast of string mcode * typeC * attr list * string mcode * expression
       | SizeOfExpr of string mcode * expression
       | SizeOfType of string mcode * string mcode * typeC * string mcode
       | TypeExp of typeC
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
