Return-Path: <SRS0=Yx51=7L=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE818C433E1
	for <cocci@archiver.kernel.org>; Fri, 29 May 2020 12:08:27 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27C31206F0
	for <cocci@archiver.kernel.org>; Fri, 29 May 2020 12:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqBsndj9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27C31206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04TC8Ncw007856;
	Fri, 29 May 2020 14:08:23 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 44A55782B;
	Fri, 29 May 2020 14:08:23 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id AF57A782B
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 14:08:21 +0200 (CEST)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:42e])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04TC8GRo012230
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 14:08:17 +0200 (CEST)
Received: by mail-pf1-x42e.google.com with SMTP id z26so1277647pfk.12
 for <cocci@systeme.lip6.fr>; Fri, 29 May 2020 05:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=T2r37R8HkRqAVm89Ne2iWyVHAZ9yMqvI7QL3wEjkD+o=;
 b=gqBsndj9y9bMEllUJ8mmnD8JSvDyhtY/Fam9kjsf0n25y0PrGjIl5RP4H68JrBa9MO
 D9U28zHXfusXAK9ZIszRb6DvJ1lXKo1u2Zt7veAkFfUBB9vGJxF/23J6SSq9YWRxvaO7
 mtwbwcSpYxJ5ABCCR+8clTyWlF1XX6l/Rd32SyNEuMFzmkFqqv2Wqb0lXUyQK4OmzgVQ
 zq/6s7RjYLdstUBRGBg544dwuqpI1jjLG6MRyisQ8xK6szemtKjP7uYJ1hWmhZclJeFs
 kwnSz4TTBfXUF5HTsbXRN8ldh+7qSOghsE1c2UjOwXXR4jZ2zo/yIhbuvEK/uJ44hRrr
 sf/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=T2r37R8HkRqAVm89Ne2iWyVHAZ9yMqvI7QL3wEjkD+o=;
 b=n6LE/7F4q2IKssRcZSlbS1vdB033PcAkCdaghEE+XEqp7geiKqBSZVM47ym+wRLViR
 C5hrXdhUm4c4y8V4TS691DqszfqYxU5J/D64tOjF1aBGxi5qxPw06BFSslr2+01ijkOo
 JDgO4jHfw4ujUaRchTmgO1x5guqCBtWSbdidXEeFjS6YvDPa1S9p38cMT9MtU4bZC7vC
 wMv2V3EGYJeKG8ckxiY3abY2Jxgmb2JGoyWTE/pFkDOgUcXLhmlCz2DiSIwSmEyHK0Cx
 PAC+BczFdAdCLXKC5+itF0RfX0QkTV092lb0dhptQwtTEf4pfkf7YzriPILyH51JBhO/
 hiig==
X-Gm-Message-State: AOAM532WkdpVw2qpWTYUN5b9ebfpeCZ+aZqfAHneTkFOTH1VMiTULL7B
 kcClrPNy6j2ZgajujA4spgb4zsd1
X-Google-Smtp-Source: ABdhPJz3vpY8+JYbLbj0xbXaTI0xw2YQlznyGblAAXHPe+Bxlat/yjAJAzJkqElwKcwhWG35u83J1Q==
X-Received: by 2002:aa7:84da:: with SMTP id x26mr8396238pfn.24.1590754095346; 
 Fri, 29 May 2020 05:08:15 -0700 (PDT)
Received: from localhost.localdomain ([2402:3a80:694:e576:19d1:a79b:707d:59f2])
 by smtp.gmail.com with ESMTPSA id dw13sm7975161pjb.40.2020.05.29.05.08.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2020 05:08:14 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 29 May 2020 17:36:31 +0530
Message-Id: <20200529120703.31145-2-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200529120703.31145-1-jaskaransingh7654321@gmail.com>
References: <20200529120703.31145-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 29 May 2020 14:08:23 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 29 May 2020 14:08:17 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 01/32] parsing_c: parser: Pass attribute list
	from type_name
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

To add Cast attributes to the C AST, pass attributes from the type_name
rule of the C parser.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 ocaml/coccilib.mli     |  3 ++-
 parsing_c/parse_c.ml   |  4 +++-
 parsing_c/parser_c.mly | 24 ++++++++++++++++--------
 3 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/ocaml/coccilib.mli b/ocaml/coccilib.mli
index 747cc9ce..30cb1a08 100644
--- a/ocaml/coccilib.mli
+++ b/ocaml/coccilib.mli
@@ -792,7 +792,8 @@ module Parser_c :
       (Lexing.lexbuf -> token) -> Lexing.lexbuf -> Ast_c.statement
     val expr : (Lexing.lexbuf -> token) -> Lexing.lexbuf -> Ast_c.expression
     val type_name :
-      (Lexing.lexbuf -> token) -> Lexing.lexbuf -> Ast_c.fullType
+      (Lexing.lexbuf -> token) -> Lexing.lexbuf ->
+      Ast_c.attribute list * Ast_c.fullType
   end
 module Lexer_c :
   sig
