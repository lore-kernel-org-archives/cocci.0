From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 2 Oct 2014 19:00:05 +0200 (CEST)
Subject: [Cocci] string parameter concatenation
In-Reply-To: <20141001130215.GB4701@rei.suse.cz>
References: <20141001130215.GB4701@rei.suse.cz>
Message-ID: <alpine.DEB.2.02.1410021858360.2062@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 1 Oct 2014, Cyril Hrubis wrote:

> Hi!
> I've found a small nit in the handling of strings that spans over
> multiple lines:
> 
> nit.c:
> int main(void)
> {
>         f("This is a string that continues to the next line"
>           " just string continuation");
> }

The patch below solves this problem as well as the one with the long 
string in the argument list.

julia

diff --git a/parsing_c/pretty_print_c.ml b/parsing_c/pretty_print_c.ml
index e7ffaa5..57d46cb 100644
--- a/parsing_c/pretty_print_c.ml
+++ b/parsing_c/pretty_print_c.ml
@@ -101,7 +101,8 @@ let mk_pretty_printers
     (match exp, ii with
     | Ident (ident),         []     -> pp_name ident
     (* only a MultiString can have multiple ii *)
-    | Constant (MultiString _), is     -> is +> List.iter pr_elem
+    | Constant (MultiString _), is     ->
+	is +> Common.print_between pr_space pr_elem
     | Constant (c),         [i]     -> pr_elem i
     | StringConstant(s,os,w),  [i1;i2] ->
 	pr_elem i1;
diff --git a/parsing_c/unparse_c.ml b/parsing_c/unparse_c.ml
index 33a4b46..ed86971 100644
--- a/parsing_c/unparse_c.ml
+++ b/parsing_c/unparse_c.ml
@@ -60,7 +60,7 @@ type token2 =
   | Fake2 of Ast_c.info * min
   | Cocci2 of string * int (* line *) * int (* lcol *) * int (* rcol *)
             * Unparse_cocci.nlhint option
-  | C2 of string
+  | C2 of string * Unparse_cocci.nlhint option
   | Comma of string
   | Indent_cocci2
   | Unindent_cocci2 of bool (* true for permanent, false for temporary *)
@@ -99,7 +99,7 @@ let print_token1 = function
 let str_of_token2 = function
   | T2 (t,_,_,_) -> TH.str_of_tok t
   | Cocci2 (s,_,_,_,_)
-  | C2 s
+  | C2 (s,_)
   | Comma s -> s
   | Fake2 _
   | Indent_cocci2
@@ -141,7 +141,7 @@ let print_token2 = function
       | Ctx -> "" in
     b_str^"fake"
   | Cocci2 (s,_,lc,rc,_) -> Printf.sprintf "Cocci2:%d:%d%s" lc rc s
-  | C2 s -> "C2:"^s
+  | C2 (s,_) -> "C2:"^s
   | Comma s -> "Comma:"^s
   | Indent_cocci2 -> "Indent"
   | Unindent_cocci2 true -> "Unindent"
@@ -328,9 +328,9 @@ let comment2t2 = function
   (* not sure iif the following list is exhaustive or complete *)
     (Token_c.CppAttr|Token_c.CppMacro|Token_c.CppPassingCosWouldGetError),
     (info : Token_c.info)) ->
-    C2(info.Common.str)
+    C2(info.Common.str,None)
   | (Token_c.TCommentCpp x,(info : Token_c.info)) ->
-    C2("\n"^info.Common.str^"\n")
+    C2("\n"^info.Common.str^"\n",None)
   | x -> failwith (Printf.sprintf "unexpected comment %s" (Dumper.dump x))
 
 let expand_mcode toks =
