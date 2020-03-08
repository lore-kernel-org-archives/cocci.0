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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BFCC1975A
	for <cocci@archiver.kernel.org>; Sun,  8 Mar 2020 08:44:40 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4528520848
	for <cocci@archiver.kernel.org>; Sun,  8 Mar 2020 08:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U16KbaBQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4528520848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0288iJXQ021080;
	Sun, 8 Mar 2020 09:44:19 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 56E6F781C;
	Sun,  8 Mar 2020 09:44:16 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 980BE77F4
 for <cocci@systeme.lip6.fr>; Sun,  8 Mar 2020 09:44:14 +0100 (CET)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:443])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0288iBxX009748
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 8 Mar 2020 09:44:12 +0100 (CET)
Received: by mail-pf1-x443.google.com with SMTP id g21so3413562pfb.5
 for <cocci@systeme.lip6.fr>; Sun, 08 Mar 2020 00:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=545xpgF/TgsFYj2C7WNNA12U+rN0HF1e2CWbfKsBxO4=;
 b=U16KbaBQMrYLdZfV1XsWmiTFXgkIyNGTAxqJj2Y4jSwQTXMf7THWgBRuxx/ilrT3ID
 axN4mDAdj1R6wlcX56WCXQfl1WrOw320o+hzwBvOdOZrD/Yvyy5y275z/F2oA9w70Zgb
 no2XcQdWO5MCnuwWAYbZEys0eLDsA7Z+PyRiSWubOZYrzFPDL8jNNASqCdbRAA6yVHca
 c6xc7/1aG+dCHNmqG3MR1UCdxqg6ECLE1nsxEFNZkZBMnGjNVV/ulYGxHqNUnt7MDOdL
 M5W9F3Bt1thfZvJibi9RKARNwaeb9KzVSsh2gJlceItS8T6fUnew6rMy8Wp4df2QpLYf
 g3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=545xpgF/TgsFYj2C7WNNA12U+rN0HF1e2CWbfKsBxO4=;
 b=AM5/KgVFOMWziHFR6YHnFL7SqHvQX4p7VJ11Gc2ncIrxYSwJ+VbO08G2BQ8heGBjdl
 YcPUG3H6VHtzAVR4BI9vYDLHyDjf2/Xj3+vBdFw6fIA6kOx9S6hIHqAS/jkuRXqsBzcc
 w14Fszs7/ijQ5JQvDlcMEFne0paE7qNXrAIJHV0UB3Bmd4cYYdPFHmbyzlC9xXqoYzpf
 HWBAaW5rGKeR7B9yM+CgqbRVhQsRIryXmobWpfMI25/NTxoCx2gcOsZYoAfMVgDJiBEw
 mOpd/tiSIAE9kwGC48nCeeO/+Hr7JSYJ49TrpI28bbfubkOqsWrwjhOUfFF3X87AZZhg
 T+kQ==
X-Gm-Message-State: ANhLgQ1SPL3MG9KZSi3ABjYA4SUTL3lRM+PZ6NeuPrDfMt7pOXXzwnWA
 ohcoFaj1gOUMGYV/1jxWcmUrFbNH
X-Google-Smtp-Source: ADFU+vtIba+N2PlB/eSjr8m8G44DahIG5XiCgdZsMvmT1LMkGPx6cQ0gnNKi4XYXqLSH2bayFS8Qxw==
X-Received: by 2002:aa7:8426:: with SMTP id q6mr11570619pfn.221.1583657050910; 
 Sun, 08 Mar 2020 00:44:10 -0800 (PST)
Received: from localhost.localdomain ([1.38.148.20])
 by smtp.gmail.com with ESMTPSA id b3sm14587244pjo.30.2020.03.08.00.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Mar 2020 00:44:10 -0800 (PST)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun,  8 Mar 2020 14:13:45 +0530
Message-Id: <20200308084356.14506-3-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200308084356.14506-1-jaskaransingh7654321@gmail.com>
References: <20200308084356.14506-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 08 Mar 2020 09:44:19 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 08 Mar 2020 09:44:13 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 02/13] ocaml: coccilib: Reflect changes in SmPL AST
	for EnumDef
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

The EnumDef constructor is changed in the SmPL AST. Reflect
these changes in coccilib.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 ocaml/coccilib.mli | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/ocaml/coccilib.mli b/ocaml/coccilib.mli
index 5a913099..9b00e130 100644
--- a/ocaml/coccilib.mli
+++ b/ocaml/coccilib.mli
@@ -2713,7 +2713,7 @@ module Ast_cocci :
       | Decimal of string mcode * string mcode * expression *
           string mcode option * expression option * string mcode
       | EnumName of string mcode * ident option
-      | EnumDef of fullType * string mcode * expression dots * string mcode
+      | EnumDef of fullType * string mcode * enum_decl dots * string mcode
       | StructUnionName of structUnion mcode * ident option
       | StructUnionDef of fullType * string mcode * annotated_field dots *
           string mcode
@@ -2789,6 +2789,12 @@ module Ast_cocci :
       | ConjField of annotated_field list
       | OptField  of annotated_field
     and annotated_field = base_annotated_field wrap
+    and base_enum_decl =
+      Ast_cocci.base_enum_decl =
+        Enum of ident * (string mcode * expression) option
+      | EnumComma of string mcode
+      | EnumDots of string mcode * enum_decl option
+    and enum_decl = base_enum_decl wrap
     and base_initialiser =
       Ast_cocci.base_initialiser =
         MetaInit of meta_name mcode * constraints * keep_binding * inherited
@@ -3357,7 +3363,7 @@ module Ast0_cocci :
       | Decimal of string mcode * string mcode * expression *
           string mcode option * expression option * string mcode
       | EnumName of string mcode * ident option
-      | EnumDef of typeC * string mcode * expression dots * string mcode
+      | EnumDef of typeC * string mcode * enum_decl dots * string mcode
       | StructUnionName of Ast_cocci.structUnion mcode * ident option
       | StructUnionDef of typeC * string mcode * field dots * string mcode
       | TypeOfExpr of string mcode * string mcode * expression * string mcode
@@ -3408,6 +3414,13 @@ module Ast0_cocci :
       | OptField of field
     and bitfield = string mcode * expression
     and field = base_field wrap
+    and base_enum_decl =
+      Ast0_cocci.base_enum_decl =
+        Enum of ident * (string mcode * expression) option
+      | EnumComma of string mcode
+      | EnumDots of string mcode *
+                    (string mcode * string mcode * enum_decl) option
+    and enum_decl = base_enum_decl wrap
     and base_initialiser =
       Ast0_cocci.base_initialiser =
         MetaInit of Ast_cocci.meta_name mcode * constraints * pure
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
