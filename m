Return-Path: <SRS0=pcGb=CS=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E81C2D0E0
	for <cocci@archiver.kernel.org>; Wed,  9 Sep 2020 18:13:49 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B511B21D7E
	for <cocci@archiver.kernel.org>; Wed,  9 Sep 2020 18:13:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B511B21D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 089IDLd4019333;
	Wed, 9 Sep 2020 20:13:24 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id EB6FD778C;
	Wed,  9 Sep 2020 20:13:23 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E17FC782A
 for <cocci@systeme.lip6.fr>; Wed,  9 Sep 2020 20:13:21 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 089IDLHM028596
 for <cocci@systeme.lip6.fr>; Wed, 9 Sep 2020 20:13:21 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: jaskaran_singh) with ESMTPSA id 1EC6329B138
From: Jaskaran Singh <jaskaran.singh@collabora.com>
To: cocci@systeme.lip6.fr
Date: Wed,  9 Sep 2020 23:43:02 +0530
Message-Id: <20200909181302.1187-4-jaskaran.singh@collabora.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200909181302.1187-1-jaskaran.singh@collabora.com>
References: <20200909181302.1187-1-jaskaran.singh@collabora.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 09 Sep 2020 20:13:24 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 09 Sep 2020 20:13:21 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: [Cocci] [RFC PATCH 3/3] parsing_c: type_annoter_c: Use name cache
	for type annotation
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

Use the name cache for type annotation. On encountering the following
which are not stored in the environment, the name cache is looked up and
the relevant header file is parsed for type information:
	- struct field use
	- typedef
	- function call
	- identifier
	- enumeration constant

Signed-off-by: Jaskaran Singh <jaskaran.singh@collabora.com>
---
 parsing_c/type_annoter_c.ml | 130 ++++++++++++++++++++++++++++++------
 1 file changed, 111 insertions(+), 19 deletions(-)

diff --git a/parsing_c/type_annoter_c.ml b/parsing_c/type_annoter_c.ml
index 25cb6c0ee..497332544 100644
--- a/parsing_c/type_annoter_c.ml
+++ b/parsing_c/type_annoter_c.ml
@@ -19,6 +19,7 @@ open Common
 open Ast_c
 
 module Lib = Lib_parsing_c
+module IC = Includes_cache
 
 (*****************************************************************************)
 (* Prelude *)
@@ -186,6 +187,13 @@ type nameenv = {
 
 type environment = nameenv list
 
+let includes_parse_fn file =
+  let choose_includes = Includes.get_parsing_style () in
+  Includes.set_parsing_style Includes.Parse_no_includes;
+  let ret = Parse_c.parse_c_and_cpp false false file in
+  Includes.set_parsing_style choose_includes;
+  List.map fst (fst ret)
+
 (* ------------------------------------------------------------ *)
 (* can be modified by the init_env function below, by
  * the file environment_unix.h
@@ -294,6 +302,39 @@ let member_env_lookup_enum s env =
   | [] -> false
   | env :: _ -> StringMap.mem s env.enum_constant
 
+(* ------------------------------------------------------------ *)
+
+let add_cache_binding_in_scope namedef =
+  let (current, older) = Common.uncons !_scoped_env in
+  let new_frame fr =
+    match namedef with
+      | IC.RetVarOrFunc (s, typ) ->
+	  {fr with
+	   var_or_func = StringMap.add s typ fr.var_or_func}
+      | IC.RetTypeDef   (s, typ) ->
+	  let cv = typ, fr.typedef, fr.level in
+	  let new_typedef_c : typedefs = { defs = StringMap.add s cv fr.typedef.defs } in
+	  {fr with typedef = new_typedef_c}
+      | IC.RetStructUnionNameDef (s, (su, typ)) ->
+	  {fr with
+	   struct_union_name_def = StringMap.add s (su, typ) fr.struct_union_name_def}
+      | IC.RetEnumConstant (s, body) ->
+	  {fr with
+	   enum_constant = StringMap.add s body fr.enum_constant} in
+  (* These are global, so have to reflect them in all the frames. *)
+  _scoped_env := (new_frame current)::(List.map new_frame older)
+
+(* Has side-effects on the environment.
+ * TODO: profile? *)
+let get_type_from_includes_cache file name exp_types on_success on_failure =
+  let file_bindings =
+    IC.get_types_from_name_cache
+      file name exp_types includes_parse_fn in
+  List.iter add_cache_binding_in_scope file_bindings;
+  match file_bindings with
+    [] -> on_failure ()
+  | _ -> on_success ()
+
 
 (*****************************************************************************)
 (* "type-lookup"  *)
@@ -394,7 +435,14 @@ let rec type_unfold_one_step ty env =
 	  then type_unfold_one_step t' env'
           else loop (s::seen) t' env
        with Not_found ->
-          ty
+          let f = Ast_c.file_of_info (Ast_c.info_of_name name) in
+          get_type_from_includes_cache
+            f s [IC.CacheTypedef]
+            (fun () ->
+              let (t', env') = lookup_typedef s !_scoped_env in
+              TypeName (name, Some t') +>
+              Ast_c.rewrap_typeC ty)
+            (fun () -> ty)
       )
 
   | FieldType (t, _, _) -> type_unfold_one_step t env
@@ -474,7 +522,15 @@ let rec typedef_fix ty env =
 	      TypeName (name, Some fixed) +>
 	      Ast_c.rewrap_typeC ty
             with Not_found ->
-              ty))
+              let f = Ast_c.file_of_info (Ast_c.info_of_name name) in
+              get_type_from_includes_cache
+                f s [IC.CacheTypedef]
+                (fun () ->
+                  let (t', env') = lookup_typedef s !_scoped_env in
+                  TypeName (name, Some t') +>
+                  Ast_c.rewrap_typeC ty)
+                (fun () -> ty)
+              ))
 
     | FieldType (t, a, b) ->
 	FieldType (typedef_fix t env, a, b) +> Ast_c.rewrap_typeC ty
