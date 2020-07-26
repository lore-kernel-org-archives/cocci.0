Return-Path: <SRS0=Xu+Y=BF=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE16C433E5
	for <cocci@archiver.kernel.org>; Sun, 26 Jul 2020 12:52:41 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B61B52065F
	for <cocci@archiver.kernel.org>; Sun, 26 Jul 2020 12:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B61B52065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 06QCqI0D001437;
	Sun, 26 Jul 2020 14:52:19 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DF927782D;
	Sun, 26 Jul 2020 14:52:15 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E8B91782A
 for <cocci@systeme.lip6.fr>; Sun, 26 Jul 2020 14:52:13 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 06QCqCGU002812
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 26 Jul 2020 14:52:12 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: jaskaran_singh) with ESMTPSA id 113252964B7
From: Jaskaran Singh <jaskaran.singh@collabora.com>
To: cocci@systeme.lip6.fr
Date: Sun, 26 Jul 2020 18:21:00 +0530
Message-Id: <20200726125141.17787-3-jaskaran.singh@collabora.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200726125141.17787-1-jaskaran.singh@collabora.com>
References: <20200726125141.17787-1-jaskaran.singh@collabora.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 26 Jul 2020 14:52:19 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 26 Jul 2020 14:52:12 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] [PATCH 02/43] parsing_cocci: parser: Parse meta attributes
	and metaattr decls
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

Introduce changes to parse meta attributes and meta attribute
declarations in SmPL rules. Currently, meta attributes are only parsed
in context and minus code.

Signed-off-by: Jaskaran Singh <jaskaran.singh@collabora.com>
---
 parsing_cocci/data.ml                 |  1 +
 parsing_cocci/data.mli                |  1 +
 parsing_cocci/lexer_cocci.mll         | 12 ++++++++++++
 parsing_cocci/parse_aux.ml            |  4 ++++
 parsing_cocci/parser_cocci_menhir.mly | 25 +++++++++++++++++--------
 5 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/parsing_cocci/data.ml b/parsing_cocci/data.ml
index d604fd636..3c5e6c941 100644
--- a/parsing_cocci/data.ml
+++ b/parsing_cocci/data.ml
@@ -132,6 +132,7 @@ let add_binaryOp_meta:
 
 let add_type_name: (string -> unit) ref = ref uninitialized_add_meta
 let add_attribute: (string -> unit) ref = ref uninitialized_add_meta
+let add_attribute_meta: cstr_meta_type ref = ref uninitialized_add_meta
 let add_declarer_name: (string -> unit) ref = ref uninitialized_add_meta
 let add_iterator_name: (string -> unit) ref = ref uninitialized_add_meta
 
diff --git a/parsing_cocci/data.mli b/parsing_cocci/data.mli
index 9fa4e45a2..88f29baa7 100644
--- a/parsing_cocci/data.mli
+++ b/parsing_cocci/data.mli
@@ -112,6 +112,7 @@ val add_binaryOp_meta:
 
 val add_type_name: (string -> unit) ref
 val add_attribute: (string -> unit) ref
+val add_attribute_meta: cstr_meta_type ref
 val add_declarer_name: (string -> unit) ref
 val add_iterator_name: (string -> unit) ref
 val init_rule: (unit -> unit) ref
diff --git a/parsing_cocci/lexer_cocci.mll b/parsing_cocci/lexer_cocci.mll
index f05c6de02..9e85efe48 100644
--- a/parsing_cocci/lexer_cocci.mll
+++ b/parsing_cocci/lexer_cocci.mll
@@ -533,6 +533,18 @@ let init _ = (* per file, first .cocci then iso *)
 	    TDirective (Ast.Space name, clt)
 	| _ -> Tattr (name, clt) in
       Hashtbl.replace attr_names name fn);
