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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E9EC10F28
	for <cocci@archiver.kernel.org>; Sun,  8 Mar 2020 08:45:09 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A54D6206D7
	for <cocci@archiver.kernel.org>; Sun,  8 Mar 2020 08:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFKI6UVD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A54D6206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0288itwF005613;
	Sun, 8 Mar 2020 09:44:55 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 22D857800;
	Sun,  8 Mar 2020 09:44:55 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3665D7742
 for <cocci@systeme.lip6.fr>; Sun,  8 Mar 2020 09:44:53 +0100 (CET)
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:542])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0288ipWD005752
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 8 Mar 2020 09:44:52 +0100 (CET)
Received: by mail-pg1-x542.google.com with SMTP id t24so3294624pgj.7
 for <cocci@systeme.lip6.fr>; Sun, 08 Mar 2020 00:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9JAdyz2iBJMEmw31vFq2hVb+1Gs7bt49sVWPqgDF7jo=;
 b=aFKI6UVDaebs4uc00T2kHOJKk52T3qRsP3Gwu70aUiHEjuDyh9P+pxZR+aG/ATHxKm
 74xz6eoziCYnLFdcDxpZLBXb8ARP+B2QyNhRwFc3HIG1YDRsQKQX1AcehRsoGiZ8c5x0
 DaVopmNtsxyG69kQluqv3KfWAnFfSzJ1F/AeSVRZrqJzpchC5jgDuoxGaOZeyhOuWBXW
 kgonYqXyoJ1LOLcps2BMRgt0FD7jREQyL1Vxv+gZsxhUiNR31Bx20gmhWGLqWyO2/E85
 qDqOXH2m0TxgL/FIQhIIMSg1zLObuzCjXcmgOfdD81HKg8rNTz+dALYNF2NwrnGUwZK5
 oFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9JAdyz2iBJMEmw31vFq2hVb+1Gs7bt49sVWPqgDF7jo=;
 b=FWg4rnaeKsAuVJNBZqQbWdika1rfWMR0Gcvq7I4z9K5Jjm+5SroDC9w3eirTBT6BlL
 x03CyX+d486M4/oZ+iWmuPeClrhdis6rWNSX3k/LJt6l/exaGrYILCIvP09D48F2IvkT
 Q0eW6EZQiA47nIY58MrzS0CEd348VVgW3RoKnSTuqq+OH66rHmA2RSC3iVvgRchBj5fE
 UkgBxdqsd1jXYJiKMrP7WlPsPLIAWZZv0xspcoXjzDS9SYkLrihTsPENFXhBflzmDzG1
 3qFkW+YgE/V2DegV8vSMhyxWj1RArEFvgzhJ5yMr/G17ezTAfCWSwv/D9By8n+pmQGBe
 gKxA==
X-Gm-Message-State: ANhLgQ32sOOMmsTANctq1V6mIJgQ6Hb2tH/gyNpVba4iUjN8K8/mcXBC
 gZ+vIWO0SK0ZjVm4i3XDoCwhIDnd
X-Google-Smtp-Source: ADFU+vvTP/Sbamu6xSoHJndOb7H5rnt7WWsronG3SqCdb+hve+XroUgvYdE4Blp67RrvmTnpaHHEDA==
X-Received: by 2002:a63:450b:: with SMTP id s11mr11015506pga.45.1583657090377; 
 Sun, 08 Mar 2020 00:44:50 -0800 (PST)
Received: from localhost.localdomain ([1.38.148.20])
 by smtp.gmail.com with ESMTPSA id b3sm14587244pjo.30.2020.03.08.00.44.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Mar 2020 00:44:50 -0800 (PST)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Sun,  8 Mar 2020 14:13:54 +0530
Message-Id: <20200308084356.14506-12-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200308084356.14506-1-jaskaransingh7654321@gmail.com>
References: <20200308084356.14506-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 08 Mar 2020 09:44:55 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 08 Mar 2020 09:44:52 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 11/13] cocci: pretty print EnumDef as per enum_decl
	type
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

The SmPL AST has a separate enum_decl for a enumerator. Make
corresponding changes in Unparse_cocci and Pretty_print_cocci
to correctly pretty print enumerators.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 parsing_c/unparse_cocci.ml          | 27 ++++++++++++++++++++++++---
 parsing_cocci/pretty_print_cocci.ml | 18 +++++++++++++++++-
 2 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/parsing_c/unparse_cocci.ml b/parsing_c/unparse_cocci.ml
index 30e755e9..8dff2b81 100644
--- a/parsing_c/unparse_cocci.ml
+++ b/parsing_c/unparse_cocci.ml
@@ -738,7 +738,7 @@ and typeC ty =
   | Ast.EnumDef(ty,lb,ids,rb) ->
       fullType ty; ft_space ty;
       mcode print_string lb;
-      dots force_newline expression ids;
+      dots force_newline enum_decl ids;
       mcode print_string rb
   | Ast.StructUnionName(kind,name) ->
       mcode structUnion kind; print_option_prespace ident name
@@ -952,6 +952,24 @@ and annotated_field d =
   | Ast.OptField(decl) -> raise CantBeInPlus
   | Ast.Fdots(_,_) -> raise CantBeInPlus
 
