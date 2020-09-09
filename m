Return-Path: <SRS0=pcGb=CS=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7ADC43461
	for <cocci@archiver.kernel.org>; Wed,  9 Sep 2020 18:13:54 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 797522065E
	for <cocci@archiver.kernel.org>; Wed,  9 Sep 2020 18:13:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 797522065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 089IDLd0019333;
	Wed, 9 Sep 2020 20:13:21 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1747C778C;
	Wed,  9 Sep 2020 20:13:21 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4D6FB4316
 for <cocci@systeme.lip6.fr>; Wed,  9 Sep 2020 20:13:19 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 089IDIZC026248
 for <cocci@systeme.lip6.fr>; Wed, 9 Sep 2020 20:13:18 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: jaskaran_singh) with ESMTPSA id AED6D29B138
From: Jaskaran Singh <jaskaran.singh@collabora.com>
To: cocci@systeme.lip6.fr
Date: Wed,  9 Sep 2020 23:43:00 +0530
Message-Id: <20200909181302.1187-2-jaskaran.singh@collabora.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200909181302.1187-1-jaskaran.singh@collabora.com>
References: <20200909181302.1187-1-jaskaran.singh@collabora.com>
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 09 Sep 2020 20:13:21 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 09 Sep 2020 20:13:18 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: [Cocci] [RFC PATCH 1/3] parsing_c: includes_cache: Implement a name
	cache
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

Implement a name cache and includes dependency graph to optimize
performance for recursive parsing of header files.

The following is a high-level description of what has been implemented:
- As header files are recursively parsed, they are scanned for the
  following:
	- fields of structs/unions/enums
	- typedefs
	- function prototypes
	- global variables
  The names of the above are stored in a "name cache", i.e. a hashtable
  to map the name to the files it is declared in.
- A dependency graph is built to determine dependencies between all the
  files in the codebase.
- In the type annotation phase of the C subsystem, if a function call,
  struct/union field or identifier is encountered, the type of which is
  not known to the annoter, the name cache is checked for the name.
- The name cache gives a list of files that the name is declared/defined
  in.  These files are cross checked with the dependency graph to
  determine if any of these are reachable by the file that the annoter is
  working on.
- If a reachable header file is found, that file is parsed and all of
  the above listed constructs are extracted from it.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Jaskaran Singh <jaskaran.singh@collabora.com>
---
 Makefile                     |   2 +-
 parsing_c/includes_cache.ml  | 286 +++++++++++++++++++++++++++++++++++
 parsing_c/includes_cache.mli |  47 ++++++
 3 files changed, 334 insertions(+), 1 deletion(-)
 create mode 100644 parsing_c/includes_cache.ml
 create mode 100644 parsing_c/includes_cache.mli

diff --git a/Makefile b/Makefile
index e25174413..f8d3424c0 100644
--- a/Makefile
+++ b/Makefile
@@ -50,7 +50,7 @@ SOURCES_parsing_cocci := \
 SOURCES_parsing_c := \
 	token_annot.ml flag_parsing_c.ml parsing_stat.ml \
 	token_c.ml ast_c.ml includes.ml control_flow_c.ml \
-	visitor_c.ml lib_parsing_c.ml control_flow_c_build.ml \
+	visitor_c.ml lib_parsing_c.ml includes_cache.ml control_flow_c_build.ml \
 	pretty_print_c.ml semantic_c.ml lexer_parser.ml parser_c.mly \
 	lexer_c.mll parse_string_c.ml token_helpers.ml token_views_c.ml \
 	cpp_token_c.ml parsing_hacks.ml cpp_analysis_c.ml \
