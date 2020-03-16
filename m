Return-Path: <SRS0=+m3J=5B=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268BDC0044D
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2020 10:04:13 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94CAF20724
	for <cocci@archiver.kernel.org>; Mon, 16 Mar 2020 10:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTAHKKmA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94CAF20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02GA3lPf007653;
	Mon, 16 Mar 2020 11:03:48 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E348C782D;
	Mon, 16 Mar 2020 11:03:43 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B43537825
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 11:03:41 +0100 (CET)
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:542])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02GA3dHI021612
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 11:03:40 +0100 (CET)
Received: by mail-pg1-x542.google.com with SMTP id t24so9460679pgj.7
 for <cocci@systeme.lip6.fr>; Mon, 16 Mar 2020 03:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=c+3Ft9r0mp9w73EYF4QG/IldFw5ZluCT6wQKOTaDhbE=;
 b=QTAHKKmA/zGppCdqkRoLwOgjkrAIBAm3NV1fHQepn5jylNj3AlBKb/8JsqIGFCriGP
 rQdsJvdd02O5IIR2tx9+q0DfyazW7vFQ5oBbsa3R6fWJtLpWZiUE1Xo/+9SVhDKgCkWx
 aTaJidbpZPmGUlJZt2qD0c+yhfDTg4Ap7wsQmI3AH/YsATDeLubwL/a+L1B3Igh0OKGr
 oCyeAFQ1kv0XUCBV/tvWmuOA8ZFzAzsG4YsHSF9JHBTUh/4kjslvEo5K5WCn9RU54397
 TlPpeBMflvbVSYtDGiSx7jMFG+PRIEF0PgfCmbRRL9Ax/D2u5zrBre8v0hTevHf8IkJn
 k9yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=c+3Ft9r0mp9w73EYF4QG/IldFw5ZluCT6wQKOTaDhbE=;
 b=FiidsZ/QcBXxbt20FmwnNUZUaod2CcbCEDPN2WC8/2RnSPcp6vR2FYo9096XC/jNql
 odUhcZUGt8eHMBvNwhgpfq+VJxijiKZ5NnWIDRZ01hudoeeWOXmJraR0h8X2ilqy+92a
 pAohY53LlD/8A9xMjHWFJty0U0ABJ9TUMNlmljW4a8qu+j6eZai5qSZPjbnTt7td4Npv
 57nmDI7GP8zdnCh39Ut3hmc4dMp2vWiFOE1JH8UL+qndXHfVLN8KJWUxVzk5MdMYmg9f
 i3kd1LKCcXipOxgQN0MH/u4vk6Ks0HKh4HSGYA1TmoWE5qFrv89mFtbGuwy0iX9FKDcV
 zrHw==
X-Gm-Message-State: ANhLgQ3hkkQNUPU8BzSBj00vsM2NiTlpGfac5dYvEC5xdfPZiTy8X1jV
 MahXytVp/HlnD920g0tL+w7eJDSo
X-Google-Smtp-Source: ADFU+vuqGMHRo2hjtMKa6FHQnihc3U9MOYtoPrkgBqq0Q2oy517H4yk5TTTgMX3rypNFizI4cRHqKg==
X-Received: by 2002:aa7:8708:: with SMTP id b8mr28664996pfo.209.1584353018969; 
 Mon, 16 Mar 2020 03:03:38 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:284:a4f2:cc63:b7fc:551c:dce5])
 by smtp.gmail.com with ESMTPSA id
 u3sm19803374pjv.32.2020.03.16.03.03.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 03:03:38 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Mon, 16 Mar 2020 15:32:55 +0530
Message-Id: <20200316100319.27935-3-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316100319.27935-1-jaskaransingh7654321@gmail.com>
References: <20200316100319.27935-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 16 Mar 2020 11:03:48 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 16 Mar 2020 11:03:41 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 02/26] parsing_cocci: AST: Add ParenType and
	FunctionType to SmPL ASTs
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

ParenType and FunctionType are types present in the C AST that
are not present in the SmPL AST. In the pursuit of aligning
both the C and SmPL ASTs, add these types to the SmPL ASTs.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 ocaml/coccilib.mli           | 6 ++++++
 parsing_cocci/ast0_cocci.ml  | 3 +++
 parsing_cocci/ast0_cocci.mli | 3 +++
 parsing_cocci/ast_cocci.ml   | 3 +++
 parsing_cocci/ast_cocci.mli  | 3 +++
 5 files changed, 18 insertions(+)

diff --git a/ocaml/coccilib.mli b/ocaml/coccilib.mli
index 5a913099..e5409a97 100644
--- a/ocaml/coccilib.mli
+++ b/ocaml/coccilib.mli
@@ -2709,6 +2709,9 @@ module Ast_cocci :
       | Pointer of fullType * string mcode
       | FunctionPointer of fullType * string mcode * string mcode *
           string mcode * string mcode * parameter_list * string mcode