+and enum_decl d =
+  match Ast.unwrap d with
+    Ast.Enum(name,enum_val) ->
+      ident name;
+      pr_space();
+      print_option
+        (function (eq,eval) ->
+          mcode print_string eq; pr_space(); expression eval) enum_val
+  | Ast.EnumComma(cm) ->
+      mcode (print_string_with_hint (SpaceOrNewline (ref " "))) cm
+  | Ast.EnumDots(dots,whencode) when generating ->
+      mcode print_string dots;
+      print_option
+      (function w ->
+        print_text "   when != ";
+        enum_decl w) whencode
+  | Ast.EnumDots(dots,whencode) -> raise CantBeInPlus
+
 (* --------------------------------------------------------------------- *)
 (* Initialiser *)
 
@@ -1420,6 +1438,7 @@ let pp_any = function
   | Ast.InitTag(x) -> initialiser false x; false
   | Ast.DeclarationTag(x) -> declaration x; false
   | Ast.FieldTag(x) -> field x; false
+  | Ast.EnumDeclTag(x) -> enum_decl x; false
 
   | Ast.StorageTag(x) -> storage x unknown unknown; false
   | Ast.IncFileTag(x) -> inc_file x unknown unknown; false
@@ -1473,6 +1492,7 @@ let pp_any = function
   | Ast.StmtDotsTag(x) -> dots force_newline (statement "") x; false
   | Ast.AnnDeclDotsTag(x) -> dots force_newline annotated_decl x; false
   | Ast.AnnFieldDotsTag(x) -> dots force_newline annotated_field x; false
+  | Ast.EnumDeclDotsTag(x) -> dots force_newline enum_decl x; false
   | Ast.DefParDotsTag(x) -> dots (fun _ -> ()) print_define_param x; false
 
   | Ast.TypeCTag(x) -> typeC x; false
@@ -1505,7 +1525,7 @@ in
 	      force_newline(); force_newline()
 	  | (Ast.Directive _::_)
 	  | (Ast.Rule_elemTag _::_) | (Ast.StatementTag _::_)
-	  | (Ast.FieldTag _::_) | (Ast.InitTag _::_)
+	  | (Ast.FieldTag _::_) | (Ast.EnumDeclTag _::_) | (Ast.InitTag _::_)
 	  | (Ast.DeclarationTag _::_) | (Ast.Token ("}",_)::_) -> prnl hd
 	  | _ -> () in
       let newline_after _ =
@@ -1516,7 +1536,8 @@ in
 	      (if isfn s then force_newline());
 	      force_newline()
 	  | (Ast.Directive _::_) | (Ast.StmtDotsTag _::_)
-	  | (Ast.Rule_elemTag _::_) | (Ast.FieldTag _::_) | (Ast.InitTag _::_)
+	  | (Ast.Rule_elemTag _::_) | (Ast.FieldTag _::_)
+	  | (Ast.EnumDeclTag _::_)| (Ast.InitTag _::_)
 	  | (Ast.DeclarationTag _::_) | (Ast.Token ("{",_)::_) ->
 	      force_newline()
 	  | _ -> () in
diff --git a/parsing_cocci/pretty_print_cocci.ml b/parsing_cocci/pretty_print_cocci.ml
index 6338e464..f6b2894f 100644
--- a/parsing_cocci/pretty_print_cocci.ml
+++ b/parsing_cocci/pretty_print_cocci.ml
@@ -439,7 +439,7 @@ and typeC ty =
       print_option (function x -> ident x; print_string " ") name
   | Ast.EnumDef(ty,lb,ids,rb) ->
       fullType ty; mcode print_string lb;
-      dots force_newline expression ids;
+      dots force_newline enum_decl ids;
       mcode print_string rb
   | Ast.StructUnionName(kind,name) ->
       mcode structUnion kind;
@@ -585,6 +585,20 @@ and annotated_field arity d =
   | Ast.ConjField(decls) -> print_disj_list (annotated_field arity) decls "&"
   | Ast.OptField(decl) -> print_string "?"; annotated_field arity decl
 
+and enum_decl d =
+  match Ast.unwrap d with
+    Ast.Enum(name,enum_val) ->
+      ident name;
+      (match enum_val with
+        None -> ()
+      | Some(eq,eval) ->
+          mcode print_string eq;
+          expression eval)
+  | Ast.EnumComma(cm) -> mcode print_string cm
+  | Ast.EnumDots(dots,Some whencode) ->
+      mcode print_string dots; print_string "   when != "; enum_decl whencode
+  | Ast.EnumDots(dots,None) -> mcode print_string dots
+
 (* --------------------------------------------------------------------- *)
 (* Initialiser *)
 
@@ -1090,6 +1104,7 @@ let _ =
     | Ast.InitTag(x) -> initialiser x
     | Ast.DeclarationTag(x) -> declaration x
     | Ast.FieldTag(x) -> field x
+    | Ast.EnumDeclTag(x) -> enum_decl x
     | Ast.StorageTag(x) -> storage x
     | Ast.IncFileTag(x) -> inc_file x
     | Ast.Rule_elemTag(x) -> rule_elem "" x
@@ -1110,6 +1125,7 @@ let _ =
     | Ast.StmtDotsTag(x) -> dots (function _ -> ()) (statement "") x
     | Ast.AnnDeclDotsTag(x) -> dots (function _ -> ()) (annotated_decl "") x
     | Ast.AnnFieldDotsTag(x) -> dots (function _ -> ()) (annotated_field "") x
+    | Ast.EnumDeclDotsTag(x) -> dots (function _ -> ()) enum_decl x
     | Ast.DefParDotsTag(x) -> dots (function _ -> ()) print_define_param x
     | Ast.TypeCTag(x) -> typeC x
     | Ast.ParamTag(x) -> parameterTypeDef x
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