diff --git a/parsing_c/includes_cache.ml b/parsing_c/includes_cache.ml
new file mode 100644
index 000000000..2c2cb0235
--- /dev/null
+++ b/parsing_c/includes_cache.ml
@@ -0,0 +1,286 @@
+(*
+ * This file is part of Coccinelle, licensed under the terms of the GPL v2.
+ * See copyright.txt in the Coccinelle source code for more information.
+ * The Coccinelle source code can be obtained at http://coccinelle.lip6.fr
+ *)
+
+open Common
+module Lib = Lib_parsing_c
+
+(*****************************************************************************)
+(* Wrappers *)
+(*****************************************************************************)
+let pr_inc s =
+  if !Flag_parsing_c.verbose_includes
+  then Common.pr2 s
+
+(*****************************************************************************)
+(* Graph types/modules *)
+(*****************************************************************************)
+
+(* Filenames as keys to check paths from file A to file B. *)
+module Key : Set.OrderedType with type t = Common.filename = struct
+  type t = Common.filename
+  let compare = String.compare
+end
+
+module KeySet = Set.Make (Key)
+
+module KeyMap = Map.Make (Key)
+
+module Node : Set.OrderedType with type t = unit = struct
+  type t = unit
+  let compare = compare
+end
+
+module Edge : Set.OrderedType with type t = unit = struct
+  type t = unit
+  let compare = compare
+end
+
+module KeyEdgePair : Set.OrderedType with type t = Key.t * Edge.t =
+struct
+  type t = Key.t * Edge.t
+  let compare = compare
+end
+
+module KeyEdgeSet = Set.Make (KeyEdgePair)
+
+module G = Ograph_simple.Make
+  (Key) (KeySet) (KeyMap) (Node) (Edge) (KeyEdgePair) (KeyEdgeSet)
+
+
+(*****************************************************************************)
+(* Includes dependency graph *)
+(*****************************************************************************)
+
+(* Header file includes dependency graph *)
+let dependency_graph = ref (new G.ograph_mutable)
+
+(* Check if a path exists between one node to another.
+ * Almost a copy of dfs_iter in commons/ograph_extended.ml with minor changes.
+ * Return true if g satisfies predicate f else false
+ *)
+let dfs_exists xi f g =
+  let already = Hashtbl.create 101 in
+  let rec aux_dfs xs =
+    let h xi =
+      if Hashtbl.mem already xi
+      then false
+      else begin
+        Hashtbl.add already xi true;
+        if f xi
+        then true
+        else begin
+          let f' (key, _) keyset = KeySet.add key keyset in
+          let newset =
+            try KeyEdgeSet.fold f' (g#successors xi) KeySet.empty
+            with Not_found -> KeySet.empty in
+          aux_dfs newset
+        end
+      end in
+    KeySet.exists h xs in
+  aux_dfs (KeySet.singleton xi)
+
+let add_to_dependency_graph parent file =
+  let add_node a =
+    if not (KeyMap.mem a !dependency_graph#nodes)
+    then !dependency_graph#add_node a () in
+  let add_arc (a, b) =
+    add_node a;
+    add_node b;
+    !dependency_graph#add_arc (a, b) () in
+  add_arc (parent, file)
+
+let path_exists_dependency_graph filea fileb =
+  dfs_exists filea (fun a -> a = fileb) !dependency_graph
+
+let print_dependency_graph _ =
+  G.print_ograph_generic
+    ~str_of_key:(fun k -> "\"" ^ k ^ "\"")
+    ~str_of_node:(fun k _ -> k)
+    "/tmp/headers.dot"
+    !dependency_graph
+
+
+(*****************************************************************************)
+(* Name cache *)
+(*****************************************************************************)
+
+type cache_exp =
+  | CacheField of string (* Name of the struct/union it is defined in *)
+  | CacheEnumConst
+  | CacheVarFunc
+  | CacheTypedef
+
+(* Not very elegant. Basically a copy-paste of namedef in type_annoter_c. *)
+type cache_return =
+  | RetVarOrFunc of string * Ast_c.exp_type
+  | RetEnumConstant of string * string option
+  | RetTypeDef   of string * Ast_c.fullType
+  | RetStructUnionNameDef of string * (Ast_c.structUnion * Ast_c.structType)
+                          Ast_c.wrap
+
+(* Map name to list of files it is defined in *)
+let name_cache : (string, (filename * cache_exp) list) Hashtbl.t ref =
+  ref (Hashtbl.create 101)
+
+let add_to_name_cache name (file, exp) =
+  let l =
+    try Hashtbl.find !name_cache name
+    with Not_found -> [] in
+  Hashtbl.replace !name_cache name ([(file, exp)] @ l)
+
+(* Visitor to cache names in a given file. *)
+let cache_name_visitor file =
+
+  let cache_struct_fields sname def =
+    let _cache_field field =
+      match (Ast_c.unwrap field) with
+        Ast_c.Simple (name, _)
+      | Ast_c.BitField (name, _, _, _) ->
+          name +>
+            do_option
+              (fun n ->
+                 add_to_name_cache (Ast_c.str_of_name n)
+                 (file, CacheField(sname))) in
+    let _cache_struct_fields field =
+      match field with
+        Ast_c.DeclarationField(Ast_c.FieldDeclList(l)) ->
+          List.iter _cache_field (Ast_c.unwrap l)
+      | _ -> () in
+    List.iter _cache_struct_fields def in
+
+  let cache_enum_constants def =
+    def +>
+      List.iter
+        (fun ec ->
+           add_to_name_cache
+             ((Ast_c.unwrap ec) +> fst +> Ast_c.str_of_name)
+             (file, CacheEnumConst)) in
+
+  { Visitor_c.default_visitor_c with
+    Visitor_c.ktoplevel = fun (k, bigf) p ->
+      match p with
+        Ast_c.Declaration
+          (Ast_c.DeclList (defs, _)) ->
+             let cache_name x =
+               (match (Ast_c.unwrap x) with
+                 {Ast_c.v_namei = Some (name, _);
+                  Ast_c.v_type = typ;
+                  Ast_c.v_storage = strg} ->
+                  (* Cache typedefs/variables/functions *)
+                    let exp_type =
+                      match (fst strg) with
+                        Ast_c.StoTypedef -> CacheTypedef
+                      | _ -> CacheVarFunc in
+                    add_to_name_cache
+                      (Ast_c.str_of_name name) (file, exp_type)
+               | {Ast_c.v_namei = None; Ast_c.v_type = typ} ->
+                    (match (Ast_c.unwrap (snd typ)) with
+                      Ast_c.StructUnion (_, Some n, def) ->
+                        (* Cache field names *)
+                        cache_struct_fields n def
+                    | Ast_c.Enum(_, def) ->
+                        (* Cache enumeration constants *)
+                        cache_enum_constants def
+                    | _ -> k p)) in
+             List.iter cache_name defs
+      | _ -> k p
+  }
+
+
+let get_type_visitor file l =
+  let add_to_ret ret =
+    l := [ret] @ !l in
+  let get_enum_constants sopt def =
+    def +>
+      List.iter
+        (fun ec ->
+           let s = (Ast_c.unwrap ec) +> fst +> Ast_c.str_of_name in
+           add_to_ret (RetEnumConstant(s, sopt))) in
+  { Visitor_c.default_visitor_c with
+    Visitor_c.ktoplevel = fun (k, bigf) p ->
+      match p with
+        Ast_c.Declaration
+          (Ast_c.DeclList (defs, _)) ->
+             let get_name x =
+               (match (Ast_c.unwrap x) with
+                 {Ast_c.v_namei = Some (n, _);
+                  Ast_c.v_type = typ;
+                  Ast_c.v_storage = strg} ->
+                  (* Cache typedefs/variables/functions *)
+                    let f _ =
+                      let s = Ast_c.str_of_name n in
+                      match (fst strg) with
+                        Ast_c.StoTypedef ->
+                          add_to_ret (RetTypeDef(s, typ))
+                      | Ast_c.NoSto
+                      | Ast_c.Sto _ ->
+                          add_to_ret
+                            (RetVarOrFunc(s, (typ, Ast_c.NotLocalVar))) in
+                    f ()
+               | {Ast_c.v_namei = None; Ast_c.v_type = typ} ->
+                   (match (Ast_c.unwrap (snd typ)) with
+                     Ast_c.StructUnion (su, snameopt, def) ->
+                       (match snameopt with
+                         Some s ->
+                           let def' = Lib.al_fields def in
+                           let ii = Ast_c.get_ii_typeC_take_care (snd typ) in
+                           let ii' = Lib.al_ii ii in
+                           add_to_ret
+                             (RetStructUnionNameDef (s, ((su, def'),ii')))
+                       | None -> k p)
+                   | Ast_c.Enum(sopt, def) ->
+                       get_enum_constants sopt def
+                   | _ -> k p)) in
+             List.iter get_name defs
+      | _ -> k p
+  }
+
+let extract_names file ast =
+  ignore (Visitor_c.vk_program (cache_name_visitor file) ast)
+
+(* Use the visitor to get all the types from a file. *)
+let get_types_from_name_cache file name exp_types parse_fn =
+  if !Includes.include_headers_for_types && Includes.is_header file
+  then []
+  else
+    let rec find_file l =
+      match l with
+        [] -> None
+      | (x, y)::xs ->
+          if List.mem y exp_types
+          then begin
+            if path_exists_dependency_graph file x then Some (x, y)
+            else find_file xs
+          end
+          else find_file xs in
+    let file_list =
+      try Hashtbl.find !name_cache name
+      with Not_found -> [] in
+    match (find_file file_list) with
+      None -> []
+    | Some (x, t) ->
+        let ast = parse_fn x in
+        let env = ref [] in
+        ignore
+          (Visitor_c.vk_program
+            (get_type_visitor file env) ast);
+        !env
+
+
+(*****************************************************************************)
+(* Set of parsed files *)
+(*****************************************************************************)
+
+module StringSet = Set.Make (String)
+
+(* Set of files parsed *)
+let seen_files = ref (StringSet.empty)
+
+let has_been_parsed file =
+  StringSet.mem file !seen_files
+
+let add_to_parsed_files file =
+  seen_files := StringSet.add file !seen_files
diff --git a/parsing_c/includes_cache.mli b/parsing_c/includes_cache.mli
new file mode 100644
index 000000000..2384cb2f7
--- /dev/null
+++ b/parsing_c/includes_cache.mli
@@ -0,0 +1,47 @@
+(*
+ * This file is part of Coccinelle, licensed under the terms of the GPL v2.
+ * See copyright.txt in the Coccinelle source code for more information.
+ * The Coccinelle source code can be obtained at http://coccinelle.lip6.fr
+ *)
+
+(*****************************************************************************)
+(* Includes dependency graph *)
+(*****************************************************************************)
+
+val add_to_dependency_graph : Common.filename -> Common.filename -> unit
+
+val print_dependency_graph : unit -> unit
+
+(*****************************************************************************)
+(* Name cache *)
+(*****************************************************************************)
+
+type cache_exp =
+  | CacheField of string (* Name of the struct/union it is defined in *)
+  | CacheEnumConst
+  | CacheVarFunc
+  | CacheTypedef
+
+type cache_return =
+  | RetVarOrFunc of string * Ast_c.exp_type
+  | RetEnumConstant of string * string option
+  | RetTypeDef   of string * Ast_c.fullType
+  | RetStructUnionNameDef of string * (Ast_c.structUnion * Ast_c.structType)
+                          Ast_c.wrap
+
+val extract_names : Common.filename -> Ast_c.program -> unit
+
+val get_types_from_name_cache :
+  Common.filename ->
+    string ->
+    cache_exp list ->
+    (Common.filename -> Ast_c.program) ->
+    cache_return list
+
+(*****************************************************************************)
+(* Set of parsed files *)
+(*****************************************************************************)
+
+val has_been_parsed : Common.filename -> bool
+
+val add_to_parsed_files : Common.filename -> unit
-- 
2.21.3

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