+      | ParenType of string mcode (* ( *) * fullType * string mcode (* ) *)
+      | FunctionType of fullType *
+          string mcode (* ( *) * parameter_list * string mcode (* ) *)
       | Array of fullType * string mcode * expression option * string mcode
       | Decimal of string mcode * string mcode * expression *
           string mcode option * expression option * string mcode
@@ -3353,6 +3356,9 @@ module Ast0_cocci :
       | Pointer of typeC * string mcode
       | FunctionPointer of typeC * string mcode * string mcode *
           string mcode * string mcode * parameter_list * string mcode
+      | ParenType of string mcode * typeC * string mcode
+      | FunctionType of typeC *
+          string mcode * parameter_list * string mcode
       | Array of typeC * string mcode * expression option * string mcode
       | Decimal of string mcode * string mcode * expression *
           string mcode option * expression option * string mcode
diff --git a/parsing_cocci/ast0_cocci.ml b/parsing_cocci/ast0_cocci.ml
index 77dc46f0..0acbeaa4 100644
--- a/parsing_cocci/ast0_cocci.ml
+++ b/parsing_cocci/ast0_cocci.ml
@@ -203,6 +203,9 @@ and base_typeC =
   | FunctionPointer of typeC *
 	          string mcode(* ( *)*string mcode(* * *)*string mcode(* ) *)*
                   string mcode (* ( *)*parameter_list*string mcode(* ) *)
+  | ParenType       of string mcode (* ( *) * typeC * string mcode (* ) *)
+  | FunctionType    of typeC *
+                  string mcode (* ( *) * parameter_list * string mcode (* ) *)
   | Array           of typeC * string mcode (* [ *) *
 	               expression option * string mcode (* ] *)
   | Decimal         of string mcode (* decimal *) * string mcode (* ( *) *
diff --git a/parsing_cocci/ast0_cocci.mli b/parsing_cocci/ast0_cocci.mli
index 274c6bc2..33bd12b2 100644
--- a/parsing_cocci/ast0_cocci.mli
+++ b/parsing_cocci/ast0_cocci.mli
@@ -194,6 +194,9 @@ and base_typeC =
   | FunctionPointer of typeC *
 	          string mcode(* ( *)*string mcode(* * *)*string mcode(* ) *)*
                   string mcode (* ( *)*parameter_list*string mcode(* ) *)
+  | ParenType       of string mcode (* ( *) * typeC * string mcode (* ) *)
+  | FunctionType    of typeC *
+                  string mcode (* ( *) * parameter_list * string mcode (* ) *)
   | Array           of typeC * string mcode (* [ *) *
 	               expression option * string mcode (* ] *)
   | Decimal         of string mcode (* decimal *) * string mcode (* ( *) *
diff --git a/parsing_cocci/ast_cocci.ml b/parsing_cocci/ast_cocci.ml
index ba6ec29e..f8e6dee6 100644
--- a/parsing_cocci/ast_cocci.ml
+++ b/parsing_cocci/ast_cocci.ml
@@ -343,6 +343,9 @@ and base_typeC =
   | FunctionPointer of fullType *
 	          string mcode(* ( *)*string mcode(* * *)*string mcode(* ) *)*
                   string mcode (* ( *)*parameter_list*string mcode(* ) *)
+  | ParenType       of string mcode (* ( *) * fullType * string mcode (* ) *)
+  | FunctionType    of fullType *
+                  string mcode (* ( *) * parameter_list * string mcode (* ) *)
   | Array           of fullType * string mcode (* [ *) *
 	               expression option * string mcode (* ] *)
   | Decimal         of string mcode (* decimal *) * string mcode (* ( *) *
diff --git a/parsing_cocci/ast_cocci.mli b/parsing_cocci/ast_cocci.mli
index 5f21664b..7fb54e4d 100644
--- a/parsing_cocci/ast_cocci.mli
+++ b/parsing_cocci/ast_cocci.mli
@@ -325,6 +325,9 @@ and base_typeC =
   | FunctionPointer of fullType *
 	          string mcode(* ( *)*string mcode(* * *)*string mcode(* ) *)*
                   string mcode (* ( *)*parameter_list*string mcode(* ) *)
+  | ParenType       of string mcode (* ( *) * fullType * string mcode (* ) *)
+  | FunctionType    of fullType *
+                  string mcode (* ( *) * parameter_list * string mcode (* ) *)
   | Array           of fullType * string mcode (* [ *) *
 	               expression option * string mcode (* ] *)
   | Decimal         of string mcode (* decimal *) * string mcode (* ( *) *
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