@@ -392,9 +392,9 @@ let expand_mcode toks =
     let pr_c info =
       (match Ast_c.pinfo_of_info info with
       | Ast_c.AbstractLineTok _ ->
-        push2 (C2 (Ast_c.str_of_info info)) toks_out
+        push2 (C2 (Ast_c.str_of_info info,None)) toks_out
       |	Ast_c.FakeTok (s,_) ->
-        push2 (C2 s) toks_out
+        push2 (C2 (s,None)) toks_out
       |	_ ->
         Printf.fprintf stderr "line: %s\n" (Dumper.dump info);
         failwith "not an abstract line"
@@ -407,7 +407,7 @@ let expand_mcode toks =
       push2 (Cocci2 ("",ln,col,col,None)) toks_out in
     let pr_nobarrier ln col = () in (* not needed for linux spacing *)
 
-    let pr_cspace _ = push2 (C2 " ") toks_out in
+    let pr_cspace _ = push2 (C2 (" ",None)) toks_out in
 
     let pr_space _ = () (* rely on add_space in cocci code *) in
     let pr_arity _ = () (* not interested *) in
@@ -485,11 +485,11 @@ let is_safe_comment_or_space = function
   | _ -> false
 
 let is_added_space = function
-  | C2(" ") -> true (* only whitespace *)
+  | C2(" ",_) -> true (* only whitespace *)
   | _ -> false
 
 let is_added_whitespace =
-  function C2 " " | C2 "\n" | Cocci2("\n",_,_,_,_) -> true | _ -> false
+  function C2 (" ",_) | C2 ("\n",_) | Cocci2("\n",_,_,_,_) -> true | _ -> false
 
 let is_newline = function
   | T2(Parser_c.TCommentNewline _,_b,_i,_h) -> true
@@ -1102,13 +1102,13 @@ let paren_then_brace toks =
 	let (nls, rest) = span is_newline_space_or_minus rest in
 	let after =
 	  match List.rev spaces with
-	    [] -> [(C2 " ")]
-	  | T2(Parser_c.TComment _,Ctx,_i,_h)::_ -> [(C2 " ")]
+	    [] -> [(C2 (" ",None))]
+	  | T2(Parser_c.TComment _,Ctx,_i,_h)::_ -> [(C2 (" ",None))]
 	  | _ ->
 	      if List.exists (function T2(_,Ctx,_,_) -> true | _ -> false)
 		  spaces
 	      then [] (* use existing trailing spaces *)
-	      else [(C2 " ")] in
+	      else [(C2 (" ",None))] in
 	match rest with
 	  (* move the brace up to the previous line *)
 	| ((Cocci2("{",_,_,_,_)) as x) :: ((Cocci2 ("\n",_,_,_,_)) as a) ::
@@ -1124,7 +1124,7 @@ let is_ident_like s = s ==~ regexp_alpha
 let rec drop_space_at_endline = function
   | [] -> []
   | [x] -> [x]
-  | (C2 " ") ::
+  | (C2 (" ",_)) ::
     ((((T2(Parser_c.TCommentSpace _,Ctx,_,_)) | Cocci2("\n",_,_,_,_) |
     (T2(Parser_c.TCommentNewline _,Ctx,_,_))) :: _) as rest) ->
     (* when unparse_cocci doesn't know whether space is needed *)
@@ -1158,7 +1158,7 @@ let rec paren_to_space = function
     ((T2(t,Min _,_,_)) as b)::
     ((T2(_,Ctx,_,_)) as c)::rest
     when not (is_whitespace a) && TH.str_of_tok t = "(" ->
-    a :: b :: (C2 " ") :: (paren_to_space (c :: rest))
+    a :: b :: (C2 (" ",None)) :: (paren_to_space (c :: rest))
   | a :: rest -> a :: (paren_to_space rest)
 
 let rec add_space xs =
@@ -1171,21 +1171,21 @@ let rec add_space xs =
     (* this only works within a line.  could consider whether
     something should be done to add newlines too, rather than
     printing them explicitly in unparse_cocci. *)
-    x::C2 (String.make (lcoly-rcolx) ' ')::add_space (y::xs)
+    x::C2 (String.make (lcoly-rcolx) ' ', None)::add_space (y::xs)
   | (Cocci2(sx,lnx,_,rcolx,_) as x)::((Cocci2(sy,lny,lcoly,_,_)) as y)::xs
     when !Flag_parsing_c.spacing = Flag_parsing_c.SMPL &&
     not (lnx = -1) && not (rcolx = -1) && lnx < lny ->
     (* this only works within a line.  could consider whether
     something should be done to add newlines too, rather than
     printing them explicitly in unparse_cocci. *)
-    x::C2 (String.make (lny-lnx) '\n')::
-    C2 (String.make (lcoly-1) ' '):: (* -1 is for the + *)
+    x::C2 (String.make (lny-lnx) '\n', None)::
+    C2 (String.make (lcoly-1) ' ', None):: (* -1 is for the + *)
     add_space (y::xs)
   | ((T2(_,Ctx,_,_)) as x)::((Cocci2 _) as y)::xs -> (* add space on boundary *)
     let sx = str_of_token2 x in
     let sy = str_of_token2 y in
     if is_ident_like sx && (is_ident_like sy or List.mem sy ["="])
-    then x::C2 " "::(add_space (y::xs))
+    then x::C2(" ",None)::(add_space (y::xs))
     else x::(add_space (y::xs))
   | ((T2(_,Ctx,_,_)) as x)::((T2(_,Ctx,_,_)) as y)::xs -> (* don't touch *)
       x :: (add_space (y :: xs))
@@ -1193,7 +1193,7 @@ let rec add_space xs =
     let sx = str_of_token2 x in
     let sy = str_of_token2 y in
     if is_ident_like sx && is_ident_like sy
-    then x::C2 " "::(add_space (y::xs))
+    then x::C2(" ",None)::(add_space (y::xs))
     else x::(add_space (y::xs))
 
 (* A fake comma is added at the end of an unordered initlist or a enum
@@ -1232,7 +1232,7 @@ let simple_string_length s count = fst(string_length s count (None,false))
 let scan_past_define l =
   let is_newline = function
       T2(Parser_c.TCommentNewline _,_b,_i,_h) -> true
-    | C2 "\n" -> true
+    | C2 ("\n",_) -> true
     | _ -> false in
   let rec loop = function
       [] -> ([],[])
@@ -1386,6 +1386,37 @@ let add_newlines toks tabbing_unit =
             | None -> loop (stack,Some (count,sp),true) count false xs)
         | _ -> loop (stack,space_cell,true) count false xs in
       a :: rest
+    | (C2(",",_)) :: (C2(" ",_)) :: xs ->
+	(* if there was a single space, contemplate turning it into a
+	   newline. Used for value of an expression list. *)
+	let sp = ref " " in
+	let a = C2(",",Some(Unparse_cocci.SpaceOrNewline sp)) in
+	let rest =
+          let count = simple_string_length "," (count + 1 (*space*)) in
+          match stack with
+          | [x] ->
+              (match check_for_newline count x space_cell with
+              | Some count -> loop (stack,Some (x,sp), true) count false xs
+              | None -> loop (stack,Some (count,sp),true) count false xs)
+          | _ -> loop (stack,space_cell,true) count false xs in
+	a :: rest
+    | (C2(s1,_)) :: (C2(" ",_)) :: (((C2(s2,_)) :: _) as xs)
+      when (not (s1 = "")) && (not (s2 = "")) &&
+	(* not perfect, because only finds the string string case *)
+	(String.get s1 0 = '\"') && (String.get s2 0 = '\"') ->
+	(* if there was a single space, contemplate turning it into a
+	   newline. Used for value of an expression list. *)
+	let sp = ref " " in
+	let a = C2(s1,Some(Unparse_cocci.SpaceOrNewline sp)) in
+	let rest =
+          let count = simple_string_length s1 (count + 1 (*space*)) in
+          match stack with
+          | [x] ->
+              (match check_for_newline count x space_cell with
+              | Some count -> loop (stack,Some (x,sp), true) count false xs
+              | None -> loop (stack,Some (count,sp),true) count false xs)
+          | _ -> loop (stack,space_cell,true) count false xs in
+	a :: rest
     | (Cocci2(s,line,lcol,rcol,_))::((T2 _) as a)::xs
       when is_newline_or_comment a ->
       (* if the added code is followed by any existing comment or newline,
@@ -1413,7 +1444,7 @@ let add_newlines toks tabbing_unit =
 	let (count,(space_cell,seen_cocci)) =
 	  string_length s count (space_cell,seen_cocci) in
       a :: loop (stack,space_cell,seen_cocci) count false xs
-    | ((C2(s)) as a)::xs ->
+    | ((C2(s,_)) as a)::xs ->
 	let (count,(space_cell,seen_cocci)) =
 	  string_length s count (space_cell,seen_cocci) in
 	a :: loop (stack,space_cell,seen_cocci) count false xs
@@ -1424,9 +1455,11 @@ let add_newlines toks tabbing_unit =
       failwith "unexpected fake, indent, unindent, or eatspace" in
   let redo_spaces prev = function
     | Cocci2(s,line,lcol,rcol,Some (Unparse_cocci.SpaceOrNewline sp)) ->
-      C2 !sp :: Cocci2(s,line,lcol,rcol,None) :: prev
+      C2 (!sp,None) :: Cocci2(s,line,lcol,rcol,None) :: prev
     | T2(tok,min,idx,Some (Unparse_cocci.SpaceOrNewline sp)) ->
-      C2 !sp :: T2(tok,min,idx,None) :: prev
+      C2 (!sp,None) :: T2(tok,min,idx,None) :: prev
+    | C2(s,Some (Unparse_cocci.SpaceOrNewline sp)) ->
+      C2 (!sp,None) :: C2(s,None) :: prev
     | t -> t::prev in
   (match !Flag_parsing_c.spacing with
   | Flag_parsing_c.SMPL -> toks
@@ -1497,7 +1530,7 @@ let parse_token tok =
 	[before;after] -> (NL after, minplus a)
       |	_ -> (Tok (str_of_token2 tok), minplus a))
   | T2(_,a,_,_) -> (Tok (str_of_token2 tok), minplus a)
-  | C2 s -> (Tok s, PlusOnly)
+  | C2 (s,_) -> (Tok s, PlusOnly)
   | Cocci2("\n",_,_,_,_) -> (NL "", PlusOnly)
   | Cocci2(s,_,_,_,_) -> (Tok s, PlusOnly)
   | Indent_cocci2 | Unindent_cocci2 _ -> (Ind tok, PlusOnly)
@@ -1587,7 +1620,8 @@ let is_nl op xs =
   match skip_unlike_me op xs is_whitespace with
     [] -> false
   | T2(Parser_c.TCommentNewline _,_b,_i,_h)::_ -> true
-  | C2 "\n"::_ | Cocci2("\n",_,_,_,_)::_ -> true (*not sure if cocci2 is needed*)
+  | C2 ("\n",_)::_ | Cocci2("\n",_,_,_,_)::_ ->
+      true (*not sure if cocci2 is needed*)
   | Indent_cocci2 :: _ -> true
   | Unindent_cocci2 _ :: _ -> true
   | _ -> false
@@ -1754,7 +1788,7 @@ let update_indent tok indent =
   match tok with
     Cocci2("\n",ln,lcol,rcol,nlhint) ->
       Cocci2(("\n"^indent),ln,lcol,rcol,nlhint)
-  | C2("\n") -> C2("\n"^indent)
+  | C2("\n",_) -> C2("\n"^indent,None)
   | _ -> failwith "bad newline"
 
 let update_entry map depth inparens n indent =
@@ -1888,7 +1922,7 @@ let rec newlines_for_unindents xs =
   let is_ctxnl =
     function T2(Parser_c.TCommentNewline _,_b,_i,_h) -> true | _ -> false in
   let is_plusnl =
-    function C2 "\n" | Cocci2("\n",_,_,_,_) -> true | _ -> false in
+    function C2("\n",_) | Cocci2("\n",_,_,_,_) -> true | _ -> false in
   let is_nl x = is_ctxnl x or is_plusnl x in
   let rec loop = function
       [] -> []
@@ -1898,18 +1932,18 @@ let rec newlines_for_unindents xs =
       when is_ctxnl ctxnl && is_plusnl plusnl ->
 	plusnl::(Unindent_cocci2 false)::x::loop (ctxnl::rest)
     | ctxnl::(Unindent_cocci2 false)::x::rest when is_ctxnl ctxnl ->
-	(C2 "\n")::(Unindent_cocci2 false)::x::loop (ctxnl::rest)
+	(C2("\n",None))::(Unindent_cocci2 false)::x::loop (ctxnl::rest)
     | plusnl1::(Unindent_cocci2 false)::x::nl2::rest
       when is_plusnl plusnl1 && is_nl nl2 ->
 	plusnl1::(Unindent_cocci2 false)::x::loop (nl2::rest)
     | plusnl::(Unindent_cocci2 false)::x::[] when is_plusnl plusnl ->
 	plusnl::(Unindent_cocci2 false)::x::[]
     | plusnl::(Unindent_cocci2 false)::x::rest when is_plusnl plusnl ->
-	plusnl::(Unindent_cocci2 false)::x::loop (C2 "\n"::rest)
+	plusnl::(Unindent_cocci2 false)::x::loop (C2("\n",None)::rest)
     | y::(Unindent_cocci2 false)::x::nl::rest when is_nl nl ->
-	y::C2 "\n"::(Unindent_cocci2 false)::x::loop (nl::rest)
+	y::C2("\n",None)::(Unindent_cocci2 false)::x::loop (nl::rest)
     | y::(Unindent_cocci2 false)::x::rest ->
-	y::C2 "\n"::(Unindent_cocci2 false)::x::C2 "\n"::rest
+	y::C2("\n",None)::(Unindent_cocci2 false)::x::C2("\n",None)::rest
     | x::rest -> x::loop rest in
   loop xs
 
@@ -1937,7 +1971,7 @@ let adjust_indentation xs =
 	    if not (depthmin = depthplus) (*&& is_cocci rest*)
 	    then
 	      context_search_in_maps n depthplus inparens past_minmap minmap
-		tabbing_unit (C2 "\n")
+		tabbing_unit (C2("\n",None))
 	    else t in
 	  (out_tu,minmap,t::res)
       | (n,MinNL(spaces,depthmin,depthplus,inparens),t)::rest ->
@@ -1996,7 +2030,7 @@ let fix_tokens toks =
 
   let cleaner = toks +> exclude (function
     | {tok2 = T2 (t,_,_,_)} -> TH.is_real_comment t (* I want the ifdef *)
-    | {tok2 = C2 " "} -> true (* added by redo_spaces *)
+    | {tok2 = C2(" ",_)} -> true (* added by redo_spaces *)
     | _ -> false
   ) in
   find_paren_comma cleaner;