+  Data.add_attribute_meta :=
+    (fun name cstr pure ->
+      let fn ((d,ln,_,_,_,_,_,_,_,_) as clt) =
+        if (match d with (Data.PLUS | Data.PLUSPLUS) -> true | _ -> false)
+        then
+          (* TODO support meta attributes in plus code *)
+	  failwith
+	    (Printf.sprintf
+             "%d: meta attributes currently only allowed in context/minus code"
+             ln);
+        TMetaAttribute(name,cstr,pure,clt) in
+      Hashtbl.replace metavariables (get_name name) fn);
   Data.add_declarer_name :=
     (function name ->
       let fn clt = TDeclarerId(name,clt) in
diff --git a/parsing_cocci/parse_aux.ml b/parsing_cocci/parse_aux.ml
index f2036bfc1..7ba7ce861 100644
--- a/parsing_cocci/parse_aux.ml
+++ b/parsing_cocci/parse_aux.ml
@@ -345,6 +345,10 @@ let check_meta_tyopt type_irrelevant v =
       (match meta_lookup rule name v with
 	Ast.MetaFragListDecl(_,_,_) -> ()
       | _ -> fail name)
+  | Ast.MetaAttributeDecl(Ast.NONE,(rule,name)) ->
+      (match meta_lookup rule name v with
+	Ast.MetaAttributeDecl(_,_) -> ()
+      | _ -> fail name)
   | Ast.MetaAnalysisDecl(analyzer,(rule,name)) ->
       (match meta_lookup rule name v with
 	Ast.MetaAnalysisDecl(analyzer1,_) ->
diff --git a/parsing_cocci/parser_cocci_menhir.mly b/parsing_cocci/parser_cocci_menhir.mly
index af9726e10..056ed0048 100644
--- a/parsing_cocci/parser_cocci_menhir.mly
+++ b/parsing_cocci/parser_cocci_menhir.mly
@@ -254,6 +254,7 @@ let inline_id aft = function
 %token <Parse_aux.expinfo>       TMetaErr
 %token <Parse_aux.cstrinfo>          TMetaParam TMetaStm
 %token <Parse_aux.cstrinfo>          TMetaInit TMetaDecl TMetaField TMeta
+%token <Parse_aux.cstrinfo>          TMetaAttribute
 %token <Parse_aux.list_info>     TMetaParamList TMetaExpList TMetaInitList
 %token <Parse_aux.list_info>     TMetaFieldList TMetaStmList TMetaDParamList
 %token <Parse_aux.typed_expinfo_bitfield> TMetaExp
@@ -764,6 +765,10 @@ delimited_list_len:
     { (fun arity name pure check_meta constraints ->
       let tok = check_meta(Ast_cocci.MetaTypeDecl(arity,name)) in
       !Data.add_type_meta name constraints pure; tok) }
+| TAttribute
+    { (fun arity name pure check_meta constraints ->
+      let tok = check_meta(Ast.MetaAttributeDecl(arity,name)) in
+      !Data.add_attribute_meta name constraints pure; tok) }
 | TError
     { (fun arity name pure check_meta constraints ->
       let tok = check_meta(Ast_cocci.MetaErrDecl(arity,name)) in
@@ -1495,11 +1500,11 @@ fninfo:
 	let _ = List.find (function Ast0_cocci.FInline(_) -> true | _ -> false) $2 in
 	raise (Semantic_cocci.Semantic "duplicate inline")
       with Not_found -> (Ast0_cocci.FInline(Parse_aux.clt2mcode "inline" $1))::$2 }
-  | a=Tattr    fninfo
+  | a=attr    fninfo
       { try
 	let _ = List.find (function Ast0_cocci.FAttr(_) -> true | _ -> false) $2 in
 	raise (Semantic_cocci.Semantic "multiple attributes")
-      with Not_found -> (Ast0_cocci.FAttr(Parse_aux.make_attr a))::$2 }
+      with Not_found -> (Ast0_cocci.FAttr(a))::$2 }
 
 fninfo_nt:
     /* empty */ { [] }
@@ -1514,11 +1519,11 @@ fninfo_nt:
 	let _ = List.find (function Ast0_cocci.FInline(_) -> true | _ -> false) $2 in
 	raise (Semantic_cocci.Semantic "duplicate inline")
       with Not_found -> (Ast0_cocci.FInline(Parse_aux.clt2mcode "inline" $1))::$2 }
-  | a=Tattr    fninfo_nt
+  | a=attr    fninfo_nt
       { try
 	let _ = List.find (function Ast0_cocci.FAttr(_) -> true | _ -> false) $2 in
 	raise (Semantic_cocci.Semantic "duplicate init")
-      with Not_found -> (Ast0_cocci.FAttr(Parse_aux.make_attr a))::$2 }
+      with Not_found -> (Ast0_cocci.FAttr(a))::$2 }
 
 storage:
          s=Tstatic      { Parse_aux.clt2mcode Ast_cocci.Static s }
@@ -3228,13 +3233,17 @@ script_virt_name_decl:
 %inline
 attr_list:
                            { [] }
- | Tattr f=full_attr_list
-    { let a = Parse_aux.make_attr $1 in a::f }
+ | a=attr f=full_attr_list  { a::f }
 
 full_attr_list:
                            { [] }
- | Tattr f=full_attr_list
-    { let a = Parse_aux.make_attr $1 in a::f }
+ | a=attr f=full_attr_list  { a::f }
+
+attr:
+   Tattr { Parse_aux.make_attr $1 }
+ | TMetaAttribute
+    { let (nm,cstr,pure,clt) = $1 in
+      Ast0_cocci.wrap(Ast0_cocci.MetaAttribute(Parse_aux.clt2mcode nm clt,cstr,pure)) }
 
 anything: /* used for script code */
    TIdentifier { "identifier" }
-- 
2.21.3

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
