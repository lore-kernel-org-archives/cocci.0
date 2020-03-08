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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476B6C3F2D1
	for <cocci@archiver.kernel.org>; Sun,  8 Mar 2020 08:44:38 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F97C206D7
	for <cocci@archiver.kernel.org>; Sun,  8 Mar 2020 08:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vTA6AwJe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F97C206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0288iDjS008846;
	Sun, 8 Mar 2020 09:44:13 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2B2CE7800;
	Sun,  8 Mar 2020 09:44:13 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1A3AB7742
 for <cocci@systeme.lip6.fr>; Sun,  8 Mar 2020 09:44:11 +0100 (CET)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:544])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0288i9db026054
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 8 Mar 2020 09:44:10 +0100 (CET)
Received: by mail-pg1-x544.google.com with SMTP id h8so3289724pgs.9
 for <cocci@systeme.lip6.fr>; Sun, 08 Mar 2020 00:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vOKXLRyIQIQIj6PkqX4hLM7maWPHM49HWGvwgyeyiF0=;
 b=vTA6AwJeHjohV86/1Ci2LCdydD47Kve7mlRRD3CrHLsviH0R6qgKy9OVbBKE8MG+ba
 KvRK52+3zBwsbMiQnhMmHpkdgt/l+vdjlZeFlvVCOfRGCqmN/+oe40ylvkTDJI+Ndw3R
 3uTD036Z+IkaJjLsPItkQ3KPAOICgD1/9QYrE7A7yOviYEwbtw3AEMwQvzWVdYXmTf1f
 U4JK1PADDSXbH+SdksZRnkUj0iLREU+UOk/OQY9kmieYHvov8CGEZmUYDCRCGELRHME6
 KOtyqDTcrV53QpeqR98Mo18Joz4ASsKmcijpuO3vmRp4POrAXB74EIjmk6TDnyP87keA
 S2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vOKXLRyIQIQIj6PkqX4hLM7maWPHM49HWGvwgyeyiF0=;
 b=lpYeUJDlwxglFgwoTKCS5rAv//eMVWnYPqn5oGKfhRiQvYhDrjNmdc4BzMN8DiXAP/
 ggQO0rYGVbM4+7uA5eTMxE64CZegGN7xC+a0btv1WTKmIb9cuqoWROiHzmdoDSJFcWeA
 o6l19KJAohksvSaba/RhtnJovmwuRR2HuvAKxDgnD33mNK2n2u7myeCHsi39QYNwbqet
 X0QQaRhwXnjfEzBjPbswV2AkTHb6Kbc36sPWgZxz+29zO46o0cmc0LNBSrB4hUra7Hoq
 FBbJ55s3NmKrmPV4veqFoQ7z+D2+94E1LMewhTSauaUm4wEzgHNMoTOmnw+hxwWazPok
 7Jeg==
X-Gm-Message-State: ANhLgQ0TriHWMZuHxWoN7f3ZiRnKke5QxtJ7MqYsAIIBTfELwZnwH2pe
 Fg60NXNKLfoZhcivgXSUR5MyUKBl
X-Google-Smtp-Source: ADFU+vuI40k+4u0NkHaLII9DYy+ZDo82clHxyYQIt2GhVNbJg7Jgw3umyIa9SOrrENqA+SOscRBcGA==
X-Received: by 2002:a63:3111:: with SMTP id x17mr11356596pgx.422.1583657048317; 
 Sun, 08 Mar 2020 00:44:08 -0800 (PST)
Received: from localhost.localdomain ([1.38.148.20])
 by smtp.gmail.com with ESMTPSA id b3sm14587244pjo.30.2020.03.08.00.44.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Mar 2020 00:44:07 -0800 (PST)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun,  8 Mar 2020 14:13:44 +0530
Message-Id: <20200308084356.14506-2-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200308084356.14506-1-jaskaransingh7654321@gmail.com>
References: <20200308084356.14506-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 08 Mar 2020 09:44:14 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 08 Mar 2020 09:44:10 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 01/13] parsing_cocci: Align C AST and SmPL AST for
	enum
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

The C AST and SmPL AST differs with respect to the enum type.

For an enumerator, the C AST is as follows:
	Enum -> list of (name, (info, expression))

For the same, the SmPL AST is as follows:
	EnumDef -> list of expression

While the SmPL parser does make sure that enumerators are
parsed as per C rules, the OCaml types for an enumerator themselves
mismatch, due to their organization. This causes bugs/mismatches for
cases where enums are in disjunctions.

Make the enumerator type of the SmPL AST closer to that of
the C AST.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_cocci/ast0_cocci.ml  | 11 ++++++++++-
 parsing_cocci/ast0_cocci.mli | 10 +++++++++-
 parsing_cocci/ast_cocci.ml   |  9 ++++++++-
 parsing_cocci/ast_cocci.mli  | 10 +++++++++-
 4 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/parsing_cocci/ast0_cocci.ml b/parsing_cocci/ast0_cocci.ml
index 77dc46f0..b3d8b137 100644
--- a/parsing_cocci/ast0_cocci.ml
+++ b/parsing_cocci/ast0_cocci.ml
@@ -211,7 +211,7 @@ and base_typeC =
 	               string mcode (* ) *) (* IBM C only *)
   | EnumName        of string mcode (*enum*) * ident option (* name *)
   | EnumDef  of typeC (* either StructUnionName or metavar *) *
