Return-Path: <SRS0=15MF=5F=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0244BC4332D
	for <cocci@archiver.kernel.org>; Fri, 20 Mar 2020 07:04:25 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F92220714
	for <cocci@archiver.kernel.org>; Fri, 20 Mar 2020 07:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUNAZjGB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F92220714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02K742pg021334;
	Fri, 20 Mar 2020 08:04:02 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 14E43780E;
	Fri, 20 Mar 2020 08:04:02 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4B2003B93
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 08:04:00 +0100 (CET)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:544])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02K73sSX017852
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 08:03:55 +0100 (CET)
Received: by mail-pg1-x544.google.com with SMTP id x7so2611773pgh.5
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 00:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=q43bQ4pPVW4yw+dfhBjcWwp74xQfP/50K0Hht57IYrI=;
 b=bUNAZjGBAiaLxbiIvcRSBl24lzxxVL6b3c540nFvXiCwbrHWDx3CXwS6hz9qc0b6B1
 xHJxVpEqQQUSLV38jBmpx8DQsPJ9t0KP/vFwZtirq85walQ6TG5IEf6dG5VP07WGOdmY
 J7Ymeu5/yLZdC5fon5LdrEkqNyXfROFvWQLUCkzWkYeopRvDv0c0tkutOi3r9DpZV/WH
 MLV/XMf4Csz3DsxDp2vDvl25JRkfkq4yg9+dOW2YdEBIN2JkRav90yAoEFUQ37Hgtmh1
 E7qTl81fgm0xndMX2JH7G9wydwpLhozAEZxAhmn8GIrzwbKoIn89x8811RSJyJAmwCvi
 SrPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=q43bQ4pPVW4yw+dfhBjcWwp74xQfP/50K0Hht57IYrI=;
 b=tNOvanrFLGhwnac44NL3b9F/CBY4AQHPQdyS6ZIbXjb4LF3u/vuCTSHrMx0PAAiF3O
 xOvmbxKf6kB//r28dkPkwf008Tks75I8aRs0XR+cL7dwQCS5i46PTRgY9EpFWzQ9MsYc
 XqIsxKHTpqo4o+OWqP95wtF+nVfwgGGpqwtroMf55SDxo4U5sxD80xHB4wtjOXeSqlF9
 djBLdlZqgO9ZZYsYT4fUf/Jh8iij8Ok4RwmQlOcQ2onn/8lLDYmUJMjpk9TDjJY/kQu6
 eYTaQD64By15yj3cvH5nVXWMs97aNwsvi5OpISRqjAMCK+vzt6df6JwxrJWAb1lNdDWe
 WzMg==
X-Gm-Message-State: ANhLgQ2bzahfzdsi92MclwBG/OzNba7zV3X3M5m6G2HG+XYFPW/o4sFo
 nVKMd+42DHUsKW59+6NiHsi6R42e
X-Google-Smtp-Source: ADFU+vuNsarjqhD0XJszOT1N3tPn/Re5hfFkXYm8tu+M34EUP+Yae4QCzwT8hJWsOXRKqn9nsB4FPg==
X-Received: by 2002:a05:6a00:42:: with SMTP id
 i2mr8134435pfk.108.1584687832621; 
 Fri, 20 Mar 2020 00:03:52 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:2190:a751:deeb:c09d:833a:659d])
 by smtp.gmail.com with ESMTPSA id l11sm3941232pjy.44.2020.03.20.00.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2020 00:03:52 -0700 (PDT)
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: cocci@systeme.lip6.fr
Date: Fri, 20 Mar 2020 12:31:56 +0530
Message-Id: <20200320070157.4206-26-jaskaransingh7654321@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200320070157.4206-1-jaskaransingh7654321@gmail.com>
References: <20200320070157.4206-1-jaskaransingh7654321@gmail.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 20 Mar 2020 08:04:02 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 20 Mar 2020 08:03:56 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: [Cocci] [PATCH v3 25/26] cocci: Remove Ast_cocci.FunctionPointer
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

ParenType and FunctionType are now in the SmPL AST, and these
types have replaced all productions related to the FunctionPointer
type in the SmPL parser.

Remove FunctionPointer from the SmPL ASTs, its cases and any functions
or constructs related to it from the codebase.

Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
---
 engine/check_exhaustive_pattern.ml       |  1 -
 engine/cocci_vs_c.ml                     | 55 ------------------------
 ocaml/coccilib.mli                       |  4 --
 parsing_c/unparse_cocci.ml               | 14 +-----
 parsing_cocci/adjust_pragmas.ml          |  3 --
 parsing_cocci/arity.ml                   |  8 ----
 parsing_cocci/ast0_cocci.ml              |  4 --
 parsing_cocci/ast0_cocci.mli             |  3 --
 parsing_cocci/ast0toast.ml               |  5 ---
 parsing_cocci/ast_cocci.ml               |  8 ----
 parsing_cocci/ast_cocci.mli              |  3 --
 parsing_cocci/check_meta.ml              |  3 --
 parsing_cocci/compute_lines.ml           | 10 -----
 parsing_cocci/disjdistr.ml               |  6 ---
 parsing_cocci/function_prototypes.ml     |  3 --
 parsing_cocci/get_constants.ml           |  2 +-
 parsing_cocci/index.ml                   |  1 -
 parsing_cocci/iso_pattern.ml             | 12 ------
 parsing_cocci/pretty_print_cocci.ml      | 14 +-----
 parsing_cocci/single_statement.ml        |  1 -
 parsing_cocci/type_cocci.mli             |  1 -
 parsing_cocci/type_infer.ml              | 25 +++++------
 parsing_cocci/unify_ast.ml               |  8 ----
 parsing_cocci/unparse_ast0.ml            | 13 +-----
 parsing_cocci/visitor_ast.ml             | 26 -----------
 parsing_cocci/visitor_ast0.ml            | 51 +---------------------
 tools/spgen/source/meta_variable.ml      |  1 -
 tools/spgen/source/position_generator.ml |  3 --
 28 files changed, 19 insertions(+), 269 deletions(-)

