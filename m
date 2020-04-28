Return-Path: <SRS0=bJsz=6M=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185D3C83000
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 17:03:12 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A70B20730
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 17:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBrjOM55"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A70B20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03SH2tEW007213;
	Tue, 28 Apr 2020 19:02:55 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4D717783A;
	Tue, 28 Apr 2020 19:02:51 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C5A5C7831
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 19:02:49 +0200 (CEST)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:102c])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03SH2l2M007164
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 19:02:48 +0200 (CEST)
Received: by mail-pj1-x102c.google.com with SMTP id a7so1424606pju.2
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 10:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/734Hyb4Pnz8r6Gb+EbHmvdi/i/Zy9SzurQZuQ8OjhU=;
 b=VBrjOM55BxSkUrkHtep1bGGDE7mCr1KQ5Jf4cW7Y1/taKJT3ZtEsQbsD8OvJmM226t
 yz743Ksg0dVrmbwcjPYLCdzCl4P4n5EccZcM6gYXuriSXbK0mfPpv0+Xph4jt3mUPaVU
 Pb3pFz+PEi39Q/a9pNmO0qn+OlmdWW+K9k6PGD5RQ8ooj6LxfPd0QUC4UbCuM1Sp5yLl
 gt0fCjLUXbq6Yv2K/f5eVZ5nIP9icYBB6JX9vnHam+myZ8FwakaVR5RN1vL/nXHP4gyF
 Rug+8JQkcnzB6IdcQA2DIlTnwxSLIp9WBpWl9HgRHTqn2Lc9ORn6eSiwAJqgd58dW9Qq
 ObLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/734Hyb4Pnz8r6Gb+EbHmvdi/i/Zy9SzurQZuQ8OjhU=;
 b=Y0/LZzE/rq8/Y6khuNyr113YlPfJ3+qhXaDEoT7qw/sSc8GUjQqkkdHDnelOZ5Cyv6
 t587UP+eZAhRQq29XomzIAPDJ1BpCEt+GhnPVec7C46JolD8REWdkBOPfFAeOawrZ7xN
 P0fFEYcq0bL3TlXSgd8N68lA8F0rleXF15YzGxKnVjEXwDlDNyuvzSXLjnVl6IvwilKk
 jWkQK4JT0OAj4uUz2qinTkyL29Ku0gh7mbfbH0FyeJpBLCdNnfvg6/L60ldMBOmPK5XH
 CxpXP9qN+2NHxlD3WHGxcLb43dEIz5IrZk//k1jCMA/2z0NnD8+H4hYg+nybfCCuAbTb
 vBaw==
X-Gm-Message-State: AGi0PuYfj5OEwrs/oWKsFCM8tOo3zFHwT05dkAVyWpyMon1Q610Ihh/5
 7+lHRJVFao1KQtnPnMZt04hZ8SuKLYg=
X-Google-Smtp-Source: APiQypKLAzIe6zuJERFQhepZyJipbylnfQ6zznE3o2ZTNYPWgLRNtWV//jHq2mh+JTBBCcfo1h5JOw==
X-Received: by 2002:a17:90a:20ea:: with SMTP id
 f97mr6332562pjg.157.1588093366845; 
 Tue, 28 Apr 2020 10:02:46 -0700 (PDT)
Received: from localhost.localdomain ([1.38.220.163])
 by smtp.gmail.com with ESMTPSA id u15sm2505097pjm.47.2020.04.28.10.02.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 10:02:46 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Tue, 28 Apr 2020 22:31:57 +0530
Message-Id: <20200428170228.7002-2-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200428170228.7002-1-jaskaransingh7654321@gmail.com>
References: <20200428170228.7002-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 28 Apr 2020 19:02:55 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 28 Apr 2020 19:02:48 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH 01/32] parsing_c: parser: Pass attribute list from
	type_name
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
 parsing_c/parser_c.mly | 16 ++++++++--------
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/ocaml/coccilib.mli b/ocaml/coccilib.mli
index 0e807c9a..a305d616 100644
--- a/ocaml/coccilib.mli
+++ b/ocaml/coccilib.mli
@@ -791,7 +791,8 @@ module Parser_c :
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
index 0d3a189a..5f8d5e2d 100644
--- a/parsing_c/parse_c.ml
+++ b/parsing_c/parse_c.ml
@@ -370,7 +370,9 @@ let parse_gen ~cpp ~tos parsefunc s =
   result
 
 (* Please DO NOT remove this code, even though most of it is not used *)
-let type_of_string       = parse_gen ~cpp:false ~tos:true Parser_c.type_name
+let type_of_string s     =
+  let typname = parse_gen ~cpp:false ~tos:true Parser_c.type_name s in
+  Common.snd typname
 let statement_of_string  = parse_gen ~cpp:false ~tos:false Parser_c.statement
 let expression_of_string = parse_gen ~cpp:false ~tos:false Parser_c.expr
 let cpp_expression_of_string = parse_gen ~cpp:true ~tos:false Parser_c.expr
diff --git a/parsing_c/parser_c.mly b/parsing_c/parser_c.mly
index aedde179..0abcc9b0 100644
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
@@ -831,7 +831,7 @@ unary_expr:
  | TDec unary_expr                 { mk_e(Infix ($2, Dec))    [$1] }
  | unary_op cast_expr              { mk_e(Unary ($2, fst $1)) [snd $1] }
  | Tsizeof unary_expr              { mk_e(SizeOfExpr ($2))    [$1] }
- | Tsizeof topar2 type_name tcpar2 { mk_e(SizeOfType ($3))    [$1;$2;$4] }
+ | Tsizeof topar2 type_name tcpar2 { mk_e(SizeOfType (snd $3))    [$1;$2;$4] }
  | Tnew new_argument               { mk_e(New (None, $2))     [$1] }
  | Tnew TOPar argument_list_ne TCPar new_argument { mk_e(New (Some $3, $5))             [$1; $2; $4] }
  | Tdelete cast_expr               { mk_e(Delete(false, $2))  [$1] }
@@ -897,9 +897,9 @@ postfix_expr:
 
  /*(* gccext: also called compound literals *)*/
  | topar2 type_name tcpar2 TOBrace TCBrace
-     { mk_e(Constructor ($2, (InitList [], [$4;$5]))) [$1;$3] }
+     { mk_e(Constructor (snd $2, (InitList [], [$4;$5]))) [$1;$3] }
  | topar2 type_name tcpar2 TOBrace initialize_list gcc_comma_opt_struct TCBrace
-     { mk_e(Constructor ($2, (InitList (List.rev $5),[$4;$7] @ $6))) [$1;$3] }
+     { mk_e(Constructor (snd $2, (InitList (List.rev $5),[$4;$7] @ $6))) [$1;$3] }
 
 
 primary_expr:
@@ -1298,7 +1298,7 @@ type_spec2:
        Right3 (TypeName (name, Ast_c.noTypedefDef())),[] }
 
  | Ttypeof TOPar assign_expr TCPar { Right3 (TypeOfExpr ($3)), [$1;$2;$4] }
- | Ttypeof TOPar type_name   TCPar { Right3 (TypeOfType ($3)), [$1;$2;$4] }
+ | Ttypeof TOPar type_name   TCPar { Right3 (TypeOfType (snd $3)), [$1;$2;$4] }
 
 /*(*----------------------------*)*/
 /*(* workarounds *)*/
@@ -1531,12 +1531,12 @@ type_qualif_list:
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