-	string mcode (* { *) * expression dots * string mcode (* } *)
+	string mcode (* { *) * enum_decl dots * string mcode (* } *)
   | StructUnionName of Ast.structUnion mcode * ident option (* name *)
   | StructUnionDef  of typeC (* either StructUnionName or metavar *) *
 	string mcode (* { *) * field dots * string mcode (* } *)
@@ -288,6 +288,15 @@ and bitfield = string mcode (* : *) * expression
 
 and field = base_field wrap
 
+and base_enum_decl =
+    Enum of ident * (string mcode (* = *) * expression) option
+  | EnumComma of string mcode (* , *)
+  | EnumDots of string mcode (* ... *) * (string mcode * string mcode *
+                enum_decl) option (* whencode *)
+
+and enum_decl = base_enum_decl wrap
+
+
 (* --------------------------------------------------------------------- *)
 (* Initializers *)
 
diff --git a/parsing_cocci/ast0_cocci.mli b/parsing_cocci/ast0_cocci.mli
index 274c6bc2..732a1345 100644
--- a/parsing_cocci/ast0_cocci.mli
+++ b/parsing_cocci/ast0_cocci.mli
@@ -202,7 +202,7 @@ and base_typeC =
 	               string mcode (* ) *) (* IBM C only *)
   | EnumName        of string mcode (*enum*) * ident option (* name *)
   | EnumDef  of typeC (* either StructUnionName or metavar *) *
-	string mcode (* { *) * expression dots * string mcode (* } *)
+	string mcode (* { *) * enum_decl dots * string mcode (* } *)
   | StructUnionName of Ast_cocci.structUnion mcode * ident option (* name *)
   | StructUnionDef  of typeC (* either StructUnionName or metavar *) *
 	string mcode (* { *) * field dots * string mcode (* } *)
@@ -276,6 +276,14 @@ and bitfield = string mcode (* : *) * expression
 
 and field = base_field wrap
 
+and base_enum_decl =
+    Enum of ident * (string mcode (* = *) * expression) option
+  | EnumComma of string mcode (* , *)
+  | EnumDots of string mcode (* ... *) * (string mcode * string mcode *
+                enum_decl) option (* whencode *)
+
+and enum_decl = base_enum_decl wrap
+
 (* --------------------------------------------------------------------- *)
 (* Initializers *)
 
diff --git a/parsing_cocci/ast_cocci.ml b/parsing_cocci/ast_cocci.ml
index ba6ec29e..8fa64dcc 100644
--- a/parsing_cocci/ast_cocci.ml
+++ b/parsing_cocci/ast_cocci.ml
@@ -351,7 +351,7 @@ and base_typeC =
 	               string mcode (* ) *) (* IBM C only *)
   | EnumName        of string mcode (*enum*) * ident option (* name *)
   | EnumDef  of fullType (* either EnumName or metavar *) *
-	string mcode (* { *) * expression dots * string mcode (* } *)
+	string mcode (* { *) * enum_decl dots * string mcode (* } *)
   | StructUnionName of structUnion mcode * ident option (* name *)
   | StructUnionDef  of fullType (* either StructUnionName or metavar *) *
 	string mcode (* { *) * annotated_field dots * string mcode (* } *)
@@ -443,6 +443,13 @@ and base_annotated_field =
 
 and annotated_field = base_annotated_field wrap
 
+and base_enum_decl =
+    Enum of ident * (string mcode (* = *) * expression) option
+  | EnumComma of string mcode (* , *)
+  | EnumDots of string mcode (* ... *) * enum_decl option (* whencode *)
+
+and enum_decl = base_enum_decl wrap
+
 (* --------------------------------------------------------------------- *)
 (* Initializers *)
 
diff --git a/parsing_cocci/ast_cocci.mli b/parsing_cocci/ast_cocci.mli
index 5f21664b..e921f917 100644
--- a/parsing_cocci/ast_cocci.mli
+++ b/parsing_cocci/ast_cocci.mli
@@ -333,7 +333,7 @@ and base_typeC =
 	               string mcode (* ) *) (* IBM C only *)
   | EnumName        of string mcode (*enum*) * ident option (* name *)
   | EnumDef  of fullType (* either EnumName or metavar *) *
-	string mcode (* { *) * expression dots * string mcode (* } *)
+	string mcode (* { *) * enum_decl dots * string mcode (* } *)
   | StructUnionName of structUnion mcode * ident option (* name *)
   | StructUnionDef  of fullType (* either StructUnionName or metavar *) *
 	string mcode (* { *) * annotated_field dots * string mcode (* } *)
@@ -424,6 +424,14 @@ and base_annotated_field =
 
 and annotated_field = base_annotated_field wrap
 
+and base_enum_decl =
+    Enum of ident * (string mcode (* = *) * expression) option
+  | EnumComma of string mcode (* , *)
+  | EnumDots of string mcode (* ... *) * enum_decl option (* whencode *)
+
+and enum_decl = base_enum_decl wrap
+
+
 (* --------------------------------------------------------------------- *)
 (* Initializers *)
 
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