diff --git a/parsing_c/parse_c.ml b/parsing_c/parse_c.ml
index ef4482f5..5574cb11 100644
--- a/parsing_c/parse_c.ml
+++ b/parsing_c/parse_c.ml
@@ -374,7 +374,9 @@ let parse_gen ~cpp ~tos parsefunc infos s =
   result
 
 (* Please DO NOT remove this code, even though most of it is not used *)
-let type_of_string       = parse_gen ~cpp:false ~tos:true Parser_c.type_name None
+let type_of_string s     =
+  let typname = parse_gen ~cpp:false ~tos:true Parser_c.type_name None s in
+  Common.snd typname
 let statement_of_string  = parse_gen ~cpp:false ~tos:false Parser_c.statement None
 let expression_of_string = parse_gen ~cpp:false ~tos:false Parser_c.expr None
 let cpp_expression_of_string = parse_gen ~cpp:true ~tos:false Parser_c.expr
diff --git a/parsing_c/parser_c.mly b/parsing_c/parser_c.mly
index b7e74506..1630ed77 100644
--- a/parsing_c/parser_c.mly
+++ b/parsing_c/parser_c.mly
@@ -665,7 +665,7 @@ let postfakeInfo pii  =
 
 %type <Ast_c.statement> statement
 %type <Ast_c.expression> expr
-%type <Ast_c.fullType> type_name
+%type <Ast_c.attribute list * Ast_c.fullType> type_name
 
 %%
 /*(*************************************************************************)*/
@@ -818,7 +818,7 @@ arith_expr:
 
 cast_expr:
  | unary_expr                        { $1 }
- | topar2 type_name tcpar2 cast_expr { mk_e(Cast ($2, $4)) [$1;$3] }
+ | topar2 type_name tcpar2 cast_expr { mk_e(Cast (snd $2, $4)) [$1;$3] }
 /*
 It could be useful to have the following, but there is no place for the
 attribute in the AST.
@@ -831,7 +831,11 @@ unary_expr:
  | TDec unary_expr                 { mk_e(Infix ($2, Dec))    [$1] }
  | unary_op cast_expr              { mk_e(Unary ($2, fst $1)) [snd $1] }
  | Tsizeof unary_expr              { mk_e(SizeOfExpr ($2))    [$1] }
- | Tsizeof topar2 type_name tcpar2 { mk_e(SizeOfType ($3))    [$1;$2;$4] }
+ | Tsizeof topar2 type_name tcpar2
+     { let ret = mk_e(SizeOfType (snd $3)) [$1;$2;$4] in
+       match (fst $3) with (* warn about dropped attributes *)
+         [] -> ret
+       | _ -> warning "attributes found in sizeof(...), dropping" ret }
  | Tnew new_argument               { mk_e(New (None, $2))     [$1] }
  | Tnew TOPar argument_list_ne TCPar new_argument { mk_e(New (Some $3, $5))             [$1; $2; $4] }
  | Tdelete cast_expr               { mk_e(Delete(false, $2))  [$1] }
@@ -897,9 +901,9 @@ postfix_expr:
 
  /*(* gccext: also called compound literals *)*/
  | topar2 type_name tcpar2 TOBrace TCBrace
-     { mk_e(Constructor ($2, (InitList [], [$4;$5]))) [$1;$3] }
+     { mk_e(Constructor (snd $2, (InitList [], [$4;$5]))) [$1;$3] }
  | topar2 type_name tcpar2 TOBrace initialize_list gcc_comma_opt_struct TCBrace
-     { mk_e(Constructor ($2, (InitList (List.rev $5),[$4;$7] @ $6))) [$1;$3] }
+     { mk_e(Constructor (snd $2, (InitList (List.rev $5),[$4;$7] @ $6))) [$1;$3] }
 
 
 primary_expr:
@@ -1298,7 +1302,11 @@ type_spec2:
        Right3 (TypeName (name, Ast_c.noTypedefDef())),[] }
 
  | Ttypeof TOPar assign_expr TCPar { Right3 (TypeOfExpr ($3)), [$1;$2;$4] }
- | Ttypeof TOPar type_name   TCPar { Right3 (TypeOfType ($3)), [$1;$2;$4] }
+ | Ttypeof TOPar type_name   TCPar
+     { let ret = Right3 (TypeOfType (snd $3)), [$1;$2;$4] in
+       match (fst $3) with (* warn about dropped attributes *)
+         [] -> ret
+       | _ -> warning "attributes found in typeof(...), dropping" ret }
 
 /*(*----------------------------*)*/
 /*(* workarounds *)*/
@@ -1532,12 +1540,12 @@ type_qualif_list:
 type_name:
  | spec_qualif_list
      { let (attrs, ds) = $1 in
-       let (returnType, _) = fixDeclSpecForDecl ds in returnType }
+       let (returnType, _) = fixDeclSpecForDecl ds in (attrs, returnType) }
  | spec_qualif_list abstract_declaratort
      { let (attrs1, ds) = $1 in
        let (attrs2, fn) = $2 in
        let (returnType, _) = fixDeclSpecForDecl ds in
-       fn returnType }
+       (attrs1@attrs2, fn returnType) }
 
 
 
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
