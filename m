Return-Path: <SRS0=0GNs=4Z=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A00C3F2D2
	for <cocci@archiver.kernel.org>; Sun,  8 Mar 2020 08:44:40 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33AE3206D7
	for <cocci@archiver.kernel.org>; Sun,  8 Mar 2020 08:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1GC4AC+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33AE3206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0288iNup023183;
	Sun, 8 Mar 2020 09:44:23 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B3C1C77F4;
	Sun,  8 Mar 2020 09:44:23 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id DF0807742
 for <cocci@systeme.lip6.fr>; Sun,  8 Mar 2020 09:44:21 +0100 (CET)
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:644])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0288iJXf021999
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 8 Mar 2020 09:44:20 +0100 (CET)
Received: by mail-pl1-x644.google.com with SMTP id w12so2747727pll.13
 for <cocci@systeme.lip6.fr>; Sun, 08 Mar 2020 00:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qagemmdAByghWog/PZSgjV9lDfhA1TgFTR47PU95//M=;
 b=d1GC4AC+XpmzJ+bm7oLAgwMAh0wGT2P3Lm9WsnOHeJnIkX/mOrLiHVnxqdTeoCq85Q
 Mh2t9hGbQWkdxgowh4LvC55kBfDAqKVwvOf2SXWqpOAEPxbBajnSTDztXuPhSXZyAq8c
 9QW7kqLBe8Id8mVUk4wzI4CXnYbNaA7RbEmJa3N7sZj3d+UOhzfnBcKLPgtGPQgTSPjW
 eJWTUW+nw3VTRI7Kkzzfi/zO0EcQQDqlLx3g0rJbafKJVE5L6N9rqCPHN0UqIksSBSbD
 2jpaSlIcLoaLAmSlNrdbwhSbfkM4m+1FY1jbBVY0cwgpE39MflRaMvoT05CSuy5iwJDr
 e3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qagemmdAByghWog/PZSgjV9lDfhA1TgFTR47PU95//M=;
 b=BmMmVNepB/EFjjwb0xMmc26I/iHptkD2HRdP9SxuF67hdTBJJJgmOw18NBVi9vbf1F
 WgOqNWZNhvWef5tYi6mZKSjV5HKNgK/wUsngWtSvkNLPH1iq0rymOAIJpycEGKkiktT2
 3BA+04KMKYksLd0SmgGZegDmtq0jPocrmHE7gEi9CfhTZthnGI58j6LKfby5zfUmigLp
 Dp4JE2mUgtsUeJI9Uw0C0LGHqqe8weUkyfBn+hFQvEdLuBnfpNrRwuk9fpMJ/FP8ZOvy
 IHbdowjFfjG6PmXiFezpNpFWv5OHiT7jRnIE9j7JSMY1jPppiyO31P6FyACyNJ24h+0d
 QtMw==
X-Gm-Message-State: ANhLgQ1mm9syk4dBCeoKUmwEiNrTKy14I/wKRxvlcCpjvnNbskc9bgtE
 xXE9vt+fDg+6EcwNNqrTXWDUhh/N
X-Google-Smtp-Source: ADFU+vtnKOaVgntM6nicPE6H1uYoM812COQm0nIquik+g1h1po5hkvx/uc8LKlp1J5aoWnnq63bqhg==
X-Received: by 2002:a17:90a:1b4c:: with SMTP id
 q70mr12992692pjq.106.1583657059060; 
 Sun, 08 Mar 2020 00:44:19 -0800 (PST)
Received: from localhost.localdomain ([1.38.148.20])
 by smtp.gmail.com with ESMTPSA id b3sm14587244pjo.30.2020.03.08.00.44.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Mar 2020 00:44:18 -0800 (PST)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun,  8 Mar 2020 14:13:47 +0530
Message-Id: <20200308084356.14506-5-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200308084356.14506-1-jaskaransingh7654321@gmail.com>
References: <20200308084356.14506-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 08 Mar 2020 09:44:23 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 08 Mar 2020 09:44:21 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 04/13] parsing_cocci: Add EnumDeclTag and
	EnumDeclDotsTag to SmPL ASTs
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

These constructors are needed by the visitor and various other
functions in the codebase. Maintain consistency and add these
constructs w/r/t changes in the SmPL AST.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/ast0_cocci.ml  | 4 ++++
 parsing_cocci/ast0_cocci.mli | 4 ++++
 parsing_cocci/ast_cocci.ml   | 4 ++++
 parsing_cocci/ast_cocci.mli  | 2 ++
 4 files changed, 14 insertions(+)

diff --git a/parsing_cocci/ast0_cocci.ml b/parsing_cocci/ast0_cocci.ml
index b3d8b137..70486e4c 100644
--- a/parsing_cocci/ast0_cocci.ml
+++ b/parsing_cocci/ast0_cocci.ml
@@ -553,6 +553,7 @@ and anything =
   | DotsStmtTag of statement dots
   | DotsDeclTag of declaration dots
   | DotsFieldTag of field dots
+  | DotsEnumDeclTag of enum_decl dots
   | DotsCaseTag of case_line dots
   | DotsDefParamTag of define_param dots
   | IdentTag of ident
@@ -566,6 +567,7 @@ and anything =
   | InitTag of initialiser
   | DeclTag of declaration
   | FieldTag of field
+  | EnumDeclTag of enum_decl
   | StmtTag of statement
   | ForInfoTag of forinfo
   | CaseLineTag of case_line