diff --git a/engine/check_exhaustive_pattern.ml b/engine/check_exhaustive_pattern.ml
index 872c060c..fe0b2c78 100644
--- a/engine/check_exhaustive_pattern.ml
+++ b/engine/check_exhaustive_pattern.ml
@@ -148,7 +148,6 @@ let dumb_astcocci_type = function
  | A.BaseType (basea,strings) -> ()
  | A.SignedT (signa,tya) -> ()
  | A.Pointer (typa, _) -> ()
- | A.FunctionPointer(ty,lp1,star,rp1,lp2,params,rp2) -> ()
  | A.ParenType(lp,ty,rp) -> ()
  | A.FunctionType(ty,lp,params,rp) -> ()
  | A.Array (typa, _, eaopt, _) -> ()
diff --git a/engine/cocci_vs_c.ml b/engine/cocci_vs_c.ml
index 3e0eb50e..87b0ce70 100644
--- a/engine/cocci_vs_c.ml
+++ b/engine/cocci_vs_c.ml
@@ -3733,58 +3733,6 @@ and (typeC: (A.typeC, Ast_c.typeC) matcher) =
             (B.Pointer typb, [ibmult])
           )))
 
-    | A.FunctionPointer(tya,lp1a,stara,rp1a,lp2a,paramsa,rp2a),
-        (B.ParenType t1, ii) ->
-        let (lp1b, rp1b) = tuple_of_list2 ii in
-        let (qu1b, t1b) = t1 in
-        (match t1b with
-        | B.Pointer t2, ii ->
-            let (starb) = tuple_of_list1 ii in
-            let (qu2b, t2b) = t2 in
-            (match t2b with
-            | B.FunctionType (tyb, (paramsb, (isvaargs, iidotsb))), ii ->
-                let (lp2b, rp2b) = tuple_of_list2 ii in
-
-                if isvaargs
-                then
-		  pr2_once
-		    ("Not handling well variable length arguments func. "^
-		     "You have been warned");
-
-                fullType tya tyb >>= (fun tya tyb ->
-                tokenf lp1a lp1b >>= (fun lp1a lp1b ->
-                tokenf rp1a rp1b >>= (fun rp1a rp1b ->
-                tokenf lp2a lp2b >>= (fun lp2a lp2b ->
-                tokenf rp2a rp2b >>= (fun rp2a rp2b ->
-                tokenf stara starb >>= (fun stara starb ->
-                parameters (seqstyle paramsa) (A.unwrap paramsa) paramsb >>=
-                (fun paramsaunwrap paramsb ->
-                  let paramsa = A.rewrap paramsa paramsaunwrap in
-
-                  let t2 =
-                    (qu2b,
-                    (B.FunctionType (tyb, (paramsb, (isvaargs, iidotsb))),
-                    [lp2b;rp2b]))
-                  in
-                  let t1 =
-                    (qu1b,
-                    (B.Pointer t2, [starb]))
-                  in
-
-                  return (
-                    (A.FunctionPointer(tya,lp1a,stara,rp1a,lp2a,paramsa,rp2a))
-                    +> A.rewrap ta,
-                    (B.ParenType t1, [lp1b;rp1b])
-                  )
-                )))))))
-
-
-
-            | _ -> fail
-            )
-        | _ -> fail
-        )
-
     | A.ParenType (lpa, typa, rpa), (B.ParenType typb, ii) ->
         let (lpb, rpb) = tuple_of_list2 ii in
         fullType typa typb >>= (fun typa typb ->
@@ -4381,9 +4329,6 @@ and compatible_typeC a (b,local) =
 
     | A.Pointer (a, _), (qub, (B.Pointer b, ii)) ->
 	compatible_type a (b, local)
-    | A.FunctionPointer (a, _, _, _, _, _, _), _ ->
-	failwith
-	  "TODO: function pointer type doesn't store enough information to determine compatibility"
     | A.ParenType (_, a, _), (qub, (B.ParenType b, ii)) ->
 	compatible_type a (b, local)
     | A.FunctionType (a, _, _, _), (qub, (B.FunctionType (b,_), ii)) ->
diff --git a/ocaml/coccilib.mli b/ocaml/coccilib.mli
index e5409a97..c54607d5 100644
--- a/ocaml/coccilib.mli
+++ b/ocaml/coccilib.mli
@@ -2707,8 +2707,6 @@ module Ast_cocci :
         BaseType of baseType * string mcode list
       | SignedT of sign mcode * typeC option
       | Pointer of fullType * string mcode
-      | FunctionPointer of fullType * string mcode * string mcode *
-          string mcode * string mcode * parameter_list * string mcode
       | ParenType of string mcode (* ( *) * fullType * string mcode (* ) *)
       | FunctionType of fullType *
           string mcode (* ( *) * parameter_list * string mcode (* ) *)
@@ -3354,8 +3352,6 @@ module Ast0_cocci :
       | BaseType of Ast_cocci.baseType * string mcode list
       | Signed of Ast_cocci.sign mcode * typeC option
       | Pointer of typeC * string mcode
-      | FunctionPointer of typeC * string mcode * string mcode *
-          string mcode * string mcode * parameter_list * string mcode
       | ParenType of string mcode * typeC * string mcode
       | FunctionType of typeC *
           string mcode * parameter_list * string mcode
diff --git a/parsing_c/unparse_cocci.ml b/parsing_c/unparse_cocci.ml
index 1fa3115a..718b466c 100644
--- a/parsing_c/unparse_cocci.ml
+++ b/parsing_c/unparse_cocci.ml
@@ -700,12 +700,6 @@ and fullType ft =
   | Ast.DisjType _ | Ast.ConjType _ -> raise CantBeInPlus
   | Ast.OptType(_) -> raise CantBeInPlus
 
-and print_function_pointer (ty,lp1,star,rp1,lp2,params,rp2) fn =
-  fullType ty; pr_space();
-  mcode print_string lp1; mcode print_string star; fn();
-  mcode print_string rp1; mcode print_string lp1;
-  parameter_list params; mcode print_string rp2
-
 and print_fninfo = function
     Ast.FStorage(stg) -> mcode storage stg
   | Ast.FType(ty) -> fullType ty
@@ -719,9 +713,6 @@ and typeC ty =
   | Ast.SignedT(sgn,ty) -> mcode sign sgn; print_option_prespace typeC ty
   | Ast.Pointer(ty,star) ->
       fullType ty; ft_space ty; mcode print_string star; eatspace()
-  | Ast.FunctionPointer(ty,lp1,star,rp1,lp2,params,rp2) ->
-      print_function_pointer (ty,lp1,star,rp1,lp2,params,rp2)
-	(function _ -> ())
   | Ast.ParenType(lp,ty,rp) ->
       print_parentype (lp,ty,rp) (function _ -> ())
   | Ast.FunctionType(ty,lp,params,rp) ->
@@ -843,10 +834,7 @@ and print_named_type ty id =
   match Ast.unwrap ty with
     Ast.Type(_,None,ty1) ->
       (match Ast.unwrap ty1 with
-	Ast.FunctionPointer(ty,lp1,star,rp1,lp2,params,rp2) ->
-	  print_function_pointer (ty,lp1,star,rp1,lp2,params,rp2)
-	    (function _ -> id())
-      | Ast.Array(_,_,_,_) ->
+        Ast.Array(_,_,_,_) ->
 	  let rec loop ty k =
 	    match Ast.unwrap ty with
 	      Ast.Array(ty,lb,size,rb) ->
diff --git a/parsing_cocci/adjust_pragmas.ml b/parsing_cocci/adjust_pragmas.ml
index 6d2a9c5d..fb2e63de 100644
--- a/parsing_cocci/adjust_pragmas.ml
+++ b/parsing_cocci/adjust_pragmas.ml
@@ -168,9 +168,6 @@ let rec left_ty t =
       call_right left_mcode sign t (function sign -> Ast0.Signed(sign,ty))
   | Ast0.Pointer(ty,star) ->
       call_right left_ty ty t (function ty -> Ast0.Pointer(ty,star))
-  | Ast0.FunctionPointer(ty,lp1,star,rp1,lp2,params,rp2) ->
-      call_right left_ty ty t
-	(function ty -> Ast0.FunctionPointer(ty,lp1,star,rp1,lp2,params,rp2))
   | Ast0.ParenType(lp,ty,rp) ->
       call_right left_mcode lp t (function lp -> Ast0.ParenType(lp,ty,rp))
   | Ast0.FunctionType(ty,lp,params,rp) ->
diff --git a/parsing_cocci/arity.ml b/parsing_cocci/arity.ml
index 3b408554..e1515873 100644
--- a/parsing_cocci/arity.ml
+++ b/parsing_cocci/arity.ml
@@ -411,14 +411,6 @@ and top_typeC tgt opt_allowed typ =
       let ty = typeC arity ty in
       let star = mcode star in
       make_typeC typ tgt arity (Ast0.Pointer(ty,star))
-  | Ast0.FunctionPointer(ty,lp1,star,rp1,lp2,params,rp2) ->
-      let arity =
-	all_same opt_allowed tgt (mcode2line lp1)
-	  (List.map mcode2arity [lp1;star;rp1;lp2;rp2]) in
-      let ty = typeC arity ty in
-      let params = parameter_list tgt params in
-      make_typeC typ tgt arity
-	(Ast0.FunctionPointer(ty,lp1,star,rp1,lp2,params,rp2))
   | Ast0.ParenType(lp,ty,rp) ->
       let arity =
         all_same opt_allowed tgt (mcode2line lp)
diff --git a/parsing_cocci/ast0_cocci.ml b/parsing_cocci/ast0_cocci.ml
index 0acbeaa4..1b4087c3 100644
--- a/parsing_cocci/ast0_cocci.ml
+++ b/parsing_cocci/ast0_cocci.ml
@@ -200,9 +200,6 @@ and base_typeC =
   | BaseType        of Ast.baseType * string mcode list
   | Signed          of Ast.sign mcode * typeC option
   | Pointer         of typeC * string mcode (* * *)
-  | FunctionPointer of typeC *
-	          string mcode(* ( *)*string mcode(* * *)*string mcode(* ) *)*
-                  string mcode (* ( *)*parameter_list*string mcode(* ) *)
   | ParenType       of string mcode (* ( *) * typeC * string mcode (* ) *)
   | FunctionType    of typeC *
                   string mcode (* ( *) * parameter_list * string mcode (* ) *)
@@ -737,7 +734,6 @@ let rec meta_names_of_typeC ty =
     ConstVol (_, ty)
   | Signed (_, Some ty)
   | Pointer (ty, _)
-  | FunctionPointer (ty, _, _, _, _, _, _)
   | Array (ty, _, _, _) -> meta_names_of_typeC ty
   | EnumName (_, Some ident)
   | StructUnionName(_, Some ident) -> meta_names_of_ident ident
diff --git a/parsing_cocci/ast0_cocci.mli b/parsing_cocci/ast0_cocci.mli
index 33bd12b2..c1bc561b 100644
--- a/parsing_cocci/ast0_cocci.mli
+++ b/parsing_cocci/ast0_cocci.mli
@@ -191,9 +191,6 @@ and base_typeC =
   | BaseType        of Ast_cocci.baseType * string mcode list
   | Signed          of Ast_cocci.sign mcode * typeC option
   | Pointer         of typeC * string mcode (* * *)
-  | FunctionPointer of typeC *
-	          string mcode(* ( *)*string mcode(* * *)*string mcode(* ) *)*
-                  string mcode (* ( *)*parameter_list*string mcode(* ) *)
   | ParenType       of string mcode (* ( *) * typeC * string mcode (* ) *)
   | FunctionType    of typeC *
                   string mcode (* ( *) * parameter_list * string mcode (* ) *)
diff --git a/parsing_cocci/ast0toast.ml b/parsing_cocci/ast0toast.ml
index dc7b30f7..375b2292 100644
--- a/parsing_cocci/ast0toast.ml
+++ b/parsing_cocci/ast0toast.ml
@@ -561,7 +561,6 @@ and typeC allminus t =
 	  [ty] -> ty
 	| types -> Ast.DisjType(List.map (rewrap t no_isos) types))
     | Ast0.BaseType(_) | Ast0.Signed(_,_) | Ast0.Pointer(_,_)
-    | Ast0.FunctionPointer(_,_,_,_,_,_,_)
     | Ast0.ParenType(_,_,_) | Ast0.FunctionType(_,_,_,_)
     | Ast0.Array(_,_,_,_) | Ast0.Decimal(_,_,_,_,_,_)
     | Ast0.EnumName(_,_) | Ast0.StructUnionName(_,_)
@@ -585,10 +584,6 @@ and base_typeC allminus t =
 	(mcode sgn,
 	 get_option (function x -> rewrap_iso x (base_typeC allminus x)) ty)
   | Ast0.Pointer(ty,star) -> Ast.Pointer(typeC allminus ty,mcode star)
-  | Ast0.FunctionPointer(ty,lp1,star,rp1,lp2,params,rp2) ->
-      Ast.FunctionPointer
-	(typeC allminus ty,mcode lp1,mcode star,mcode rp1,
-	 mcode lp2,parameter_list params,mcode rp2)
   | Ast0.ParenType(lp,ty,rp) ->
       Ast.ParenType(mcode lp,typeC allminus ty,mcode rp)
   | Ast0.FunctionType(ty,lp,params,rp) ->
diff --git a/parsing_cocci/ast_cocci.ml b/parsing_cocci/ast_cocci.ml
index 4fea9794..b1639ba6 100644
--- a/parsing_cocci/ast_cocci.ml
+++ b/parsing_cocci/ast_cocci.ml
@@ -340,9 +340,6 @@ and base_typeC =
     BaseType        of baseType * string mcode list (* Yoann style *)
   | SignedT         of sign mcode * typeC option
   | Pointer         of fullType * string mcode (* * *)
-  | FunctionPointer of fullType *
-	          string mcode(* ( *)*string mcode(* * *)*string mcode(* ) *)*
-                  string mcode (* ( *)*parameter_list*string mcode(* ) *)
   | ParenType       of string mcode (* ( *) * fullType * string mcode (* ) *)
   | FunctionType    of fullType *
                   string mcode (* ( *) * parameter_list * string mcode (* ) *)
@@ -1108,8 +1105,6 @@ let rec string_of_typeC ty =
       ssign ^ " " ^ Common.default "" string_of_typeC ty'
   | Pointer (ty', _) ->
       string_of_fullType ty' ^ "*"
-  | FunctionPointer (ty', _, _, _, _, _, _) ->
-      string_of_fullType ty' ^ "(*)()"
   | ParenType (_ , ty', _) ->
       "(" ^ string_of_fullType ty' ^ ")"
   | FunctionType (ty' , _, _, _) ->
@@ -1193,8 +1188,6 @@ and typeC_map tr ty =
         | Some f -> rewrap ty (f ty' s)
       end
   | Pointer (ty', s) -> rewrap ty (Pointer (fullType_map tr ty', s))
-  | FunctionPointer (ty, s0, s1, s2, s3, s4, s5) ->
-      rewrap ty (FunctionPointer (fullType_map tr ty, s0, s1, s2, s3, s4, s5))
   | ParenType (s0, ty', s1) ->
       rewrap ty (ParenType (s0, fullType_map tr ty', s1))
   | FunctionType (ty', s0, s1, s2) ->
@@ -1257,7 +1250,6 @@ and typeC_fold tr ty v =
   | SignedT (_, None) -> v
   | SignedT (_, Some ty') -> typeC_fold tr ty' v
   | Pointer (ty', _)
-  | FunctionPointer (ty', _, _, _, _, _, _)
   | ParenType (_, ty', _)
   | FunctionType (ty', _, _, _)
   | Array (ty', _, _, _)
diff --git a/parsing_cocci/ast_cocci.mli b/parsing_cocci/ast_cocci.mli
index 7fb54e4d..6bc1d652 100644
--- a/parsing_cocci/ast_cocci.mli
+++ b/parsing_cocci/ast_cocci.mli
@@ -322,9 +322,6 @@ and base_typeC =
     BaseType        of baseType * string mcode list (* Yoann style *)
   | SignedT         of sign mcode * typeC option
   | Pointer         of fullType * string mcode (* * *)
-  | FunctionPointer of fullType *
-	          string mcode(* ( *)*string mcode(* * *)*string mcode(* ) *)*
-                  string mcode (* ( *)*parameter_list*string mcode(* ) *)
   | ParenType       of string mcode (* ( *) * fullType * string mcode (* ) *)
   | FunctionType    of fullType *
                   string mcode (* ( *) * parameter_list * string mcode (* ) *)
diff --git a/parsing_cocci/check_meta.ml b/parsing_cocci/check_meta.ml
index 7b10bd53..fc6766ae 100644
--- a/parsing_cocci/check_meta.ml
+++ b/parsing_cocci/check_meta.ml
@@ -221,9 +221,6 @@ and typeC old_metas table minus t =
   | Ast0.Signed(sgn,ty) ->
       get_opt (typeC old_metas table minus) ty
   | Ast0.Pointer(ty,star) -> typeC old_metas table minus ty
-  | Ast0.FunctionPointer(ty,lp1,star,rp1,lp2,params,rp2) ->
-      typeC old_metas table minus ty;
-      parameter_list old_metas table minus params
   | Ast0.ParenType(lp,ty,rp) ->
       typeC old_metas table minus ty
   | Ast0.FunctionType(ty,lp,params,rp) ->
diff --git a/parsing_cocci/compute_lines.ml b/parsing_cocci/compute_lines.ml
index c47a06ba..2b2606ad 100644
--- a/parsing_cocci/compute_lines.ml
+++ b/parsing_cocci/compute_lines.ml
@@ -564,16 +564,6 @@ and typeC t =
       let ty = typeC ty in
       let star = normal_mcode star in
       mkres t (Ast0.Pointer(ty,star)) ty (promote_mcode star)
-  | Ast0.FunctionPointer(ty,lp1,star,rp1,lp2,params,rp2) ->
-      let ty = typeC ty in
-      let lp1 = normal_mcode lp1 in
-      let star = normal_mcode star in
-      let rp1 = normal_mcode rp1 in
-      let lp2 = normal_mcode lp2 in
-      let params = parameter_list (Some(promote_mcode lp2)) params in
-      let rp2 = normal_mcode rp2 in
-      mkres t (Ast0.FunctionPointer(ty,lp1,star,rp1,lp2,params,rp2))
-	ty (promote_mcode rp2)
   | Ast0.ParenType(lp,ty,rp) ->
       let lp = normal_mcode lp in
       let rp = normal_mcode rp in
diff --git a/parsing_cocci/disjdistr.ml b/parsing_cocci/disjdistr.ml
index 91d7f1b8..ff49057c 100644
--- a/parsing_cocci/disjdistr.ml
+++ b/parsing_cocci/disjdistr.ml
@@ -67,12 +67,6 @@ and disjtypeC bty =
   | Ast.Pointer(ty,star) ->
       let ty = disjty ty in
       List.map (function ty -> Ast.rewrap bty (Ast.Pointer(ty,star))) ty
-  | Ast.FunctionPointer(ty,lp1,star,rp1,lp2,params,rp2) ->
-      let ty = disjty ty in
-      List.map
-	(function ty ->
-	  Ast.rewrap bty (Ast.FunctionPointer(ty,lp1,star,rp1,lp2,params,rp2)))
-	ty
   | Ast.ParenType(lp,ty,rp) ->
       let ty = disjty ty in
       List.map
diff --git a/parsing_cocci/function_prototypes.ml b/parsing_cocci/function_prototypes.ml
index fd36f31b..b31178d2 100644
--- a/parsing_cocci/function_prototypes.ml
+++ b/parsing_cocci/function_prototypes.ml
@@ -226,9 +226,6 @@ let rec attach_right strings ty =
     | Ast0.Signed(sgn,Some ty) ->
 	Ast0.Signed(sgn,Some (attach_right strings ty))
     | Ast0.Pointer(ty,star) -> Ast0.Pointer(ty,right_attach_mcode strings star)
-    | Ast0.FunctionPointer(ty,lp,star,rp,lp1,ps,rp1) ->
-	Ast0.FunctionPointer(ty,lp,star,rp,lp1,ps,
-			     right_attach_mcode strings rp1)
     | Ast0.ParenType(lp,ty,rp) ->
 	Ast0.ParenType(lp,ty,right_attach_mcode strings rp)
     | Ast0.FunctionType(ty,lp,ps,rp) ->
diff --git a/parsing_cocci/get_constants.ml b/parsing_cocci/get_constants.ml
index 65c72641..a23f2e4f 100644
--- a/parsing_cocci/get_constants.ml
+++ b/parsing_cocci/get_constants.ml
@@ -181,7 +181,7 @@ let check_inherited nm =
     | _ -> k i in
 
   let rec type_collect res = function
-      TC.ConstVol(_,ty) | TC.Pointer(ty) | TC.FunctionPointer(ty)
+      TC.ConstVol(_,ty) | TC.Pointer(ty)
     | TC.Array(ty) -> type_collect res ty
     | TC.MetaType(tyname,_,_) ->
 	inherited tyname
diff --git a/parsing_cocci/index.ml b/parsing_cocci/index.ml
index 088db18a..56eed017 100644
--- a/parsing_cocci/index.ml
+++ b/parsing_cocci/index.ml
@@ -92,7 +92,6 @@ let typeC t =
   | Ast0.BaseType(ty,strings) -> [48]
   | Ast0.Signed(sign,ty) -> [129]
   | Ast0.Pointer(ty,star) -> [49]
-  | Ast0.FunctionPointer(ty,lp1,star,rp1,lp2,params,rp2) -> [131]
   | Ast0.ParenType(lp,ty,rp) -> [138]
   | Ast0.FunctionType(ty,lp,params,rp) -> [139]
   | Ast0.Array(ty,lb,size,rb) -> [50]
diff --git a/parsing_cocci/iso_pattern.ml b/parsing_cocci/iso_pattern.ml
index 6d51b072..71640044 100644
--- a/parsing_cocci/iso_pattern.ml
+++ b/parsing_cocci/iso_pattern.ml
@@ -863,14 +863,6 @@ let match_maker checks_needed context_required whencode_allowed =
 	      else return false
 	  | (Ast0.Pointer(tya,star1),Ast0.Pointer(tyb,star)) ->
 	      conjunct_bindings (check_mcode star1 star) (match_typeC tya tyb)
-	  | (Ast0.FunctionPointer(tya,lp1a,stara,rp1a,lp2a,paramsa,rp2a),
-	     Ast0.FunctionPointer(tyb,lp1b,starb,rp1b,lp2b,paramsb,rp2b)) ->
-	       conjunct_many_bindings
-		 [check_mcode stara starb; check_mcode lp1a lp1b;
-		   check_mcode rp1a rp1b; check_mcode lp2a lp2b;
-		   check_mcode rp2a rp2b; match_typeC tya tyb;
-		   match_dots match_param is_plist_matcher
-		     do_plist_match paramsa paramsb]
 	  | (Ast0.Array(tya,lb1,sizea,rb1),Ast0.Array(tyb,lb,sizeb,rb)) ->
 	      conjunct_many_bindings
 		[check_mcode lb1 lb; check_mcode rb1 rb;
@@ -1814,10 +1806,6 @@ let instantiate bindings mv_bindings model =
                           Ast0.rewrap ty (Ast0.ConstVol(cv,renamer ty'))
                       | Ast0.Pointer(ty', s) ->
                           Ast0.rewrap ty (Ast0.Pointer(renamer ty', s))
-                      | Ast0.FunctionPointer(ty', s0, s1, s2, s3, p, s4) ->
-                          Ast0.rewrap ty (
-                            Ast0.FunctionPointer(
-                              renamer ty', s0, s1, s2, s3, p, s4))
                       | Ast0.ParenType(s0, ty', s1) ->
                           Ast0.rewrap ty (Ast0.ParenType(s0, renamer ty', s1))
                       | Ast0.FunctionType(ty', s0, s1, s2) ->
diff --git a/parsing_cocci/pretty_print_cocci.ml b/parsing_cocci/pretty_print_cocci.ml
index 8055ba3b..770e117c 100644
--- a/parsing_cocci/pretty_print_cocci.ml
+++ b/parsing_cocci/pretty_print_cocci.ml
@@ -397,12 +397,6 @@ and fullType ft =
   | Ast.ConjType(decls) -> print_disj_list fullType decls "&"
   | Ast.OptType(ty) -> print_string "?"; fullType ty
 
-and print_function_pointer (ty,lp1,star,rp1,lp2,params,rp2) fn =
-  fullType ty; print_string " ";
-  mcode print_string lp1; mcode print_string star; fn();
-  mcode print_string rp1; mcode print_string lp1;
-  parameter_list params; mcode print_string rp2
-
 and print_parentype (lp,ty,rp) fn =
   let function_pointer ty1 array_dec =
     match Ast.unwrap ty1 with
@@ -462,9 +456,6 @@ and typeC ty =
       List.iter (function s -> mcode print_string s; print_string " ") strings
   | Ast.SignedT(sgn,ty) -> mcode sign sgn; print_option typeC ty
   | Ast.Pointer(ty,star) -> fullType ty; mcode print_string star
-  | Ast.FunctionPointer(ty,lp1,star,rp1,lp2,params,rp2) ->
-      print_function_pointer (ty,lp1,star,rp1,lp2,params,rp2)
-	(function _ -> ())
   | Ast.ParenType(lp,ty,rp) ->
       print_parentype (lp,ty,rp) (function _ -> ())
   | Ast.FunctionType(ty,lp,params,rp) ->
@@ -525,10 +516,7 @@ and print_named_type ty id =
   match Ast.unwrap ty with
     Ast.Type(_,None,ty1) ->
       (match Ast.unwrap ty1 with
-	Ast.FunctionPointer(ty,lp1,star,rp1,lp2,params,rp2) ->
-	  print_function_pointer (ty,lp1,star,rp1,lp2,params,rp2)
-	    (function _ -> id())
-      | Ast.Array(ty,lb,size,rb) ->
+        Ast.Array(ty,lb,size,rb) ->
 	  let rec loop ty k =
 	    match Ast.unwrap ty with
 	      Ast.Array(ty,lb,size,rb) ->
diff --git a/parsing_cocci/single_statement.ml b/parsing_cocci/single_statement.ml
index 2bd4c202..4e23aef3 100644
--- a/parsing_cocci/single_statement.ml
+++ b/parsing_cocci/single_statement.ml
@@ -165,7 +165,6 @@ and left_typeC t =
   | Ast0.BaseType(ty,strings) -> modif_before_mcode (List.hd strings)
   | Ast0.Signed(sgn,ty) -> modif_before_mcode sgn
   | Ast0.Pointer(ty,star) -> left_typeC ty
-  | Ast0.FunctionPointer(ty,lp1,star,rp1,lp2,params,rp2) -> left_typeC ty
   | Ast0.ParenType(lp,ty,rp) -> modif_before_mcode lp
   | Ast0.FunctionType(ty,lp,params,rp) -> left_typeC ty
   | Ast0.Array(ty,lb,size,rb) -> left_typeC ty
diff --git a/parsing_cocci/type_cocci.mli b/parsing_cocci/type_cocci.mli
index 6f24adf7..5b0734d2 100644
--- a/parsing_cocci/type_cocci.mli
+++ b/parsing_cocci/type_cocci.mli
@@ -15,7 +15,6 @@ type typeC =
   | BaseType        of baseType
   | SignedT         of sign * typeC option
   | Pointer         of typeC
-  | FunctionPointer of typeC (* only return type *)
   | ParenType       of typeC (* only return type *)
   | FunctionType    of typeC (* only return type *)
   | Array           of typeC (* drop size info *)
diff --git a/parsing_cocci/type_infer.ml b/parsing_cocci/type_infer.ml
index b4c0b55e..345bc129 100644
--- a/parsing_cocci/type_infer.ml
+++ b/parsing_cocci/type_infer.ml
@@ -161,18 +161,19 @@ let rec propagate_types env =
               Ast0.rewrap e (
                 Ast0.Array(Ast0.rewrap e char_type, dummy, None, dummy)))
 	| Ast0.FunCall(fn,lp,args,rp) ->
-	    (match Common.map_option Ast0.unwrap (Ast0.get_type fn) with
-		 Some (Ast0.FunctionPointer(ty, _, _, _, _, _, _)) -> Some ty
-	       |  _ ->
-		    (match Ast0.unwrap fn with
-			 Ast0.Ident(id) ->
-			   (match Ast0.unwrap id with
-				Ast0.Id(id) ->
-				  if List.mem (Ast0.unwrap_mcode id) bool_functions
-				  then Some(Ast0.rewrap e bool_type)
-				  else None
-			      | _ -> None)
-		       |	_ -> None))
+            let fna = Common.map_option Ast0.unwrap (Ast0.get_type fn) in
+            (match fna with
+                 Some _ ->
+                 (match Ast0.unwrap fn with
+                    Ast0.Ident(id) ->
+                      (match Ast0.unwrap id with
+                         Ast0.Id(id) ->
+                           if List.mem (Ast0.unwrap_mcode id) bool_functions
+                           then Some(Ast0.rewrap e bool_type)
+                           else None
+                       | _ -> None)
+                  | _ -> None)
+            | _ -> None)
 	| Ast0.Assignment(exp1,op,exp2,_) ->
 	    let ty = lub_type (Ast0.get_type exp1) (Ast0.get_type exp2) in
 	      Ast0.set_type exp1 ty; Ast0.set_type exp2 ty; ty
diff --git a/parsing_cocci/unify_ast.ml b/parsing_cocci/unify_ast.ml
index de86b1d3..47a4dfe6 100644
--- a/parsing_cocci/unify_ast.ml
+++ b/parsing_cocci/unify_ast.ml
@@ -328,14 +328,6 @@ and unify_typeC t1 t2 =
       then unify_option unify_typeC ty1 ty2
       else false
   | (Ast.Pointer(ty1,s1),Ast.Pointer(ty2,s2)) -> unify_fullType ty1 ty2
-  | (Ast.FunctionPointer(tya,lp1a,stara,rp1a,lp2a,paramsa,rp2a),
-     Ast.FunctionPointer(tyb,lp1b,starb,rp1b,lp2b,paramsb,rp2b)) ->
-       if List.for_all2 unify_mcode
-	   [lp1a;stara;rp1a;lp2a;rp2a] [lp1b;starb;rp1b;lp2b;rp2b]
-       then
-	 unify_fullType tya tyb &&
-	 unify_dots unify_parameterTypeDef pdots paramsa paramsb
-       else false
   | (Ast.ParenType(lpa,tya,rpa),Ast.ParenType(lpb,tyb,rpb)) ->
       unify_fullType tya tyb && unify_mcode lpa lpb && unify_mcode rpa rpb
   | (Ast.FunctionType(tya,lpa,paramsa,rpa),
diff --git a/parsing_cocci/unparse_ast0.ml b/parsing_cocci/unparse_ast0.ml
index 76288087..c3e0df9c 100644
--- a/parsing_cocci/unparse_ast0.ml
+++ b/parsing_cocci/unparse_ast0.ml
@@ -287,11 +287,6 @@ and string_format e =
 (* --------------------------------------------------------------------- *)
 (* Types *)
 
-and print_function_pointer (ty,lp1,star,rp1,lp2,params,rp2) fn =
-  typeC ty; mcode print_string lp1; mcode print_string star; fn();
-  mcode print_string rp1; mcode print_string lp2;
-  parameter_list params; mcode print_string rp2
-
 and print_parentype (lp,ty,rp) fn =
   let function_pointer ty1 array_decs =
     match Ast0.unwrap ty1 with
@@ -332,9 +327,6 @@ and typeC t =
 	    strings
       |	Ast0.Signed(sgn,ty) -> mcode U.sign sgn; print_option typeC ty
       | Ast0.Pointer(ty,star) -> typeC ty; mcode print_string star
-      | Ast0.FunctionPointer(ty,lp1,star,rp1,lp2,params,rp2) ->
-	  print_function_pointer (ty,lp1,star,rp1,lp2,params,rp2)
-	    (function _ -> ())
       | Ast0.ParenType(lp,ty,rp) ->
           print_parentype (lp,ty,rp) (function _ -> ())
       | Ast0.FunctionType(ty,lp,params,rp) ->
@@ -388,10 +380,7 @@ and typeC t =
 
 and print_named_type ty id =
   match Ast0.unwrap ty with
-    Ast0.FunctionPointer(ty,lp1,star,rp1,lp2,params,rp2) ->
-      print_function_pointer (ty,lp1,star,rp1,lp2,params,rp2)
-	(function _ -> print_string " "; ident id)
-  | Ast0.Array(ty,lb,size,rb) ->
+    Ast0.Array(ty,lb,size,rb) ->
       let rec loop ty k =
 	match Ast0.unwrap ty with
 	  Ast0.Array(ty,lb,size,rb) ->
diff --git a/parsing_cocci/visitor_ast.ml b/parsing_cocci/visitor_ast.ml
index 6f2e3dab..6f435ee6 100644
--- a/parsing_cocci/visitor_ast.ml
+++ b/parsing_cocci/visitor_ast.ml
@@ -297,19 +297,6 @@ let combiner bind option_default
       | Ast.OptType(ty) -> fullType ty in
     ftfn all_functions k ft
 
-  and function_pointer
-	(ty, lp1, star, (id : Ast.ident option), rp1, lp2, params, rp2) =
-    (* have to put the treatment of the identifier into the right position *)
-    let lty = fullType ty in
-    let llp1 = string_mcode lp1 in
-    let lstar = string_mcode star in
-    let lid = match id with Some idd -> [ident idd] | None -> [] in
-    let lrp1 = string_mcode rp1 in
-    let llp2 = string_mcode lp2 in
-    let lparams = parameter_dots params in
-    let lrp2 = string_mcode rp2 in
-    multibind ([lty; llp1; lstar] @ lid @ [lrp1; llp2; lparams; lrp2])
-
   and array_type (ty,(id : Ast.ident option),lb,size,rb) =
     let lty = fullType ty in
     let lid = match id with Some idd -> [ident idd] | None -> [] in
@@ -376,8 +363,6 @@ let combiner bind option_default
 	  let lty = fullType ty in
 	  let lstar = string_mcode star in
 	  bind lty lstar
-      | Ast.FunctionPointer(ty,lp1,star,rp1,lp2,params,rp2) ->
-	  function_pointer (ty,lp1,star,None,rp1,lp2,params,rp2)
       | Ast.ParenType(lp,ty,rp) ->
           parentype_type (lp,ty,None,rp)
       | Ast.FunctionType(ty,lp,params,rp) ->
@@ -435,8 +420,6 @@ let combiner bind option_default
     match Ast.unwrap ty with
       Ast.Type(_,None,ty1) ->
 	(match Ast.unwrap ty1 with
-	  Ast.FunctionPointer(ty,lp1,star,rp1,lp2,params,rp2) ->
-	    function_pointer (ty, lp1, star, Some id, rp1, lp2, params, rp2)
 	| Ast.Array(ty,lb,size,rb) -> array_type (ty, Some id, lb, size, rb)
         | Ast.ParenType(lp,ty,rp) -> parentype_type (lp, ty, Some id, rp)
 	| _ -> let lty = fullType ty in
@@ -1299,15 +1282,6 @@ let rebuilder
 	    let lty = fullType ty in
 	    let lstar = string_mcode star in
 	    Ast.Pointer (lty, lstar)
-	| Ast.FunctionPointer(ty,lp1,star,rp1,lp2,params,rp2) ->
-	    let lty = fullType ty in
-	    let llp1 = string_mcode lp1 in
-	    let lstar = string_mcode star in
-	    let lrp1 = string_mcode rp1 in
-	    let llp2 = string_mcode lp2 in
-	    let lparams = parameter_dots params in
-	    let lrp2 = string_mcode rp2 in
-	    Ast.FunctionPointer(lty, llp1, lstar, lrp1, llp2, lparams, lrp2)
         | Ast.ParenType(lp,ty,rp) ->
             let llp = string_mcode lp in
             let lty = fullType ty in
diff --git a/parsing_cocci/visitor_ast0.ml b/parsing_cocci/visitor_ast0.ml
index 76ec4e5c..adc2fc99 100644
--- a/parsing_cocci/visitor_ast0.ml
+++ b/parsing_cocci/visitor_ast0.ml
@@ -336,9 +336,6 @@ let visitor mode bind option_default
 	    let (ty_n,ty) = typeC ty in
 	    let (star_n,star) = string_mcode star in
 	    (bind ty_n star_n, Ast0.Pointer(ty,star))
-	| Ast0.FunctionPointer(ty,lp1,star,rp1,lp2,params,rp2) ->
-	    let (t,id) =
-              function_pointer (ty,lp1,star,None,rp1,lp2,params,rp2) in t
         | Ast0.ParenType(lp,ty,rp) ->
 	    let (t,id) =
               parentype_type (lp,ty,None,rp) in t
@@ -412,23 +409,6 @@ let visitor mode bind option_default
 	    (bind ty_n asty_n, Ast0.AsType(ty,asty))) in
     tyfn all_functions k t
 
-  (* returns ((bind value,original value),id) since id may have been updated*)
-  and function_pointer
-      (ty,lp1,star,(id : Ast0.ident option),rp1,lp2,params,rp2) =
-    let (ty_n,ty) = typeC ty in
-    let (lp1_n,lp1) = string_mcode lp1 in
-    let (star_n,star) = string_mcode star in
-    let (idl,idu) = (match id with
-      | Some a -> let (b,c) = ident a in ([b],Some c)
-      | None -> ([],None)) in
-    let (rp1_n,rp1) = string_mcode rp1 in
-    let (lp2_n,lp2) = string_mcode lp2 in
-    let (params_n,params) = parameter_dots params in
-    let (rp2_n,rp2) = string_mcode rp2 in
-    (* have to put the treatment of the identifier into the right position *)
-    ((multibind ([ty_n;lp1_n;star_n] @ idl @ [rp1_n;lp2_n;params_n;rp2_n]),
-     Ast0.FunctionPointer(ty,lp1,star,rp1,lp2,params,rp2)), idu)
-
   (* returns ((bind value,original value),id) since id may have been updated*)
   and array_type (ty,(id : Ast0.ident option),lb,size,rb) =
     let (ty_n,ty) = typeC ty in
@@ -505,12 +485,7 @@ let visitor mode bind option_default
 
   and named_type ty id =
     match Ast0.unwrap ty with
-      Ast0.FunctionPointer(rty,lp1,star,rp1,lp2,params,rp2) ->
-	let (tyres, idn) =
-          function_pointer (rty,lp1,star,Some id,rp1,lp2,params,rp2) in
-        let idn = match idn with Some i -> i | None -> failwith "Impossible" in
-	(rewrap ty tyres, idn)
-    | Ast0.Array(rty,lb,size,rb) ->
+      Ast0.Array(rty,lb,size,rb) ->
 	let (tyres, idn) = array_type (rty,Some id,lb,size,rb) in
         let idn = match idn with Some i -> i | None -> failwith "Impossible" in
 	(rewrap ty tyres, idn)
@@ -526,23 +501,6 @@ let visitor mode bind option_default
            let (id_n,id) = ident id in
              ((bind ty_n id_n, ty), id)
 
-  (* returns ((bind value,original value),id) since id may have been updated*)
-  (* the next three functions are needed due to a lack of polymorphism :( *)
-  and function_pointer_typedef (ty,lp1,star,id,rp1,lp2,params,rp2) =
-    let (ty_n,ty) = typeC ty in
-    let (lp1_n,lp1) = string_mcode lp1 in
-    let (star_n,star) = string_mcode star in
-    let (idl,idu) = (match id with
-      | Some a -> let (b,c) = typeC a in ([b],Some c)
-      | None -> ([],None)) in
-    let (rp1_n,rp1) = string_mcode rp1 in
-    let (lp2_n,lp2) = string_mcode lp2 in
-    let (params_n,params) = parameter_dots params in
-    let (rp2_n,rp2) = string_mcode rp2 in
-    (* have to put the treatment of the identifier into the right position *)
-    ((multibind ([ty_n;lp1_n;star_n] @ idl @ [rp1_n;lp2_n;params_n;rp2_n]),
-     Ast0.FunctionPointer(ty,lp1,star,rp1,lp2,params,rp2)), idu)
-
   (* returns ((bind value,original value),id) since id may have been updated*)
   and array_type_typedef (ty,id,lb,size,rb) =
     let (ty_n,ty) = typeC ty in
@@ -620,12 +578,7 @@ let visitor mode bind option_default
 
   and named_type_typedef ty id =
     match Ast0.unwrap ty with
-      Ast0.FunctionPointer(rty,lp1,star,rp1,lp2,params,rp2) ->
-	let (tyres, idn) =
-          function_pointer_typedef (rty,lp1,star,Some id,rp1,lp2,params,rp2) in
-        let idn = match idn with Some i -> i | None -> failwith "Impossible" in
-	(rewrap ty tyres, idn)
-    | Ast0.Array(rty,lb,size,rb) ->
+      Ast0.Array(rty,lb,size,rb) ->
 	let (tyres, idn) = array_type_typedef (rty,Some id,lb,size,rb) in
         let idn = match idn with Some i -> i | None -> failwith "Impossible" in
 	(rewrap ty tyres, idn)
diff --git a/tools/spgen/source/meta_variable.ml b/tools/spgen/source/meta_variable.ml
index 7adfacad..6a3c2089 100644
--- a/tools/spgen/source/meta_variable.ml
+++ b/tools/spgen/source/meta_variable.ml
@@ -273,7 +273,6 @@ let types ~rn = function
         | Ast.StructUnionName(_, Some n) -> get_meta_id acc n
         | Ast.SignedT (_, Some t) -> get_meta_type acc t
         | Ast.Pointer (t, _)
-        | Ast.FunctionPointer (t, _, _, _, _, _, _)
         | Ast.Array (t, _, _, _) -> get_meta_type_full acc t
 	| Ast.TypeOfExpr(_,_,exp,_) -> acc (* not sure *)
 	| Ast.TypeOfType(_,_,ty,_) -> get_meta_type_full acc ty
diff --git a/tools/spgen/source/position_generator.ml b/tools/spgen/source/position_generator.ml
index 2fa630fb..602e768e 100644
--- a/tools/spgen/source/position_generator.ml
+++ b/tools/spgen/source/position_generator.ml
@@ -192,9 +192,6 @@ let rec type_pos t snp
   | Ast0.Pointer(t,star) ->
       let constructor ~mc = Ast0.Pointer(t,mc) in
       mcode_wrap ~mc:star ~constructor snp
-  | Ast0.FunctionPointer(t,lp,star,rp,lp2,params,rp2) ->
-      let constructor ~mc = Ast0.FunctionPointer(t,lp,star,rp,lp2,params,mc) in
-      mcode_wrap ~mc:rp2 ~constructor snp
   | Ast0.ParenType(lp,t,rp) ->
       let constructor ~mc = Ast0.ParenType(lp,t,rp) in
       mcode_wrap ~mc:rp ~constructor snp
-- 
2.21.1

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