@@ -797,8 +853,15 @@ let annotater_expr_visitor_subpart = (fun (k,bigf) expr ->
                     Type_c.noTypeHere
                 )
             | None ->
-                pr2_once ("type_annotater: no type for function ident: " ^ s);
-                Type_c.noTypeHere
+                let f =
+                  Ast_c.file_of_info
+                    (Ast_c.info_of_name ident) in
+                get_type_from_includes_cache
+                  f s [IC.CacheVarFunc]
+                  (fun () -> match lookup_opt_env lookup_var s with
+                    Some (typ, local) -> make_info_fix (typ, local)
+                  | None -> Type_c.noTypeHere)
+                  (fun () -> Type_c.noTypeHere)
             )
         )
 
@@ -848,22 +911,33 @@ let annotater_expr_visitor_subpart = (fun (k,bigf) expr ->
                 | Some _ ->
                     make_info_def (type_of_s "int")
                 | None ->
-                    if not (s =~ "[A-Z_]+") (* if macro then no warning *)
-                    then
-                      if !Flag_parsing_c.check_annotater then
-                        if not (Hashtbl.mem _notyped_var s)
-                        then begin
-                          pr2 ("Type_annoter: no type found for: " ^ s);
-                          Hashtbl.add _notyped_var s true;
-                        end
-                        else ()
-                      else
-                        pr2 ("Type_annoter: no type found for: " ^ s)
-                    ;
-                    Type_c.noTypeHere
-                )
+                    let f = Ast_c.file_of_info (Ast_c.info_of_name ident) in
+                    let failure_fn =
+                      (fun () ->
+                         if not (s =~ "[A-Z_]+") (* if macro then no warning *)
+                         then
+                           if !Flag_parsing_c.check_annotater then
+                             if not (Hashtbl.mem _notyped_var s)
+                             then begin
+                               pr2
+                                 ("Type_annoter: no type found for: " ^ s);
+                               Hashtbl.add _notyped_var s true;
+                             end
+                             else ()
+                           else pr2 ("Type_annoter: no type found for: " ^ s);
+                         Type_c.noTypeHere) in
+                    get_type_from_includes_cache
+                      f s [IC.CacheEnumConst;IC.CacheVarFunc]
+                      (fun () -> match lookup_opt_env lookup_enum s with
+                        Some _ -> make_info_def (type_of_s "int")
+                      | None ->
+                          (match lookup_opt_env lookup_var s with
+                            Some (typ,local) -> make_info_fix (typ,local)
+                          | None -> failure_fn ()))
+                      failure_fn
             )
         )
+    )
 
     (* -------------------------------------------------- *)
     (* C isomorphism on type on array and pointers *)
@@ -954,7 +1028,25 @@ let annotater_expr_visitor_subpart = (fun (k,bigf) expr ->
                         Type_c.noTypeHere
                   )
               | _ ->
-		  Type_c.noTypeHere
+                let s = Ast_c.str_of_name namefld in
+                let f = Ast_c.file_of_info (Ast_c.info_of_name namefld) in
+                let ret_typ =
+                  (match (Ast_c.unwrap (snd t)) with
+                    Ast_c.StructUnionName(su, sname) ->
+                      get_type_from_includes_cache
+                        f s [IC.CacheField sname]
+                      (fun () ->
+                        try
+                          let ((su,fields),ii) =
+                            lookup_structunion (su, sname) !_scoped_env in
+                            (try
+                               make_info_def_fix
+                                 (Type_c.type_field fld (su, fields))
+                             with _ -> Type_c.noTypeHere)
+                        with Not_found -> Type_c.noTypeHere)
+                      (fun () -> Type_c.noTypeHere)
+                  | _ -> Type_c.noTypeHere)
+                in ret_typ
           )
         )
 
-- 
2.21.3

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