@@ -585,6 +587,7 @@ let dotsInit x = DotsInitTag x
 let dotsStmt x = DotsStmtTag x
 let dotsDecl x = DotsDeclTag x
 let dotsField x = DotsFieldTag x
+let dotsEnumDecl x = DotsEnumDeclTag x
 let dotsCase x = DotsCaseTag x
 let dotsDefParam x = DotsDefParamTag x
 let ident x = IdentTag x
@@ -601,6 +604,7 @@ let forinfo x = ForInfoTag x
 let case_line x = CaseLineTag x
 let string_fragment x = StringFragmentTag x
 let top x = TopTag x
+let enum_decl x = EnumDeclTag x
 
 (* --------------------------------------------------------------------- *)
 (* Avoid cluttering the parser.  Calculated in compute_lines.ml. *)
diff --git a/parsing_cocci/ast0_cocci.mli b/parsing_cocci/ast0_cocci.mli
index 732a1345..7b2a87c4 100644
--- a/parsing_cocci/ast0_cocci.mli
+++ b/parsing_cocci/ast0_cocci.mli
@@ -542,6 +542,7 @@ and anything =
   | DotsStmtTag of statement dots
   | DotsDeclTag of declaration dots
   | DotsFieldTag of field dots
+  | DotsEnumDeclTag of enum_decl dots
   | DotsCaseTag of case_line dots
   | DotsDefParamTag of define_param dots
   | IdentTag of ident
@@ -555,6 +556,7 @@ and anything =
   | InitTag of initialiser
   | DeclTag of declaration
   | FieldTag of field
+  | EnumDeclTag of enum_decl
   | StmtTag of statement
   | ForInfoTag of forinfo
   | CaseLineTag of case_line
@@ -574,6 +576,7 @@ val dotsParam : parameterTypeDef dots -> anything
 val dotsStmt : statement dots -> anything
 val dotsDecl : declaration dots -> anything
 val dotsField : field dots -> anything
+val dotsEnumDecl : enum_decl dots -> anything
 val dotsCase : case_line dots -> anything
 val dotsDefParam : define_param dots -> anything
 val ident : ident -> anything
@@ -585,6 +588,7 @@ val param : parameterTypeDef -> anything
 val ini : initialiser -> anything
 val decl : declaration -> anything
 val field : field -> anything
+val enum_decl : enum_decl -> anything
 val stmt : statement -> anything
 val forinfo : forinfo -> anything
 val case_line : case_line -> anything
diff --git a/parsing_cocci/ast_cocci.ml b/parsing_cocci/ast_cocci.ml
index 8fa64dcc..27942992 100644
--- a/parsing_cocci/ast_cocci.ml
+++ b/parsing_cocci/ast_cocci.ml
@@ -790,6 +790,7 @@ and anything =
   | LogicalOpTag        of logicalOp
   | DeclarationTag      of declaration
   | FieldTag            of field
+  | EnumDeclTag         of enum_decl
   | InitTag             of initialiser
   | StorageTag          of storage
   | IncFileTag          of inc_file
@@ -807,6 +808,7 @@ and anything =
   | StmtDotsTag         of statement dots
   | AnnDeclDotsTag      of annotated_decl dots
   | AnnFieldDotsTag     of annotated_field dots
+  | EnumDeclDotsTag     of enum_decl dots
   | DefParDotsTag       of define_param dots
   | TypeCTag            of typeC
   | ParamTag            of parameterTypeDef
@@ -932,6 +934,7 @@ and tag2c = function
   | LogicalOpTag _ -> "LogicalOpTag"
   | DeclarationTag _ -> "DeclarationTag"
   | FieldTag _ -> "FieldTag"
+  | EnumDeclTag _ -> "EnumDeclTag"
   | InitTag _      -> "InitTag"
   | StorageTag _   -> "StorageTag"
   | IncFileTag _   -> "IncFileTag"
@@ -949,6 +952,7 @@ and tag2c = function
   | StmtDotsTag _ -> "StmtDotsTag"
   | AnnDeclDotsTag _ -> "AnnDeclDotsTag"
   | AnnFieldDotsTag _ -> "AnnFieldDotsTag"
+  | EnumDeclDotsTag _ -> "EnumDeclDotsTag"
   | DefParDotsTag _ -> "DefParDotsTag"
   | TypeCTag _ -> "TypeCTag"
   | ParamTag _ -> "ParamTag"
diff --git a/parsing_cocci/ast_cocci.mli b/parsing_cocci/ast_cocci.mli
index e921f917..8316a427 100644
--- a/parsing_cocci/ast_cocci.mli
+++ b/parsing_cocci/ast_cocci.mli
@@ -759,6 +759,7 @@ and anything =
   | LogicalOpTag        of logicalOp
   | DeclarationTag      of declaration
   | FieldTag            of field
+  | EnumDeclTag         of enum_decl
   | InitTag             of initialiser
   | StorageTag          of storage
   | IncFileTag          of inc_file
@@ -776,6 +777,7 @@ and anything =
   | StmtDotsTag         of statement dots
   | AnnDeclDotsTag      of annotated_decl dots
   | AnnFieldDotsTag     of annotated_field dots
+  | EnumDeclDotsTag     of enum_decl dots
   | DefParDotsTag       of define_param dots
   | TypeCTag            of typeC
   | ParamTag            of parameterTypeDef
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
